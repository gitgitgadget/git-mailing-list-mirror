Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB793201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 17:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764930AbdKRRrZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 12:47:25 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45120 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759251AbdKRRrX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 12:47:23 -0500
Received: by mail-pf0-f195.google.com with SMTP id 17so4224532pfn.12
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 09:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i7U/wBqJABCtCRRXuNxtDtG9yNNkA30cJ/3Eehs7VAs=;
        b=VN/iWK/t8L2TOXhtvuf7BmXCIzBGkKE1c9sQTArXMNUehvN4EzRrb6EdL9K8l02i+c
         wC2UnknWuoRzwvMVfc4hrGwtCQhJn9FyOXklAYdweHxNQ+vLNvzwkGwzowLuxoo7bokH
         3gDDXqTYc0ju5MNJqeo4q2MO2s0F48tWqcPOoUdVAebok6Zh7xFVsJNp3n1/W+0L84E5
         plZyaj+fu2hCpekjV5NYahWcCq4IZoBsIEFdwhjGT1xDwvmBd/wh40pz4E+YnGURuqKq
         N9qBP0h6wbdUOPkLPm+3L6fJtM7mczUhpMnPSrkaPWZrDvI9UKkxKqS812h35mOKKd1n
         LTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i7U/wBqJABCtCRRXuNxtDtG9yNNkA30cJ/3Eehs7VAs=;
        b=E8wTnfDsQi9NtEYUAoLzdr7/jxsXUTF57Pib6+Izlp//Y5QcdPhIx0UI+x40qx2IMt
         9o1+/1MHt7iOpKHjiroP3jVvkVX+vvGp1K/Gd5T2Xca6M+u5C27SaJcAVJrZP7/U6KTd
         GcTZkG1PbL9wPlUwgSHeDsZGz3wF7QTVd0owT38633jY9a8X30oNRbDrAM9IlSEBu0uh
         h6qnNVLjRpk+2yc/obFkWM8+fm4kUpzdVKYw8eAHvRrtxCVLJQCsdKYVtor97WVI7ZdJ
         BBxOfxHVbxiQ5KHeXypyZDcxWXmVrV6Bsi3sBOAXyEC11x/x0Oj3xRpV3M8N4GS3XU4R
         BKww==
X-Gm-Message-State: AJaThX7JpTZAyVVOYzlWN+S95ydcFmtuton5HVqLOpfj3VZlyN37XXX8
        HcGa8OvJJUvo8r3+UfvGMJRND0fB
X-Google-Smtp-Source: AGs4zMZCqcaOO3c5SMGkDjSMRtgrMAaPtMsXbUCkZE93cfb5QFcTPmOIHC0zpU9o5XPxAXDGGxC0tw==
X-Received: by 10.84.196.36 with SMTP id k33mr9111929pld.236.1511027242812;
        Sat, 18 Nov 2017 09:47:22 -0800 (PST)
Received: from ?IPv6:2405:204:72c0:fc36:f2a4:a5ab:70fc:f807? ([2405:204:72c0:fc36:f2a4:a5ab:70fc:f807])
        by smtp.gmail.com with ESMTPSA id l191sm15936242pfc.180.2017.11.18.09.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Nov 2017 09:47:21 -0800 (PST)
Subject: Re: [PATCH] launch_editor(): indicate that Git waits for user input
To:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>
References: <274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com>
 <xmqqr2syvjxb.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <26256555-4463-7bc9-5d07-8617932cf6cb@gmail.com>
Date:   Sat, 18 Nov 2017 23:17:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqr2syvjxb.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 16 November 2017 11:34 AM, Junio C Hamano wrote:
> 
>   * I tried this with "emacsclient" but it turns out that Emacs folks
>     have already thought about this issue, and the program says
>     "Waiting for Emacs..." while it does its thing, so from that
>     point of view, perhaps as Stefan said originally, the editor Lars
>     had trouble with is what is at fault and needs fixing?  I dunno.
> 
>     Also, emacsclient seems to conclude its message, once the editing
>     is done, by emitting LF _before_ we have a chance to do the "go
>     back to the beginning and clear" dance, so it probably is not a
>     very good example to emulate the situation Lars had trouble with.
>     You cannot observe the nuking of the "launched, waiting..." with
>     it.
>

I tried this patch with 'gedit' and it seems to work fine except for one 
particular case. When the launched editor gets killed somehow when 
waiting for user input, the error message shown in the terminal seems to 
be following the "Launched editor..." message immediately, making it 
hard to identify it.

$ GIT_EDITOR=gedit ./git commit --allow-empty
Launched your editor, waiting...error: gedit died of signal 15
error: There was a problem with the editor 'gedit'.
Please supply the message using either -m or -F option.

Though this is not something that's going to happen very often, I'm not 
sure if this is to be considered. Just wanted to note what I observed.


>   editor.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/editor.c b/editor.c
> index 7519edecdc..1321944716 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -40,6 +40,28 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
>   		const char *args[] = { editor, real_path(path), NULL };
>   		struct child_process p = CHILD_PROCESS_INIT;
>   		int ret, sig;
> +		static const char *close_notice = NULL;

Just a little curious, what's the advantage of making 'close_notice' 
'static' over 'auto' ?


> +
> +		if (isatty(2) && !close_notice) {
> +			char *term = getenv("TERM");
> +
> +			if (term && strcmp(term, "dumb"))
> +				/*
> +				 * go back to the beginning and erase the
> +				 * entire line if the terminal is capable
> +				 * to do so, to avoid wasting the vertical
> +				 * space.
> +				 */
> +				close_notice = "\r\033[K";
> +			else
> +				/* otherwise, complete and waste the line */
> +				close_notice = "done.\n";
> +		}
> +
> +		if (close_notice) {
> +			fprintf(stderr, "Launched your editor, waiting...");
> +			fflush(stderr);

Being curious again, is flushing 'stderr' required ? AFAIK, 'stderr' is 
unbuffered by default and I didn't notice any calls that changed the 
buffering mode of it along this code path.


> +		}
>   
>   		p.argv = args;
>   		p.env = env;
> @@ -53,11 +75,14 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
>   		sig = ret - 128;
>   		sigchain_pop(SIGINT);
>   		sigchain_pop(SIGQUIT);
> +
>   		if (sig == SIGINT || sig == SIGQUIT)
>   			raise(sig);
>   		if (ret)
>   			return error("There was a problem with the editor '%s'.",
>   					editor);
> +		if (close_notice)
> +			fputs(close_notice, stderr);
>   	}
>   
>   	if (!buffer)
> 

