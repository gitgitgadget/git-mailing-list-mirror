Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110BF1E3772
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753899253; cv=none; b=HmWxejr1kWm9F3WX25o/TBSCdmVdBNpW97vSVcyenyMplB2G70z1BXxot0kBRGRf/gDuojqkA/3fCcN56jmiFD9+vM9DOQtGwc/yMdd//1LkcOr8to+3DcKD6MbZdaz/9Pv1Aj27jdlIT+bIxrFZAZc/sM1R1vfrf+v0+I4NOgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753899253; c=relaxed/simple;
	bh=Ub8XjQEj5f/o++X/cNp73SVI570prlPQlpmYeYkm2f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGZIKPSznxN0bZt0tIUOzZeQrRsx+ob+vT2G63nr4SszNyiTc6fI9lpkMWn2e6HAjAc8S3NetILc2ORm/Vn4PCnxxeVhWTwMOcsP5EIqneZYsrU9nEjUH8Zr9C9u2cyzNdqptrsq1zmmqv8FKQFqxg7Ccs3jwXekRFQokvt7Q04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVH2D7P3; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVH2D7P3"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2ff8d43619cso137185fac.1
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 11:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753899251; x=1754504051; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vzs9U5UyWtldtbFyifJXvCjel3myqH9NQdl5liy5JHI=;
        b=fVH2D7P3LyoKp/DIskX0aWU217vVUUJb7/Na0nmkM8OAHo6alyacutPEP27pviONXv
         Pv7jgQOrUw0HmtucuvfRvvyFUEy/6Kg6ih6y58tZQU4lubTkEBtnhdJgLYpkwKAGdt3O
         mW05ARyrHRKtDItykxn3IE5g/kyN6OZIPWF5ohRaCArAGqToU5s5N7cnlHLpO4pkNI7c
         WjS3a4CP4vXuq8feapFkc9jNAPs6gk+FZKGjCz50FBXAcj9un42vU3LTfAa87YoqsZNE
         +jNXzeXbNHgo8mGCzHRPX8WcsvM48gbJvZZrMefRTfnM7gL1OMBKN2/Ru7sWv9/wTf2T
         9iKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753899251; x=1754504051;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vzs9U5UyWtldtbFyifJXvCjel3myqH9NQdl5liy5JHI=;
        b=NXXQpySOAw0n+ITly5dLPhtCuTFLQbR8ARpTaok5YJZF9xsO0eIaxvlJLvzo1uzcxR
         xlOFMVZ0JsUuxB3Xu8DpYO3Ttp5MX+PqmEGNjR876cQoBDkD/7hpVquDAF/NC+xLtneI
         gYtVxaWAo4BRGYy4I0qu9TfJpPiYk4iHZ7YHh+8bC2htcJUdluqQMA0GUq4EAz2J4Dc3
         El9VjDAzYO6nOLSO9QfYZQDDLVaBbGYU9e+jQfyeHPM9la5LHd5N7DgR5eGs+n/1Nu/F
         qBVeA7iHqYuR0ebhtRDfZtSaMIL4seDkHqBAL9CDyIe+ZIQz7EzxzPta20c+A/Q+ueeb
         Y2wA==
X-Forwarded-Encrypted: i=1; AJvYcCUyMjoUvVhaHJPWIQ40Twz35LipEgma5tfonobzwbIs3CDWzPl/LAybvdQR1MgYFf420O8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0PFmBuRPXTNfGeQrkXCTTeqw4hS6YGAruKeDRvt34zFx51Grg
	1BMdPoLlgzxDZggmfS2+elesP+taBoemVboU4Ck0da8Qh5iPqb0R33sd
X-Gm-Gg: ASbGnctV7kDpMLfkWTvLoCIOpc/Mhwhi7wmesAQFsd+JcxkNtmAYdtF1YA5GVuBLiNG
	vsGHTtEgacBaCX2dZu2M2WmsVmul1WUtdLxNYo5lFE3Gesq0YAzlBPbcliPp3Rg7R8A6ius6Lci
	urOE6PXgh6TMQtxr/kVd+GVCi/sl3SZTUsIeDavp6jst7Wk1S2JitXVCvP8QzhKUQm5YOAXb3Mc
	k++Vth2ppe4hydDskQl+1L+tJZ7ho+4x/33+aMHz2M4WxIeHlOxtRyuH+TnfXB91x+8K2qT16yt
	lsLl3Y6PD6ssIP9pTyScOT4Mf2QC++T1UHmwc1KrajzXhrs8zuD+gICJ3EZfkIL556gHVoICPxg
	jj2zlQK+ynSmNNNE=
X-Google-Smtp-Source: AGHT+IE1CJbGqllIQIyepXCVY65fg7Nn2ow+nCdaRwXqCR0IyOFAX9xi/o1Sgnw6/clTDFXDGn0owg==
X-Received: by 2002:a05:6871:4309:b0:2bd:455e:c22e with SMTP id 586e51a60fabf-30785c5c20bmr2624187fac.19.1753899250937;
        Wed, 30 Jul 2025 11:14:10 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-3071316d7ffsm3036370fac.5.2025.07.30.11.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 11:14:10 -0700 (PDT)
Date: Wed, 30 Jul 2025 13:08:13 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?6ZmI5bu66JmO?= via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, =?utf-8?B?6ZmI5bu66JmO?= <18230222379@163.com>, 
	=?utf-8?B?6ZmI5bu66JmO?= <chenjianhu@kylinos.cn>
Subject: Re: [PATCH] modify the =?utf-8?B?4oCcZm9v?= =?utf-8?Q?=22?= file
 path to "$PWD/bad-clone/sub/foo".
Message-ID: <r3q4uyx6725ryuxnvnpidyaglptytro25pw4l53tg4vypkdruh@fmsgo5c6r4qd>
References: <pull.2022.git.git.1753860300588.gitgitgadget@gmail.com>
 <xmqq5xf9n0jf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5xf9n0jf.fsf@gitster.g>

On 25/07/30 08:47AM, Junio C Hamano wrote:
> "陈建虎 via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > From: =?UTF-8?q?=E9=99=88=E5=BB=BA=E8=99=8E?= <chenjianhu@kylinos.cn>
> 
> Justin, who wrote the test originally, Cc'ed for comments.
> 
> > diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
> > index 14b5743b962..f512eed278c 100755
> > --- a/t/t7450-bad-git-dotfiles.sh
> > +++ b/t/t7450-bad-git-dotfiles.sh
> > @@ -401,7 +401,7 @@ test_expect_success SYMLINKS,!WINDOWS,!MINGW 'submodule must not checkout into d
> >  	git -C repo commit -m submodule &&
> >  
> >  	git -c protocol.file.allow=always clone --recurse-submodules repo bad-clone &&
> > -	! test -f "$PWD/foo" &&
> > +	! test -f "$PWD/bad-clone/sub/foo" &&

This assertion is supposed to validate that the post-checkout hook did
not execute. The path here is incorrect indeed. I've tested the fix here
and it works as expected. Thanks

> >  	test -f $(printf "bad-clone/sub\r/post-checkout")

The second assertion here still demonstrates that a file was not checked
out into an arbitrary location, which is the root of the problem, and
likely why I missed this. Apologies. 

-Justin
