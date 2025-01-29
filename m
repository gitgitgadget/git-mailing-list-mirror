Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0465C1E0E10
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738183503; cv=none; b=OttWxH2iUEgBv1hbV3DFcIP5fHGmP83RUh0namxnvmEOXyuPKvCZNE8OHvm8y4ukRPsx0rpmtH8ewb6w46lx779ZiRzWQSH5jvydFbGkYpbbDuu/BA4lIKo0IwjcnFZVP6GHKb+FaBKFVgFJiFRkRV/2YOZRMIRDQeocy7maY9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738183503; c=relaxed/simple;
	bh=/xmymbh/UXAhSbeAp7bIF2Vb8Y1k0i7VXFBjJgRDAAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1FlsWzkcbVTF34maPmy446h7bBnd2cNS++84TiYiKfDtwjL0ZtZHSEqfJrxjUrc160alSslS9So+OT8p3Qj0zI/gti0NmuiCkU/V2XnkVlj1JQs0Ic7s5ItHcFO+X+DOohuxJgGBc4CM4va/MdF3vPyeF02/AUY87S673gQZYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jzlw0Las; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jzlw0Las"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71e287897ceso79030a34.0
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 12:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738183501; x=1738788301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Jbt7tcghAKyiGheDiUv7jJRvamhp4RL67UvOUTbQPs=;
        b=Jzlw0LasqnmaKo+fzTNWMUhkN/Le5hX23o+yOvUYhDXmg1hazsEvIqJ2EYwfdxwt4m
         usfT90ejBXaQX0XS8XeAF1ChD6CROFnh28Js2JCKiYq2RXAzJcCuWOhX+jV1AvpOPbjZ
         e1FJAbuk9qg9LbGuT3FWL6zn38fpf3qdHBuwU0+vRr0+ejseUTJ1R6AMUYgx8sGBOYhP
         02IJDRDNank10nGCgsv4pR0v+ZdaTMewyi5zn4Q1fcEpSKsFPSsDNuLi5eobWeu/BrNu
         ykr550NH0aWiahPMexbl/VLANt2A0Lmwp1C1JW9vJslg0hcSBwXixl9ACqf/dxjh3W9D
         zniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738183501; x=1738788301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Jbt7tcghAKyiGheDiUv7jJRvamhp4RL67UvOUTbQPs=;
        b=lgBSrBp4iUZeiviOT1vOsprvWzgJPBNtA6Ki06JGZr0Y3EaOMPM5TUl78SzLc69BlF
         iHfRrpwcG611rGW5mCfXpTqUV7mHyZdd0t/lE2iOC6AnPJqtTNnwNcaZHTDXowW50Dp5
         6PADif0YVmo37NjI8VsIEpilxOdbw1QsA/PjdiVEyT7v44OaoKC8nhpIJ8ZW3hBuYVqn
         pNAHDjq93d7v19irpbvxttHit4AayEmXyMZF5mtQjuU/R1hXBNo+pldkyTrQB5i7cbI/
         7wMWfbUFFx8US4l731+s6UhTwF73WTjAHaxCccwprSexYk1dSTBMlXt9vgfQXgRpxA8L
         DFPA==
X-Gm-Message-State: AOJu0Yxmq2fpw9BxuU5C4eVxoSO472bLZMdyuRUamZlcXIHYCxWR6sY0
	HUTbbNr+aFoUPu1kJ2zfH4dXsBMwFCdPjmWpKhXLMWpD1+02vOfLI0gc8A==
X-Gm-Gg: ASbGncuWxX4+D52Xer0cgVAeuK2XMtX8wJTFwAYT3lVSaFAGAaqWybjBW9/hAVERKXi
	zJYrPcmSUr7oYYB2/UUiMkXKjQ8mBXB0e0EA7PvF4Eph54dC3q/GIMhsNZD5Dplj4YUxEc0ob2B
	8+/hjD2E9EAWtOyTTuePTzhMoFzNYN7oTwenbS0UNQkg0xRf8SVAq9Eho+JSEmtAA3T4p9rGx6b
	SsNmUk6DfxjibHuB5MD6Cm/Vn30lmYW9sUU4zDcxH/8IiwTJohltrmrD5ZoOM+stBRLAucy04It
	76WRMT3v
X-Google-Smtp-Source: AGHT+IHS2q5KuUX0dF93CseKooqoDcirpL2yQUhGZdLYOzNKo8fDuoRTPV7fCJ+uXZo/ixg8g5nXFA==
X-Received: by 2002:a05:6830:2901:b0:724:921b:5b03 with SMTP id 46e09a7af769-72656785110mr2443940a34.14.1738183500920;
        Wed, 29 Jan 2025 12:45:00 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b35610846csm12398fac.4.2025.01.29.12.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 12:45:00 -0800 (PST)
Date: Wed, 29 Jan 2025 14:42:07 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/11] meson: simplify setup of PATH environment variable
Message-ID: <ujdktdisdk56ow3f2uudfgyh4lkya372wennuh7xsurbmylkgx@gh6p3l5hx3nf>
References: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
 <20250129-b4-pks-meson-improvements-v1-8-ab709f0be12c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129-b4-pks-meson-improvements-v1-8-ab709f0be12c@pks.im>

On 25/01/29 08:12AM, Patrick Steinhardt wrote:
> We're setting up the PATH environment variable such that a set of
> necessary build tools can be found at build time. Make this step a bit
> less repetitive by only looping through the set of found programs once.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 48eb068fd8..e3829f2365 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -181,22 +181,21 @@ if host_machine.system() == 'windows'
>    program_path += [ 'C:/Program Files/Git/bin', 'C:/Program Files/Git/usr/bin' ]
>  endif
>  
> +cat = find_program('cat', dirs: program_path)
>  cygpath = find_program('cygpath', dirs: program_path, required: false)
>  diff = find_program('diff', dirs: program_path)
> +git = find_program('git', dirs: program_path, required: false)
> +grep = find_program('grep', dirs: program_path)
> +sed = find_program('sed', dirs: program_path)
>  shell = find_program('sh', dirs: program_path)
>  tar = find_program('tar', dirs: program_path)

At first I was curious to why we wouldn't just invoke `find_program()`
during the loop as well, but some of these programs are not required and
marked as such here.

>  script_environment = environment()
> -foreach tool : ['cat', 'grep', 'sed']
> -  program = find_program(tool, dirs: program_path)
> -  script_environment.prepend('PATH', fs.parent(program.full_path()))
> +foreach program : [cat, cygpath, diff, git, grep, sed, shell, tar]
> +  if program.found()
> +    script_environment.prepend('PATH', fs.parent(program.full_path()))
> +  endif

It looks like cygpath, diff, shell, and tar were previously not being
appended to the path environment. With this change now they are.

>  endforeach
> -
> -git = find_program('git', dirs: program_path, required: false)
> -if git.found()
> -  script_environment.prepend('PATH', fs.parent(git.full_path()))
> -endif
> -
>  if get_option('sane_tool_path') != ''
>    script_environment.prepend('PATH', get_option('sane_tool_path'))
>  endif
> 
> -- 
> 2.48.1.362.g079036d154.dirty
> 
> 
