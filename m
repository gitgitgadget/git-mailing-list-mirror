Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A877C1FAD6
	for <e@80x24.org>; Mon, 11 Sep 2017 14:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbdIKOeI (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 10:34:08 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33953 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbdIKOeH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 10:34:07 -0400
Received: by mail-pf0-f180.google.com with SMTP id e1so14232627pfk.1
        for <git@vger.kernel.org>; Mon, 11 Sep 2017 07:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cygCH2RIeE5OhSeVmvzKFKhfgn5LewdwRR/8YMtAyjE=;
        b=sR/1x86fBOvIAEzxrFeODIYV3zl1Jkh4TeY3/A7/vUjus8ryKVuAFIvUfqsaODzTjW
         5ketSmd3/T+S7FIok6fi3HeaXNSWra0U7a3KNThw01dhvxy8BaaFbNzE8xCoMWDbZhJj
         5se48pGoO5wWO336WBgWymcEqiB0jm4sjLEZXpFF4VitzCrHg0oAD2fpuvHNidP1kiAR
         ZUkNgK+mjtB6Ec1k0Tv+H05EmOG4PHrgqnE1fCVoG9COMYbCZOUBcBEWTGaON3V2QPTM
         bOhodXnnMrVQyulIYvkCwIzEXdMiXLuwyikK8GfrkWVKf2PN5ajXZ81f8qCcp9g3E+JI
         skrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cygCH2RIeE5OhSeVmvzKFKhfgn5LewdwRR/8YMtAyjE=;
        b=BoM3WE36o967cK5JNBNgOd2SXpwgWP4Es29r0TV6CwhDCOjMUPL24+PH/+0j/Zwjqr
         y7m55max03Mjp8GGsrjC3eNLi4mOSCv6PacKTMi6DY6d8wsIidTV5eHpzyWWJ+Q2FsNd
         G7wBY1PhGUD7kAz4SFpL6Fpg0lD6dFmAQooKjQ/4+DknglJnmjA/B4uOhxH8wE6UagRf
         Vq4jHpIz2UvCXH3WJBLS1x+CdbYGnegKJmOgJONSz1V1hGwEj1EqPTNfK4JHERLI7nHO
         ogNbBrQQxq//BCbY36mU/+IKtlgbnhvp+kb1U08s7BobQpe+yawPN3EAdIzp4RrdPyJy
         2QOA==
X-Gm-Message-State: AHPjjUj5b2GiNbHXrYvjxcdAOXT3kfcNlVplEF6RF0cLdUsBRYoaoLY3
        xmIBNVJQsO2IdAE2qe8gNhEGAB2LnH475xM35Q==
X-Google-Smtp-Source: ADKCNb7zgtxDjr6dxHmuIHrl6jQXgtbi4ZSw6lETlmyDlk9ax8MVhyYQbOClRu2hiUOA9uKVGxD3K96CTBhzchw2+Gc=
X-Received: by 10.98.33.80 with SMTP id h77mr6527876pfh.18.1505140446666; Mon,
 11 Sep 2017 07:34:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.138 with HTTP; Mon, 11 Sep 2017 07:34:06 -0700 (PDT)
From:   Joseph Dunne <jdunne525@gmail.com>
Date:   Mon, 11 Sep 2017 09:34:06 -0500
Message-ID: <CAC7pkbQhwLFQQjqBwaW=0j4iKFcLdKDucCMck-PsSAeCs0rqpw@mail.gmail.com>
Subject: commit-msg hook does not run on merge with --no-ff option
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I=E2=80=99ve globally configured git master branch to use the =E2=80=93no-f=
f option in
my .gitconfig file:
[branch "master"]
                mergeoptions =3D =E2=80=9C-=E2=80=93no-ff=E2=80=9D

When I merge a branch into master that would normally be a fast
forward merge, the merge happens fine and follows the option =E2=80=93no-ff=
,
creating a new commit, however my commit-msg hook does not run.  (The
commit-msg hook works fine in all other commits / merges.)

I tried changing my commit-msg hook to just be =E2=80=9Cexit 1=E2=80=9D and=
 it doesn=E2=80=99t
abort a no-ff merge, so I=E2=80=99m certain the hook is just not being
executed.
