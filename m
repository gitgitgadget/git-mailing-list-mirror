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
	by dcvr.yhbt.net (Postfix) with ESMTP id BB06F1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 16:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfHOQRW (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 12:17:22 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44177 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfHOQRV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 12:17:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id 44so2874479qtg.11
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 09:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=42xE9ZpEbl0RHRU6OQUJbqlp7lLoV9JzWeLGkHieLu4=;
        b=j1d+3/aWQH3v4q103VofsDSU4HLZ9X/CezZs1kJGcyRTJmiUekBrKs+9oDW0Pnzkj4
         XPWGmnD6apar2ELQ0FzbV4AdFxOzWhiXPeWlPXR/5j1s7rBlxHm2/HEngsjful2eGPOn
         34yHgPmsSckNs/0pswkFp6HsEW+b8XWAQILVdRu+GECT7QKlTodwsJ498+HmKI5H4fOG
         LhJZMRpP2Gg0RdTAi3X6libq5VswT/lD7Zg90ieuWHZnNkk9d8Pd/X7/kg1zFSN9bBk9
         oODy2//zEYW++Q6qQBMYsLjVeHrF6R6B1uQNj0mnF6iZCU6dwO3v8T2tgUK+ujI/fEMj
         cvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=42xE9ZpEbl0RHRU6OQUJbqlp7lLoV9JzWeLGkHieLu4=;
        b=gcC4Bxa/RF4ZiHaAKzTmzRzXCLSa/nAhpoJgT2dS9waXSfsxKTf+9JHvaIp3UolHs0
         H/uhi/Bk0lDokpErOowhxd6E1i/HZhCprDkSbp6NOmmTwzA4F0Lkf+DAjcl458WhE8/8
         8eMyXdIiVOhoe0S3RKmcVCYrGBK2gax+aqYJffp55bBO6/OKgKEaeI0qL6T/xK0IGbQy
         l3Jaogvj+VK+JYhTf7gKYqtH85K4auSmPJONorp/UUDTODDNL2EmyPvTeU2qs3Tp+nP9
         DTPrm404L8ZVVyomHDGvOMVIaAgWGkbzY7TEcvuhsMvCiOA4ZXVWTvfd4PCLrisfZqbh
         0MCg==
X-Gm-Message-State: APjAAAXVlSgLZx+zL8q8s3VPACkaVHaM4xT8MwWH2/QUPYc6oqs393x1
        E/+6ck3GgAiB8eaN0dGEAp0TE4r7unWElTbCPK8=
X-Google-Smtp-Source: APXvYqw2mV9W95+Vk4rVhRLrZcVmKsM/EQHy6L4ny5l7eZMiSWYN4lWJyzPtrMniaJToflM3oM6ltf8q/0rOolUkJMA=
X-Received: by 2002:a0c:a94b:: with SMTP id z11mr2187229qva.22.1565885840220;
 Thu, 15 Aug 2019 09:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190813160353.50018-1-vcnaik94@gmail.com> <b7f4b745-8942-6d90-dbc5-7f79f2cc323e@web.de>
 <xmqqr25o7qmf.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr25o7qmf.fsf@gitster-ct.c.googlers.com>
From:   Varun Naik <vcnaik94@gmail.com>
Date:   Thu, 15 Aug 2019 09:17:09 -0700
Message-ID: <CAK_rgsGSfL2zQLP59O+PUCLGz0X8c4UQ3Zg=9M+nCww5C+X_gA@mail.gmail.com>
Subject: Re: [RFC PATCH] unpack-trees.c: handle empty deleted ita files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 13, 2019 at 1:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> The original code considered that two entries with the same mode and
> the same "contents" are the same.  As nobody sane tracks an empty
> file for an extended span of history, that meant that most of the
> time, intent-to-add entries, which has the normal mode bits for the
> blobs (with or without the executable bit) and object name for a
> zero length blob, would have been judged "different".
>

I agree, this edge case is really arcane. The rabbit hole was deep :)

> So perhaps
>
> +       !ce_intent_to_add(a) && !ce_intent_to_add(b) &&
>
> i.e. "a cache entry is eligible to be same with something else only
> when its I-T-A bit is unset".
>

I decided to follow Ren=C3=A9's suggestion in response to this. Patch comin=
g soon.

Varun
