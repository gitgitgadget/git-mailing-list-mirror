Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFA3C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 14:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbiC2OJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 10:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbiC2OJV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 10:09:21 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E1D257196
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 07:07:37 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z19so12050936qtw.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 07:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1CBttYRyg57JWEz/Qt3dgg8vh5izm8az6P6cOV7epro=;
        b=ZAoFgCYpWRmlDbF80GZ9HuEOAhP+qO9pRoKrxgLdJhPfyflGtOMNFiQbwJ4a6Mfo3D
         1gC0W17mm0BgWaVW55uK+6zmkEHTZK4kGc//iaKQl2NiMiMw0GcNtqyDwe+WHhl15mjp
         bxcvNW2wLVvZINDaCjtVmHiSmL/bSZ0u+GOR3pPMgYXnOUyBSWUsyjjOLqCLaump3VL1
         WyInYBddSGLOiEB+lCWgcpEhkRmO0MOIY/izwzgDWGlA+afNeaVnhPvof9ryAYOJ0XcP
         G8ce3bh1uAfHZ9+VrThnpVi1azl37q7EB6pfNGT1X+RYMZth6eLei+l2i9ax/WJTkNSU
         f+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1CBttYRyg57JWEz/Qt3dgg8vh5izm8az6P6cOV7epro=;
        b=SqzXzX1uVZT6FRUSVdctWBCmB+4ctndNA0J2BtcdDgB9fatlYRIp4+KUGvf3F52Dk6
         qX1w2PXSuDkNs8uZ8n71nPjL3f2u1SdQZVG05RNazy5d2YC6sF5/VbnXx1bbM9HfzEDp
         +gdbbv6z97mZ8SPlaYGtngs1GeqEYB7O0A8/MnYaNs4vaO0lf5KoFSqKgdqZbTh+xnLY
         aTG/N8FpZjxukFYKKjiivHT+xJNKfA2/08W7BTM/CoStu67ahy2mgmhEGcR+ro7mFNZd
         vn01+hxWq5Cir13kYGnTqTSa74pfr/DgbSp2Pa7psf+Ay7u/g6VRmSjSg2KoCjrhU8CD
         bsCA==
X-Gm-Message-State: AOAM531ZsuCkDuhSQfkj+7slCu2j0Mcc3OV5xEU89VuJGJ8XpVBebO56
        3ynHdrcKdd1J/YnoBxNS3U0=
X-Google-Smtp-Source: ABdhPJz9qHsKmAUBhqFwRNH/W4Itqgqq2Ue3z54cArfPPfrlPMjqyZ2abaIXKeYGk5ZCRvcqiP3rUg==
X-Received: by 2002:a05:622a:58d:b0:2e1:d246:fb1 with SMTP id c13-20020a05622a058d00b002e1d2460fb1mr27106242qtb.132.1648562856633;
        Tue, 29 Mar 2022 07:07:36 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id 19-20020a05620a079300b0067d1537f35bsm9524381qka.83.2022.03.29.07.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 07:07:35 -0700 (PDT)
Subject: Re: [PATCH v7 3/4] vimdiff: add tool documentation
To:     Fernando Ramos <greenfoo@u92.eu>, git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, rogi@skylittlesystem.org, bagasdotme@gmail.com
References: <20220328223019.271270-1-greenfoo@u92.eu>
 <20220328223019.271270-4-greenfoo@u92.eu>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <1bc25dd7-fca6-eab9-c850-3dc2b2dc9e8c@gmail.com>
Date:   Tue, 29 Mar 2022 10:07:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220328223019.271270-4-greenfoo@u92.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Fernando,

Le 2022-03-28 à 18:30, Fernando Ramos a écrit :
> Running 'git {merge,diff}tool --tool-help' now also prints usage
> information about the vimdiff tool (and its variantes) instead of just
> its name.
> 
> Two new functions ('diff_cmd_help()' and 'merge_cmd_help()') have been
> added to the set of functions that each merge tool (ie. scripts found
> inside "mergetools/") can overwrite to provided tool specific
> information.
> 
> Right now, only 'mergetools/vimdiff' implements these functions, but
> other tools are encouraged to do so in the future, specially if they
> take configuration options not explained anywhere else (as it is the
> case with the 'vimdiff' tool and the new 'layout' option)
> 
> In addition, a section has been added to
> "Documentation/git-mergetool.txt" to explain the new "layout"
> configuration option with examples.
> 
> Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>

Thanks :) I think the project convention is to also use the 
'Co-authored-by' trailer as well :) 

> ---
>  Documentation/config/mergetool.txt   |   9 ++
>  Documentation/git-mergetool.txt      |   8 ++
>  Documentation/mergetools/vimdiff.txt | 189 +++++++++++++++++++++++++++
>  git-mergetool--lib.sh                |  10 +-
>  mergetools/vimdiff                   |  53 ++++++++
>  5 files changed, 268 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/mergetools/vimdiff.txt
> 
> diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
> index cafbbef46a..13f1b234db 100644
> --- a/Documentation/config/mergetool.txt
> +++ b/Documentation/config/mergetool.txt
> @@ -45,6 +45,15 @@ mergetool.meld.useAutoMerge::
>  	value of `false` avoids using `--auto-merge` altogether, and is the
>  	default value.
>  
> +mergetool.vimdiff.layout::
> +	The vimdiff backend uses this variable to control how its split
> +	windows look like. Applies even if you are using Neovim (`nvim`) or
> +	gVim (`gvim`) as the merge tool. See BACKEND SPECIFIC HINTS section
> +ifndef::git-mergetool[]
> +	(on linkgit:git-mergetool[1])

small nit: "in linkgit:git-mergetool[1]" would read slightly better I think,
but that may be just me... and I think I would drop the parentheses.

> +endif::[]
> +	for details.
> +

> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 542a6a75eb..9f99201bcc 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -63,7 +63,7 @@ $(list_tool_variants)"
>  					preamble=
>  				fi
>  				shown_any=yes
> -				printf "%s%s\n" "$per_line_prefix" "$toolname"
> +				printf "%s%-15s  %s\n" "$per_line_prefix" "$toolname" $(diff_mode && diff_cmd_help "$toolname" || merge_cmd_help "$toolname")
>  			fi

I tried this and it looks much better on a single line, nice!

I also noticed that the list of available tools is embedded in 'git help config'
(see the rule for "mergetools-list.made" in Documentation/Makefile). I looked 
at the generated 'git-config.html' and it is not ideal; it would be better if 
the tool names would be enclosed in backticks. I tried the following tweak:

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ed656db2ae..a2201680a2 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -333,10 +333,10 @@ mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
 	$(QUIET_GEN) \
 	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
 		. ../git-mergetool--lib.sh && \
-		show_tool_names can_diff "* " || :' >mergetools-diff.txt && \
+		show_tool_names can_diff "* " || :' | sed -e "s/* \([a-z0-9]*\)/* \`\1\`:/" >mergetools-diff.txt && \
 	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
 		. ../git-mergetool--lib.sh && \
-		show_tool_names can_merge "* " || :' >mergetools-merge.txt && \
+		show_tool_names can_merge "* " || :' | sed -e "s/* \([a-z0-9]*\)/* \`\1\`:/" >mergetools-merge.txt && \
 	date >$@
 
 TRACK_ASCIIDOCFLAGS = $(subst ','\'',$(ASCIIDOC_COMMON):$(ASCIIDOC_HTML):$(ASCIIDOC_DOCBOOK))


and it mostly works, though with the Asciidoc HTML backend, "emerge" is not correctly
formatted, I get:

‘emerge`: Use Emacs’ Emerge

and in the man page the backticks are kept litereally.It works correctly 
with Asciidoctor though, both in HTML and man page ...
