Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0E3C54FCB
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 20:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A96F12075B
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 20:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="bS0gG3Zc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgDZUJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 16:09:40 -0400
Received: from mout.web.de ([212.227.15.14]:41093 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgDZUJk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Apr 2020 16:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587931777;
        bh=O8fwJukH6uhDJqO8vAzT5isbz7J60k3bgRjxuwbrTV8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bS0gG3ZcF6szpzwhQQF5aDOYhm+rnh0J14rVasxLLhUIpb7ZVfwXH4cknOjAEp3EM
         Inwg/u3viRge5u1CPxgBXHaVbegVzN0niS4qlxAYI2qocKg0rIREVdwK3lnDeDe5vE
         6sN9lTJUBFzttiAnS+PbddXbDDW+1JO+jmh95nSs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from susi.lan ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MFLQi-1jNHpU3Vmm-00EOqn; Sun, 26
 Apr 2020 22:09:36 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        szeder.dev@gmail.com, sunshine@sunshineco.com, carenas@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 1/1] MacOs/brew: Let the build find gettext headers/libraries/msgfmt
Date:   Sun, 26 Apr 2020 22:09:32 +0200
Message-Id: <20200426200932.3769-1-tboegi@web.de>
X-Mailer: git-send-email 2.26.1.107.gefe3874640
In-Reply-To: <pull.616.v2.git.1587819266388.gitgitgadget@gmail.com>
References: <pull.616.v2.git.1587819266388.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HciHB8r7HaPcPSrpyGQoSIKeJzfh2h8y46kplw20TDKayuXW09k
 bDPKLBKh7Da0GOxu+1ZBpw3i8p6A2+gxhN51q37Irrm/XkYFO4KNbECZeueKrxEtil6jrKq
 Zl1hCqvsHBU0FH3V95Zp6eWJIwPtOjX/7+9yyl1w+hXAudVNzbKEkCrE0CK5iOdpSQF9ILn
 d2zzhkzPp+IhjzArEdSXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y1r25owSN5c=:q1YVPGr78KacNoh6G4fNFD
 P93UXm6u16RJIOYd5Vaka+LLuW4bywH8pHp79laWz/YY7t9Z+N3RmddVyeAbAIta2h8LfKAGu
 SOlAvE7Lr2zuvnTlliRZj36CZLR/awUnttHj2Fm/ujMuQuV6knggpQaTmVivH7xHx2nxir3cW
 eiL1LN7Txu3rJ+qdsU5MMM6EK7g88R2omqjc2CqDNpakT0/HZT0FA5XNGB1JZc3Nksieie/rS
 1iWpQ8Yl+YjIrySUei6kyZ/paoIalpE73imGGclEuBjsBjHWmUzZ8m/6KJ48SF0Nylc6TCHSQ
 ZZq2GE89lafqKM6bS+ha10qaKyPAgo1yge8bEcLcZAozJSLvYL36qXmsFrXp2joYFNmmn2aNq
 Cri1KivHszIzwVeWd5Dq6h5wu8nbRDPzZERhBhOsvxsZ2b8OEZd410hb3T2JaoBI1npVafF8s
 spFFNWNu86GlDOcwi08NzDFCSwJBZirPNKn7lwYNX0cO8kzrxMWCpfsHJOBfdiqv80YUblINA
 3DA8GBkTHxGzNdWWfuCkWsFle0BS3jV8KESW5QKuy1YWuT+8neDRQZE9Gud7Gx5DL2yoVXArd
 B35v3yM84wPh9jQPHn/7V7RZjWGkFRHIX35PBQJUZvsJpRJm/tA95wRVw8TH3jqD5yeThYDyh
 PZs4FHui0wC6IKwnYZJfEG9/oOFPICikGPfxN2kjD8HsWwX32rdde0Vtjph0UZrbf7rYBzjro
 ADJHwJJprixmk1ykSgKfmd4qzaZjddmFUGM8dvKWxK7OWjHR3dvZC+5ZznzzAL7o0LFrkw6s7
 pWAggoc4coClVkNc2FFcTtjpL7ApHdU7t8FyaLAfclzIVjkIZxWIM/prO9ZjjtrlSU5CBayYi
 FBI7/ZZh/yJ2H+1zTpxvObvaRdm8mLFZOtH30V2A4InWTv2z8MSn8Dl/ug+AHGoqsr8xDeYgx
 8Lg8KKXIeG90ucMzHdeKBWsEvVH7XQU/tlvOWh6d0rsOZ1ZqeJY07z1hXAi1SGGNkTN8Pq134
 gKzUEZVpFsE67jB8+uWlht/TJ36bLvjRokq7kfUZrgoGvINYiCrRwrHBPb9Ry9qsgxSVYS0d1
 pnU25ARGCjkFRAhfuFcSHmeBVidNXUNp3EiLZhB9blAzl2NSWcy21HLP4vqxMykVzlwriYa7k
 coptAMEhSNdBwvrmaO+MjkgRS24ec9BvgLoEu79tE4xKLfuCYCocAY4ONJ5Nm8A/D2McCfHIs
 iUYRSKzRZFsWiwutL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Apparently a recent Homebrew update now installs `gettext` into the
subdirectory /usr/local/opt/gettext/[lib/include].

Sometimes the ci job succeeds:
 brew link --force gettext
 Linking /usr/local/Cellar/gettext/0.20.1... 179 symlinks created

And sometimes installing the package "gettext" with force-link fails:
 brew link --force gettext
 Warning: Refusing to link macOS provided/shadowed software: gettext
 If you need to have gettext first in your PATH run:
  echo 'export PATH=3D"/usr/local/opt/gettext/bin:$PATH"' >> ~/.bash_profi=
le

(And the is not the final word either, since MacOs itself says:
 The default interactive shell is now zsh.)

Anyway, The latter requires CFLAGS to include /usr/local/opt/gettext/inclu=
de
and LDFLAGS to include /usr/local/opt/gettext/lib.

Likewise, the `msgfmt` tool is no longer in the `PATH`.

While it is unclear which change is responsible for this breakage (that
most notably only occurs on CI build agents that updated very recently),
https://github.com/Homebrew/homebrew-core/pull/53489 has fixed it.

Nevertheless, let's work around this issue, as there are still quite a
few build agents out there that need some help in this regard: we
explicitly do not call `brew update` in our CI/PR builds anymore.

Helped-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 Changes since V2:
   Updated the commit message

config.mak.uname | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 0ab8e00938..1ea16e8928 100644
=2D-- a/config.mak.uname
+++ b/config.mak.uname
@@ -133,8 +133,17 @@ ifeq ($(uname_S),Darwin)
 	HAVE_BSD_SYSCTL =3D YesPlease
 	FREAD_READS_DIRECTORIES =3D UnfortunatelyYes
 	HAVE_NS_GET_EXECUTABLE_PATH =3D YesPlease
-	BASIC_CFLAGS +=3D -I/usr/local/include
-	BASIC_LDFLAGS +=3D -L/usr/local/lib
+
+	# Workaround for `gettext` being keg-only and not even being linked via
+	# `brew link --force gettext`, should be obsolete as of
+	# https://github.com/Homebrew/homebrew-core/pull/53489
+	ifeq ($(shell test -d /usr/local/opt/gettext/ && echo y),y)
+		BASIC_CFLAGS +=3D -I/usr/local/include -I/usr/local/opt/gettext/include
+		BASIC_LDFLAGS +=3D -L/usr/local/lib -L/usr/local/opt/gettext/lib
+		ifeq ($(shell test -x /usr/local/opt/gettext/bin/msgfmt && echo y),y)
+			MSGFMT =3D /usr/local/opt/gettext/bin/msgfmt
+		endif
+	endif
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET =3D YesPlease
=2D-
2.26.1.107.gefe3874640

