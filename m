Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9180A1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389875AbfG2UDD (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:03:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42775 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389557AbfG2UDC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:03:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so28550713pff.9
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wyfbrwDVn7/ESmIyVxWJ8ZvbGzccMjl97O2jnd1+ABA=;
        b=rfs2/uKGwzr92Jf4L96KfZnShdd19ju90oujHFSai5PY5VXumZmEmcz0FweKZTqnoH
         /UbpGPrgo9vy8tEx3RQvc+mBHKdIsSFdCfFJ3lZ5hvNFKEhSV5QMqoIDGhkNr1+Trny1
         ZMs+uz+fiL7OLPSt9JBGRnJL/DvTfrHWd49UqvkURE315UtZCG2NakQARs5tbuNnrw4L
         FZOkkEEuRyolqTI70yozw+53LXnrYZXKCePvDe+ekv1MdLpHcwzMgmmJLejf+IWh+dNs
         T2a+24KlCd9NUG3xfEC5Sr4kN18zP72b3cGRKJdLTJizcOhb/Yupawe7TG34EGIVJdJg
         BdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyfbrwDVn7/ESmIyVxWJ8ZvbGzccMjl97O2jnd1+ABA=;
        b=rCzx5SJ+mqfYTsc0hzeeKjIF+O3eP7Cx7rQFEqmc0AUEyKJSbr0lltxtbd2ExpupCu
         OIJNqdZSdDQBkrwlN0t193EJ/6zzQWQ2zHnI5lgy6osa/9TVoKFTLqJXQCHyEfmDT5qD
         GZJKmChGagogBlsQBaUvLeAG6l7oKSupOIMhYq1tz/SB+ArKLV9avUF3TUJU9bb94+od
         XH4SrYHPkqwjCC6cUUwdvDC2jTOXwXCpfQkj/rouMm1N9wdNCWrM1pMnEUAATJy+JACv
         CDOgKQmgug/Hu+dDRPcp62fvWiuGCdtvqLsCnMjNXf4KI+V7H/ma5faE23neeDympfJj
         swAQ==
X-Gm-Message-State: APjAAAW0Ht13MdM7UOoaS0gEN3Z3ahBcu+3jjutFNiTRK3dMkPN8/b6W
        O+Vyg/kHojUYkY7epn2q43Ywz1SEGQTDyc4EXqM=
X-Google-Smtp-Source: APXvYqxcwcOEi5v7GDIFlwYBmbeliNpnu4hOnxbEYoUs6/CWpoOfnCXUuWVeXbB1jUGzE/ucPozEyzkNr9hXgwa96sk=
X-Received: by 2002:a65:430b:: with SMTP id j11mr104045943pgq.383.1564430581750;
 Mon, 29 Jul 2019 13:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbml6pgfm.fsf@gitster.mtv.corp.google.com> <cover.1563490164.git.steadmon@google.com>
 <2440ad35e420db868596435dea3d634e37dbe671.1563490164.git.steadmon@google.com>
In-Reply-To: <2440ad35e420db868596435dea3d634e37dbe671.1563490164.git.steadmon@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 29 Jul 2019 22:02:49 +0200
Message-ID: <CAN0heSqNEgFXLOTBssW6wSnqqvWDGfOU+TW7_5T2V6t+GCAm5A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] merge: --no-verify to bypass pre-merge hook
To:     Josh Steadmon <steadmon@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>, stefanbeller@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 19 Jul 2019 at 00:57, Josh Steadmon <steadmon@google.com> wrote:
> From: Michael J Gruber <git@grubix.eu>
>
> Analogous to commit, introduce a '--no-verify' option which bypasses the
> pre-merge hook. The shorthand '-n' is taken by the (non-existing)
> '--no-stat' already.

I don't understand this "(non-existing)". I realize this message is two
years old, maybe lots older still, and I haven't dug. But at least
*now*, "-n" seems to behave like "--no-stat", suppressing "--stat", from
my simple testing.


Martin
