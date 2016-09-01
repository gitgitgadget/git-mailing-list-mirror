Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 777801F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 23:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752744AbcIAXdk (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 19:33:40 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37496 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752151AbcIAXdj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 19:33:39 -0400
Received: by mail-wm0-f47.google.com with SMTP id v143so6075088wmv.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 16:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=FKF+T6uP4brZuVWy6xHzvfVvUFsNGkXlH75cB1Uzqa0=;
        b=V1NYyUm5utDoaOMW7eOthyOtNPKZikaPjmoqqJUroBtjAoHwE4C2YFi/wRaIAT9kLt
         Uz6o9QMAVx9jcpf8UYZtAxCQgIDuLQHMHESuHUlCVQtsPWZ14qqVrtO52s3rsYvxHmUi
         zpb6oBxFgl96RZ8nwpriaz4ExjgQYM6UP0WzwcWcO3CrFNlmVAgNtrpLA7SzUCM5GR5H
         C4Bigcz8qUHyDBYK2+DiAKMgwKuIvI/HgmQuAHSWRxb4CI6VJRs/hYLXh/Bkt8amfNV4
         vJyuGZ4u70fR7XICq28EOtCOu2hBU59xdH5DezxU8Se1hTbH4DYOME6OcfeY5tu7m3Ui
         lN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=FKF+T6uP4brZuVWy6xHzvfVvUFsNGkXlH75cB1Uzqa0=;
        b=lBwhpwe7UP14d3dRhqhxElKkUUPHQMaXW497lZkUgRevtfadck8KktTN+3Yys8bbIY
         7aQaaqrt+k0j+4VdhBtLRLUistwepfO4c85dmKD34I5ta0ezRPiSeHwG4IC7NkgZHkbo
         As0SDYBUezR4eJU7PG/navjAMMjx+SDrTPs/c3XZSHlh8r/ATZJseNRX4ohXvL3xSeLY
         EQ+BgxGnPDtkY/FznPQUgquBfzqADhEWoiUsEqVitqL1kOvJ1+LjEPe2iaqocsHqOKM7
         ORuDqHSPAqzgDv7MvfcgMqaV+zvfuLEgu4jRVytcwLV0Mwr53OyxloxFy5RuVgh/AfXG
         tIBw==
X-Gm-Message-State: AE9vXwNGTpNYSToiNVJKRaRpoM3MspULBi0RKMaf3gSOjfFxO8Kb+Lc4clH4VCZjghDyFw==
X-Received: by 10.194.37.101 with SMTP id x5mr18518200wjj.95.1472772818184;
        Thu, 01 Sep 2016 16:33:38 -0700 (PDT)
Received: from [192.168.1.26] (abrf30.neoplus.adsl.tpnet.pl. [83.8.99.30])
        by smtp.googlemail.com with ESMTPSA id d8sm732103wmi.0.2016.09.01.16.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 16:33:37 -0700 (PDT)
Subject: Re: [PATCH 21/22] sequencer: left-trim the lines read from the script
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <8c30113a920e075e5ecd68ba31b4007de3e2dbc2.1472457609.git.johannes.schindelin@gmx.de>
 <7996a963-52b5-5f3c-f686-f5cf22573573@gmail.com>
 <alpine.DEB.2.20.1609011608440.129229@virtualbox>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <54cc3d11-6384-b666-3103-4e56a399ba6d@gmail.com>
Date:   Fri, 2 Sep 2016 01:33:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609011608440.129229@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

W dniu 01.09.2016 o 16:13, Johannes Schindelin pisze: 
> On Thu, 1 Sep 2016, Jakub Narębski wrote:
 
>> 'bol' is beginning-of-line, isn't it (a complement to eol)?
> 
> Yep. How did you guess? :-)

Wouldn't 'beg' and 'end' instead of 'bol' and 'eol' be easier
to understand, thus more readable?

-- 
Jakub Narębski

