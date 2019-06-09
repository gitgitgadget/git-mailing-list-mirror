Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57B711F462
	for <e@80x24.org>; Sun,  9 Jun 2019 17:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfFIRwm (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 13:52:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54957 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbfFIRwl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jun 2019 13:52:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id g135so6395679wme.4
        for <git@vger.kernel.org>; Sun, 09 Jun 2019 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yy0/mkt/qjGyRYQmwudGxEtoHCwGUOgqGs/4mhstSc0=;
        b=C19rBAPvXJ4pMACUr6r3NNlFtwma0QBpF5Th2T66f5ptM+QH9aWcs6Ik4B/QBjcJh6
         cEzV+U2+gHwiP76o1vdVXaxWesO3a9cmFecXELzu81K0v/Ka/vJPupzNzpieGPqUw5U6
         3SjnyXo9By5bgImEC7ucTt6weo/3cnCFzinIsgLBUZEZ2TLLrzvHjh2TA8yFjkXUw65z
         QFafOatdfANJN+Nhuka1SeRoJhqpb1hTd0SqFTTe+a0Pj5koXjqG23MrnFvuo8JtXBwU
         5LXWsbZ4tcekAMEQz/vqEdc0uetAf7cwntL3l6wUsl6t2BHv6z7wSmKOsaEAwH5fwaPh
         FhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yy0/mkt/qjGyRYQmwudGxEtoHCwGUOgqGs/4mhstSc0=;
        b=X9ZlrQHoZOehBhiI4EfloOoYkvvHsbKAj7rSx2AsjRbbyAFgJigHJkM/RxCuo1sdON
         i/FegtIj3vqD1Bi9YOyZD1aC3okdvRwPj77trMybVjTmdV8UK+jHtBiuZ7B2SKusZYtO
         HZHcXDsWBW22YYdYvVirSSTc92Mjitts9YDAu6IinsbVcEQXoDjAIwDLxzEwP1To+Uvx
         BhzmMY3A1LFe2q4gKyGIPpVa86NHP2ERswr4Bq4+5DZYN6y0vBSRgjg6DW26KFbRJR5s
         yKnMlm/IWPIwgeEa24zwTdZkp+rXabRXDt+ZIOmDg1V2tvgf42Q7uEfAKAt0hah7XOsh
         qORQ==
X-Gm-Message-State: APjAAAUb0YamIpiHtpwo+xNI/e9IfhFR0Uvdlp6xh9ufkKqJJ5Wm/7r3
        oTUvWNlzJDeu7ibGG6e4koo=
X-Google-Smtp-Source: APXvYqwhskeScbN3PlRV5WGioV7m8na6C9uOu06NxPA0XGOQDZu8uD8Z9XLstMIEvqKe/408Wlp0mQ==
X-Received: by 2002:a7b:c001:: with SMTP id c1mr10891545wmb.49.1560102759724;
        Sun, 09 Jun 2019 10:52:39 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.googlemail.com with ESMTPSA id u2sm2219610wmc.3.2019.06.09.10.52.38
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 10:52:38 -0700 (PDT)
Subject: Re: [GSoC][PATCH 1/3] sequencer: add advice for revert
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>, git@vger.kernel.org
Cc:     newren@gmail.com, t.gummerer@gmail.com
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190608191958.4593-2-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <2007ef79-1791-4f77-f9e4-34c59b4f0c36@gmail.com>
Date:   Sun, 9 Jun 2019 18:52:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190608191958.4593-2-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

Congratulations on your first GSoC patch series!

On 08/06/2019 20:19, Rohit Ashiwal wrote:
> In the case of merge conflicts, while performing a revert, we are
> currently advised to use `git cherry-pick --<sequencer-options>`
> of which --continue is incompatible for continuing the revert.
> Introduce a separate advice message for `git revert`.
> 
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
>  sequencer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sequencer.c b/sequencer.c
> index f88a97fb10..9c561a041b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2655,6 +2655,7 @@ static int create_seq_dir(void)
>  	if (file_exists(git_path_seq_dir())) {
>  		error(_("a cherry-pick or revert is already in progress"));
>  		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
> +		advise(_("or  \"git revert (--continue | --quit | --abort)\""));

I agree that it's a good idea to add advice for revert as well, but it
would be better to call sequencer_get_last_command() to find out if
we're running cherry-pick or revert and tailor the advice appropriately.

Best Wishes

Phillip

>  		return -1;
>  	} else if (mkdir(git_path_seq_dir(), 0777) < 0)
>  		return error_errno(_("could not create sequencer directory '%s'"),
> 

