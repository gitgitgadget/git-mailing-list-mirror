Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D04411F424
	for <e@80x24.org>; Mon, 16 Apr 2018 06:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeDPG2i (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 02:28:38 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42831 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeDPG2h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 02:28:37 -0400
Received: by mail-wr0-f196.google.com with SMTP id s18so22513666wrg.9
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 23:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=iF9DOW9k9KJ73xho53vc0bB+3nYffv9WNw0xecjUqKY=;
        b=FxOV8S2a/81anKkkr6Zf2fh2RVRWl7AJbMOvG9ks45QciKUBNuXoKWPR5JJ2yBtsVZ
         uJCerAelgI35UYdnhIatH8lLUEIJqUc1LMEm7nI5Fx3381J8xQPNy+pEHyEhDBKzZCMc
         k3GYjJZbFg6QbvpXxJHDoQN0wML9vL3/jBP1LRPl19dDGgNKJFs4/qA9IXfKiWrqqJFO
         /FTkXJ+HWvurpuiCb4nLQRRI4ZeWFFAUcoJ/NJAglmxP8ADfWUwS0T+ghQNXHRvOHkVW
         eKvHlOh/q77HqdX2VW8WLPGKLSQ2g5Paz1uyCRGyiDis9J88JC7Hpym+XNEjckHBQJ0F
         VqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=iF9DOW9k9KJ73xho53vc0bB+3nYffv9WNw0xecjUqKY=;
        b=uXPaSrxgyBwHTYmboTRBFimtAPF0BgpZx0FuXQB7EjTMEvdGb26E6hmypgVZ7Ng3TY
         2eJ4dfZQih8YwQKdIRRB8WwzE3E15dt8+yHhb2Jy+sM5iZsm11b4nNG+s4jbJevDWOKy
         MBD1o/+PrgyU/R1RHdiT4En+1IZwaXMttCUe30GFtx8b/nOeXhMyIKbyvSOeZ0/61IDA
         pcl+kk5Jamcl++8bWMT9nIxACThXIuVdzkUt9LR2WrJF3oyOUVSB0Hyu7KdOy0xXiUw1
         1TonMD4z/oGKiwSpf7MLpk6Kw0oYe24QwfRu/lN8d4N01A0XKj5V6YLlnWt0p7cZOSeI
         PZYQ==
X-Gm-Message-State: ALQs6tAuPeCmwzfgjJ3q/xLV1O+LSaaE5WMiyVj5vGfnsGxbMIatkpYQ
        3WsBbnIMi2KNiM44uVz9ROI=
X-Google-Smtp-Source: AIpwx4/spnifv0gTZin0ABGHepbAaCdR9LQc9K2YJ8WRg6Gh44BAs+jofQsrZ/NZ5AYmSu69SPQyAw==
X-Received: by 10.28.137.131 with SMTP id l125mr4893738wmd.14.1523860116007;
        Sun, 15 Apr 2018 23:28:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c27sm18316597wrg.75.2018.04.15.23.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 23:28:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, philipoakley@iee.org
Subject: Re: [PATCH v2 3/6] generate-cmdlist.sh: keep all information in common-cmds.h
References: <20180326165520.802-1-pclouds@gmail.com>
        <20180415164238.9107-1-pclouds@gmail.com>
        <20180415164238.9107-4-pclouds@gmail.com>
Date:   Mon, 16 Apr 2018 15:28:34 +0900
In-Reply-To: <20180415164238.9107-4-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Sun, 15 Apr 2018 18:42:35 +0200")
Message-ID: <xmqq36zvy8a5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> @@ -23,28 +36,44 @@ sed -n '
>  	' "$1"
>  printf '};\n\n'
>  
> +echo "#define GROUP_NONE 0xff /* no common group */"

Some later code forgets about this value, and causes "git<ENTER>" to
segfault at the end of this entire series.

Namely, here:

> -	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
> +	for (i = 0; i < nr; i++) {
>  		if (common_cmds[i].group != current_grp) {
>  			printf("\n%s\n", _(common_cmd_groups[common_cmds[i].group]));
>  			current_grp = common_cmds[i].group;

where common_cmd_groups[] gets overrun.

Here is a squash I'll queue on top to keep the tip of 'pu' at least
buildable.

 help.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/help.c b/help.c
index a44f4a113e..74591d5ebc 100644
--- a/help.c
+++ b/help.c
@@ -242,7 +242,9 @@ void list_common_cmds_help(void)
 	puts(_("These are common Git commands used in various situations:"));
 
 	for (i = 0; i < nr; i++) {
-		if (common_cmds[i].group != current_grp) {
+		if (ARRAY_SIZE(common_cmd_groups) <= common_cmds[i].group)
+			; /* skip */
+		else if (common_cmds[i].group != current_grp) {
 			printf("\n%s\n", _(common_cmd_groups[common_cmds[i].group]));
 			current_grp = common_cmds[i].group;
 		}


