Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7749520A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750950AbdAWUGA (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:06:00 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37670 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdAWUF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:05:59 -0500
Received: by mail-wm0-f44.google.com with SMTP id c206so174490725wme.0
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Nf4im6Gc0p/pHh6rczgy9thcZX1HfqV0KswGxOAWNR4=;
        b=vKKNf1KpOF9uGEVC5U+cZL8Hejr7IkRLzdZeFIR6vDaGrFR/nG4uujjCNMLGve5S50
         QmWTOBN9PJCpzOn97Wc2s1sfOnpu0UusriihuRT9jvlV716Z78+UXKvC1wtrzj1d5bO8
         jYmFeQ1ePc8KdeCet4+oyO9/SV/QVXBFEt4020PCdkBaxf3q1A8Ooxoc7Q5YJ/aogIxu
         eBl/s9sRg9KUwiT0EyaHevJd5Pf7HWuCO3UEMBKO0BeEebspKNpNYxhIVgc4Pf31BuzU
         GKjkJv+XaKxUX4H9m+FPsbkzj8/g87GlktIZJwr5jdFJr9j6F15eNg3gdjiIpC2Zho9C
         MQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Nf4im6Gc0p/pHh6rczgy9thcZX1HfqV0KswGxOAWNR4=;
        b=nq7HpH6I+xXT6B4AWsB2jTOWghAQPkgLSiUDf/I1BPt0OSNJjIQndXak2g8sit3ok+
         nsirU09Es/DJZaoAETOd0BdqYd2wEjSeOclvSsqvjhFGXCOAEDnvknOd4SgBat+7UTOp
         U1c8S4Rwu2e4KNr3M3YD+BGG8X5GHSSqSVocLzp2sCHE8pkqyr/XYT9c7fBRFPb81att
         Z0bBdy4r8Nhr0Qfb7Kgg4q8aejonrKHvmoup6j2IHK8CXZ26ChhD6suw0rT+rlwRJusO
         XdfHoDre1VVMK5EY38FlgwxUKulwYYenoOidMcxzLDHDAmeXYsNIiG51ZL7ickg/ijzl
         aelQ==
X-Gm-Message-State: AIkVDXIc5sEpPwo82JnpSiL5i8HHk01VBHq3gu/TJeSEycGmf0M+kGfA3FznIhHj7ElClhtsWXo/ZNv/Qe3RLw==
X-Received: by 10.28.0.2 with SMTP id 2mr15666187wma.141.1485201956905; Mon,
 23 Jan 2017 12:05:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.145.193 with HTTP; Mon, 23 Jan 2017 12:05:36 -0800 (PST)
In-Reply-To: <xmqqd1fdtzgv.fsf@gitster.mtv.corp.google.com>
References: <20170121131629.16326-1-giuseppe.bilotta@gmail.com>
 <xmqqpojeu14h.fsf@gitster.mtv.corp.google.com> <CAOxFTczut_CGGxmbrVFzhn_o4=StTOY6N1mEAw75Ro2Q4tzWgQ@mail.gmail.com>
 <xmqqd1fdtzgv.fsf@gitster.mtv.corp.google.com>
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Date:   Mon, 23 Jan 2017 21:05:36 +0100
Message-ID: <CAOxFTcxRjWS-=wyGBVOtg-tfCHrqqAr9rVOcvkyxXwJHonN_Tg@mail.gmail.com>
Subject: Re: [RFC PATCH] Option to allow cherry-pick to skip empty commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 23, 2017 at 7:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> By the way, I noticed going over the code that the -allow options are
>> not stored, so that in case of interruption they will be reset, is
>> this intentional or a bug?
>
> I do not know offhand, but given the history of the two commands, I
> would guess it was a bug simply overlooked when people bolted "a
> series of commits" mode onto these commands that originally worked
> only on a single commit.

It seems like a bug to me. I'll prepare a new series that also fixes
this. I still don't see how to force a complete reread of the index
after running a git reset (which I need for the --skip command), but
maybe I'll add a WIP of what I have for --skip so far and people can
comment on that.


-- 
Giuseppe "Oblomov" Bilotta
