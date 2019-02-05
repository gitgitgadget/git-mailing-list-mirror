Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A34E31F453
	for <e@80x24.org>; Tue,  5 Feb 2019 15:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfBEPwL (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 10:52:11 -0500
Received: from mail-vs1-f48.google.com ([209.85.217.48]:40826 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbfBEPwL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 10:52:11 -0500
Received: by mail-vs1-f48.google.com with SMTP id z3so2434324vsf.7
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 07:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LuTqnwS1x0u6A6gnfLiJm/nC0YbwQUeGQNY22lml7Nw=;
        b=kzClYGKoKoRQgSfnstpf+XavcelZ3mzVeQnQw3YqqmO2v89AmN+AazkCDEDXitRcas
         pDsW/1K8Na8PzeTBk3XIT6uSzEPB2TKNk7Dtxu1YgxoWjZgz8xjCrGi4hBzg4LdAxBlP
         tjWwsuhIMOs/IcqtHA6EiWpQp1okk0V+WQztQwGTR5SiymG/O5Uz0EDAcPp/IrXlu3k4
         YzRzpD9xzIa6wWWqVE6lKrD6ev3hXxX4yNbXPVppaQ1CSLeXCh8pKzqV6EZ7iaVV4Vt7
         sIsOzS5bOXhrPn6Aneh/utL71CesKjZQQje4o7/4JQkB0HsCJRziSUWp2aiNCoyaofuW
         57Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LuTqnwS1x0u6A6gnfLiJm/nC0YbwQUeGQNY22lml7Nw=;
        b=XO8iUAILvGUvRixbls6xSos3rL5WdIGLR1BN/TWkcs9MYYVfO/kV7tDdhefEdkKqfV
         LtUtCAUih5g6HVHtAT5IiW9DsBudEUbv1/Fyv3tNK4fIFomlyqYMrAgzvv+ZXQwH/03j
         7GS6FzNz7PfNsvkmiIykr23FOyNw03rVd0TLm7sAM2jU54CyVX1Bq2MQZ32dalZaSuis
         iU5rFKf9iU9YSgvJVsvbdj4XTtd1c2uTpz6ViUQr+Og9LHxaMCscWd5XhfLyCO7RkOqv
         75+Df61bXXXSS7jas2BEA6Wrxywdv0Y7iAFSg2Xp11TIfkWNnf8kcSX/IjKlV3b+4z/r
         F7fw==
X-Gm-Message-State: AHQUAubi5/aGUs89+AGvalHFiGoRyhJPcJNodbhXFX6O7FgtrSttCwUB
        yEKPxoD/yV+0Nu1P/sscODpLTc1c5r0rTyW0rfU=
X-Google-Smtp-Source: AHgI3Iagg13U7YpGHm98iPh8YiAn8FKHhrDv7eRmjVY49hvqtCGeAo2oRwFq4PUzcDhnTo3wknJc7NxtXLAf2sIDZpI=
X-Received: by 2002:a67:44c4:: with SMTP id y65mr185701vsf.53.1549381929860;
 Tue, 05 Feb 2019 07:52:09 -0800 (PST)
MIME-Version: 1.0
References: <20190126221811.20241-1-newren@gmail.com> <20190204200754.16413-1-newren@gmail.com>
 <xmqqlg2vtfmo.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg2vtfmo.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 5 Feb 2019 07:51:56 -0800
Message-ID: <CABPp-BGyL5BAejK-P-EdscFdH3C6uR7e6CbgNe-9doy-mkw-vg@mail.gmail.com>
Subject: Re: [PATCH v4] log,diff-tree: add --combined-all-names option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 4, 2019 at 1:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> There is one place that says combined-all-paths, and everywhere else
> it says combined-all-names.  The former is probably techincally more
> correct, I think ;-)

Looks like I had a mixture of my original name (combined-with-paths)
and the one someone else suggested (combined-all-names).  Since you
like the hybrid better, I'll switch them all over to it.

> > The combined diff format for merges will only list one filename, even if
> > rename or copy detection is active.  For example, with raw format one
> > might see:
> >
> >   ::100644 100644 100644 fabadb8 cc95eb0 4866510 MM   describe.c
> >   ::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM   bar.sh
> >   ::100644 100644 100644 e07d6c5 9042e82 ee91881 RR   phooey.c
> >
> > This doesn't let us know what the original name of bar.sh was in the
> > first parent, and doesn't let us know what either of the original names
> > of phooey.c were in either of the parents.  In contrast, for non-merge
> > commits, raw format does provide original filenames (and a rename score
> > to boot).  In order to also provide original filenames for merge
> > commits, add a --combined-all-names option (which must be used with
> > either -c or --cc, and is likely only useful with rename or copy
> > detection active) so that we can print tab-separated filenames when
> > renames are involved.  This transforms the above output to:
> >
> >   ::100644 100644 100644 fabadb8 cc95eb0 4866510 MM   desc.c  desc.c  desc.c
> >   ::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM   foo.sh  bar.sh  bar.sh
> >   ::100644 100644 100644 e07d6c5 9042e82 ee91881 RR   fooey.c fuey.c  phooey.c
> >
> > Further, in patch format, this changes the from/to headers so that
> > instead of just having one "from" header, we get one for each parent.
> > For example, instead of having
> >
> >   --- a/phooey.c
> >   +++ b/phooey.c
> >
> > we would see
> >
> >   --- a/fooey.c
> >   --- a/fuey.c
> >   +++ b/phooey.c
>
> Do we have the three "rename from fooey.c", "rename from fuey.c" and
> "rename to "phooey.c" extended headers, too?  That's what I meant in
> my response, but I do like what I see in the above example ;-)

Ah, gotcha.  I'll look into whether it's possible to hook it up to
diff.c's fill_metainfo() .

Elijah
