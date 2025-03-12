Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8996A156C62
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800898; cv=none; b=nklQHDAVypbK6K7DsbIlGAAGCFTuWPZLuHAUL7ip9p5V+cwlMydNFSQ89owZjaQKYPzeZO9P9+5uyzmFfldxlSkfJ/JelHIKmBBaeFefN1lZCEAVyIK4SnVcD1jSRxHdTt+Z4eZ12i6r5kh6UjDSWNKN2KvQTAvhl4M0VCZZ9IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800898; c=relaxed/simple;
	bh=6VIz9jYxobrbARawDz34AtQLCXYfQuanST2+wiO5LAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUV/YrOFlKiUv835x3vsmaxy0obwxDL79W0zwK53DN/GL/LzpdUHPb707GZsxSXSqIlQZCXH18jDT6bshAPz3dCmF991kya3svVwOs8oiV7HlMUfu9F7LvdJF5peP8FlItgFwc+fqlFA5wIPdJZunbl/+k9gGjDdGjz2Jviw5rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aynp.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aynp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2240b4de12bso2777035ad.2
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 10:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741800896; x=1742405696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VIz9jYxobrbARawDz34AtQLCXYfQuanST2+wiO5LAk=;
        b=RQVoxRA46PvahvEwgJXK6myA3Xf2PP4sHbQO8f0MCIKYONCyvlLpbvvIxdXsaguLBp
         irkTp2HrScsSOBR/iY3hkOPk3zxLn78BxNiTPo27Nyngwf6MYt1QOfbIUE8pgYTv+Qnb
         YJOOPqCzNMqqTlEYaW5fPyqcxNaSYlReAnh/6qNNmg7wW/u74fejc5898V0xwTBXA7/O
         +xf28NhBO/88QKg2k5CwkbeIqWlR88XVuREwTPjZbrAfmIPzO97QCgkkSBsxOYBTYd76
         j8mJr6Nh+e5cGYMczIxpGrC0YCt5AnPujSfYswFzi8pf51v3oYimWgVeu88uakprlpr8
         ny+w==
X-Gm-Message-State: AOJu0YzXIziymouiM3WUk5QZQAJ/h7NAMZQNOOQIcXDbpMhWddaPLM/+
	840YM1DhGBaDMSzEYFN9XWLOcZAN983CPMVNbmlTwxdLLGWmwMvx
X-Gm-Gg: ASbGncutIAaMhJl5ZbOgsC9w0CE7RoUzF8AEJRwChgywRuZ/XnxL2X/C00LJx84jzYS
	qY4YuRx1Vl30TfgaDnFAnE9qwQI2UP2S4RxUGtE14qdL242t5ZyLPN1ywXB4t0cagWfndzjdql5
	xPwVju7ABQ7K3u6GbwNywUIwt2kptd7Ebq9oc/QSB+X5PjHKa9TR/K1yTTJ1vg5EUB58bkuWXrR
	Bls+c7pEBfIU4A16pWOPhSaR1zsMDGVReWT29UTLvRrlhPw0tgdOQLtAwklu34CvZKbzYCbmEhb
	CIg5e3/p09lpaGYoNR/71bGD8XLKRPLkFPMgHeJ9XZOB0w==
X-Google-Smtp-Source: AGHT+IGIMo+t8op7TIFQtXGdo5ERliKFBfgAwH0rB7qyzq5fzwglaUbyPMnroes/lUTG9DxCznbTHQ==
X-Received: by 2002:a17:902:eb81:b0:220:efc8:60b1 with SMTP id d9443c01a7336-22428ab865fmr350938475ad.39.1741800895701;
        Wed, 12 Mar 2025 10:34:55 -0700 (PDT)
Received: from arch ([2405:6580:9580:2e00:bfeb:1d53:4d27:1c15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ea87esm118948245ad.85.2025.03.12.10.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 10:34:55 -0700 (PDT)
Date: Thu, 13 Mar 2025 02:34:52 +0900
From: Aryan Pathania <contact@aynp.dev>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] t9400: prefer test_path_* helper functions
Message-ID: <r5572ospfh3d7nwniod36jcy5ikv5pkmiwtqj25ll7p5ts3zay@okbxrhy77iyv>
References: <20250308090358.25429-1-contact@aynp.dev>
 <Z86LrOEhH3CJOIey@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <Z86LrOEhH3CJOIey@pks.im>

Hi Patrick,
Thank you so much for taking the time out of your schedule to review my
patch.

>> use `test_path_*` instead of `test -[efd]` to avoid false complaints and
>
>Nit: We want to have full sentences in commit messages. Those sentences
>should start with an upper-case letter and end with punctuation.
I understand. Sorry for not knowing this.

>Hm. I'm not exactly sure what "false complaints" you are talking about
>here. The benefit of `test_path_*`()` over `test -[efd]` is that they
>actually print information _why_ they have failed, which may help devs
>to figure out what's happening. So it's kind of the opposite of what you
>say in the commit message: we're now printing _more_ output, not less.
I'm really sorry, I got confused in using `! test_path_*` and `test !*`.
Bad mistake while writing the message.

>This isn't quite equivalent: we've been checking that the path is not a
>directory before, but now we verify that the path doesn't exist.
I understand. I could not find `test_path_is_not_dir` or any equivalent
function in `test-lib-functions.sh`. Maybe we can keep this stronger
check. I'll mention in the commit message of next version of patch.

>We tend to use `test_path_is_file` rather than
>`test_path_is_file_not_symlink`, but I don't mind it too much.
I believe `test -f` is equivalent to `test_path_is_file_not_symlink` and
is a stronger check so maybe it's fine.

I'll make the required changes in a new patch version. Sorry for the
trouble and mistakes.

