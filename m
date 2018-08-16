Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E62D31F404
	for <e@80x24.org>; Thu, 16 Aug 2018 12:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeHPPOi (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 11:14:38 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:51141 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeHPPOi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 11:14:38 -0400
Received: by mail-wm0-f51.google.com with SMTP id s12-v6so4265968wmc.0
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 05:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=G2ilkee+2ysDF8M9id3CWan5EPKlPDGLWH5ErTjwFJU=;
        b=PRzktEq6/DMTXJAWdny6Wlaa6Axs+EKUTXCfJUDQt1kXLmFDrCf36p4uo5CmErtIs9
         JM68wXajCo/FaG9swmIzeLAmZYGuespI2dZG8IDlzblMuZoQ1iR/loxMQhOHuFVeYG6C
         /KN/MeevljfEqxo6husT+2TUzbvUQmk5MjdzGU4QVuYIciEfDMojH6+uwUpdAgD4Wiir
         7W1Rt+8RijPe5oea0xZSKN6W/M/N7kPo7XY+gQ6Q41x0QwQyFWnqhXh5YvfasispejBR
         JkSeP7LNFRfYoIcYim1mlkSWXhN6GokI0asy6YhSsy/LyxwoKLw1ornclWMKnWeu2lPi
         v5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=G2ilkee+2ysDF8M9id3CWan5EPKlPDGLWH5ErTjwFJU=;
        b=cIfFx6riZnyCJwU05mOgvZs9l1R3H+rRLiaB7tVpAPaUEsUOUB/RhyFr2ssWrnCdlf
         9weNLm+iXAuE9xt/mNzEugY7PmaHpwWO90z+v4HlKkcExs/tsnQqhnDlEH1AmVh+ak5Z
         JzJ0UM4IrxTdL5feBRst7P5vhDyAc5Ypxxdi95Z9yRxEdu2/qWzPYvhwPBsnwKH87+Xh
         AezmqIEqu18gCDvRQeWjFD576V8y6Xy27UyG1mZ12rGar5j4e1sfT/YcX1Syi7thIjCj
         GSM049G4vGSdb0Cqyzpps8M+alX9SZS0ga1WjIOhfa3psvDw+tOPgxJTgr0aKOllio+8
         71Cw==
X-Gm-Message-State: AOUpUlGFp5uQ5E38rEwCOg+qWIK4IC97+pehboK2OycuoRPuE+Rpx3zV
        U5o+U2hUZhJfEYL2WVT7Y7Yad05H
X-Google-Smtp-Source: AA+uWPy/zJQOg8/3be1tlzDvZ5Tgd2yGW713fwrMbgZi4Zxvx4/3Oedk9ALLFC//8/7vTN1RSZRZDg==
X-Received: by 2002:a1c:2807:: with SMTP id o7-v6mr16005830wmo.60.1534421783496;
        Thu, 16 Aug 2018 05:16:23 -0700 (PDT)
Received: from agis-knzzdba.ws.skroutz.gr (agis-knzzdba.ws.skroutz.gr. [2a03:e40:2a:200:3412:9d1:5373:9184])
        by smtp.gmail.com with ESMTPSA id z141-v6sm1333005wmc.3.2018.08.16.05.16.22
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 05:16:22 -0700 (PDT)
From:   Agis <agis.anast@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: git-clone removes destination path after permission deny
Date:   Thu, 16 Aug 2018 15:16:20 +0300
References: <A1C23FEE-55CC-4888-9BD5-1C4566E83A38@gmail.com>
To:     git@vger.kernel.org
In-Reply-To: <A1C23FEE-55CC-4888-9BD5-1C4566E83A38@gmail.com>
Message-Id: <450A55F6-A4B8-4841-8814-FC7365EFE43E@gmail.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nevermind, this is does not happen in 2.18.0. Apparently it was fixed =
somewhere between 2.11 and 2.18.

> On 16 Aug 2018, at 15:08, Agis <agis.anast@gmail.com> wrote:
>=20
> Hello.
>=20
> I've recently observed the following:
>=20
>    $ mkdir foo
>    $ # try to clone from a repository that you have no access to
>    $ git clone git@github.com:agis/private.git foo
>    Cloning into 'foo'...
>    Permission denied (publickey).
>    fatal: Could not read from remote repository.
>=20
>    Please make sure you have the correct access rights
>    and the repository exists.
>    $ ls foo
>    ls: cannot access 'foo': No such file or directory
>=20
> Is this expected behavior?
>=20
> Thanks in advance,
> Agis
>=20
> P.S. If this is something that should be fixed, I'd be happy to =
prepare a patch
>=20

