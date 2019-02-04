Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EFAA1F453
	for <e@80x24.org>; Mon,  4 Feb 2019 21:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfBDVti (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 16:49:38 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33050 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbfBDVth (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 16:49:37 -0500
Received: by mail-ed1-f66.google.com with SMTP id p6so1320851eds.0
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 13:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=N2GqIR4uz87kr3YnUIpSzuY4RxVn1TsG0FPO+d/8mbo=;
        b=b6eYkwXnjJLZvvLK44Xg53cRWsxr2SeiRY3nvynyMbsFAxJHs8+PXY1Aul53wMTPLQ
         9JFG78n3s37GIyfPUDv++OY4CmFZ4FIq9FUzzzuV1hHOAtkgGIG/fVLMzcDuGSr5MjHv
         zXyhzNiXX1r1J1Y0eeh0mocz1yFrLqTDHjPP9Mk1kkaV+WUX9vZQnqk849oqu7Atc74o
         nVASv/hbbZa96pcIEwJhBD1JHfd0qiVkVubo0YyHdi6odxa+DtGNmtIHTs8YDQtNQa7L
         aGnoyJKJnsBUuKpOS3sIrA6oHE8umGPqFvmlQzTb7YiR3sUSI/7daZfWtjiJ4clSnuqu
         q3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=N2GqIR4uz87kr3YnUIpSzuY4RxVn1TsG0FPO+d/8mbo=;
        b=bg+pDOzWSjtf2jRThzDwNdY/U24C+qqZbBhnZ5LL6KOewqsrV6Z7112sLi+ctZiXFq
         /aJiwrRBwZpxbbSC/Av9z2s44PuMzVktNM4SZKbG5e0PVgIV65U+HXCk4u/sBDdSy5ZJ
         kbFfwmntgVoEAHmX3XOJZHhByqN6FwEzuEKCQvutXsbNzpYq5th6N+oTVhwBlyXTXVIw
         xYlNCZq0AGz+kXV7sPRBZBPqWxuCquKHNOJRlustHd5QZzyxj5tES5ruFd297ge9ZSvV
         AtdD2ZqDd7cssyvT0i0Hl1fQKyuncUqL8vZkNqT9DBrSe8FcrdLoExeTJBGvpsl+xM+I
         wQow==
X-Gm-Message-State: AHQUAuZGrHRAZ43u9jn8GgDhYJsw/QdfKysKgQvcJGwJnz86lUVWBIWz
        A52xZUGe4kvUih6NVgySDI4=
X-Google-Smtp-Source: AHgI3IZvb2xzvj5b1EVWu9M0Dq0UUGTo+ggNH3NZr2Axgqvtslf59Q8NC2Wmd0PnAOCyjcTeL2EHcw==
X-Received: by 2002:aa7:dc51:: with SMTP id g17mr1132766edu.115.1549316974924;
        Mon, 04 Feb 2019 13:49:34 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id y16sm4549173edb.41.2019.02.04.13.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 13:49:34 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH] diff-tree doc: correct & remove wrong documentation
References: <1292425376-14550-12-git-send-email-pclouds@gmail.com> <20190204103618.17992-1-avarab@gmail.com> <xmqqpns7tg2x.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqpns7tg2x.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 04 Feb 2019 22:49:33 +0100
Message-ID: <87sgx3kyvm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 04 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>>  <path>...::
>>  	If provided, the results are limited to a subset of files
>> -	matching one of these prefix strings.
>> -	i.e., file matches `/^<pattern1>|<pattern2>|.../`
>> -	Note that this parameter does not provide any wildcard or regexp
>> -	features.
>> +	matching one of the provided pathspecs.
>
> Correct.
>
>> -
>> -
>> -LIMITING OUTPUT
>> ----------------
>> -If you're only interested in differences in a subset of files, for
>> -example some architecture-specific files, you might do:
>> -
>> -	git diff-tree -r <tree-ish> <tree-ish> arch/ia64 include/asm-ia64
>> -
>> -and it will only show you what changed in those two directories.
>> -
>> -Or if you are searching for what changed in just `kernel/sched.c`, just=
 do
>> -
>> -	git diff-tree -r <tree-ish> <tree-ish> kernel/sched.c
>> -
>> -and it will ignore all differences to other files.
>
> All of the above give still useful piece of information to the
> readers.  I do not think it is a good idea to assume familiarilty
> with pathspec limiting to all readers---a new reader must start
> somewhere and diff-tree may just be a random place s/he started at.
>
> So I do not think it is a good idea to drop this example or the
> section from the page.

I was aiming for something like what e.g. "git-ls-files" says, which is
just:

    Files to show. If no files are given all files which match the other
    specified criteria are shown.

But yes, having an example is good, but with this removed isn't the
example we show in "RAW OUTPUT FORMAT" now just below sufficient to show
what this remove section was trying (and failing) to do, i.e.:

    git-diff-tree [-r] <tree-ish-1> <tree-ish-2> [<pattern>...]
        compares the trees named by the two arguments.

That doesn't have --abbrev, but I think it's enough to leave that
discussed in "OPTIONS" above.

>> -The pattern is always the prefix, and is matched exactly.  There are no
>> -wildcards.  Even stricter, it has to match a complete path component.
>> -I.e. "foo" does not pick up `foobar.h`.  "foo" does match `foo/bar.h`
>> -so it can be used to name subdirectories.
>
> I agree with the patch that this paragraph should go.
>
>> -An example of normal usage is:
>> -
>> -  torvalds@ppc970:~/git> git diff-tree --abbrev 5319e4
>> -  :100664 100664 ac348b... a01513...	git-fsck-objects.c
>
> Interesting.  This does not work (and I do not think it has ever
> worked) for a tree object 5319e4, but it works as advertised for a
> commit object.
>
> The description section has this near the top
>
>        If there is only one <tree-ish> given, the commit is compared
>        with its parents (see --stdin below).
>
> I think s/given,/& it must be a commit-ish and/ would be appropriate
> there; please include such a fix in a reroll.
>
> I agree with this patch that it is a good idea to drop this example;
> it is more appropriate to use "git show" on the commit-ish in the
> case of the given example anyway.
>
>> -
>> -which tells you that the last commit changed just one file (it's from
>> -this one:
>> -
>> ------------------------------------------------------------------------=
------
>> -commit 3c6f7ca19ad4043e9e72fa94106f352897e651a8
>> -tree 5319e4d609cdd282069cc4dce33c1db559539b03
>> -parent b4e628ea30d5ab3606119d2ea5caeab141d38df7
>> -author Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr 9 12:02:30 2005
>> -committer Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr 9 12:02:30 =
2005
>> -
>> -Make "git-fsck-objects" print out all the root commits it finds.
>> -
>> -Once I do the reference tracking, I'll also make it print out all the
>> -HEAD commits it finds, which is even more interesting.
>> ------------------------------------------------------------------------=
------
>> -
>> -in case you care).
>> -
