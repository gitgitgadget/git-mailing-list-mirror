Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE85A1F621
	for <e@80x24.org>; Wed, 27 Jul 2016 20:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757964AbcG0UCE (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 16:02:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34790 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757475AbcG0UCC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 16:02:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so8034545wma.1
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 13:02:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=A57xG3X0A35MU0OO42Xuekf4Yvw8ymI52O26Zs8yndM=;
        b=TXvghTPLRFmo7fyNW8gyuBdb5soZ3qAzMnrrc8b86nQbEnqY746h362lChAP6KXz/E
         bZRj1glmBjX25vzWbQhHISq/Qxz/SVLGs4gP4Jocj6ex7WO2/pk85yu9O6jBamcabPgx
         8Ot1K+dPsc3+gQ4RXcyGCg9Uxn2XUmk51oVZh2MSj3gAmrXjSfRkTtZZkHzwtr23FrUx
         spczutAz+UvxBcNLG5wMnam0bzqgR7vSyhy5vHZBoLbDiZL5ATXggDrSY8ap2iIlH5vx
         4Bjg1wOs0voEy0af7oiPc8DzSRVjXdlEYGKW/LYH6XQIdYr1CROYw4HTXxPWR+reYzKX
         tadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=A57xG3X0A35MU0OO42Xuekf4Yvw8ymI52O26Zs8yndM=;
        b=l2xwvBtYchS+zkCkwj2kr8e6w6eVEP3w7kQw56Rd9QVO1oZaaHbYHw5aXMjKWZg7JP
         ooK4dM4croqxcMIo+61EL4nq9BgyxqfDkrJq2XWcl2j608Vm5IDIAHGW5rTxAKRM5PWO
         yb+pqnYnIMSJWU5bSWwp2np13lFxZK3kj6Jkcjd5zVgIWvA6ZtcyzbwlGXH0MCAAdCC+
         7XyHfsXQJy43OcLTht8WY2n5lP44K6QCDirujokssdGwDs1ZO6tvuuUxnhFrxxDUH9y3
         VFRFt2yUR3wJk5KWHgNMG9QAAJKH0PVHaA8AAA2K49zNeBieS21RlkiKrgvP64OGXb9g
         Zd/w==
X-Gm-Message-State: AEkoouufVj2a6mUb5X/pJw8GAMsLEFqbd6lKdHtTSUtVSl9cD25FarMBpOx7VVUoY3OO0Q==
X-Received: by 10.194.142.198 with SMTP id ry6mr29179148wjb.62.1469649720646;
        Wed, 27 Jul 2016 13:02:00 -0700 (PDT)
Received: from [192.168.1.26] (epw206.neoplus.adsl.tpnet.pl. [83.20.64.206])
        by smtp.googlemail.com with ESMTPSA id c16sm8694850wme.4.2016.07.27.13.01.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jul 2016 13:01:59 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] convert: quote filter names in error messages
To:	larsxschneider@gmail.com, git@vger.kernel.org
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160727000605.49982-1-larsxschneider@gmail.com>
 <20160727000605.49982-2-larsxschneider@gmail.com>
Cc:	gitster@pobox.com, tboegi@web.de, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	e@80x24.org, ramsay@ramsayjones.plus.com, peff@peff.net
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <57991329.1000709@gmail.com>
Date:	Wed, 27 Jul 2016 22:01:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20160727000605.49982-2-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-27 o 02:06, larsxschneider@gmail.com pisze:

> Git filter with spaces (e.g. `filter.sh foo`) are hard to read in
> error messages. Quote them to improve the readability.

This is not something very important, but the above commit message
feels a bit clunky to me.  The change is easy to understand, though,
so the commit message style is not that important.

Perhaps "Git filter driver command with spaces"?

Well, nevermind; if you have a better idea, good.  If not, it is
good enough, IMHO.
-- 
Jakub Narębski
