Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C005D1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 21:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbeIEBng convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 4 Sep 2018 21:43:36 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46623 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeIEBnf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 21:43:35 -0400
Received: by mail-qt0-f196.google.com with SMTP id d4-v6so5699705qtn.13
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=83qyZFocQzjbKV8IFd8PWvKzfqJI2wveXf52bptV3T8=;
        b=T3dGmXUGK433Y7lbAR/HuL0EU97MrDUNtkwPXmWMLSL16z6SOAVMUEjjAfllHqjek5
         1MqIu9EaIjU3TQ+HujuDAKBLs4K1CkywNZjyNfe/cs8n7M8sF8SgmLFu+ftheN+JIC3x
         8GKwcu+D8GeNcgJOqRJht5YtOEDQ7E9QbK8JFiKlFXCBP72kFoLzPbblt+ViVZx1M6zt
         KeseQ0PhgL4nGRUk6+7kftNgdvZtDLkyn8nrfnvxVxVLTK6PdDp+z7uJB9RX42qX9JPa
         b78aEJQM9lZVHl9vyXakRl3nireFTS8KMXeEbE7EyIhkl/qc/5dm/nSMoIoVO7vvioyF
         Nfkg==
X-Gm-Message-State: APzg51AsHHrbkRfpefyEQTSYaYqQ97MRV16Oa2KWmRccRGTimGbfOcmZ
        ZcCKSKoltnQKFoXcPrwNfSRD0iRSwsK5AEXM6zEE/A==
X-Google-Smtp-Source: ANB0VdbLO3rwxfjMsqApdsJWz2WuYheFNvdmZbf39r7AJCqQ6S6VmCWNtBYM5dCqvnL8kdp9qBBnnKcaLWl7gLemlw0=
X-Received: by 2002:aed:3a68:: with SMTP id n95-v6mr32113591qte.283.1536095801522;
 Tue, 04 Sep 2018 14:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180904202729.13900-1-avarab@gmail.com> <20180904202729.13900-2-avarab@gmail.com>
In-Reply-To: <20180904202729.13900-2-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 4 Sep 2018 17:16:30 -0400
Message-ID: <CAPig+cR9Lcj3JaFdMU9EyjPStHRG1M4SQcHaR8BwXKsDAzG4kg@mail.gmail.com>
Subject: Re: [PATCH 1/2] commit-graph write: add progress output
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 4, 2018 at 4:27 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> With --stdin-packs we don't show any estimation of how much is left to
> do. This is because we might be processing more than one pack. We
> could be less lazy here and show progress, either detect by detecting

s/detect//

> that we're only processing one pack, or by first looping over the
> packs to discover how many commits they have. I don't see the point in
> doing that work. So instead we get (on 2015-04-03-1M-git.git):
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
