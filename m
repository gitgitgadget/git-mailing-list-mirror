Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21A81ADC98
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736852607; cv=none; b=PbScxIRsOb+V+w8zrJZW6415CY9YXClnAe+v4OHTJ8DBVeX8i3+seAH1e9Q97r9Lh1xfgqtcsOFZCT0Bf6/YrYCvff91KqiQr5CnAg7D8Fucn8M3BV++F720wII2JsE0uSBR+tQF4X8ii2RaJNv84PDhXzdCo1QAQGGSQgLt6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736852607; c=relaxed/simple;
	bh=naUb+zT3IEIu/yI51OryUG/CCqZiOsgaNuzPs9nkzdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pysCyWnubb7Tcjn1eprIN4420cL3SENJAcZgb+FvcYGcXlksmqWtU0iGtHzGm/Xbb7PL3Bv3VIOxDnMJQ9Q18Zxa3ehkOrEKi7hIR+m1BnRk/V3tvL9PEQwQ9NzSZfIyjze77vq9RZmK8MU6yRcXE5toqJ+14zC3ntLkb5wvS7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VrWGdNtJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VrWGdNtJ"
Received: (qmail 27844 invoked by uid 109); 14 Jan 2025 11:03:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=naUb+zT3IEIu/yI51OryUG/CCqZiOsgaNuzPs9nkzdE=; b=VrWGdNtJiSK9n/TWhXLLbkHahUPHq4g9p13u9bRwX/m+aj+MOE5hG6/NOFFdj/+cKCuQ9QLdaaFdwjUWws/selShZEjn9oOX82BGrijANKSAW7tnOU+/eH2rFfA9bIdnjESX1q2r4A6NRHNMoSH+rYCb7TIp7kO2459jkGaochy8Do2LnXBhTfwEGDqxF4jiKUd92GtX05ODgLytcetXN9dMjRORCkO//CwVXb524lomzJqxV2W5KIXZqayZ6xuUVNWtEVoeHLrEan2s0i0jzV2WunFthXv7PKMR5Why46AK6e6Jn7unvWHPE/1po2ZNBaFSn10wqRu6VScPSU63qw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Jan 2025 11:03:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5622 invoked by uid 111); 14 Jan 2025 11:03:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jan 2025 06:03:29 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Jan 2025 06:03:23 -0500
From: Jeff King <peff@peff.net>
To: Josh Steadmon <steadmon@google.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	James Mills <prologic@shortcircuit.net.au>
Subject: Re: Git v2.46.0 and --allow-multiple-definition linker flag
Message-ID: <20250114110323.GD882468@coredump.intra.peff.net>
References: <CALGqR9+bH3nMrGqPQ18aqs-epSHRFQOtnd6Da55=KrtSu+Jrkg@mail.gmail.com>
 <xmqqbjx4bgae.fsf@gitster.g>
 <xmqq7c7sbfhi.fsf@gitster.g>
 <egtxf4f3dufiz56g276lt4qtediarj5kkuqbv222edrwcgf5dk@ocnbky74w3tv>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <egtxf4f3dufiz56g276lt4qtediarj5kkuqbv222edrwcgf5dk@ocnbky74w3tv>

On Mon, Jan 13, 2025 at 09:54:07AM -0800, Josh Steadmon wrote:

> As Junio says, a short term fix would be to build with
> LINK_FUZZ_PROGRAMS="". A better solution would be to make
> config.mak.uname smarter about whether to enable this by default. I see
> that we use "detect-compiler" in config.mak.dev, would it make sense to
> check this in config.mak.uname as well?

It feels like the original sin here is defining main() in our library in
the first place, if there are programs that may not want it. But we
don't actually put it into libgit.a; the object file is just mentioned
in the $(GITLIBS) variable of the Makefile.

We could split that out like this:

diff --git a/Makefile b/Makefile
index 97e8385b66..f098ca5a5c 100644
--- a/Makefile
+++ b/Makefile
@@ -1371,7 +1371,8 @@ UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
 
 # xdiff and reftable libs may in turn depend on what is in libgit.a
-GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
+GITLIBS = $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
+PROGRAM_GITLIBS = common-main.o $(GITLIBS)
 EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)

and then depend on $(PROGRAM_GITLIBS) as appropriate. Or if oss-fuzz is
the only special case here, then perhaps we could just teach it to
suppress the extra main:

diff --git a/Makefile b/Makefile
index 97e8385b66..06431170de 100644
--- a/Makefile
+++ b/Makefile
@@ -3852,9 +3852,8 @@ FUZZ_CXXFLAGS ?= $(ALL_CFLAGS)
 .PHONY: fuzz-all
 fuzz-all: $(FUZZ_PROGRAMS)
 
-$(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAGS
+$(FUZZ_PROGRAMS): %: %.o $(filter-out common-main.o,$(GITLIBS)) GIT-LDFLAGS
 	$(QUIET_LINK)$(FUZZ_CXX) $(FUZZ_CXXFLAGS) -o $@ $(ALL_LDFLAGS) \
-		-Wl,--allow-multiple-definition \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS) $(LIB_FUZZING_ENGINE)
 
 $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_OBJS) \

You'd need two fixes to go with that:

  1. common-main was originally supposed to just be about overriding
     main(). But it has since grown common_exit(), which does not have
     the same linking properties (we override exit() calls at the macro
     layer instead). That should be defined in libgit.a somewhere.

  2. When building the test-compile fuzzers, now you'll need to
     provide an actual main() function. I guess we can determine that by
     the presence of LIB_FUZZING_ENGINE? So maybe:

diff --git a/Makefile b/Makefile
index 97e8385b66..ba3faf9b9e 100644
--- a/Makefile
+++ b/Makefile
@@ -3852,9 +3852,15 @@ FUZZ_CXXFLAGS ?= $(ALL_CFLAGS)
 .PHONY: fuzz-all
 fuzz-all: $(FUZZ_PROGRAMS)
 
-$(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAGS
+ifdef LIB_FUZZING_ENGINE
+# assume the fuzzing engine supplies main()
+FUZZ_GITLIBS = $(filter-out common-main.o, $(GITLIBS))
+else
+FUZZ_GITLIBS = oss-fuzz/dummy-cmd-main.o $(GITLIBS)
+endif
+
+$(FUZZ_PROGRAMS): %: %.o $(FUZZ_GITLIBS) GIT-LDFLAGS
 	$(QUIET_LINK)$(FUZZ_CXX) $(FUZZ_CXXFLAGS) -o $@ $(ALL_LDFLAGS) \
-		-Wl,--allow-multiple-definition \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS) $(LIB_FUZZING_ENGINE)
 
 $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_OBJS) \

-Peff
