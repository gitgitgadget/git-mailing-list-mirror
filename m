Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68931144039
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240314; cv=none; b=Dul+Ql4l7xS3DVeE0iLr4YeGZlZ9HsJpzI15FUeEF9q5e6na6VycR4+Cpg6y9SM1fbpXh6z4rOimgIsKmdij4dKEPb3r4sY/6mcUZBFv31qzoVOE/azRh5SUDxOVRCi8KpXa+f85VNmtoxfc6Ng9tDvkWvMSsdlyMT4YI+jriuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240314; c=relaxed/simple;
	bh=AivSGio2kU8UuGchoEQEiBGqBoKUkDhmVSo44SLv32w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=le8ZXUvzJcjlgclIpjX+jYCpwrx7LBNY6kKj/jApqeZX5+Q8N3Ez5xAA1xIqibuTFRYytUFG0h+IY84f4RlsfxGrpDrOQq0V6SFy7fEyOzLL5bblcg98gFEuhjcAhr3WLTWzHxce4Le3seWakcnbVu8D5cTLlQYPr/m+TdMDOVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEvFqgwf; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEvFqgwf"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-299b92948a6so959704a91.3
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 12:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709240312; x=1709845112; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jvtd1YPyVfuVi8vO8M8LD3uvGAxJnI5RdDxAcEp34UI=;
        b=PEvFqgwfmw7ds0CoZkQQLT0EZ7PtOUv7vgOOutEZh+yCSGe0ayQnaVE6DbG+wzM4Qa
         K9KkRcPeLpgv8szAFXgMXLXzwj+OooE8pVc19jMD9vXocZpzRST5gFr3buQEFQBKbv58
         rX+LsSwG7EHBMFe7fOhHFQ1Hgj6nyBq+t3BVgfrxZiHgF2Ioyw2wij+HTvzw4L3OTCCr
         N9H5qI8IEIlB22Zp7W/P28YRksSXU3F+/o6wICu8Xk386ufkig37eGdxTlS/o7e4lpur
         LWBIlzqAbhUbvur0HfcuvrVieHOtDUDmzIqTmAAfpqk43aerc6Qjr7kcfhN04yt7soeY
         I0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709240312; x=1709845112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jvtd1YPyVfuVi8vO8M8LD3uvGAxJnI5RdDxAcEp34UI=;
        b=pKGhO8GsFhUnlNFhGhzwqYvggVu09LkhZyatqjQWNFrWkbKyDuyXByVkFRvXvy3B1w
         DALh9PLvIVGCa5s/r6G9Tv5kLXj9ZAeZd2MJAGS64p4j+kyYei7SeK4wpMCzu834x0WM
         J+jELjFWe6nVQ1egZTx3WIeEkjWdPzLeuxZSltFxc77L+q8lS2Pg3c1PLrcI4ePWt7kO
         wtyRiQtfvM0mY2CRmGiYg/9PxfWFCppctCf1plIR1biPwxVg6uYWD/CbSttG/6ymDMDl
         9mxDPEelK9bovSQF8pF7HSNSD+oFN+fE5DWFNOVUZE/cI9Kv936NBMqajAwRjO2vcuaf
         7Leg==
X-Gm-Message-State: AOJu0Yw3Zj5s8YITi/3P5jfsV1Ad7GaEifGWxoEGAJanZ5REC3pPPClP
	tTZ3Bg4UDo/dHxrmqNVAF8EHFCYhjbVyfEIRWStzRzIcJbMEVyVdThMJlz6W
X-Google-Smtp-Source: AGHT+IE6k9CR4DCknpVrd7KnTYPIy7ATDXbNowzRkyTnZTA49A6uEJPiUelZEPFUAz5rv9fq3n0Wvg==
X-Received: by 2002:a17:90b:4d87:b0:29b:a59:a12d with SMTP id oj7-20020a17090b4d8700b0029b0a59a12dmr207650pjb.25.1709240312522;
        Thu, 29 Feb 2024 12:58:32 -0800 (PST)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id cc13-20020a17090af10d00b0029681231ae1sm1930993pjb.28.2024.02.29.12.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 12:58:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Mar 2024 02:28:27 +0530
Message-Id: <CZHV4DHG59B1.2KMP4AJW9MHJE@gmail.com>
Cc: <git@vger.kernel.org>, <johannes.schindelin@gmx.de>, <newren@gmail.com>,
 <christian.couder@gmail.com>
Subject: Re: [PATCH] setup: clarify TODO comment about ignoring core.bare
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-Mailer: aerc 0.15.2
References: <85d4e83c-b6c4-4308-ac8c-a65c911c8a95@gmail.com>
 <20240229134114.285393-2-shyamthakkar001@gmail.com>
 <xmqqsf1bf5ew.fsf@gitster.g>
In-Reply-To: <xmqqsf1bf5ew.fsf@gitster.g>

On Fri Mar 1, 2024 at 12:45 AM IST, Junio C Hamano wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
>
> >  	/*
> > -	 * TODO: heed core.bare from config file in templates if no
> > -	 *       command-line override given
> > +	 * Note: The below line simply checks the presence of worktree (the
> > +	 * simplification of which is given after the line) and core.bare fro=
m
> > +	 * config file is not taken into account when deciding if the worktre=
e
> > +	 * should be created or not, even if no command line override given.
> > +	 * That is intentional. Therefore, if in future we want to heed
> > +	 * core.bare from config file, we should do it before we create any
> > +	 * subsequent directories for worktree or repo because until this poi=
nt
> > +	 * they should already be created.
> >  	 */
> >  	is_bare_repository_cfg =3D prev_bare_repository || !work_tree;
>
> I do not recall the discussion; others may want to discuss if the
> change above is desirable, before I come back to the topic later.
>
> But I see this long comment totally unnecessary and distracting.
>
> > -	/* TODO (continued):
> > +	/* Note (continued):
> >  	 *
> > -	 * Unfortunately, the line above is equivalent to
> > +	 * The line above is equivalent to
> >  	 *    is_bare_repository_cfg =3D !work_tree;
> > -	 * which ignores the config entirely even if no `--[no-]bare`
> > -	 * command line option was present.
> >  	 *
> >  	 * To see why, note that before this function, there was this call:
> >  	 *    prev_bare_repository =3D is_bare_repository()
>
> If it can be proven that the assignment can be simplified to lose
> the "prev_bare_repository ||" part, then the above comment can be
> used as part of the proposed log message for a commit that makes
> such a change.  There is no reason to leave such a long comment to
> leave the more complex "A || B" expression when it can be simplified
> to "B", no?

I agree. In fact, we can remove the prev_bare_repository variable altogethe=
r
as it was used solely for the "A || B" expression. Initially this
function used to be in builtin/init-db.c and shared with
builtin/clone.c. In moving to setup.c, an unnecessary global variable
equivalent to prev_bare_repository was removed and therefore
prev_bare_repository was intruduced to not hinder the future possibility
of intruducing the (core.bare from config) feature which might have been
the global variables partial intent[1]. Therefore, I kept the original
expression.

However, in the same series that this was introduced, it was acknowledged
by Elijah[2] that create_default_files() would possibly be too late to heed
core.bare. And indeed it is, as the directories for the worktree or repo
are already created by this point. Therefore, prev_bare_repository does
not seem to have any usecase with/without supporting core.bare from
config.

[1]:
https://lore.kernel.org/git/xmqqsf1bf5ew.fsf@gitster.g/T/#m64125dd80d04ae17=
7944434e7092522325b374c9
[2]: 0f7443bdc7 (init-db: document existing bug with core.bare in
template config, 2023-05-16)

Thanks.
