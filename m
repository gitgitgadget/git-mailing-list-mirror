Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE54B20286
	for <e@80x24.org>; Sat,  9 Sep 2017 06:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755286AbdIIGaX (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Sep 2017 02:30:23 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:48286 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755260AbdIIGaW (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Sep 2017 02:30:22 -0400
X-AuditID: 12074413-38bff70000007929-9f-59b38a7d64b6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 2E.15.31017.D7A83B95; Sat,  9 Sep 2017 02:30:21 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC859.dip0.t-ipconnect.de [87.188.200.89])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v896UJfw020319
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 9 Sep 2017 02:30:20 -0400
Subject: Re: [PATCH v4 12/16] files-backend: make reflog iterator go through
 per-worktree reflog
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
 <20170823123704.16518-13-pclouds@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <22ce3629-cd72-7fe0-8511-29b34e135122@alum.mit.edu>
Date:   Sat, 9 Sep 2017 08:30:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170823123704.16518-13-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42IRYndR1K3t2hxp0P9DzqLrSjeTRUPvFWaL
        7ilvGS02b25ncWDx2DnrLrvHgk2lHhcvKXt83iQXwBLFZZOSmpNZllqkb5fAlTH31wrWgqc8
        FXOOLWRrYFzK1cXIySEhYCLx+GcnexcjF4eQwA4mib/d7xghnHNMEkc/T2IFqRIWSJKYcPoj
        M4gtIpAmsXjyeyCbg4NZwEti3sdykLCQQIpEd08zWAmbgK7Eop5mJhCbV8BeouVPLwtIOYuA
        isTRrRYgYVGBCIm+t5fZIUoEJU7OfMICYnMKWEhs3LcEbCuzgLrEn3mXmCFscYlbT+YzQdjy
        Es1bZzNPYBSYhaR9FpKWWUhaZiFpWcDIsopRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11wvN7NE
        LzWldBMjJMCFdzDuOil3iFGAg1GJh7di+6ZIIdbEsuLK3EOMkhxMSqK8F2o3RwrxJeWnVGYk
        FmfEF5XmpBYfYpTgYFYS4Z3dCpTjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJ
        ynBwKEnwzuwEahQsSk1PrUjLzClBSDNxcIIM5wEartgFMry4IDG3ODMdIn+KUVFKnDcBpFkA
        JJFRmgfXC0tArxjFgV4R5q0BqeIBJi+47ldAg5mABpc83wAyuCQRISXVwLjVuilJXdHuY1bg
        //l9Z+vuvizg+bI5opY/2P2MT87LkiplmWdl/F9NpkzImLRuv5PIDecZTW92m5+eVjXjx3eb
        Exk3EhWYXSb9fXp1y90KzjOyZQcznk29UnfO/Lk5y7KlE9tdJWcEf1m5rUOlt1RtMesdgZad
        Ebvvznnn+8xlSkPL66B7Xf1KLMUZiYZazEXFiQCUHXTQGwMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/23/2017 02:37 PM, Nguyễn Thái Ngọc Duy wrote:
> refs/bisect is unfortunately per-worktree, so we need to look in
> per-worktree logs/refs/bisect in addition to per-repo logs/refs. The
> current iterator only goes through per-repo logs/refs.
> 
> Use merge iterator to walk two ref stores at the same time and pick
> per-worktree refs from the right iterator.
> 
> PS. Note the unsorted order of for_each_reflog in the test. This is
> supposed to be OK, for now. If we enforce order on for_each_reflog()
> then some more work will be required.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs/files-backend.c          | 59 +++++++++++++++++++++++++++++++++----------
>  t/t1407-worktree-ref-store.sh | 30 ++++++++++++++++++++++
>  2 files changed, 75 insertions(+), 14 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 5cca55510b..d4d22882ef 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> [...]
> +static enum iterator_selection reflog_iterator_select(
> +	struct ref_iterator *iter_worktree,
> +	struct ref_iterator *iter_common,
> +	void *cb_data)
> +{
> +	if (iter_worktree) {
> +		/*
> +		 * We're a bit loose here. We probably should ignore
> +		 * common refs if they are accidentally added as
> +		 * per-worktree refs.
> +		 */
> +		return ITER_SELECT_0;

I don't understand the point of the comment. If we should ignore common
refs here, why not do it rather than commenting about it? Wouldn't it be
really easy to implement? OTOH if it's not needed, then why the comment?

> [...]

Michael
