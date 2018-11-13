Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 383931F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 15:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbeKNBgm (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 20:36:42 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36327 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeKNBgm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 20:36:42 -0500
Received: by mail-it1-f196.google.com with SMTP id w7-v6so19062008itd.1
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 07:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s94PD7d8e6EEO29ToGZG6revJCGfz/T6pMQIlFzlSmk=;
        b=UvsGMk8CJ0HPhenCpu32mlRUyfVHRBeCP83U079FHSqUOzX2GbGJmHs/ES9H1mFpCf
         Ec96G0ma2pRXZ8qmDIEG8wAtrniITG/ZCGI6PzjZaEpdoFItdwnIGINrOpxyYIfNcfTc
         n/hOm7nPh5FylHiOQSFwSz02jPC6W1RmLZicoMcrMBPxay8q6daGhFGHx92PQLsOw+Y8
         NGRG4xeghPgwRXu0DfN++UuE9WwVfCNuX480Xclu8V5SGXWAXKNWjnHz9F6WCgWUBOZI
         UQDbzVJiB0O0+9qPzQS6PR+AllPb6oY7v6FYO5TmvXhNctjpFTY2Igo9O0f2on8VFfJZ
         g4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s94PD7d8e6EEO29ToGZG6revJCGfz/T6pMQIlFzlSmk=;
        b=iFDGT02D4GdVlyF45NYXqaUklVOZFLwDHk5bsLL8PLkkcW3j44I4Wwutk9wTUNMVUL
         28g5FFLxb1DjZ/YXw0hOvbnKn/ozG47Cf9Do6V8RNS9b5WofMRHcF1qUiO6tJvvZjAWE
         SpM4420a5Ow5P01gU3s2iawo3ZBkiCR2X/W5MAhg6TM99UkduHFosSqcu95+G1ynzDh4
         aPuPkMOIqXC3t2z63EtfpDKm9KqcRKhPbPzEHTf5tt2XWl+ixcgAapGengOXAN/S4zoi
         om/w6aIEAW4FIF58W9YV+xmVSxdAd0rUH4RM9CoaFXny5FvHE+pzjNxpSwTw/tNWsvWy
         8Rgg==
X-Gm-Message-State: AGRZ1gKrhAFJCghLco8HNG3n5yGw1IcxumHDUQfh/X+DiJ1RuyIyMwBC
        BzOXmFS0LhPNycOwmbYu1MYGfT1brgCEzic/MxE=
X-Google-Smtp-Source: AJdET5cI2FIGk9YiZoQ+M6L2ejUmqJp57uo4zLhosnz1uzWLj0sTTOz34A3L3EtvbCYo5kXXhmB/iVitTbqbCQ/V3Wc=
X-Received: by 2002:a24:f589:: with SMTP id k131mr3532042ith.10.1542123484535;
 Tue, 13 Nov 2018 07:38:04 -0800 (PST)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com> <20181113003817.GA170017@google.com>
 <20181113003938.GC170017@google.com> <xmqqpnv9zsu6.fsf@gitster-ct.c.googlers.com>
 <20181113011207.GE170017@google.com>
In-Reply-To: <20181113011207.GE170017@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 13 Nov 2018 16:37:37 +0100
Message-ID: <CACsJy8DNo1Q96jb5nwJ8vREFu=ZmbN29+uoH17N2VVy80k387Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] ieot: default to not writing IEOT section
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 13, 2018 at 2:12 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Junio C Hamano wrote:
>
> > How about
> >
> >       hint: ignoring an optional IEOT extension
> >
> > to make it clear that it is totally harmless?
> >
> > With that, we can add advise.unknownIndexExtension=false to turn all
> > of them off with a single switch.
>
> I like it.  Expect a patch soon (tonight or tomorrow) that does that.
>
> We'll have to find some appropriate place in the documentation to
> explain what the message is about, still.

Also from the last discussion, if I remember correctly, this
"ignoring" is considered harmless and could be suppressed most of the
time. But commands like 'fsck' should always report it.
-- 
Duy
