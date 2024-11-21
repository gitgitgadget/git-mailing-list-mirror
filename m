Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFE5148FE8
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732221107; cv=none; b=Sr1929RxXmwvJzBFgQ09dn6GSfka3UEcWfbsvLTj8iTge7trEzvW3PSYQ0WH9nQgnoeYezJPLut1Fy3kb5dwekM8IQFNIPBNS8XZYD3lZoJipL1HAqbrAJMXvI7ySCIEvGkfzZ0OH9d4beoNNg9gdkljh3I5JhmQhtDaEL4QDwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732221107; c=relaxed/simple;
	bh=lT87QLTQifXok595ALvg7Ck2DgHhucHjr2mhJsvVlfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzX7BnnG/d/V8jb7ifQgj4DG926OOHmP6Pg+sXBn31Y34l52vHvFj6zFmUiHbyqJKRbZn51Q98IwqfqdUrHqsynPdtHlJ6etSkJJTlrRpVHwrVRFmHigEnQUWQZQ6IGrJN87ZsziT9mRmou7E7jnDvMTAl9YL1+UJIscxDMQHgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=bOfok8FV; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="bOfok8FV"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e377e4aea3so10084567b3.3
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 12:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732221104; x=1732825904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fo0mPy1VLrVPcV9GbJUnw6sQEAclOTnWy6IXV7+sCPk=;
        b=bOfok8FV9aKGSEISKwYXZGYJhBwiRTutn8LTEY25D0IA3o0EvR/iLYdHU8DXfse7su
         4CnG7j04TwZUWfR4pdFVQfJqaQ6LPRPn7cBaPkufIIomqXH3X9N6azcv9UUPkSGkfsxG
         KeibVPQjGwUa2yXkuV1t5UUJiwgvQo8pxENubWByW3F8Dxzq3Ed0ACgmEx9EGYeuqPDr
         QGPXSw1ZP4WxCvTvgXvC9/7qXj19sjQ+PaNliAt5bGBy3ZS5vnRwHx59HwSaDwAo5S7d
         RBn9Md+iHhJydKQRaByh8S9MIHg5n1grnPtnIpeAH5CnLifVpdlz/2Gt6ze6pB6gb+1u
         RGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732221104; x=1732825904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fo0mPy1VLrVPcV9GbJUnw6sQEAclOTnWy6IXV7+sCPk=;
        b=hHZkKLsDavyTBj2YN0ckD+vHFBanG7JESEEzlr8nq64ynuYWG2LCdtiowrUPFGqAGY
         QTecMQ/w5sT/bGqEBWJNzqbHUT6QxefBZ9sSoyYLV0P1LDkEmA7OjDxyWdM5xpTTFCL0
         X3bQXW7KlVJKcRko0Fo7UYCmY0tPLGwXz38MFE6TI0V78vZdXQ4VRw+0M+NpTxoMNOyZ
         BFWmCfWBsQ+9RO4gUTfdhZBhwyRhj10+MHAnXDWTNdDYx1pj/kdAuZohsIfgxQjyeyj8
         DDnmNfYSsX8fYXtRCU8lhm8CT+sEK4qYb4+zmimiQ706rwrlF5qAdqCm21Ap6T00vU3H
         0N3Q==
X-Gm-Message-State: AOJu0YwIzgo/igqnnM7+YQhXCDjbMNIHgoTCs6louIu1DVjlO2uz2RVD
	6Ht/AypzpKWSpciB1TMkS3BogYFOV5E3oolFwGTbvWaZVo8ZHUiFKbUCZv5SxIo=
X-Gm-Gg: ASbGncveVTX2MCE6uiM6TW+TjR6puVL5VfUOKzw+bkBpnI6AsHqXyYW883chU5WJuZA
	58S8K3KQ6BjYy1qNjvO1pBkTcoTqidILopsJ5q1cT7CLPAoaQ+V3wBMP/8/W/YJzu9FjwXiH3y6
	rRGLXiae8gfuf3N6M3SdBWP0A0ShDxaRwDxwo9a272xTvhq3lDarDynDfw+LZCM+JVhOp9L9QCs
	4783xk0YxdA7cX6klt1fcAKLkA0lRXeAR40Av21Hl0rRJTLms40Q5usenumYtUteiTMFfiIWhqh
	rxd4gv9Isi4bSioKUduYzQ==
X-Google-Smtp-Source: AGHT+IGhzwF63zr23gYEHpb5PBDgak9bn1HblEhKZ84LKLE7SEw/EXQ7D79UEbsQZv1sjol4/PSBOQ==
X-Received: by 2002:a05:690c:4d83:b0:6e2:2c72:3aaf with SMTP id 00721157ae682-6eee0a26cdcmr7852037b3.31.1732221104447;
        Thu, 21 Nov 2024 12:31:44 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eedfe2bf82sm1167477b3.46.2024.11.21.12.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:31:44 -0800 (PST)
Date: Thu, 21 Nov 2024 15:31:42 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 5/7] p5313: add size comparison test
Message-ID: <Zz+YrvL8h0Cxwqfy@nand.local>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <c14ef6879e451401381ebbdb8f30d33c8f56c25b.1730775908.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c14ef6879e451401381ebbdb8f30d33c8f56c25b.1730775908.git.gitgitgadget@gmail.com>

On Tue, Nov 05, 2024 at 03:05:05AM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
> As custom options are added to 'git pack-objects' and 'git repack' to
> adjust how compression is done, use this new performance test script to
> demonstrate their effectiveness in performance and size.

Nicely done, thank you for adding a perf test to allow readers to easily
verify these changes themselves.

> In the case of the Git repository, these numbers show some of the issues
> with this approach:
>
> [...]
>
> The thin pack that simulates a push is much worse with --full-name-hash
> in this case. The name hash values are doing a lot to assist with delta
> bases, it seems. The big pack and shallow clone cases are slightly worse
> with the --full-name-hash option. Only the full repack gains some
> benefits in size.

Not a problem with your patch, but just thinking aloud: do you think
there is an easy/straightforward way to suggest when to use
--full-name-hash or not?

> ---
>  t/perf/p5313-pack-objects.sh | 94 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100755 t/perf/p5313-pack-objects.sh
>
> diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
> new file mode 100755
> index 00000000000..dfa29695315
> --- /dev/null
> +++ b/t/perf/p5313-pack-objects.sh
> @@ -0,0 +1,94 @@
> +#!/bin/sh
> +
> +test_description='Tests pack performance using bitmaps'
> +. ./perf-lib.sh
> +
> +GIT_TEST_PASSING_SANITIZE_LEAK=0
> +export GIT_TEST_PASSING_SANITIZE_LEAK
> +
> +test_perf_large_repo
> +
> +test_expect_success 'create rev input' '
> +	cat >in-thin <<-EOF &&
> +	$(git rev-parse HEAD)
> +	^$(git rev-parse HEAD~1)
> +	EOF
> +
> +	cat >in-big <<-EOF &&
> +	$(git rev-parse HEAD)
> +	^$(git rev-parse HEAD~1000)
> +	EOF
> +
> +	cat >in-shallow <<-EOF
> +	$(git rev-parse HEAD)
> +	--shallow $(git rev-parse HEAD)
> +	EOF
> +'

I was going to comment that these could probably be moved into the
individual perf test that cares about reading each of these inputs. But
having them shared here makes sense since we are naturally comparing
generating two packs with the same input (with and without
--full-name-hash). So the shared setup here makes sense to me.

> +
> +test_perf 'thin pack' '
> +	git pack-objects --thin --stdout --revs --sparse  <in-thin >out
> +'
> +
> +test_size 'thin pack size' '
> +	test_file_size out
> +'

Nice. I always forget about this and end up writing 'wc -c <out'.

> +test_perf 'thin pack with --full-name-hash' '
> +	git pack-objects --thin --stdout --revs --sparse --full-name-hash <in-thin >out
> +'
> +
> +test_size 'thin pack size with --full-name-hash' '
> +	test_file_size out
> +'
> +
> +test_perf 'big pack' '
> +	git pack-objects --stdout --revs --sparse  <in-big >out
> +'
> +
> +test_size 'big pack size' '
> +	test_file_size out
> +'
> +
> +test_perf 'big pack with --full-name-hash' '
> +	git pack-objects --stdout --revs --sparse --full-name-hash <in-big >out
> +'
> +
> +test_size 'big pack size with --full-name-hash' '
> +	test_file_size out
> +'
> +
> +test_perf 'shallow fetch pack' '
> +	git pack-objects --stdout --revs --sparse --shallow <in-shallow >out
> +'
> +
> +test_size 'shallow pack size' '
> +	test_file_size out
> +'
> +
> +test_perf 'shallow pack with --full-name-hash' '
> +	git pack-objects --stdout --revs --sparse --shallow --full-name-hash <in-shallow >out
> +'
> +
> +test_size 'shallow pack size with --full-name-hash' '
> +	test_file_size out
> +'
> +
> +test_perf 'repack' '
> +	git repack -adf
> +'
> +
> +test_size 'repack size' '
> +	pack=$(ls .git/objects/pack/pack-*.pack) &&
> +	test_file_size "$pack"

Here and below, I think it's fine to inline this as in:

    test_file_size "$(ls .git/objects/pack/pack-*.pack)"

...but I wonder: will using ".git" break this test in bare repositories?
Should we write instead:

    pack="$(ls $(git rev-parse --git-dir)/objects/pack/pack-*.pack)" &&
    test_file_size

?

Thanks,
Taylor
