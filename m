Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 188511F453
	for <e@80x24.org>; Mon,  5 Nov 2018 15:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbeKFAmv (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 19:42:51 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41948 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbeKFAmu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 19:42:50 -0500
Received: by mail-io1-f65.google.com with SMTP id a5-v6so6747336ioq.8
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 07:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=GCgADqQjLSmABm+iso4eFlEDlAcMDnWGaqcVDYl9qXg=;
        b=ntmOV6PuukthuRko0vVe+RPT32fo98KVgfo3HAWtOYL/Jg/cTMNMyj+ElsNLqfZhWi
         BMI2X754c3vCL6FHNQ3hU9P5peQUa44AOzpufWL0iXSZa6CgYmz29Yf6kQrlWgIL9gkJ
         2932FWlECviW1ruQV4V+prvIWxpnPNn0cv1NvcUQcKiL5deCcczoJGjMLHLsVKXBCCvV
         olVQsghTEuijnELYNdxYKgBq7S9sVNbQ2MD/5PJQE6qm9Kq+osTz6Y1mMg5VpiZCh3cv
         7EtupMQ8QiXOjRa7CsXLQ3060hZgh5odT6J69OHEzKrYk21VEiYt4g1M4zxD7XZdmgwS
         IMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=GCgADqQjLSmABm+iso4eFlEDlAcMDnWGaqcVDYl9qXg=;
        b=bJNHOFJFo4/A08o+7ksyJ3gKeXyAL3Pz5go6eLMwsrDYtx9ycA3lnGC71+w6UZCqjS
         t083Kd2nYby64yl12ELL/Z4SNvxvHNArwjZiigzEY3xHLGQ3K2qZ0d7X2bnXkLpyR00e
         uRtNGSnXg4Y969I89xgawBALiZEnNQGcqKAXBCRTuE0Q91VIKivQBkULFenp3rdS2JHh
         8Ei2GBe5nSmdkIEXYX0XvRmJo36U+3VOPRsenj0bgJzGGG4Q1mfeKox5nRKUIGksUEoi
         HQmPzQkq4CGUjphuMHLDdHERa+ik2p9BmpuBZyStMaHxajuQoCaIBsTaVzS5Pvg7GaSX
         6WeQ==
X-Gm-Message-State: AGRZ1gLL+wS61dF2LZw++Wga8VFX/8XkI6CDxJVc/fdQKwuMKzewfSja
        fuUQkVWge7rxSm+UAR3MzBHqB6V2PEVxKOtLSaM=
X-Google-Smtp-Source: AJdET5ehtxExZ5tJJagu825SEJ2RxnTAtqM7ScUZRYarGg6NPP1HtJ+eCU8SeZXsZs09mxTlgI3kH2w4ZYJR5SQsf/8=
X-Received: by 2002:a6b:216:: with SMTP id 22-v6mr18582387ioc.118.1541431358366;
 Mon, 05 Nov 2018 07:22:38 -0800 (PST)
MIME-Version: 1.0
References: <20181030191608.18716-1-peartben@gmail.com> <CACsJy8DbiVZYmY11Nt4c_+egSi5tz0iVq7rNv2BiVdyJ4htgvw@mail.gmail.com>
 <1f7efd07-4881-daa7-cd1d-145bbf3ffcc8@gmail.com> <CACsJy8BqWu0YG_Q8EFNeDgrRhYCCKBU+zPJjrhAWFU_gTDCoXg@mail.gmail.com>
 <20181104210105.GK731755@genre.crustytoothpaste.net>
In-Reply-To: <20181104210105.GK731755@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 5 Nov 2018 16:22:10 +0100
Message-ID: <CACsJy8BHp_m3M8FjzyXuquPq65UiXTxi2goUzP2GECYzXq7T6Q@mail.gmail.com>
Subject: Re: [RFC v1] Add virtual file system settings and hook proc
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 4, 2018 at 10:01 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On Sun, Nov 04, 2018 at 07:34:01AM +0100, Duy Nguyen wrote:
> > On Wed, Oct 31, 2018 at 9:53 PM Ben Peart <peartben@gmail.com> wrote:
> > > It's more than a dynamic sparse-checkout because the same list is also
> > > used to exclude any file/folder not listed.  That means any file not
> > > listed won't ever be updated by git (like in 'checkout' for example) so
> > > 'stale' files could be left in the working directory.  It also means git
> > > won't find new/untracked files unless they are specifically added to the
> > > list.
> >
> > OK. I'm not at all interested in carrying maintenance burden for some
> > software behind closed doors. I could see values in having a more
> > flexible sparse checkout but this now seems like very tightly designed
> > for GVFS. So unless there's another use case (preferably open source)
> > for this, I don't think this should be added in git.git.
>
> I should point out that VFS for Git is an open-source project and will
> likely have larger use than just at Microsoft.  There are both Windows
> and Mac clients and there are plans for a Linux client as well.
> Ideally, it would work with an unmodified upstream Git, which is (I
> assume) why Ben is sending this series.

Ah I didn't know that. Thank you. I'll have to look at this GVFS some time then.

If we're going to support GVFS though, I think there should be a big
(RFC perhaps) series that includes everything to at least give an
overview what the end game looks like. Then it could be split up into
smaller series.
-- 
Duy
