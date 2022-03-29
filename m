Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCEBC433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 17:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbiC2Rbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 13:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbiC2Rbi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 13:31:38 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CD151E57
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 10:29:55 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id v2so15862696qtc.5
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 10:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+I/JASGoEiKE/nbT+hyzw753HxZBgLtVYuPZCFLlzTQ=;
        b=mOi4QvlCI0mjnu2TFFu4hjzNYO2MnO0hvTYMulkhJbiO3hSYx8ARmnQcIrz0+HQACj
         oYVU02zxHcy+GDtDCyfPJHGe/b68IFaqFe0YUb3XszaWQ1rEZKFQaGDM0XF3x9JWtu7/
         73G5ljAPOlMwQm9pH0oug2gpXw/ujssLifClpmJIq9cREsOU+n283oa7beDuCOaXSR+X
         CM6p3ItZgTga/xjXt8N0s6fDvw/zXsejK4rjoGuQUjUj7/q0SXDRoJoEoz8PUVLu9lF5
         2rostbn4PffYCKwGe0mUW6cZ6vqMQt4a4ZmEZUTozeRwSBIReoeQZI8TtiiydQy6vrxP
         LPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+I/JASGoEiKE/nbT+hyzw753HxZBgLtVYuPZCFLlzTQ=;
        b=5TEtYXKT7M9AZh/6b8LPen8mDcbEDIPaMXqQqZ3RIWNSSmj8BKipl2CJgYkOIQMJTS
         bFYjFxEiQvzX9ZJsZ5/ClKNnNkLzVigWPypiQ4a5mgYUwr9k3bW2V9MxAL7Sq4RxkW2r
         LdWfvDWnyPuZqKIztyzhB6Eo7QY5Gu+4Xo4vINSDvOmVTFRTIH2ndtqVWBdt0SLPTWj2
         gcSKGM6LLHRwRQZp/7kHERtCGMTKVnc/B4cbc5whTf58ARopT+FgeeWr+2Ygry1RKjPq
         Tf6tmKSlkqbJ9o7gTeAWHSM36hxkK/OLZsuxUlT2+gzP8g/Z0K20Z6uMzdZgw35g9aAW
         YL3w==
X-Gm-Message-State: AOAM532oH1Oh2XxibdjQFtg7MYXn7wMKBzDbi2R4j0sSasthQzDsCm5M
        dOSK0RpFehSQ3gx4gDH6EiM=
X-Google-Smtp-Source: ABdhPJx1D+pS2IbnA8bwOs0magLZxW+B1fEguLfS0658092nWUNI77CQyXTQ/d6wmjagdjujTc7HEw==
X-Received: by 2002:ac8:7f0e:0:b0:2e1:e86f:c73 with SMTP id f14-20020ac87f0e000000b002e1e86f0c73mr29613072qtk.535.1648574994114;
        Tue, 29 Mar 2022 10:29:54 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id a16-20020a05622a02d000b002e20e4bf4aesm16268444qtx.23.2022.03.29.10.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 10:29:53 -0700 (PDT)
Subject: Re: [PATCH v7 3/4] vimdiff: add tool documentation
To:     Fernando Ramos <greenfoo@u92.eu>, git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, rogi@skylittlesystem.org, bagasdotme@gmail.com
References: <20220328223019.271270-1-greenfoo@u92.eu>
 <20220328223019.271270-4-greenfoo@u92.eu>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <1363db57-74de-226a-468f-69feffde6ba5@gmail.com>
Date:   Tue, 29 Mar 2022 13:29:52 -0400
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
>  		done
>  

While responding to Junio I tried removing the definition of
'diff_cmd_help' for araxis and it is still listed as "Use Araxis"
in the list of values under "merge.guitool" in git-config.{1,html}.

I think that "diff_mode" that you use in the command substitution does
not work for our usage in the documentation Makefile, as in that case
TOOL_MODE is not defined. So a more complete tweak to the Makefile
would be:

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ed656db2ae..c2667de7b3 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -331,12 +331,12 @@ $(mergetools_txt): mergetools-list.made
 
 mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
 	$(QUIET_GEN) \
-	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
+	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && TOOL_MODE=diff && \
 		. ../git-mergetool--lib.sh && \
-		show_tool_names can_diff "* " || :' >mergetools-diff.txt && \
-	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
+		show_tool_names can_diff' | sed -e "s/\([a-z0-9]*\)/\`\1\`;;/" >mergetools-diff.txt && \
+	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && TOOL_MODE=merge && \
 		. ../git-mergetool--lib.sh && \
-		show_tool_names can_merge "* " || :' >mergetools-merge.txt && \
+		show_tool_names can_merge' | sed -e "s/\([a-z0-9]*\)/\`\1\`;;/" >mergetools-merge.txt && \
 	date >$@
 
 TRACK_ASCIIDOCFLAGS = $(subst ','\'',$(ASCIIDOC_COMMON):$(ASCIIDOC_HTML):$(ASCIIDOC_DOCBOOK))
