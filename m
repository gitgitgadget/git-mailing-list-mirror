Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E8EA20756
	for <e@80x24.org>; Fri, 13 Jan 2017 18:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbdAMSdO (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 13:33:14 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33949 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbdAMSdM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 13:33:12 -0500
Received: by mail-pf0-f178.google.com with SMTP id 127so34473447pfg.1
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 10:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XTECVHbwwMIoZOeYM6y3QUfzsXE+278eJH9QceeFV1w=;
        b=gPD8QvqyKuoXNTNzNCh2Q1jc69XyCv0niKwOPs1s8GucvlmVE/4LERvXcnPv+B67MJ
         sJQAKtMs6i5uls2aep/vtW53/HAFbfuHejUIdyd3QUSQQWHyt9CIERXyzeelSZG0aetX
         vFYEjJsW6lo2UHtJWFcFGDHS4z0LR8rmUTTVv0XQm0l0+AbCYx4qyunuSAxeVh6C0zyU
         HDA9a5uFlkRPB2yuu5vI0QIJ9wB2vtC0fUIBIUWxQz547tnpmypZIf3uICCdg4p3vQLy
         NqZerpgAksKgYLobFG2U/5Gkx7t/Zij81aispWF6LrUxQ0dT+tUfHZbjBNG5f9ltiZZS
         imRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XTECVHbwwMIoZOeYM6y3QUfzsXE+278eJH9QceeFV1w=;
        b=fi9MFlab25jabfKWJc/kTOxeNmQCyon4AaRr2N05UuYhw4FVxKvbWzr+sT1y4tA3Kx
         8Rx4nPNiiDXyPsVx/14u62kSfYtVDOGYJ0JkhhaQ6BuUwFVcIfhZ0vQzqVBT6fFJlAz9
         jcOY609isR+oWt4kASMTFN9DfFVBGepHWQRgTHgWXTfbxhGnXTm9LeMmelxQxFQvA4FI
         lNHD7hy1E31LMr4u6j6D14/MLo120TwQ2iREoPcFe+phswUc/VFAEMk/lr1e/Op0Hbn3
         BT32jy6oga4pWGznd37bWJxve4O9/s7NHIqbQoEterGDPViBWDRqpx1gCo2K1elia2Wi
         3GJg==
X-Gm-Message-State: AIkVDXIusB76kqX7kNGx+0ryTE2K/JQSaqPK/A6PEaqvknar80osIeno0KaTH3JOOXPZi4XY
X-Received: by 10.98.25.21 with SMTP id 21mr2763962pfz.46.1484332391636;
        Fri, 13 Jan 2017 10:33:11 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:7042:6105:e50f:988])
        by smtp.gmail.com with ESMTPSA id w11sm30815779pfk.75.2017.01.13.10.33.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 13 Jan 2017 10:33:10 -0800 (PST)
Date:   Fri, 13 Jan 2017 10:33:09 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCHv3 2/2] builtin/commit.c: switch to xstrfmt(), instead of
 snprintf,
Message-ID: <20170113183309.GA28002@google.com>
References: <20170113175801.39468-1-gitter.spiros@gmail.com>
 <20170113175801.39468-2-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170113175801.39468-2-gitter.spiros@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/13, Elia Pinto wrote:
> In this patch, instead of using xnprintf instead of snprintf, which asserts
> that we don't truncate, we are switching to dynamic allocation with  xstrfmt(),
> , so we can avoid dealing with magic numbers in the code and reduce the cognitive burden from
> the programmers, because they no longer have to count bytes needed for static allocation.
> As a side effect of this patch we have also reduced the snprintf() calls, that may silently truncate 
> results if the programmer is not careful.
> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Jeff King <peff@peff.net> 
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>

Small nit's with the commit message:
* Stray comma ',' of on its own
* lines are longer than 80 characters

> ---
> This is the third  version of the patch.
> 
> Changes from the first version: I have split the original commit in two, as discussed here
> http://public-inbox.org/git/20161213132717.42965-1-gitter.spiros@gmail.com/.
> 
> Changes from the second version:
> - Changed the commit message to clarify the purpose of the patch (
> as suggested by Junio)
> https://public-inbox.org/git/xmqqtw95mfo3.fsf@gitster.mtv.corp.google.com/T/#m2e6405a8a78a8ca1ed770614c91398290574c4a1
> 
> 
> 
>  builtin/commit.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 09bcc0f13..37228330c 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1526,12 +1526,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
>  static int run_rewrite_hook(const unsigned char *oldsha1,
>  			    const unsigned char *newsha1)
>  {
> -	/* oldsha1 SP newsha1 LF NUL */
> -	static char buf[2*40 + 3];
> +	char *buf;
>  	struct child_process proc = CHILD_PROCESS_INIT;
>  	const char *argv[3];
>  	int code;
> -	size_t n;
>  
>  	argv[0] = find_hook("post-rewrite");
>  	if (!argv[0])
> @@ -1547,11 +1545,11 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
>  	code = start_command(&proc);
>  	if (code)
>  		return code;
> -	n = snprintf(buf, sizeof(buf), "%s %s\n",
> -		     sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
> +	buf = xstrfmt("%s %s\n", sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
>  	sigchain_push(SIGPIPE, SIG_IGN);
> -	write_in_full(proc.in, buf, n);
> +	write_in_full(proc.in, buf, strlen(buf));
>  	close(proc.in);
> +	free(buf);
>  	sigchain_pop(SIGPIPE);
>  	return finish_command(&proc);
>  }
> -- 
> 2.11.0.154.g5f5f154
> 

-- 
Brandon Williams
