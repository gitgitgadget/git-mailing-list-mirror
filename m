Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C9A92023D
	for <e@80x24.org>; Wed,  1 Mar 2017 17:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbdCARuD (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 12:50:03 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32899 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbdCARuA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 12:50:00 -0500
Received: by mail-pf0-f196.google.com with SMTP id b5so1808503pfa.0
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 09:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=21KiCnuxrPABqYQDYjfkeNqzE+MPbGq4/kCWEHkc0HQ=;
        b=j6setLNyeoXhs9b2rZ97ewX+8TTVAzqIiV1aL69uGpCJqhVjWb188aQurzG2JoEswN
         4V36Lo0VVz0aYUuP+EJompl9r4urPU8SUJgUtErTjO8Cy3w2+IhUn8sCEo+VzF7PdtKz
         RYX55aZNe3MrzsPI/5U6RowOEbK510S15FdO3F9Bb4jy5YBuTHVEvzhF+6TsT8fgpmf6
         8IlcfztOQDja976R8NJHKLvQh5A5rCZerOWOxc/YkncyX0CwRi415aFuv1drVacLFnLP
         KD9HkYSoxeHae4om0hHvnhP4xUC70Zjr421QM4n6PTrIhKrUEiJg+KERP96UMdfYCFMP
         E2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=21KiCnuxrPABqYQDYjfkeNqzE+MPbGq4/kCWEHkc0HQ=;
        b=T5tmG/LqwToJs471GYDsqYNuvPmwzTq0euAzoDGsopVxr86bCKulMUFSGLD7ajjGJq
         wss/2BKagyOabfwxHh4FVECon4CedPCxV4Ja61Go4HCijFd81z7QpQxGwNM9DSk5TfzB
         I4yA3fAOCWdG37tJQE4NjYJhuXCtuRUEOyrZYcf92Rs4UovzxRQm7CIdfSq3dp1gC2om
         nqE78NKqbMUSIz5Zp+3bFYvwnvLwOwEbHvX2o6Sp70r8BRTIAFgJJldvzbDPhxvdDxLy
         M0pHp8FXVHJHwUHMn/2EXGthR9tfB72eIXZyqOUHrCXoW64mafiXug3aC84CmSVR12e/
         YUXw==
X-Gm-Message-State: AMke39lhDpGauCj9d9sPsjGjg/DnhytoiUftMYK+Fs54LKh5waiqGAF/zYxqyOcvIxBxKw==
X-Received: by 10.99.117.85 with SMTP id f21mr10029022pgn.62.1488390059388;
        Wed, 01 Mar 2017 09:40:59 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:dd87:32f4:da52:1d3d])
        by smtp.gmail.com with ESMTPSA id i3sm8514054pfk.47.2017.03.01.09.40.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 09:40:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        sschuberth@gmail.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Philip Oakley <philipoakley@iee.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v7 1/3] config.txt: clarify multiple key values in include.path
References: <20170224131425.32409-1-pclouds@gmail.com>
        <20170301112631.16497-1-pclouds@gmail.com>
        <20170301112631.16497-2-pclouds@gmail.com>
Date:   Wed, 01 Mar 2017 09:40:57 -0800
In-Reply-To: <20170301112631.16497-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 1 Mar 2017 18:26:29 +0700")
Message-ID: <xmqqshmwhp3q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> The phrasing in this paragraph may give an impression that you can only
> use it once. Rephrase it a bit.
>
> Helped-by: Philip Oakley <philipoakley@iee.org>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Documentation/config.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 015346c417..4748efbf36 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -79,10 +79,10 @@ escape sequences) are invalid.
>  Includes
>  ~~~~~~~~
>  
> -You can include one config file from another by setting the special
> +You can include a config file from another by setting the special
>  `include.path` variable to the name of the file to be included. The
>  variable takes a pathname as its value, and is subject to tilde
> -expansion.
> +expansion. `include.path` supports multiple key values.

Multiple key values or just simply multiple values?  I think it is
the latter.

But to the intended target audience, I think

	`include.path` can be given multiple times.

is easier to understand.  It's not like you can (or want to)
enumerate with "git config --get-all include.path" to learn all the
values (for the single key "include.value"), and it is better not to
lead readers to think of this in terms of <key,value> in the first
place (which is already clarified in the text that follows).

>  The
>  included file is expanded immediately, as if its contents had been
