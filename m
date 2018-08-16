Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC64E1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 06:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbeHPJNV (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 05:13:21 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40929 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbeHPJNV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 05:13:21 -0400
Received: by mail-io0-f193.google.com with SMTP id l14-v6so2977204iob.7
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 23:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eTGeuSXER+YISmFD4hMpqxTi3spLQXeomOUDwAfxhUY=;
        b=bwvwq3db9MfRdtXVsmeS8BmsKdJFchPeZQQ/ZjsTy1J7d5+tnajEExG2CvysjzbWXY
         R3tULQXI6vcJewMoyJjKi5CaHXOa2/pbwFAquv9dLeFjgRbyZJSLoVPd8AtLeg7ujJPs
         yybN4tqGERIonZjpn7Vhoz+fZ8YQUbXgw0jtdT+ikwjoJkm1up4qx8gN33NBeArLcRBj
         MFH+E7uz+IJZXU44T4odRMamnsIdX1gWhvwzAIpS8zm8AfU9atVqeGeuxgQt3pmisH4R
         0xWyUoozfHQLN/Y29WwWL4fYzVw3+sJu7fHqASNI4aFNS64NKtNTJtA6yMXwj3lrIZ8x
         uf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eTGeuSXER+YISmFD4hMpqxTi3spLQXeomOUDwAfxhUY=;
        b=HtrcvPLilvj+43qijWKymdd56wAeHECnGrLFvOVdYza9SDT3qHddD4iLtVoedAkrQp
         DZO2NQVqfH1vaPb9sEpgIgCBsMysnW+k9X9vCEp2c4XcYflOR6weHkrxKSCi6jAoUoms
         mVDfOItRCEWagJL9Kp8OsfcDZZvs7BxaGWkCNGBglDr0EnIOFFZzHi4086QDQbsFCFZ2
         VA1NQER67XnfDokIy46R56vsbpRAYnbnEdlZFqY8bnsk74j0UHn49Z2PsYU4AMsm6vpY
         XUMubBPOSNPXLU3ozejY7Zp8moUQ489fgz6/jQXkPdjV8tTHU/BzjljIByUgZR6czrop
         fZIQ==
X-Gm-Message-State: APzg51A4Bwx2aGm1yjPa4QCiomQk9Oe1YOHw0hLsP9lLDwBW/g0adJHg
        kr0YsARbT//g3cKpFcBMUGTbP+c5yYmpIi6dLriLl5i+
X-Google-Smtp-Source: ANB0Vdb+RIt2U6ROxUT8xD9qtwy5vN9UuAlSOI6X5x9yhwdmoT0qbsPeC+MqosY2u1kxgrG6pgLdUit2BUkNI1sfE2I=
X-Received: by 2002:a5e:9615:: with SMTP id a21-v6mr3648983ioq.53.1534400232535;
 Wed, 15 Aug 2018 23:17:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:228d:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 23:17:11
 -0700 (PDT)
In-Reply-To: <20180816061313.19298-1-chriscool@tuxfamily.org>
References: <20180816061313.19298-1-chriscool@tuxfamily.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 16 Aug 2018 08:17:11 +0200
Message-ID: <CAP8UFD1PzJ90zwLCVR_4nwFhSL1-H8MpNjXrOrEvzFz38dbSJQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] [PATCH v4 0/7] Add delta islands support
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER Gabor <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, I made a copy paste error in the subject there should not be
"[PATCH v4 0/7]" in it.


On Thu, Aug 16, 2018 at 8:13 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> This patch series is upstreaming work made by GitHub and available in:

[...]
