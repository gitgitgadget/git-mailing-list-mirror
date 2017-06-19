Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D480520401
	for <e@80x24.org>; Mon, 19 Jun 2017 04:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751024AbdFSEce (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 00:32:34 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35340 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdFSEcd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 00:32:33 -0400
Received: by mail-pg0-f65.google.com with SMTP id f127so14013500pgc.2
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 21:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zJkfc+U5WziyV1qwOqwLSS8kA/lO7yeYXYV3+FYEmZA=;
        b=FJQq7/NX5DwafeNw7TSR9ldY8P4w/0x9WGLG9ztMjYGD2YQ8H3YKVukjFlvSZaqnnF
         Grccft+VANo4rLjBmWNTqMzp0fv+iwnKcUIdKZKPTbDk+INJ96RhR/+3Lobx2Sq+GQLq
         CAQi7pqPjSTq0yUfM2bCcZzMpAArfBm/1gPN4kliW0atNYInaM58ZBWR/DztIio2f2h9
         QwAqDcPh7ZdmF28/DDh2/xFz6IDgEDTfLxC59adKTZNAb5H8XV1O8L6aakQaNnxCozWm
         EMzfU+/STZjwEMq/6ki2IYqNJyduha1jvFWjPkBhY2gzHjnDL9EMAp7aq3BJEVn6Ig3f
         dlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zJkfc+U5WziyV1qwOqwLSS8kA/lO7yeYXYV3+FYEmZA=;
        b=hjr7v1ZAd/+kkf8TQWu8JXXpLPoaebncwX/WBtRvpoWWlZHwNLrue6ft5Wuyhb3Spe
         7AbHBLmn+/MIU7TMh5DKLKItZ0IduhI1Se9PJOLzKbodszON73WHBIEt4AVcfh8obqpI
         z0ZOdgpV0KFrIUKPyljLTfCOMWWBcv1iJovXUE7lupcRJFPI/KOUN3E7AaLF9+TR4C5g
         9ZH03/XgQw3tLqOpuGqaRdC99coTfmDBkqhBRDuXMCP2AX0K+htco7mliV2XnI2l3gFk
         /TSg833ogEmmlHZvRwT86+0DpmtmP8AQt1TZhK50aDb0U8k/+sAZV/D0AkIvCt1PN9ye
         z00g==
X-Gm-Message-State: AKS2vOwKowMzd6PU1YhZCmJQft3lPtK+3pEf+dCMONSN8syzcbIXQTe7
        1o51PW5n4izogQ==
X-Received: by 10.98.111.194 with SMTP id k185mr22955863pfc.13.1497846752934;
        Sun, 18 Jun 2017 21:32:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec96:eb20:667b:9e2b])
        by smtp.gmail.com with ESMTPSA id q76sm18360986pfg.117.2017.06.18.21.32.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 18 Jun 2017 21:32:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     avarab@gmail.com, peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH 2/2] Add test for the new status message
References: <20170619024123.5438-1-kaarticsivaraam91196@gmail.com>
        <20170619024412.5861-1-kaarticsivaraam91196@gmail.com>
Date:   Sun, 18 Jun 2017 21:32:31 -0700
In-Reply-To: <20170619024412.5861-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 19 Jun 2017 08:14:12 +0530")
Message-ID: <xmqqh8zcvbq8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> +test_expect_success 'No commits yet should be noted in status output' '
> +       git init initial &&
> +       cd initial &&
> +       git status >output &&
> +       test_i18ngrep "No commits yet" output &&
> +       test_commit initial &&
> +       git status >output &&
> +       test_i18ngrep ! "No commits yet" output &&
> +       test_i18ngrep "nothing.*to commit" output
> +'
> +

Do not "cd" in a test, without being in a subshell.  When other
people in the future want to add new tests to the end of this
script, the new test will end up running in the new subdirectory,
which is not something they should have to worry about.

	git checkout --orphan empty-branch &&
	git status >output &&
	test_i18ngrep "No commits yet" output &&
	...

perhaps?


>  test_done
