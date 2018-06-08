Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F32FB1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 06:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750898AbeFHGGB (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 02:06:01 -0400
Received: from mout.web.de ([212.227.17.12]:60633 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750837AbeFHGGA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 02:06:00 -0400
Received: from [192.168.178.36] ([79.237.242.156]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MX0YK-1foLha2bvY-00Vujk; Fri, 08
 Jun 2018 08:05:42 +0200
Subject: Re: [PATCH v8 1/2] json_writer: new routines to create data in JSON
 format
To:     git@jeffhostetler.com, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180607141209.24423-1-git@jeffhostetler.com>
 <20180607141209.24423-2-git@jeffhostetler.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f1154c86-9d11-f272-643f-4316be40e9b7@web.de>
Date:   Fri, 8 Jun 2018 08:05:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607141209.24423-2-git@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ybluv9LSzOV2OYe/Ra1VbSWp9Hrr6S52zF3p2QMymo2NRGBBgHh
 TZhpHela+awqwXS0EIzENFCITeYoa1BCr0+bI/rfw040n9rK1Xur1X21VS+j2Nwo1ww/65X
 FjD0GCs6oOaeUjVrF0uOmf7JsLRILwfNfKRjBQY8IlzzmK+3dskD32WqHwW9Dzv03X7RA9P
 tXeG0XNh50zk87khrDffg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FobdfQYx2gw=:ESjkBXqDv8RGhx1Pq5czGT
 uKpbRrfcjJgZ0GFaC+gO7aIJSNPxik+2hJ9B3ElncZln6fwh/lk6sZpM+sAAQ7bLHwRA1H/jt
 ebeQzDQiIUeBs7EYiNK8NSp1XysupGvVMKEVwUOou5PWh5P1GSTPEPJSBiwIJjwUUWPusOnYy
 RZ1KGUuN/4JoWfJFQs38Dv2ZVCgxFTCBDuzdFvQtXuKmXcB5VGO1UCRHg5Xdup+hpsipvjt0d
 YTVLsnoBwQ+rBOpFJRCmeatCEBucSwZlm+l9jJ60S25ec5rNpusvQ2+Lp1ED5ZiFX1okcOez7
 umpLLhLJOkoxGEsqibsf2doA6c3mCi12/a0l3juIPvVauZ6QE5AjUMo93E0N1WLJtU0En+1ii
 E4JZk4dYQDNQnVxVXT5X3diEyZGnio449doCYxYEc1dndwC54UCwnfqr6fAhztM3qDXeX9lQw
 XNZDm84DvHjKJ4vhtZ+v2oqkb/D7EiBrOrVhf/RDx/aF5YzMVpPkpCxSdPFylSiKp+4jtAy8w
 dwkvbDB7KzYo1VDvvZcFNHdSBlM7EAInmh0DjCGseoy1P6PXI46tutLiJSTwBQb53rnzRL8gV
 TZPoRP3JA6qDHJnQxoupaTxwVzVFcSkp3vim+Ym00DjZkXNR4C/uBOakC7gXidL5a4K5ucGdi
 MQfw9OZ7i10M0kqO3UNGy5AniyKdJ0VsbJTufIT1nhmaPmhgKpIj7j7Usqz3v+04O1zyO49PN
 CWRdsKozWDblBlYvcChRKA59NV4TSTaGO/KBgqVEARcMq7qvPZFjGataGM33N+tyZSXCZaEw5
 WcH9U44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.06.2018 um 16:12 schrieb git@jeffhostetler.com:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Add a series of jw_ routines and "struct json_writer" structure to compose
> JSON data.  The resulting string data can then be output by commands wanting
> to support a JSON output format.
> 
> The json-writer routines can be used to generate structured data in a
> JSON-like format.  We say "JSON-like" because we do not enforce the Unicode
> (usually UTF-8) requirement on string fields.  Internally, Git does not
> necessarily have Unicode/UTF-8 data for most fields, so it is currently
> unclear the best way to enforce that requirement.  For example, on Linx
> pathnames can contain arbitrary 8-bit character data, so a command like
> "status" would not know how to encode the reported pathnames.  We may want
> to revisit this (or double encode such strings) in the future.
> 
> The initial use for the json-writer routines is for generating telemetry
> data for executed Git commands.  Later, we may want to use them in other
> commands, such as status.
> 
> Helped-by: René Scharfe <l.s.r@web.de>
> Helped-by: Wink Saville <wink@saville.com>
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
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
> 
> diff --git a/Makefile b/Makefile
> index a1d8775..4ae6946 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -666,6 +666,7 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
>  TEST_PROGRAMS_NEED_X += test-genrandom
>  TEST_PROGRAMS_NEED_X += test-hashmap
>  TEST_PROGRAMS_NEED_X += test-index-version
> +TEST_PROGRAMS_NEED_X += test-json-writer>  TEST_PROGRAMS_NEED_X += test-lazy-init-name-hash
>  TEST_PROGRAMS_NEED_X += test-line-buffer
>  TEST_PROGRAMS_NEED_X += test-match-trees

This doesn't apply cleanly on master, because most test helpers have
been combined into a single binary to reduce their disk footprint and
link times.  See efd71f8913 (t/helper: add an empty test-tool program)
for the overall rationale.

test-json-writer could become a built-in as well, I think.  You can see
e.g. in c932a5ff28 (t/helper: merge test-string-list into test-tool)
what needs to be done to convert a helper.

René
