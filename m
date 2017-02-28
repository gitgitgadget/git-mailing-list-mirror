Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43B88201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 18:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbdB1SWd (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 13:22:33 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:62333 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751435AbdB1SUa (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Feb 2017 13:20:30 -0500
X-AuditID: 12074414-7efff70000002bfd-1e-58b5be1c12c7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 13.1B.11261.C1EB5B85; Tue, 28 Feb 2017 13:14:52 -0500 (EST)
Received: from [192.168.69.190] (p5B10410E.dip0.t-ipconnect.de [91.16.65.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1SIEm29017945
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 28 Feb 2017 13:14:50 -0500
Subject: Re: [PATCH v5 14/24] path.c: move some code out of
 strbuf_git_path_submodule()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-15-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <72093fc6-806e-506e-5c75-206f864c365e@alum.mit.edu>
Date:   Tue, 28 Feb 2017 19:14:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170222140450.30886-15-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1JXZtzXCoOegpEXXlW4mi4beK8wW
        /cu72CyWPHzNbNE95S2jxcyr1habN7ezOLB77Jx1l93jw8c4jwWbSj262o+weVy8pOyxf+k2
        No/Pm+QC2KO4bFJSczLLUov07RK4Mj48m8ZUcFe+Ysrt80wNjDsluxg5OSQETCTmTPrLAmIL
        CexgkvjaXNDFyAVkn2WSWHT5EztIQlggUqJ3fhcriC0ikCaxePJ7ZoiiCYwS/49+YQRxmAVu
        MEpcmviRCaSKTUBXYlFPM5jNK2AvMWXqZzYQm0VAVWLF6t/MILaoQIjEnIUPGCFqBCVOznwC
        dgangIXEz6b7YHFmAXWJP/MuMUPY8hLNW2czT2Dkn4WkZRaSsllIyhYwMq9ilEvMKc3VzU3M
        zClOTdYtTk7My0st0rXQy80s0UtNKd3ECAl3kR2MR07KHWIU4GBU4uHN6NwaIcSaWFZcmXuI
        UZKDSUmUN2gGUIgvKT+lMiOxOCO+qDQntfgQowQHs5II745ioBxvSmJlVWpRPkxKmoNFSZz3
        22J1PyGB9MSS1OzU1ILUIpisDAeHkgTv0z1AjYJFqempFWmZOSUIaSYOTpDhPEDDN4DU8BYX
        JOYWZ6ZD5E8xKkqJ84aDJARAEhmleXC9sHT0ilEc6BVhXtG9QFU8wFQG1/0KaDAT0OAXKmCD
        SxIRUlINjLETVp55fu7Sr40bNWwCZH/FP511Z9/T6G3b/otW8m26V3PA82HD4UAmHW/Gwz9v
        GV3Zn1qzpttO9Vzgm6iHEfIXDk55XnHy70fzlytqamRYLgXdePXAbLcYT8XiDyoSYbK7gqd3
        qLgWtfupx7YsnPzkPHs3yw+1vDL5r2LvEvUajkzZkPa2rF2JpTgj0VCLuag4EQDu/AvwIgMA
        AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22/2017 03:04 PM, Nguyễn Thái Ngọc Duy wrote:
> refs is learning to avoid path rewriting that is done by
> strbuf_git_path_submodule(). Factor out this code so it could be reused
> by refs*
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  path.c      | 34 +++++++---------------------------
>  submodule.c | 31 +++++++++++++++++++++++++++++++
>  submodule.h |  1 +
>  3 files changed, 39 insertions(+), 27 deletions(-)
> 
> diff --git a/path.c b/path.c
> index efcedafba..3451d2916 100644
> --- a/path.c
> +++ b/path.c
> @@ -475,35 +475,16 @@ const char *worktree_git_path(const struct worktree *wt, const char *fmt, ...)
>  static int do_submodule_path(struct strbuf *buf, const char *path,
>  			     const char *fmt, va_list args)
>  {
> -	const char *git_dir;
>  	struct strbuf git_submodule_common_dir = STRBUF_INIT;
>  	struct strbuf git_submodule_dir = STRBUF_INIT;
> -	const struct submodule *sub;
> -	int err = 0;
> +	int ret;
>  
> -	strbuf_addstr(buf, path);
> -	strbuf_complete(buf, '/');
> -	strbuf_addstr(buf, ".git");
> -
> -	git_dir = read_gitfile(buf->buf);
> -	if (git_dir) {
> -		strbuf_reset(buf);
> -		strbuf_addstr(buf, git_dir);
> -	}
> -	if (!is_git_directory(buf->buf)) {
> -		gitmodules_config();
> -		sub = submodule_from_path(null_sha1, path);
> -		if (!sub) {
> -			err = SUBMODULE_PATH_ERR_NOT_CONFIGURED;

I didn't read this patch too carefully, but where the old code used the
constant `SUBMODULE_PATH_ERR_NOT_CONFIGURED`, the new code returns -1.
In fact, now the constant is totally unused. It looks like there's some
more cleanup that could happen.

> -			goto cleanup;
> -		}
> -		strbuf_reset(buf);
> -		strbuf_git_path(buf, "%s/%s", "modules", sub->name);
> -	}
> -
> -	strbuf_addch(buf, '/');
> -	strbuf_addbuf(&git_submodule_dir, buf);
> +	ret = submodule_to_gitdir(&git_submodule_dir, path);
> +	if (ret)
> +		goto cleanup;
>  
> +	strbuf_complete(&git_submodule_dir, '/');
> +	strbuf_addbuf(buf, &git_submodule_dir);
>  	strbuf_vaddf(buf, fmt, args);
>  
>  	if (get_common_dir_noenv(&git_submodule_common_dir, git_submodule_dir.buf))
> @@ -514,8 +495,7 @@ static int do_submodule_path(struct strbuf *buf, const char *path,
>  cleanup:
>  	strbuf_release(&git_submodule_dir);
>  	strbuf_release(&git_submodule_common_dir);
> -
> -	return err;
> +	return ret;
>  }
>  
>  char *git_pathdup_submodule(const char *path, const char *fmt, ...)
> diff --git a/submodule.c b/submodule.c
> index 3b98766a6..36b8d1d11 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1514,3 +1514,34 @@ void absorb_git_dir_into_superproject(const char *prefix,
>  		strbuf_release(&sb);
>  	}
>  }
> +
> +int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
> +{
> +	const struct submodule *sub;
> +	const char *git_dir;
> +	int ret = 0;
> +
> +	strbuf_reset(buf);
> +	strbuf_addstr(buf, submodule);
> +	strbuf_complete(buf, '/');
> +	strbuf_addstr(buf, ".git");
> +
> +	git_dir = read_gitfile(buf->buf);
> +	if (git_dir) {
> +		strbuf_reset(buf);
> +		strbuf_addstr(buf, git_dir);
> +	}
> +	if (!is_git_directory(buf->buf)) {
> +		gitmodules_config();
> +		sub = submodule_from_path(null_sha1, submodule);
> +		if (!sub) {
> +			ret = -1;
> +			goto cleanup;
> +		}
> +		strbuf_reset(buf);
> +		strbuf_git_path(buf, "%s/%s", "modules", sub->name);
> +	}
> +
> +cleanup:
> +	return ret;
> +}
> diff --git a/submodule.h b/submodule.h
> index 05ab674f0..fc3d0303e 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -81,6 +81,7 @@ extern int push_unpushed_submodules(struct sha1_array *commits,
>  				    int dry_run);
>  extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
>  extern int parallel_submodules(void);
> +int submodule_to_gitdir(struct strbuf *buf, const char *submodule);

A docstring is always nice :-)

>  
>  /*
>   * Prepare the "env_array" parameter of a "struct child_process" for executing
> 

Michael

