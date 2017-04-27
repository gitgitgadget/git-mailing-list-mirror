Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23C091FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 05:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938337AbdD0FEz (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 01:04:55 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:49388 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932269AbdD0FEy (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Apr 2017 01:04:54 -0400
X-AuditID: 12074414-059ff70000004f50-86-59017bf3f978
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id A2.93.20304.3FB71095; Thu, 27 Apr 2017 01:04:52 -0400 (EDT)
Received: from [192.168.69.190] (p5B104215.dip0.t-ipconnect.de [91.16.66.21])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3R54mZG019090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 27 Apr 2017 01:04:50 -0400
Subject: Re: [PATCH 39/53] refs/files-backend: convert many internals to
 struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
 <20170423213453.253425-40-sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
        <pclouds@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <1e4a72a0-9b6c-e9b4-7639-d241558e2120@alum.mit.edu>
Date:   Thu, 27 Apr 2017 07:04:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170423213453.253425-40-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsUixO6iqPulmjHSoP2StUXXlW4mi+4pbxkt
        frT0MFu0zfzB5MDisfzmXyaPnbPusns8693D6PF5k1wASxSXTUpqTmZZapG+XQJXxrfvU9gK
        FrJU3P3+nbWBcTVzFyMnh4SAicSjl0eZuhi5OIQEdjBJLNs1mxnCOcskse7bPaAMB4ewQLTE
        qSceIA0iAl4S8x/NYAWxhQRqJJb3zGcHsZkFKiTeNpxmA7HZBHQlFvU0M4HYvAL2EifufAdb
        xiKgKnH+1w9GEFtUIERizsIHjBA1ghInZz5hAbE5BVwk/hzfxggxU09ix/VfrBC2vMT2t3OY
        JzDyz0LSMgtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Vro5WaW6KWmlG5ihISt
        yA7GIyflDjEKcDAq8fA6bGSIFGJNLCuuzD3EKMnBpCTKy+3HGCnEl5SfUpmRWJwRX1Sak1p8
        iFGCg1lJhDe9ECjHm5JYWZValA+TkuZgURLn/bZY3U9IID2xJDU7NbUgtQgmK8PBoSTBm1UF
        1ChYlJqeWpGWmVOCkGbi4AQZzgM0PA+khre4IDG3ODMdIn+KUZdjzr2v75mEWPLy81KlxHk5
        QYoEQIoySvPg5sDSzStGcaC3hHmTQap4gKkKbtIroCVMQEtYXBhAlpQkIqSkGhgn+x7R7GlR
        2nLowbMNe2SnOF4UUEi+9CJzm8inNd4BsS5dd/hWfPp9QT5X0v7ZWRFL/p0OjhdLn7N5G/0+
        POesyM1X1tPsXlstCpFpjQt7HJSjW3VOsuJw04rv9UfYTTWc/8TLsx8V12a3C+H60isXZbf3
        Us+nXU1PjJRmz7c8fr5haVWilJESS3FGoqEWc1FxIgCtcSAaEgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/23/2017 11:34 PM, brian m. carlson wrote:
> Convert many of the internals of the files backend to use struct
> object_id.  Avoid converting public APIs to limit the scope of the
> changes.
> 
> Convert one use of get_sha1_hex to parse_oid_hex, and rely on the fact
> that a strbuf will be NUL-terminated and that parse_oid_hex will fail on
> truncated input to avoid the need to check for an explicit length.
> 
> This is a requirement to convert parse_object later on.
> [...]

This patch also looks fine to me.

Michael

