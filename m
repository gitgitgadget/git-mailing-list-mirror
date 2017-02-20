Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E3DB201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 20:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbdBTUgC (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 15:36:02 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33088 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbdBTUgB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 15:36:01 -0500
Received: by mail-lf0-f54.google.com with SMTP id l12so17662433lfe.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 12:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=D/XJRxKV2ZqQkE2+Ba7fdrR6ygO37s7GV8u8xcGy8LI=;
        b=Ffz40yJLX5Kr4JTALFniOWlPaKSLEnCZ6PQyddbF9y5iAMqwveAkV3cmu1yK+B5MQj
         JwuKRlBHl5fDvnQ9T3f7BiyyRoOrd2DZSTVMqPWSjlR6f+rNWkOkd5TyPWChGkoQ232j
         pUSMHOIFiWVimbsiqsqy4tIcr8dIN8oKMvdOsoewkYei2LehwVGqpHeIprcmRYJDANCv
         r3NId5zbTD3jP1G1TAHSViwG2RbfT1Lqx0M+zIpxWA61NpUNE5ZtT1vx8x24mI72A2pt
         FzJz1qLpBa3pIWC83InbXTx4puFF9BMfcvhlkAXMXRx2in6PnFhOgfecD6qQu2yxgVrF
         tBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=D/XJRxKV2ZqQkE2+Ba7fdrR6ygO37s7GV8u8xcGy8LI=;
        b=LuogRN83toT58VXcR7MYiyvCA8JAAe43YhSspoHDelMK8hd6AQmZXn59nVn8EEjNGi
         IwNIUYAr8hG/MRRRw7wnRF+7jmhUG65J0OrnVy2dNDm7ceZ+uaVohkHUhERR6NbhaO+b
         DQvFqd58lAnDViScR3putd6yXr7P37ZF8c2SFfu3xXIK7tdcs6P3MVQHJoo23RCvt9OI
         IgmQCrikVx7kbp3QElE2d3uwFCF2tRtFGvKg1IY714lYaV3efOCG+H4zElwbfk1LoueV
         aGf2kRjUNK6sBMDTL8WiVYp91KCMPEPZ0kE0V5L5bsJau13hb4RnbpM6udnV2dFyHefY
         QHrQ==
X-Gm-Message-State: AMke39nKb2VRzeqvhuhHzvfBM7qFS+s6ThZ0/TSpIPn5+W+sjLUzfGFN1IZWdGxEwxrxxA==
X-Received: by 10.25.217.205 with SMTP id s74mr5510442lfi.8.1487622959766;
        Mon, 20 Feb 2017 12:35:59 -0800 (PST)
Received: from [192.168.1.26] (adat244.neoplus.adsl.tpnet.pl. [83.11.255.244])
        by smtp.googlemail.com with ESMTPSA id u30sm5559408ljd.4.2017.02.20.12.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Feb 2017 12:35:58 -0800 (PST)
Subject: Re: Git bisect does not find commit introducing the bug
To:     Alex Hoffman <spec@gal.ro>,
        Oleg Taranenko <olegtaranenko@gmail.com>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
 <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net>
 <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
 <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com>
 <477d3533-d453-9499-e06e-72f45488d421@kdbg.org>
 <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
 <CAP8UFD3ngMvVy2XLzYNn9OFbS+zQpWTW=pravpHhA-0PcDVhfg@mail.gmail.com>
 <CAMX8fZVeAEJ5tfCO_4Pebnq=rysaJ2xDMjH-9pjmPeF4FziLFw@mail.gmail.com>
 <d7bb866d-4a50-f75e-ff4c-bcdd54f75459@kdbg.org>
 <CAMX8fZWRgeK5XjSrFYzZea8YgT9Mqm0XJBxQGt1eqdWZU+DEnA@mail.gmail.com>
 <CA+P7+xrch9WDo6OgU3vUEpXqAETZ07mkf76dC9nJctm0LTFQHQ@mail.gmail.com>
 <CABEd3j8sgDd8DXW8+2Q7pjANPTr-Ws1Xs1ap875mkxFOfnenYw@mail.gmail.com>
 <58d25138-de2e-6995-444f-79c3ac0bbad2@gmail.com>
 <CABEd3j8m5D=bBbUD+uzvE9c8AwdBEM79Np7Pnin-RLL=Hjq06A@mail.gmail.com>
 <CAMX8fZUNHmouUsgEY3+0CmTaEp+y5b1-Cp8Nk3OttTc30v0R5A@mail.gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stephan Beyer <s-beyer@gmx.net>, git <git@vger.kernel.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <ca1ef8f6-58cf-4994-d1bf-39e04b42dd4c@gmail.com>
Date:   Mon, 20 Feb 2017 21:35:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAMX8fZUNHmouUsgEY3+0CmTaEp+y5b1-Cp8Nk3OttTc30v0R5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 20.02.2017 o 21:31, Alex Hoffman pisze:
> I see two different problems each with a different assumption (see the
> definition of "bisectable" in the email of Junio C Hamano):
> 
> 1. (Current) Assume the entire history graph is bisectable. DO: Search
> where in the entire graph the first 'trait'/transition occurs.
>
> 2. (New) Assume only the graph between one good commit and one bad
> commit is bisectable. DO: Search where the first transition occurs in
> the graph between these two commits.

If `git bisect` is/would be affected by `git log` history-related options
then this is what `--strict-ancestor` option gives/would give.

-- 
Jakub Narębski

