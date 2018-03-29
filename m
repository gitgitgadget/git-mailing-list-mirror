Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 535351F404
	for <e@80x24.org>; Thu, 29 Mar 2018 14:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeC2OlG (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 10:41:06 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:46125 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeC2OlE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 10:41:04 -0400
Received: by mail-io0-f171.google.com with SMTP id q80so7920689ioi.13
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oqMGyvRrKU/172M0+JhAIJTQfF51THMUoyGTsoqn6gg=;
        b=DKXVGwmkik3oKih27S1dabRPZngSLz5Kwsz+TNzFbaK3y+RM227R4Zs+sbSud6DWQH
         zyiJkxmkvGaAf37K3e0pc+AeV3tCOCyd4iL4HjRh4dJ7iAYjQdj41AQMYORw0LKTVchp
         Buhd+OVO6EkKArHwKyH7+Ca6rctkCO4g9Q8JNqjCpZEwvPARtdMQkcWHB6Qqdc+KhWhY
         +ZSTsTH1RKezDAuHdW+aIdHUvO6DirLPGpRNTssoNeojgdT5z83B8b+I9vhyPFbz/YHH
         YhOLIWTovpkaZFaP4+93+g4zCai4dPoDmrOFReBS/1jjBErbQzhOtG5QTNKo4p+iypp7
         6jtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oqMGyvRrKU/172M0+JhAIJTQfF51THMUoyGTsoqn6gg=;
        b=iDPUruC1MGWbtipH6Y0B602HN+Vic3788Cj3xrqoY1tPxt+40IlpvahSlu9Qlgu7QB
         6nSuJPQtEdKimTk1vHPtbxDwR/v2E9bmMg0MpJ/ENXtTjtWftIYQyhek4Ezm7C/U8VZK
         k4Gxl4Yyny7/ZaTKG2duRetiqpnpi5mqzqFd9Qifzp+VqYPikNW7aQWN0+I1xG8Xp+vx
         Qq3LHKuz9ksYACfSwGICMgekvZXzX1Akwn84Nl+Vu1KJFa/TTZ/7upBw3vXB8eiH1aPh
         aMLHR32Z2lcKardepKTT3uu+AVWatTwgbjXLR+4i7GNhlgR8iLL0ABD1EjcJLH5m5Uek
         VmBg==
X-Gm-Message-State: AElRT7HcDvUFdauU/8kJWkmyR/oBUjSUzsM+2xnaa4dRKBxu1moIWBmy
        dlGNuOeTqKBLELleO2O9CT/r+xwksLKSsD2rUn4=
X-Google-Smtp-Source: AG47ELsFtVxUVv299+9kVcM6jwORo9zc1vw5wdzQEDXd06GqerC/3QOKIUPG33k3mkfkqMHerY9JR/cG66GRNTMYxHY=
X-Received: by 10.107.93.20 with SMTP id r20mr51726045iob.53.1522334463539;
 Thu, 29 Mar 2018 07:41:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Thu, 29 Mar 2018 07:41:02 -0700 (PDT)
In-Reply-To: <CAL21Bm=U=p+tw5FSXXBU01Bm=YCS6oQQSseB-Xv758onmxszwA@mail.gmail.com>
References: <CAL21Bm=U=p+tw5FSXXBU01Bm=YCS6oQQSseB-Xv758onmxszwA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 29 Mar 2018 16:41:02 +0200
Message-ID: <CAP8UFD2EjZ9-qeS-3oWWS8O8ayP92aXAxAb1qK9qjKKqDh7y2g@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] ref-filter: remove die() calls from formatting logic
To:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 2:52 PM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=
=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
> Move helper function from strbuf to ref-filter.
> Get rid of some memory leaks.

The above seems to be the changes since v5. Usually in a cover letter
(patch 0/X) there is both information about the goal of the patch
series and the changes since last version.

Repeating the goal in each version is useful for reviewers who might
not have time to look at the patch series before, or who might have
forgotten about it.

Thanks,
Christian.
