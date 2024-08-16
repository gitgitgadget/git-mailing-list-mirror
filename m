Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBA91BB684
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815461; cv=none; b=sTu3ZQnvvNWAGRBgIgeO9X1RPwk/3g8nf9U/RKlh4jYvpK2bOg3Qk+smhLPzWPRRuKo+QnwqJyg2CAgSEb1bB2gtDiTasWPvXrFNjuvVE9HrNWPfHJe9ks8fgW0UIQ01krCISGg9fYbWJAny8vzMpsVOGhg6FMkRxYlXNvOcrdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815461; c=relaxed/simple;
	bh=AArEWRYvUlT51YANMJ4odUWE38yCyJYwmVne14FsRKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDNklVeuvqEmEkQrWKPE+oOjLT5k9A3tJfb4vETStk9gtLLRunfwwpseJiOTf+OA3gDgiuET12msGfoBj8cIu7oiNghErlqj3KnxR4JhfAqKGHN1/XFfLp+2G0Hu7UVvX545iV2U6FRWvLQ6TU83RyPnGB3Tx6Gtn5vgI73c6Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUe0P4aR; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUe0P4aR"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4281faefea9so13957905e9.2
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723815457; x=1724420257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=49h73pL7HvH1GK3XHzJCfI07ExKiRFAYSGwNcvv/pN8=;
        b=CUe0P4aRaZKIgUIqm8w0SC2a4JSAwybk1M4D/DVh0ta4e22Xt0UKtXKJIP1GGr/DSu
         h8BgUH9yTy0/zrNONDVa3XwgX+eadbf4EWlElHiMwP3K7CeQFUKUmVB7B/JIYC4UCUw8
         Sddx2OuLdGANW58gL6sSx1q87B8VuwQ8qfkGHCnFPsOgOGS0jh4Mot53BGpZX0FvsjP9
         l6A9Rz2IntyWbvO3K8TQgM/7EtG3GMifBvNKTmAGTNAo9E6oAuByikjw7oMJk3BJFc9D
         ZmoWfUR7fuLa6QZ8y8SweMhKGYt+mcjW9JlbiMyKP/DuNodZErQ2cN+c0AuRpBttN3YI
         T18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723815457; x=1724420257;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49h73pL7HvH1GK3XHzJCfI07ExKiRFAYSGwNcvv/pN8=;
        b=SwzNZ4XP32N6z6Ta2N5yqWcUTIWQxrkfkRoRt8hCUZPUNOWn3NqrQToMgEzqljNKQi
         C/iHd4FXLVlrTer+8Sa/iDEw1tIJq3UzAhNL/FN5tXcUpL0k+g2y9HU9q6F76AhnpQax
         8gRvUgvs3S6GMowx+ZNxM3Qq7EupJnqOIiBpNx7JBluV4qpYQ3wuXVwzm2CXEYFCAXD/
         AnPH7EvWoDTJDA81HM2m7xlidBt9riqoIGr/4D6ncmjJQ46OVZlkgf17hmRd4UoE1WWp
         jYRup0hOAMFTVF45MZc5iJzVO2USpFzx19l775VkTBID/aohJEhR1JVLh8Fvpezast+9
         pr1g==
X-Forwarded-Encrypted: i=1; AJvYcCV9at8zqEaRFVWDM0uwHL2JzOGkYiU7FjFBoW4Cwd0pih3QxoN15DCeKbZVOveiTMfsNOhgcefhuLfNdICpUf9/msTX
X-Gm-Message-State: AOJu0YyZPN+StNLTxJuqC3XWDF+3WhePbXXtkN01NGFgsS6ezHpZnylN
	HBb8o8pWKMBvdpUQj4hjuo4c9jrP0+IDbj+yTO16OY9RYUJ6jZ/WXIlpig==
X-Google-Smtp-Source: AGHT+IGfa7dK8sJsD0GDNrDyEpWHyIo1/k/R9RucaOf7WLr1gvkl/5z7i+pg/4UiMbCq9JMFLctPZQ==
X-Received: by 2002:a05:600c:474e:b0:427:fa39:b0a1 with SMTP id 5b1f17b1804b1-429ed7d3578mr16574015e9.36.1723815456366;
        Fri, 16 Aug 2024 06:37:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69b:eb01:545f:b423:671d:5e99? ([2a0a:ef40:69b:eb01:545f:b423:671d:5e99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985a354sm3656581f8f.51.2024.08.16.06.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 06:37:36 -0700 (PDT)
Message-ID: <b87700d2-0c9a-4d0c-9ee4-e6a91278d596@gmail.com>
Date: Fri, 16 Aug 2024 14:37:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/9] Introduce clar testing framework
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
 Edward Thomson <ethomson@edwardthomson.com>
References: <cover.1722415748.git.ps@pks.im> <cover.1723791831.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <cover.1723791831.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 16/08/2024 08:04, Patrick Steinhardt wrote:
> Hi,
> 
> this is the fifth version of my patch series that introduces the clar
> testing framework for our unit tests.

Thanks for working on this, I'm broadly in favor of this change. I
like the way it keeps each test as a function and adds automatic test
registration with support for setup and teardown functions. I am keen
though to keep an emphasis on good diagnostic messages when tests
fail. Looking at the conversions in this series all of the test_msg()
lines that provide useful debugging context are removed. I'm not sure
using yaml to report errors rather than human readable messages is an
improvement either.

I wonder if we want to either improve the assertions offered by clar
or write our own. I find the names of the cl_assert_equal_?()
functions are a bit cumbersome. The aim of the check_* names was to
try and be both concise and descriptive. Adding our own check_* macros
on top of clar would also make it easier to port our existing tests.

Here are some thought having read through the assertion and error
reporting code:

  - As I think you've pointed out elsewhere there are no equivalents
    for check_int(a, <|<=|>|>=, b) so we're forced to use cl_assert()
    and forego the better diagnostic messages that come from a
    dedicated comparison macro. We should fix this as a priority.

  - cl_assert_equal_i() casts its arguments to int whereas check_int()
    and check_uint() are careful to avoid truncation and keep the
    original signedness (if that's a word). I think that's unlikely to
    be a problem with our current test but could trip us up in the
    future.

  - cl_assert_equal_s() prints each argument as-is. This means
    that it passes NULL arguments through to snprintf() which is
    undefined according to the C standard. Compare this to check_str()
    that is NULL safe and is careful to escape control characters and
    add delimiters to the beginning and end of the string to make it
    obvious when a string contains leading or trailing whitespace.

  - The cl_assert_equal_?() macros lack type safety for the arguments
    being compared as they are wrappers around a variadic function.
    That could be fixed by having each macros wrap a dedicated
    function that wraps clar__fail().

  - There is no equivalent of test_todo() to mark assertions that are
    expected to fail. We're not using that yet in our tests but our
    experience with the integration tests suggests that we are likely
    to want this in the future.

  - To me the "sandbox" feature is mis-named as it does not provide any
    confinement. It is instead a useful mechanism for running a test in
    a temporary directory created from a template.

  - There are no checks for failing memory allocations - the return
    value of calloc() and strdup() are used without checking for NULL.

  - The use of longjmp is a bit of a double edged sword as it makes it
    easy to leak resources on test failures.

Best Wishes

Phillip

> Changes compared to v4:
> 
>    - The whitespace fixes have been merged upstream, so I've updated the
>      embedded copy of clar and dropped the subsequent patch that fixed
>      them in our copy. The NonStop compatibility fixes have not yet been
>      merged as the pull request needs some more work.
> 
>    - Both "clar-decls.h" and "clar.suite" are now part of GENERATED_H.
>      This brings removal of these files via "make clean" for free.
> 
>    - The "sparse" target already depends on GENERATED_H, but in a broken
>      way. I've fixed that in a new commit.
> 
>    - The "sparse" target no longer checks external sources, including the
>      clar sources.
> 
>    - The "hdr-check" target now depends on GENERATED_H, as well. This
>      avoids having to manually wire up dependencies on generated headers
>      per file, which seems rather unmaintainable to me.
> 
> With this, the "hdr-check" and "sparse" targets all work on my machine
> now.
> 
> Thanks!
> 
> Patrick
> 
> Patrick Steinhardt (9):
>    t: do not pass GIT_TEST_OPTS to unit tests with prove
>    t: import the clar unit testing framework
>    t/clar: fix compatibility with NonStop
>    Makefile: fix sparse dependency on GENERATED_H
>    Makefile: make hdr-check depend on generated headers
>    Makefile: do not use sparse on third-party sources
>    Makefile: wire up the clar unit testing framework
>    t/unit-tests: convert strvec tests to use clar
>    t/unit-tests: convert ctype tests to use clar
> 
>   .gitignore                                 |   1 +
>   Documentation/technical/unit-tests.txt     |   2 +
>   Makefile                                   |  53 +-
>   t/Makefile                                 |   4 +-
>   t/run-test.sh                              |   2 +-
>   t/unit-tests/.gitignore                    |   2 +
>   t/unit-tests/clar-generate.awk             |  50 ++
>   t/unit-tests/clar/.github/workflows/ci.yml |  23 +
>   t/unit-tests/clar/COPYING                  |  15 +
>   t/unit-tests/clar/README.md                | 329 ++++++++
>   t/unit-tests/clar/clar.c                   | 842 +++++++++++++++++++++
>   t/unit-tests/clar/clar.h                   | 173 +++++
>   t/unit-tests/clar/clar/fixtures.h          |  50 ++
>   t/unit-tests/clar/clar/fs.h                | 522 +++++++++++++
>   t/unit-tests/clar/clar/print.h             | 211 ++++++
>   t/unit-tests/clar/clar/sandbox.h           | 159 ++++
>   t/unit-tests/clar/clar/summary.h           | 143 ++++
>   t/unit-tests/clar/generate.py              | 266 +++++++
>   t/unit-tests/clar/test/.gitignore          |   4 +
>   t/unit-tests/clar/test/Makefile            |  39 +
>   t/unit-tests/clar/test/clar_test.h         |  16 +
>   t/unit-tests/clar/test/main.c              |  40 +
>   t/unit-tests/clar/test/main.c.sample       |  27 +
>   t/unit-tests/clar/test/resources/test/file |   1 +
>   t/unit-tests/clar/test/sample.c            |  84 ++
>   t/unit-tests/{t-ctype.c => ctype.c}        |  71 +-
>   t/unit-tests/{t-strvec.c => strvec.c}      | 119 ++-
>   t/unit-tests/unit-test.c                   |  17 +
>   t/unit-tests/unit-test.h                   |   3 +
>   29 files changed, 3166 insertions(+), 102 deletions(-)
>   create mode 100644 t/unit-tests/clar-generate.awk
>   create mode 100644 t/unit-tests/clar/.github/workflows/ci.yml
>   create mode 100644 t/unit-tests/clar/COPYING
>   create mode 100644 t/unit-tests/clar/README.md
>   create mode 100644 t/unit-tests/clar/clar.c
>   create mode 100644 t/unit-tests/clar/clar.h
>   create mode 100644 t/unit-tests/clar/clar/fixtures.h
>   create mode 100644 t/unit-tests/clar/clar/fs.h
>   create mode 100644 t/unit-tests/clar/clar/print.h
>   create mode 100644 t/unit-tests/clar/clar/sandbox.h
>   create mode 100644 t/unit-tests/clar/clar/summary.h
>   create mode 100755 t/unit-tests/clar/generate.py
>   create mode 100644 t/unit-tests/clar/test/.gitignore
>   create mode 100644 t/unit-tests/clar/test/Makefile
>   create mode 100644 t/unit-tests/clar/test/clar_test.h
>   create mode 100644 t/unit-tests/clar/test/main.c
>   create mode 100644 t/unit-tests/clar/test/main.c.sample
>   create mode 100644 t/unit-tests/clar/test/resources/test/file
>   create mode 100644 t/unit-tests/clar/test/sample.c
>   rename t/unit-tests/{t-ctype.c => ctype.c} (71%)
>   rename t/unit-tests/{t-strvec.c => strvec.c} (54%)
>   create mode 100644 t/unit-tests/unit-test.c
>   create mode 100644 t/unit-tests/unit-test.h
> 
> Range-diff against v4:
>   1:  086dd728a7 !  1:  832dc0496f t: do not pass GIT_TEST_OPTS to unit tests with prove
>      @@ Commit message
>           environment variable. Like this, we can conditionally forward it to our
>           test scripts, only.
>       
>      +    Signed-off-by: Patrick Steinhardt <ps@pks.im>
>      +
>        ## t/Makefile ##
>       @@ t/Makefile: failed:
>        	test -z "$$failed" || $(MAKE) $$failed
>   2:  5c22e0b3b9 !  2:  3690607933 t: import the clar unit testing framework
>      @@ Metadata
>        ## Commit message ##
>           t: import the clar unit testing framework
>       
>      -    Import the clar unit testing framework at commit faa8419 (Merge pull
>      -    request #93 from clar-test/ethomson/fixtures, 2023-12-14). The framework
>      +    Import the clar unit testing framework at commit 1516124 (Merge pull
>      +    request #97 from pks-t/pks-whitespace-fixes, 2024-08-15). The framework
>           will be wired up in subsequent commits.
>       
>           Signed-off-by: Patrick Steinhardt <ps@pks.im>
>      @@ t/unit-tests/clar/clar/fs.h (new)
>       +			ERROR_PATH_NOT_FOUND == last_error)
>       +			return 0;
>       +
>      -+		Sleep(RM_RETRY_DELAY * retries * retries);	
>      ++		Sleep(RM_RETRY_DELAY * retries * retries);
>       +	}
>       +	while (retries++ <= RM_RETRY_COUNT);
>       +
>      @@ t/unit-tests/clar/clar/sandbox.h (new)
>       +	static const size_t var_count = 5;
>       +	static const char *env_vars[] = {
>       +		"CLAR_TMP", "TMPDIR", "TMP", "TEMP", "USERPROFILE"
>      -+ 	};
>      ++	};
>       +
>      -+ 	size_t i;
>      ++	size_t i;
>       +
>       +	for (i = 0; i < var_count; ++i) {
>       +		const char *env = getenv(env_vars[i]);
>      @@ t/unit-tests/clar/clar/sandbox.h (new)
>       +{
>       +	return _clar_path;
>       +}
>      -+
>       
>        ## t/unit-tests/clar/clar/summary.h (new) ##
>       @@
>      @@ t/unit-tests/clar/generate.py (new)
>       +    suite.disable(options.excluded)
>       +    if suite.write():
>       +        print("Written `clar.suite` (%d tests in %d suites)" % (suite.callback_count(), suite.suite_count()))
>      -+
>       
>        ## t/unit-tests/clar/test/.gitignore (new) ##
>       @@
>      @@ t/unit-tests/clar/test/.gitignore (new)
>       +.clarcache
>       +clar_test
>       +*.o
>      -+
>       
>        ## t/unit-tests/clar/test/Makefile (new) ##
>       @@
>   4:  75e097dfa4 =  3:  db53673294 t/clar: fix compatibility with NonStop
>   3:  e0f99874cc !  4:  b6199c88dd t/clar: fix whitespace errors
>      @@ Metadata
>       Author: Patrick Steinhardt <ps@pks.im>
>       
>        ## Commit message ##
>      -    t/clar: fix whitespace errors
>      -
>      -    Fix whitespace errors in the clar that make git-apply(1) unhappy. This
>      -    has been cherry-picked from the upstream pull request at [1].
>      -
>      -    [1]: https://github.com/clar-test/clar/pull/97
>      +    Makefile: fix sparse dependency on GENERATED_H
>      +
>      +    The "check" Makefile target is essentially an alias around the "sparse"
>      +    target. The one difference though is that it will tell users to instead
>      +    run the "test" target in case they do not have sparse(1) installed, as
>      +    chances are high that they wanted to execute the test suite rather than
>      +    doing semantic checks.
>      +
>      +    But even though the "check" target ultimately just ends up executing
>      +    `make sparse`, it still depends on our generated headers. This does not
>      +    make any sense though: they are irrelevant for the "test" target advice,
>      +    and if these headers are required for the "sparse" target they must be
>      +    declared as a dependency on the aliased target, not the alias.
>      +
>      +    But even moving the dependency to the "sparse" target is wrong, as
>      +    concurrent builds may then end up generating the headers and running
>      +    sparse concurrently. Instead, we make them a dependency of the specific
>      +    objects. While that is overly broad, it does ensure correct ordering.
>      +    The alternative, specifying which file depends on what generated header
>      +    explicitly, feels rather unmaintainable.
>       
>           Signed-off-by: Patrick Steinhardt <ps@pks.im>
>       
>      - ## t/unit-tests/clar/clar/fs.h ##
>      -@@ t/unit-tests/clar/clar/fs.h: fs_rm_wait(WCHAR *_wpath)
>      - 			ERROR_PATH_NOT_FOUND == last_error)
>      - 			return 0;
>      -
>      --		Sleep(RM_RETRY_DELAY * retries * retries);	
>      -+		Sleep(RM_RETRY_DELAY * retries * retries);
>      - 	}
>      - 	while (retries++ <= RM_RETRY_COUNT);
>      + ## Makefile ##
>      +@@ Makefile: check-sha1:: t/helper/test-tool$X
>        
>      -
>      - ## t/unit-tests/clar/clar/sandbox.h ##
>      -@@ t/unit-tests/clar/clar/sandbox.h: find_tmp_path(char *buffer, size_t length)
>      - 	static const size_t var_count = 5;
>      - 	static const char *env_vars[] = {
>      - 		"CLAR_TMP", "TMPDIR", "TMP", "TEMP", "USERPROFILE"
>      -- 	};
>      -+	};
>      + SP_OBJ = $(patsubst %.o,%.sp,$(OBJECTS))
>        
>      -- 	size_t i;
>      -+	size_t i;
>      +-$(SP_OBJ): %.sp: %.c %.o
>      ++$(SP_OBJ): %.sp: %.c %.o $(GENERATED_H)
>      + 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
>      + 		-Wsparse-error \
>      + 		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $< && \
>      +@@ Makefile: style:
>      + 	git clang-format --style file --diff --extensions c,h
>        
>      - 	for (i = 0; i < var_count; ++i) {
>      - 		const char *env = getenv(env_vars[i]);
>      -@@ t/unit-tests/clar/clar/sandbox.h: const char *clar_sandbox_path(void)
>      - {
>      - 	return _clar_path;
>      - }
>      --
>      -
>      - ## t/unit-tests/clar/generate.py ##
>      -@@ t/unit-tests/clar/generate.py: def write(self):
>      -     suite.disable(options.excluded)
>      -     if suite.write():
>      -         print("Written `clar.suite` (%d tests in %d suites)" % (suite.callback_count(), suite.suite_count()))
>      --
>      -
>      - ## t/unit-tests/clar/test/.gitignore ##
>      -@@ t/unit-tests/clar/test/.gitignore: clar.suite
>      - .clarcache
>      - clar_test
>      - *.o
>      --
>      + .PHONY: check
>      +-check: $(GENERATED_H)
>      ++check:
>      + 	@if sparse; \
>      + 	then \
>      + 		echo >&2 "Use 'make sparse' instead"; \
>   -:  ---------- >  5:  06364b2b72 Makefile: make hdr-check depend on generated headers
>   -:  ---------- >  6:  88ea94ce16 Makefile: do not use sparse on third-party sources
>   5:  5b8a64ae79 !  7:  05bcb5bef6 Makefile: wire up the clar unit testing framework
>      @@ .gitignore
>        /bin-wrappers/
>       
>        ## Makefile ##
>      +@@ Makefile: REFTABLE_TEST_LIB = reftable/libreftable_test.a
>      + GENERATED_H += command-list.h
>      + GENERATED_H += config-list.h
>      + GENERATED_H += hook-list.h
>      ++GENERATED_H += $(UNIT_TEST_DIR)/clar-decls.h
>      ++GENERATED_H += $(UNIT_TEST_DIR)/clar.suite
>      +
>      + .PHONY: generated-hdrs
>      + generated-hdrs: $(GENERATED_H)
>       @@ Makefile: THIRD_PARTY_SOURCES += sha1dc/%
>        THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/%
>        THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
>      @@ Makefile: endif
>        
>        bin-wrappers/%: wrap-for-bin.sh
>        	$(call mkdir_p_parent_template)
>      -@@ Makefile: CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(LIB_H))
>      - HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
>      - HCC = $(HCO:hco=hcc)
>      -
>      -+$(UNIT_TEST_DIR)/unit-test.hcc: $(UNIT_TEST_DIR)/unit-test.h $(UNIT_TEST_DIR)/clar-decls.h
>      - %.hcc: %.h
>      - 	@echo '#include "git-compat-util.h"' >$@
>      - 	@echo '#include "$<"' >>$@
>       @@ Makefile: endif
>        
>        artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
>      @@ Makefile: cocciclean:
>        
>        clean: profile-clean coverage-clean cocciclean
>        	$(RM) -r .build $(UNIT_TEST_BIN)
>      -+	$(RM) GIT-TEST-SUITES $(UNIT_TEST_DIR)/clar.suite $(UNIT_TEST_DIR)/clar-decls.h
>      ++	$(RM) GIT-TEST-SUITES
>        	$(RM) po/git.pot po/git-core.pot
>        	$(RM) git.res
>        	$(RM) $(OBJECTS)
>   6:  bc4e23d666 =  8:  8f56b4d626 t/unit-tests: convert strvec tests to use clar
>   7:  0a7fe8775a =  9:  ca09d19fd5 t/unit-tests: convert ctype tests to use clar
> 
> base-commit: 406f326d271e0bacecdb00425422c5fa3f314930
