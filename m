Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AE9C4332F
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 23:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiL0X1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 18:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiL0X1d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 18:27:33 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2946038D
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 15:27:32 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id p4so14614167pjk.2
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 15:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ID3FdEmoshjq28QYcjulBlQVe0CPrzHhffvPqJ+lz5A=;
        b=lIZodN8jNoCMGobf9YV6mdxUDkv/V+ko1xwlG/tNkvKgR2ohgXb0JzsZRqtz3np36G
         QVkEa6+Y2YmjHfRXkoGgQSgzYVd8xvxgqXIZReN+XP+/2dzVE7uXrCu4jWcLlwx75CU+
         gtFt/64uJ3BuIyTO5dKARwXc5mo4EAKDvrKCOtZRbThPPQX3LSsyWsAq3Rc5cdStN2k9
         /PY+jalZh+MwQSOxdEHjyLtcgInS7o/ugwKGnaNh5fq5b7KzQG+ADbI0LDsYjx0bTg3p
         qdrx8ycReqTxvXYf8qeBNDmcyvkFh569zTzCRVvE7zt5oWxu1ZkZTksu/uTK+fDvfFox
         U9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ID3FdEmoshjq28QYcjulBlQVe0CPrzHhffvPqJ+lz5A=;
        b=rmeq4O3QwKKlTR2PL9WMQqiooISroiJ+14SEWGWPYFQJiY5MXyTT9tTWdMJ77o5XT8
         Hr2T8RMukXIMVoKQTrHjPk/e+WbfZR0jbQA+KVRGiIoQXyerH1Bpzn4PzhRQNE+G9EsS
         ii8UQ29760csvfR2qCl7ThIlLTii3i9wFrualzrqADBTqWGmMLqz5RUPqQ2k87tDYjcU
         J3nj7ZWn7KAl4XceA8Fu826j7NMMDGqldMbdM4Qb6elIE7vumekrrZ6Mdj3GRu8Up5l/
         7fgKhu0XWL3tnPa0+PPl4qcNE0CEldgD43dcQBvYe0F5fnGTKtXfY5S+OEGrUFazXa3Z
         +NTQ==
X-Gm-Message-State: AFqh2kper0hkIpZs6563NeinOTzwve2/C0Wf2cQyCEM2nHDo5TAEJoeJ
        uag/VShqGpCPHiX3s+3SJK9aDiH4nzDdxQ==
X-Google-Smtp-Source: AMrXdXuA+EA8ozln1r0H8rE1SM17z5krI93+VP5st+Bd/fxwM9KjzFACWKrcbi58ow7ksoXEHjDH6g==
X-Received: by 2002:a05:6a20:a5a1:b0:a7:7c23:6cf4 with SMTP id bc33-20020a056a20a5a100b000a77c236cf4mr33826996pzb.2.1672183651622;
        Tue, 27 Dec 2022 15:27:31 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id jd15-20020a170903260f00b00186b69157ecsm9565171plb.202.2022.12.27.15.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 15:27:31 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gitattributes.txt: fix typo in "comma separated"
References: <20221227210156.1532168-1-rybak.a.v@gmail.com>
Date:   Wed, 28 Dec 2022 08:27:30 +0900
In-Reply-To: <20221227210156.1532168-1-rybak.a.v@gmail.com> (Andrei Rybak's
        message of "Tue, 27 Dec 2022 22:01:56 +0100")
Message-ID: <xmqqbknoqvfh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>  Documentation/gitattributes.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Obviously correct.  Will queue.  Thanks.

> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 4b36d51beb..c19e64ea0e 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -1155,7 +1155,7 @@ Unspecified::
>  
>  String::
>  
> -	Specify a comma separate list of common whitespace problems to
> +	Specify a comma separated list of common whitespace problems to
>  	notice in the same format as the `core.whitespace` configuration
>  	variable.
