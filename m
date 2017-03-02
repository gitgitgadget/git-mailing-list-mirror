Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B3A71F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 19:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753851AbdCBTg6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 14:36:58 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:36403 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753658AbdCBTg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 14:36:56 -0500
Received: by mail-io0-f176.google.com with SMTP id l7so60701042ioe.3
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 11:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=glKlHP+3XIqcdbjDxrdLvxULg2QeErotI8aqdfiYiTc=;
        b=CmIVQiH/RpgljZcjP4ZNCac39uN6Sxn48wKO6QZ7MlNKXsEyXQGf1J6hRUVOM4IgZ3
         rsXTz6B8l5G2YlT9XSMNceYoLATGJg6AJX0fv77VjS8OGid2i3qZ9LCmgBN58f/xEZBv
         sfZXKIqP8OP08Lsp1iemnlcbWhnnkYuaGjZFAvxvL993qJnNHqDPYcvVhQH65XZMfWXF
         fhuv842rh9JMedG9pIhgdXqusOvR+cDUl7yfEf1oY60p2Gm54p+b/eK4e794NEl2rhei
         zPOK++4o9scDgHDrD5xbXt8sZot2tYXnpNn9Tx0YA1kKCYW6Y87GVlAf9SvPT3cDbI+3
         91FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=glKlHP+3XIqcdbjDxrdLvxULg2QeErotI8aqdfiYiTc=;
        b=Yr30z2mvmgxrWyTD+9zYgDgEWhg5qzD7HvZXNtO4feVg+d1KI2Hp/K9WD66QLsRW57
         ozSsLWFJtCcGXbEzbXnBuvt3arphnNo6waEXqdOg5Y+q0KWWRBzJZsuwH9VJ/BCckamf
         MZIpADz7kMZ/riRXQx9fAYNEEXjD4l/87hD0GCaRu21obftUbnN8p4LtWtUaFEZ/W/n1
         y2PRGQN5bdFCpCYACRWLglC2XD8w6jlO3b0v/VHFM/kvdnwS11zyRle0CFAvuTM+E9vR
         IsoJmJd9p09S20pH497abLkCjsvTuzb7EKz9ye4LONB1PAB8J+/cy3RPJW+6G3IqSU4i
         hx2Q==
X-Gm-Message-State: AMke39lAk7FOvC5+cgZwHWYD6o8KgMunuYjK7pzKGs4ZC3brKVX438iclBmhM0ZP/vfSk/P6/jHfKhNkbg7vFQ==
X-Received: by 10.107.5.213 with SMTP id 204mr14748567iof.189.1488481476952;
 Thu, 02 Mar 2017 11:04:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Thu, 2 Mar 2017 11:04:36 -0800 (PST)
In-Reply-To: <85221b97-759f-b7a9-1256-21515d163cbf@jeffhostetler.com>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan> <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com>
 <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com>
 <xmqq37ewhji1.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1703012227010.3767@virtualbox>
 <CA+55aFys5oQ0RySQ+Xv0ZDussr-xZNh4_b3+Upx_d9VPWmpM8Q@mail.gmail.com>
 <alpine.DEB.2.20.1703012334400.3767@virtualbox> <CA+55aFy9=jBJT36FC2HiAeabJBssY=jE=zLxwrXWzhpiFkMUXg@mail.gmail.com>
 <20170301231921.2puf7o7jkrujscwn@sigill.intra.peff.net> <CACsJy8D3h1KAaKi_Esc98za3LqXaB=YeW0Yu+VAV9UnX5vmttg@mail.gmail.com>
 <alpine.DEB.2.20.1703021539330.3767@virtualbox> <CA+55aFzscLaviJac-SB65WFYViY=wyAF3EWOnhHSuzSuFLdPTA@mail.gmail.com>
 <85221b97-759f-b7a9-1256-21515d163cbf@jeffhostetler.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Mar 2017 11:04:36 -0800
X-Google-Sender-Auth: JS70kVGyzVXDl6AfH3Sp5ezdO8s
Message-ID: <CA+55aFxbfmW6UL8cd=s43=bbDkTaqUmah0+snhzR3j_Fyv=-gw@mail.gmail.com>
Subject: Re: [PATCH] Put sha1dc on a diet
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Stevens <marc.stevens@cwi.nl>,
        Dan Shumow <danshu@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 2, 2017 at 10:37 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>>
>> Now, if your _file_ index is 300-400MB (and I do think we check the
>> SHA fingerprint on that even on just reading it - verify_hdr() in
>> do_read_index()), then that's going to be a somewhat noticeable hit on
>> every normal "git diff" etc.
>
> Yes, the .git/index is 450MB with ~3.1M entries.  verify_hdr() is called
> each time we read it into memory.

Ok. So that's really just a purely historical artifact.

The file index is actually the first part of git to have ever been
written. You can't even see it in the history, because the initial
revision from Apr 7, 2005, obviously depended on the actual object
hashing.

But the file index actually came first. You can _kind_ of see that in
the layout of the original git tree, and how the main header file is
still called "cache.h", and how the original ".git" directory was
actually called ".dircache".

And the two biggest files (by a fairly big margin) are "read-cache.c"
and "update-cache.c".

So that file index cache was in many ways _the_ central part of the
original git model. The sha1 file indexing and object database was
just the backing store for the file index.

But part of that history is then how much I worried about corruption
of that index (and, let's face it, general corruption resistance _was_
one of the primary design goals - performance was high up there too,
but safety in the face of filesystem corruption was and is a primary
issue).

But realistically, I don't think we've *ever* hit anything serious on
the index file, and it's obviously not a security issue. It also isn't
even a compatibility issue, so it would be trivial to just bump the
version header and saying that the signature changes the meaning of
the checksum.

That said:

> We have been testing a patch in GfW to run the verification in a separate thread
> while the main thread parses (and mallocs) the cache_entries.  This does help
> offset the time.

Yeah, that seems an even better solution, honestly.

The patch would be cleaner without the NO_PTHREADS things.

I wonder how meaningful that thing even is today. Looking at what
seems to select NO_PTHREADS, I suspect that's all entirely historical.
For example, you'll see it for QNX etc, which seems wrong - QNX
definitely has pthreads according to their docs, for example.

                     Linus
