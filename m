Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 670DE20248
	for <e@80x24.org>; Tue, 26 Feb 2019 12:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfBZMVB (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 07:21:01 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37288 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfBZMVA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 07:21:00 -0500
Received: by mail-it1-f195.google.com with SMTP id z124so3724209itc.2
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 04:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/w+iNLSrGuBI8BeG6/+Zg4l0CfYRgXysZqp71A4rTXU=;
        b=XkF9KgB/sO0XX/0z2hH1T7siY0DWFSyGSOE7O9L8i5Cxs1O21cXw9Stp9Ln0oATMp1
         6xiHI8Nh3y9pduYfXOudfvmMd0KIdia/ZQHYW4Xz6WEtoHZvSOz6OwMEI91VvcK8UDWj
         SH0TwHurrTe32lYQ45CP016qFa3cH10zY5PRfmpJ2qt4+jfGORjZbt78v5RfifZ9YNtQ
         i0D/yPtPplSomnfP3PjJfW9RDTF5bD+Iq3vOWyj2uiQfuZf4a1URvqsAuH9mbLmDp30f
         TOuQLlpemG1BRzXHaEW7QRvsXRo/7AItB/ujRLl8q+oYrhHP+D9yAgzN11QJrmyAT+US
         bGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/w+iNLSrGuBI8BeG6/+Zg4l0CfYRgXysZqp71A4rTXU=;
        b=ELXfSgaduCMoqpgMGlgVRPUdhMwzerEIybO2vXyYbop7jazukQXzu9NvLukoq9IuvA
         vjnkMcZLcAGHecHIKSnOrvaxlf8d9itDt1k3Y7FrM6yUbgFnORtB2qoXQG03qA7tdpMR
         OCbHQfIAv27iM3fqzzGZlwpMLdIJ+UTuUYDPeSmbb6ESNPCnFAfXTWQ03Y+1aPzNBztF
         paCE59yZHMT6PGRhbuLz1KQZtuQvuwJHOIUF/W+TlavUgAd2Y+orT5niFo75Bgtb6JbV
         Wn3yRjtPtqhJuPPVic6Gq9HjuwJ4Uye4xYkkPhi0BGRRhIJ0af63731sNJVGpFo7DISA
         xbjw==
X-Gm-Message-State: AHQUAuZDh0WBRAUftDHrTTVjPonfByU4bkaXgNJeoxhAxSOlxnDeMMIt
        fYRCPhk+XEfmdsuQbqumIBJKEz5kzXYQuoD0/kA=
X-Google-Smtp-Source: AHgI3IZuXi0ns30xcLlood2PLc8eEaZw3QTV2Z1YMeFRkFd/tch+26kvKPWgm0knk234yB8T1GBlOVLsbNWPJWqbmp8=
X-Received: by 2002:a24:7542:: with SMTP id y63mr2243180itc.70.1551183660065;
 Tue, 26 Feb 2019 04:21:00 -0800 (PST)
MIME-Version: 1.0
References: <20190226051804.10631-1-matheus.bernardino@usp.br> <87va16vl1f.fsf@evledraar.gmail.com>
In-Reply-To: <87va16vl1f.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 26 Feb 2019 19:20:34 +0700
Message-ID: <CACsJy8BWmCGim1_8P6j_iYCvPALdTAVhqqsBdR+ktfN6XmFSkQ@mail.gmail.com>
Subject: Re: [WIP RFC PATCH v2 0/5] clone: dir iterator refactoring with tests
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 6:36 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Feb 26 2019, Matheus Tavares wrote:
>
> > =C3=86var sent v1: https://public-inbox.org/git/20190226002625.13022-1-=
avarab@gmail.com/
>
> Tip. Use --in-reply-to with git format-patch, then the whole discussion
> goes in the same thread on the ML.

Better tip. Click on v1 link, look for the "reply" link, click it and
copy the whole format-patch command :D
--=20
Duy
