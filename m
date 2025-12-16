Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2A934D931
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765896514; cv=none; b=dnIpqm4rXZCoyhFL3IJcIE3D9qayKdbAW+pp2YK9nIGLsNVdiJjbIi6ThuaLNZyDPICBQzmlLeodhE+9GKjq7yHxNhTWtZJITqELex+R14fGz3cwf3vY8xFYJiPzpG3UZIgIKOvV+gi0fb4OhxI1Spb6+OKRPiJ5ikWvWetuVps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765896514; c=relaxed/simple;
	bh=UrsIEaxtl1OjGHOhvlEzX13FDpVLTPHPiniXQKfub8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epga7ddkbwyXvhrtIlYZQGgnzbt0cVBwxxx1DelXdWs8BjS+h9LpZLzhCnoKfcqJbo3UO7aK9Cm4WFVkPTP8IL0uDP9DVlGUiNY34cLAereZZ0Jf4/dZefkiH8JewLVJdsdvrt7Eh7UFW126MiRGmY/C/y7/+4m6V6IDPST/E6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rl4kuis1; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rl4kuis1"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c52fa75cd3so4216097a34.3
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 06:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765896511; x=1766501311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WtW5W2Z4KjizDguorhhJXgY3FvK4qb7owlLBuMRX0ZY=;
        b=Rl4kuis1MEU+sJhqw4VCFN/+q3pqEnwgPqdkKWZFKn04hTYjiMbx4bZSPo6rfIn0nd
         03ohOSCO3U1tsD/UQdmRn7EZ+n/tMIPDmByjqnLn5vc2N3G8llKGop7nAZ0Iru6mmhIq
         +Hlrvsvw2z49LCtKDTm4XLGRyhfaiMed0ChzQBbd9UetRvXkvasOl4zoWOBtBvmeHPiP
         e9+7RnFgodOYZe+XRGDiVy0hba6k4VyywjGMkXvoWHFwCUbLfoa/y73qYm4k+LSxmduB
         T+qpkdgxP46rud212mDflv3cAfT8vKvvdUHCUEtDM/OCSBsDM2LZgpogfEmeNZ0LHhz5
         LIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765896511; x=1766501311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtW5W2Z4KjizDguorhhJXgY3FvK4qb7owlLBuMRX0ZY=;
        b=Kb6pSzu++ScqQjSkq2o9g1sH6a5s5lOiHuW7KLDQ/coI3Z1mfXAJc0KSfoc8mZg+T8
         5AD4smHYR3vO8FAOrKc05tUXr1+ovOpdpHq0zFoTrzkYZ5U9b06QPEhXJycc1a+mjgs5
         bEgbf3tU1TXkW1B+GcUm8Aek6rIM/f04WU9wNVC4aQqnLMNSimL37GaPLuH9d8jk5ITG
         vSNgQFa0LI+mWlcOUCUMUyldYcQtKYG9VZvid8l+yvH+bYhrzfgNbEE7eodPGHpyEP3e
         j0YmC6Vyxps26EYKSwWx1rZ4UqQaMmK9tHbUDH5C6FdpTGriH6ojpRsdpelEKrfByaCV
         wQ+A==
X-Gm-Message-State: AOJu0YyinECgLYhS8OcA4B23EMphjWqTe8qFrOwMBxtbpZEXdzuO+CJo
	T4T66orY0tBCbtPeL13mG9LzgsiOHA6ih3A4AE7lR72YsaJtdvoHRquU6CBMew==
X-Gm-Gg: AY/fxX5AZFkguzkV6I9v6LZqpVY1L5pQCON+JmTFh2/POQHOSeLMIBlv132b2MHKMeJ
	tlZml+wh9xYB9RsnI0DZ7M74vC1b/tpU22ba/AhLUi1gMZlNg6P3iY+hxD3MjLjWi7RGTtsbYN2
	6glPQBWR15kkzyc+J3g6bJ8Zd2rbouDpSGwjPKG9EcSea7WN4Uf8tX91aILzsc/R+5IAg6Que6w
	YgdpjWnLBHDFxVtcIqcVjo32Y6JN3wITRpF0K0yTDX6z5dxCTo6sNyZkJKPZLVxegwt4avSRdv9
	6WNC/JxURJ711itnhr1GUXB8wyLACfCW0sgtJB4RafIIs4iIYx6/rOtZ0RhenERTAudKygUVhS4
	tBGSpI57avpVoL1HLT2u0oAK8E3iW0WlNJ43L5ObXipOaO/yHY5Le3Enl+UkkqV9df4JJYKKlQA
	jh0MIq
X-Google-Smtp-Source: AGHT+IEYttP4ZRZZCR+rADqz30iX2D7/MPo3RPFFWRfIXrRlEnwgrY0iYm7cXIdx/WDxkO4fFzY/tw==
X-Received: by 2002:a05:6830:3104:b0:7c5:2c10:b6b8 with SMTP id 46e09a7af769-7cae82d7fdemr7908419a34.2.1765896511259;
        Tue, 16 Dec 2025 06:48:31 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb200661sm11572193a34.8.2025.12.16.06.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 06:48:30 -0800 (PST)
Date: Tue, 16 Dec 2025 08:48:30 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 7/7] builtin/repo: add object disk size info to
 structure table
Message-ID: <y7kutectqntle5557tjmta44wwjvk2f4tvsxfuajaktj647275@6kupww6ldexe>
References: <20251212223644.3090879-1-jltobler@gmail.com>
 <20251215205639.2700270-1-jltobler@gmail.com>
 <20251215205639.2700270-8-jltobler@gmail.com>
 <aUEXeuCkMDWSfwHi@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUEXeuCkMDWSfwHi@pks.im>

On 25/12/16 09:25AM, Patrick Steinhardt wrote:
> On Mon, Dec 15, 2025 at 02:56:39PM -0600, Justin Tobler wrote:
> > diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> > index dd17caad05..64db191234 100755
> > --- a/t/t1901-repo-structure.sh
> > +++ b/t/t1901-repo-structure.sh
> > @@ -5,8 +5,18 @@ test_description='test git repo structure'
> >  . ./test-lib.sh
> >  
> >  object_type_disk_usage() {
> > -	git rev-list --all --objects --disk-usage --filter=object:type=$1 \
> > -		--filter-provided-objects
> > +	disk_usage_opt="--disk-usage"
> > +
> > +	if [ "$2" = "true" ]; then
> > +		disk_usage_opt="--disk-usage=human"
> > +	fi
> > +
> > +	if [ "$1" = "all" ]; then
> > +		git rev-list --all --objects $disk_usage_opt
> > +	else
> > +		git rev-list --all --objects $disk_usage_opt \
> > +			--filter=object:type=$1 --filter-provided-objects
> > +	fi
> >  }
> >  
> >  test_expect_success 'empty repository' '
> 
> We don't use `if [ ... ]` in our codebase, and we typically have the
> `then` on the next line:
> 
>     if test "$2" = "true"
>     then
>         ...
>     fi
> 
>     if test "$1" = "all"
>     then
>         ...
>     else
>         ...
>     fi

Noted, will fix.

> > @@ -79,6 +94,11 @@ test_expect_success SHA1 'repository with references and objects' '
> >  		|     * Trees          |  15.81 MiB |
> >  		|     * Blobs          |  11.68 KiB |
> >  		|     * Tags           |    132 B   |
> > +		|   * Disk size        | $(object_type_disk_usage all true) |
> > +		|     * Commits        | $(object_type_disk_usage commit true) |
> > +		|     * Trees          | $(object_type_disk_usage tree true) |
> > +		|     * Blobs          |  $(object_type_disk_usage blob true) |
> > +		|     * Tags           |    $(object_type_disk_usage tag) B   |
> >  		EOF
> 
> Curious, but why is the last one special here?

The `--disk-usage=human` rev-list option here outputs "byte/bytes"
instead of "B". In patch 5, the HUMANISE_COMPACT flag was added to
humanise_bytes() to toggle this behavior. For the git-repo(1) structure
table output, I wanted to always use the more compact unit prefix
representation.

I'll leave a comment here to explain this special case.

-Justin
