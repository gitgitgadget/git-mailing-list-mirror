Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 651D61F453
	for <e@80x24.org>; Wed, 24 Oct 2018 11:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeJXUP2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 16:15:28 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:50455 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbeJXUP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 16:15:28 -0400
Received: by mail-wm1-f43.google.com with SMTP id i8-v6so5046006wmg.0
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 04:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ppofDhZ5T/zXmbN2IsnNseHc0+qo6OMPWA1/tkKXrk4=;
        b=gweEHhWkaOKYff8LgeGDOoZ+aYuy8iYpTugr6BdXVKstIPn1daARy8i+ooEWU08GYr
         u3ozyYtvVHC+fPMM2MdBZr25Ie7yGG8+zwChWSGliKj8CasSB0rXy590G1jY+u1/RKqS
         kXyyFumK4LbykY7tbobfm2ezWpLu0Y3UiJadRfUHBQpCLQkm7Y66fX3vqpQYYtJTTbz2
         NQDmPJoaJQ6HCCmMQRVIVQeO/dhTqvKcrRwczDvJmbzsCVOH/c4+XRCGHmB0aegK/N62
         4r5OnhqG8xBKP4sMViZ5IYQI3xdko3jPJVVijsWGe2hT/LuBDc9VoGUx5fZsyB7DniTv
         aSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ppofDhZ5T/zXmbN2IsnNseHc0+qo6OMPWA1/tkKXrk4=;
        b=tOw/jgKo/TKKlyPnyPA/T0OWRlZC/vwxSAAGONZl1GggP7QsH7jdiKLGbfQpE8T2E0
         A1zbvWwZJAjaX6yH+pm5wK2j2GfpVcbp4Tr3HUyPkCCQA666J2/2BHN7qAk0IytQVv/J
         4a6TY6c9wzDBEsYR4/MXQ6u8ZI8L0RCsrlmhmr8iZLraAqRpBvG8jO87ee15HYfuNowN
         PCcbR0bgrjLuHYIuU8RuKBgHv1wvvl9a+j2PL18A1EcHj3nSVlxlrW8ZMZINXTnztDnJ
         TWmozcRl0MtORcmj6UM/hROuXFUBJnScIj/5nC0DuOA657zA0tzrOzS/ojEr3i0UDlJs
         3Sgg==
X-Gm-Message-State: AGRZ1gK6WCHfVmoDF8PE/YZyfR372vzhdXHcsiNOaXdc6ZF0XWW79nsP
        dQaPrWHUH7blkDXJxN5TtQWb9f9PUQI=
X-Google-Smtp-Source: AJdET5c0vJQfIGARJeKaE9NlHjH5XMQduPbXcVMK41UVsoWgJWHJVIc9UHs9oUyREYuXcfoYhwqAZw==
X-Received: by 2002:a1c:e12:: with SMTP id 18-v6mr2272821wmo.30.1540381655361;
        Wed, 24 Oct 2018 04:47:35 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q1-v6sm2951512wru.23.2018.10.24.04.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 04:47:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] i18n: make GETTEXT_POISON a runtime option
Date:   Wed, 24 Oct 2018 11:47:25 +0000
Message-Id: <20181024114725.3927-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <xmqqefcfoq2a.fsf@gitster-ct.c.googlers.com>
References: <xmqqefcfoq2a.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the GETTEXT_POISON compile-time + runtime GIT_GETTEXT_POISON
test parameter to only be a GIT_TEST_GETTEXT_POISON=<boolean> runtime
parameter, to be consistent with other parameters documented in
"Running tests with special setups" in t/README.

When I added GETTEXT_POISON in bb946bba76 ("i18n: add GETTEXT_POISON
to simulate unfriendly translator", 2011-02-22) I was concerned with
ensuring that the _() function would get constant folded if NO_GETTEXT
was defined or if it wasn't and GETTEXT_POISON wasn't defined.

But as the benchmark in my [1] shows doing a one-off runtime
getenv("GIT_TEST_[...]") is trivial, and since GETTEXT_POISON was
originally added this has become the common idiom in the codebase for
turning on special test setups.

So change GETTEXT_POISON to work the same way. Now the
GETTEXT_POISON=YesPlease compile-time option is gone, and running the
tests with GIT_TEST_GETTEXT_POISON=[true|false] can be toggled on/off
without recompiling.

This allows for conditionally amending tests to test with/without
poison, similar to what 859fdc0c3c ("commit-graph: define
GIT_TEST_COMMIT_GRAPH", 2018-08-29) did for GIT_TEST_COMMIT_GRAPH. Do
some of that, now we e.g. always run the t0205-gettext-poison.sh test.

I did enough there to remove the GETTEXT_POISON prerequisite, but its
inverse C_LOCALE_OUTPUT is still around, and surely some tests using
it can be converted to e.g. always set GIT_TEST_GETTEXT_POISON=false.

Notes on the implementation:

 * The only reason we need a new "git-sh-i18n--helper" is to expose
   git_env_bool() to shellscripts, since git-sh-i18n and friends need
   to inspect the $GIT_TEST_GETTEXT_POISON variable.

   We only call it if $GIT_TEST_GETTEXT_POISON is set, or in the test
   suite. This code can go away for non-test code once the last
   i18n-using shellscript is rewritten in C, or if "git config" learns
   to combine --bool and a value fed into it, see [2].

 * We still compile a dedicated GETTEXT_POISON build in Travis CI,
   this is probably the wrong thing to do and should be followed-up
   with something similar to ae59a4e44f ("travis: run tests with
   GIT_TEST_SPLIT_INDEX", 2018-01-07) to re-use an existing test setup
   for running in the GIT_TEST_GETTEXT_POISON mode.

 * The reason for not doing:

       test_lazy_prereq C_LOCALE_OUTPUT [...]

   in test-lib.sh is because there's some interpolation problem with
   that syntax which makes t6040-tracking-info.sh fail. Hence using
   the simpler test_set_prereq. It'll fail with:

       + git branch -vv
       + sed -n -e
       mkdir -p "$TRASH_DIRECTORY/prereq-test-dir" &&
       (
               cd "$TRASH_DIRECTORY/prereq-test-dir" &&! git sh-i18n--helper --git-test-gettext-poison
       )
       sed: -e expression #1, char 2: unknown command: `m'
       error: last command exited with $?=1
       not ok 3 - branch -vv

   This is some interpolation problem with how test_lazy_prereq works
   that doesn't affect test_set_prereq.

 * We now skip a test in t0000-basic.sh under
   GIT_TEST_GETTEXT_POISON=true that wasn't skipped before. This test
   relies on C locale output, but due to an edge case in how the
   previous implementation of GETTEXT_POISON worked (reading it from
   GIT-BUILD-OPTIONS) wasn't enabling poison correctly. Now it does,
   and needs to be skipped.

See also
https://public-inbox.org/git/878t2pd6yu.fsf@evledraar.gmail.com/ for
more discussion.

1. https://public-inbox.org/git/871s8gd32p.fsf@evledraar.gmail.com/

2. https://public-inbox.org/git/20181024074400.GA31239@sigill.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Wed, Oct 24 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Notes on the implementation:
>>
>>  * The only reason we need a new "git-sh-i18n--helper" and the
>>    corresponding "test-tool gettext-poison" is to expose
>>    git_env_bool() to shellscripts, since git-sh-i18n and friends need
>>    to inspect the $GIT_TEST_GETTEXT_POISON variable.
>>
>>    We only call these if $GIT_TEST_GETTEXT_POISON is set, or in the
>>    test suite, and this code can go away for non-test code once the
>>    last i18n-using shellscript is rewritten in C.
>
> Makes me wonder if we want to teach "git config" a new "--env-bool"
> option that can be used by third-party scripts.  Or would it be just
> the matter of writing
>
> 	git config --default=false --type=bool "$GIT_WHATEVER_ENV"
>
> in these third-party scripts and we do not need to add such a thing?

As Jeff notes in a follow-up reply git-config can't quite do this
yet. So in lieu of implementing that I have a more minimal helper,
which could be migrated to something like the --get-env mode Jeff is
talking about if we add that.

>>  * The reason for not doing:
>>
>>        test_lazy_prereq GETTEXT_POISON 'test-tool gettext-poison'
>>        test_lazy_prereq C_LOCALE_OUTPUT '! test-tool gettext-poison'
>>
>>    In test-lib.sh is because there's some interpolation problem with
>>    that syntax which makes t6040-tracking-info.sh fail. Hence using
>>    the simpler test_set_prereq.
>
> s/In/in/, as you haven't finished the sentence yet.  But more
> importantly, what is this "some interpolation problem"?  Are you
> saying that test_lazy_prereq implementation is somehow broken and
> cannot take certain strings?  If so, perhaps we want to fix that,
> and people other than you can help to do so, once you let them know
> what the problem is.

I haven't fixed (don't know what the fix is) this issue, but the new
version elaborates on what the error is.

>> See also
>> https://public-inbox.org/git/871s8gd32p.fsf@evledraar.gmail.com/ for
>> more discussion.
>
> "See also [*1*] for more discussion" as you've already have
> reference below.

Thanks, mispasted E-Mail ID. Fixed.

>>
>> 1. https://public-inbox.org/git/871s8gd32p.fsf@evledraar.gmail.com/
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>
>> Here's a polished version of that. I think it makes sense to queue
>> this up before any other refactoring of GETTEXT_POISON, and some patch
>> to unconditionally preserve format specifiers as I suggested upthread
>> could go on top of this.
>> ...
>> +int cmd_sh_i18n__helper(int argc, const char **argv, const char *prefix)
>> +{
>> +	int poison = -1;
>> +	struct option options[] = {
>> +		OPT_BOOL(0, "git-test-gettext-poison", &poison,
>> +			 N_("is GIT_TEST_GETTEXT_POISON in effect?")),
>> +		OPT_END()
>> +	};
>> +
>> +	argc = parse_options(argc, argv, NULL, options,
>> +			     builtin_sh_i18n_helper_usage, PARSE_OPT_KEEP_ARGV0);
>> +
>> +	if (poison != -1)
>> +		return !git_env_bool("GIT_TEST_GETTEXT_POISON", 0);
>
> Hmm?  If "--[no-]git-test-gettext-poison" is given, poison is either
> 0 or 1, and we return the value we read from the environment?  What
> convoluted way to implement the option is that, or is there anything
> subtle that I am not getting?
>
> If the "default" parameter to git_env_bool() were poison, and then
> the option was renamed to "--get-git-text-gettext-poison", then I
> sort of understand the code, though (it's like "git config" with
> "--default" option).

Yeah this didn't make much sense. The test helper is now gone, and the
main helper doesn't use git_env_bool() but the utility function in
gettext.h.

> But if there is nothing subtle, it may make sense to implement this
> as an opt-cmdmode instead.

You mean something that works like "helper foo" instead of an option
via "helper --foo"? Seemed easier just to use the opt parse mechanism.

>> diff --git a/po/README b/po/README
>> index fef4c0f0b5..dba46c4a40 100644
>> --- a/po/README
>> +++ b/po/README
>> @@ -289,16 +289,11 @@ something in the test suite might still depend on the US English
>>  version of the strings, e.g. to grep some error message or other
>>  output.
>>  
>> -To smoke out issues like these Git can be compiled with gettext poison
>> -support, at the top-level:
>> +To smoke out issues like these Git tested with a translation mode that
>> +emits gibberish on every call to gettext. To use it run the test suite
>> +with it, e.g.:
>
> s/these Git tested/these, Git can be tested/; even though the comma
> is not a new issue you introduced.

Fixed. Range-diff of the whole thing below:

1:  c93bf2f23f ! 1:  7bcb95a82d i18n: make GETTEXT_POISON a runtime option
    @@ -24,19 +24,23 @@
     
         This allows for conditionally amending tests to test with/without
         poison, similar to what 859fdc0c3c ("commit-graph: define
    -    GIT_TEST_COMMIT_GRAPH", 2018-08-29) did for GIT_TEST_COMMIT_GRAPH, but
    -    this patch doesn't change any of the existing tests to work like that.
    +    GIT_TEST_COMMIT_GRAPH", 2018-08-29) did for GIT_TEST_COMMIT_GRAPH. Do
    +    some of that, now we e.g. always run the t0205-gettext-poison.sh test.
    +
    +    I did enough there to remove the GETTEXT_POISON prerequisite, but its
    +    inverse C_LOCALE_OUTPUT is still around, and surely some tests using
    +    it can be converted to e.g. always set GIT_TEST_GETTEXT_POISON=false.
     
         Notes on the implementation:
     
    -     * The only reason we need a new "git-sh-i18n--helper" and the
    -       corresponding "test-tool gettext-poison" is to expose
    +     * The only reason we need a new "git-sh-i18n--helper" is to expose
            git_env_bool() to shellscripts, since git-sh-i18n and friends need
            to inspect the $GIT_TEST_GETTEXT_POISON variable.
     
    -       We only call these if $GIT_TEST_GETTEXT_POISON is set, or in the
    -       test suite, and this code can go away for non-test code once the
    -       last i18n-using shellscript is rewritten in C.
    +       We only call it if $GIT_TEST_GETTEXT_POISON is set, or in the test
    +       suite. This code can go away for non-test code once the last
    +       i18n-using shellscript is rewritten in C, or if "git config" learns
    +       to combine --bool and a value fed into it, see [2].
     
          * We still compile a dedicated GETTEXT_POISON build in Travis CI,
            this is probably the wrong thing to do and should be followed-up
    @@ -46,19 +50,40 @@
     
          * The reason for not doing:
     
    -           test_lazy_prereq GETTEXT_POISON 'test-tool gettext-poison'
    -           test_lazy_prereq C_LOCALE_OUTPUT '! test-tool gettext-poison'
    +           test_lazy_prereq C_LOCALE_OUTPUT [...]
     
    -       In test-lib.sh is because there's some interpolation problem with
    +       in test-lib.sh is because there's some interpolation problem with
            that syntax which makes t6040-tracking-info.sh fail. Hence using
    -       the simpler test_set_prereq.
    +       the simpler test_set_prereq. It'll fail with:
    +
    +           + git branch -vv
    +           + sed -n -e
    +           mkdir -p "$TRASH_DIRECTORY/prereq-test-dir" &&
    +           (
    +                   cd "$TRASH_DIRECTORY/prereq-test-dir" &&! git sh-i18n--helper --git-test-gettext-poison
    +           )
    +           sed: -e expression #1, char 2: unknown command: `m'
    +           error: last command exited with $?=1
    +           not ok 3 - branch -vv
    +
    +       This is some interpolation problem with how test_lazy_prereq works
    +       that doesn't affect test_set_prereq.
    +
    +     * We now skip a test in t0000-basic.sh under
    +       GIT_TEST_GETTEXT_POISON=true that wasn't skipped before. This test
    +       relies on C locale output, but due to an edge case in how the
    +       previous implementation of GETTEXT_POISON worked (reading it from
    +       GIT-BUILD-OPTIONS) wasn't enabling poison correctly. Now it does,
    +       and needs to be skipped.
     
         See also
    -    https://public-inbox.org/git/871s8gd32p.fsf@evledraar.gmail.com/ for
    +    https://public-inbox.org/git/878t2pd6yu.fsf@evledraar.gmail.com/ for
         more discussion.
     
         1. https://public-inbox.org/git/871s8gd32p.fsf@evledraar.gmail.com/
     
    +    2. https://public-inbox.org/git/20181024074400.GA31239@sigill.intra.peff.net/
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      diff --git a/.gitignore b/.gitignore
    @@ -101,14 +126,6 @@
      # Define JSMIN to point to JavaScript minifier that functions as
      # a filter to have gitweb.js minified.
      #
    -@@
    - TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
    - TEST_BUILTINS_OBJS += test-example-decorate.o
    - TEST_BUILTINS_OBJS += test-genrandom.o
    -+TEST_BUILTINS_OBJS += test-gettext-poison.o
    - TEST_BUILTINS_OBJS += test-hashmap.o
    - TEST_BUILTINS_OBJS += test-index-version.o
    - TEST_BUILTINS_OBJS += test-json-writer.o
     @@
      BUILTIN_OBJS += builtin/rm.o
      BUILTIN_OBJS += builtin/send-pack.o
    @@ -167,8 +184,9 @@
     +{
     +	int poison = -1;
     +	struct option options[] = {
    -+		OPT_BOOL(0, "git-test-gettext-poison", &poison,
    -+			 N_("is GIT_TEST_GETTEXT_POISON in effect?")),
    ++		OPT_BOOL_F(0, "git-test-gettext-poison", &poison,
    ++			   N_("is GIT_TEST_GETTEXT_POISON in effect?"),
    ++			   PARSE_OPT_NONEG),
     +		OPT_END()
     +	};
     +
    @@ -176,7 +194,7 @@
     +			     builtin_sh_i18n_helper_usage, PARSE_OPT_KEEP_ARGV0);
     +
     +	if (poison != -1)
    -+		return !git_env_bool("GIT_TEST_GETTEXT_POISON", 0);
    ++		return !use_gettext_poison();
     +
     +	usage_with_options(builtin_sh_i18n_helper_usage, options);
     +}
    @@ -275,7 +293,7 @@
      
     -To smoke out issues like these Git can be compiled with gettext poison
     -support, at the top-level:
    -+To smoke out issues like these Git tested with a translation mode that
    ++To smoke out issues like these, Git tested with a translation mode that
     +emits gibberish on every call to gettext. To use it run the test suite
     +with it, e.g.:
      
    @@ -308,44 +326,18 @@
      test suite. Accept any boolean values that are accepted by git-config.
      
     
    - diff --git a/t/helper/test-gettext-poison.c b/t/helper/test-gettext-poison.c
    - new file mode 100644
    - --- /dev/null
    - +++ b/t/helper/test-gettext-poison.c
    + diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
    + --- a/t/lib-gettext.sh
    + +++ b/t/lib-gettext.sh
     @@
    -+#include "test-tool.h"
    -+#include "git-compat-util.h"
    -+#include "thread-utils.h"
    -+#include "gettext.h"
    -+
    -+int cmd__gettext_poison(int argc, const char **argv)
    -+{
    -+	return use_gettext_poison() ? 0 : 1;
    -+}
    -
    - diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
    - --- a/t/helper/test-tool.c
    - +++ b/t/helper/test-tool.c
    -@@
    - 	{ "dump-untracked-cache", cmd__dump_untracked_cache },
    - 	{ "example-decorate", cmd__example_decorate },
    - 	{ "genrandom", cmd__genrandom },
    -+	{ "gettext-poison", cmd__gettext_poison },
    - 	{ "hashmap", cmd__hashmap },
    - 	{ "index-version", cmd__index_version },
    - 	{ "json-writer", cmd__json_writer },
    -
    - diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
    - --- a/t/helper/test-tool.h
    - +++ b/t/helper/test-tool.h
    -@@
    - int cmd__dump_untracked_cache(int argc, const char **argv);
    - int cmd__example_decorate(int argc, const char **argv);
    - int cmd__genrandom(int argc, const char **argv);
    -+int cmd__gettext_poison(int argc, const char **argv);
    - int cmd__hashmap(int argc, const char **argv);
    - int cmd__index_version(int argc, const char **argv);
    - int cmd__json_writer(int argc, const char **argv);
    + 
    + . "$GIT_BUILD_DIR"/git-sh-i18n
    + 
    +-if test_have_prereq GETTEXT && ! test_have_prereq GETTEXT_POISON
    ++if test_have_prereq GETTEXT && test_have_prereq C_LOCALE_OUTPUT
    + then
    + 	# is_IS.UTF-8 on Solaris and FreeBSD, is_IS.utf8 on Debian
    + 	is_IS_locale=$(locale -a 2>/dev/null |
     
      diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
      --- a/t/t0000-basic.sh
    @@ -360,6 +352,37 @@
      		test-verbose "test verbose" --verbose <<-\EOF &&
      	test_expect_success "passing test" true
     
    + diff --git a/t/t0205-gettext-poison.sh b/t/t0205-gettext-poison.sh
    + --- a/t/t0205-gettext-poison.sh
    + +++ b/t/t0205-gettext-poison.sh
    +@@
    + 
    + test_description='Gettext Shell poison'
    + 
    ++GIT_TEST_GETTEXT_POISON=true
    ++export GIT_TEST_GETTEXT_POISON
    + . ./lib-gettext.sh
    + 
    +-test_expect_success GETTEXT_POISON 'sanity: $GIT_INTERNAL_GETTEXT_SH_SCHEME" is poison' '
    ++test_expect_success 'sanity: $GIT_INTERNAL_GETTEXT_SH_SCHEME" is poison' '
    +     test "$GIT_INTERNAL_GETTEXT_SH_SCHEME" = "poison"
    + '
    + 
    +-test_expect_success GETTEXT_POISON 'gettext: our gettext() fallback has poison semantics' '
    ++test_expect_success 'gettext: our gettext() fallback has poison semantics' '
    +     printf "# GETTEXT POISON #" >expect &&
    +     gettext "test" >actual &&
    +     test_cmp expect actual &&
    +@@
    +     test_cmp expect actual
    + '
    + 
    +-test_expect_success GETTEXT_POISON 'eval_gettext: our eval_gettext() fallback has poison semantics' '
    ++test_expect_success 'eval_gettext: our eval_gettext() fallback has poison semantics' '
    +     printf "# GETTEXT POISON #" >expect &&
    +     eval_gettext "test" >actual &&
    +     test_cmp expect actual &&
    +
      diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
      --- a/t/t3406-rebase-message.sh
      +++ b/t/t3406-rebase-message.sh
    @@ -377,18 +400,33 @@
      --- a/t/t7201-co.sh
      +++ b/t/t7201-co.sh
     @@
    + test_expect_success 'checkout to detach HEAD' '
    + 	git config advice.detachedHead true &&
      	git checkout -f renamer && git clean -f &&
    - 	git checkout renamer^ 2>messages &&
    - 	test_i18ngrep "HEAD is now at 7329388" messages &&
    +-	git checkout renamer^ 2>messages &&
    +-	test_i18ngrep "HEAD is now at 7329388" messages &&
     -	(test_line_count -gt 1 messages || test -n "$GETTEXT_POISON") &&
    -+	(
    -+		test_line_count -gt 1 messages ||
    -+		test_have_prereq GETTEXT_POISON
    -+	) &&
    ++	GIT_TEST_GETTEXT_POISON=false git checkout renamer^ 2>messages &&
    ++	grep "HEAD is now at 7329388" messages &&
    ++	test_line_count -gt 1 messages &&
      	H=$(git rev-parse --verify HEAD) &&
      	M=$(git show-ref -s --verify refs/heads/master) &&
      	test "z$H" = "z$M" &&
     
    + diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
    + --- a/t/t9902-completion.sh
    + +++ b/t/t9902-completion.sh
    +@@
    + 	verbose test -z "$__git_all_commands"
    + '
    + 
    +-test_expect_success !GETTEXT_POISON 'sourcing the completion script clears cached merge strategies' '
    ++test_expect_success 'sourcing the completion script clears cached merge strategies' '
    ++	GIT_TEST_GETTEXT_POISON=false &&
    + 	__git_compute_merge_strategies &&
    + 	verbose test -n "$__git_merge_strategies" &&
    + 	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
    +
      diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
      --- a/t/test-lib-functions.sh
      +++ b/t/test-lib-functions.sh
    @@ -417,7 +455,7 @@
      	fi
      
     -	if test -n "$GETTEXT_POISON"
    -+	if ! test_have_prereq C_LOCALE_OUTPUT
    ++	if test_have_prereq !C_LOCALE_OUTPUT
      	then
      		# pretend success
      		return 0
    @@ -438,8 +476,9 @@
     -else
     -	test_set_prereq C_LOCALE_OUTPUT
     -fi
    -+test-tool gettext-poison && test_set_prereq GETTEXT_POISON
    -+test-tool gettext-poison || test_set_prereq C_LOCALE_OUTPUT
    ++## Fails in the 'branch -vv' test in t6040-tracking-info.sh
    ++#test_lazy_prereq C_LOCALE_OUTPUT '! git sh-i18n--helper --git-test-gettext-poison'
    ++git sh-i18n--helper --git-test-gettext-poison || test_set_prereq C_LOCALE_OUTPUT
      
      if test -z "$GIT_TEST_CHECK_CACHE_TREE"
      then

 .gitignore                |  1 +
 .travis.yml               |  2 +-
 Makefile                  | 10 +---------
 builtin.h                 |  1 +
 builtin/sh-i18n--helper.c | 28 ++++++++++++++++++++++++++++
 ci/lib-travisci.sh        |  4 ++--
 gettext.c                 |  5 ++---
 gettext.h                 |  4 ----
 git-sh-i18n.sh            |  3 ++-
 git.c                     |  1 +
 po/README                 | 13 ++++---------
 t/README                  |  6 ++++++
 t/lib-gettext.sh          |  2 +-
 t/t0000-basic.sh          |  2 +-
 t/t0205-gettext-poison.sh |  8 +++++---
 t/t3406-rebase-message.sh |  2 +-
 t/t7201-co.sh             |  6 +++---
 t/t9902-completion.sh     |  3 ++-
 t/test-lib-functions.sh   |  8 ++++----
 t/test-lib.sh             | 12 +++---------
 20 files changed, 69 insertions(+), 52 deletions(-)
 create mode 100644 builtin/sh-i18n--helper.c

diff --git a/.gitignore b/.gitignore
index 9d1363a1eb..f7b7977910 100644
--- a/.gitignore
+++ b/.gitignore
@@ -148,6 +148,7 @@
 /git-serve
 /git-sh-i18n
 /git-sh-i18n--envsubst
+/git-sh-i18n--helper
 /git-sh-setup
 /git-sh-i18n
 /git-shell
diff --git a/.travis.yml b/.travis.yml
index 4d4e26c9df..4523a2e5ec 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -26,7 +26,7 @@ addons:
 
 matrix:
   include:
-    - env: jobname=GETTEXT_POISON
+    - env: jobname=GIT_TEST_GETTEXT_POISON
       os: linux
       compiler:
       addons:
diff --git a/Makefile b/Makefile
index d18ab0fe78..086600b099 100644
--- a/Makefile
+++ b/Makefile
@@ -362,11 +362,6 @@ all::
 # Define HAVE_DEV_TTY if your system can open /dev/tty to interact with the
 # user.
 #
-# Define GETTEXT_POISON if you are debugging the choice of strings marked
-# for translation.  In a GETTEXT_POISON build, you can turn all strings marked
-# for translation into gibberish by setting the GIT_GETTEXT_POISON variable
-# (to any value) in your environment.
-#
 # Define JSMIN to point to JavaScript minifier that functions as
 # a filter to have gitweb.js minified.
 #
@@ -1099,6 +1094,7 @@ BUILTIN_OBJS += builtin/revert.o
 BUILTIN_OBJS += builtin/rm.o
 BUILTIN_OBJS += builtin/send-pack.o
 BUILTIN_OBJS += builtin/serve.o
+BUILTIN_OBJS += builtin/sh-i18n--helper.o
 BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-index.o
@@ -1439,9 +1435,6 @@ endif
 ifdef NO_SYMLINK_HEAD
 	BASIC_CFLAGS += -DNO_SYMLINK_HEAD
 endif
-ifdef GETTEXT_POISON
-	BASIC_CFLAGS += -DGETTEXT_POISON
-endif
 ifdef NO_GETTEXT
 	BASIC_CFLAGS += -DNO_GETTEXT
 	USE_GETTEXT_SCHEME ?= fallthrough
@@ -2591,7 +2584,6 @@ ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=YesPlease >>$@+
 endif
 	@echo NO_GETTEXT=\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))'\' >>$@+
-	@echo GETTEXT_POISON=\''$(subst ','\'',$(subst ','\'',$(GETTEXT_POISON)))'\' >>$@+
 ifdef GIT_PERF_REPEAT_COUNT
 	@echo GIT_PERF_REPEAT_COUNT=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_REPEAT_COUNT)))'\' >>$@+
 endif
diff --git a/builtin.h b/builtin.h
index 962f0489ab..a40c56e7a2 100644
--- a/builtin.h
+++ b/builtin.h
@@ -219,6 +219,7 @@ extern int cmd_revert(int argc, const char **argv, const char *prefix);
 extern int cmd_rm(int argc, const char **argv, const char *prefix);
 extern int cmd_send_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_serve(int argc, const char **argv, const char *prefix);
+extern int cmd_sh_i18n__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
diff --git a/builtin/sh-i18n--helper.c b/builtin/sh-i18n--helper.c
new file mode 100644
index 0000000000..aa62787514
--- /dev/null
+++ b/builtin/sh-i18n--helper.c
@@ -0,0 +1,28 @@
+#include "builtin.h"
+#include "cache.h"
+#include "config.h"
+#include "parse-options.h"
+
+static const char * const builtin_sh_i18n_helper_usage[] = {
+	N_("git sh-i18n--helper [<options>]"),
+	NULL
+};
+
+int cmd_sh_i18n__helper(int argc, const char **argv, const char *prefix)
+{
+	int poison = -1;
+	struct option options[] = {
+		OPT_BOOL_F(0, "git-test-gettext-poison", &poison,
+			   N_("is GIT_TEST_GETTEXT_POISON in effect?"),
+			   PARSE_OPT_NONEG),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL, options,
+			     builtin_sh_i18n_helper_usage, PARSE_OPT_KEEP_ARGV0);
+
+	if (poison != -1)
+		return !use_gettext_poison();
+
+	usage_with_options(builtin_sh_i18n_helper_usage, options);
+}
diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 06970f7213..6a89d0d7d8 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -123,7 +123,7 @@ osx-clang|osx-gcc)
 	# Travis CI OS X
 	export GIT_SKIP_TESTS="t9810 t9816"
 	;;
-GETTEXT_POISON)
-	export GETTEXT_POISON=YesPlease
+GIT_TEST_GETTEXT_POISON)
+	export GIT_TEST_GETTEXT_POISON=true
 	;;
 esac
diff --git a/gettext.c b/gettext.c
index 7272771c8e..722a2f726c 100644
--- a/gettext.c
+++ b/gettext.c
@@ -7,6 +7,7 @@
 #include "gettext.h"
 #include "strbuf.h"
 #include "utf8.h"
+#include "config.h"
 
 #ifndef NO_GETTEXT
 #	include <locale.h>
@@ -46,15 +47,13 @@ const char *get_preferred_languages(void)
 	return NULL;
 }
 
-#ifdef GETTEXT_POISON
 int use_gettext_poison(void)
 {
 	static int poison_requested = -1;
 	if (poison_requested == -1)
-		poison_requested = getenv("GIT_GETTEXT_POISON") ? 1 : 0;
+		poison_requested = git_env_bool("GIT_TEST_GETTEXT_POISON", 0);
 	return poison_requested;
 }
-#endif
 
 #ifndef NO_GETTEXT
 static int test_vsnprintf(const char *fmt, ...)
diff --git a/gettext.h b/gettext.h
index 7eee64a34f..4c492d9f57 100644
--- a/gettext.h
+++ b/gettext.h
@@ -41,11 +41,7 @@ static inline int gettext_width(const char *s)
 }
 #endif
 
-#ifdef GETTEXT_POISON
 extern int use_gettext_poison(void);
-#else
-#define use_gettext_poison() 0
-#endif
 
 static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 {
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index 9d065fb4bf..c0713b1ee9 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -17,7 +17,8 @@ export TEXTDOMAINDIR
 
 # First decide what scheme to use...
 GIT_INTERNAL_GETTEXT_SH_SCHEME=fallthrough
-if test -n "$GIT_GETTEXT_POISON"
+if test -n "$GIT_TEST_GETTEXT_POISON" &&
+	    git sh-i18n--helper --git-test-gettext-poison
 then
 	GIT_INTERNAL_GETTEXT_SH_SCHEME=poison
 elif test -n "@@USE_GETTEXT_SCHEME@@"
diff --git a/git.c b/git.c
index 5920f8019b..125c523720 100644
--- a/git.c
+++ b/git.c
@@ -539,6 +539,7 @@ static struct cmd_struct commands[] = {
 	{ "rm", cmd_rm, RUN_SETUP },
 	{ "send-pack", cmd_send_pack, RUN_SETUP },
 	{ "serve", cmd_serve, RUN_SETUP },
+	{ "sh-i18n--helper", cmd_sh_i18n__helper, 0 },
 	{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
 	{ "show", cmd_show, RUN_SETUP },
 	{ "show-branch", cmd_show_branch, RUN_SETUP },
diff --git a/po/README b/po/README
index fef4c0f0b5..07595d369b 100644
--- a/po/README
+++ b/po/README
@@ -289,16 +289,11 @@ something in the test suite might still depend on the US English
 version of the strings, e.g. to grep some error message or other
 output.
 
-To smoke out issues like these Git can be compiled with gettext poison
-support, at the top-level:
+To smoke out issues like these, Git tested with a translation mode that
+emits gibberish on every call to gettext. To use it run the test suite
+with it, e.g.:
 
-    make GETTEXT_POISON=YesPlease
-
-That'll give you a git which emits gibberish on every call to
-gettext. It's obviously not meant to be installed, but you should run
-the test suite with it:
-
-    cd t && prove -j 9 ./t[0-9]*.sh
+    cd t && GIT_TEST_GETTEXT_POISON=true prove -j 9 ./t[0-9]*.sh
 
 If tests break with it you should inspect them manually and see if
 what you're translating is sane, i.e. that you're not translating
diff --git a/t/README b/t/README
index 8847489640..53c3dee7a9 100644
--- a/t/README
+++ b/t/README
@@ -301,6 +301,12 @@ that cannot be easily covered by a few specific test cases. These
 could be enabled by running the test suite with correct GIT_TEST_
 environment set.
 
+GIT_TEST_GETTEXT_POISON=<boolean> turns all strings marked for
+translation into gibberish. Used for spotting those tests that need to
+be marked with a C_LOCALE_OUTPUT prerequisite when adding more strings
+for translation. See "Testing marked strings" in po/README for
+details.
+
 GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
 test suite. Accept any boolean values that are accepted by git-config.
 
diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index eec757f104..755f421431 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -12,7 +12,7 @@ export GIT_TEXTDOMAINDIR GIT_PO_PATH
 
 . "$GIT_BUILD_DIR"/git-sh-i18n
 
-if test_have_prereq GETTEXT && ! test_have_prereq GETTEXT_POISON
+if test_have_prereq GETTEXT && test_have_prereq C_LOCALE_OUTPUT
 then
 	# is_IS.UTF-8 on Solaris and FreeBSD, is_IS.utf8 on Debian
 	is_IS_locale=$(locale -a 2>/dev/null |
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 4d23373526..b6566003dd 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -274,7 +274,7 @@ test_expect_success 'pretend we have a mix of all possible results' "
 	EOF
 "
 
-test_expect_success 'test --verbose' '
+test_expect_success C_LOCALE_OUTPUT 'test --verbose' '
 	test_must_fail run_sub_test_lib_test \
 		test-verbose "test verbose" --verbose <<-\EOF &&
 	test_expect_success "passing test" true
diff --git a/t/t0205-gettext-poison.sh b/t/t0205-gettext-poison.sh
index 438e778d6a..1675d3e171 100755
--- a/t/t0205-gettext-poison.sh
+++ b/t/t0205-gettext-poison.sh
@@ -5,13 +5,15 @@
 
 test_description='Gettext Shell poison'
 
+GIT_TEST_GETTEXT_POISON=true
+export GIT_TEST_GETTEXT_POISON
 . ./lib-gettext.sh
 
-test_expect_success GETTEXT_POISON 'sanity: $GIT_INTERNAL_GETTEXT_SH_SCHEME" is poison' '
+test_expect_success 'sanity: $GIT_INTERNAL_GETTEXT_SH_SCHEME" is poison' '
     test "$GIT_INTERNAL_GETTEXT_SH_SCHEME" = "poison"
 '
 
-test_expect_success GETTEXT_POISON 'gettext: our gettext() fallback has poison semantics' '
+test_expect_success 'gettext: our gettext() fallback has poison semantics' '
     printf "# GETTEXT POISON #" >expect &&
     gettext "test" >actual &&
     test_cmp expect actual &&
@@ -20,7 +22,7 @@ test_expect_success GETTEXT_POISON 'gettext: our gettext() fallback has poison s
     test_cmp expect actual
 '
 
-test_expect_success GETTEXT_POISON 'eval_gettext: our eval_gettext() fallback has poison semantics' '
+test_expect_success 'eval_gettext: our eval_gettext() fallback has poison semantics' '
     printf "# GETTEXT POISON #" >expect &&
     eval_gettext "test" >actual &&
     test_cmp expect actual &&
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 0392e36d23..2bdcf83808 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -77,7 +77,7 @@ test_expect_success 'rebase -n overrides config rebase.stat config' '
 #     "Does not point to a valid commit: invalid-ref"
 #
 # NEEDSWORK: This "grep" is fine in real non-C locales, but
-# GETTEXT_POISON poisons the refname along with the enclosing
+# GIT_TEST_GETTEXT_POISON poisons the refname along with the enclosing
 # error message.
 test_expect_success 'rebase --onto outputs the invalid ref' '
 	test_must_fail git rebase --onto invalid-ref HEAD HEAD 2>err &&
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 826987ca80..71e8e0167f 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -254,9 +254,9 @@ test_expect_success 'checkout to detach HEAD (with advice declined)' '
 test_expect_success 'checkout to detach HEAD' '
 	git config advice.detachedHead true &&
 	git checkout -f renamer && git clean -f &&
-	git checkout renamer^ 2>messages &&
-	test_i18ngrep "HEAD is now at 7329388" messages &&
-	(test_line_count -gt 1 messages || test -n "$GETTEXT_POISON") &&
+	GIT_TEST_GETTEXT_POISON=false git checkout renamer^ 2>messages &&
+	grep "HEAD is now at 7329388" messages &&
+	test_line_count -gt 1 messages &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
 	test "z$H" = "z$M" &&
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 175f83d704..537f5fdada 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1697,7 +1697,8 @@ test_expect_success 'sourcing the completion script clears cached commands' '
 	verbose test -z "$__git_all_commands"
 '
 
-test_expect_success !GETTEXT_POISON 'sourcing the completion script clears cached merge strategies' '
+test_expect_success 'sourcing the completion script clears cached merge strategies' '
+	GIT_TEST_GETTEXT_POISON=false &&
 	__git_compute_merge_strategies &&
 	verbose test -n "$__git_merge_strategies" &&
 	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 78d8c3783b..2f42b3653c 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -755,16 +755,16 @@ test_cmp_bin() {
 
 # Use this instead of test_cmp to compare files that contain expected and
 # actual output from git commands that can be translated.  When running
-# under GETTEXT_POISON this pretends that the command produced expected
+# under GIT_TEST_GETTEXT_POISON this pretends that the command produced expected
 # results.
 test_i18ncmp () {
-	test -n "$GETTEXT_POISON" || test_cmp "$@"
+	! test_have_prereq C_LOCALE_OUTPUT || test_cmp "$@"
 }
 
 # Use this instead of "grep expected-string actual" to see if the
 # output from a git command that can be translated either contains an
 # expected string, or does not contain an unwanted one.  When running
-# under GETTEXT_POISON this pretends that the command produced expected
+# under GIT_TEST_GETTEXT_POISON this pretends that the command produced expected
 # results.
 test_i18ngrep () {
 	eval "last_arg=\${$#}"
@@ -779,7 +779,7 @@ test_i18ngrep () {
 		error "bug in the test script: too few parameters to test_i18ngrep"
 	fi
 
-	if test -n "$GETTEXT_POISON"
+	if test_have_prereq !C_LOCALE_OUTPUT
 	then
 		# pretend success
 		return 0
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 897e6fcc94..892591ac84 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1104,15 +1104,9 @@ test -n "$USE_LIBPCRE1" && test_set_prereq LIBPCRE1
 test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 
-# Can we rely on git's output in the C locale?
-if test -n "$GETTEXT_POISON"
-then
-	GIT_GETTEXT_POISON=YesPlease
-	export GIT_GETTEXT_POISON
-	test_set_prereq GETTEXT_POISON
-else
-	test_set_prereq C_LOCALE_OUTPUT
-fi
+## Fails in the 'branch -vv' test in t6040-tracking-info.sh
+#test_lazy_prereq C_LOCALE_OUTPUT '! git sh-i18n--helper --git-test-gettext-poison'
+git sh-i18n--helper --git-test-gettext-poison || test_set_prereq C_LOCALE_OUTPUT
 
 if test -z "$GIT_TEST_CHECK_CACHE_TREE"
 then
-- 
2.19.1.568.g152ad8e336

