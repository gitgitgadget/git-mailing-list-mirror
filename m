Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC83CC433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 10:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D288611ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 10:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhEHKVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 06:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhEHKU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 06:20:59 -0400
X-Greylist: delayed 468 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 08 May 2021 03:19:58 PDT
Received: from shout02.mail.de (shout02.mail.de [IPv6:2001:868:100:600::217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5835BC061574
        for <git@vger.kernel.org>; Sat,  8 May 2021 03:19:58 -0700 (PDT)
Received: from postfix01.mail.de (postfix02.bt.mail.de [10.0.121.126])
        by shout02.mail.de (Postfix) with ESMTP id 1340FC00FB;
        Sat,  8 May 2021 12:12:08 +0200 (CEST)
Received: from smtp03.mail.de (smtp03.bt.mail.de [10.0.121.213])
        by postfix01.mail.de (Postfix) with ESMTP id EA49FA006A;
        Sat,  8 May 2021 12:12:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
        s=mailde202009; t=1620468728;
        bh=Igdb3MnpfgK7PiWy6TBzYTRm/EJOb4UUuNGvpHeTtcw=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=d8N4MNfucuxUu8fcjOhu2nOPXReU0vFtTLcdwqUyCgZacz+zDmIxspcocsEBe8f92
         Ujguo83j1Yt7H77XWNVPeMk+uyAFtbOSq5g3BCJ0j8b/MO85QoT8wwtWnlonjQNtJ+
         PF4yAwfR9ClJVl2uIx3Y59xWNnoXoknYLMG4vv8fQh5LE+bXF/lvlpzwMgzVcnC9BL
         EzOuoH2yhOQ2atHXj83iDAXlC9GwekZQoYZiwPQN87qzvt63MXEsgRI9HOe8nW4Sg7
         7OFypFodcxLvrBg8Fh0SM8AKJtX9N/0DdIKo9hu/tE/cezbghQt4zdSmNxrqva+xCB
         8C5suIigd//+Q==
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp03.mail.de (Postfix) with ESMTPSA id BBB10A0484;
        Sat,  8 May 2021 12:12:06 +0200 (CEST)
From:   Stefan Moch <stefanmoch@mail.de>
Subject: Re: Preserving the ability to have both SHA1 and SHA256 signatures
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        dwh@linuxprogrammer.org
Cc:     git <git@vger.kernel.org>
References: <20210508022225.GH3986@localhost>
 <CAP8UFD0vp-zZv=Q1+KWv8PHnxTuspTw2aSCUp8QUic0HOSyq4w@mail.gmail.com>
 <xmqqim3tvhlr.fsf@gitster.g> <609645cb11f72_1fc6d208ee@natae.notmuch>
Message-ID: <f4f782c4-3adc-8c1c-428d-8037426fc475@mail.de>
Date:   Sat, 8 May 2021 12:11:51 +0200
MIME-Version: 1.0
In-Reply-To: <609645cb11f72_1fc6d208ee@natae.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 1752
X-purgate-ID: 154282::1620468727-000063E7-D58F927C/0/0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> Junio C Hamano wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>> (Not sure why, but, when using "Reply to all" in Gmail, it doesn't
>>> actually reply to you (or Cc you), only to the mailing list. I had to
>>> manually add your email back.)
>>
>> I am sure why.  DWH, please do not use mail-follow-up-to when
>> working with this list.  It is rude and wastes people's time (like
>> the practice just did by stealing time from Christian).
> 
> I agree with this, but shouldn't this be written in some kind of mail
> etiquiette guideline? Along with a rationale.

Good idea to write this down. How to use the mailing list is only
sparsely documented. The following files talk about sending to the
mailing list:

 1. README.md
 2. Documentation/SubmittingPatches
 3. Documentation/MyFirstContribution.txt
 4. MaintNotes (in Junio's “todo” branch, sent out to the list from
    time to time as “A note from the maintainer”)

2, 3 and 4 mention sending Cc to everyone involved.

2 is about new messages.

3 and 4 specifically talk about keeping everyone in Cc: in replies.
Both in the context of “you don't have to be subscribed and you
don't need to ask for Cc:”.


Please also note, that mutt sets the “Mail-Followup-To:” header by
default for sending to known mailing lists, unless “followup_to” is
set to “no”. Whether or not it removes the sender address in this
header depends on the list address to be known to be subscribed to
or simply known to be a mailing list. It also does not set this
header if no recipient address is known as a mailing list.

http://www.mutt.org/doc/manual/#followup-to
http://www.mutt.org/doc/manual/#using-lists
