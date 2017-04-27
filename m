Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38DFC1FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 04:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbdD0Ez6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 00:55:58 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:53205 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751601AbdD0Ez4 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Apr 2017 00:55:56 -0400
X-AuditID: 1207440d-de7ff70000000e33-66-590179d81d13
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 68.97.03635.8D971095; Thu, 27 Apr 2017 00:55:55 -0400 (EDT)
Received: from [192.168.69.190] (p5B104215.dip0.t-ipconnect.de [91.16.66.21])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3R4to8g018647
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 27 Apr 2017 00:55:51 -0400
Subject: Re: [PATCH 38/53] refs: convert struct ref_update to use struct
 object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
 <20170423213453.253425-39-sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
        <pclouds@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <c68038fc-5014-8b48-0ea3-a26a54e7d353@alum.mit.edu>
Date:   Thu, 27 Apr 2017 06:55:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170423213453.253425-39-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsUixO6iqHu7kjHSoPmmoEXXlW4mi+4pbxkt
        frT0MFu0zfzB5MDisfzmXyaPnbPusns8693D6PF5k1wASxSXTUpqTmZZapG+XQJXxv75v9kL
        upkq3p6/xdjAeJWxi5GTQ0LAROLaymlMXYxcHEICO5gkNqz6yg6SEBI4yySx7jc3iC0sECLR
        cOcaC4gtIuAlMf/RDFaImhqJxs/vwWxmgQqJtw2n2UBsNgFdiUU9zUwgNq+AvcSsJ//BbBYB
        VYmuDXfBbFGgmXMWPmCEqBGUODnzCdh8TgEXieY7PSwQM/Ukdlz/BTVfXmL72znMExj5ZyFp
        mYWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdI30cjNL9FJTSjcxQsKWdwfj/3Uy
        hxgFOBiVeHgdNjJECrEmlhVX5h5ilORgUhLl5fZjjBTiS8pPqcxILM6ILyrNSS0+xCjBwawk
        wpteCJTjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwVlYANQoWpaan
        VqRl5pQgpJk4OEGG8wAN9wCp4S0uSMwtzkyHyJ9i1OWYc+/reyYhlrz8vFQpcd5YkCIBkKKM
        0jy4ObB084pRHOgtYd4JIFU8wFQFN+kV0BImoCUsLgwgS0oSEVJSDYyWU7xWbp5u+U96McuH
        XYf2/JcMa3Ofq1n19rc/5zNJl2uPlWLM9epSX93kdK0yPbDROCF599yG65eVhL97+catUT7p
        xzFzIr//RWuvzU17H8y5FBwg86AoXo3D/5r1hXre1I9yLD4d9VdmV3kf8D5tdq0kPyy3TkHR
        YeLxKQ8va0seXHTqY68SS3FGoqEWc1FxIgAiSEFxEgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/23/2017 11:34 PM, brian m. carlson wrote:
> Convert struct ref_array_item to use struct object_id by changing the
> definition and applying the following semantic patch, plus the standard
> object_id transforms:
> [...]

This commit LGTM.

Michael


