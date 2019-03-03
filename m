Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1439420248
	for <e@80x24.org>; Sun,  3 Mar 2019 01:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfCCBVu (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 20:21:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45253 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCCBVt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 20:21:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id w17so1692742wrn.12
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 17:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=eTnclMCq+BHPb6t5dmTt+lz+pIAGnm/S7fr0yAlWNh4=;
        b=HitbPMx5mn5nIzSrqBrYS2sYxPrtRPI/o9minxGryZaYsGMdmxoANg7W4kq7iKP6GU
         HHUgiZt2isokecmSDhtb7AdsdDVMPgkHFTr91RXmvGMOmvyJnXDVyImaDPdzi10Qwor7
         9nCTmZ0FDOtMfsYjtMqOyiyoZCniQ4FFsz4c7fmN4XuFApYymQOPxLvvN8B+KFMmhE2T
         4nPj0bPEBDsfkAg5S3+6LAwCQMTqDTxCW/GMkicUSib5dsprU2/eqmOePvajDeynHNm9
         XxTlzBOoIWcqUAuSYDNpAbKGUrUK5u6V2z0lhCRPHOF5NLbe3p9TInsPkpkdASopkZ+b
         igqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=eTnclMCq+BHPb6t5dmTt+lz+pIAGnm/S7fr0yAlWNh4=;
        b=azOmT6pyCBnSEo1eIhjx8Mr21kGIOpfSDOTIB7pmUyB/l6L4L362WdRXuT/BQD/8dr
         VRMd5ywV/dnO6y612TcRpVMiy9nLDCWXAXWKgFTfmzCllJveJqPBurUf4BplWnVVLjHT
         4RksJ8KP+kFs4qbeLkueJm5BRv3Uor4RJN5IGbnxlgZgUfYNh08nGOsEmRSeZ54Bqyj+
         jowuO66DheEmoy6V+JjialjU+svekobyZevOm/sxIIrxmikGMjPmAou4yQ1fchSnMgXy
         S8Exap5Y+gLQqnC8lgh6tK22HmKjpFxVYNZ6kPl2lrId+FYogNoqmxkg8iLfjJo7VtF6
         UQzA==
X-Gm-Message-State: APjAAAVWKaimIkdg21FPrcjVdUcRCPsR6hLvkD2FTwUIDjpk4H9DPb81
        J2AHxwo0RXlwczOpKLiecUM=
X-Google-Smtp-Source: APXvYqzv4dV/AC/3fyT1eswLECLKa3TwNIEN+UWrmv/Ps70xroBy1aGoMuXFob1BmqfoLigy+VlyGw==
X-Received: by 2002:adf:ee4d:: with SMTP id w13mr8203308wro.16.1551576107886;
        Sat, 02 Mar 2019 17:21:47 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e7sm2146322wrw.35.2019.03.02.17.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Mar 2019 17:21:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] fixup! upload-pack: refactor reading of pack-objects out
References: <pull.139.git.gitgitgadget@gmail.com>
        <5fa4fcad63e18dd9d840217eb8cf3dab8f69bc1b.1551046329.git.gitgitgadget@gmail.com>
Date:   Sun, 03 Mar 2019 10:21:46 +0900
Message-ID: <xmqq1s3o69cl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This fixes an issue pointed out by clang.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  upload-pack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index 2365b707bc..534e8951a2 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -179,7 +179,7 @@ static void create_pack_file(const struct object_array *have_obj,
>  			     const struct string_list *uri_protocols)
>  {
>  	struct child_process pack_objects = CHILD_PROCESS_INIT;
> -	struct output_state output_state = {0};
> +	struct output_state output_state = {"\0"};

OK, as the structure looks like

	struct output_state {
		char buffer[8193];
		int used;
		...

we obviously cannot initialize buffer[] with a single integer 0 ;-)
Between "" and "\0" you wondered elsewhere, I have no strong
preference, but if I were fixing it, I would probably write it as

	struct output_state output_state = { { 0 } };

so that readers do not even have to waste time to wonder between the
two.

Thanks.

