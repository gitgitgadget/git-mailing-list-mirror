Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 720E71F463
	for <e@80x24.org>; Thu, 26 Sep 2019 20:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfIZUq0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 16:46:26 -0400
Received: from mail-ua1-f47.google.com ([209.85.222.47]:38466 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbfIZUq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 16:46:26 -0400
Received: by mail-ua1-f47.google.com with SMTP id 107so1247160uau.5
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 13:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=JJNtZE6fanxLvuOjMv5sMzCAzFhgHYIes2GJS6mX8M8=;
        b=PyIzcJnaHL1A6LNiBtyO9stv1mh5nnoolBImFmXTHwGXrPX58rDNupqMBrhvGagLWZ
         yGu4m54Orcwy/XAhff+5FzMg5+uNFrc1kILBgjkC34ajy0o8pGJMr+XwloCIWh7Mm1l1
         Jn7LTXRCvSrZQSxTOl1p6BmtVojw6ZR6gS5nMA/g9ciOV/UT+BG78IQkl4dJn0uUZF4z
         X59xzE6QxHrb81ZPrHZE4GmSt51mxdRTqseSj/luY21Hdvp3+YkjcYVOVX7qWm7KdqHO
         g3uV8FEdTdiMCgK0nkT3Bzm2dm/uFHUKC2nBRjUS1yXyyjSy8eHVRsK/ZsX0bpo4umfF
         gbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=JJNtZE6fanxLvuOjMv5sMzCAzFhgHYIes2GJS6mX8M8=;
        b=cSht6L2cFXOl9AhPOcFHVLZGvnT7y+KGRNM5nCNS/5S2mXCFDppl2TwO3QDGhC/W2r
         ZD3D4YuqSWEYEBGFAuuylrqCFu+wPrL/pNrpkBdACYWfPCHpWDxK+EOR2PC03S6CS+p1
         rb+ZIdtvqA7iIXWjAsrW2LPpr8uPHlx3BbsIA0VIIMWAlOyJXHC+JemwYIE7un/9pzYu
         OFOI+Bww1dmwm7xmze8S++pezdhMvZwLANbugH8o9JIcVpA4jspqlT6CDP0/bxbdTept
         0H+b4ffy6U5Ifr2iIY8StQzoNGY3vY9oJS5Zob+fbRgOLStySvFw4jceUubMWZim43ms
         nM4g==
X-Gm-Message-State: APjAAAUBAspKk+bINRnOlVbH0YR5mhgkKm3ZNWcd0sqHHSRsjCJ3CzC/
        YMu1ySS1fuOwE3fu/2gyplXj+I7QLH/PIPg/vVagi2eXMCs=
X-Google-Smtp-Source: APXvYqyqoPWagJeHaUbLeZAWqieAPc6QgY3RwDQQaEYPlMl/touIw8eZkLscJYw682MQiE+jDJQ8b/DgeC8PCaYDDmE=
X-Received: by 2002:ab0:7c3:: with SMTP id d3mr749606uaf.131.1569530784751;
 Thu, 26 Sep 2019 13:46:24 -0700 (PDT)
MIME-Version: 1.0
From:   "dirtbikersteve ." <stevemk14ebr@gmail.com>
Date:   Thu, 26 Sep 2019 16:46:13 -0400
Message-ID: <CAN-=hvFX+tN_pQHPBxo0pA90N03dO7pxHVbD79Es22mx30TdxQ@mail.gmail.com>
Subject: Git describe shows old tag
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I believe there is a bug in git describe. When using the command `git
describe =E2=80=93tags` an old tag version was returned. The repo had a
lightweight tag at v0.6.1, which was correctly shown by `git tag` but
did not get returned by `git describe =E2=80=93tags` OR `git describe =E2=
=80=93all`.
The command `git for-each-ref --format=3D"%(refname:short)"
--sort=3D-authordate --count=3D1 refs/tags` worked correctly. Console
logs:

=CE=BB git tag
v0.1.0
v0.1.1
v0.1.10
v0.1.11
v0.1.12
v0.1.13
v0.1.14
v0.1.15
v0.1.16
v0.1.17
v0.1.18
v0.1.2
v0.1.3
v0.1.4
v0.1.5
v0.1.6
v0.1.7
v0.1.8
v0.1.9
v0.2.0
v0.2.1
v0.2.2
v0.2.3
v0.2.4
v0.2.5
v0.2.7
v0.2.8
v0.2.9
v0.3.0
v0.3.1
v0.3.2
v0.3.3
v0.3.4
v0.4.0
v0.4.1
v0.4.9
v0.5.0
v0.5.1
v0.5.10
v0.5.11
v0.5.12
v0.5.13
v0.5.14
v0.5.15
v0.5.16
v0.5.17
v0.5.18
v0.5.19
v0.5.2
v0.5.20
v0.5.21
v0.5.3
v0.5.4
v0.5.5
v0.5.6
v0.5.7
v0.5.8
v0.5.9
v0.6
v0.6.1

=CE=BB git describe --all
tags/v0.5.20

=CE=BB git describe --all --debug
describe HEAD
tags/v0.5.20

=CE=BB git describe --all --debug
describe HEAD
tags/v0.5.20

=CE=BB git for-each-ref --format=3D"%(refname:short)" --sort=3D-authordate
--count=3D1 refs/tags
v0.6.1

-Stephen Eckels
