Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2C6C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 18:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1950522C9F
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 18:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wU6DVPt9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgHFSst (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:48:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52004 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgHFSst (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 14:48:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F3C7FE70F4;
        Thu,  6 Aug 2020 14:11:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FBZ4cVgPC5gXvubsW0eiL0/v0WA=; b=wU6DVP
        t9uQnNUvYsGyELi/UGVrbIbqMpdLHqCYbWYNRM8AAGttMHZ/rX4spCSST5x3pTC/
        YQ9cFTYzFz2WogszZW0xpwctjYRAoeS7qXDjTYkNb1fTZxbcf2bg1f7Fo0ugPAIl
        mC3xxNOB0EvAbgM4UBTyvP9T+2VbcofWLnn7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Gig/p31Gor4u4uF1VfOTZ6ZotuRS92Hg
        WR5HTVNgvt6MObFQoltdBchrizqAtwxh9xuqoneU9ry4tT2n45dbWciCfDxJ2lKD
        SIeHFR7wU9mOvTadA+PQpMB38s24ru8ka3jCMlTjIzrJmh6VivIXGV5H1VELKdZj
        eC2cUkdUQjg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EC82EE70F3;
        Thu,  6 Aug 2020 14:11:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1A5ABE70F1;
        Thu,  6 Aug 2020 14:10:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "lufia via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "KADOTA\, Kyohei" <lufia@lufia.org>
Subject: Re: [PATCH 3/4] Fit to Plan 9's ANSI/POSIX compatibility layer
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
        <d15ed626de65c51ef2ba31020eeb2111fb8e091f.1596675905.git.gitgitgadget@gmail.com>
        <20200806020407.GR6540@camp.crustytoothpaste.net>
Date:   Thu, 06 Aug 2020 11:10:57 -0700
In-Reply-To: <20200806020407.GR6540@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 6 Aug 2020 02:04:07 +0000")
Message-ID: <xmqq5z9vlk5q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E03106C-D810-11EA-8594-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I will note that usually the project prefers to have a human's personal
> name here and in the commit metadata instead of a username.  Junio may
> chime in here with an opinion.

Thanks, I just did.

>>  command_list () {
>> -	eval "grep -ve '^#' $exclude_programs" <"$1"
>> +	eval "grep -v -e '^#' $exclude_programs" <"$1"
>
> Is it really the case that Plan 9's grep cannot deal with bundled short
> options?  That seems to be a significant departure from POSIX and Unix
> behavior.  Regardless, this should be explained in the commit message.

I am not interested in this ball of wax, but there are some pieces
that are worth salvaging.  This is one of those good bits.

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 9db2f4feab..a7cc01caf9 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -26,7 +26,7 @@ else
 	VN="$DEF_VER"
 fi
 
-VN=$(expr "$VN" : v*'\(.*\)')
+VN=${VN#v}
 
 if test -r $GVF
 then

BUT.

Dealing with "grep" that cannot take "-ve" and forces developers to
spell it as "-v -e" is not one of them.  So is forbidding use of
"cut".

>>  get_categories () {
>> -	tr ' ' '\n'|
>> +	tr ' ' '\012'|
>
> Okay, I guess.  Is this something we need to handle elsewhere as well?
> The commit message should tell us why this is necessary, and what Plan 9
> does and doesn't support.

Yeah, POSIX does want you to understand '\n' and others, but this is
within reason for portability that I think we could swallow.

>> +if test -z "$(echo -n)"
>> +then
>> +	alias print='echo -n'
>> +else
>> +	alias print='printf %s'
>> +fi
>
> Let's avoid an alias here (especially with a common builtin name) and
> instead use a shell function.  Maybe like this (not tab-indented):
>
>   print_nonl () {
>     if command -v printf >/dev/null 2>&1
>     then
>       printf "%s" "$@"
>     else
>       echo -n "$@"
>     fi
>   }

I'd rather not to see this done; "echo -n" and "echo '...\c'" are
not portable and we do want people to use 'printf'.  This directly
goes against it.

> This is also going to need some patching in the testsuite, since we use
> printf extensively (more than 1300 times).  I do hope you have perl
> available.

Eh, so what would Plan9 people do with Perl?  Write a single-liner
'printf' script and put it in a directory on their $PATH?

I am not sure if it is worth crippling the toolset our developers
are allowed to choose from and use in our scripts and tests like
this patch tries to do.

If this were Windows, it might have been a different story, but what
we are talking about is Plan 9, which had the last "fourth edition"
in 2002, right?  During the 18 years since then, none of its users
and developers work on porting many OSS packages, whose primary user
base are on POSIXy systems, to it and we need to apply patches like
these to each and every OSS packages of interest?  I would have
expected that any exotic-minority-but-thriving-platform would be
able to tell its users "here are ports of POSIXy programs---install
them and it can become usable by those who only know Linux"?

So, I dunno.
