Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5388220188
	for <e@80x24.org>; Thu, 11 May 2017 00:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbdEKAVo (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 20:21:44 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36309 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbdEKAVn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 20:21:43 -0400
Received: by mail-pg0-f66.google.com with SMTP id 64so1330300pgb.3
        for <git@vger.kernel.org>; Wed, 10 May 2017 17:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=o+vWTCIK0Ky5zZo3wF3LjL7WL60/u4bB6rguMfLrOro=;
        b=m/+C2c5/byUIki76ptXe7TgAXxVos1UgFY6PZGIrw2cBslOvHX5vGhFNTwJETMd67q
         hpBVH0lNxWfKE8omCDsTEPRnL92M9JpH4C6RSl1i5d1EaI+HyG/fWq4tH/M1mYT5za+D
         hR1BZqMlfKcK9hGdPAJKAM09q2bVBjX0Ef3VkETQvWWiHB9jMck/T5APEeFu00RPqMdF
         d7mBPOKhSvExaV48W1906+/+Ase+gmoQlOdumJWJuLSmGjcQHRuVwF2fNgkBvgk5GJKF
         3DnaCxwcB5A8LjuahIgZKO7QfXGaRNJ2wB/+jSkTVNBmCUhWfKubcMlug8+0/rlk5RRi
         194A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=o+vWTCIK0Ky5zZo3wF3LjL7WL60/u4bB6rguMfLrOro=;
        b=FMN6J0gHKdHxGTikrF6yLg8zFEXyx7pXrziGM4z+RgqJhCjm0e+1TesoSyWGf4ksXG
         dxjpQX01mJLjMLy0KkIItAA5mKsXuYtiOv9TvpvHB5IYBsUi9K+fbkxq3pt58z1sfXTb
         NatqDmTy+GgMd2LtEIuBEHLQMZiAnw/J36yaJVP4v/UZbRfXf5efty9GZHnePlC/QR+0
         GAWN7tpew+J96xUkYOus9iReEYTPZh+Cay3tX15D38glZxXKpQaoqe+7jf30ZR872wcr
         DbvSreuzp/F/sGw4ci3hn5aTv1D/x2rwuY+86OF1ufg4YI1lmgNxGKPfGZhir/jcm0y1
         pjdA==
X-Gm-Message-State: AODbwcB7rT6CGREKPFH9kAX9laM+or8OY4uUlzawTqOLoHQPonN1JXox
        +Z0+4mkZfsKUeA==
X-Received: by 10.98.193.129 with SMTP id i123mr9124594pfg.203.1494462102528;
        Wed, 10 May 2017 17:21:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4994:7ba7:e883:c475])
        by smtp.gmail.com with ESMTPSA id g20sm100139pfk.21.2017.05.10.17.21.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 17:21:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Subject: Re: t6134 test failure in 'pu'
References: <361a3331-4d48-9ad3-42d4-3bf4b97dca22@ramsayjones.plus.com>
Date:   Thu, 11 May 2017 09:21:40 +0900
In-Reply-To: <361a3331-4d48-9ad3-42d4-3bf4b97dca22@ramsayjones.plus.com>
        (Ramsay Jones's message of "Wed, 10 May 2017 17:14:32 +0100")
Message-ID: <xmqqwp9ow8dn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for a quick report.  Yes, that was a stupid mismerge.

Will correct in my rerere database X-<.
