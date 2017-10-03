Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73E6B20365
	for <e@80x24.org>; Tue,  3 Oct 2017 06:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750820AbdJCGc7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 02:32:59 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:55297 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbdJCGc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 02:32:58 -0400
Received: by mail-it0-f50.google.com with SMTP id 4so10116669itv.4
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 23:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c7I/6VBhl1TJkxDIF8TtpKpDTSan5gGDsfYWlwE6utU=;
        b=Vix3NeosCAqqCCoGomnuBDtkKHXGVfHDggEEnND3AV6cacq97+pKCYQPKBwJKN56so
         HZd3orQThccyftX/L0ryR2KcO6byet/OcTdlZcmmHX+TdHymXdEIpvjerXyxfw8lgJUa
         oUe9haf2E4BRMIT6bukzgl9PvD0eGF7C88IjYjekYHhfRpmVR+qtRM0N/8lzf9Lor9R7
         CKLnsDiykuijtygHiO2h38vZkVsVFVhItWdV1GW/5eMmsjjZC+Do5I2jrXrJEuEw7yPJ
         xj3Ay3rG7/7UEuFH+E3980hY6xJ2XLIpdZSOxd4YHLRtll3GS8cNfMbeFgmS48MyEFfg
         jWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c7I/6VBhl1TJkxDIF8TtpKpDTSan5gGDsfYWlwE6utU=;
        b=OQF9qVxW93Z6ijUtL7xRY/IUscxcwrt5vEB78InHx0VGfNEYEgnU5Vt3zfIcAOvp9W
         /HV7FuWz+Qz+4gw82Qp2Z0Gn0gm1QehIZCzdsg9C3GS7jBzbkp3/i3bZaP8g4aa6TFB5
         NZiyhOFVelce0s4NsR0fXi+wVo9yI3zUIhfpoJI3LAcKwzxLOEOl/ms+5eFUcN31hEMM
         +KaJMJtCvbs3zq4ySbQTlpW5sCRpkDE/rA+qFnxAgIkl71U+aNP3wZerLPh80Q2BSDUt
         btIpLE1rhHs3LnqGWKpXUn1qOc8H84f3x3PHEX4aKS3fwlxSv5ngxnOm9S1iykIKno8X
         gkrQ==
X-Gm-Message-State: AMCzsaUqIpZ1zKuTWplxdAj2KD5bzMNV1TAIMuqI+V/+vDHHeys2NO7Z
        JH7UHh78sZ/ynW1TVif1Gmdo5vYEmT4ZKkqw2Pg=
X-Google-Smtp-Source: AOwi7QAEpGnbQbqeTeQ66317FsQUa0LKo9akO2VXafSdtVE21gFRZP/jCXoamDOj3M2RHbBtn9HtjVP2M0fBlV/vs4I=
X-Received: by 10.36.111.4 with SMTP id x4mr21059862itb.144.1507012377836;
 Mon, 02 Oct 2017 23:32:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.142.216 with HTTP; Mon, 2 Oct 2017 23:32:57 -0700 (PDT)
In-Reply-To: <1d53569f-4bc8-0d8e-0182-eec0eb6634cd@gmail.com>
References: <20170916080731.13925-1-chriscool@tuxfamily.org> <1d53569f-4bc8-0d8e-0182-eec0eb6634cd@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 3 Oct 2017 08:32:57 +0200
Message-ID: <CAP8UFD0tfei69b1BOCoAynWKtz8MJ3v2NF6iXc=N-x-C6YCiYA@mail.gmail.com>
Subject: Re: [PATCH v6 00/40] Add initial experimental external ODB support
To:     Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 2, 2017 at 4:18 PM, Ben Peart <peartben@gmail.com> wrote:
>
> On 9/16/2017 4:06 AM, Christian Couder wrote:
>
>       - Patch 1/40 is a small code cleanup that I already sent to the
>>
>>        mailing list but may be removed in the end due to ongoing work
>>        on "git clone".
>>
>>      - Patches 02/40 to 07/40 create a "Git/Packet.pm" module by
>>        refactoring "t0021/rot13-filter.pl". Functions from this new
>>        module will be used later in test scripts. According to Junio's
>>        suggestion compared to v5 we now first fully refactor
>>        "t0021/rot13-filter.pl" before creating the "Git/Packet.pm"
>>        module.
>
> This seems like a very logical thing to do and should be split out so that
> progress can be made independently.

Ok, I will split according to my division of the patches.
