Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC446C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 22:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C6265009
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 22:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhCDWsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 17:48:09 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58089 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbhCDWsI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 17:48:08 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 23242118724;
        Thu,  4 Mar 2021 17:48:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f/D4rh4oMB2VP9k5xb1PhbaBe/w=; b=EZz1ga
        S4I4XllUqBwX5Jk07fkTMfTIIZIjN6W49flVieUkSTSrqsYxIYQ1IIWUfLNIIpcc
        I/i+uT15wOIFsJiqU/mf3yt2ZwEplxp/U6/B1Jbwg6Nm1gy8Yzry0hddMTJ4FIFe
        NHbPdOvEF3yugZsnfZ6E8VLUFaJnmNeuKIVsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YQ70PDlh4pRLP4bERTh1JFucmQO2gann
        nwNeCCgkqH6QhRPCTfDQAUiU8vrqb3pBlbFiCvqQcRNIsM9DUG76qWYGcpsfozM5
        jrPKdkOAp+4YnOsxN6IPlH9vn868Wk1F8Or7nhSBV3HE31k7w98Bh+BRljPqSQuj
        N0MesyDOPes=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1C1BA118723;
        Thu,  4 Mar 2021 17:48:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5F316118722;
        Thu,  4 Mar 2021 17:48:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH v2] Update 'make fuzz-all' docs to reflect modern clang
References: <pull.889.git.1614514959347.gitgitgadget@gmail.com>
        <pull.889.v2.git.1614871707845.gitgitgadget@gmail.com>
Date:   Thu, 04 Mar 2021 14:48:03 -0800
In-Reply-To: <pull.889.v2.git.1614871707845.gitgitgadget@gmail.com> (Andrzej
        Hunt via GitGitGadget's message of "Thu, 04 Mar 2021 15:28:27 +0000")
Message-ID: <xmqqlfb2cz8c.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AECB9112-7D3B-11EB-8A08-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Andrzej Hunt <ajrhunt@google.com>

> Subject: Re: [PATCH v2] Update 'make fuzz-all' docs to reflect modern clang

I'd retitte it to

    Makefile: update 'make fuzz-all' docs to reflect modern clang

> Clang no longer produces a libFuzzer.a, instead you can include
> libFuzzer by using -fsanitize=fuzzer.

Do we see two sentences here?  IOW, s/, instead/. Instead/ is needed?

> Therefore we should use
> that in the example command for building fuzzers.
>
> We also add -fsanitize=fuzzer-no-link to ensure that all the required
> instrumentation is added when compiling git [1], and remove
>  -fsanitize-coverage=trace-pc-guard as it is deprecated.

Without something like s/add/add to CFLAGS/, I found this a bit
cryptic and failed to read what it wanted to do without looking at
the patch text itself.

> I happen to have tested with LLVM 11 - however -fsanitize=fuzzer appears to
> work in a wide range of reasonably modern clangs.
>
> (On my system: what used to be libFuzzer.a now lives under the following path,
>  which is tricky albeit not impossible for a novice such as myself to find:
> /usr/lib64/clang/11.0.0/lib/linux/libclang_rt.fuzzer-x86_64.a )

All nice things to have in the log message.

>  Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index dd08b4ced01c..c7248ac6057b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3292,11 +3292,11 @@ cover_db_html: cover_db
>  # are not necessarily appropriate for general builds, and that vary greatly
>  # depending on the compiler version used.
>  #
> -# An example command to build against libFuzzer from LLVM 4.0.0:
> +# An example command to build against libFuzzer from LLVM 11.0.0:
>  #
>  # make CC=clang CXX=clang++ \
> -#      CFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
> -#      LIB_FUZZING_ENGINE=/usr/lib/llvm-4.0/lib/libFuzzer.a \
> +#      CFLAGS="-fsanitize=fuzzer-no-link,address" \
> +#      LIB_FUZZING_ENGINE="-fsanitize=fuzzer" \
>  #      fuzz-all
>  #
>  FUZZ_CXXFLAGS ?= $(CFLAGS)

LIB_FUZZING_ENGINE is used this way in the Makefile:

    $(FUZZ_PROGRAMS): all
            $(QUIET_LINK)$(CXX) $(FUZZ_CXXFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) \
                    $(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@

and it is somewhat annoying to see a compiler/linker option that
late on the command line, where readers would expect an object file
or a library archive would appear.  It makes me wonder if we should
instead be doing something along the following line:

 - empty LIB_FUZZING_ENGINE by default
 - add -fsanitize=fuzzer names to FUZZ_CXXFLAGS

i.e.

diff --git c/Makefile w/Makefile
index 4128b457e1..b5df76b33b 100644
--- c/Makefile
+++ w/Makefile
@@ -3306,14 +3306,15 @@ cover_db_html: cover_db
 # are not necessarily appropriate for general builds, and that vary greatly
 # depending on the compiler version used.
 #
-# An example command to build against libFuzzer from LLVM 4.0.0:
+# An example command to build against libFuzzer from LLVM 11.0.0:
 #
 # make CC=clang CXX=clang++ \
-#      CFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
-#      LIB_FUZZING_ENGINE=/usr/lib/llvm-4.0/lib/libFuzzer.a \
+#      CFLAGS="-fsanitize=fuzzer-no-link,address" \
 #      fuzz-all
 #
 FUZZ_CXXFLAGS ?= $(CFLAGS)
+FUZZ_CXXFLAGS += -fsanitize=fuzzer
+LIB_FUZZING_ENGINE =
 
 .PHONY: fuzz-all
 

In the meantime, I'll queue the version you sent as-is (modulo the
retitling).

Thanks.


