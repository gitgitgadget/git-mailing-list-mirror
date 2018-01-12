Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 959C11F406
	for <e@80x24.org>; Fri, 12 Jan 2018 12:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933473AbeALMkT (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 07:40:19 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:42165 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933149AbeALMkS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 07:40:18 -0500
Received: by mail-wm0-f66.google.com with SMTP id b141so11923473wme.1
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 04:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=Pgimpeik0z3pWig2e3xYjNWHArm2UUzwYQFog2IoVaw=;
        b=aBH3bK+Dq4rYLLOt6ATkFCDAE0AeWagJyfHCTc5ZaiKIMiopDJVu53hNw3246I9SPF
         62l9cwcHfwngFTRrMUiAlGKtvLcMBQGWLUoa1GyXR6GaqwErnzRZWeep+T0NP8IZq5kg
         PAjcfLmYN1zORaw2zO6SIwv/jLTLnmiqdOnTW4r7r3XPKYU3DSwicfz5dbbKi49qNtgL
         Kz89u+QyK3aW18mRBlW0ffE/zCGsBDWoIjjayvXo+0DQaihuLDpmrE4RpOf5CSM5O/Ek
         YOPcxdiJwRMS2xLrF0lLsw71GNDDS1mE3mmdvYTbGJdXitUH9n3ypDmIxJQapJkg+UrU
         Eiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=Pgimpeik0z3pWig2e3xYjNWHArm2UUzwYQFog2IoVaw=;
        b=g9gwLSzz7SEPcK+dpwbqqqpUIF3DDB/mDR+Ddyx5mvz5UgjWto5G4tuyzNgLnU1icO
         Ux7ozY38HwIEiOp1CQcw53tvdA5kuEcUt1Mlb3eV6ifa5k4dnVbat0GlOWtLqFS6VYw3
         o5U+vgZtiQPsFesQFfZxuH3evUPcX3tc1siPYY81ijmsAG14ipbmg9Bp8SGnilKPPc5K
         6ln2KHaxEfVbVZ128XK1kgaCkw4JGSrloliBl8Bv0ZhURCgAgfeRmgYRF6udy8RIwYhj
         Z/gRMclB38ESbJwQNl+watc0U9q8LM00sHxeYQWTZYepZ4oYvFUofKGkzQhDOjrw4Hym
         yGwg==
X-Gm-Message-State: AKwxyteGt+6nvecsxBhs1A8NFv5IBLnBHJd6cK5ewq0xLDkh4Kg/9XyN
        Q0vPyAWYrivd+VO/LRF4LGk=
X-Google-Smtp-Source: ACJfBot5GILXq+YK251wAaoDwy8R09MO3ea673JVcYUzkPGR7wnYDERNkY1N7GYkrjeBMTps5qK5GA==
X-Received: by 10.28.63.15 with SMTP id m15mr3850993wma.1.1515760817205;
        Fri, 12 Jan 2018 04:40:17 -0800 (PST)
Received: from localhost.localdomain (x4db288cd.dyn.telefonica.de. [77.178.136.205])
        by smtp.gmail.com with ESMTPSA id w11sm32472511wrg.41.2018.01.12.04.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Jan 2018 04:40:16 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Christian Ludwig <chrissicool@googlemail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] send-email: Support separate Reply-To address
Date:   Fri, 12 Jan 2018 13:39:43 +0100
Message-Id: <20180112123943.21227-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.0.rc2.67.ga02edd63f
In-Reply-To: <20180112104751.28263-1-chrissicool@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> In some projects contributions from groups are only accepted from a
> common group email address. But every individual may want to recieve
> replies to her own personal address. That's what we have 'Reply-To'
> headers for in SMTP.
> 
> Introduce an optional '--reply-to' command line option. Unfortunately
> the $reply_to variable name was already taken for the 'In-Reply-To'
> header field. To reduce code churn, use $reply_address as variable
> name instead.

That $reply_to variable is only accessed in 6 lines.  I wouldn't
consider it that much of a code churn to rename it in a preparatory
patch.

> Signed-off-by: Christian Ludwig <chrissicool@gmail.com>
> ---
>  Documentation/git-send-email.txt |  5 +++++
>  git-send-email.perl              | 18 +++++++++++++++++-
>  t/t9001-send-email.sh            |  2 ++
>  3 files changed, 24 insertions(+), 1 deletion(-)

Please add the new option to the completion script as well, to keep it
up to date.

> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 8060ea35c..c3bc622b1 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -84,6 +84,11 @@ See the CONFIGURATION section for `sendemail.multiEdit`.
>  	the value of GIT_AUTHOR_IDENT, or GIT_COMMITTER_IDENT if that is not
>  	set, as returned by "git var -l".
>  
> +--reply-to=<address>::
> +	Specify the address that replies from reciepients should

s/reciepients/recipients/

And I don't like that "that" and would prefer e.g. "where" instead,
but I'd rather leave this to the native English speakers.

> +	to go. Use this if replies to messages should go to another

s/to go/go to/

