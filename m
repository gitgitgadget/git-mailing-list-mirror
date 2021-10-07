Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC534C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 16:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83E8C61130
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 16:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241942AbhJGQaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 12:30:10 -0400
Received: from mail-oln040092068024.outbound.protection.outlook.com ([40.92.68.24]:54473
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233610AbhJGQaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 12:30:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cf3Mjl1r1rNQXMcDLYyVqTReR6IBaC4GSMazms8TmdFSDwPhowly0Mtkw5qk/YpFAyF/wpI+r6q+ZatESaD2+8c343Nq+Idno+2R7HaMzpud2pax4UCWtJEWRJnU0cficX/FAJwZlynCKt/3GRUE5b2y9yk1vnpXEgg9GzByM4Zsgqc0X+Ls9jOVyehsfYTaP1l/+e5gb5nGt1yiaf7UcMOIXPTqI5+gQEgwujnuGGfkRPp3EVa6Aaz9cgnjRAKZw0fmcQdu4QElOyQNm9QQXuNb8EWtTJSEsi8jVjyQEI5/s6N3XlerEUoa2makle8Z4v+GTiiutWqeCG4+v3Pn1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0MAPdi+2819s7ySqFAj17mWdA/24i2xjrxkUEJfOvg=;
 b=UY2VWAofCSPtzxHbK6Cezm5IeYvARbOIcr+sasLFVIZIbpHsZ1AFGYl31VI3f5SYFE5DPdkwJRzx/bLLJVjy8i2N0X1KbOnhOEu9hnL79EUJG/CGEjjkP2iyGn74X7u9UKRmibflYq/vZghooIUz9Xv8MlyHtWBEPvic522sms6JqA306gNqshvUfKmVpDvlNH2qShQ96bPiO4eNolQhRfEvgZVNpvu7nCtvj/mJZTpb3vhuOzGPS8Kk0HfeeN7yPjHissbKN2a/kPcxP1MWGhTG/DhMLg4Tk3VVPAxzTCncKk14Dag51Vfg0dyskSoSHMW3m0eapYgAipV8VUpb9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM0PR04MB6019.eurprd04.prod.outlook.com (2603:10a6:208:141::13)
 by AM0PR04MB6226.eurprd04.prod.outlook.com (2603:10a6:208:147::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 16:28:14 +0000
Received: from AM0PR04MB6019.eurprd04.prod.outlook.com
 ([fe80::b9eb:3ad3:9332:5d65]) by AM0PR04MB6019.eurprd04.prod.outlook.com
 ([fe80::b9eb:3ad3:9332:5d65%7]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 16:28:14 +0000
Date:   Thu, 7 Oct 2021 18:28:12 +0200 (CEST)
From:   =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To:     Rene Hutschenreuter <rene.hutschi@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Security issues with openssl.exe
In-Reply-To: <CAP_xbc=ag3+Bkvwtou4ZaYrnVm67kb37=oZEc5eTx8FsufhV=Q@mail.gmail.com>
Message-ID: <AM0PR04MB6019545C115A7161E83881A8A5B19@AM0PR04MB6019.eurprd04.prod.outlook.com>
References: <CAP_xbc=PZq2Qs8KUVYJVofpTxucf43TeSm8Bk4Pxcb0wn70KjQ@mail.gmail.com> <CAP_xbc=ag3+Bkvwtou4ZaYrnVm67kb37=oZEc5eTx8FsufhV=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TMN:  [nW7ZUlcd8YNrPfOvz/VgErJymeQxEp06aiiKqBxertRvR20s2lo3jholuXQwVZf2]
X-ClientProxiedBy: AM6PR05CA0026.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::39) To AM0PR04MB6019.eurprd04.prod.outlook.com
 (2603:10a6:208:141::13)
X-Microsoft-Original-Message-ID: <9b6d6062-65af-f69c-9a49-536d97d06166@live.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from p200300d3bf139000215a97ccbed7509a.dip0.t-ipconnect.de (2003:d3:bf13:9000:215a:97cc:bed7:509a) by AM6PR05CA0026.eurprd05.prod.outlook.com (2603:10a6:20b:2e::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Thu, 7 Oct 2021 16:28:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db60c156-ab93-4861-02cc-08d989af759a
X-MS-TrafficTypeDiagnostic: AM0PR04MB6226:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BY8odNGrfl4HQGjXjG4lJsUfWWSpSODyjVj70T2o11i3GZraKRKuOVHri/kZJDJWTdmIG1zPKLVsClS/IPXoXrqx3iOGWMp8IUHoelcASBiV0Tz6kTFHjqI7vmcYALb65LsjWP8I+bCaxXSsCCy2ij5N8gsKjVwKHqFxuan4/jnViU0paMeCj4IfzGYuKuRbnGr5yg7EWiYqhsou/Vhefh62XJoAATe8A3QMqregP6iJhavemj3+yGO/v8d9BklZzOzeuzaqbxTLfaUfeDpqpAVVMu8WlR07tQv+jvyAQSX+vhhUpEjJLr0XVyFnVlsm/kupUhUdgpGQnTp7zfJ5yZHxAb0a+BMMFkzDxBqI8JtNNS9M3ftP+KPAAq6YqYvkV0Jcd1ec2e51Dcws7U97lfJ6cgnqLqFGSHMvD291S7brKiLjEdfC0GHYZKQx3uiuYhskS1fc7T3cqwrZ2X33rJcoL56VPq0cYoXpw2uclwk=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UH7yVljlnvbkSsfFw7Pk10D5n1x3jedfNvR7NOKMCJ7GMipb/EVukwdgDTan5ocD6kTIsTGumVvb0NwuZRl4LUFkkq0B5qbicg+iLoAkJhuFpzY5q0mmln1WN/ZRfyDPyKgNTwRDtqQ1ukQ5dWUHapzCE2mlRQIrJ2amHfjJ/y5o6YFuEmNihk+Dpt8pZkYxP/htEp+tVaIDnKIpi7jJxg==
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-adf9b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: db60c156-ab93-4861-02cc-08d989af759a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 16:28:14.3150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6226
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Thu, 7 Oct 2021, Rene Hutschenreuter wrote:

> Dear Sir or Madam,
>
> in our company we currently use GIT for programming tasks. Furthermore
> we use a VPN to connect to the company network.
>
> This VPN now prevents this connection due to a security problem with
> the "openssl.exe" in the GIT installation folder:
> - C:\Program Files\Git\mingw64\bin\openssl.exe
>
> Description-Text: In order to decrypt SM2 encrypted data an
> application is expected to call the API function EVP_PKEY_decrypt().
> Typically an application will call this function twice. The first
> time, on entry, the \"out\" parameter can be NULL and, on exit, the
> \"outlen\" parameter is populated with the buffer size required to
> hold the decrypted plaintext. The application can then allocate a
> sufficiently sized buffer and call EVP_PKEY_decrypt() again, but this
> time passing a non-NULL value for the \"out\" parameter. A bug in the
> implementation of the SM2 decryption code means that the calculation
> of the buffer size required to hold the plaintext returned by the
> first call to EVP_PKEY_decrypt() can be smaller than the actual size
> required by the second call. This can lead to a buffer overflow when
> EVP_PKEY_decrypt() is called by the application a second time with a
> buffer that is too small. A malicious attacker who is able present SM2
> content for decryption to an application could cause attacker chosen
> data to overflow the buffer by up to a maximum of 62 bytes altering
> the contents of other data held after the buffer, possibly changing
> application behaviour or causing the application to crash. The
> location of the buffer is application dependent but is typically heap
> allocated. Fixed in OpenSSL 1.1.1l (Affected 1.1.1-1.1.1k).
>
> Could you please provide a new Git version with an updated openssl.exe
> to fix this security issues?

This sounds like you're talking about Git for Windows and specifically
CVE-2021-3711. The Git for Windows team assesed the situation and 
determined the issue unlikely to be exploitable via Git's usage of 
OpenSSL.

The next regular Git for Windows release (likely 2.34.0, to be released 
soon after the 15th of November) will include OpenSSL 1.1.1l (or newer). In
the meantime you can try the latest snapshot[1] to get a Git for Windows
build that includes OpenSSL 1.1.1l.

[1] https://wingit.blob.core.windows.net/files/index.html

> Best regards
> René Hutschenreuter
> Developer
>

Best regards

Matthias Aßhauer
