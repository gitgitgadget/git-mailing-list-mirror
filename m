Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06EC71F404
	for <e@80x24.org>; Tue, 27 Feb 2018 23:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbeB0Xkw (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 18:40:52 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:46141 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751778AbeB0Xkt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 18:40:49 -0500
Received: by mail-wr0-f173.google.com with SMTP id m12so510295wrm.13
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 15:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JPm3G6J/kjO9by3Sg+al8WK79YNycthxdwG3d2/BsC0=;
        b=YLSxSavu9yemIqpx6DG9KLAQSkBSI9/4lM00egO+8d4IOVcFyPuHHl/07w28opFcjt
         MKdyRGTltxnd6vSw4Wsfgv5FB5Sr+E+jhyJsuxq7Wad/2Te7wu16Wc21+Lpj1vZGHuVw
         E7fOEAR+qzPpfrEoCjaBrWBcQX9CUthR3oW6YrQ9DA07I/TvIwJ+QSh5sD/zsh2cHlhB
         RQFmztWcUMT1OOBmq0C1YuAaWep7BZhQ6t0G8gs/f3rlBNDA3yq6o3VSZRxB6WTRcjWc
         Bd6MPkmwW9FyjDXSlwvNPivnKgM7SGyT/+CSDzjCBxGAsUqp4/mAbwvcr85Zqyb1aDcm
         05Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JPm3G6J/kjO9by3Sg+al8WK79YNycthxdwG3d2/BsC0=;
        b=LVCfabdRuFd6V1WCodY46XmlKQ6KncXhE7wsx7KJP4eie+kzv0POD13vJsL3tX/e55
         EYAGaFC18MkeZneJX2gtVxd9ZCyAq7yP1qV6NTMjKv36r+mVWPwXEmRkFuOx0hacJTzH
         OJTdJUCoT/D/RHuKuVoJQOJB4yWr9FEZHSLmVK6Rkttd2chbbFTws0NUPYcaV+q84SOc
         cTlPIipDsuDaCFQyEsVC+Tt2wrdf7sUfgJOvgwirCAW5wash7jMJD9FoPmWPeYy9HkJs
         tdKmbEEWuQRb9c9vuewbZrFSlwqyKUESLbM0Id0fUrq/+aNMZGgpNa5VM+ZZSvgMy3pw
         zuSw==
X-Gm-Message-State: APf1xPC1c1gMBpZIMxH+NblIO28/BJl+XO+1MU0HUN6a/3Gm6ooFQi59
        gNG9bqT13n43lZTFLmC9QJs=
X-Google-Smtp-Source: AH8x226Mxx1Mt1YPjtakiRoWw+qyocXcAFJorrDLzoamInuFqyVyxWcC6wWXzkHtma+izZ1gA2KTgw==
X-Received: by 10.223.209.18 with SMTP id a18mr13958427wri.141.1519774848714;
        Tue, 27 Feb 2018 15:40:48 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id m7sm765238wrm.35.2018.02.27.15.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2018 15:40:47 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
Message-ID: <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
Date:   Wed, 28 Feb 2018 00:40:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/02/2018 20:59, Igor Djordjevic wrote:
> 
> (3) ---X1---o---o---o---o---o---X2
>        |\                       |\
>        | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
>        |             \          |
>        |              M         |
>        |             /          |
>        \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'
> 

Meh, I hope I`m rushing it now, but for example, if we had decided to 
drop commit A2 during an interactive rebase (so losing A2' from 
diagram above), wouldn`t U2' still introduce those changes back, once 
U1' and U2' are merged, being incorrect/unwanted behavior...? :/

p.s. Looks like Johannes already elaborated on this in the meantime, 
let`s see... (goes reading that other e-mail[1])

[1] https://public-inbox.org/git/nycvar.QRO.7.76.6.1802272330290.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz/
