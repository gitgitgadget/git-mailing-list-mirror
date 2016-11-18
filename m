Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CEDD1FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 22:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbcKRWq4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 17:46:56 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35617 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752140AbcKRWqz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 17:46:55 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so10734892wme.2
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 14:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=OmTurADYvLlxbuu65Bht92UrP8BekizLHu0S8bNaVh0=;
        b=GnIv9VfRPO3xM9Uf/+yd2m8vVmQKQkV736bxlvRCVMr0L/EHfWMyRbYYyYPUQt38q1
         25XiNqmtcgGeTlVx2AJaGlPu1VId/Nx60q3B04hK2hwgFI6RqihYBNzdNLKsTVgaqDio
         nklY9dHQie4gWqcIMEofR9mAjSsRrDg9+Qplb1KfqRQPB1BQmspaorj/D4gOwe0jPv+f
         GfUMbGZJQzGlZIQgdOhBtOJ4/c+om9GkZuZ1tpMBzTHd8Q2qMo8JWyyAmvN9fwgTt6I/
         Zc5gWLXb1JrzkT7/hz0/d7BDFLV2RV2dewXgKouMZpLXJiI7lVTCGv2DdWGB+nujMUch
         8DtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=OmTurADYvLlxbuu65Bht92UrP8BekizLHu0S8bNaVh0=;
        b=makZqDJeR+vGBvxRp82LUpDJsoX5fQZUFDDJjq2Ng3hgqlcBncaf9dBZrhzPLgyX5P
         Dg1+qPwhiJ8sgz9r2LMhqKEdNgHXFomFUsXSb8o+M08nJBX6xZHlACweYoDYV3WJfckt
         GgZf08TjCC5916WgX8pIClBSw+/aORHXcAmizC2jfbZ8S3Aux1JP8tWgHNbO4VrE0K7e
         c+ZFTQptY7r9zvrUQtRwVs6EWdKy5qKtVkXXnKWdJGuTnkF0uDxpr55QwovhclLmXiL+
         enD2xe8WkkaiPMx9MFwcskmctS6GAMB2J8aDKRLHzM/pmgbBWjaexKQpyIK/lLIffxV8
         9j3A==
X-Gm-Message-State: AKaTC00E9U5VbQv+Nleny2ZwlqYo/Cmo7SpN2m76EmPQ+lmQz7N0fv0RhRe0BZyr/5PXpA==
X-Received: by 10.28.36.193 with SMTP id k184mr736638wmk.40.1479509213896;
        Fri, 18 Nov 2016 14:46:53 -0800 (PST)
Received: from [192.168.1.26] (acuy2.neoplus.adsl.tpnet.pl. [83.11.104.2])
        by smtp.googlemail.com with ESMTPSA id im3sm11134060wjb.13.2016.11.18.14.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Nov 2016 14:46:53 -0800 (PST)
Subject: Re: [PATCH v7 14/17] ref-filter: allow porcelain to translate
 messages in the output
To:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
References: <20161108201211.25213-1-Karthik.188@gmail.com>
 <20161108201211.25213-15-Karthik.188@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <af0b7bdc-2b29-0d04-85f1-aa1d5a2ba549@gmail.com>
Date:   Fri, 18 Nov 2016 23:46:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <20161108201211.25213-15-Karthik.188@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 08.11.2016 o 21:12, Karthik Nayak pisze:
> From: Karthik Nayak <karthik.188@gmail.com>
> 
> Introduce setup_ref_filter_porcelain_msg() so that the messages used in
> the atom %(upstream:track) can be translated if needed. This is needed
> as we port branch.c to use ref-filter's printing API's.
> 
> Written-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  ref-filter.c | 28 ++++++++++++++++++++++++----
>  ref-filter.h |  2 ++
>  2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/ref-filter.c b/ref-filter.c
> index b47b900..944671a 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -15,6 +15,26 @@
>  #include "version.h"
>  #include "wt-status.h"
>  
> +static struct ref_msg {
> +	const char *gone;
> +	const char *ahead;
> +	const char *behind;
> +	const char *ahead_behind;
> +} msgs = {
> +	"gone",
> +	"ahead %d",
> +	"behind %d",
> +	"ahead %d, behind %d"
> +};
> +
> +void setup_ref_filter_porcelain_msg(void)
> +{
> +	msgs.gone = _("gone");
> +	msgs.ahead = _("ahead %d");
> +	msgs.behind = _("behind %d");
> +	msgs.ahead_behind = _("ahead %d, behind %d");
> +}

Do I understand it correctly that this mechanism is here to avoid
repeated calls into gettext, as those messages would get repeated
over and over; otherwise one would use foo = N_("...") and _(foo),
isn't it?

I wonder if there is some way to avoid duplication here, but I don't
see anything easy and safe (e.g. against running setup_*() twice).

Best,
-- 
Jakub Narębski

