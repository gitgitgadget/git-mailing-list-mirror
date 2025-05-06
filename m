Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4725872637
	for <git@vger.kernel.org>; Tue,  6 May 2025 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746564668; cv=none; b=a/j7Cq1bJ/9AdnVYbSuXvN2g4rsI+UhVbW83fGCfD3zVVU9I89GTM6U7D/fpKDOyx0nbmmXr1uFmo7du/xuFSEUpxO7fNTe+qbfGpsqzf+u1vdrWuvRqij9rXwS9KKgEUPmcVYD9vgI+N6QBPmpoSWRmmgUfYJJ1JQmQWk0PW4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746564668; c=relaxed/simple;
	bh=pyxC+uMTRPAL/t0dTDxWPlvHriuac1XqgsltuIGEzG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=il4WBIiGqIYkVEH5xmuL8qHs3C/BJTJ3RDWMb2My+VqndIjIMUO7VJOn4h3o6Qk4tyqr+ncJTIankfrm5Q+SWZ9qoAR6+m5+CaS45UDpW+ofucqnDgCgRffMkjnmVvTv5gXVk2CHnV/KnVP94ME5OQLkUeunAXUO390iRuoE5hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZ1P3bUG; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZ1P3bUG"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-60219d9812bso1632618eaf.0
        for <git@vger.kernel.org>; Tue, 06 May 2025 13:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746564666; x=1747169466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S40p46UPg97VuZW/bzHmkCC3VoncECo9C+hAOJwdAP8=;
        b=iZ1P3bUGLj8Pd3XY7hF/a7zaubQ7DhDUjWQGqP1t10HE6FswTogUhm6eKh/qWfxt2M
         BgctS/XxCsZMiF6o0bX0Hn72wwOaMfqIreGSsxoCCjp5xz+vn6GXVXeKmTpqQiZN4SPA
         G9KPqd4UJP3LkWH5hD2yL2COYsvHhGiYvJ88WVv0qUJFx+rqhIv4FlMHLfJSQyiZhBh8
         liOVUROQXxrPuzbw8Aitn1DPLyhhOZEckb0dHY+qAm1srE5GyzOf2Ffw5d0PdbwhzrMG
         WYZQihMeYDZ0quKVRuFzPoXNw1O1vmG14kHnwTZTfucT8iWORvhxQMW1DIB1wSp0UBrs
         u2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746564666; x=1747169466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S40p46UPg97VuZW/bzHmkCC3VoncECo9C+hAOJwdAP8=;
        b=wFSNlzVmOhBNJT7QiYGgUNZujdyWPIfEXQOLKN/gk6YQpT3BUXXY6y1Oo3XGAxtXLS
         XgGy1M3qDOK0xyF1iHQ6RERQ4m+fRyvyAyb+UaiKajO9NZqM1z6pT0NKnz54svCBZnw7
         NtiM3ZnVBWgIK+PnCxAKy5aw9NT2EffPZV/7mMHbvY0KhekSDMDisP3E3Qz03EOPWlmV
         NGWs7S5G5VY0tW4b+qzIFVPowvuIG60dM3wajzJu5X+/bcqwNeUcNeiTACyzcP99z1KX
         A3rr4dJ18JGLlRNO/DAvgAXIT/75tCnVZsK02Xz1tgWwum5H9cfDo43onby6/+7AQR9i
         Slyw==
X-Forwarded-Encrypted: i=1; AJvYcCURyyqxhUPhjsfha59M0leGEwJ6fCwWqgejeFCrLaqv1gsfiBVrCkfz3ZalM+gdHlxSsFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/HMo5kX82k/uzSjopn01733WAqria171cY/SxC8sKAPruqWgT
	P3NX8+y1r7I6xNbgxFrgp5OQr5TMM6Zsn/lV1vIZe21pmvqRdRQEW3Vva713
X-Gm-Gg: ASbGncsYmhn/0mYBcaFXQ0qfTYuilwSnPqy57EwVY+nG/117Zrs/G7qXmTEMw5JQP0Q
	HYyK9eqG9mPRLZMfXeOnH+2+50CYNB+cBgV00tpYbvhnLVyQW5zzPNTWNkgpfcj/xi06ZLVrsPY
	Ijio5Q+t3cC6A/DVyWvXDy0EDa5luBzdf8VfUrZgyYLP7W80jYD8V0ZQybR15PdUjgY3bJs2GVF
	eEkKx84iRzqTAPsS2Yj3KVKt5Pot8cV5EEHKwG5iwanIxI1DfIJufyn2ITpDc1slgqoPi9YLc3p
	TeM2DWTf9hOqXFrVguDx5HSPNI7u841/yQ==
X-Google-Smtp-Source: AGHT+IEtbRbdzMmGP6Op1fXvmiuyGufUFBYL7AscYE3Ls9a0PwkxCPnm4T/s6zJygwPNNwds/hC4eg==
X-Received: by 2002:a05:6820:811a:b0:607:e293:95b2 with SMTP id 006d021491bc7-60828d4c2a6mr684569eaf.8.1746564666149;
        Tue, 06 May 2025 13:51:06 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-607e7fb645bsm2446279eaf.28.2025.05.06.13.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 13:51:05 -0700 (PDT)
Date: Tue, 6 May 2025 15:46:42 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Abhishek Dalmia <adalmia@commvault.com>
Cc: Akash S <akashs@commvault.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>, Adithya Urugudige <aurugudige@commvault.com>
Subject: Re: Incremental Backup of repositories using Git
Message-ID: <hanlqq5mma3dvbfq4j4u2zgz5mjegejjg3gjrhyggg2e6ozd5t@354nrc4nq6gn>
References: <PH7PR19MB70252D42F5D04FFC0331AB63C08E2@PH7PR19MB7025.namprd19.prod.outlook.com>
 <2dz3cema2mr5mrlvuroemnyeqyrglxfmusfdz2kaghv6rvj3ro@ti2dhu45fdmr>
 <SJ1PR19MB6401D7734B73C453E491D54DAE89A@SJ1PR19MB6401.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR19MB6401D7734B73C453E491D54DAE89A@SJ1PR19MB6401.namprd19.prod.outlook.com>

On 25/05/06 12:44PM, Abhishek Dalmia wrote:
> Hi Justin
> 
> (My previous email got blocked due to HTML content)
> 
> Thanks for the recommendation. We want to backup all the repo contents, so could you please comment if the following steps will help us backup and restore everything, or we might miss some tags/references?
> 
> During backup:
> - Create full bundle first time using: git bundle create <full-bundle-file-path> --all
> - Create further incremental bundles using: git bundle create <inc-bundle-file-path> --since="<last-backup-time>" -all
> 	- making sure we don't miss out any time

Just something to note, it's ok if a bundle contains objects that
already exist in the repository. So some overlap with the previous
backup would be fine.

> During restore:
> - Create the initial repo with: git clone -bare <full-bundle-file-path> - using the full bundle we created earlier
> - For restoring further incremental bundle files
> 	- git fetch <inc-bundle-file-path> 'refs/*:refs/*'
> 	- I can't use --all here, that works only with remote repos

This seems reasonable to me. It may be worth validating that the bundles
would apply to a fresh repository. If an incremental bundle depends on
some prerequistite objects that are not in a repository it cannot be
applied. This means if you have a series of incremental backups, they
all would depend on each other and one missing in the middle could
prevent subsequent bundles from being applied.

> Will using 'refs/*:refs/*' restore everything, or is it possible any git data might get missed out?

That refspec captures all references and mirrors them. All branches and
tags, along with all reachable objects from them, would be fetched.

-Justin
