Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A6B91F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 13:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbeGLOJg (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 10:09:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:49189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732402AbeGLOJg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 10:09:36 -0400
Received: from [192.168.0.129] ([37.201.195.126]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXDo1-1fXmhK13pN-00WDge; Thu, 12
 Jul 2018 15:59:47 +0200
Date:   Thu, 12 Jul 2018 15:59:30 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ben Peart <Ben.Peart@microsoft.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: Re: [PATCH v1] handle lower case drive letters on Windows
In-Reply-To: <20180711175420.16940-1-benpeart@microsoft.com>
Message-ID: <nycvar.QRO.7.76.6.1807121556030.75@tvgsbejvaqbjf.bet>
References: <20180711175420.16940-1-benpeart@microsoft.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qqB2LtLFJYx0PQjE2ETCTZEHQk8lGJOVZ48CgzVOTglfYhnyw8t
 o+ScTBwhvDSv8NMwx1M+7ZxSTK2ix/HtKx/2S3gob/CYmQkI2ht/iie9wwGaH8UCyvMQBY8
 cg2SLWZx4C9Hm0TxIUHmRCrxENBB6fQsDAQUVU+Ry0K4L6lJSbNljL5Wcb2VQT1s8I8AOOJ
 bu/3RofEIag+/X2WwKY1A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zLGg0Q4c3Pw=:PtEEvZS6ytua73MUGJ3MAx
 uRmiWuBTwWvbjWV43y+/LMBnvKRXtc5gPpwxPIMo7XbJDkHz0lc5KIQ6gAzjshsrtCxAuI0nR
 u2PigfhBaXiR9TdaB+3uWPvXroMMk0r4dl+6GaXXs3UM4qWJSO0uOqVeLj4Dw/EKETuuNEMqE
 OahGHB3X5POtC//7EKx0C3O+0QdbG817i6rVRyLdIF6sVCVZQh3Yhjnq/FhFfz/ZyRdvi9n/M
 FMHrmla+n0gw+i+lQ+TgJzsbyiN7rePiyT4/+RlJNtfwtmSvPURwlHDkMZ7kFtNxo4rwcwizz
 dY4nGI6mrR7qoLB/OFj55YMb+68A2pimjvCrJg/xb/vQ7Bjw/+0S5agM90s/HVbjqPapM+Efz
 V+0uk53N1Pb35eu5CnsrRVWNeMwvJJSpSfovx1zkXUvppUCwpVUo1ZzMRMcizXI4C3CRkTONF
 SpGpgJeGxf2MpMXB9fFqmkUsjr8KgBJcgcM6sHRrYH72a8kv7750MKEFNonLOVV5dqHdLk60b
 HRxL4I45q0keAGXw2zEdaT+01xSCpG2Z64tt+KZXVenDAoNOtuehuOo23yLm9DfrxF6y+NEvV
 E2KEd1hfoytpJc5m17r15fLlXVXWJ8HfjdrSC0EgK3yvTGsffCy7IBwx8qwgUKCbztR4awWnx
 QA/fHm1oRzB9E+OeThIW65y/RfeoRkMoSMTpmsfQrwgOMNFXTN6Y4g0tA37YCwwCC80InNP5b
 jCAFVU5q7jrV6bu9nYQE7UhPErHO60TluXrQGe4RyVsldfDE0ww4PbbpUcr03AnuwUKbNhGRp
 YmblfK+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Wed, 11 Jul 2018, Ben Peart wrote:

> Teach test-drop-caches to handle lower case drive letters on Windows.

Maybe mention that you can trigger this by using a lower case drive letter
in Powershell (CMD normalizes your path, Powershell does not).

> diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
> index d6bcfddf13..37047189c3 100644
> --- a/t/helper/test-drop-caches.c
> +++ b/t/helper/test-drop-caches.c
> @@ -16,7 +16,7 @@ static int cmd_sync(void)
>  	if ((0 == dwRet) || (dwRet > MAX_PATH))
>  		return error("Error getting current directory");
>  
> -	if ((Buffer[0] < 'A') || (Buffer[0] > 'Z'))
> +	if ((toupper(Buffer[0]) < 'A') || (toupper(Buffer[0]) > 'Z'))
>  		return error("Invalid drive letter '%c'", Buffer[0]);

This is a rather incomplete test, as it does not even test for the colon
after the drive letter.

But I guess the more common case where this code path triggers the error
is when your current directory is a UNC path to a file share (again, only
possible in Powershell, CMD does not let you do that unless you play
serious tricks).

So maybe a much better idea is to use our `has_dos_drive_prefix()`
function:

	if (!has_dos_drive_prefix(Buffer))
		return error("'%s': invalid drive letter", Buffer);

Ciao,
Johannes
