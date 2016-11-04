Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBF962022D
	for <e@80x24.org>; Fri,  4 Nov 2016 23:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750898AbcKDXEL (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 19:04:11 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36522 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbcKDXEK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 19:04:10 -0400
Received: by mail-lf0-f47.google.com with SMTP id t196so75200182lff.3
        for <git@vger.kernel.org>; Fri, 04 Nov 2016 16:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9ydsKSWaEaNjR/9qO3gMicWbwj/QezPZQfbc3aH/5+w=;
        b=oKoQmNOj3VyJxmDPUZ/bKTohqx5Tr5cEr5gFHghbi0WhmWBarD/odK4YfqCFZlwdlD
         sCh+465trZVrDc3QFLvv00SC4UhzGn4ophE2h0PQNqrwf2xIOZwYoucTzeUX13bDOXlu
         Ju/F4//SlNzQokosRvQdtMhzHft/+mUHF+AJjQMGHAdQMMuibhKvnwsESSE2F3KRmPkh
         5zLgW/hfkqsQXarBBApG/kmeKuMKVfxagPn6uYJl5XamSMPgp/liMVAr/x1dvt0PgdM7
         56R+0jkmFiTxm5pJj/cPj0I8mO9N4vt408TICAUbr/lKp9MYf/unRRZ1JyjfVcvZ2Az7
         w0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9ydsKSWaEaNjR/9qO3gMicWbwj/QezPZQfbc3aH/5+w=;
        b=NlTbK3cg1a5Nac4NyONSnfg8U3Gp0Vv5NKz8czFCr5Uh67ucBbZREJcrU9SW3D2Vdh
         CfVKeSBPWfpYIHJTVOKjK3x9cs59AmFoy2tml9W8Y9zH/VBegM7p2Zk0kBMS1szCWzXa
         i1/zpZbZU1my6NhQhCQeAWPIstDBFFut4QOvqLXKhHv+2blWd4R0Zf8Hg+hsrPAX9r7M
         UzyKapzg6SOu+qG5AG1TkonL5naSwDDz+8fQ4BvfqVyqzGfW6QNf6D+ZG7qHyrZ5D5e2
         PYoFDo6rdai7Ay3PM9rKytXPybR5Jd+7lbdIr1s5clAoOd1b+i+KE8k1GdNNicbGdi//
         +jtg==
X-Gm-Message-State: ABUngvdlF6ew0sU2TXdmxGNOY6AjoD1HmRmSSqQ9+pCIf0N8xr+nFp8XW7lc2414jlMwLHtd3wcaPz64NNMhWw==
X-Received: by 10.25.93.84 with SMTP id p20mr2612692lfj.151.1478300648859;
 Fri, 04 Nov 2016 16:04:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Fri, 4 Nov 2016 16:04:08 -0700 (PDT)
In-Reply-To: <20161104211959.3532uiud27nhumt7@x>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com> <CAP8UFD2+A0MUKazAfSwCvv61TJRPuoOzH5EkqcrBOUi4TcuoDw@mail.gmail.com>
 <20161104211959.3532uiud27nhumt7@x>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 5 Nov 2016 00:04:08 +0100
Message-ID: <CAP8UFD13sDOFuyZMWuoJeLFt_LAsfAHFBHpRwcdAGmA22xNEKQ@mail.gmail.com>
Subject: Re: Regarding "git log" on "git series" metadata
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        "Shawn O. Pierce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
        Stefano Zacchiroli <zack@upsilon.cc>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 4, 2016 at 10:19 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> On Fri, Nov 04, 2016 at 09:47:41PM +0100, Christian Couder wrote:
>> On Fri, Nov 4, 2016 at 6:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> >
>> > Imagine we invent a new tree entry type, "gitref", that is similar
>> > to "gitlink" in that it can record a commit object name in a tree,
>> > but unlike "gitlink" it does imply reachability.  And you do not add
>> > phony parents to your commit object.  A tree that has "gitref"s in
>> > it is about annotating the commits in the same repository (e.g. the
>> > tree references two commits, "base" and "tip", to point into a slice
>> > of the main history).  And it is perfectly sensible for such a
>> > pointer to imply reachability---after all it serves different
>> > purposes from "gitlink".
>>
>> The more I think about this (and also about how to limit ref
>> advertisements as recently discussed in
>> https://public-inbox.org/git/20161024132932.i42rqn2vlpocqmkq@sigill.intra.peff.net/),
>> the more I think about Shawn's RefTree:
>>
>> https://public-inbox.org/git/CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com/
>>
>> Couldn't a RefTree be used to store refs that point to the base
>> commit, the tip commit and the blob that contains the cover letter,
>> and maybe also a ref pointing to the RefTree of the previous version
>> of the series?
>
> That's really interesting!  The Software Heritage project is working on
> something similar, because they want to store all the refs as part of
> their data model as well.  I'll point them to the reftree work.

Yeah, I know them :-) and I think I have already told Stefano
Zacchiroli about this, but I am not sure anymore.
Anyway I am CC'ing him.

> If upstream git supported RefTree, I could potentially use that for
> git-series.  However, I do want a commit message and history for the
> series itself, and using refs in the reftree to refer to the parents
> seems like abusing reftree to recreate commits, in a reversal of the
> hack of using commit parents as a reftree. :)

Yeah, maybe :-) But the properties of the existing Git objects we
already use wouldn't change at all.

> What if, rather than storing a hash reference to a reftree as a single
> reference and replacing it with no history,

In what I suggest the history is kept because the new reftree has a
ref that points to the old one it is replacing.

Yeah, this reftree history maybe seen as "redundant" with the commit
history, but in my opinion this can be seen as a "feature" that will
prevent us from "mucking" too much with the commit object.

> a reftree could be
> referenced from a commit and have history?  (That would also allow
> tagging a version of the reftree.)

I think that tags are already allowed to point to any kind of Git
object, so tagging a reftree should be allowed anyway if we add a
reftree object.
