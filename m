Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 209C41FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 15:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756656AbeAHPJz (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 10:09:55 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:39068 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755386AbeAHPJy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 10:09:54 -0500
Received: by mail-io0-f182.google.com with SMTP id g70so14238835ioj.6
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 07:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0op8+FPphkuBzSHOktjzfI8iti93THTPwxvge6SVllc=;
        b=VHqd9TkriUiV9Y8shven3taW4EA6iIITHCr8MM+8KOP3zAH4TO5LPJUl64vv1YMogc
         OcZgbwt7gSTO6qJZe/B/iLYkX0d7XmCTg/dkRr0of23i0zjEEsnrU516X3k85bX88gJX
         NAn41vrK4XOusRVqVvzVzdW1wypRo9Bzhtxd0aqD7/vCZxs7TUgmw0DaV3/vJqimrokD
         F9gHVHlmYSZCoN377PRoS44fy3JmVQm7EUT3HkUGTR2NuhSyJASLpNPJg/1wfpPBtdGp
         4MNMUbephlWn+sqZg4vnhgZrrOIP3mIMjfJomSsSXfErG6sJ/riLvz18wa5+REvlPr3L
         e+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0op8+FPphkuBzSHOktjzfI8iti93THTPwxvge6SVllc=;
        b=XszpEh3o0pKkjncyGJ+rdp303yNwXf5V97qLj+E/nYurQZubOkWhQ/V2ESNR3gyRPu
         QoCqTp/ANXWIkH/ijfi7eg2RDC6oweJ3bZr0h4BHA4+a5IGYaT4k8yc+UjIez4A4xFZ9
         NOcBLHtuPDRN5I+dDwKDZARBLtTpnyEymIsZeido3bb0cctdui4pSyZw28phrZGmw9+y
         sJNxKaieD3GYptBY8vdjQUay+J0qGG+yNE1YSFO6xVitCmzztuGbgaIkkrm0zGuaQ9dC
         v6jkwv8BY2POINtoGkZb1H3anqt0qSFswEqy70WF2nclWG9dhCMdBy11nS/oQdA90ktq
         K4Ug==
X-Gm-Message-State: AKGB3mJwQh+58kNHcj+S0f0yNKRv4dZdkzmhMovERfPg7rvoQWW+q0yW
        xhZSdR26YsFhPitrS84McLZMoqqTirgfXXu8Oh8=
X-Google-Smtp-Source: ACJfBosfWLEsnmZs41JoRo9QEbZGIEQq2XND/a3m9ZuQiUYPtO3EImETGQ8ZFkNgamoN3BEILTFHguaQuNI1DRtQwYM=
X-Received: by 10.107.3.199 with SMTP id e68mr10855338ioi.96.1515424193779;
 Mon, 08 Jan 2018 07:09:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.113.199 with HTTP; Mon, 8 Jan 2018 07:09:53 -0800 (PST)
In-Reply-To: <CAELBRWLV7wQm_b9Lvj67KiAMAxq6vNOzA3z62S-f5=3A5LyjZQ@mail.gmail.com>
References: <CAELBRWLyZ5s2Wvk2U5Ks2adx23Z+51dbEs3QbAq+5nGLe21srQ@mail.gmail.com>
 <20180106082116.11057-1-martin.agren@gmail.com> <CAELBRWJJYfRUxkzoeFfHQbSL5xzPQKt4srdoge=4K4n=ChN-TA@mail.gmail.com>
 <CAP8UFD03-EPxQQk51RZgb9Osdb4P=B67CLU6PrEP0O9chcHOCw@mail.gmail.com> <CAELBRWLV7wQm_b9Lvj67KiAMAxq6vNOzA3z62S-f5=3A5LyjZQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 8 Jan 2018 16:09:53 +0100
Message-ID: <CAP8UFD1rO1cFCfZg53gG71qfbapkn3gVvja87YFiMBZTkOqNuw@mail.gmail.com>
Subject: Re: [BUG] v2.16.0-rc0 seg faults when git bisect skip
To:     Yasushi SHOJI <yasushi.shoji@gmail.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Jan 8, 2018 at 3:45 PM, Yasushi SHOJI <yasushi.shoji@gmail.com> wrote:
> Hi all,
>
> Thank you guys for insightful help.  I just read the code and now I understand
> what you guys are saying.  Yeah, I can say the fix is "spot on".
>
> But, to be honest, it's hard to see why you need "if (p)" at  the first glance.
> So, how about this fix, instead?

+    for (p = list, i = 0; i < cnt; i++, p = p->next) {

Here "i" can reach "cnt - 1" at most, so ...

+        if (i == cnt) {
+            /* clean-up unused elements if any */
+            free_commit_list(p->next);
+            p->next = NULL;
+        }

... "i == cnt" is always false above. I think it should be "i == cnt - 1".

And with your code one can wonder why the cleanup is part of the loop.

> I also found a bug in show_list().  I'm attaching a patch as well.

Could you send it inline as explained in Documentation/SubmittingPatches?

Thanks,
Christian.
