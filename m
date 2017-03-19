Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9F1820323
	for <e@80x24.org>; Sun, 19 Mar 2017 20:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbdCSUdo (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 16:33:44 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:42486 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752313AbdCSUdn (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Mar 2017 16:33:43 -0400
X-AuditID: 1207440d-029ff70000003721-db-58ceeafa0e7f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 8D.A0.14113.AFAEEC85; Sun, 19 Mar 2017 16:32:58 -0400 (EDT)
Received: from [192.168.69.190] (p5B105D72.dip0.t-ipconnect.de [91.16.93.114])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2JKWsLX018004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 19 Mar 2017 16:32:56 -0400
Subject: Re: [PATCH v6 09/27] files-backend: add and use files_refname_path()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
 <20170318020337.22767-10-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <f90afe6c-534e-80ec-cb58-95bcb3172d86@alum.mit.edu>
Date:   Sun, 19 Mar 2017 21:32:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170318020337.22767-10-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqPvr1bkIg7cr5Cy6rnQzWTT0XmG2
        6F/exWax5OFrZovuKW8ZLWZetbbYvLmdxYHdY+esu+weHz7GeSzYVOrR1X6EzePiJWWP/Uu3
        sXl83iQXwB7FZZOSmpNZllqkb5fAlbHrbTtTwXORin9Nz1gbGK8JdDFyckgImEj8aGlm7WLk
        4hAS2MEk0dm3B8o5xySxbdMqNpAqYQFficONX8BsEYE0icWT3zNDFE1klGi9MhvMYRa4wShx
        aeJHJpAqNgFdiUU9zWA2r4C9xMmXM9hBbBYBVYmHi3aBxUUFQiTmLHzACFEjKHFy5hMWEJtT
        wAKkHmwbs4C6xJ95l5ghbHmJ5q2zmScw8s9C0jILSdksJGULGJlXMcol5pTm6uYmZuYUpybr
        Ficn5uWlFuka6eVmluilppRuYoQEPO8Oxv/rZA4xCnAwKvHw3rh0LkKINbGsuDL3EKMkB5OS
        KO8/daAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd4ND4FyvCmJlVWpRfkwKWkOFiVxXrUl6n5C
        AumJJanZqakFqUUwWRkODiUJ3qJnQI2CRanpqRVpmTklCGkmDk6Q4TxAw4OfgwwvLkjMLc5M
        h8ifYlSUEue98QIoIQCSyCjNg+uFJaRXjOJArwjzsoOs4AEmM7juV0CDmYAGL7txBmRwSSJC
        SqqBMSSBNTrIct3XjVL9td4enR1CzVOmPj328WOt65zdYioLhf/LWu59p5SR9Hru1y87RJJF
        JHp9J2s61Tsuuztp+g51rkLFiD2OJr5eWlci5nRWn7eLUbh37eXpHS3R79uZr5jaqP47nrGZ
        qT5ji6St5/m7Oo03ZihFnXfp1J+1d0byQzaDr0IKSizFGYmGWsxFxYkA/0ppiCMDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/18/2017 03:03 AM, Nguyễn Thái Ngọc Duy wrote:
> Keep repo-related path handling in one place. This will make it easier
> to add submodule/multiworktree support later.
> 
> This automatically adds the "if submodule then use the submodule version
> of git_path" to other call sites too. But it does not mean those
> operations are submodule-ready. Not yet.

Maybe `files_loose_ref_path()` would be a more descriptive name for the
new function. But I can live with it either way.

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs/files-backend.c | 47 +++++++++++++++++++++++------------------------
>  1 file changed, 23 insertions(+), 24 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 64d1ab3fe8..1a13fb5e2b 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1180,6 +1180,18 @@ static void files_reflog_path(struct files_ref_store *refs,
>  	strbuf_git_path(sb, "logs/%s", refname);
>  }
>  
> +static void files_refname_path(struct files_ref_store *refs,
> +			       struct strbuf *sb,
> +			       const char *refname)
> +{
> +	if (refs->submodule) {
> +		strbuf_git_path_submodule(sb, refs->submodule, "%s", refname);
> +		return;
> +	}
> +
> +	strbuf_git_path(sb, "%s", refname);
> +}
> +
>  /*
>   * Get the packed_ref_cache for the specified files_ref_store,
>   * creating it if necessary.
> @@ -1249,19 +1261,10 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
>  	struct strbuf refname;
>  	struct strbuf path = STRBUF_INIT;
>  	size_t path_baselen;
> -	int err = 0;
>  
> -	if (refs->submodule)
> -		err = strbuf_git_path_submodule(&path, refs->submodule, "%s", dirname);
> -	else
> -		strbuf_git_path(&path, "%s", dirname);
> +	files_refname_path(refs, &path, dirname);
>  	path_baselen = path.len;
>  
> -	if (err) {
> -		strbuf_release(&path);
> -		return;
> -	}
> -
>  	d = opendir(path.buf);
>  	if (!d) {
>  		strbuf_release(&path);

The old code in the hunk above went to the trouble of handling errors
from `strbuf_git_path_submodule()`, which I think can happen if the
submodule path doesn't actually point at a directory that looks like a
Git repository. Your new code doesn't handle such an error.

It seems clear that `read_loose_refs()` is to late a place to be dealing
with such errors, and indeed it seems like the check
`is_nonbare_repository_dir()` in `get_ref_store()` should make such
errors impossible, so I think your change is OK. If you agree, it might
be appropriate to mention that reasoning in the commit message.

> [...]

Michael

