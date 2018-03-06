Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B845D1F404
	for <e@80x24.org>; Tue,  6 Mar 2018 19:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753535AbeCFT54 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 14:57:56 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34695 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeCFT5z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 14:57:55 -0500
Received: by mail-wr0-f174.google.com with SMTP id o8so10698364wra.1
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 11:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BXgGS0rxk6azpys1o8YFOYGfjCYaY8nufKW/vIIi9SE=;
        b=T9IvKa8qb2GGoN+uOfnc5hKBx8iZJ5dSc5cnG0g5vdXEHjCEIF3N7y/jpkXcqBKS7i
         PsnVjRJ38sZk8n15otBnrLb7T3QXkcZU6utWdEo81wuKn8LWP2Tvdeu91S3ANeCaazV/
         x+Hd2VsAfezfjhdZc6lzLMaUYtJns+bfIZPwrjAXZKWaS+gUXR4ihW6q2dEV1Tc49wrh
         eswm0PsnbwyBilAb77YS3UDh7K6VoAfmV54J9J4zEfBJVzlDuhWnOsoAInoRTlUGbJob
         w51Yr+c/1SRmTMQN0M51WbZ5q2nTbZEbbeJroAXdMHsi2hvL5BXI57mxa82AYFP96YyC
         0+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BXgGS0rxk6azpys1o8YFOYGfjCYaY8nufKW/vIIi9SE=;
        b=Wi4g6EwEebbiXLr0Z5bamuAjR71qQGYyzz4G7RAecKTqgo9WqrnNmSfLCBinEhvRoo
         FyHpJvbLKIAV6z2xcFHOZdkX19fmLWuBoNwedLXvlD3/0ToSFGUA/r7nokHv5Q12QaBM
         jsCAF+sO7SX5+tbGSWvcI00DavRkXsJ6/+00KPGZO8cVHHPYE6QaDJbSEC+0prv0neWl
         PxjjVkTbjAQ6qKTdArZnFUTMhpibriIXaABMrdjdjRJdQpRf/S3Tf5I0P18yO5zZhpp6
         k2ArcWnvMg1bMJ7KiCkytT2Yn4aY1xHK57L29Bh7NNinIYPmvpT+qVko44paMA3geM5i
         3ktw==
X-Gm-Message-State: APf1xPCB2ynAmUMSgO1AXJIlE+ohtWle0pOGnscjOerSceVrsUDj1KtN
        3xcisngeGKU/lCCzKx7hwAY=
X-Google-Smtp-Source: AG47ELvoB12kntFoptJCi3R+cU2P0meGcQu2wdR96JHKlei0PJQVskwZe24msSp561uwEzbKOwOs4g==
X-Received: by 10.223.176.228 with SMTP id j33mr16082656wra.67.1520366274177;
        Tue, 06 Mar 2018 11:57:54 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j6sm587198wmg.14.2018.03.06.11.57.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Mar 2018 11:57:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Gustavo Leite <gustavoleite.ti@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 2/3] add -p: allow line selection to be inverted
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
        <20180306101750.18794-1-phillip.wood@talktalk.net>
        <20180306101750.18794-3-phillip.wood@talktalk.net>
Date:   Tue, 06 Mar 2018 11:57:52 -0800
In-Reply-To: <20180306101750.18794-3-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Tue, 6 Mar 2018 10:17:49 +0000")
Message-ID: <xmqq371d3rjz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If the list of lines to be selected begins with '^' select all the
> lines except the ones listed.

There is "# Input that begins with '-'; unchoose" in list_and_choose
helper.  Does it make things inconsistent to use '^' for negation
like this patch does with it?
