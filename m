Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6806E1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 12:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeJZVQ1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 17:16:27 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:33895 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeJZVQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 17:16:27 -0400
Received: by mail-ed1-f43.google.com with SMTP id w19-v6so1161046eds.1
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 05:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=e/JH935i0XM0TSbsIOSSRqvKpPw4MloNjazC4dDTWfQ=;
        b=F/iW9ToJ+88mKU4dnSSVzvtCgCBymkpSCNvNGUMPfcnlDRY87jxU/hBuRcbpj2+oQF
         cn4limO2Tx+HnMsU/s1C66mGrovqIAvrNp0m4ieHOcARr0/bT5b/Yahe4vbuZP84/Byl
         9MQ3/hPssqU1oevdPcodZaXMmoIRz7vPoxrbL09L/W6FuZEx0X+eJmnjr7IcNhQtRWPE
         Wk0i4IrqH4C5mHEa1BZyieWKD3rTxv4preXWmpqDTNcGnB7gQSFDUe97ckKMH2xJjhm9
         cwD7eX6Si5jmgtkFVPVX+PfiKRYotQpGJeLCuCmL/zBmSX7mU7O8lvEueiPDzSTkXNtl
         Dh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=e/JH935i0XM0TSbsIOSSRqvKpPw4MloNjazC4dDTWfQ=;
        b=KvQK57TrN4H5kGDxUk9KbJkVOGc/CGsLmxoQwAccVU7NOjiN6we+BhUhsWOq3BIYjy
         LopS9LULCvTSXhLFEKTbQQJumhVOvGS3xPl/CLRcGCZcG3GQONcJeNChhlR0VxlCcPsW
         XiYv2w2Jk3UG6sR6qhvG/QDYJnDCzdXTkiBfXkis0gbY74FeDxpAVFa6Xd4XytcRGTZr
         /I68iNbL5n/yer1KtF9NUpNd6egR+BBFxU5ytaloppPxyDufhvJgIBO1viS5Gm4vEcnT
         EiE2E2g8uWESg3njf0C/63X4oOMoXZTKh0MPsH/1TXtGlVC6YPjV21VIDV864CiOFbeA
         3fPA==
X-Gm-Message-State: AGRZ1gKkZUodT9m37ic8GQyn6qYRfL7jFacw4OHNV7Ma5e1CVgZKhvf5
        o0YkFL/VpipsiMoBBh2Sl8Q=
X-Google-Smtp-Source: AJdET5eD67vMpQY+HbT93uyrK+nMmNuiFqUpP3hfa/lMk0N11s+HI3csD1bbUDVh3mEJZ+ZVuYN27g==
X-Received: by 2002:a50:98a6:: with SMTP id j35-v6mr2237302edb.273.1540557567985;
        Fri, 26 Oct 2018 05:39:27 -0700 (PDT)
Received: from evledraar (223-81-146-85.ftth.glasoperator.nl. [85.146.81.223])
        by smtp.gmail.com with ESMTPSA id n6-v6sm2217586ejh.2.2018.10.26.05.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 05:39:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Junio C Hamano <gitster@pobox.com>,
        "lhf635\@163.com" <lhf635@163.com>, git <git@vger.kernel.org>
Subject: Re: the opposite of .gitignore, whitelist
References: <201810251039388653199@163.com>
        <xmqqh8hak2mh.fsf@gitster-ct.c.googlers.com>
        <c166b421-a228-8349-0815-2ebb9dcab998@lakedaemon.net>
        <20181026093644.GA20876@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181026093644.GA20876@sigill.intra.peff.net>
Date:   Fri, 26 Oct 2018 14:39:26 +0200
Message-ID: <87tvl8lw5d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 26 2018, Jeff King wrote:

> On Thu, Oct 25, 2018 at 10:38:46AM -0400, Jason Cooper wrote:
>
>> On 10/25/18 1:37 AM, Junio C Hamano wrote:
>> > "lhf635@163.com" <lhf635@163.com> writes:
>> >
>> >> I have a good idea, add a file to git that is the opposite of .gitignore...,
>> > Do negative patterns in .gitignore file help without inventing
>> > anything new?
>> I did this several years ago in an attempt to track /etc/ (minus
>> ownership, of course) without storing secrets in the git history. As
>> the system grew and was maintained (read: crap added), the negative
>> patterns grew untenable. I quickly realized it wasn't the correct way
>> to solve the problem.
>>
>> Unfortunately, shortly after realizing this, I left that project. So I
>> never had the chance to develop a proper solution. However, the concept
>> of a '.gitonly' file was exactly was I was seeking. So, for what it's
>> worth, I've definitely had at least one legit usecase for this feature.
>>
>> The usecases tend to center around tracking select files within the
>> rootfs of a full-blown operating system. Or a subset thereof.
>
> I think what Junio meant is to ignore everything by default, like:
>
>   echo '*' >.gitignore
>
> and then selectively use negative patterns (and being in .gitignore,
> that makes them positive "yes, include this") to add things back:
>
>   echo 'foo' >>.gitignore
>
> which ends up being roughly the same as your .gitonly concept.
>
> I don't offhand remember if you might run into problems where a
> subdirectory is ignored by the "*" and we do not even recurse into it. I
> think it would work OK as long as you put everything in the top-level
> gitignore, like:
>
>   echo 'subdir/file' >>.gitignore
>
> but I didn't test.

This doesn't work, as explained to myself in this commit in a private
project I have where I tried this a while ago:

    I thought this was a bug:

        (
            rm -rf /tmp/git &&
            git init /tmp/git &&
            cd /tmp/git >/dev/null &&
            echo '*' >.gitignore &&
            echo '!*.txt' >>.gitignore &&
            echo '!.gitignore' >>.gitignore &&
            touch foo.png foo.txt &&
            mkdir dir &&
            touch dir/bar.png dir/bar.txt &&
            git add *.txt &&
            git add */*.txt;
            git status --short
        )

    But it's a limitation, gitignore(5) says:

        It is not possible to re-include a file if a parent directory of
        that file is excluded. Git doesn’t list excluded directories for
        performance reasons, so any patterns on contained files have no
        effect, no matter where they are defined.

    So as a hack exclude anything that looks like a file with an
    extension.

    1 file changed, 1 insertion(+), 1 deletion(-)
    .gitignore | 2 +-

    modified   .gitignore
    @@ -1,3 +1,3 @@
    -*
    +*.*
     !*.gpg
     !.gitignore

I.e. here I'm trying to maintain a repository where I only want
.gitignore and *.gpg files committed and everything else ignored, but it
only works for one directory level.

There's not a lot of room left in the gitignore syntax, but I suppose we
could extend it to add some "I really mean it" negative pattern which
would override previous patterns even if those previous patterns matched
directories.

Just fixing it as a bug would make the ignore process slower, since we
could no longer just ignore directories and would always need to
recursively scan them.
