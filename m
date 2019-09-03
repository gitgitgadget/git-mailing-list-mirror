Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CBB91F461
	for <e@80x24.org>; Tue,  3 Sep 2019 05:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbfICFkO (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 01:40:14 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:34882 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfICFkO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 01:40:14 -0400
Received: by mail-lf1-f47.google.com with SMTP id w6so6443473lfl.2
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 22:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ynjWuzZOM2qjW8wsIwDMWvuvMU96U2Rd+prgHOy3X84=;
        b=YcFD6h+QDpF+u4J3fTMcQt0Sq62IK4TfRkIzYIN9eWYh09BHoFS0y3WeCaBizlfOSJ
         z4IjizCQmowuoxbqo3CNFbtMB2ND5x65BvqT6XHWV0LbC3dT9VRUEKZ2XP4uc9gp8GL7
         7iextgpW1BvraIi+CIKrgzdRWjVNa2LJiIsSv71A/q4aHTNIKUJTBCNaPzLq74sbUQ0r
         sIGwTbgZloAbGpsjyOUDYup83GCk5LDWGd3Jdxv7nEXm1+JNfrKmHR45y1WpOFzAsXee
         u+D8IiY78VwHUk4Qopipzl67IM+Fy0cpXLrjiIiOyDugmeW2LFouz6N//9dQ3o1z26mV
         VRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynjWuzZOM2qjW8wsIwDMWvuvMU96U2Rd+prgHOy3X84=;
        b=Dg392iKItanVdchxBpZ5k0O06kLFSKbFlZfZyCFQXfEYIfH6WiGffXkMnMXYBon2M+
         8WKLLpt/VNSWtSn1STNRWL3zHUOF7mc/1p5otb3I2dO9HsyMgXi6i1bjIIe7MRI8bPvu
         IFD+v5NYv56wbpQg+5AYHME6iGbIqgWj5w/ipg/M9fda6LSx/KWpZ398U+2eZiMbE51X
         o6tUcgI6VkKcE1yJ5yDYuBS6ACRdOoDImG4pmptkNb8TFQ7aq/MH4f3uOT4UUWV/2D1V
         /+JSeqLcKmJuTXRSo0KoaKPBoN2xeVeTAawoq7t6FvJEHP37YWkpuaMJSD4zMrBk2pxP
         ZIig==
X-Gm-Message-State: APjAAAUmP9qxkqTahpu7H8dtvXKCPqV+kVJg6Sb6ITsJesUGhfjuTfK8
        nsKtmDKuYWBoGVRVmTRpH8d7PYml1TlZdPhm2Mk=
X-Google-Smtp-Source: APXvYqwMbZYYIjAa43KMqHL3iu804RxO/xAx6FbZiSpSNkTVuKRefoFNYnM0Yn6PhPtSZvZaNRF73vUBRIOWns84ooA=
X-Received: by 2002:a19:a407:: with SMTP id q7mr17471971lfc.166.1567489212853;
 Mon, 02 Sep 2019 22:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=Jw4DAqTi3ROujtE=xBMYErMws6B6vhuXYMQA+5Q1ccow@mail.gmail.com>
 <CAGr--=JkNqcrcenp6F1_CHTun_9wPLVvEWGOFJW=ng=XfO+jHw@mail.gmail.com>
 <CAKPyHN3Zvf6gtKAq03s8AsguaOFG=g2huGRCTWmBVWioDBqFWw@mail.gmail.com>
 <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com>
 <CAKPyHN3S-jLWmfHUyH9mCBPjHCEaBCbrkVQEKFqHv59U37=Kyg@mail.gmail.com> <CAKPyHN08Z_9oByA8ruKwwXRcAfYPU95JaMb=pqQWwGwPVG=_og@mail.gmail.com>
In-Reply-To: <CAKPyHN08Z_9oByA8ruKwwXRcAfYPU95JaMb=pqQWwGwPVG=_og@mail.gmail.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Tue, 3 Sep 2019 07:37:50 +0200
Message-ID: <CAGr--=Jn87r_ySYkZmtqUBA40+fwdn0MbuN6_LNDO4mOWyoKTg@mail.gmail.com>
Subject: Re: feature request, git-gui: add hotkey to toggle amend/new
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Git List <git@vger.kernel.org>, bouncingcats@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 2, 2019 at 10:15 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> does Control-Tab works for traversal?


Bert,

Control+Tab works for traversal, but as a means to toggle new/amend
it's very tedious. I have to press Ctrl+Tab 9 times to select "new"
and 10 times to select "Amend"(!). Then 1 or 2 more times to go back
to the input area.
I sincerely doubt that this is your preferred method of switching
between new/amend. At this point we're better of letting go of the
keyboard and use the mouse, which is what I'm trying to avoid.

> I think this is short enough, so that wasting a Letter is not justified here.
I (also) often amend commits, so having a hotkey for this is quite a
necessity imo.


Birger
