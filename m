Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97A7C4167B
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 04:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiL0EqT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Dec 2022 23:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiL0EqR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2022 23:46:17 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA73A2620
        for <git@vger.kernel.org>; Mon, 26 Dec 2022 20:46:16 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d7so12231031pll.9
        for <git@vger.kernel.org>; Mon, 26 Dec 2022 20:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8obgmjtel3d36bz4zZ1Kaml6wSbpoVWpXPFWQYw2aM=;
        b=e33uYuyar8PS34b40PdJULGc0/YWdnde0+ilTDK9VpebRcClVDnKjiYaTqMkFMsGyM
         vhJSbKpWBTLnoze2kpSqxnbTu8uc/kWqy+4k2zlShuRDKG9EHSOsGOE/JGp4q4sKN025
         zmwR41O4isdakMJ7joeSbBydM9CVrncnInL6v3cvLYQTv5hx2RRhzTyFIzS3wFkX6s4x
         8xXkFAZ/WyAo3F5CuWP2HYhiqDeqjMEioYAOm8WNeiw13KLEAzwaL08m31isM9ffj+FW
         Nt9TiwFT7gUAQSBLlFu5GSKlDvriNt4KuedELL2msl7zQrXMK/K7cF1rm4s+iUKdVPDr
         7lRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8obgmjtel3d36bz4zZ1Kaml6wSbpoVWpXPFWQYw2aM=;
        b=Kcu1gu2ZnWSYajaQDp62CrmhRPVe0yQuT8pH/xW/tep8bpZ2CtG6tRISbJ0JpcGm8h
         OY30Dw2qjURo84SQ2Ef9hnAo5g4wsXvZtilMl3wDx2NKNFSC3vys2Y4nitiHEB/C8Xvj
         vra+YXuHpFAHfYrOKs5fhsMHlJuGqSEbB6ySAhlNS200KPeQ2hLCkkJ8JX2LuePvONKE
         dhEEpIe8UZ/kC8Go7zpuAxnuO4Ge1svBkilx6UxbliEDL7/+JCgdRD3WXspywdlkXx8N
         TK6TQWa5sIrhNrSx1euPv4ttIJyQzDpvxIOsKZWB8iEeIVpD0PpqPgby/KJQdWOavy4z
         8spw==
X-Gm-Message-State: AFqh2koIRQWeMLhzXBYIpqjyf3gab53/fTo5nrMKhy8X6EOKG4SaelzB
        SVU/kqr5XqVZ4G1kC0MiJxs=
X-Google-Smtp-Source: AMrXdXvYO3yKjtzFrgTatGBel8x6Y/45vn6El8GyhcizDge9kL771cg1CDrwE7CHgXUQFhlU8psH8w==
X-Received: by 2002:a17:902:a708:b0:187:467f:c76c with SMTP id w8-20020a170902a70800b00187467fc76cmr20750898plq.51.1672116376105;
        Mon, 26 Dec 2022 20:46:16 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m19-20020a170902f21300b001766a3b2a26sm7967431plc.105.2022.12.26.20.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 20:46:15 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc/git-branch: fix --force description typo
References: <20221226165441.126625-1-kyle@kyleam.com>
Date:   Tue, 27 Dec 2022 13:46:15 +0900
Message-ID: <xmqqcz85v4h4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

> Subject: Re: [PATCH] doc/git-branch: fix --force description typo

> Update the description of --force to use '<start-point>' rather than
> '<startpoint>' to match the spelling used everywhere else in the
> git-branch documentation.

Thanks.  This <startpoint> was written in 2017, and all other lines
that say "start-point", except for one, blame on commits made in
2019-2022, but they have been inherited from older versions.

Apparently we missed to convert this single one for consistency.

Good find.  Will queue.  Thanks.

> Signed-off-by: Kyle Meyer <kyle@kyleam.com>
> ---
>  Documentation/git-branch.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 12c5f84e3b..aa2f78c4c2 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -116,7 +116,7 @@ OPTIONS
>  
>  -f::
>  --force::
> -	Reset <branchname> to <startpoint>, even if <branchname> exists
> +	Reset <branchname> to <start-point>, even if <branchname> exists
>  	already. Without `-f`, 'git branch' refuses to change an existing branch.
>  	In combination with `-d` (or `--delete`), allow deleting the
>  	branch irrespective of its merged status, or whether it even
