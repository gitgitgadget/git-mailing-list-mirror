Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB481ADFE8
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919418; cv=none; b=jTBPm27WyY97Ugh53NtfSK4BcxENgwLKGum6EiQz0xhY3Xdd1gf0T4npMlVgwxuaTAfi65WbNfnuNI3RRMDufZPyxZfUL0VcC2HcKOQuT00l/5B2MUhxCJx+G+ZlEOrE6Smlt1M6tL3Ajm7o5htJeBXBf7pHw4eJ4bv3ueT0hfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919418; c=relaxed/simple;
	bh=kZHDCQwDbnUVVUoZwBaoCEt57CFbO6s3CCyMNGhLd6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4UtBLkuvE2vTSBSbJs4eRzsi3DAx4aumuNhUFcZoGCykoVYJgoyGxfotAlYfrDkFx6B+kH9NkbziFhyH/GhTW18VQQjiWycTfGuPWAnhi8kPlHZTSqzQDlF+wlSBNNzYtbNX5eOeEDsZygt9kyLC0AMng0jXPvIJK2HHIegRAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/QkUPzl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/QkUPzl"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-431160cdbd0so27863515e9.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728919414; x=1729524214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hUewdoHZJNHiXABP5XQYuRjdyeaF9gVi69hBf5W3yLs=;
        b=c/QkUPzly7ZzDONaSuXl79Z6QXcFv/UmnkGLYizJ6lMlt4Xi6KAXo7H2jd0w/bfxz6
         ZQpg8AieAdavcKEBHn+sGm1ZU5k3LT6R7ZMqVRe+1miVrODu60dMKY5L+rE/NNwDCg3M
         9QpGM4A2Q72ekApzTximAeMi63ZONPjUhpBsjVzSdD+/5i9TpcvBAE8iH6wEMNNwsdTf
         4pJUEcW8tSpjH0LPZ4H5x6GfWZkzNDUzk4OEAsliYLKz/mQ5SNPvTVC/WXdopqJ/u2S0
         iJUrWq8+OOFX6HhedrRIaqB9qu2Ur1m81dlV8Xwmy2cSbPbcAxJOR04wlb+/Ph43LcK7
         +CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728919414; x=1729524214;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUewdoHZJNHiXABP5XQYuRjdyeaF9gVi69hBf5W3yLs=;
        b=qmzrn1NH30VuxRlEfLJgV09eTGPtMwkybl1cRQNsmvUXRwpgNYhJjJ62pvatWoyZq6
         16wYHbH0HVioQ63n3uGCxrFsZzWd2/uIm1B2Qq2AM9uwrSYUHW45LZ9M05t3DhYgLWnK
         YSo9hC6saZBGRG+LQ1wNJzUSbQT2wbrY4CMiSW3/Mkzt6eiLFZ5a3KkTYGK1D4Ou4dFL
         6THVqMjKVSuXdR9SphK+OAYuanFsTN2yol9tV5uW9JAZmPdhRVwRuJGHUngnjRnbdCl2
         DbQWsIzK486nncvGDHYUFyDkC2x5nlC2yB0xtPNYOcRvutMIxMZV9fandhq9vv5+pDLl
         WMoA==
X-Forwarded-Encrypted: i=1; AJvYcCUf5t1SM606OSJ/7PvdoaOdVJeYmLg3shELVuVXhuUWHRgHZRNYHRO/Yp/JhVJxqaspTgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHx760RIlF74zQbvSAARMwb9JODTa/1xEPxQUJ5yg2gdRC3Iyn
	qcwHluhhL2liJuuO8RzsvxmpGjn9Oo2hdXa79T4PFSDxFXb9vHxYHfJTSA==
X-Google-Smtp-Source: AGHT+IHoH5c9czQViUgiVe/95hHNOzKI35DNuX+dhX5b9aS3f9uj0weaU5LZuW27JoVvra1fbrk6jQ==
X-Received: by 2002:a05:6000:dd2:b0:374:c21a:9dd4 with SMTP id ffacd0b85a97d-37d5529cb8dmr8896167f8f.20.1728919414326;
        Mon, 14 Oct 2024 08:23:34 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd3e7sm11522731f8f.39.2024.10.14.08.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 08:23:33 -0700 (PDT)
Message-ID: <72da40d7-2570-456c-966d-cd09579edd22@gmail.com>
Date: Mon, 14 Oct 2024 16:23:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 23/24] Documentation: add comparison of build
 systems
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
 Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>
References: <cover.1727881164.git.ps@pks.im> <cover.1728485139.git.ps@pks.im>
 <afa2f79d46cb9b2e25cd31b622d5f547e2746f2e.1728485139.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <afa2f79d46cb9b2e25cd31b622d5f547e2746f2e.1728485139.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 09/10/2024 15:57, Patrick Steinhardt wrote:

Thanks for putting this together, I've left a few comments below.

> +== Requirements
> +
> +The following subsections present a list of requirements that we have for any
> +potential build system. Sections are sorted by decreasing priority, even though
> +these priorities will naturally differ between users.

This last sentence sounds a bit self contradictory - whose priorities 
are we using?

> +=== Platform support
> +
> +The build system must have support for all of our primary platforms as outlined
> +by. These platforms are:

Something seems to have been lost when the first sentence was edited.

> +  - Linux
> +  - Windows
> +  - macOS
> +
> +Furthermore, the build system should have support for the following secondary
> +platforms:
> +
> +  - AIX
> +  - FreeBSD
> +  - NetBSD
> +  - OpenBSD
> +
> +The platforms which must be supported by the tool should be aligned with our
> +[platform support policy](platform-support.txt).

The platform support document does not use the terms primary or 
secondary when talking about support so I'm not sure what distinction 
we're trying to make here. Also where does NonStop fit into this?

> +=== Ease of use
> +
> +The build system should be both easy to use and easy to extend. While this is
> +naturally a subjective metric it is likely not controversial to say that some
> +build systems are considerably harder to use than others.

The tricky part is deciding how to measure ease of use if we're going to 
use it as a metric for selecting a build system.

> +=== Out-of-tree builds
> +
> +The build system should support out-of-tree builds.

Yes please!

> +=== Language support
> +
> +The following languages and toolchains are of relevance and should be supported
> +by the build system:
> +
> +  - C: the primary compiled language used by Git, must be supported. Relevant
> +    toolchains are GCC, Clang and MSVC.
> +  - Rust: candidate as a second compiled lanugage, should be supported. Relevant
> +    toolchains is the LLVM-based rustc.
> +
> +Built-in support for the respective languages is preferred over support that
> +needs to be wired up manually to avoid unnecessary complexity. Native support
> +includes the following features:
> +
> +  - Compiling objects.
> +  - Dependency tracking.
> +  - Detection of available features.
> +  - Discovery of relevant toolchains.
> +  - Linking libraries and executables.

Do we want a section about templating (i.e. substituting @XXX@) support 
which we use when installing scripts?

> +=== Test integration
> +
> +It should be possible to integrate tests into the build system such that it is
> +possible to build and test Git within the build system. Features which are nice
> +to have:
> +
> +  - Track build-time dependencies for respective tests. Unit tests have
> +    different requirements than integration tests.
> +  - Allow filtering of which tests to run.
> +  - Allow interactive tests that drop the user into a shell with `test_pause` or
> +    `debug`.

Does this last point mean we want to be able to selectively pass 
--interactive to the test script(s) being run?

> +=== CMake
> +
> +- Platform support: not as extensive as GNU Make or autoconf, but all major
> +  platforms are supported.
> +  - AIX
> +  - Cygwin
> +  - FreeBSD
> +  - Linux
> +  - OpenBSD
> +  - Solaris
> +  - Windows
> +  - macOS

This matches the list in the CMake README but in practice it is 
available for a much wider range of platforms including all those listed 
below for meson.

> +- Ease of use: easy to use, discovering available options is not always
> +  trivial. The scripting language used by CMake is somewhat cumbersome to use,
> +  but extending CMake build instructions is doable.
> +- IDE support: natively integrated into Microsoft Visual Studio. Can generate
> +  project descriptions for Xcode. An extension is available for Visual Studio
> +  Code. Many other IDEs have plugins for CMake.
> +- Out-of-tree builds: supported.
> +- Cross-platform builds: supported.
> +- Language support:
> +  - C: Supported for GCC, Clang, MSVC and other toolchains.
> +  - Rust: No built-in support, needs to be wired up manually.
> +- Test integration: supported, even though test dependencies are a bit
> +  cumbersome to use via "test fixtures". Interactive test runs are not
> +  supported.
> +
> +=== Meson
> +
> +- Platform: not as extensive as GNU Make or autoconf, but all major platforms
> +  and some smaller ones are supported.
> +  - AIX
> +  - Cygwin
> +  - DragonflyBSD
> +  - FreeBSD
> +  - Haiku
> +  - Linux
> +  - NetBSD
> +  - OpenBSD
> +  - Solaris
> +  - Windows
> +  - macOS
> +- Ease of use: easy to use, discovering available options is easy. The
> +  scripting language is straight-forward to use.
> +- IDE support: Supports generating build instructions for Xcode and Microsoft
> +  Visual Studio, a plugin exists for Visual Studio Code.

This is my main concern about meson - it means we either loose the nice 
integration on Windows that we have with CMake or we have to continue to 
maintain both. As I understand it Microsoft Visual Studio support 
requires the user to open a mingw terminal and run some to generate a 
build description which they can then use form the GUI which is what the 
CMake support was added to avoid. I guess they also need to install 
meson somehow as well.

Best Wishes

Phillip

> +- Out-of-tree builds: supported.
> +- Cross-platform builds: supported.
> +- Language support:
> +  - C: Supported for GCC, Clang, MSVC and other toolchains.
> +  - Rust: Supported for rustc.
> +- Test integration: supported. Interactive tests are supported starting with
> +  Meson 1.5.0 via the `--interactive` flag.

