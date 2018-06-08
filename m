Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C6F71F403
	for <e@80x24.org>; Fri,  8 Jun 2018 20:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753040AbeFHUc7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 16:32:59 -0400
Received: from mout.web.de ([212.227.17.12]:50517 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752883AbeFHUc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 16:32:57 -0400
Received: from [192.168.178.36] ([79.237.242.156]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1X9B-1gG3jo113J-00tSrn; Fri, 08
 Jun 2018 22:32:45 +0200
Subject: Re: [PATCH v8 1/2] json_writer: new routines to create data in JSON
 format
To:     git@jeffhostetler.com, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180607141209.24423-1-git@jeffhostetler.com>
 <20180607141209.24423-2-git@jeffhostetler.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <515709a2-3cfe-b147-6176-ff95455e1692@web.de>
Date:   Fri, 8 Jun 2018 22:32:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607141209.24423-2-git@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HGHup4Z7wrYdPCUpS4h/bdXOnXhnXXKu8VxbOz2vQsvaXPZsxRm
 lbrajLn5K0aKU4BLh0NOq7QehSOYl5E7HhBPm+r7Swi3PLrC9DgRDky8wOnrFT/7hNAqKvD
 u9hrlnO8ORDzU55rMTqjpdzzfbhYJf4W9oUoVO0hkFCFKxo+x6+rROTfTb6m3A31oWIiM/J
 ZQ4X+5WCkMF8J98HpwLIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/4wxRi19js4=:FakOqTzFHMKxb3Omi1i1CL
 gfn8oOVKhErhm+o6tDJce9vO917WvtRArLmJltaoY/QgkO4BYlSVsKF79DVqQ0UzuGkzYowYQ
 ZX6r8mWCgymjaVNPn08IFjoconF6QoDr8ydAaGN3yEcCjP/ldbvzRwNJ0hq1m3Ew/CrHsJgxg
 DamKxG3vr61MGhXznHEAKGKofNs/PDysXWfe1A+FOiq1KZXudQpWSEXET/4+lMmJaxmYNKeoY
 9LERLzw+OZijMWgdhbaHrvbPHMHLS7VfZbWrGNPNMWDBNV9JdN4yIM/euEEXC0ZshebMnt3RO
 QAFzDCkXZ5l9/6HJ2bsZGXMVI4Ws6ekYA02d33JmFkHFmq3V/gzktTVI70kZcD88Jq262Kp2g
 l21SrRKCOJQc7JusvFTDr9txat9taZRaz2vPIIJtuSgjOuoMAtPCkBdd68CqnMcr45r2rHmfM
 CudOBYIpdGiT3+c8TblRF+4amvcSTO9UGpi7U09TkBrXlIOMOUZ4bQiAgoRL0KF9yl+N82Xxc
 CCoUeF+7mKZd4Vnbf6z4nHgwxDoce2F9Qp0C+ht9oVVUjjvyWzJg2FFb9g+DqFxGtx0mwF+wO
 WdwJ/GB6rZXKejl0MzFMtkvr3RD9MNPs2qoGflKddQAJVEyREPkQQTsQvbezQq6U8J013J5po
 QVQoaQ6ZGo4kkDw+l4utYLTf0Bel9kUXAX+W42OI+8VEJAyAPOxLK90kWMDkVt8kqqtxbCsLD
 qekSalXn9hLXW8NB895/4xBcCDF0D4FzBNrQultH9pdI20CrSiXdHqBcZ3jLniD4OFWgMfaDr
 TLKQvHX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.06.2018 um 16:12 schrieb git@jeffhostetler.com:
>   Makefile                    |   2 +
>   json-writer.c               | 419 ++++++++++++++++++++++++++++++++
>   json-writer.h               | 113 +++++++++
>   t/helper/test-json-writer.c | 572 ++++++++++++++++++++++++++++++++++++++++++++
>   t/t0019-json-writer.sh      | 236 ++++++++++++++++++
>   5 files changed, 1342 insertions(+)
>   create mode 100644 json-writer.c
>   create mode 100644 json-writer.h
>   create mode 100644 t/helper/test-json-writer.c
>   create mode 100755 t/t0019-json-writer.sh

$ git grep 'static inline' '*json*'
json-writer.c:static inline void indent_pretty(struct json_writer *jw)
json-writer.c:static inline void begin(struct json_writer *jw, char ch_open, int pretty)
json-writer.c:static inline void assert_in_object(const struct json_writer *jw, const char *key)
json-writer.c:static inline void assert_in_array(const struct json_writer *jw)
json-writer.c:static inline void maybe_add_comma(struct json_writer *jw)
json-writer.c:static inline void fmt_double(struct json_writer *jw, int precision,
json-writer.c:static inline void object_common(struct json_writer *jw, const char *key)
json-writer.c:static inline void array_common(struct json_writer *jw)
json-writer.c:static inline void assert_is_terminated(const struct json_writer *jw)
t/helper/test-json-writer.c:static inline int scripted(int argc, const char **argv)
t/helper/test-json-writer.c:static inline int my_usage(void)

Do you need all those inline keywords?  I'd rather leave the decision
about inlining to the compiler and (via optimization flags) the user
as much as possible.  Not a biggie, but the high frequency of that
word made me blink..

René
