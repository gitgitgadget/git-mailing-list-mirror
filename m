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
	by dcvr.yhbt.net (Postfix) with ESMTP id F3C081F453
	for <e@80x24.org>; Tue, 16 Oct 2018 09:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeJPQ7t (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 12:59:49 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39783 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeJPQ7t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 12:59:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id d15-v6so20554408edq.6
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 02:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=IF2YNNNMHOBohpwLHiX/V6shCqrFCr0o4u2PtUqZe+o=;
        b=hXjaTatPfBSg4u88Yr74bOCjPbNHpOWNdFH3l753y+YKKkqhUjsaTVKzv2/EpZG6Sy
         bIRcLaD+wmB38mpf698DYneGqx9AmNHsvPb15//v+rh/fCmWtvXFF0i71TEGPAxDpie1
         NqKZbZmRez4uNmuGko7zzTQVxuTHjF3g638mq8paBvz0wjQEElK09QtICNodc4vOB7MI
         7qHFDJKpuf10VgB68Wv9y4RxomtcbN9xaZIoGfttXlucmUi5l6IHi4AR7K6TeHaZ20hn
         jOHBErJmKgSJZvkBTi4L8CjugteeEq/c6N7aZK/3MVEcpX/A/SKj8mwLkRTZoRwk260F
         m2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=IF2YNNNMHOBohpwLHiX/V6shCqrFCr0o4u2PtUqZe+o=;
        b=Zjsa0lSZE0c6oDplZ4xQqdnsq2GlG3HdhhPGraBH69rGu/LPBZOTDq1WcdqvsPCPwq
         ZqUX1ickug2Rq0ll41D/PU8m4CDwJ2eXbGVks5jnPM306NCyuYvxcdwrayzWQVg/glrl
         EOitwsbwn1Ty8CnwgyCFadNmXz22iP/0e3930yF1FbEmsuYGJv6cJwc0Oew+G3BYW9Du
         Xx1bfKk0UeE8s/kWoLX2u2JWSiial0UShsKrHlvwpJGuFMvCRVNVCwNam0ADq6El3mZS
         bVf5ctwKKCSJHYT9jIgnIKHMW/Dw5hh7RgPQG3JRaokNXQ+oTlHsg7eCF9ov57KG7eZl
         0IzA==
X-Gm-Message-State: ABuFfojBwvhXVXthe15iyoev+EJrxa9iAQYveBz9/akMYzfoDPULgcb9
        vYzRNzysgpi2kHsGzhTlexU=
X-Google-Smtp-Source: ACcGV62fuLAmgRCjznmEVagW9XepxiE5GmWpvIEFyt+ulXKSdkmdUZCO0fOQw1hZuPbMGT8K0F4b8g==
X-Received: by 2002:a50:f05e:: with SMTP id u30-v6mr29529247edl.91.1539681020578;
        Tue, 16 Oct 2018 02:10:20 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id g18-v6sm4845318edg.69.2018.10.16.02.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 02:10:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Per Lundberg <per.lundberg@hibox.tv>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Subject: Re: Ignored files being silently overwritten when switching branches
References: <7d6858c8-aa84-aa05-6c69-22dbbff7dfaa@hibox.tv>
        <20181016064049.GB25933@sigill.intra.peff.net>
        <7v4oepaup7.fsf@alter.siamese.dyndns.org>
        <vpqd3t9656k.fsf@bauges.imag.fr>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181016064049.GB25933@sigill.intra.peff.net>
Date:   Tue, 16 Oct 2018 11:10:18 +0200
Message-ID: <871s8qdzph.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 16 2018, Jeff King wrote:

> On Mon, Oct 15, 2018 at 01:01:50PM +0000, Per Lundberg wrote:
>
>> Sorry if this question has been asked before; I skimmed through the list
>> archives and the FAQ but couldn't immediately find it - please point me
>> in the right direction if it has indeed been discussed before.
>
> It is a frequently asked question, but it doesn't seem to be in any FAQ
> that I could find. The behavior you're seeing is intended. See this
> message (and the rest of the thread) for discussion:
>
>   https://public-inbox.org/git/7viq39avay.fsf@alter.siamese.dyndns.org/
>
>> So my question is: is this by design or should this be considered a bug
>> in git? Of course, it depends largely on what .gitignore is being used
>> for - if we are talking about files which can easily be regenerated
>> (build artifacts, node_modules folders etc.) I can totally understand
>> the current behavior, but when dealing with more sensitive & important
>> content it's a bit inconvenient.
>
> Basically: yes. It would be nice to have that "do not track this, but do
> not trash it either" state for a file, but Git does not currently
> support that.

There's some patches in that thread that could be picked up by someone
interested. I think the approach mentioned by Matthieu Moy here makes
the most sense:
https://public-inbox.org/git/vpqd3t9656k.fsf@bauges.imag.fr/

I don't think the rationale mentioned by Junio in
https://public-inbox.org/git/7v4oepaup7.fsf@alter.siamese.dyndns.org/ is
very convincing.

The question is not whether .gitignore is intended to be used in some
specific way, e.g. only ignoring *.o files, but whether we can
reasonably suspect that users use the combination of the features we
expose in such a way that their precious data gets destroyed. User data
should get the benefit of the doubt.

Off the top of my head, I can imagine many ways in which this'll go
wrong:

 1. Even if you're using .gitignore only for "trashable" as as Junio
    mentions, git not trashing your data depends on everyone who
    modifies .gitignore in your project having enough situational
    awareness not to inadvertently add a glob to the file which
    *accidentally* ignores existing files, and *nothing warns about
    this*.

    Between the caveat noted in "It is not possible to re-include[...]"
    in gitignore(5) and negative pathspecs it can be really easy to get
    this wrong.

    So e.g. in git.git I can add a line with "*" to .gitignore, and
    nothing will complain or look unusual as long as I'm not introducing
    new files, and I'll only find out when some-new-file.c of mine gets
    trashed.

 2. Related, the UI "git add <ignored>" presents is just "Use -f if you
    really want to add them". Users who aren't careful will just think
    "oh, I just need -f in this case" and not alter .gitignore, leaving
    a timebomb for future users.

    Those new users will have no way of knowing that they've cloned a
    repo with a broken overzealous .gitignore, e.g. there's nothing on
    clone that says "you've just cloned a repo with N files, all of
    which are ignored, so git clean etc. will likely wipe out anything
    you have in the checkout".

 3. Since we implictly expose this "you need a one-off action to
    override .gitignore" noted in #2 users can and *do* use this for
    "soft" ignores.

    E.g. in a big work repo there's an ignore for *.png, even though the
    repo has thousands of such files, because it's not considered good
    practice to add them anymore (there's another static repo), and
    someone thought to use .gitignore to enforce that suggestion.

    I have a personal repo where I only want *.gpg files, and due to the
    inability to re-include files recursively (noted in #1) I just
    ignore '*' and use git veeery carefully. I was only worried about
    'git clean' so far, but now I see I need to worry about "checkout"
    as well.

But maybe the use-cases I'm mentioning are highly unusual and the repos
at work have ended up in some bizarre state and nobody else cares about
this.

It would be interesting if someone at a big git hosting providers (hint:
Jeff :) could provide some numbers about how common it is to have a
repository containing tracked files ignored by a .gitignore the
repository itself carries. This wouldn't cover all of #1-3 above, but is
probably a pretty good proxy metric.

I thought this could be done by:

    git ls-tree -r --name-only HEAD  | git check-ignore --no-index --stdin

But I see that e.g. on git.git this goes wrong due to
t/helper/.gitignore. So I don't know how one would answer "does this
repo have .gitignored files tracked?" in a one-liner.
