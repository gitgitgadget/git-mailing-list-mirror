Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDA31E2839
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729548615; cv=none; b=TusKaXlyS7fSiI+HV2mP6zS9OJ+jAMzBv9qd3Gqn5fuYIwNje2B1D999krZlbDaz0PQOhY1BDgC373nxS4zI3+0xJ/xaIQqi8JyHM1vDrD9KVINhkdElR1LJkEAbfQbzFY37Z3Kmwwf+9U3lo9u520sRclUiEgwNC7T1aFmQpt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729548615; c=relaxed/simple;
	bh=mXhHPN6EGl2qFVKEcKkCERdk7OdD4s36nLEaBVrvbBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZmbFEv2KS0befHthf7BgdGfKGNqH4Cejpy8qDd3mSSu8/h4Lbxgde3AtPc32qJCM5y8jAN27JiDnIks+GNl8M1l51mZkyOdTnQoKlLUGiNA7Wk3OooUDEycrcD4fz1EJBYN3G0wGzGJMHZG65kwpwS+14N5Lw2eVvYEkQcPI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=MgyutH5t; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MgyutH5t"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e2975432b8cso5290420276.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729548612; x=1730153412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/duvz2p3dd8aJJbF4VqCAS5FDgvkvsVX1/HtvB1H5gM=;
        b=MgyutH5tM+4B/Mh3dy9lHY96JqqeNHHHJVceYUeBC24OCAmSw/sS8SIILtvK8siMyH
         NDEJFZf5LffnfdpegaLPuR3SbuO7dzdTyuhxx3y7DofyrlsLG7kbDlbnoq6hW9wNwBc3
         DK/6gmzCtJtwmn642gFNPmzWdOOvBsXlq728czFXSACOJxA6W8sB/ZD6CkJQxTNOZz4E
         2q8FL4wKsK/AdZkuUIbhvcp3Cfg0Es0AoJ7SBdZQsoO4N20lJnoQ/7akHXkPs51kyeEH
         Tru2BTNIdqpyS5sK09Eh5wl9hQvl8A6j0PmFyk4gLZmV1UtqUGzTFNq2mNUMWrEmrKVq
         VnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729548612; x=1730153412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/duvz2p3dd8aJJbF4VqCAS5FDgvkvsVX1/HtvB1H5gM=;
        b=Vf7qVTy9meO7G2uGG0jpxTEPB3XHrJbkYGAeOGGfAPiSRFi/kqbOuQURn+4/tCD3f7
         fwoEz0sLUT44cY8+4iTFWkibl2Dnfj5upbb5A3X8Lchu5+C7e0DqbWqAWRrGakN7XY86
         MVsc1UsMycdLtMFdyPE9ssxLh/PHi+ZqEBrmm1EHSBFhpxlwd5Bl/Kcnk5u2rR57Bo1p
         SqHcIgixGnuzjlhX4LLkgW1DtZO+Zd64esSpR8kqOw4Iie5IgN9OTB+8zT/D3Fz9u8pA
         1FpmaiiNunHaIEp3cIbVP9n3R0Xd5FtykXMr3lHwrEDBdvTyMXYv/yh1y1yEeVhzaB1K
         ao1w==
X-Gm-Message-State: AOJu0YzaPdWdjn4eD+ODVQl/VhePKfE0AaHDaP5Kx9gFTeBfMuKKJrnd
	VMVIREyGs1cgG+qQbXQXQcYCBu1tl1bnohFdHJI0G/0cW1hh1EpI8N0lXFm2N04=
X-Google-Smtp-Source: AGHT+IGVyzdvAD553mFqKFDxT7t70nqY2j5DN/QYlOJEOciWUGUym0ui23MJoQ+3diKesfu/JMhEkw==
X-Received: by 2002:a05:690c:fc7:b0:6e3:8760:29ba with SMTP id 00721157ae682-6e7d3b842d2mr14121157b3.36.1729548612241;
        Mon, 21 Oct 2024 15:10:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f59faf22sm8537237b3.1.2024.10.21.15.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 15:10:11 -0700 (PDT)
Date: Mon, 21 Oct 2024 18:10:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v3 00/15] Modernize the build system
Message-ID: <ZxbRQjQQ4TDdaFgl@nand.local>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729254070.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1729254070.git.ps@pks.im>

On Fri, Oct 18, 2024 at 02:23:47PM +0200, Patrick Steinhardt wrote:
> This series is based on 15030f9556 (The second batch, 2024-10-15) and
> has the following dependencies:
>
>   - ps/cmake-clar at c6d3e52c91 (cmake: set up proper
>     dependencies for generated clar headers, 2024-10-15).
>
>   - ps/upgrade-clar at f3501edb0e (Makefile: adjust sed command for
>     generating "clar-decls.h", 2024-10-14).
>
>   - ps/platform-compat-fixes at 80ebd91b83 (http: fix build error on
>     FreeBSD, 2024-10-16).

While this is still sitting on my review queue, I rebuilt this topic
based on the above (extremely helpful) information, but it seems to
produce some conflicts when I try to merge it in at the end of 'seen':

--- 8< ---
diff --cc Makefile
index 2c1afd08cb,a93aeb3bc8..0000000000
--- a/Makefile
+++ b/Makefile
@@@ -3932,10 -3859,9 +3886,18 @@@ GIT-TEST-SUITES: FORC
              fi

  $(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUITES)) GIT-TEST-SUITES
++<<<<<<< HEAD
 +	$(QUIET_GEN)$(SHELL_PATH) $(UNIT_TEST_DIR)/generate-clar-decls.sh "$@" $(filter %.c,$^)
++||||||| merged common ancestors
++	$(QUIET_GEN)for suite in $(CLAR_TEST_SUITES); do \
++		sed -ne "s/^\(void test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$$\)/extern \1;/p" $(UNIT_TEST_DIR)/$$suite.c; \
++	done >$@
++=======
+ 	$(QUIET_GEN)$(SHELL_PATH) $(UNIT_TEST_DIR)/generate-clar-decls.sh "$@" $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUITES))
++>>>>>>> ps/build
  $(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
  	$(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/clar-generate.awk $< >$(UNIT_TEST_DIR)/clar.suite
 +$(UNIT_TEST_DIR)/clar/clar.o: $(UNIT_TEST_DIR)/clar.suite
  $(CLAR_TEST_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
  $(CLAR_TEST_OBJS): EXTRA_CPPFLAGS = -I$(UNIT_TEST_DIR)
  $(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-LDFLAGS
diff --cc t/unit-tests/clar/clar.c
index d54e455367,64879cf2bd..0000000000
--- a/t/unit-tests/clar/clar.c
+++ b/t/unit-tests/clar/clar.c
@@@ -812,9 -801,8 +812,17 @@@ void clar__assert_equal
  			}
  		}
  	}
++<<<<<<< HEAD
 +#endif /* CLAR_HAVE_WCHAR */
  	else if (!strcmp("%"PRIuMAX, fmt) || !strcmp("%"PRIxMAX, fmt)) {
  		uintmax_t sz1 = va_arg(args, uintmax_t), sz2 = va_arg(args, uintmax_t);
++||||||| merged common ancestors
++	else if (!strcmp("%"PRIuZ, fmt) || !strcmp("%"PRIxZ, fmt)) {
++		size_t sz1 = va_arg(args, size_t), sz2 = va_arg(args, size_t);
++=======
++	else if (!strcmp("%"PRIuMAX, fmt) || !strcmp("%"PRIxMAX, fmt)) {
++		uintmax_t sz1 = va_arg(args, uintmax_t), sz2 = va_arg(args, uintmax_t);
++>>>>>>> ps/build
  		is_equal = (sz1 == sz2);
  		if (!is_equal) {
  			int offset = p_snprintf(buf, sizeof(buf), fmt, sz1);
diff --cc t/unit-tests/generate-clar-decls.sh
index 688e0885f4,81da732917..0000000000
--- a/t/unit-tests/generate-clar-decls.sh
+++ b/t/unit-tests/generate-clar-decls.sh
@@@ -1,16 -1,16 +1,36 @@@
++<<<<<<< HEAD
 +#!/bin/sh
 +
 +if test $# -lt 2
 +then
 +	echo "USAGE: $0 <OUTPUT> <SUITE>..." 2>&1
 +	exit 1
 +fi
 +
 +OUTPUT="$1"
 +shift
 +
 +for suite in "$@"
 +do
 +	sed -ne "s/^\(void test_$(basename "${suite%.c}")__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)\)$/extern \1;/p" "$suite" ||
 +	exit 1
 +done >"$OUTPUT"
++||||||| merged common ancestors
++=======
+ #!/bin/sh
+
+ if test $# -lt 2
+ then
+ 	echo "USAGE: $0 <OUTPUT> <SUITE>..." 2>&1
+ 	exit 1
+ fi
+
+ OUTPUT="$1"
+ shift
+
+ for suite in "$@"
+ do
+ 	sed -ne "s/^\(void test_$suite__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$\)/extern \1;/p" "$suite" ||
+ 	exit 1
+ done >"$OUTPUT"
++>>>>>>> ps/build
--- >8 ---

Thanks,
Taylor
