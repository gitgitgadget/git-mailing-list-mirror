Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD9D91FAAD
	for <e@80x24.org>; Thu,  2 Feb 2017 17:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbdBBRFC (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 12:05:02 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32771 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbdBBRFB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 12:05:01 -0500
Received: by mail-pg0-f68.google.com with SMTP id 194so2305447pgd.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 09:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ce+mpkGLzOlDN4q6TeQHi8Rf8tkZhKjZuzCMQ7+lb6w=;
        b=tuBQvXK79FTQ2X9j712xqCk2nbJaE09kOTUAUtRSnoh3uwl7id9258aPtjcZg/7PBz
         uWAFcswQR92XiEYQy5jRVTkQgU420TvFMQhvqTOnq+/glrE/Kf/zSu7T1jsl0GFzSeld
         povhFVIK4DQJN1zxhzrooKSF1IpSCr1LNL9DTY6ZEO/RwcfSWxjYAN842iqLS5vBxCKt
         VuHro/9uF14xnHtAhUMJpUai19Crg8Xyo18vtdY9VzNG0HthmdxPPg2fAokzAdrmpcyG
         pHeL+bT8N0XY+P+E7yWw3AwlxgcPNfTY7utWcs4/rSwz6wKMe9sYnqHdFpamYRtiAkZp
         Bsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ce+mpkGLzOlDN4q6TeQHi8Rf8tkZhKjZuzCMQ7+lb6w=;
        b=b48jUokxicfkedVGXz7KK9Q/IQ8TN8BB2Qete5V6Sr/1Mvl34j+hiW7+Mm5ESs1v8V
         MMeFmN8dbrX9nKsj2S4PrXhGAz204uZrD/jXYmtb+JbiRPb/oPcAEN4sVTY6uEpj5NFm
         ixYbtxECGdP0ZwjHN5TuT6YFsDj+VHwg+Ml0A0oIfd72KLUptwYSfe7r+xt57MZSgWRM
         yWR5PbRpoTki7Seookf/9WFm7/kQXWIbRcEw5WPlCIMa7wBdMpKCudgeJEKEblAq4mPj
         r/4WrwguUrRjl8x3Kdg769s0c5hY7j9JXrbRQhtoXWv/S90UrLffnA/lDUY2L28jLmKo
         H/Ew==
X-Gm-Message-State: AIkVDXLj+JJew9bKKm723edyv+vKD8okRf1C8y2wzRID7kyRlqDE8FBWN0N8MoTs8rV4Ew==
X-Received: by 10.99.53.195 with SMTP id c186mr11614933pga.24.1486054659086;
        Thu, 02 Feb 2017 08:57:39 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a474:f273:b947:baf6])
        by smtp.gmail.com with ESMTPSA id r21sm59844535pfd.95.2017.02.02.08.57.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 08:57:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        bitte.keine.werbung.einwerfen@googlemail.com,
        thomas.braun@virtuell-zuhause.de, john@keeping.me.uk,
        git@vger.kernel.org
Subject: Re: [PATCH 4/7] completion: teach ls-remote to complete options
References: <20170202014014.25878-1-szeder.dev@gmail.com>
        <603697da-c8e9-5644-e0f0-7ee265c069d8@tngtech.com>
Date:   Thu, 02 Feb 2017 08:57:37 -0800
In-Reply-To: <603697da-c8e9-5644-e0f0-7ee265c069d8@tngtech.com> (Cornelius
        Weig's message of "Thu, 2 Feb 2017 10:40:53 +0100")
Message-ID: <xmqqwpd8leda.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cornelius Weig <cornelius.weig@tngtech.com> writes:

> On 02/02/2017 02:40 AM, SZEDER Gábor wrote:
>> 
>>> ls-remote needs to complete remote names and its own options.
>> 
>> And refnames, too.
>
> Yes, right. However, do you think it is reasonable to complete remote
> refnames? I don't think so, because it would mean we would have to run
> ls-remote during completion -- and waiting for ls-remote could be quite
> lengthy.

... and by the time the completion script knew what they are, we
have all information necessary without actually having the user run
the command ;-)  That does sound backwards.

I am however not sure what Szeder really meant by "refnames".  For
example, you may want to see that this

	$ git ls-remote origin mast<TAG>

peek into refs/remotes/origin/* and find those matching, i.e. most
likely "master", and that can be done without talking to the remote
side.  It won't catch the case where the remote end added a new
branch that also match, e.g. "mastiff", and it will actively harm
the users by giving the impression that Git (collectively, even
though from technical point of view, what the completion script does
is not part of Git) told them that there is no such new branch they
need to worry about.

So probably even with the "peek local" optimization, I have a feeling
that completion of refnames may not be such a good idea.
