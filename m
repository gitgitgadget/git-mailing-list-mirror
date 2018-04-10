Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 638171F404
	for <e@80x24.org>; Tue, 10 Apr 2018 19:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeDJTiR (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 15:38:17 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:36248 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752611AbeDJTiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 15:38:16 -0400
Received: by mail-wr0-f182.google.com with SMTP id y55so13938395wry.3
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 12:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pKinFWYwdVrUaNy70Rzw20VTKQxdvgLm9ZO2i5xZx1o=;
        b=keYuquviLuA6Q9HRTgtRnnJdaq65+Z44U541ru/Q7JRJ/iV54ZLxh175ln21xPJkZi
         KPgiBTzxEMi3oV1sqRZb1LndUrgLKAJdIixaS46caTd/rkQ5fVI3LofGd6r18KlonJVI
         2f23EnnWEAp4EoGmSu2BBtGoSMrTIjio1gEGFYV3GDI/CBftmsaVXthz0n7dSo5+FF+h
         ME2m6ajQu33lEVpGmLQiDhK5StIDycWAMxZ9Lowj1//31FaGgCjaykfHn3AOZUW3Z5AE
         Ap4fRfaZdTaVtjvA8MihpSIJ8d0GKRQ4+51+XhvgfLCIOXLCUIVTiFdbx2z73SbwdhKY
         ReFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pKinFWYwdVrUaNy70Rzw20VTKQxdvgLm9ZO2i5xZx1o=;
        b=JH70fLK+ledXrYvjwcTVbEAP++Hb+ObxuO0bF8TH3IRTqxQbzeie1dB9K84+oCGurF
         vXXBYPXWaEETzSQy4dRpGz3RfDCEhHnc3Tgo4pS7Jf59SJtn8oEZ1Z8aaG+ZSl07EaHU
         KWcZ1OM2ksP5hRiAQIhTKa5nKK9vXJmhni8z/01RT5mFb8uUP5pqiSyyjGSeKE9CBy56
         SFJTT4uwFsfVFWe8K0BeNBljBy10ibDdVqW5v8HAY9JdKcFt44xFTHL5g/q0EcBpL08d
         sp4FwWcCNUEWO8airch5UGYf/BgSvfq9teOPJePlnUoa0PkSSNWggqrSt1pc0tRCNcls
         Ec8w==
X-Gm-Message-State: ALQs6tCNgSTXJMVZkcSP+kKXNqdt5hwZao9RTxXed3GBvnf4BF1TQVoL
        +wZJG4I/CZqHTxdWipvTGLUvow==
X-Google-Smtp-Source: AIpwx483MYO0r6KXPyc+jWh1delsMCyUkb/Knio2p7oq/Mujobi5z++8JEsNOSnfCBxP718HxHvJSA==
X-Received: by 10.223.184.219 with SMTP id c27mr1408297wrg.30.1523389095025;
        Tue, 10 Apr 2018 12:38:15 -0700 (PDT)
Received: from ?IPv6:2001:a62:81d:ab01:35db:2474:c452:ca1e? ([2001:a62:81d:ab01:35db:2474:c452:ca1e])
        by smtp.googlemail.com with ESMTPSA id p4sm4608124wrf.27.2018.04.10.12.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 12:38:14 -0700 (PDT)
Subject: Re: [PATCH 4/6] doc: added '-d' and '-q' for 'git push'
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20180410183224.10780-1-asheiduk@gmail.com>
 <20180410183224.10780-5-asheiduk@gmail.com>
 <CAN0heSrrPa5-ckjsonUh+3JpoAnaAT=efJT4Rp7uEn=UfWpC_g@mail.gmail.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=asheiduk@gmail.com; prefer-encrypt=mutual; keydata=
 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
 khKIKhAKu5lezA==
Message-ID: <85c6d713-7e36-6068-f6d3-9b9144a4958d@gmail.com>
Date:   Tue, 10 Apr 2018 21:38:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSrrPa5-ckjsonUh+3JpoAnaAT=efJT4Rp7uEn=UfWpC_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.04.2018 um 21:17 schrieb Martin Ågren:
> On 10 April 2018 at 20:32, Andreas Heiduk <asheiduk@gmail.com> wrote:
>> Add the missing `-o` shortcut for `--push-option` to the synposis.
>> Add the missing `-d` shortcut for `--delete` in the main section.
> 
> s/synposis/synopsis/
> 
> The subject of this patch says -q, which should be -o. The subject
> could also be in imperative ("doc: add ...", or "doc: add missing ...").
> The diff LGTM.
> 
> Martin
> 

ACK & Thanks,

Can I add "Reviewed-by: $YOU" to this one and 2/6?

Andreas
