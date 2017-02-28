Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FD5B201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 18:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbdB1SJI (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 13:09:08 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:49687 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751467AbdB1SJE (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Feb 2017 13:09:04 -0500
X-AuditID: 1207440d-029ff70000003721-95-58b5bc46f685
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 25.C2.14113.64CB5B85; Tue, 28 Feb 2017 13:07:02 -0500 (EST)
Received: from [192.168.69.190] (p5B10410E.dip0.t-ipconnect.de [91.16.65.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1SI6wR7017488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 28 Feb 2017 13:07:00 -0500
Subject: Re: [PATCH v5 13/24] refs.c: make get_main_ref_store() public and use
 it
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-14-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <a6e3f43b-a97c-6aa4-d80d-de342049df9f@alum.mit.edu>
Date:   Tue, 28 Feb 2017 19:06:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170222140450.30886-14-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqOu2Z2uEweIJvBZdV7qZLBp6rzBb
        9C/vYrNY8vA1s0X3lLeMFjOvWlts3tzO4sDusXPWXXaPDx/jPBZsKvXoaj/C5nHxkrLH/qXb
        2Dw+b5ILYI/isklJzcksSy3St0vgyvixYy5jwR2mijOruRsY5zF1MXJySAiYSHz+0wZkc3EI
        CexgkuhZfYQNwjnLJHF9y15mkCphgWCJ92/egdkiAmkSiye/Z4YomsAocbpxJyOIwyxwg1Hi
        0sSPYHPZBHQlFvU0g9m8AvYST7ZNZAOxWQRUJZb/uAlmiwqESMxZ+IARokZQ4uTMJywgNqeA
        hcSExsNgNrOAusSfeZeYIWx5ieats5knMPLPQtIyC0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm
        6xYnJ+blpRbpGunlZpbopaaUbmKEhDvvDsb/62QOMQpwMCrx8GZ0bo0QYk0sK67MPcQoycGk
        JMobNAMoxJeUn1KZkVicEV9UmpNafIhRgoNZSYR3RzFQjjclsbIqtSgfJiXNwaIkzqu2RN1P
        SCA9sSQ1OzW1ILUIJivDwaEkwdu+C6hRsCg1PbUiLTOnBCHNxMEJMpwHaPhpkBre4oLE3OLM
        dIj8KUZdjhvHD7xhEmLJy89LlRLn3Q1SJABSlFGaBzcHlqZeMYoDvSXM+w2kigeY4uAmvQJa
        wgS05IUK2JKSRISUVANjZL3CosepJ5h23Amuv3fu3NyTndNs1s4XUDG4kxu6QKOku3ChacTi
        HxURj6pc5s8UVr1w76mS3K2/rXW7X5wVfhy9r3Xd54PJe7hnzF31Tb9BavKsoBkFuva8inw7
        PC8tr5orLpTvJXv/j4DTEoHbgVxXEnOzz63R1F5rdfzQ1K6zhZv/Rn92VmIpzkg01GIuKk4E
        ACCFC+IuAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22/2017 03:04 PM, Nguyễn Thái Ngọc Duy wrote:
> get_ref_store() will soon be renamed to get_submodule_ref_store().
> Together with future get_worktree_ref_store(), the three functions
> provide an appropriate ref store for different operation modes. New APIs
> will be added to operate directly on ref stores.

Nice.

Michael

