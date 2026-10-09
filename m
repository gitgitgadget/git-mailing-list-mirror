Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835D14C10CA
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544134; cv=none; b=iedx4eTDmRjWoL1URyF2k27vTQ88/MgkQ2qhdZ5oFTUgLFOvwbMstsiNXDqRxDQm8Wto+5JpnunRnh3R5AwNOu0lqm9OXxfFTwnxzCxYd45cfHtgz6xyDa7NBTNJHJm+xWJHC2oXlpIizXnT+zU0aUjgfSqoEyPcu/k2j5ZLOOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544134; c=relaxed/simple;
	bh=zT3C53a6tGxRZrguZRka+QPAM2k10pROAARLTiVcv0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOFH35nfaF2CBaSXtV2geIij0nTb/1NEhAN4yzAjj8ZULTHMS+DFbfBkl/xjoYY8DG5/HrZkinM7D5BqUWsX+Ki72yWdaQDGRQWDUFtxIiiyvMtXjFhyCnD7mWl2315ZZ8sl52oGf1/TAHj0I9Pfi/WIhH9kxYYLT1n4UemC4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6lTAERh; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6lTAERh"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3514b90bb89so6249268eec.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 04:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791544126; x=1792148926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zT3C53a6tGxRZrguZRka+QPAM2k10pROAARLTiVcv0o=;
        b=D6lTAERhgicnV1a0Efkfu7irGtfiQ7ZDh4u5XYq9KB5jQUKqI9hxnQupxqjnvdZ2oE
         +lWZFDgxAWLp6BnCVS3hRD6KIxjUO12JARZNII2I+P1PoBVVj155pfzTMizgier5vEs8
         KHxAKnshttMcGam0HSnjOzNQDPu1WRVNrNkoLd+qTqQi/sZu43w+pgyZDsXHZ2B59xGC
         0RhdNDdxMLhcoVRUJ4qSV59M9hJxCMBzZuJwDuCMpngIApXj84VZ6pP+3RYBFJ8BknOY
         NNgJmE9m6cWttCyRzcgkoV7s4lt/n2JjcGd3u/eFfKEIIbg8/ds/wzALGQ87oS6I877I
         S5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791544126; x=1792148926;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zT3C53a6tGxRZrguZRka+QPAM2k10pROAARLTiVcv0o=;
        b=EOGcRCI7wnzYbLocWIQf9+PJ37s38ZbsCiF+o8IZUu9Rd7dUefk3Slc69eRgIx+Qtc
         lnWOiG4aDyvJhTnSFhByZ3PKCWWRpN/BHxUK1pFAo7JDdGSYQqBleYx9J9hsF4xiCZti
         i/Flo5tvDWS56tKQN7TrucQ3Iox/w/XjxSurqVFFvy0XT6YQbhvvqT5BA6S5FKrDeCP9
         y6FqRTz+oVADUwAgiaBDPkLfCB6fSSAu7r4k8wYCM92TdKr5ZOg2PDpGj6qHpMVf7RHS
         9rwn71J/wfQTn0SK1oCpyaU2T2+cSBlxR7GMV4eaqOtFe7YQcLxtEB/imgDj0ss7XB4l
         KdIA==
X-Gm-Message-State: AFq9FYKZVnLgw5KLuFB1KEBoGCFbSsV2f6kXNeBpe3va5ewquNXpvdw3
	neFrUIk2ScNauMHxSSnKnhZoNdpTJc2wVP0ds9SvviWsHVDuF5y2lfWT
X-Gm-Gg: AYBFou3X1o9jceYs7fAfycG5srkomGd51R5UilDgCPvEhXzbSNdWJXOSJBj6ExN+C1G
	gRimfDAe3mlVyRirkglkSD+7ZIx/jpwEU1or1JPKYIJyNsaqPYMZJS5/pedsZL06+2OR2hZ54NO
	pMwOkAR7B+0JLJ9zY/SvXEQpoGK7XNa7euCEP26KjqCjjRIRxxpym7ZuQN2bFopNkAGMrAFk+em
	4EXCavA4lDubyTe7tG2l2CrJOGpbWG6AG0EBX/90f7fwFbj4n1NMgy3hSgp5/XOd25o3w92Ppku
	jRs3linVRBfLZJER+jvgQsK+2eecDUBM1pXk0/N99FVMa+ykL2VcEygt0HV4GGCqlW48le1POsQ
	DdhL2BtkNPRhrtJTnLECpYHBDsXp4da/XtglnJkgN7NqEwj5+pONDYhJ0JeflvuCNW2FFW8T3/G
	pDFr9aTwwpvVEBiLZyP3IHQLbFXFnZdzi+OkNktM5nRdSy20gL88scoS6h3YQBsloyfKnF34SvU
	5vkOgMZKGpvW5CO
X-Received: by 2002:a05:7300:dd41:b0:34c:3ae5:c280 with SMTP id 5a478bee46e88-3537df596eemr2327609eec.10.1791544126129;
        Fri, 09 Oct 2026 04:08:46 -0700 (PDT)
Received: from archlinux ([2409:40f4:3151:37e2:36ef:bf3c:7f30:217e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca76e5asm7317758eec.15.2026.10.09.04.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 04:08:45 -0700 (PDT)
Sender: Dilshad <hello.dilshad.in@gmail.com>
From: Muhammed Dilshad A <dilsheddilu123@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	Muhammed Dilshad A <dilsheddilu123@gmail.com>
Subject: Re: [PATCH v2 0/2] combine-diff: honor relative paths consistently
Date: Fri,  9 Oct 2026 16:38:30 +0530
Message-ID: <20261009110830.54832-1-dilsheddilu123@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <xmqqh5ix8kji.fsf@gitster.g>
References: <cover.1791390459.git.dilsheddilu123@gmail.com> <xmqqh5ix8kji.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junio,

Resending in plain text after the list rejected my earlier reply.

Understood. I'll keep responses to review comments in separate replies
and make future cover letters introduce the series for readers who have
not seen the earlier discussion.

Regards,
Dilshad
