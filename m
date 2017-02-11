Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AE9A1FCC7
	for <e@80x24.org>; Sat, 11 Feb 2017 19:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751179AbdBKTum (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 14:50:42 -0500
Received: from mout.web.de ([212.227.15.14]:57240 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751175AbdBKTul (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 14:50:41 -0500
Received: from [192.168.178.36] ([79.197.218.233]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCqSB-1ckZmc2wYF-009kzM; Sat, 11
 Feb 2017 20:50:25 +0100
Subject: Re: [PATCH] cocci: detect useless free(3) calls
To:     Lars Schneider <larsxschneider@gmail.com>
References: <7e10f934-f084-ceb4-00eb-b75cdb01886b@web.de>
 <5DF3AA3E-90C6-443C-A22C-489CE2C89A51@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ca01f8de-f5ce-2201-450d-cadd6aca7cb8@web.de>
Date:   Sat, 11 Feb 2017 20:50:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <5DF3AA3E-90C6-443C-A22C-489CE2C89A51@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:rfjmKiICpZ68j74VUHDkvYg8eBd0IHiGGUFsjPuNaoy5d1tAtCC
 Y4BfXteewXEAQ22E8ZeP17zHNycOx3QDCPJhnjHuNFD+hmP7FvB0/aRZfUx98tSBRl9jHic
 +I3vYB7tvauUPvR30yHBdPkQzLEDh71r+31+Z1228r25E38Xe9zfJP3CAV1JsKIe0GNSkEv
 RRMtoJQYL++MjP/e+4Ftg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:66CyneBV+no=:p8x4ObwMlQyfjvi89KlRKm
 SD1pVkLhT/0PqL7+MwiO0gmZDOrEYspcwLwlKOzZP5BhOPHNcaxp4AZ7kCRHg+c6QJWwZSkhO
 W4AGWvtu/y0S4Qm3qQs9cAgpJ1VGeLtyymoNBinHypP0UIL4bpoTxDUxEmCkwumlcpejrMdQ/
 X2xWAJE7EfW3YHdh941tYMSiQpUQhKYGoLh7ojYl468rZLjrCRI0e+RHtDty3KrOCaCgEmpyX
 AcOogd+hld4QsEqPv7UALuu+1ujAyQ2IEe4eXFY7xYAvUMPtTeYJZ75+WdBfgPnO7ijaieErg
 Obe4XTfwtOgujx1C9duQ6hIwo/nUFt6oZ+ranE7Na1MBgmwM5HBc9q7ConhJYRumwkUw/7nJZ
 1w5SesUOKKaGqgXqRzicUEaG1KH6Gm9u5FPQh6f6YhNaDGYgrna7zOGiafaaLKlCmwyaZSKOv
 0l2CDyi3R1AI1YJGLkzDHrr4zF6Nx5vzph4310k+uWbA+Pd76jO0YMmkriYd+fJRbJwMLCVAT
 cZFdyggMFAk7qSYAuc7QVQNV8FElz9fksNxZCRwBhTp90Y7bCXTDKFrqo+6pIDYYbljOCJJgP
 xrs+BfFLrS6tjCC6DAm1M74u8JfgL8IfhqNcotiX23w+LrenMX+snknEa1q4lWQqX4ubCfHtN
 cpnctqZzuOgMiNDx2a3S2IMNbCEsGaAMKK8qRxGXCn0TR793ZRrlDcvwi9edT/DQeHzMQkJE8
 R6xKUaWPN6JPeUMQILUmlnO/FKgvRaa6IKiQ67qMg38p1jpkgagSMNcYutsowyM9UgpVs6pQS
 /My4F8m
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.02.2017 um 20:31 schrieb Lars Schneider:
> how do you run these checks on the entire Git source?
> Do you run each semantic patch file on the source like this?
> 
> spatch --sp-file contrib/coccinelle/qsort.cocci --dir /path/to/git/git
> ...
> spatch --sp-file contrib/coccinelle/free.cocci --dir /path/to/git/git

With "make coccicheck", which runs spatch against the items in the make
variable C_SOURCES, for all .cocci files.

> How stable do you consider these checks? Would it make sense to run them
> as part of the Travis-CI build [1]? 

There seem to have been problems with older versions[2], but I'm not
aware of other issues.

Having these checks run automatically would be nice because they
require a special tool which I guess not everybody is willing (or able)
to install and because they take multiple minutes.

René


[2] https://public-inbox.org/git/014ef44e-9dd8-40b3-a3ec-b483f938ee02@web.de/
