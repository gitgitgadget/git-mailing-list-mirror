Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EBAC1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 21:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeCYVPE (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 17:15:04 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:52392 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751142AbeCYVPD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 17:15:03 -0400
Received: by mail-wm0-f41.google.com with SMTP id l9so11946884wmh.2
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 14:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=swcl/hzHFUzkYIRCAGkQJqjL9wWVMRG+M+Hdxz3E/8E=;
        b=A+2Np4YVNqBsfUIuAoPJTyZ4PwoydISAnV7kt1lq12+k+/DV+p82kGds3zcpQ7Lufa
         tL89cHSBAHP5QHx2Shw0coTRbFYbNzZUksN32bKKO1mEWbn8X3AeIy8Fpyc9Bj7ktSG9
         VxGaFzuSlp3kZCR/xeON9oaEIeSLI/lQkw6UHRjLEgIRtIuW3ll26mzojO7OGjFcaBz6
         5AyCdCdXsVDqVOizOChrvxEq2eCVZMQBF0cMe875LBoWJBjdUe0eySgx1ZEpMgaGAaeq
         C7cw4NpnNURMHUJ7G7yJ3caqvZ0B03Kxnlb8jsgAR9uTF+W0eAat/4zA7w3GzLyMYEkH
         8w3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=swcl/hzHFUzkYIRCAGkQJqjL9wWVMRG+M+Hdxz3E/8E=;
        b=hxUiYbcWNXTaFNepnXwv1Ofj5rs1kNw3XA///49T796VrjwUg82LJMtEbQ/vNfpLPB
         pItJ52Ukc7vtS0M6YZ80lJ3a+Cz4cWiPHvjqiCz93+h0F/Yb+XmSi6aD75EGP02qEmbK
         zz6mJYOlE0KWJ/5uGNSy1RfW5FmT8Eq2EwbO1JUvGI0dG8+JLCvcxxDMuOmqgdAz2+gG
         8nF0k8/W0UfCxv2adHt/0O0d379EjI3NnVt9C78HqlBkpQMlCB7hpayfnlb4LHoCoKKP
         HvSwO9Tgz8kgiYvGynt8290ymT4wZQO1TNw59QrXz8bsdTl1nQXrKs+Pg+AJJdXDcf+x
         DD/g==
X-Gm-Message-State: AElRT7HADRWuxa4ETILeIFFPVUidWM26Lw4JGeMP5V3E/cE31bUiHMij
        F4DXOI26/U40QSnQjr1966A=
X-Google-Smtp-Source: AG47ELsQr+jyqp/Qtf3rN06jqz1+AriciYd73bB4dmSm4MQ8gQw9oSbj2q70+AbPkj8r42nG93/79w==
X-Received: by 10.80.134.50 with SMTP id o47mr37899410edo.243.1522012502447;
        Sun, 25 Mar 2018 14:15:02 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id a10sm9509207eda.71.2018.03.25.14.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 14:15:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dan Jacques <dnj@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v7 0/3] RUNTIME_PREFIX relocatable Git
References: <20180325205120.17730-1-dnj@google.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180325205120.17730-1-dnj@google.com>
Date:   Sun, 25 Mar 2018 23:15:00 +0200
Message-ID: <877epzyi0b.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 25 2018, Dan Jacques wrote:

> This patch set expands support for the RUNTIME_PREFIX configuration flag,
> currently only used on Windows builds, to include Linux, Darwin, and
> FreeBSD. When Git is built with RUNTIME_PREFIX enabled, it resolves its
> ancillary paths relative to the runtime location of its executable
> rather than hard-coding them at compile-time, allowing a Git
> installation to be deployed to a path other than the one in which it
> was built/installed.
>
> Note that RUNTIME_PREFIX is not currently used outside of Windows.
> This patch set should not have an impact on default Git builds.
>
> This is a minor update based on comments from the v6 series. If all's
> well, I'm hoping this set is good to go.

This looks good to me this time around, couple of small nits (maybe
Junio can amend while queuing):

 * You add a dependnecy typo in 2/3 but fix it again in 3/3. Should be
   squashed.

 * s/\Q${gitexecdir_relative}\E$// in 2/3 can be done less verbosely as
   s/\Q$gitexecdir_relative\E$//. Discussed before in
   https://public-inbox.org/git/CAD1RUU-3Q_SYvJorU+vEY2-0CPMZ1eL-41Z6eL7Sq4USiJ0U+w@mail.gmail.com/
   seems like something you just forgot about.
