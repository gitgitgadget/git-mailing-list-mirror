Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 601951F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 11:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeJKSez (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 14:34:55 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:39391 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeJKSey (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 14:34:54 -0400
Received: by mail-wm1-f52.google.com with SMTP id y144-v6so8899273wmd.4
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 04:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JkwyGeSRxboUkHJRnQZCm7f3THvWzR0hUOFPnJoZDkw=;
        b=JBivAbfVNNzY0TEnF98E716myQtoS5ZmKJX+BqeShofE8hVV2r/MoMl5CY7aZOjsk5
         ftBPAUllrlkN/tL3A7MOlfY5QpMg/EMrZNyqwFbiSSIWM45FJ3jBdTGvSLbwXndjrpDT
         XXKSCA6LUQXNw5IwOnzVrhoEdGpDtnZ9WhHVdHDOhAV4gm5CEpwE24CKjNN3Be/kzPod
         JolD6fQP8O64xKKGyTahqQPJk7gqMenca1j5O9g4O6oSKlnpRDZtb03sPhhUdk/bSHo7
         TjeMIPShBZHsWOCHwFTHvzrYy2SSqW0bP3zh4i2d21Xwc0keerJW2b1JiesOaP/W4TO3
         AjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=JkwyGeSRxboUkHJRnQZCm7f3THvWzR0hUOFPnJoZDkw=;
        b=NDk1e67pSWF/BvnzvBhT0oQIPq/YiJvxb+MqZIYlZG3BQBf8jeZturg0ZNgPdN8iNu
         Sfl1kSutHojhCpXry5Cn96UbJT1ukuBjILnKX5+gfbjxpZuI1IMKR6wUNkhPwpxkXYjs
         AKQv6Hq169mdn9OkymR3wRiahhNUalgxZW0iFYuMS3a1yHyrnGOuC9jzhPi9RgCOcH1D
         JBRsxdC9fywqojlUsCgWgRf/KeIEXOMm4KQqL14OZnFZtoKTcY+0Myz2g00Pvsgosxu6
         aBVIPVZD59dd+xJtMbT7AaKZHxbM7IMfXmsUYuNjPJt6hOGmzCDvLzeCFtUn6kIJYGDt
         yZnw==
X-Gm-Message-State: ABuFfogVcMDjG3jiSzduG+81yaWETb9B7SweMGH2xUndTPTW2Tc1gw1E
        n/J41mvBCPLCu+bBC4Cfat3GllEnsWc=
X-Google-Smtp-Source: ACcGV62TR6NWpdNX9PQg2gzocZI764wlOCqbly2BqSZA1Gm33YvkLtHbyTEw3uVaFFo7GKHNtD25XA==
X-Received: by 2002:a1c:f312:: with SMTP id q18-v6mr1288511wmq.14.1539256087976;
        Thu, 11 Oct 2018 04:08:07 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id u5-v6sm37328878wru.16.2018.10.11.04.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 04:08:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     dana <dana@dana.is>
Cc:     git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [BUG] gitignore documentation inconsistent with actual behaviour
References: <C16A9F17-0375-42F9-90A9-A92C9F3D8BBA@dana.is>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <C16A9F17-0375-42F9-90A9-A92C9F3D8BBA@dana.is>
Date:   Thu, 11 Oct 2018 13:08:06 +0200
Message-ID: <87bm80eo6h.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 11 2018, dana wrote:

> Hello,
>
> I'm a contributor to ripgrep, which is a grep-like tool that supports using
> gitignore files to control which files are searched in a repo (or any other
> directory tree). ripgrep's support for the patterns in these files is based on
> git's official documentation, as seen here:
>
>   https://git-scm.com/docs/gitignore
>
> One of the most common reports on the ripgrep bug tracker is that it does not
> allow patterns like the following real-world examples, where a ** is used along
> with other text within the same path component:
>
>   **/**$$*.java
>   **.orig
>   **local.properties
>   !**.sha1
>
> The reason it doesn't allow them is that the gitignore documentation explicitly
> states that they're invalid:
>
>   A leading "**" followed by a slash means match in all directories...
>
>   A trailing "/**" matches everything inside...
>
>   A slash followed by two consecutive asterisks then a slash matches zero or
>   more directories...
>
>   Other consecutive asterisks are considered invalid.
>
> git itself happily accepts these patterns, however, apparently treating the **
> like a single * without fnmatch(3)'s FNM_PATHNAME flag set (in other words, it
> matches / as a regular character, thus crossing directory boundaries).
>
> ripgrep's developer is loathe to reverse-engineer this undocumented behaviour,
> and so the reports keep coming, both for ripgrep itself and for down-stream
> consumers of it and its ignore crate (including most notably Microsoft's VS Code
> editor).
>
> My request: Assuming that git's actual handling of these patterns is intended,
> would it be possible to make it 'official' and explicitly add it to the
> documentation?
>
> References (the first one is the main bug):
>
> https://github.com/BurntSushi/ripgrep/issues/373
> https://github.com/BurntSushi/ripgrep/issues/507
> https://github.com/BurntSushi/ripgrep/issues/859
> https://github.com/BurntSushi/ripgrep/issues/945
> https://github.com/BurntSushi/ripgrep/issues/1080
> https://github.com/BurntSushi/ripgrep/issues/1082
> https://github.com/Microsoft/vscode/issues/24050

Yeah those docs seem wrong. In general the docs for the matching
function are quite bad. I have on my TODO list to factor this out into
some gitwildmatch manpage, but right now the bit in gitignore is all we
have.

Our matching function comes from rsync originally, whose manpage says:

    use ’**’ to match anything, including slashes.

I believe this is accurate as far as the implementation goes. You can
also see the rather exhaustive tests here:
https://github.com/git/git/blob/master/t/t3070-wildmatch.sh

Note the different behavior with e.g. --glob-pathspecs v.s. the
default. There's also stuff like:

    $ grep diff=perl .gitattributes
    *.perl eol=lf diff=perl
    *.pl eof=lf diff=perl
    *.pm eol=lf diff=perl
    $ git ls-files ":(attr:diff=perl)" | wc -l
    65

And then the exclude syntax. This is not in .gitignore:

    $ git ls-files ":(exclude)*.pm" ":(attr:diff=perl)" | wc -l
    41
    $ git ls-files ":^*.pm" ":(attr:diff=perl)" | wc -l
    41

I.e. we have wildmatch() on one hand and then the pathspec matching.

For an unrelated thing I have been thinking of adding a new plumbing
command who'd get input like this on stdin:

    1 text t/t0202/test.pl\0\0
    2 text perl/Git.pm\0\0
    3 text *.pm\0\0
    4 text :^*.pm"\0:(attr:diff=perl)\0\0
    5 match glob,icase\04\03\0\0
    6 match icase\04\02\0\0
    7 match \04\01\0\0

Which would return (in any order):

    1 OK
    2 OK
    3 OK
    4 OK
    5 NO
    6 NO
    7 YES

Or whatever. I.e. something where you can as a batch feed various
strings into a program in a batch, and then ask how some of them would
match against each other.

The reason for this is to extend something like git-multimail[1] with a
config where users can subscribe to changes to paths as declared by git
pathspecs, and be informed about which of the glob rules they defined
matched their config.

Right now you'd need to e.g. for a "git push" run each match rule for
each user with such config against each changed path in each commit
that's pushed, but plumbing like this would allow for feeding arbitrary
combinations of those in and ask what matches against what.

The reason I'm on this tangent is to ask whether if such a thing
existed, if it's something you can see something like ripgrep
using. I.e. ask git given its .gitignore and .gitattributes what thing
matches one of its pathspecs instead of carrying your own bug-compatible
implementation.

1. https://github.com/git-multimail/git-multimail/
