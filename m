Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF0951F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 19:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755630AbdKNTzR (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 14:55:17 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:39666 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754867AbdKNTzP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 14:55:15 -0500
Received: by mail-it0-f66.google.com with SMTP id y15so15074443ita.4
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 11:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wWaZdFqi0AI2O1JI9B4SneZT2ajYv9NdtvKDItRT/K4=;
        b=o/1PuNXagwrWnTNHwbEBmYRNbaG3/2Qmy0EsSX7SjhFZ/TIA6kaEPLsJBK3NhbSyoe
         /YX0uxcw97hrhQGF4TtTGnN8dgTyLfwzcOVTStAHqZiaNdFoM1kwuIsgLTNq8bWuaocn
         +lMgZiYj03AaUOs+XZ9Anm+YL+GrMdWyA9mOOOX0F7PTuGBvkGM9jEmJ+TgT8oP5c/i0
         D0P3rYcv9H59rYJKMLXiP+AIABD5V1BJEaKE3WZnwAnHwGs8JI/XMf1hQIbs65VOnIQR
         AKVprvicXpbh8PpSeA4gtYq7NyajBSj0lOlSp8zGZLbcfplLdPZGSJh32UzASTlTpFHr
         +e3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWaZdFqi0AI2O1JI9B4SneZT2ajYv9NdtvKDItRT/K4=;
        b=I6d8ofDU47xX1nCIh6RDjN4eIfxyB8dCRZMYvLTC3AyX7XLMkZs1b7xvXjbC4wPUSJ
         IpbvbEkEK1XIV37FLjSQtuuroUlXU6Z4rfog6ise4/Y+bQcJqzPAcI+M52uTdD/GHUk0
         P5Io2TWAfUt2mE3JBXw+/nRr1MhBvsfkmzifc/L7HxwjZJjt50xk23yZoK+SoV7kOjAI
         rm/88s4wtQQes3Yl4AHL/u8WQuAs2LYCgoz5sUWMRvAVW5HF2UeTx1N3U7mdZ1SSfKPu
         votitzoaXkmJbwqbtGJMMc2OzzYIQrL4s2okS76br91pK1YFZgZFMpKPP5gmhSHgb0jN
         4y9A==
X-Gm-Message-State: AJaThX6k/bhWAJBoGZLlEEg3FdUyV502kBVZSwrw8Q3wQfpKXlhhClNP
        xquRxUf01BcDg8Fpnvpt7tCw4w==
X-Google-Smtp-Source: AGs4zMYTEjmpAn9bu81PWqROK6fEEkKhchieXHqhez41B7dglGDmEuYDDL+jSmaW892nxL3c8fSvqQ==
X-Received: by 10.36.28.200 with SMTP id c191mr15120616itc.93.1510689314277;
        Tue, 14 Nov 2017 11:55:14 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:9ca7:c33c:854a:a353])
        by smtp.gmail.com with ESMTPSA id p10sm8932727ioe.19.2017.11.14.11.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Nov 2017 11:55:13 -0800 (PST)
Date:   Tue, 14 Nov 2017 11:55:12 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info, schwab@linux-m68k.org
Subject: Re: [PATCHv3 5/7] builtin/describe.c: print debug statements
 earlier
Message-Id: <20171114115512.a3ba15c0325b1eefa2602984@google.com>
In-Reply-To: <20171102194148.2124-6-sbeller@google.com>
References: <20171031211852.13001-1-sbeller@google.com>
        <20171102194148.2124-1-sbeller@google.com>
        <20171102194148.2124-6-sbeller@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu,  2 Nov 2017 12:41:46 -0700
Stefan Beller <sbeller@google.com> wrote:

> For debuggers aid we'd want to print debug statements early, so
> introduce a new line in the debug output that describes the whole
> function, and then change the next debug output to describe why we
> need to search. Conveniently drop the arg from the second line;
> which will be useful in a follow up commit, that refactors the\
> describe function.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/describe.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/describe.c b/builtin/describe.c
> index fd61f463cf..3136efde31 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -293,6 +293,9 @@ static void describe(const char *arg, int last_one)
>  	unsigned long seen_commits = 0;
>  	unsigned int unannotated_cnt = 0;
>  
> +	if (debug)
> +		fprintf(stderr, _("describe %s\n"), arg);
> +

Could you explain in the commit message why this wasn't needed before
(if it wasn't needed), and why this is needed now?

>  	if (get_oid(arg, &oid))
>  		die(_("Not a valid object name %s"), arg);
>  	cmit = lookup_commit_reference(&oid);
> @@ -316,7 +319,7 @@ static void describe(const char *arg, int last_one)
>  	if (!max_candidates)
>  		die(_("no tag exactly matches '%s'"), oid_to_hex(&cmit->object.oid));
>  	if (debug)
> -		fprintf(stderr, _("searching to describe %s\n"), arg);
> +		fprintf(stderr, _("No exact match on refs or tags, searching to describe\n"));

What is this arg that can be safely dropped?

You mention that it is for convenience (since the describe() function
will be refactored), but could the arg just be passed to the new
function?
