Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDDB41F45F
	for <e@80x24.org>; Thu,  9 May 2019 19:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfEITHV (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 15:07:21 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:33175 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfEISqA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 14:46:00 -0400
Received: by mail-wm1-f46.google.com with SMTP id s18so4784390wmh.0
        for <git@vger.kernel.org>; Thu, 09 May 2019 11:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=76mdj83fGOEkgCCQejczY3ZHUnnaTYmtJ/EBdEuvPQA=;
        b=sMNJvPU1yUo0HPBZwfJDB6qX6IxJ4lw1verQtMHnnBT71lNVhTUM4BG/5v6tY4OIDg
         9mB6ohtuanT8aSsuDl5fCelesp2EYHVrqJtk3zUjdinu+Ihu2TOf537Yowvhsbawwzs2
         6++nxsX6ZRHguaCTXVqZR9fFEzTVZs8u77YBzoZG+hp8BjJEsxp82tdVQEnemYkZO5Ax
         kftCFJR11ZQtX4ll0RuZPuhT93rCxIlrbeuhzOZ2t6j4EMd5ymmjXW7VQ4DjO9X8rMmV
         slAGdTEVrlM9TLzGq5/odxHIzQvRSiRuvIW6F0iFcSiKf0CHGhgbNABjZKJ2lnKPGTOt
         UAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=76mdj83fGOEkgCCQejczY3ZHUnnaTYmtJ/EBdEuvPQA=;
        b=RTqYQGgv7yDpbYDTe9KIIIV75zf8V02V8145M401qW6x5CwiOwnM+vtwGRdHJguIIp
         /F6AirKk5c8Jc5/P0rI06Iq5DmGd7Afw7B/2j5zgvIl2hAXQGTBOjiZV9hujPmj0+66g
         5EXWZGflIVgvZshTrPkgRSVZJqRGkWbgopNEIvnSbKROkOrcVS/3A+3kR/MS8OG6opAB
         0ng1dkdG0KHNeHSXPGvASv6k/XdkQYFXe4o6jMTYcwN5H5WhTCnsM6WFGPrIcavao0dg
         L68jR75Lg0I0Xeizlj81b3IvMJYGBioFF24GP+F95/x0R+Iv04ectRfRoXKOu9HpSec7
         Xdug==
X-Gm-Message-State: APjAAAWXQEolk+NsYLgPXerde3v5AAbeW+Mjew2FjvCDkGgMAXbsCd71
        VxmlSP46vto3E8JfFCuuEtyFUh3Kk6krQYYZPIws+hjO
X-Google-Smtp-Source: APXvYqw75VvXSeSowDo9wyVDu3rze3jjxXRbkIOUMisDuPploGC8PT15lnZlgysaEno1IUNm61+VadM8khhqpfVXKb4=
X-Received: by 2002:a1c:a008:: with SMTP id j8mr4108750wme.73.1557427558394;
 Thu, 09 May 2019 11:45:58 -0700 (PDT)
MIME-Version: 1.0
From:   Jack Zylkin <jzylkin@gmail.com>
Date:   Thu, 9 May 2019 14:45:47 -0400
Message-ID: <CACG5jMxnS1AR4YjuRu1woBKfrC+R-Fr9qbBK9L2L9D6Vfp9dig@mail.gmail.com>
Subject: config file not being copied from templates folder
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The =E2=80=9Cgit init=E2=80=9D documentation for the =E2=80=9CTemplate Dire=
ctory=E2=80=9D states that:


=E2=80=9CFiles and directories in the template directory whose name do not
start with a dot will be copied to the $GIT_DIR after it is created.=E2=80=
=9D


However, I put a file called =E2=80=9Cconfig=E2=80=9D in this directory, an=
d it was
not copied to the .git directory after running =E2=80=9Cgit init=E2=80=9D. =
 Instead
there is always the same old default config file there (and I don=E2=80=99t
know where this file comes from).


I don=E2=80=99t know any other way of changing the default local config fil=
e
used for new repos.  I really want to change this default config file
because I want to use =E2=80=9Csymlinks=3Dtrue=E2=80=9D in all new repos, r=
egardless of
what git was told to do about symlinks when it was installed.


(In my case, the chocolatey installer that installs git seems to
disable symlinks no matter what).

--=20
Jack Zylkin
