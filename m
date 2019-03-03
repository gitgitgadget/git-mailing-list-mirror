Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E99D20248
	for <e@80x24.org>; Sun,  3 Mar 2019 16:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfCCQFF (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 11:05:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35837 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfCCQFE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 11:05:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id t18so2855812wrx.2
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 08:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=y3JLNTtUQLI3N/PYFsbkiO+3+pyBfW6+sBRJjNUCsgc=;
        b=cjNIgMyhK58mdFDbIyFS0mTZJ8ikl0l4k3wEYpCkbBENZfF3FlaWOq5TCr/WKWRbGV
         VJffPf+t2nn0hOMzkv2+7+gPl/hqOGq/PxbjJlu/mem3pp+JMZkAzKtv+ZLujeMu+SA7
         7AjiujedDoldbZXHJLuwIvOBACrnk2Ssd8CF2ODdnO8XsqkiJZZoNDF8UzjOmQ9KWmq6
         EfVaE4HJM6wKldNE59VCeES0nMU+fhiTtf83MywZKoJFNVBelwIxBWjr4Tx/NzKt1n+V
         JjXPdUT/XTUw8AUfIBwQi3L6VhiHgTfsZBV/Xk+pmo4cKeNg3/zEHRl8S9WOrVv0vBCV
         a59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=y3JLNTtUQLI3N/PYFsbkiO+3+pyBfW6+sBRJjNUCsgc=;
        b=VBXcFXqkWjO0DMnSPn4JB80XDft1+Vtppz49K8+x4LlYXlaygAV8xL2xcnwVBhIFL7
         oAD4LtVW9qRX3GnFBqvt28BicDhFxLek5cyqIjwnXN72nZM0oa0P58uyNqKSBkJq65VK
         f2xBxA96geVkqonbBZRKCx0Nc06E4rQ+zpJ9sf3CFh8dvvaREnJFeaiy7Ldsn5sHJmXM
         NZvEb8RAZGERJ35Em+0wnW0d/0Ofq6E31M6NO0XyItIsJBo/VYA6xb0vYqnarxLnh0/Q
         P7HLvQcayNENLmmISw688RQJOEVEqglkzspIhbd6QLKePefrILGVw8YeZPOYCDbzaSwC
         auuw==
X-Gm-Message-State: APjAAAXIVKDvDgEeGzzmQ7JPU5H9h9ljeSXpweXtaq56Nk2DSQwkIMma
        EdTwLjpKroFu7dDjhP26ORc=
X-Google-Smtp-Source: APXvYqyQh1CaSPrgf9c9Iky38fLv6zVOUzobfofpV1BRxI01J33ytE46XkyPjG8DHu17jw43F2tffA==
X-Received: by 2002:adf:f28f:: with SMTP id k15mr10238422wro.272.1551629102557;
        Sun, 03 Mar 2019 08:05:02 -0800 (PST)
Received: from szeder.dev (x4dbe14c7.dyn.telefonica.de. [77.190.20.199])
        by smtp.gmail.com with ESMTPSA id s5sm15066147wra.77.2019.03.03.08.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 08:05:01 -0800 (PST)
Date:   Sun, 3 Mar 2019 17:04:59 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: Do test-path_is_{file,dir,exists} make sense anymore with -x?
Message-ID: <20190303160459.GB28939@szeder.dev>
References: <pull.152.git.gitgitgadget@gmail.com>
 <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
 <CACsJy8DG6+mmA5NT67V46=n1-5H_eh3779eE28YN4kcjb0Cq0A@mail.gmail.com>
 <87sgwav8cp.fsf@evledraar.gmail.com>
 <20190226170400.GC19739@szeder.dev>
 <20190226174316.GD19606@sigill.intra.peff.net>
 <20190226193912.GD19739@szeder.dev>
 <20190226210101.GA27914@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190226210101.GA27914@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 04:01:01PM -0500, Jeff King wrote:
> On Tue, Feb 26, 2019 at 08:39:12PM +0100, SZEDER Gábor wrote:
> 
> > > > I didn't find this to be an issue, but because of functions like
> > > > 'test_seq' and 'test_must_fail' I've thought about suppressing '-x'
> > > > output for test helpers (haven't actually done anything about it,
> > > > though).

> > There are a couple of tricky cases:
> > 
> >   - Some test helper functions call other test helper functions, and
> >     in those cases tracing would be enabled upon returning from the
> >     inner helper function.  This is not an issue with e.g.
> >     'test_might_fail' or 'test_cmp_config', because the inner helper
> >     function is the last command anyway.  However, there is
> >     'test_must_be_empty', 'test_dir_is_empty', 'test_config',
> >     'test_commit', etc. which call the other test helper functions
> >     right at the start or in the middle.
> 
> Yeah, this is inherently a global flag that we're playing games with. It
> does seem like it would be easy to get it wrong. I guess the right model
> is considering it like a stack, like:
> 
> -- >8 --
> #!/bin/sh
> 
> x_counter=0
> pop_x() {
> 	ret=$?
> 	case "$x_counter" in
> 	0)
> 		echo >&2 "BUG: too many pops"
> 		exit 1
> 		;;
> 	1)
> 		x_counter=0
> 		set -x
> 		;;
> 	*)
> 		x_counter=$((x_counter - 1))
> 		;;
> 	esac
> 	{ return $ret; } 2>/dev/null
> }
> 
> # you _must_ call this as "{ push_x; } 2>/dev/null" to avoid polluting
> # trace output with the push call
> push_x() {
> 	set +x 2>/dev/null
> 	x_counter=$((x_counter + 1))
> }
> 
> bar() {
> 	{ push_x; } 2>/dev/null
> 	echo in bar
> 	pop_x
> }
> 
> foo() {
> 	{ push_x; } 2>/dev/null
> 	echo in foo, before bar
> 	bar
> 	echo in foo, after bar
> 	false
> 	pop_x
> }
> 
> set -x
> foo
> echo \$? is $?
> -- 8< --
> 
> I wish there was a way to avoid having to do the block-and-redirect in
> the push_x calls in each function, though.
> 
> I dunno. I do like the output, but this is rapidly getting complex.
> 
> >   - && chains in test helper functions; we must make sure that the
> >     tracing is restored even in case of a failure.

Actually, the && chain is not really an issue, because we can simply
break the && chain at the very end:

  test_func () {
        { disable_tracing ; } 2>/dev/null 4>&2
        do this &&
        do that
        restore_tracing
  }

and make restore_tracing exit with $? (like you did above in pop_x()).

> Yeah, there is no "goto out" to help give a common exit point from the
> function. You could probably do it with a wrapper, like:

Yeah, the wrapper works.
There are only a few test helper functions with multiple 'return'
statements, and refactoring them to have a single 'return $ret' at the
end worked, too.

>   foo() {
> 	{ push_x; } 2>/dev/null
> 	real_foo "$@"
> 	pop_x
>   }
> 
> and then real_foo() is free to return however it likes. I wonder if you
> could even wrap that up in a helper:
> 
>   disable_function_tracing () {
> 	# rename foo() to orig_foo(); this works in bash, but I'm not
> 	# sure if there's a portable way to do it (and ideally one that
> 	# wouldn't involve an extra process).
> 	eval "real_$1 () $(declare -f $1 | tail -n +2)"
> 
> 	# and then install a wrapper which pushes/pops tracing
> 	eval "$1 () { { push_x; } 2>/dev/null; real_$1 \"\$@\"; pop_x; }"
>   }
> 
>   foo () { .... }
>   disable_function_tracing foo

We can wrap all functions at once:

  eval "$(declare -f \
                test_cmp \
                test_cmp_bin \
                <....> \
                write_script |
        sed -e 's%^\([a-zA-Z0-9_]*\) ()% \
                \1 () { \
                        { disable_tracing; } 2>/dev/null 4>/dev/null \
                        real_\1 \"\$@\" \
                        restore_tracing \
                } \
                real_\1 ()%')"

Yeah, not particularly pretty, but with the s/// command broken up
into several lines it's not all that terrible either...  And at least
it doesn't need extra processes for each wrapped function.

We should also be careful and don't switch on tracing when returning
from test helper functions invoked outside of tests, e.g.
'test_create_repo' while initializing the trash directory or
'test_set_port' while sourcing a daemon-specific lib.

Alas, 'declare' is Bash-only, and I don't see any way around that.
Bummer.


On a mostly unrelated note, but I just noticed it while playing around
with this: 't0000'-basic.sh' runs its internal tests with $SHELL_PATH
instead of $TEST_SHELL_PATH.  I'm not sure whether that's right or
wrong.

