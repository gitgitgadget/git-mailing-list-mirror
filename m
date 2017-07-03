Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4C7D201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 22:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbdGCW2F (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 18:28:05 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38018 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbdGCW2E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 18:28:04 -0400
Received: by mail-wm0-f49.google.com with SMTP id f67so67402157wmh.1
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 15:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=bjAU+o1fl+gyh7lBTk+0Lp445RTDy1gwMB5uChIu5n4=;
        b=ARxT2QOczluVMaIHY9KKOUNDZ9a/GseXKn2ufw6EItB+jZ2J3Ni7jmEtXwhdnvRWWY
         gOI8CZc8Y/QNqRGa4kF1bA/5ke5c7hNyaFEwoKWTdxjy6aVCSPuu77k43Q1cRdIfKXgU
         jeB+/ClnzyyicUdJF0xyHAWXNYzkBL6osCXWPIMhuX6bMaMaEEjQ2/t1NInbp08xkzSD
         4b9L/ZAq+vv+xFhRjacVhxQiyaQhZvldFxmqOznz1phYlDmqWHGe8lgAcAxVR3V6w5JX
         rxBME0TO9OoReHjKreUMw2YmDTP9+g9dUHeVnBkAjbG+R5Vj1lCo3mMx4JEVVQq9//kB
         +Qdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=bjAU+o1fl+gyh7lBTk+0Lp445RTDy1gwMB5uChIu5n4=;
        b=YyCgZKZJQI3DYu1g21RlUZ9+4D5KWlKF4Vev9vvOUEpLEEdCY5enEDtGLlgKtUZ6fI
         AHpDG+mhl9A3J1dZ8AAeNBQ/0N94z9zNqMSBTLa6tR5kDOF8vWB7lPmlj1h6kpgOup4A
         gLZz8wKKemhEFM2CfY/PymPtBpLrpPQovU90JKR0deMLb9GadsHFUd9bZyPN6VGb0T+6
         Wm1a25Es/GNSQpTvdbgjPWZzPcSPpAILwDgzGQEf13zfk8c3BySNvr3z9M/925VnBqnF
         lfJduReJtCIzOdt4kbmJCImxs8r45ZKSgu3MRAPkRdZxOVequTap74/heAsVdzbnkAdh
         zHQA==
X-Gm-Message-State: AIVw111dICYhW70SV0dqNe9d38yYs2mjWwGmsyJPDgMB2cDo6eW+wkpx
        TJsszetpEhon1Q==
X-Received: by 10.28.19.11 with SMTP id 11mr5660294wmt.123.1499120882404;
        Mon, 03 Jul 2017 15:28:02 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id j190sm8459868wmd.22.2017.07.03.15.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jul 2017 15:28:01 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dS9p2-0005rv-S7; Tue, 04 Jul 2017 00:28:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Francesco Mazzoli <f@mazzo.li>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] push: add config option to --force-with-lease by default.
References: <1499116727-757-1-git-send-email-f@mazzo.li> <87y3s5b204.fsf@gmail.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <87y3s5b204.fsf@gmail.com>
Date:   Tue, 04 Jul 2017 00:28:00 +0200
Message-ID: <87wp7pb1fz.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 03 2017, Ævar Arnfjörð Bjarmason jotted:

> On Mon, Jul 03 2017, Francesco Mazzoli jotted:
>
> A couple of things I didn't notice at first:

Oh and also, makes sense to add tests for this, see
t/t5533-push-cas.sh. I.e. just make sure the cases where the option
works work with the config, and that the option overrides the config
etc.

>>  	git_config(git_push_config, &flags);
>> +	if (push_always_force_with_lease) {
>> +		cas.use_tracking_for_rest = 1;
>> +	}
>
> This should go in git_push_config.
>
>> +	if (!strcmp(var, "push.alwaysforcewithlease")) {
>> +		push_always_force_with_lease = git_config_bool(var, value);
>> +		return 0;
>> +	}
>
> [As you noted on IRC] --force-with-lease takes args, but yours
> doesn't. Arguably this makes no sense whatsoever to have in the config,
> but something worth pointing out in the commit message.
>
> We could make the config accept args, you'd call
> parse_push_cas_option(), but should we? I don't know.
>
> Should this also apply to send-pack's --force-with-lease? Under the same
> option name or send-pack.forceWithLease? I also don't know...
