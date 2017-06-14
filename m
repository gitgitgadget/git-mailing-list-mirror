Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCC7920282
	for <e@80x24.org>; Wed, 14 Jun 2017 18:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbdFNSXq (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 14:23:46 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33414 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752628AbdFNSXp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 14:23:45 -0400
Received: by mail-pg0-f51.google.com with SMTP id f185so3736247pgc.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 11:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=26buH+qDHm5XTF5nzlORZJwF5lA1/VIn1KDE+/MXCK0=;
        b=cKzFgXZiBB3U8FLCvBao084JXehTTQEblJRS4abBRkE53OVyKuX4TZq1zhNOWcIo8h
         WYoz9TfZbVDv/IAzoUjJNEUMSBof5vD8VCnWGWadcIZ3iTOQAB54BlAIAGZViaVa8oxj
         6K/YHHwLFfTEmwLi4YLM8NeY8pad+IeYQXZhU3yDHev/i3AlqQFTM/CNJPu/IxmYVL0E
         dcJwwuKoxPdSGrzBfTuKYM1nlBS4//hU/cQt0yRg1ggUIvlXYYDkCFbklr1ZM9ptM33R
         9E2JuimRhrgvaln+RVJJxJkOuXbcJN2GdhuH3wuUh8mZhifMEk5yC8jkoZOMgZG8/8YU
         jO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=26buH+qDHm5XTF5nzlORZJwF5lA1/VIn1KDE+/MXCK0=;
        b=prDgR43+BKbKPaXd+7xCchWyrIdhsQklseWgbboSmEQI0zVdm+LUt7JfNYHTCARsNU
         b9nGwdrfrKpx4a7zlbqg2yzC7o4V3aaCWq69U7KuRXFPJoQVoU81NH9bfVdcn5Im8W5D
         Oj7R7AUE/WIfxH0JzFtl0/EOHWGPR5SFpYyjK8Rat5WoR5aWFCZBFwoUh0nejpWX6XhJ
         Mn8p1BpG3mK1R1TTcJBZo11gGHHK853ztldw7aix6X2/NYieND/e1pssDnRINyaY0oLM
         QM+BpJk/g4bkP90baB3gcJHUDAwIiCgJVDDh+bi2wySszP2cQ21FuzMTDJE0AUsGT009
         a3dA==
X-Gm-Message-State: AKS2vOzXEjErd1EqVfm1My3FTHgUsLHAu8iWQKzsRIeFgj0iM/IEmgsd
        d7Fk/mKV1dVWPQ==
X-Received: by 10.84.216.93 with SMTP id f29mr1450852plj.297.1497464624607;
        Wed, 14 Jun 2017 11:23:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9e8:46fc:1af4:4618])
        by smtp.gmail.com with ESMTPSA id o13sm1060070pfa.120.2017.06.14.11.23.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 11:23:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: rs/strbuf-addftime-zZ, was Re: What's cooking in git.git (Jun 2017, #04; Tue, 13)
References: <xmqqshj34ldr.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1706141245520.171564@virtualbox>
Date:   Wed, 14 Jun 2017 11:23:42 -0700
In-Reply-To: <alpine.DEB.2.21.1.1706141245520.171564@virtualbox> (Johannes
        Schindelin's message of "Wed, 14 Jun 2017 12:57:06 +0200 (CEST)")
Message-ID: <xmqqzida2ztd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hold on. Have you tried to build this branch?
>
> -- snip --
>     CC date.o
> date.c:63:36: error: unknown type name ‘timestamp_t’
>  static struct tm *time_to_tm_local(timestamp_t time)
>                                     ^
> date.c: In function ‘show_date’:
> date.c:211:8: error: implicit declaration of function ‘time_to_tm_local’
> [-Werror=implicit-function-declaration]
>    tm = time_to_tm_local(time);
>         ^
> date.c:211:6: error: assignment makes pointer from integer without a cast
> [-Werror=int-conversion]
>    tm = time_to_tm_local(time);
>       ^
> cc1: all warnings being treated as errors
> -- snap --
>
> I would expect this to be rebased *at least* to dddbad728c9 (timestamp_t:
> a new data type for timestamps, 2017-04-26).

Thanks for noticing.

My preference is to use ulong in the commit at the tip by Peff.  We
can do s/ulong/timestamp_t/ in a merge that merges the topic to
newer integration branches that have the timestamp_t topic merged
(e.g. 'master'), as that allows older integration branches
(e.g. 'maint') to have the %z/%Z fix independently.

It would be another valid approach to fork it at b15667bb ("Merge
branch 'js/larger-timestamps'", 2017-05-16) or a commit that appears
later than that one on 'master', and tweak Peff's commit to use
timestamp_t, if we declare that the %z/%Z fix will only be in 2.14
and later and will never go to 'maint'.



