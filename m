Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E1BD201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 17:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbdB1RHT (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 12:07:19 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:61711 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751332AbdB1RHR (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Feb 2017 12:07:17 -0500
X-AuditID: 12074414-7efff70000002bfd-20-58b5ae0d6477
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 96.D7.11261.D0EA5B85; Tue, 28 Feb 2017 12:06:21 -0500 (EST)
Received: from [192.168.69.190] (p5B10410E.dip0.t-ipconnect.de [91.16.65.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1SH6Hrj014143
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 28 Feb 2017 12:06:19 -0500
Subject: Re: [PATCH v5 04/24] files-backend: convert git_path() to
 strbuf_git_path()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-5-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <9074fcd9-2b80-8927-19d2-1659eb0e327c@alum.mit.edu>
Date:   Tue, 28 Feb 2017 18:06:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170222140450.30886-5-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1OVdtzXCYOU7bYuuK91MFg29V5gt
        +pd3sVksefia2aJ7yltGi5lXrS02b25ncWD32DnrLrvHh49xHgs2lXp0tR9h87h4Sdlj/9Jt
        bB6fN8kFsEdx2aSk5mSWpRbp2yVwZdy538desFS54sztdcwNjFNluxg5OSQETCTOLPnL1MXI
        xSEksINJ4vOfY6wQzlkmif8PbjCDVAkLhElcWNLLCmKLCKRJLJ78nhmiqJ9RYsvfE2AdzAI3
        GCUuTfzIBFLFJqArsainGcjm4OAVsJf4Pt8VJMwioCrx+eFLRhBbVCBEYs7CB2A2r4CgxMmZ
        T1hAbE4Bc4lZp/azg9jMAuoSf+ZdYoaw5SWat85mnsDIPwtJyywkZbOQlC1gZF7FKJeYU5qr
        m5uYmVOcmqxbnJyYl5dapGuhl5tZopeaUrqJERLuIjsYj5yUO8QowMGoxMOb0bk1Qog1say4
        MvcQoyQHk5Iob9AMoBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3h3FQDnelMTKqtSifJiUNAeL
        kjjvt8XqfkIC6YklqdmpqQWpRTBZGQ4OJQneCWuAGgWLUtNTK9Iyc0oQ0kwcnCDDeYCGbwGp
        4S0uSMwtzkyHyJ9iVJQS510IkhAASWSU5sH1wtLRK0ZxoFeEeX3WAlXxAFMZXPcroMFMQINf
        qIANLklESEk1MM5l//zl42vB6XeuncuSEF54OJY1kCvbukFE9aDxfS9VrcZWz4RCwWdZ/uKb
        3KcHs79qeHz2d1I5w++ljIndT8rUQ2dXVgWEKB7Q81T891C8YIWNVnChd9R5RQ3WkvhC03xR
        yZommWf/p0y2uWVn+KHurJbDdY6UmUYNIpYn5u41yTrPb7RJiaU4I9FQi7moOBEAE8VYGCID
        AAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22/2017 03:04 PM, Nguyễn Thái Ngọc Duy wrote:
> git_path() and friends are going to be killed in files-backend.c in near
> future. And because there's a risk with overwriting buffer in
> git_path(), let's convert them all to strbuf_git_path(). We'll have
> easier time killing/converting strbuf_git_path() then because we won't
> have to worry about memory management again.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs/files-backend.c | 139 +++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 106 insertions(+), 33 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 4676525de..435db1293 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> [...]
> @@ -2586,9 +2603,15 @@ static int files_rename_ref(struct ref_store *ref_store,
>  	int flag = 0, logmoved = 0;
>  	struct ref_lock *lock;
>  	struct stat loginfo;
> -	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
> +	struct strbuf sb_oldref = STRBUF_INIT;
> +	struct strbuf sb_newref = STRBUF_INIT;
> +	struct strbuf tmp_renamed_log = STRBUF_INIT;
> +	int log, ret;
>  	struct strbuf err = STRBUF_INIT;
>  
> +	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
> +	log = !lstat(sb_oldref.buf, &loginfo);
> +	strbuf_release(&sb_oldref);
>  	if (log && S_ISLNK(loginfo.st_mode))
>  		return error("reflog for %s is a symlink", oldrefname);
>  
> @@ -2602,7 +2625,12 @@ static int files_rename_ref(struct ref_store *ref_store,
>  	if (!rename_ref_available(oldrefname, newrefname))
>  		return 1;
>  
> -	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
> +	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
> +	strbuf_git_path(&tmp_renamed_log, TMP_RENAMED_LOG);
> +	ret = log && rename(sb_oldref.buf, tmp_renamed_log.buf);
> +	strbuf_release(&sb_oldref);
> +	strbuf_release(&tmp_renamed_log);
> +	if (ret)
>  		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
>  			oldrefname, strerror(errno));
>  
> @@ -2681,13 +2709,19 @@ static int files_rename_ref(struct ref_store *ref_store,
>  	log_all_ref_updates = flag;
>  
>   rollbacklog:
> -	if (logmoved && rename(git_path("logs/%s", newrefname), git_path("logs/%s", oldrefname)))
> +	strbuf_git_path(&sb_newref, "logs/%s", newrefname);
> +	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
> +	if (logmoved && rename(sb_newref.buf, sb_oldref.buf))
>  		error("unable to restore logfile %s from %s: %s",
>  			oldrefname, newrefname, strerror(errno));
> +	strbuf_git_path(&tmp_renamed_log, TMP_RENAMED_LOG);
>  	if (!logmoved && log &&
> -	    rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", oldrefname)))
> +	    rename(tmp_renamed_log.buf, sb_oldref.buf))
>  		error("unable to restore logfile %s from "TMP_RENAMED_LOG": %s",
>  			oldrefname, strerror(errno));

It feels like you're writing, releasing, re-writing these strbufs more
than necessary. Maybe it would be clearer to set them once, and on
errors set `ret = error()` then jump to a label here...

> +	strbuf_release(&sb_newref);
> +	strbuf_release(&sb_oldref);
> +	strbuf_release(&tmp_renamed_log);
>  

...and change this to `return ret`?

>  	return 1;
>  }
> [...]
> @@ -4108,18 +4171,28 @@ static int files_reflog_expire(struct ref_store *ref_store,
>  
>  static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
>  {
> +	struct strbuf sb = STRBUF_INIT;
> +
>  	/* Check validity (but we don't need the result): */
>  	files_downcast(ref_store, 0, "init_db");
>  
>  	/*
>  	 * Create .git/refs/{heads,tags}
>  	 */
> -	safe_create_dir(git_path("refs/heads"), 1);
> -	safe_create_dir(git_path("refs/tags"), 1);
> +	strbuf_git_path(&sb, "refs/heads");
> +	safe_create_dir(sb.buf, 1);
> +	strbuf_reset(&sb);
> +	strbuf_git_path(&sb, "refs/tags");
> +	safe_create_dir(sb.buf, 1);
> +	strbuf_reset(&sb);
>  	if (get_shared_repository()) {
> -		adjust_shared_perm(git_path("refs/heads"));
> -		adjust_shared_perm(git_path("refs/tags"));
> +		strbuf_git_path(&sb, "refs/heads");
> +		adjust_shared_perm(sb.buf);
> +		strbuf_reset(&sb);
> +		strbuf_git_path(&sb, "refs/tags");
> +		adjust_shared_perm(sb.buf);
>  	}
> +	strbuf_release(&sb);
>  	return 0;
>  }

It looks to me like `safe_create_dir()` already has the ability to
`adjust_shared_perm()`, or am I missing something? (I realize that this
is preexisting code.)

Michael

