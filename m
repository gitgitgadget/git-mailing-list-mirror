Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0613C202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 17:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbdGER0v (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 13:26:51 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34196 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbdGER0u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 13:26:50 -0400
Received: by mail-pg0-f54.google.com with SMTP id t186so128109894pgb.1
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 10:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=jfFFGGB4D7vf6DcsDTN9a/wxOX9BV+GHqZ/4tjBDbOM=;
        b=Mf/2IFnBO4anRdVUIs/22eohvEz0PC14FfV5A69+sybQSjwAtagscU9eBgNq3oXowd
         ZCQD0mwyrJxRYbd54yyORM0aCk6GvQgVJWxB8VmcQM+j+QtaqcdzsMo4W6n66l56/1K8
         WQJYy/DLQm2zdyytXOj1cyRJPW7Rd2kcH7Iold3MN8tpBz6ZMzRWhKyEkby6xumJkXOy
         GShmnPuDSe+AGwjb8jksHM7NYhKgr+kLLJDJGWXo1/3K4Er7Z0xZCWSFJMBUy30JA/EC
         cqs2M0D2luTNJ0U6bf4f3hMUfQWV4FxwKrf8gzVKyQ5ZelreDhWh9xNewVzKU+d+8e9N
         AhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=jfFFGGB4D7vf6DcsDTN9a/wxOX9BV+GHqZ/4tjBDbOM=;
        b=tkdu+9puxvZuz/kyX+KAeOT51beduJYm2kbbhxdBHXNO6qpDIbi7lFywNBJxDzMg3O
         fdEqz8qq7mOLzftBWE/wlCpzFn0BUGaI9bnX8HrHf5eGM9amoZTXCJQs0GV5elVfeigK
         fXSbJyjOxS7Ct8q1p8dKfiS7bvIYHJ8YKr4AVtxnGndRmRpS+VlJg3k8Q6D+Yg1OBJnK
         FSSEgS1JoPhs7uluVujiwiWAOwWWBcoWyE+3GmNeJr/cHkOT9fP65KvLvgSeCDGYT2oA
         V5JgnnVb/9tKA2Mfb774SVyVqVhty6GOwErxA7zhY4EeOV0kDQ7tFV9phD+iKrxiFA/T
         cNsQ==
X-Gm-Message-State: AIVw112knkTgFviQuidtJqy27BFRdYDHLxzTtWJ0jJhcUxVO7RWtrVlr
        ede7r6FVKMVgTQ==
X-Received: by 10.99.186.13 with SMTP id k13mr22463871pgf.0.1499275609457;
        Wed, 05 Jul 2017 10:26:49 -0700 (PDT)
Received: from unique-pc ([117.209.172.103])
        by smtp.googlemail.com with ESMTPSA id t4sm30755810pgs.22.2017.07.05.10.26.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jul 2017 10:26:48 -0700 (PDT)
Message-ID: <1499275601.16389.6.camel@gmail.com>
Subject: Re: Requesting suggestions for a good sample "prepare-commit-msg"
 hook
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Wed, 05 Jul 2017 22:56:41 +0530
In-Reply-To: <xmqqwp7miztv.fsf@gitster.mtv.corp.google.com>
References: <1499273152.16389.2.camel@gmail.com>
         <xmqqwp7miztv.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-07-05 at 10:00 -0700, Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
> 
> > So, we're searching for scripts that
> > could both be  helpful to users and could serve as a good sample to
> > prove what could be done using the hooks.
> 
> I am not so sure that we are searching for them, to be honest (who
> are we in this context anyway?)
I think I misinterpreted your sentence in one of the other mails (found
below),

    That sounds like a sample that is there not because it would be
    useful, but because we couldn't think of any useful example.


> This sounds like a solution looking for a problem to me.  The
> simplest option may be to remove the sample hook---perhaps it
> outlived its usefulness.
Removing it is going to be done for sure. I thought it would be even
better to replace it for the reasons I specified previously. Anyways,
in case the last path I sent[1] seems not to be useful and not other
interesting alternatives turn up in this thread then the "simplest
option" has to be chosen.


[1]: http://public-inbox.org/git/20170705165114.20662-1-kaarticsivaraam91196@gmail.com/raw

-- 
Kaartic
