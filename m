Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A92B920372
	for <e@80x24.org>; Wed, 11 Oct 2017 08:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757279AbdJKIaq (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 04:30:46 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:48390 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757189AbdJKIao (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Oct 2017 04:30:44 -0400
X-AuditID: 1207440e-be1ff70000007085-37-59ddd6b32653
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 38.34.28805.3B6DDD95; Wed, 11 Oct 2017 04:30:43 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCD9E.dip0.t-ipconnect.de [87.188.205.158])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9B8UegE006755
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 11 Oct 2017 04:30:42 -0400
Subject: Re: [PATCH v2 23/24] refs: convert read_raw_ref backends to struct
 object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <20171009011132.675341-24-sandals@crustytoothpaste.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <cebd6976-833e-ebb4-ef90-445e3b338d36@alum.mit.edu>
Date:   Wed, 11 Oct 2017 10:30:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171009011132.675341-24-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqLv52t1Ig9ZTShbP159gt+i60s1k
        8aOlh9mibeYPJovNm9tZHFg9lt/8y+SxYFOpx7PePYwenzfJBbBEcdmkpOZklqUW6dslcGX8
        7ZvEVnCbqeLq+YtMDYxzmLoYOTkkBEwkJr2bz9zFyMUhJLCDSeLl+qVMEM4FJollj+awglQJ
        C4RLbNy9EswWEfCSmP9oBpjNLFAg8bz9DiOILSRQIzH91AawOJuArsSinmawDbwC9hIdp3+y
        gNgsAqoSc78dAKrh4BAViJDYsJEfokRQ4uTMJ2AlnAIuEhO2r2GDGK8u8WfeJWYIW1zi1pP5
        TBC2vMT2t3OYJzAKzELSPgtJyywkLbOQtCxgZFnFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGus
        l5tZopeaUrqJERLufDsY29fLHGIU4GBU4uEVuH4nUog1say4MvcQoyQHk5Ior8Kcu5FCfEn5
        KZUZicUZ8UWlOanFhxglOJiVRHiDLwLleFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1ML
        UotgsjIcHEoSvGeuAjUKFqWmp1akZeaUIKSZODhBhvMADY8EqeEtLkjMLc5Mh8ifYtTluPHw
        +h8mIZa8/LxUKXFeD5AiAZCijNI8uDmwNPWKURzoLWFecWDSEuIBpji4Sa+AljABLRFNuwOy
        pCQRISXVwCg2s/e4gP68e6t+/HrPcOfvpC7O/Ton6mLEbf9cT5zSn+mzzPf1qrlO/jfbAr0D
        41ZPDyvnWbPy5azuWOu/6xflelZOzVuiWPbN7al/3TlevqOTG25cai+cGyVZnZBvccmO1VmW
        sVnntaJnkKjjn9thVUYVsumNZ+afOd9xfaXZHLs3B54dVFNiKc5INNRiLipOBACEwMU8LgMA
        AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/09/2017 03:11 AM, brian m. carlson wrote:
> Convert the unsigned char * parameter to struct object_id * for
> files_read_raw_ref and packed_read_raw-ref.  Update the documentation.

Nit:

s/packed_read_raw-ref/packed_read_raw_ref/

> Switch from using get_sha1_hex and a hard-coded 40 to using
> parse_oid_hex.
> [...]

Michael
