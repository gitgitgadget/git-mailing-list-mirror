Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52E70201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 17:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbdB1Rls (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 12:41:48 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:44811 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751334AbdB1Rl3 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Feb 2017 12:41:29 -0500
X-AuditID: 1207440c-abdff70000002e8f-f2-58b5b63e76ce
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 9E.71.11919.E36B5B85; Tue, 28 Feb 2017 12:41:18 -0500 (EST)
Received: from [192.168.69.190] (p5B10410E.dip0.t-ipconnect.de [91.16.65.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1SHfFHk016001
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 28 Feb 2017 12:41:16 -0500
Subject: Re: [PATCH v5 07/24] files-backend: add and use files_refname_path()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-8-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <beef528b-66cd-e104-4c02-b07ddfa7e6d7@alum.mit.edu>
Date:   Tue, 28 Feb 2017 18:41:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170222140450.30886-8-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1LXbtjXC4MMrFYuuK91MFg29V5gt
        +pd3sVksefia2aJ7yltGi5lXrS02b25ncWD32DnrLrvHh49xHgs2lXp0tR9h87h4Sdlj/9Jt
        bB6fN8kFsEdx2aSk5mSWpRbp2yVwZbT1tTEWXBWomLXyA2sD41beLkZODgkBE4lPT2azdzFy
        cQgJ7GCSOL9pISOEc5ZJ4su+BawgVcICvhJ3+o6xgNgiAmkSiye/ZwaxhQT6GSXOzkgEaWAW
        uMEocWniRyaQBJuArsSinmYwm1fAXuLxhYdgzSwCqhInZ64Es0UFQiTmLHzACFEjCBR/Ahbn
        FDCXuDKjFSzOLKAu8WfeJWYIW16ieets5gmM/LOQtMxCUjYLSdkCRuZVjHKJOaW5urmJmTnF
        qcm6xcmJeXmpRbqGermZJXqpKaWbGCHhzrOD8ds6mUOMAhyMSjy8GZ1bI4RYE8uKK3MPMUpy
        MCmJ8gbNAArxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4d1RDJTjTUmsrEotyodJSXOwKInzqi5R
        9xMSSE8sSc1OTS1ILYLJynBwKEnwVm0BahQsSk1PrUjLzClBSDNxcIIM5wEa/nczyPDigsTc
        4sx0iPwpRkUpcd4JIAkBkERGaR5cLywdvWIUB3pFmFceZAUPMJXBdb8CGswENPiFCtjgkkSE
        lFQDo4f3l8nxWYnyO7q9oy1fNl7oNy71YtF1yX91ruuOQu+jsJj6WeJs/7Rr9HMaUwtmS3kr
        OTlErbvsxHD67LmTPX1dRhb51/Z7lOziKVJJ2v54Q2JS8/IWh/ez3W4dVGl3Mt3CLFIv23fy
        eKyb8YRdK9JmXnmsniG+8/8Hk4IjzoWlJ8X2cG1QYinOSDTUYi4qTgQAQTk54CIDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22/2017 03:04 PM, Nguyễn Thái Ngọc Duy wrote:
> Keep repo-related path handling in one place. This will make it easier
> to add submodule/multiworktree support later.
> 
> This automatically adds the "if submodule then use the submodule version
> of git_path" to other call sites too. But it does not mean those
> operations are sumodule-ready. Not yet.

s/sumodule/submodule/

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs/files-backend.c | 45 +++++++++++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 7b4ea4c56..72f4e1746 100644
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

Maybe it's just me, but I find it odd to exit early here when the first
exit isn't due to an error. For me, structuring this like `if ()
call1(); else call2();` would make it clearer that the two code paths
are equally-valid alternatives, and either one or the other will be
executed.

I had the same feeling when I read `files_reflog_path()`

>  /*
>   * Get the packed_ref_cache for the specified files_ref_store,
>   * creating it if necessary.
> @@ -1251,10 +1263,7 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
>  	size_t path_baselen;
>  	int err = 0;
>  
> -	if (refs->submodule)
> -		err = strbuf_git_path_submodule(&path, refs->submodule, "%s", dirname);
> -	else
> -		strbuf_git_path(&path, "%s", dirname);
> +	files_refname_path(refs, &path, dirname);

It's so nice to see these ugly `if (refs->submodule)` code blocks
disappearing!

> [...]

Michael

