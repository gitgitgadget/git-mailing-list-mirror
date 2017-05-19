Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA9712023D
	for <e@80x24.org>; Fri, 19 May 2017 19:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753106AbdEST5e (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 15:57:34 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34307 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbdEST5d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 15:57:33 -0400
Received: by mail-vk0-f52.google.com with SMTP id y190so17629990vkc.1
        for <git@vger.kernel.org>; Fri, 19 May 2017 12:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ell.io; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DL6E+dA8SSdEnw0pxP7hHJRgL/W4RvQNS7Z8jIO9n/c=;
        b=MZSZNXTLLd6L3SR/64h4VLZl37AgUkw6xesh4vbLkeSgWJ+JKvodgaXdDU8ormoP4B
         Qg9akGVsLS37IKKznYG0zVRtZCOZSrkPxOWs93Ee6xgRfPWY3d5b8NoJSyioc8a4sqw8
         5j1HBle1bg+4PL4MTw8ZZipZbZ8VpCvmFuoIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DL6E+dA8SSdEnw0pxP7hHJRgL/W4RvQNS7Z8jIO9n/c=;
        b=hRJeTneY+Aqh8O915C3F+OFk3I9kR8q0sk2GFOZhlXwupc8DJhz2t7+Ko2J+683R7F
         bwKbFcP2WrM/7CqJRwBCjW251Wbo5cGiqflbxEnxpdnG1s4pvC2VFZpgV8/FByg3S6kL
         nkR0JEc9eL9XqSpJoOItmx5UiTRR4DUEWPll4k/WKxyaHpp7KGPVk0tQREYJyaRU18tA
         +yyEsq0fYG+3CbftQJN0DPGW3sKFY22yUY0ej+a/8ltojrKjvY7gNrszvnKskWsxUqgk
         gq1tlN2fBsAaoilkMo19UwxC+XUd/JHrBmWO8TN0T3+l7dEZYF052Zmx8VmXnfYMClu4
         ZkVw==
X-Gm-Message-State: AODbwcAwa4KPiIi6bi/s7jTYNgWo4fLlgD7bXPM15jLF9D0LTyIAV46r
        LbiZUEm7Wrj2ZcrmXh1rUfUpaC/jJ227A8DSRA==
X-Received: by 10.31.83.7 with SMTP id h7mr2694366vkb.61.1495223852555; Fri,
 19 May 2017 12:57:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.33.227 with HTTP; Fri, 19 May 2017 12:57:12 -0700 (PDT)
X-Originating-IP: [136.30.24.42]
From:   Elliott Cable <me@ell.io>
Date:   Fri, 19 May 2017 14:57:12 -0500
Message-ID: <CAPZ477MCsBsfbqKzp69MT_brwz-0aes6twJofQrhizUBV7ZoeA@mail.gmail.com>
Subject: persistent-https, url insteadof, and `git submodule`
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set up `persistent-https` as described in the [README][]; including the
=E2=80=98rewrite https urls=E2=80=99 feature in `.gitconfig`:

    [url "persistent-https"]
        insteadof =3D https
    [url "persistent-http"]
        insteadof =3D http

Unfortunately, this breaks `git submodule add`:

    > git submodule add https://github.com/nodenv/nodenv.git \
        ./Vendor/nodenv
    Cloning into '/Users/ec/Library/System Repo/Vendor/nodenv'...
    fatal: transport 'persistent-https' not allowed
    fatal: clone of 'https://github.com/nodenv/nodenv.git' into
submodule path '/Users/ec/Library/System Repo/Vendor/nodenv' failed

Presumably this isn't intended behaviour?

   [README]: <https://github.com/git/git/tree/master/contrib/persistent-htt=
ps#readme>


=E2=81=93=E2=80=89ELLIOTTCABLE=E2=80=84=E2=80=94=E2=80=84fly safe.
=E2=80=83=E2=80=89http://ell.io/tt
