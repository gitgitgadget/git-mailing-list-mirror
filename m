Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A29BB20958
	for <e@80x24.org>; Wed, 29 Mar 2017 21:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932966AbdC2Vgo (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 17:36:44 -0400
Received: from mout.gmx.net ([212.227.15.19]:63413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933008AbdC2Vgb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 17:36:31 -0400
Received: from [192.168.178.43] ([88.71.239.83]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Me8di-1cUg2Z1a7a-00Psak; Wed, 29
 Mar 2017 23:36:09 +0200
Subject: Re: [PATCH] Correct compile errors when DEBUG_BISECT=1 after
 supporting other hash algorithms
To:     Alex Hoffman <spec@gal.ro>, git <git@vger.kernel.org>
References: <CAMX8fZU-HeKzd8VYh8R=U8f8V-px+4V==M3CJSS677K0ErwPtA@mail.gmail.com>
 <CAGZ79kY1g-4c+GXZy3p-q=MsBY94esxsfs2=OPuhOH_o5oGc_Q@mail.gmail.com>
 <20170320221429.qefqowtwe2ptvgdg@genre.crustytoothpaste.net>
 <CAMX8fZXqTfKQXxV_pZEieN=1ap8ocVnnwZUvpGuw5rWo5_Yhfg@mail.gmail.com>
 <CAMX8fZXS4k5chezESM4pcaSfhG6WZ4xKxsWB0fpm4h-PQGjXwQ@mail.gmail.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>
Message-ID: <52ac188d-1112-758e-5d02-470afc6ffa8d@gmx.net>
Date:   Wed, 29 Mar 2017 23:36:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAMX8fZXS4k5chezESM4pcaSfhG6WZ4xKxsWB0fpm4h-PQGjXwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:rRYqUEVWydT9BaCm0OnPOcK2WgGhpiIh2b0UmbBbALoAYQd30ps
 52pA5GQMbcetomVLmEEeMI0Ihtp+grcP9Lwg98KqPq3wfUcSGYDZfCNp6nbi38TDUm4btaq
 WXfRlyDRzYGzRqRTjy3ylB6QEciffe5gSq/AzB+2ZzgsVsPUSOgF8KayaGC0D3w/imOxW2z
 0szuWhgrN0dlfrVHN2wNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:luW/khp0RYc=:sqaXlPWle8YZdEkzVeBPs9
 ozeI/JaWh9nUdl5+fOCLkvginXhcE69wfW4aJctV/y2+othuC4j8Xb1QNG8nGEKxIut5B3EFi
 PPPR4KUZmkpWKm/e7tX16ZhNVI+5ewtqNGFBFmRTMV2xyy60nXypfvreag8bT7UBXQWCfiP7h
 9M7ntQ+CTEQmdhSGKYXOiOIFOKLTIa0S0s3zDYs1b50JPRTRToJm79sz4IevZvy+8lXEEDUSO
 rcIJhHXv5zveSSnnFQQu3b01FY3Wf1A8+Ro+BnwuzZgE2o6iAOW/q6R2mk2GjEinF0mA3HkOT
 OTDsu6S2M2xnf1ep35AvuCfveb8l8clskF6U8vQoBCOJpTD1Kjlw+LqR4ObIwv5THyijI8M3l
 uL1R6rnxN51hihbf+3zxbZntr8fseAW7XGB0NCzZ5OTi5Eu6s0plZFflUcV9wQHAuOKQj6WOj
 f4AaJgPPof77UcaXNjligCXaOve1ol3YPDZZlAcp7WIYnSB9uhjWdEO06uNxCNFy4A9BsRcnL
 Gj+y+1VVdw+8LNJykWbN7WTebNehJfCnKEoSyyVSFMK4XZo7zJxOLlA65Vt7k2RFYv5KUvOFz
 pq9QsntkFlfEM3QkhYlRKpkgRtDbGhicd2qExah5b5fAYCKoHh5KtBJSDi9k5uOairKHsOQ3G
 kR5wL25fXpCA8wrlvLqrQCxWhd/xsbFMVLHADVMZWZDVEDIJiNCQG68XqqFOaOnVZuH5FKiRL
 Roc2euc9587VbigwpeBWXhDqgIwnk8VRvDl62ISqQWxGwZ4L8KtRyKhgrB+Ps/BY9v4htsqdB
 THlDtIP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 03/29/2017 10:02 PM, Alex Hoffman wrote:
> Any news about this patch?

Haha nice, your initial patch is the same as mine (but mine was part of
a bigger patch series and the v3 is probably going to have one less commit):
https://public-inbox.org/git/1456452282-10325-4-git-send-email-s-beyer@gmx.net/

>>                 for (pp = commit->parents; pp; pp = pp->next)
>>                         fprintf(stderr, " %.*s", 8,
>> -                               sha1_to_hex(pp->item->object.sha1));
>> +                                       oid_to_hex(&pp->item->object.oid));

I guess your change in continued indentation is intentional, but is it
just my mail client or do you f*ck up tabs? (I haven't tried to apply
the patch but it looks like it is not possible due to broken tabs.)

Stephan
