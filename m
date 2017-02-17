Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A911B2013A
	for <e@80x24.org>; Fri, 17 Feb 2017 08:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932075AbdBQIpP (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 03:45:15 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:61597 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754276AbdBQIpO (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Feb 2017 03:45:14 -0500
X-AuditID: 1207440e-cb3ff7000000340b-f1-58a6b80d83f0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 0D.77.13323.D08B6A85; Fri, 17 Feb 2017 03:45:02 -0500 (EST)
Received: from [192.168.69.190] (p4FEDF52F.dip0.t-ipconnect.de [79.237.245.47])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1H8ix6J021253
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 17 Feb 2017 03:45:01 -0500
Subject: Re: [PATCH v2 11/19] builtin/replace: convert to struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20170214023141.842922-1-sandals@crustytoothpaste.net>
 <20170214023141.842922-12-sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <f7e35bf8-a320-6ac1-6184-977d6bf6de08@alum.mit.edu>
Date:   Fri, 17 Feb 2017 09:44:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170214023141.842922-12-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsUixO6iqMu3Y1mEwfK3TBZdV7qZLH609DBb
        tM38weTA7LH85l8mj2e9exg9Pm+SC2CO4rJJSc3JLEst0rdL4MqYcuQma8FRpoqF7XfYGxjb
        mboYOTkkBEwkfl2awdzFyMUhJLCDSeL3uqVMEM55IKf7GgtIlbCAl8TSzWdYQWwRIHv+oxlA
        NgdQUY3ElWlgYWYBWYn1K/4ygthsAroSi3qawRbwCthLdK05C2azCKhKrNh2AGykqECIxJyF
        DxghagQlTs58AhbnFHCRmH1xGwvETD2JHdd/Qc2Xl9j+dg7zBEb+WUhaZiEpm4WkbAEj8ypG
        ucSc0lzd3MTMnOLUZN3i5MS8vNQiXWO93MwSvdSU0k2MkBDl28HYvl7mEKMAB6MSD2/G9qUR
        QqyJZcWVuYcYJTmYlER5F01bFiHEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhPf/VqAcb0piZVVq
        UT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mC12w7UKNgUWp6akVaZk4JQpqJgxNk
        OA/Q8LNbQIYXFyTmFmemQ+RPMepynPp04SWTEEtefl6qlDivB8ggAZCijNI8uDmw1PKKURzo
        LWFenW1AVTzAtAQ36RXQEiagJZ0RS0GWlCQipKQaGH33r3+i0nH3gnmp4teFB6P0gh72lr5d
        bSL3tjijosNiTtParOUnbs15sjlo2X6Zipuib4NqFA81xWk+XfK4MCWs2fBL9ScG98k5HgrL
        rXh7Betnbzm2SuaRZOaX15WCVgK5irwFq65+L/uUvtY5j0X5mIN5yJwNUku2pbXMiWcwyv9v
        fmv2aiWW4oxEQy3mouJEABdaVpYIAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/14/2017 03:31 AM, brian m. carlson wrote:
> Convert various uses of unsigned char [20] to struct object_id.  Rename
> replace_object_sha1 to rename_object_oid.  Finally, specify a constant
> in terms of GIT_SHA1_HEXSZ.

The new name is not rename_object_oid but rather replace_object_oid.

> [...]

Michael

