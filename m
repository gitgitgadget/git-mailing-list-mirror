Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7177B1FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 10:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932724AbcIAKuj (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 06:50:39 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34453 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbcIAKui (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 06:50:38 -0400
Received: by mail-lf0-f65.google.com with SMTP id k135so3930991lfb.1
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 03:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=MWZAUyEGQgpQN59P81ZJ8+rmUhZZOXh+tW4hpDyZ2Ss=;
        b=lDHFFWDEg6SsqyadrCIpTMgAnYvI8j7vdmRjYKuDlp59f7+HX8sU87KqhQJ8G8PlAR
         XLpnxHt7tz2543ufLQ6E4v4beTDOqCS5l/AGEbfVhSbl2Si5HVUx8Gob+l4h7LzrLmlt
         VQ75JYw/hQHK8IBtHDrVvmsgM935ENTe5ABbx5t1DPDheqx61KsCBUpF/fV3v98U9IlY
         tbZHZCq3uXEarl1iE4RFUsJfMZ6WTMwW1maWnreOjNaB5A9cgarPuyUc6TPZm6FzpScP
         2A8GJXM931ExFl/4yc0jeS/jjuW9NXouajZ3QweygyI55MYgocbAx5SxYOelfoc9NaZl
         ejWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=MWZAUyEGQgpQN59P81ZJ8+rmUhZZOXh+tW4hpDyZ2Ss=;
        b=DnOLcwYSoQCj6ZhEGnoeie31pllTwuqjOqcofAbsruzvZTWEdvtd4DHrs7RBYymk1/
         ZIKfCEl40TB6i6NNCvrd9WiSetRmfypS2K92lSYK2I1tUa7wmrDCM8TscgRr6rPK+P7s
         9a4StLpXhvgylDVgY8moCO+NeNbXXioBuZjZ5czfVJnx718vMOj7FlGZdMQG7SGcG9Hm
         48xawihWnawfsWbv/cLSMh+WUxjauOmb5coj/VT/ebwcBX0r/b9BG32/Liyd81KfN2Pz
         LUn72a24DiI6MiwlJ6KH2SbZSQu6HIjdUP/1Fo6mcGb7mSAXJxsQAiOOQbYtSTsSZNO8
         bPuQ==
X-Gm-Message-State: AE9vXwNLl6j73vhuDVMrfL6bkE29oq8UbUcAAHqWsgmXzN+zKLL1H8Po+q0Zx5imgWHYAw==
X-Received: by 10.46.5.6 with SMTP id 6mr4645333ljf.66.1472727036037;
        Thu, 01 Sep 2016 03:50:36 -0700 (PDT)
Received: from [192.168.1.26] (enu134.neoplus.adsl.tpnet.pl. [83.20.10.134])
        by smtp.googlemail.com with ESMTPSA id k63sm815401lfe.48.2016.09.01.03.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 03:50:34 -0700 (PDT)
Subject: Re: [PATCH 21/22] sequencer: left-trim the lines read from the script
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <8c30113a920e075e5ecd68ba31b4007de3e2dbc2.1472457609.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <7996a963-52b5-5f3c-f686-f5cf22573573@gmail.com>
Date:   Thu, 1 Sep 2016 12:50:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <8c30113a920e075e5ecd68ba31b4007de3e2dbc2.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

W dniu 29.08.2016 o 10:06, Johannes Schindelin pisze:

Subject: [PATCH 21/22] sequencer: left-trim the lines read from the script

In the subject, it should probably be without "the", as "lines"
are plural.

s/left-trim the lines/left-trim lines/

> Interactive rebase's scripts may be indented; We need to handle this
> case, too, now that we prepare the sequencer to process interactive
> rebases.

s/; We need/; we need/

Nice little bit of scaffolding for sequencer-izing rebase -i.

> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 3 +++
>  1 file changed, 3 insertions(+)

Small change, easy to review.

> 
> diff --git a/sequencer.c b/sequencer.c
> index 0614b90..5efed2e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -864,6 +864,9 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
>  	char *end_of_object_name;
>  	int i, saved, status, padding;
>  
> +	/* left-trim */
> +	bol += strspn(bol, " \t");
> +

Nice.  Thanks for the comment.  "left-trim" is better than "de-indent".

'bol' is beginning-of-line, isn't it (a complement to eol)?

>  	for (i = 0; i < ARRAY_SIZE(todo_command_strings); i++)
>  		if (skip_prefix(bol, todo_command_strings[i], &bol)) {
>  			item->command = i;
> 

-- 
Jakub Narębski

