Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9E5820A17
	for <e@80x24.org>; Thu, 19 Jan 2017 19:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754413AbdASTDT (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 14:03:19 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35584 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754242AbdASTDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 14:03:16 -0500
Received: by mail-pg0-f54.google.com with SMTP id 194so16312207pgd.2
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 11:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VAnPNXQ0MGc03vjAt8CG6m3VZeBVJGuZMYbYGMWJy+s=;
        b=baO5wm+c3AT+k123XRkV0R0hdjNWo064FQEcbcKh/4kx1yZLyOtgF2LZwkQ5nuYDs7
         a+84+DR8NAv+vNthnZ9PXFX6D5Ta0/F/Paocbq+m5Jx+Qy/M75KWJoyT5FYHbta8w0xM
         oxspAhRF42qacwRJJipnI6bPI6g3Nrj7Ozrzr6AHw7XGv16PFa2/4lyrdUSgTjtnFjRO
         P3q0o0wcdygj+n7jn60QXUgJimoLNv7ewUoLTJUj+AsxaUc74uwR7ZR1pNdH5tp91qjq
         f47gngiF5rTbqOSgYecdzOEf2djPZZP5lASL44R8lWQ0KjaBJ8gRccxj8atft+9+kT4k
         0CqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VAnPNXQ0MGc03vjAt8CG6m3VZeBVJGuZMYbYGMWJy+s=;
        b=PYcafp3NO/68VA3iIqTUpZ3YKlw5+yCdXgbpd9qwmTddcRRgxZXo2NKn8iYKKISPAM
         FTVkIvdNeUR1pMWX//tkD+PypIYK97c9khe2XrPu88Rja6e9UzPfesGJyx+o7B0mKu2W
         84+QtwF/VlRQUEJAuCNZdu/rtCarvaIEx9m9Oiy11Rl+9sTIrVM7/cOHXf1VpFhhmtO0
         8uel0m8/NaK3UzZijwOX3J2J4ePBCkbH9FCD5siWIIKyzMsbErwgehIRx9NEsOtKipix
         iv8dOyJOTP0BEwjAeQYL7mfJC/kBlYNSTRXSG7c/wap/oOGQHbJJwGUyxJt1NdSv7YIi
         e0mQ==
X-Gm-Message-State: AIkVDXK8MzpUK0+HLJ/fW8hrgFYVsOWeEOGylejcIz+bxd0Gm3UIcdNe51UQNe0FbYfwz/Zx
X-Received: by 10.84.130.5 with SMTP id 5mr15052521plc.69.1484850576860;
        Thu, 19 Jan 2017 10:29:36 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:1d68:bc5d:3a1b:2ccb])
        by smtp.gmail.com with ESMTPSA id 89sm10564740pfo.40.2017.01.19.10.29.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 19 Jan 2017 10:29:35 -0800 (PST)
Date:   Thu, 19 Jan 2017 10:29:34 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC 2/2] grep: use '/' delimiter for paths
Message-ID: <20170119182934.GH10641@google.com>
References: <20170119150347.3484-1-stefanha@redhat.com>
 <20170119150347.3484-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170119150347.3484-3-stefanha@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/19, Stefan Hajnoczi wrote:
> If the tree contains a sub-directory then git-grep(1) output contains a
> colon character instead of a path separator:
> 
>   $ git grep malloc v2.9.3:t
>   v2.9.3:t:test-lib.sh:	setup_malloc_check () {
>   $ git show v2.9.3:t:test-lib.sh
>   fatal: Path 't:test-lib.sh' does not exist in 'v2.9.3'
> 
> This patch attempts to use the correct delimiter:
> 
>   $ git grep malloc v2.9.3:t
>   v2.9.3:t/test-lib.sh:	setup_malloc_check () {
>   $ git show v2.9.3:t/test-lib.sh
>   (success)
> 
> This patch does not cope with @{1979-02-26 18:30:00} syntax and treats
> it as a path because it contains colons.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  builtin/grep.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 3643d8a..06f8b47 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -493,7 +493,8 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
>  
>  			/* Add a delimiter if there isn't one already */
>  			if (name[len - 1] != '/' && name[len - 1] != ':') {
> -				strbuf_addch(&base, ':');
> +				/* rev: or rev:path/ */
> +				strbuf_addch(&base, strchr(name, ':') ? '/' : ':');

As Jeff mentioned it may be better to base which character gets appended
by checking the obj->type field like this maybe:

diff --git a/builtin/grep.c b/builtin/grep.c
index 69dab5dc5..9dfe11dc7 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -495,7 +495,8 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 			/* Add a delimiter if there isn't one already */
 			if (name[len - 1] != '/' && name[len - 1] != ':') {
 				/* rev: or rev:path/ */
-				strbuf_addch(&base, strchr(name, ':') ? '/' : ':');
+				char del = obj->type == OBJ_COMMIT ? ':' : '/';
+				strbuf_addch(&base, del);
 			}
 		}
 		init_tree_desc(&tree, data, size);

-- 
Brandon Williams
