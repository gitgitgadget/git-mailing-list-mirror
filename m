Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E0281F404
	for <e@80x24.org>; Sun,  4 Mar 2018 02:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751819AbeCDCM4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 21:12:56 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:41307 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbeCDCMz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 21:12:55 -0500
Received: by mail-qk0-f174.google.com with SMTP id w142so16705807qkb.8
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 18:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/aYYy/oKeyFzleVzD35mjOPo8YXMcDNdmFOsX7VP1Tk=;
        b=LxZfwIC3fP9OX/m5UBijpii1ey5d9dT/zIzrTrdFdCJ1V9roJpHsvTGllC7fC+nbXF
         26SYmq5s+4G2LhMw1sTrYTtPTaB6HPcnII38vSTuS+NBCrWKtCCVb/g8LUTKBK1ylQQf
         euqauBMREPYt57LphC5Q7F3kqSoSQ7Asqf/DnDCPFbEfwbrA4jUDnwfYasQeYj3nq5iv
         C5zU6jmPKDOUIucO6CIDmAzaKBgQf5PpJ9ztVZ9p4UHpe7dahhmvpX15UWQSEnpdbSnq
         xwcwELm3yspIVbLTQADNa6bV7f6NkoA4jOcHETFj4+m/yhdTVEYCldhzPjuWblXRd4NR
         Y8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/aYYy/oKeyFzleVzD35mjOPo8YXMcDNdmFOsX7VP1Tk=;
        b=EpSrrDvuhPVlr0fhqDsJs/O5ArEtaehzUqSF3YimiVe7eVY3AkpTg74yNKpAnoDK06
         VtJ6ewM3V8Qhfojed69Ez+Fya4YAK26ZbVCDQvJ0HxdC+Hss8MFZqZTxONr76f24sGlP
         L2OMDH0DOR0guvF+g6Dg6PocTc42PZ7H/xTw2GVPCVY/wRa3dyIcMrtXdpyqla+4BhI9
         FKcVx+9pXfnVGF/FctAL+T+G3TtpadT16m0UiIEFieCIHx8IVqEe4yw/M/JeGQS2lwwT
         zM4Q0TjlksQ49r6P5Vqb0CLdR68yLeQ7F4rEon+E0jCSNFirrLX+5t+QFOTWlmljhqjT
         NSXw==
X-Gm-Message-State: AElRT7GWrhzLj0YbRPzEKJs6l3c6Id2YxGYJxH4u1l1YDcCsYeZgxvqB
        QSxhwi7kr4sNIpjUKvRm9Fe+rXnIbWEUcMgbVDY=
X-Google-Smtp-Source: AG47ELsECApFzA53nVb5DuLTnc9XZPUBeZ1Wf9LW3m6KVKMf0OOFCrE6Cf4qF8XEBAY9v2cPHtqPlAP5Eq9SRttnQL0=
X-Received: by 10.55.134.133 with SMTP id i127mr15850387qkd.275.1520129574419;
 Sat, 03 Mar 2018 18:12:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sat, 3 Mar 2018 18:12:53 -0800 (PST)
In-Reply-To: <CAE09B1+XXJvrOucHwehUGk=Taio7sirfOh5gq7KGs4iZSpK=vQ@mail.gmail.com>
References: <20180303034803.21589-1-dorabpatel@gmail.com> <CAPig+cR=adC_Ok=FJw2APaLahXX_v1ix4ufEJyBhED5ruXaQxA@mail.gmail.com>
 <CAE09B1+XXJvrOucHwehUGk=Taio7sirfOh5gq7KGs4iZSpK=vQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Mar 2018 21:12:53 -0500
X-Google-Sender-Auth: toujMhhOL1s_EjYnSouu5ZWeqfI
Message-ID: <CAPig+cTyZAFx486Y9LrQuaK0qMnQEGD3U55sk9Vvyb_TgDz5tQ@mail.gmail.com>
Subject: Re: [PATCH] git.el: handle default excludesfile properly
To:     Dorab Patel <dorabpatel@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexandre Julliard <julliard@winehq.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 3, 2018 at 8:36 PM, Dorab Patel <dorabpatel@gmail.com> wrote:
> Correct me if I'm wrong, but my understanding, from
> https://git-scm.com/docs/gitignore, is that $HOME/.gitignore is used
> only if it is specified as the value of core.excludesfile in
> ~/.gitconfig. It is not used by default. If that is so, then the
> proposed (and original) code works. The changes I am proposing handle
> the default case, when core.excludesfile is not specified.

You're right. I must have set core.excludesfile so long ago that I
forgot about it and assumed $HOME/.gitignore was consulted by default.

> Looking deeper into how the function git-get-exclude-files is used, I
> see that it is only being called from git-run-ls-files-with-excludes.
> So, perhaps, a better (or additional) fix might be to add the
> parameter "--exclude-standard" in the call to git-run-ls-files from
> within git-run-ls-files-with-excludes. And remove the need for
> get-get-exclude-files altogether.  Presumably, "--exclude-standard"
> handles the default case with/without XDG_CONFIG_HOME correctly. The
> question I'd have then is: why didn't the original author use that
> option? Either I'm missing something? Or the option was added later,
> after the original code was written? Or something else?

Using --exclude-standard rather than --exclude-from and retiring
git-get-exclude-files() makes sense to me.

As for why the original author didn't use --exclude-standard, project
history tells us that. In particular, git-get-exclude-files() was
implemented by 274e13e0e9 (git.el: Take into account the
core.excludesfile config option., 2007-07-31), whereas
--exclude-standard was introduced by 8e7b07c8a7 (git-ls-files: add
--exclude-standard, 2007-11-15), three and a half months later.

If you do re-roll to use --exclude-standard, then it would be good for
your commit message to explain this history, citing the relevant
commits.

Thanks.
