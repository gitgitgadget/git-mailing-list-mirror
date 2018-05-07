Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7CBF1F42E
	for <e@80x24.org>; Mon,  7 May 2018 07:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbeEGHjM (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 03:39:12 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49914 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750990AbeEGHjL (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 May 2018 03:39:11 -0400
X-AuditID: 12074411-a9fff70000001186-28-5af0029e43cc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 97.9D.04486.E9200FA5; Mon,  7 May 2018 03:39:10 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCCC0.dip0.t-ipconnect.de [87.188.204.192])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w477d7r2023499
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 7 May 2018 03:39:08 -0400
Subject: Re: [PATCH] refs: handle null-oid for pseudorefs
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?Rafael_Ascens=c3=a3o?= <rafa.almas@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Turner <novalis@novalis.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <CACUQV5-9PagVhE5YY=Z3721YRiBwSZykT3ZjtzmD3o-c6O6ddQ@mail.gmail.com>
 <20180506133549.8536-1-martin.agren@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <1291dbc0-31f9-213a-ae30-1a6349ea1626@alum.mit.edu>
Date:   Mon, 7 May 2018 09:39:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180506133549.8536-1-martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsUixO6iqDuP6UOUQeNyG4uuK91MFg29V5gt
        3t5cwmjx900Xo8WSh6+ZLT4dvMli0TbzB5MDu8fym3+ZPHbOusvu0dV+hM3j4iVlj8+b5AJY
        o7hsUlJzMstSi/TtErgy/nY2shUc5a3Y2W7SwNjD1cXIySEhYCLR++oMSxcjF4eQwA4mifd9
        25khnPNMEksONLOBVAkLWEo0zzzODGKLCNRI7Pr5BKyDWeAyo0TXml9MEB2NjBI7Wt+ygFSx
        CehKLOppZgKxeQXsJeb92AnWzSKgIrHp+XxGEFtUIELi3vlPbBA1ghInZz4B6+UUsJboevuK
        HcRmFlCX+DPvEjOELS5x68l8JghbXqJ562zmCYwCs5C0z0LSMgtJyywkLQsYWVYxyiXmlObq
        5iZm5hSnJusWJyfm5aUW6Zrq5WaW6KWmlG5ihESE4A7GGSflDjEKcDAq8fCumPI+Sog1say4
        MvcQoyQHk5IoL/cDoBBfUn5KZUZicUZ8UWlOavEhRgkOZiURXv6jQDnelMTKqtSifJiUNAeL
        kjgvs8neKCGB9MSS1OzU1ILUIpisDAeHkgRvH+OHKCHBotT01Iq0zJwShDQTByfIcB6g4dYg
        NbzFBYm5xZnpEPlTjIpS4ryXQBICIImM0jy4XljCesUoDvSKMG8SSBUPMNnBdb8CGswENFgQ
        5CPe4pJEhJRUA6P03e2ciw6s2tix6MRrsUnb0xssCll8Prxrj7zIXJfrnLd5YeZNVZ6tjodj
        bJRv5D5YxpheED5786RFFvfrXsa6Lp3u+XR+5oTF21Ksdk4Ka25ytNfLs+F7FvlaNOxf8ezC
        xTkq+zvZcz8zhBxpn3LVQvDFfsu071lMby/P5L3zsv+yiWnaRm4lluKMREMt5qLiRAA/+4jB
        MwMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/06/2018 03:35 PM, Martin Ågren wrote:
> According to the documentation on `git update-ref`, it is possible to
> "specify 40 '0' or an empty string as <oldvalue> to make sure that the
> ref you are creating does not exist." But in the code for pseudorefs, we
> do not implement this. If we fail to read the old ref, we immediately
> die. A failure to read would actually be a good thing if we have been
> given the null-oid.
> 
> With the null-oid, allow -- and even require -- the ref-reading to fail.
> This implements the "make sure that the ref ... does not exist" part of
> the documentation.
> 
> Since we have a `strbuf err` for collecting errors, let's use it and
> signal an error to the caller instead of dying hard.
> 
> Reported-by: Rafael Ascensão <rafa.almas@gmail.com>
> Helped-by: Rafael Ascensão <rafa.almas@gmail.com>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>

Thanks for the patch. This looks good to me. But it it seems that the
test coverage related to pseudorefs is still not great. Ideally, all of
the following combinations should be tested:

Pre-update value   | ref-update old OID   | Expected result
-------------------|----------------------|----------------
missing            | missing              | accept *
missing            | value                | reject
set                | missing              | reject *
set                | correct value        | accept
set                | wrong value          | reject

I think your test only covers the lines with asterisks. Are the other
scenarios already covered by other tests? If not, how about adding them?
That would give us confidence that the new code works in all circumstances.

Michael
