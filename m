Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8F57209FD
	for <e@80x24.org>; Fri, 26 May 2017 03:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163510AbdEZDPp (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 23:15:45 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33051 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162487AbdEZDPa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 23:15:30 -0400
Received: by mail-io0-f195.google.com with SMTP id m4so377638ioe.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 20:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SsaKgR4ElPcWqDgAZw2BW5/Di8YKtJG6iQxTdQKGigY=;
        b=XdVL015Rbz5ko1z8y9242mv4aZtYz3Oty/qiSQasXu5sPUiWBBFPO+uycX+nbtPylY
         M1RFZA2LtgbQATdMxb8U/hkc2QZ9RkWyoTXEewZOL/LYBauurWytZSrrQFafSroRWcv8
         CxhkiubAPW+bO69HULBnvVg4Ik1zXtuZx7Go+jODmcPmKpaJ//YFiagOU92rYR9HtMf9
         Fw+ZdEHuYhlkTKIzryHe4O9g77DPRwme+iG+CAOX/ncx2mMp37Ps0ZvN5pEK1YI7ySh8
         PGYOqx5wmCysyRiX1iLkLWQdOavT/WtyrB9LA52LExV45TC0XR/0fmlTkLcvLKHuFoSt
         a50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SsaKgR4ElPcWqDgAZw2BW5/Di8YKtJG6iQxTdQKGigY=;
        b=lwDW+9XhDlGtkmj8fXhiqmA/W2+M0ZNXSGNNoaNIL/KaXcsSTGGeCLPz8ggOgw4S/D
         ivG3M6ZnfVeLt2/jkpxxkzkz8VDMBnfavpjSpLpBVm9i6+jrhloU8JOm2e3oDz90lyLH
         jt0Kkp6u3VKcbheGi7/rPHvzYVzFpn9vi1XIXBv7b0yNlsED7SMIbcP/S3OAnGxGns1n
         acjLN7ufaD9aLC+Fnsh82d7E/U+RJhGS8DyycLGVS9U4jaSIpH5Wyua3ueySxrDIjku1
         EeZJZRuAPIFgnN9gKHuN3g65ivV+xdNkAdAB9uEmdFRP8jKmuWL5RY+SMJgQ0RmZdY6L
         81hQ==
X-Gm-Message-State: AODbwcBJy1iPcypEfkF+H5ZIswrpnhULYpbG6AoYgZCQCAWW9AAeh3IG
        Y088qrE8muVtpQ==
X-Received: by 10.107.136.195 with SMTP id s64mr40173085ioi.18.1495768529550;
        Thu, 25 May 2017 20:15:29 -0700 (PDT)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id f15sm3876328ioi.58.2017.05.25.20.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 20:15:28 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     johannes.schindelin@gmx.de
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, phillip.wood@dunelm.org.uk
Subject: [PATCH v4 03/10] rebase -i: remove useless indentation
Date:   Thu, 25 May 2017 23:15:24 -0400
Message-Id: <20170526031524.27935-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <fefd59fb626a9a0ddd6c9bc3a7a42d6d1016b4c3.1493414945.git.johannes.schindelin@gmx.de>
References: <fefd59fb626a9a0ddd6c9bc3a7a42d6d1016b4c3.1493414945.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> The commands used to be indented, and it is nice to look at, but when we
> transform the SHA-1s, the indentation is removed. So let's do away with it.
> 
> For the moment, at least: when we will use the upcoming rebase--helper
> to transform the SHA-1s, we *will* keep the indentation and can
> reintroduce it. Yet, to be able to validate the rebase--helper against
> the output of the current shell script version, we need to remove the
> extra indentation.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git-rebase--interactive.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 609e150d38f..c40b1fd1d2e 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -155,13 +155,13 @@ reschedule_last_action () {
>  append_todo_help () {
>  	gettext "
>  Commands:
> - p, pick = use commit
> - r, reword = use commit, but edit the commit message
> - e, edit = use commit, but stop for amending
> - s, squash = use commit, but meld into previous commit
> - f, fixup = like \"squash\", but discard this commit's log message
> - x, exec = run command (the rest of the line) using shell
> - d, drop = remove commit
> +p, pick = use commit
> +r, reword = use commit, but edit the commit message
> +e, edit = use commit, but stop for amending
> +s, squash = use commit, but meld into previous commit
> +f, fixup = like \"squash\", but discard this commit's log message
> +x, exec = run command (the rest of the line) using shell
> +d, drop = remove commit

do we also need to update all the translations since this is a `gettext`
function?

>  
>  These lines can be re-ordered; they are executed from top to bottom.
>  " | git stripspace --comment-lines >>"$todo"
> -- 
> 2.12.2.windows.2.800.gede8f145e06

Liam

