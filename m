Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EC62201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 17:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbdB1Rwj (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 12:52:39 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:53529 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751248AbdB1Rwe (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Feb 2017 12:52:34 -0500
X-AuditID: 12074413-f67ff700000077e1-28-58b5b8bf5b8d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id D5.58.30689.FB8B5B85; Tue, 28 Feb 2017 12:51:59 -0500 (EST)
Received: from [192.168.69.190] (p5B10410E.dip0.t-ipconnect.de [91.16.65.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1SHpuTu016667
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 28 Feb 2017 12:51:58 -0500
Subject: Re: [PATCH v5 09/24] refs.c: introduce get_main_ref_store()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-10-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <0bef1e49-e96b-1666-9b88-f4262c2aeeba@alum.mit.edu>
Date:   Tue, 28 Feb 2017 18:51:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170222140450.30886-10-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqLt/x9YIg1urNSy6rnQzWTT0XmG2
        6F/exWax5OFrZovuKW8ZLWZetbbYvLmdxYHdY+esu+weHz7GeSzYVOrR1X6EzePiJWWP/Uu3
        sXl83iQXwB7FZZOSmpNZllqkb5fAlTHnyHzWgoOsFefO9jA1MK5l6WLk5JAQMJFY8/APkM3F
        ISSwg0li9qa9UM5ZJonfW24wg1QJC7hIfH72E6xDRCBNYvHk98wQRRMYJX7+P8AG4jAL3GCU
        uDTxIxNIFZuArsSinmYwm1fAXuL9j6OsIDaLgKrEhN/3wCaJCoRIzFn4gBGiRlDi5MwnYHFO
        AQuJqVefgMWZBdQl/sy7xAxhy0s0b53NPIGRfxaSlllIymYhKVvAyLyKUS4xpzRXNzcxM6c4
        NVm3ODkxLy+1SNdcLzezRC81pXQTIyTghXcw7jopd4hRgINRiYf3QPfWCCHWxLLiytxDjJIc
        TEqivEEzgEJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeHcUA+V4UxIrq1KL8mFS0hwsSuK8akvU
        /YQE0hNLUrNTUwtSi2CyMhwcShK8W7YDNQoWpaanVqRl5pQgpJk4OEGG8wAN3wNSw1tckJhb
        nJkOkT/FqMtx4/iBN0xCLHn5ealS4rwbQYoEQIoySvPg5sAS1StGcaC3hHkVgGlLiAeY5OAm
        vQJawgS05IUK2JKSRISUVAOj9nPZtsMHGS9/+ltdclbp7oopvRvmME242fXkzTXNraetrrde
        zruRfiexSXGVQsQZxec2Gzy1RBZIcF+SVak/ImslOU/e8V6jR2CdkGgI477avw8OLI3hEJr7
        X9rzZPDBdWYP6wqULzF8kzbZo+i67/TMGX8/NBYpzHJ+8v2y0TteThs+GYUvSizFGYmGWsxF
        xYkAOo0NvC8DAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22/2017 03:04 PM, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 81b64b4ed..dab1a21ac 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1456,15 +1456,23 @@ static struct ref_store *ref_store_init(const char *submodule)
>  	return refs;
>  }
>  
> +static struct ref_store *get_main_ref_store(void)
> +{
> +	struct ref_store *refs;
> +
> +	if (main_ref_store)
> +		return main_ref_store;
> +
> +	refs = ref_store_init(NULL);
> +	return refs;

Unnecessary temporary variable?

> [...]

Michael


