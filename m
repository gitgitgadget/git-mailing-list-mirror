Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF577272E74
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 18:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756405729; cv=none; b=Jfp4RU5ZEgvDRu9dWtol7SXZmqRIWL5IBsGcYczWXteyW7r+glv6+dp/cwhYBa/qkEAB7lnmtc6fQC0KqWRVrlYC4S0W9qqw+HaDo17nDKVOLO0ULd0JFyUEMvPGrRxQsfi6LEbkCHIg9GUhzleLeVjbYqzA7CLJElDq0eDXYvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756405729; c=relaxed/simple;
	bh=R1UTKMSNy19ecZ1RDqrF3MO+9YyJ3wbHQCjodvIPens=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ur3ZKargdoj6/OGAJ6NE/eKe9zTRViHdCiH8tNOshvwhefMhqwRHFZ1f66kxuRM0ovfaxP7Yhz3FqzpwHgS2TjaUPNk3Sq4P8wMVUC5fVCch5vxpEW2o/+rAA926vIA6G4Skoh1JOWeh6QXx6tnIhBbgYSOkAqP5eqPbLsm6/DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTZ4NPFs; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTZ4NPFs"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ce47d1f1f8so691019f8f.2
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756405726; x=1757010526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lqjagfnw3kRh6dxnUNLVht+Lk0gy+cgVA2Tm6Iq0GFM=;
        b=nTZ4NPFsIRKOC31pZEQNOgeoN4exdBRn6XY7HfVFvH43Jqbqn3AMhMTIz2R0WkrqC2
         JgOn5f5x79YTjGxd7m9GI4+B5ysDrMKP9+L3G/hEFkODkSM39zoIn0Aptb4XF9wmSpBj
         6RCEb1UG8hUVC9OBejOsPJuwa6E6CwQkM0m6ndFWGvqd3xatqQuqhF9X71WKuIolEexW
         vEot7aFXBn/8x9stBOurEahXJ7cLB9OGLSZjqASTK9GjTIKW89MTnVUoEn1/AOh4JFhI
         dQv4iRENDmEb5k7NCooER8D2r++LAvDDlIqaSi1dowDUR1vR0NGRuw7jMsP7ihHJSylB
         vx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756405726; x=1757010526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lqjagfnw3kRh6dxnUNLVht+Lk0gy+cgVA2Tm6Iq0GFM=;
        b=HxDfp8NvOjAAqoX3Eiu+8KP1yzVJm9UaySNXJDLJcKqPsnaUVlHFvOgC25xnST6La4
         Xb9YfL2MfrVZHdJR0gzlgMWh4t05fAd4Zqx2leFZUpOgAVk3hYffo7ZsTs1yDoNKJETW
         H1Rkr0bsT6M0hlFNiafKOuQ1CABC1w6qA8/67IfBpUxlGJSh4co5FnlGR0GhEAWoQefV
         hEXW8wW5EkMyJKkqGPLbmGc0RC/fPYvq1vnfmYuJMf2PjwD3gUPZYQR6j+IGJ6qAJRld
         Xhf32asLD/UqT3t1RIhDBQbgqMttWFRJr5Qpr6Wq3HHq110X4reZjJmceAHL0lU7a6KO
         HDzg==
X-Gm-Message-State: AOJu0YxjH5an/xuGszR6/neJhCLv/ursXlyABo65sDo+DC9U0/uVbElH
	Vkj/IpjxT7J+BPxtIJqByqRkpeqiGugdRQdfIGkI6oq5ywVoz55T4V8P/v87Mw==
X-Gm-Gg: ASbGncvj3NbHbsJuNl3Tu5M2ATlzHxBxRSE5CXZ1i1fSpoAwt52a5AkAidydFSS+IQV
	YP64Vsli+iv8X+D4AYrfMIJJ/E1orX8+bo5xIc1jRXna5qQchNvQVfDZ383ygezmY0RQi0TPUJ2
	7I1WDhgdk+XKVptvAskG5d5xAwIOqc/t6N7QeHMaaLIbqXAPLvM/nIl3QuNtt5BaC+dsdXRYgrI
	8NP9GWZKlFvp3x4dUndXBRSxt3azhjpPpBaI43CN/YPUjM94ttv6qgPc1dcR/hrDb4TwesmtUZj
	L4KV5Wq+PUU7t0W2jspuaFNZRMatos+0dD4x4zmXB/Rqp2Ovtlqax3YsauByhsbeNb9qkGrtHwL
	Ht6P4hapVSthnAYhrpbglDPIlxKHTN7tSWHtGZahamKwK+IirBBSG
X-Google-Smtp-Source: AGHT+IGSpnSbNeBJOHNiicEVHFuV7EhF2fQDKrwZ4eiva9FnrSo7EgPe0fbSoknqr2NYjNfQY0QAag==
X-Received: by 2002:a05:6000:1a8b:b0:3cb:12e5:ebf7 with SMTP id ffacd0b85a97d-3cb12e5ee9amr8796275f8f.15.1756405725941;
        Thu, 28 Aug 2025 11:28:45 -0700 (PDT)
Received: from localhost (78-131-14-115.pool.digikabel.hu. [78.131.14.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb96ecsm263585f8f.45.2025.08.28.11.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 11:28:45 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:28:33 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] ci: perform build and smoke tests for Meson docs
Message-ID: <aLCf0UaTxy5Nxpv/@szeder.dev>
References: <20250312-b4-pks-ci-meson-docs-v1-1-5e7cf7ac959a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312-b4-pks-ci-meson-docs-v1-1-5e7cf7ac959a@pks.im>

On Wed, Mar 12, 2025 at 03:28:54PM +0100, Patrick Steinhardt wrote:
> Our "documentation" CI job performs a couple of tests against our
> documentation. Part of these tests is to check whether documentation
> builds at all and whether it spits out the expected set of files. We
> don't yet have such a test for Meson, which means that we wouldn't
> notice at all if building the documentation were to break. As a result,
> breakages as fixed by 87eccc3a81d (meson: fix building technical and
> howto docs, 2025-03-02) are easy to go unnoticed.
> 
> Address this test gap by starting to build both manpages and HTML sites
> as part of the CI job.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
> 
> this single patch expands our "documentation" CI job to also start
> building Meson documentation.
> 
> Thanks!
> 
> Patrick
> ---
>  ci/test-documentation.sh | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
> index 6c018b673e0..49f87f50fd7 100755
> --- a/ci/test-documentation.sh
> +++ b/ci/test-documentation.sh
> @@ -15,6 +15,13 @@ filter_log () {
>  	    "$1"
>  }
>  
> +check_docs () {
> +	test -s "$1"/Documentation/git.html &&
> +	test -s "$1"/Documentation/git.xml &&
> +	test -s "$1"/Documentation/git.1 &&
> +	grep "<meta name=\"generator\" content=\"$2 " "$1"/Documentation/git.html
> +}
> +
>  make check-builtins
>  make check-docs
>  
> @@ -23,10 +30,7 @@ make doc > >(tee stdout.log) 2> >(tee stderr.raw >&2)
>  cat stderr.raw
>  filter_log stderr.raw >stderr.log
>  test ! -s stderr.log
> -test -s Documentation/git.html
> -test -s Documentation/git.xml
> -test -s Documentation/git.1
> -grep '<meta name="generator" content="AsciiDoc ' Documentation/git.html
> +check_docs . AsciiDoc
>  
>  rm -f stdout.log stderr.log stderr.raw
>  check_unignored_build_artifacts
> @@ -37,10 +41,21 @@ make USE_ASCIIDOCTOR=1 doc > >(tee stdout.log) 2> >(tee stderr.raw >&2)
>  cat stderr.raw
>  filter_log stderr.raw >stderr.log
>  test ! -s stderr.log
> -test -s Documentation/git.html
> -grep '<meta name="generator" content="Asciidoctor ' Documentation/git.html
> +check_docs . Asciidoctor
>  
>  rm -f stdout.log stderr.log stderr.raw
>  check_unignored_build_artifacts
>  
> +# Build docs with Meson and AsciiDoc
> +meson setup build-asciidoc -Ddocs=html,man -Ddocs_backend=asciidoc
> +meson compile -C build-asciidoc
> +check_docs build-asciidoc AsciiDoc
> +rm -rf build-asciidoc
> +
> +# Build docs with Meson and AsciiDoctor
> +meson setup build-asciidoctor -Ddocs=html,man -Ddocs_backend=asciidoctor
> +meson compile -C build-asciidoctor
> +check_docs build-asciidoctor Asciidoctor
> +rm -rf build-asciidoctor

The documentation CI job should only build the documentation, but
these meson commands unnecessarily compile git as well:

https://github.com/git/git/actions/runs/17222438141/job/48860520663#step:4:4679

  + meson compile -C build-asciidoc
  ninja: Entering directory `/home/runner/work/git/git/build-asciidoc'
  [1/1327] Generating hook-list.h with a custom command
  [2/1327] Generating config-list.h with a custom command
  [3/1327] Generating GIT-VERSION-FILE with a custom command (wrapped by meson to set env)
  [4/1327] Generating command-list.h with a custom command
  [5/1327] Generating version-def.h with a custom command (wrapped by meson to set env)
  [6/1327] Generating Documentation/asciidoc.conf with a custom command (wrapped by meson to set env)
  [7/1327] Generating t/clar-decls.h with a custom command
  [8/1327] Generating Documentation/cmds-ancillaryinterrogators.adoc with a custom command
  [9/1327] Generating Documentation/mergetools-diff.adoc with a custom command (wrapped by meson to set env)
  [10/1327] Compiling C object libcommon-main.a.p/common-main.c.o
  [11/1327] Compiling C object libgit.a.p/alias.c.o
  [12/1327] Compiling C object libgit.a.p/advice.c.o
  [13/1327] Compiling C object libgit.a.p/abspath.c.o

