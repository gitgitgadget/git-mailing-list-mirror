Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDD3199EBB
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729597350; cv=none; b=AtUDR7SKHG7LDDHbT9AMHIi2cLrJhmMEBbYGxpNW3jAaBFgbprWVI0PpTDRPgmdkhnCorxLSrCWd8y6+BFLKnaM61u9ZfdPYthGhYejLrdz0S98g3XI310QQmDOdsCJYzMvN69P+y0tpncVlmLC3up1pFFjNQt1XEfqnegzdRns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729597350; c=relaxed/simple;
	bh=9T1K2WMM5CRiUv4zsOec4zFotRYBQGj9cJl072I/ARg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6Qewl8sOje16E9uhwR050o3CBp/LqDp9LByIZ0qvFZDanOZXcfdZfQNRDaX4fwt1cTQIU1v720ddiiE2k4bGW9g4frVDOs0CJy1cevlcZ4E0EObNA4X21jb8mc26gjSyDHSc/nhuDRfSZhC5cI53x/fY/BpQLLTILYDZePqA4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMqNW824; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMqNW824"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ca1b6a80aso51718065ad.2
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 04:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729597348; x=1730202148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dK5Guo8D0qhnFEN8aTXha7alf2efn0H8T8+8sgkYXaY=;
        b=HMqNW824OkBShguNFvCFN3zondw/r7JlpJHHkDSgpOj3CyyiydDchGK9VSP1YjqCHt
         naHMav9NFFQfRz+yhpnDy08KEbL7Q56Kh/XixE44MoCt3yqQLJ4mCzklQN1Yvx1lE8sL
         WpDjt0xhZa0tr406V0fuZI+TMMgYZqf6nYy8e+s3+B9S/eeIDPK6g4F14HVHugwmFcm4
         IZzlzivd8gYV9/cdxg6Y/hH+9aG6WQwLl/KgZd7g53ciAl3U7ZjVYFynHgCQERaAuN05
         fh0vbXPuxOzUdCBFa3CvGQUHocxQDympgkohl+cRzDH2fZv79ZWOiVZc+2NEObFs+HYY
         OcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729597348; x=1730202148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dK5Guo8D0qhnFEN8aTXha7alf2efn0H8T8+8sgkYXaY=;
        b=rTcJY9lLqBa/4mltyJ3d6J8DKfvjqATJ/awEGWciSR8Fp4jPra0jdrvbAfwrtzk7ND
         jGIahGAJY0gOOJKA8t4FhgpOlsTq66ExfNkiXtwealYWf6498UzUfExzxUBQhXgbhHkv
         E0qPWpO8GxFpqHd75171u5lEMjrXTJhjIZDnVQpOSVakLFoNyTSGG79PNFNeTSWmGtQD
         tKpBx0+ZoxwM8X3ZfRA9e73wcxGKTbNyQCxm2jnY37B/aM3mycJmWWJ/9qfFIz3C/DKD
         iTeWx5m3XAn70jazsdNS1wVGtm0cUAtTU9H+9jLTm8d9eiBHwEH8BH3uJJkYIYtEOkJ7
         QGmA==
X-Gm-Message-State: AOJu0Yzg2V32ZqbA0ujR/ZaqjSkyPoWR5/C3of7UV4194rCOmri/Fdg9
	+Ay4dPaxSvkbbbPHnARQZUVRaxtknvAw9DoP3+xfoEH9+rqYp3YJ
X-Google-Smtp-Source: AGHT+IFOSAPEiuYf3vC8cauE7qca84wI4V7uYzsor3DfCSoQ9GjTmmjZPLppx/qTWVdtztIA10gYuQ==
X-Received: by 2002:a17:903:2287:b0:20c:ab33:f8b8 with SMTP id d9443c01a7336-20e5a76da57mr222040925ad.15.1729597347761;
        Tue, 22 Oct 2024 04:42:27 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef1a953sm41375865ad.112.2024.10.22.04.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 04:42:27 -0700 (PDT)
Date: Tue, 22 Oct 2024 19:42:32 +0800
From: shejialuo <shejialuo@gmail.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/9] ref: check the full refname instead of basename
Message-ID: <ZxePqCgV3RQDtwe-@ArchLinux>
References: <ZxZX5HDdq_R0C77b@ArchLinux>
 <ZxZYXpuCD2I_3bNh@ArchLinux>
 <CAOLa=ZSoB77JvuEJkWLL=eiDTsKysM8sxcYddUEbTSt1LziY1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSoB77JvuEJkWLL=eiDTsKysM8sxcYddUEbTSt1LziY1A@mail.gmail.com>

On Mon, Oct 21, 2024 at 10:38:02AM -0500, karthik nayak wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> [snip]
> 
> > diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> > index 71a4d1a5ae..0aee377439 100755
> > --- a/t/t0602-reffiles-fsck.sh
> > +++ b/t/t0602-reffiles-fsck.sh
> > @@ -25,6 +25,13 @@ test_expect_success 'ref name should be checked' '
> >  	git tag tag-2 &&
> >  	git tag multi_hierarchy/tag-2 &&
> >
> > +	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
> > +	git refs verify 2>err &&
> > +	cat >expect <<-EOF &&
> > +	EOF
> > +	test_must_be_empty err &&
> > +	rm $branch_dir_prefix/@ &&
> > +
> >  	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
> >  	test_must_fail git refs verify 2>err &&
> >  	cat >expect <<-EOF &&
> > @@ -33,20 +40,20 @@ test_expect_success 'ref name should be checked' '
> >  	rm $branch_dir_prefix/.branch-1 &&
> >  	test_cmp expect err &&
> >
> > -	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
> > +	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/'\'' branch-1'\'' &&
> 
> Nit: Here and below we could use ${SQ} instead.
> 

I agree.

> [snip]


