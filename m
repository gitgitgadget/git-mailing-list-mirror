Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BD7274FC6
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380322; cv=none; b=uZ6MqWj5p9UVm+ztLOhZTUFyp8VnPvGoBoqnS0I88HfhCY/Hyydv4/5wnVyLUShJ1oQyAULhZFsGNs5lk3qWgjnjE4QaYELiWADoBM0suHrFJNoRuQoV296w9ag9d3WN+YYOKGHcucOWZwX9cPQTKbEO8o7zviOl/Ne/j/KUVB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380322; c=relaxed/simple;
	bh=hBA/kZREpQV4V6MfZBoB+u0e2jpLht8LlfwJHQHJ0N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFY+OB2tvrintJ8QLc5ry8wNDMevm0JLQVTq/Ct88cY73rQ9WDoyll4EfmOVpdRz1EvFutwXdtIxTHWT7uTdlHB+LfHlJDlNDy2lIsoVSkcFkDegSGHmGz6xAL3o+V7V0/oYRPKH+mPFROITuuDI+jMUeuzu4kQPkDhqTEV7Wf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVKNsWRH; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVKNsWRH"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2efdd5c22dfso1890417fac.3
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 07:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751380320; x=1751985120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qFUvtp+3D7D3YdGsvlmT0pXYDmGWRwsYLb8ICArK1zM=;
        b=lVKNsWRHM5hUKfd5d09Y9IAmXOJM40vIXqF7AmB9J2d0mFBkEida89kQ2jJMYPz9Uk
         Rhny9sl5qKGFf691a72bQkXx7jQEC1z2E/FOG29H2blvEIPO8KZSld5G20yMksLZOpRp
         RQtVrbXfurwG7+qBHldNGIBnYYd/X9U1RPxZxWp8nLQ4z44vrUm3PG4s5RrVqxd6NABN
         5jmNnG1apbIjEfvGa0rgJArm3fj5v9pl3Yb8JRSAYKmfQaxu76bgB/oocitQe1a/72Vn
         ULrr726Pqgsm8Nc0LNclHEtWfL7Zj4KbfvWPQ+YYjQP+HH+G89EGVYzZvZq0ulmT/IQc
         3IkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751380320; x=1751985120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFUvtp+3D7D3YdGsvlmT0pXYDmGWRwsYLb8ICArK1zM=;
        b=Uf31w+mWG5BcRbPwlcLJUdzaXJXh2a3aOtAd1EEjac+YFZlnu4SFAjZF3VAE/Vsw/R
         SU42i12YprahjxTP/OIWkJ7zB/3m5irQgAgd5apX0I4GERqxjlSgZ9q+hTMNsg8FOlRC
         melo6XVoOQamH0qu6bM5gzoERXAkTCVZ8lViLsWwQD3+E4ztbEGGjveh2SLVH9KjU9eB
         zadzeZVBHiI805K20VvF45ywCRKT8gTcpbxiMBf3SW3Ezv9acbo7/lYxomxyU5UjPpC4
         zi+lfX84f0YUEl3Om5e/9/eweqRRC/pWV5VuAQ/JIV3F2q4UolaR8DXg3ec1UU3Jg2oU
         znvg==
X-Gm-Message-State: AOJu0YwM+oKoSRGFuNskJWjuugat3EX0EU9KK+xwyY/StOECrVBa7prh
	bn+VhVJgyhVWjoH+DtIbJR2x2oPa7Logcc1pEHPZJcOW5fi2OqEKr3nY
X-Gm-Gg: ASbGnctmRAJqQL/eurf1UvAGrjjkW6xnvxfPm5dCGbzS9vdCWkHL0nyFETmn4IDUla+
	EUiU0RxyDmcHnvJrGL26QZp8S3k9dIE00nVWDwxSuk9+IqwQN4bp5+KvWKkpAxgln8Qjx6E65Az
	t1Rc4iD5ARw7E48U6oHFTi3KziVw/XCWrmF1GY6rjcUONN+M71iIO+TKIR+GG2A7FJMr0J1wLXW
	g7K1QA/pLmsT7+GomYYbNMjOANgqXHyI8jSqc8O1MvVLjahjXn7pOrmdYH9OLTcUgTdbxZC+zlM
	OyVN55M2FSmbuwG0XTUkyzkkjM48bzC34EOQTY3biAOXVmqyWrt8glo=
X-Google-Smtp-Source: AGHT+IFmgsPnC0rgL+NLHkafw6hGDxh3tvCLyWRTmbUtLBgNSeP57nyLY4ww7ovKvTzqlO8MK/u/Eg==
X-Received: by 2002:a05:6871:2113:b0:2bc:716c:4622 with SMTP id 586e51a60fabf-2efed7c1ffdmr12331060fac.38.1751380318231;
        Tue, 01 Jul 2025 07:31:58 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2efd4f36d0csm3281794fac.22.2025.07.01.07.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:31:57 -0700 (PDT)
Date: Tue, 1 Jul 2025 09:26:30 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v6 00/17] object-store: carve out the object database
 subsystem
Message-ID: <o6aswfyrrfgp3xytnnko6hmxiqowiwqbfmpto6nx4pvuvrzw66@ihcwxe4ek2ek>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>

On 25/07/01 02:22PM, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series refactors the object store subsystem to become more
> self-contained by getting rid of `the_repository`. Instead of passing in
> the repository explicitly, we start to pass in the object store itself,
> which is in contrast to many other refactorings we did, but in line with
> what we did for the ref store, as well.
>
> This series also starts to properly scope functions to the carved out
> object database subsystem, which requires a bit of shuffling. This
> allows us to have a short-and-sweet `odb_` prefix for functions and
> prepares us for a future with pluggable object backends.

Nice to see the odb subsystem take shape and become more self-contained.

> The series is structured as follows:
> 
>   - Patches 1 to 3 rename `struct object_store` and `struct
>     object_directory` as well as the code files.
> 
>   - Patches 4 to 12 refactor "odb.c" to get rid of `the_repository`.
> 
>   - Patches 13 to 17 adjust the name of remaining functions so that they
>     can be clearly attributed to the ODB. I'm happy to kick these
>     patches out of this series and resend them at a later point in case
>     they create too much turmoil.
> 
> This series is built on top of 6f84262c44a (The eleventh batch,
> 2025-05-05) with ps/object-store-cleanup at 8a9e27be821 (object-store:
> drop `repo_has_object_file()`, 2025-04-29) merged into it. There are a
> couple of trivial conflicts when merged with "seen", I have appended the
> merge conflict resolution as a patch at the end of this mail.

[snip]
 
> Changes in v6:
>   - Fix a mis-merged comment.
>   - A couple of commit message improvements.
>   - Link to v5: https://lore.kernel.org/r/20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im

The changes in the range-diff are good. This version looks good to me.

-Justin
