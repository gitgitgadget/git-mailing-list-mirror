Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45B3A205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933190AbdABPh0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:37:26 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:55111 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932966AbdABPhZ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Jan 2017 10:37:25 -0500
X-AuditID: 1207440f-46bff700000009ea-5e-586a73ac259c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 35.96.02538.CA37A685; Mon,  2 Jan 2017 10:37:17 -0500 (EST)
Received: from [192.168.69.190] (p5B10411C.dip0.t-ipconnect.de [91.16.65.28])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v02FbF6m031704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 2 Jan 2017 10:37:16 -0500
Subject: Re: [PATCH 00/17] object_id part 6
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20170101191847.564741-1-sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <4780c459-b40c-3b5c-e780-fd792a35ce8f@alum.mit.edu>
Date:   Mon, 2 Jan 2017 16:37:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170101191847.564741-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsUixO6iqLu2OCvC4MF1QYuuK91MFj9aepgt
        2mb+YHJg9lh+8y+Tx7PePYwenzfJBTBHcdmkpOZklqUW6dslcGX8f7iVueAAS8WOlpVMDYxn
        mbsYOTkkBEwkOhZ/Zuti5OIQErjMKHHq61p2COcMk8T8Bd8Yuxg5OIQFtCUW/0kFaRAR8JKY
        /2gGK0hYSMBJ4sy/FJAws4CsxPoVfxlBbDYBXYlFPc1MIDavgL1E26x3rCA2i4CKxNx1v8Fq
        RAVCJC7POcoGUSMocXLmExYQm1PAWeJO4ydWiJl6Ejuu/4Ky5SW2v53DPIGRfxaSlllIymYh
        KVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdELzezRC81pXQTIyRA+Xcwdq2XOcQowMGo
        xMPbEZUVIcSaWFZcmXuIUZKDSUmUN2FDRoQQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd4tRUDl
        vCmJlVWpRfkwKWkOFiVxXvUl6n5CAumJJanZqakFqUUwWRkODiUJXh+QRsGi1PTUirTMnBKE
        NBMHJ8hwHqDhG8GGFxck5hZnpkPkTzHqchx4v+IpkxBLXn5eqpQ4736QIgGQoozSPLg5sMTy
        ilEc6C1hXnWQKh5gUoKb9ApoCRPQkq9x6SBLShIRUlINjPXhW0rfhM+9HvXVrrCLoztwuuBS
        H3MdJfaE6C0Pmhh0E7c8O6eRso2h12t+bX/V/mcH5l7esO2A99wr64UeeXa9yq/bIhReZCPz
        p3OB85V1u/ik/3g+4Aq7wuJ4ufiUk/mMxQYXyh3utH5ddiGs+DzHxUf8MspZ/9wj9iYVMTl6
        rE/iePfzlhJLcUaioRZzUXEiAKZiKRMHAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/01/2017 08:18 PM, brian m. carlson wrote:
> This is another series in the continuing conversion to struct object_id.
> 
> This series converts more of the builtin directory and some of the
> refs code to use struct object_id. Additionally, it implements an
> nth_packed_object_oid function which provides a struct object_id
> version of the nth_packed_object function.
> 
> There is a small known conflict with next, but it can easily be fixed up.

I read through all of the patches, and sent a few comments. I didn't
notice any other problems.

Michael

