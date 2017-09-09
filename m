Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0670A1FAD6
	for <e@80x24.org>; Sat,  9 Sep 2017 05:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbdIIFpK (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Sep 2017 01:45:10 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:43693 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751244AbdIIFpJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Sep 2017 01:45:09 -0400
X-AuditID: 1207440e-bf9ff70000007085-fb-59b37fe408c7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 45.0F.28805.4EF73B95; Sat,  9 Sep 2017 01:45:08 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC859.dip0.t-ipconnect.de [87.188.200.89])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v895j6Ga018514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 9 Sep 2017 01:45:07 -0400
Subject: Re: [PATCH v4 06/16] refs: move submodule slash stripping code to
 get_submodule_ref_store
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
 <20170823123704.16518-7-pclouds@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <c620f399-9074-4a43-aed1-3995a1651114@alum.mit.edu>
Date:   Sat, 9 Sep 2017 07:45:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170823123704.16518-7-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqPukfnOkwYZ5GhZdV7qZLBp6rzBb
        dE95y2ixeXM7iwOLx85Zd9k9Fmwq9bh4Sdnj8ya5AJYoLpuU1JzMstQifbsErox1m7cxFSxh
        r1hxdAZTA+Mv1i5GTg4JAROJXUcOM3UxcnEICexgkvg3axaUc45J4sL+t2wgVcICKRIXt+9n
        B7FFBNIkFk9+z9zFyMHBLOAlMe9jOUhYSCBZYu7ZL2BD2QR0JRb1NDOB2LwC9hJvvs1jBCln
        EVCRmHPUACQsKhAh0ff2MjtEiaDEyZlPWEBsTgFziYaFHWCtzALqEn/mXWKGsMUlbj2ZDxWX
        l2jeOpt5AqPALCTts5C0zELSMgtJywJGllWMcok5pbm6uYmZOcWpybrFyYl5ealFusZ6uZkl
        eqkppZsYIQHOt4Oxfb3MIUYBDkYlHt6K7ZsihVgTy4orcw8xSnIwKYnyXqjdHCnEl5SfUpmR
        WJwRX1Sak1p8iFGCg1lJhNesBijHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgST
        leHgUJLgZQJGspBgUWp6akVaZk4JQpqJgxNkOA/Q8Ll1IMOLCxJzizPTIfKnGI059uy9/oeJ
        48ZDICnEkpeflyolzmsMUioAUppRmgc3DZakXjGKAz0nzLsEpIoHmODg5r0CWsUEtKrk+QaQ
        VSWJCCmpBsYoIY9C/S2T31+e1h+zJ3L3tBuTP019Ni34b1ukOuP/QstGuyMKXhGZ4vEfcvta
        rGuMD/4JKJ2V15rSfqSsSSF2xvd13brl7I4n3rO7m7xgOHXWhXGRSj+fdk+g/LzDVzRSa38l
        L+iNbJ+p6PHwcIjV4ts5E3bEFor8018gHrD9L7dS/1P1qUosxRmJhlrMRcWJAPI8kvQtAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/23/2017 02:36 PM, Nguyễn Thái Ngọc Duy wrote:
> This is a better place that will benefit all submodule callers instead
> of just resolve_gitlink_ref()

This is a nice sentiment, but I have to wonder whether we should rather
be requiring callers to use the "canonical" submodule name rather than
covering up their sloppiness for them (perhaps multiple times?). I
vaguely remember intentionally limiting the number of functions that do
this canonicalization, and having in mind the goal that the number
should become smaller over time, not larger.

For example, there could be some kind of `canonicalize_submodule_name()`
function that callers can use to clean up whatever submodule string they
have in hand, then let them use the cleaned up value from then on.

I don't really know much about the callers, though, so that is more of a
lazy philosophical speculation than a concrete suggestion.

Michael
