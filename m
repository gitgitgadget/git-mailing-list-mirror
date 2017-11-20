Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E9B220954
	for <e@80x24.org>; Mon, 20 Nov 2017 06:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751149AbdKTGEK (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 01:04:10 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:38565 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbdKTGEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 01:04:09 -0500
Received: by mail-it0-f51.google.com with SMTP id n134so10520346itg.3
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 22:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=amlsdzTDNa6abUSojkMC3HR1RzhFBHbHhBCZqnLTPIg=;
        b=bAHI6VYHy5aCxiiRNPX3p8Xkvq804yp2b/g39QB0/ZO0p80LDb8BwW3GxgIB91EAa9
         /IwEwzf5k349yq8pgIY66QWlASqMmTwu5cigA/bXM3qYzf2f0LEZS6nQgmAXL/zXWKHK
         XUVZcChfGcCqe9cJcXTijUnK7JUoRSRx39RnHRwveULdmo3520sX5fhD+6yDZfey9ME3
         3hJbkWx5KYExFq/DeWNfoBKPZbXTDpma5mx7UUmVvXJBid3ny69IcGtGvACvqG1/9j1l
         LjW2AE/vh62gGInjpBavTTOUdbp5WJys27XLjENn2M7EbfeQ9ISMwqg5z7OyAeWnSDyt
         998Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=amlsdzTDNa6abUSojkMC3HR1RzhFBHbHhBCZqnLTPIg=;
        b=sv6hAlnHv5xilFdAnxe23oa0QsSolvg5drpPtZ8X3ZH2QQOVnx6uOyBCeU6Ukhzscu
         KzZ2W4KLqJNUcxT0ddsiPsfVN8cOUBLrU8MVbmzus2EJNZY93tmfZYGFHX/nLkamctzu
         XFAiS1O5jUwKD5Cn2yu4WopmQXep6Hq0d0nnncyw5z306MBJmLtUEQ7Dh85STlmWLhG7
         R6cfiJL9cBPDZlnxXSityoNZgzwAla3RqeCd/Fai8Nf9g9J8ao6SfmSqRhkvBzM25F96
         N7NIBNRGiKkRax2C4SW3DOHruMaaAWTJ0bM8nRdYTCT2GYgGt+bkFcwYZqKHfjvAERpm
         F9WA==
X-Gm-Message-State: AJaThX7VztNwf9Gk+3WqH2bFjtRBZjHisL/xFs7EvcDSktID+vV9AfZh
        xGVOGx/yccSNRbpu7dVwmIFUkMT/lyiM5pIwfOpRlbAd
X-Google-Smtp-Source: AGs4zMYwpUItrqcVMMTNyIJ/hGBSaoJjjG+p0pHun+37l2bmJ/0v3y4D4KcMGSbmkljf3HFU1OdIa+wEOWdZ1gVdSYA=
X-Received: by 10.36.93.138 with SMTP id w132mr8064569ita.139.1511157848101;
 Sun, 19 Nov 2017 22:04:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.88.8 with HTTP; Sun, 19 Nov 2017 22:04:07 -0800 (PST)
In-Reply-To: <xmqqr2stldcm.fsf@gitster.mtv.corp.google.com>
References: <20171113231155.GA26779@eros> <20171114110500.GA21175@kroah.com>
 <20171114213320.GB905@eros> <CA+55aFyMxkS=8JzZ+ROOAFkwR45EKBnQ0GUMQS4f+r_-fFWiEA@mail.gmail.com>
 <CA+55aFzhK+GPO1_Zm2PoQiq5-cHAq6nz1ejrBhGhWX-KAjTU9A@mail.gmail.com> <xmqqr2stldcm.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Nov 2017 20:04:07 -1000
X-Google-Sender-Auth: WBeHka95NB5d7Ty9D0x4khfSH_o
Message-ID: <CA+55aFxoNsnKvwAX+bub+amL3s3Znvi-fpRTENP31mrgdZZHRw@mail.gmail.com>
Subject: Re: git pull
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 19, 2017 at 7:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>> Which is simple. Just create a .git/hooks/prepare-commit-msg file that contains
>>
>>   #!/bin/sh
>>   sed -i 's|ssh://gitolite.kernel.org/|git://git.kernel.org/|g' "$1"
>>
>> and make it executable, and git will do that commit message editing for you.
>
> This should work with any recent versions of Git (1.7.4.2 and
> upwards), but it still is a workaround.  Should we mark it as a
> feature request in the Git land to record the URL you typed as-is in
> the builtin/fetch.c::store_updated_refs() function, instead of the
> one that was rewritten by the insteadOf mechanism?

The main problem with the prepare-commit-msg thing is actually that is
such a nasty hack, and it can change other things than just the remote
name. Maybe "gitolite" might be mentioned in the shortlog of the
merge, and then the sed script comes and edits that part too.

It is really not a huge issue simply because those things don't really
happen in real life, but it's the main thing about that
prepare-commit-msg hook that makes me go "eww, what an ugly hack".

But it's an ugly hack that just happens to work pretty well in practice.

And yes, I looked at alternatives. In fact, I  looked at a couple of
other approaches:

 - the one you mention, namely to remember the original url, and use
that instead

 - the one I'd actually prefer, which is to generalize the whole
"insteadOf" to work in more situations.

Why would I prefer that second one? It turns out that the "original"
isn't actually necessarily what I'd want either. Several people send
me pointers to "https://git.kernel.org/" and I prefer rewriting them
to git:// just to be consistent. And now that people have started
doing the "insteadOf", their pull requests end up containing that
"git@gitolite" version of the URL, so again, I'd actually like to
rewrite the url _anyway_ in the commit message.

For example, for the kernel, the git.kernel.org address is very
common, but it also has a very common path prefix, so almost all pull
messages for the kernel have that

   "git://git.kernel.org/pub/scm/linux/kernel/git/"

part in common, and I have occasioally felt that it's not adding a lot
of value particularly as it shows up in shortlogs and gitk. I could
change my own rules for the first line (instead of the "Merge tag xyz
from git://..." maybe I should just have my human-legible version),
but I have also considered just rewriting the url to something that
shortens that very common thing.

So maybe

   Merge tag 'sound-4.10-rc4' of
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound

could be instead

   Merge tag 'sound-4.10-rc4' of git://kernel.org/../tiwai/sound

which would keep the _important_ part, and shorten the boilerplate
part away. But that kind of "insteadOf" would only be for the message,
since the end result isn't actually a "real" URL at all, it's
literally a rewritten shorthand.

Again, I can do all of this with the sed script. But again, it's kind
of wrong to do it on the whole message, when it's really only the url
that it should affect.

So it would potentially be nice to just have a generic "rewrite the
url" model, where you can do it for remote fetches, but you could also
do it for just the commit message, or you could do it for doing pushes
(we do have that "pushinsteadof" already - exactly because you might
want to pull and push from different versions, with the push having to
use ssh).

But, as you say:

> It would probably need an update to "struct remote" to have new
> fields, to teach remote.c::alias_all_urls() not to overwrite the
> url[] (and pushurl[] merely for symmetry) fields, to add a field to
> "struct transport" and teach transport.c::transport_get() to record
> the original URL in it so that builtin/fetch.c::fetch_refs() can
> give it to store_updated_refs() instead of the rewritten one.

Yes, the existing "insteadOf" is actually hidden surprisingly deep in
the remote code, and it's very non-obvious. That works ok for the pull
and push case, but really not for just the message rewriting case
(which doesn't happen as part of the pull, but as part of the "git
merge" that then takes the FETCH_HEAD or MERGE_HEAD that contains the
url, and parses that).

Anyway, it's not a big deal. The sed script works. It's a bit hacky,
but it does the job.

I might have wished for a different model, but it's almost certainly
not worth the effort unless somebody really gets fired up about this
and decides they really want to do it.

            Linus
