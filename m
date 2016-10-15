Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7026209A9
	for <e@80x24.org>; Sat, 15 Oct 2016 08:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbcJOIq3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Oct 2016 04:46:29 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34386 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752975AbcJOIq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2016 04:46:27 -0400
Received: by mail-it0-f65.google.com with SMTP id e203so718768itc.1
        for <git@vger.kernel.org>; Sat, 15 Oct 2016 01:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Z02Gm+T9jJzpo5cfR9igRMkeIiKzZTsNzwkpG9Rw7i0=;
        b=BDXmbJMTiUkWDcRfRIzx0ww/77O2UsVdw9v68maUSLD7b4SoV05Y48mSWyZ8E305f5
         qDwih6T1/xuiunj9/Mfh2lvmu0D7Nl9t83QSMoyMBUehLRUlS1mFpy30tM8zq2yRs1nG
         LGv2J1emuPuTS0oBPhYaXXAfUBLBbOjiM5ZhGkG1v4eKT8F04udNErIl6ClRAplTHQ84
         TP7lO1/o+oZGeQFr/vseShbLCZeOgxx8/HpSQeFiRdDYWbUa1l4UjAkIuSp4xFYa2pEM
         AS/J8NzyrChURXpPNcnDblqdbDgjWpSyRVurlt8nGBNdN1SoVcziM6qJYe+DS/dRbFt9
         Ww+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Z02Gm+T9jJzpo5cfR9igRMkeIiKzZTsNzwkpG9Rw7i0=;
        b=RDJkPopjogd19VNLNQDIhJcEwDPRkluERtHvZmIj+Tgv2NWMrBg8FwpaSSDpaTmHCB
         c0ipgfI/C2UiTIYc58IZEylxBp488cEA2r/unLYM/VXRYhSe2O2JI8cVIefzcD77DlZV
         MK5xKylbrUzrJZIxFCvKHe0eimkEAhrbn3F0YOj8t/QZBQ7rq0tGUsq1s4pCswMvgZUH
         DHfbeTWB7qCMdGNho9OJudoKe/945t7/Cgc9Na25XAS6bNwqTHEQUhrEPJ+vWFq8Pebv
         KW++OXjO5758Ff4d/32NPtwseEKKdpfzy8MILcEanefkdIlxhY7546AOx/RQdiARhDkS
         Sdrg==
X-Gm-Message-State: AA6/9RkNyz7k9XAKKfrysLynjsufqej3luvXpmbzn/Som90jyMsI1TpRK6qnFLZrcRwIymd38P8AGfrml+vZuQ==
X-Received: by 10.36.225.193 with SMTP id n184mr1134852ith.100.1476521186513;
 Sat, 15 Oct 2016 01:46:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.38.215 with HTTP; Sat, 15 Oct 2016 01:46:26 -0700 (PDT)
In-Reply-To: <xmqqr37iy5bw.fsf@gitster.mtv.corp.google.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1adc-d5fa6b9a-ce13-4ee9-874e-e45fac99fba6-000000@eu-west-1.amazonses.com>
 <xmqqr37iy5bw.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sat, 15 Oct 2016 14:16:26 +0530
Message-ID: <CAFZEwPMjJ90k1BwK+Bc2Ca9LXzscvs2c2BuX347N+XyREDG98Q@mail.gmail.com>
Subject: Re: [PATCH v15 14/27] t6030: no cleanup with bad merge base
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Sat, Oct 15, 2016 at 3:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> +test_expect_success 'check whether bisection cleanup is not done with bad merges' '
>> +     git bisect start $HASH7 $SIDE_HASH7 &&
>> +     test_expect_failure git bisect bad >out 2>out &&
>
> I think you meant "test_must_fail" here.

Oh yes! Thanks for pointing it out. I see that you have already
submitted a patch to catch this mistake which was previously ignored.
Thanks!

Regards,
Pranit Bauva
