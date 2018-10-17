Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2291F453
	for <e@80x24.org>; Wed, 17 Oct 2018 13:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeJQU7w (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 16:59:52 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42105 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbeJQU7w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 16:59:52 -0400
Received: by mail-vs1-f67.google.com with SMTP id e126so20688369vsc.9
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 06:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=S8uWggcrBZvrn2rUt7/uU2YSN70m1IGWO9pvEhPEzxc=;
        b=Uq46WwZl5nN9dmjCh5yNZMKN7b1UZdeSobKSRryRQr5PA+joXeIx5oxV7woTsCWAgQ
         lgrg+pKwO89hPuubhQ9kaPy0QnaqT2cug1JFdLCJ3zF6KBd6JUB3QNWpTGmO5rRUK9jP
         W3AQw40cMxIsLteVbiNQ3booCowipUJBBXd3u1yvj1BWoQCo03DYzb9tNe5gQBMeOkd8
         RUL700iWATD3QTbcaUomoBRQELUkAQ0147UNmUoynbW9AwI1f7S55KW2Ol7JZ1GnMD/0
         CeqRj5BOM72x+iVgX+ZgzVNjE5+tN8dUMxIToCf8OIkV377n9d1L49ANEZvm2I0qrq1Q
         xJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=S8uWggcrBZvrn2rUt7/uU2YSN70m1IGWO9pvEhPEzxc=;
        b=GsXBovjVNsuBcNgthKdi7NsdANmC0k6mKXop2/fgZaFb6R2XIEaAM1OFQrdSTVjLXl
         mcgeINkZMT+PmmlxwtWqrwRNLobwqS8yt/sX2nJVUcBF5E8FiaRtZICHj1IfybZmraXx
         lrqclWgyFIeQgLRp/2t6HtSWj9zb+F3AyvTz146T/HwBaOy4xypor8TebvASxTrGM8qm
         VJ+BJmK+TgZCfqNdOuMwDIaoF6HL1eIHBUCrw4CuDUVdS0dbBPK2fLeo1Zb4eglxaJby
         uZPVRH+foOjkYq65H/pWCvA+DmSHKQEwzRGZ5Xsf6VbvPJsziC0DNeMXTDSvgrnbIKFW
         hVPg==
X-Gm-Message-State: ABuFfoi4JmHvbUiYPwMuQFkYFURRmLj3eY33XcsRzY3MLmwa5GAz6Sjd
        PCah2QoOr+/2XP5EdkLmusE=
X-Google-Smtp-Source: ACcGV60M0+QKpbt81c/6wI8ESsl7JzQ6l7iBpDzs2SM1GOwTLaYk6qssE7cX053v1s8IMbXg4SN0RQ==
X-Received: by 2002:a67:9858:: with SMTP id a85mr10426590vse.163.1539781455077;
        Wed, 17 Oct 2018 06:04:15 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:8586:348a:8c9:d17b? ([2001:4898:8010:0:6ebc:348a:8c9:d17b])
        by smtp.gmail.com with ESMTPSA id j71-v6sm3361251vkj.38.2018.10.17.06.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 06:04:14 -0700 (PDT)
Subject: Re: [PATCH 0/1] Run GIT_TEST_COMMIT_GRAPH and
 GIT_TEST_MULTI_PACK_INDEX during CI
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.49.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d0a90195-5e13-8c12-f04e-ae0705a512b7@gmail.com>
Date:   Wed, 17 Oct 2018 09:04:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <pull.49.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/17/2018 9:00 AM, Derrick Stolee via GitGitGadget wrote:
> [1] https://git.visualstudio.com/git/_build?definitionId=4
Newlines are hard. Sorry for the formatting issues when translating from 
a PR description.
> Build definition
> that tests Git with different arrangements of GIT_TEST_* variables.
Thanks,
-Stolee
