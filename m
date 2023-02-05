Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC4AC636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 14:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBEO2W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 09:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBEO2U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 09:28:20 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BAD15C9B
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 06:28:19 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so7027062wms.1
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 06:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWs3QQNqhnRFtMeJ0ZKL+HSBEektW9XOxdbODwoA9BQ=;
        b=V0dS9skqYNCJIs+Sdv/8j7OKjfBAMUDpkrXQB6W1f/aGw+Mg14RuPSvdrIOxWXz7w4
         QkKkKqOWMTa7V5F52ais8npaWr6WTgVAFB1G2MNg9dmHQFBAn3ljwsgSOesL4EHp9wsP
         IxrGI8Zf/CCRPEtAkVoi2nRfOdF8/0U8yHYv2jQEa3RB4+B6JyhdMPeL83Xik8xNGVO8
         mfOwKav4RLEX+Kk8YDaB6TTOyY8w3yNWQkcZz7StQ/SwMZEMPaW12rnLQrGiipmPGr4S
         eezE1+pejniAWEYEvpXGEHmSf1vYUsXn2fvMReio8008IoPzzmZeBCNuE+AeSCcGWU5L
         MXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWs3QQNqhnRFtMeJ0ZKL+HSBEektW9XOxdbODwoA9BQ=;
        b=nUT58Bgci9OtDJpj6cH7w9VbRJQMGeXKwso2l9414hGUMufQPfVQRgHY5ALf22yB2U
         whFSAtiCEDqncsCVq7gz0g1kyXmQLazoE8UjZu/f3CX4SFfiXH2Pld3LmoZKgP4JVsbB
         oZDXDEfVWKFHfAucBHPlBjzo/oT2Q2LspWWXaBc705UOoSpKpGM0C6JfAF9h7mxzB2We
         B23I7a2yf8OYyZ4InZAy2ZC/7nw2GmridQFbGzyiBx0ABtBGNCCTCJA52ifFh+3sxQjE
         W7ULwWiO4zyU5TAnLFT6q7P7yIp+YjBdF2bQVFwk7IwWLuCnlnLEdg2aGCzmzbkQ1EE3
         sgBQ==
X-Gm-Message-State: AO0yUKV4kp10RntdPGNjo5WiJGhMSGLBN9FNIDu+65e/VyMi2XB5W/UZ
        r6Rmis1wzTXBQx9Jg7s/tNibOcXFldIJfQont8T/qYL4PUB7EQ==
X-Google-Smtp-Source: AK7set+sq7YN8FgHjHGGukRcFRYi3GWGXa39EY0pQ2M6tiHTc03wqYqbuwkE2+4Y5vI0YEMhpCeGxj1zMkOxkfSO+3M=
X-Received: by 2002:a05:600c:1d03:b0:3da:f956:1ada with SMTP id
 l3-20020a05600c1d0300b003daf9561adamr543711wms.177.1675607297627; Sun, 05 Feb
 2023 06:28:17 -0800 (PST)
MIME-Version: 1.0
References: <20230131224929.2018546-1-cheskaqiqi@gmail.com>
 <20230202171821.10508-1-cheskaqiqi@gmail.com> <20230202171821.10508-2-cheskaqiqi@gmail.com>
 <xmqq1qn7u6if.fsf@gitster.g>
In-Reply-To: <xmqq1qn7u6if.fsf@gitster.g>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Sun, 5 Feb 2023 09:28:05 -0500
Message-ID: <CAMO4yUEyYNHfvB7Tp1_=EKh7jqESvHKJ3YL5EuYEj1qQ23swfQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4]t4113: replace backslash with single quote
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Feb 2, 2023 at 4:00 PM Junio C Hamano <gitster@pobox.com> wrote:

> is almost impossible to understand without knowing that this wanted
> to say what Andrei gave in a different way.  The title is worse.
> It's not replacing a backslash with a single quote, which would
> result in
>
>     -test_expect_success setup \
>     +test_expect_success setup '
>         'git update-index --add file'
>
> and obviously that is not what you did (or wanted to do).

Thanks, I will modify it to make it clear about my motivation and the
real changes to my patch.
