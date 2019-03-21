Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74A0820248
	for <e@80x24.org>; Thu, 21 Mar 2019 09:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfCUJpf (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 05:45:35 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34124 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfCUJpf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 05:45:35 -0400
Received: by mail-it1-f193.google.com with SMTP id l4so2040518ite.1
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 02:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOBCjk2cjW+pGj2e8e97qQpFpquASkSywievNSXVYJs=;
        b=ecDi23rPkwYP/6SHKKvq1rWPseQ2R4Ctfpxk9Lcj9b4GChJRCOcTSlm5XJwcc3j5gC
         VSOnTY8kY+A58gNOlFvXJ4Q5frg97+G573goN2IEPTvHnOVSuPpb4v3p4eC3yJ9eIO+v
         1Lj/DOG1zLUasVZUCWCd04Q10Td+W6bGdoRoVu+mgZ1U86RHZD/GiUEKBtBJaqwFUCv0
         s8JHAVaya8hMOEMhvjqCfcZ1+maPY26H4UCDrLg2X+HPpkS6Ia88kqde09v0pUleU8bq
         WGjLdmY6t1PwPD3k8W8pnvycmOh7RalMps+oy7LBUNdNvAtYjnq9AYBHbGpRamxVcvKi
         Jpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOBCjk2cjW+pGj2e8e97qQpFpquASkSywievNSXVYJs=;
        b=eHSiNvZ2bT6DAKh03Mgu5yDYBlbEQatb6CIyWSU+lZZO2AhNh6OaHXt9Lmzel/XmF2
         U9iPdhJNPhV7xr34fWkTmFbOd0eqe+oTN3iVZlgYUYuq8pIouU6gbZzJg4TdFFpshbua
         hffzm/llFfIQyue82D4wturWBIbW2eIDqFjeTAbNTD0n2ouFiIIREqPgLOcIMgZBXuJd
         i/MJbMo0fRU57ry5vlsdfuIU6ruJVBSVO5dj9myXm0Qqns6r6GmuL3gBrPjDzrdZEmFG
         O0YyaPdB4ogP4arooPS1+5bOhYNnqdme1k54Uv7bpM14VY5KO5Zz1x78RW3IeLGHt5L3
         WmfA==
X-Gm-Message-State: APjAAAWf6PjY/w+KKDTPO+RLtcpRdsbVFLOX6bEv+yaEWtNfpta5UBXJ
        ZNOffHADxvLbr3hLZ0ueq2Hyke2HNnd4a4RDpL8=
X-Google-Smtp-Source: APXvYqzEJhl8JBeSlv+9q/UoC6tQhC+9DyGq2oG/JBU39QTkoROmE5l8EGZ724dQ1GxWh9C+AR290ZRu/qNCmMLlB0Q=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr1947180itf.123.1553161534436;
 Thu, 21 Mar 2019 02:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <CACsJy8DiQwmAKMruOAO4roPbiRTvt5TESBTd682hTwkZjcoj2Q@mail.gmail.com>
 <20190320180329.22280-1-tmz@pobox.com>
In-Reply-To: <20190320180329.22280-1-tmz@pobox.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 21 Mar 2019 16:45:08 +0700
Message-ID: <CACsJy8BM_3_XYhY9J3bp97N-Ux6AZvuTOzSMTn4fAxizk+2fYA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] completion.commands: fix multiple command removals
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 21, 2019 at 1:03 AM Todd Zullinger <tmz@pobox.com> wrote:
>
> Hi,
>
> Duy Nguyen wrote:
> > You probably want to drop the comment block about repository setup
> > inside list_cmds_by_config() too.
>
> You're right, of course.  Thanks Duy. :)
>
> That's the only change since v2.

The range-diff looks obviously correct. Thanks!
-- 
Duy
