Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEA282021E
	for <e@80x24.org>; Wed,  9 Nov 2016 13:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754011AbcKIN4z (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 08:56:55 -0500
Received: from mout.gmx.net ([212.227.15.18]:60080 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752964AbcKIN4m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 08:56:42 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LnPGI-1cky7Z02hi-00haRB; Wed, 09 Nov 2016 14:56:27
 +0100
Date:   Wed, 9 Nov 2016 14:56:25 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH] sequencer: shut up clang warning
Message-ID: <efbba4b32515fed7096c1c81dbe97eedd44083b0.1478699713.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1160187855-1478699787=:72596"
X-Provags-ID: V03:K0:HQSSfhkXH9+qNdx3+rvJG1mA5cMZIu6p31oE9wawKi59W+w0lwU
 GYG12v+z6Qj4za7QwDlpkqhs2ePVTp/9bBf+W6sJStmL/6yONM8mFsl9aDxw2cI28Gli1cI
 cZ2JQtHMKCIgL1zcSXSkqLwSVjLVxRcW6kytjbsL+SAwFtMkGwpxhL4NONlV1gtlKnxyJoX
 3vn0rIT3fAEW2XunvsNLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7r4KMc1Eyd0=:fNYUWulAPbaQ1tOgTRNHNp
 cCQss2sfyXB4oYoreTnQUjaSm4fvtyj0a/9LY1ulflc5oY5fINF3a2ZCUsjIP2ZRBhywLd0Yq
 QSPG+jetdqdz0PW69Qtqm37VXDxOAvWoX8OpnMFu28Px6ry3kkr+up3qeF6Ih2iLD514PClxA
 OHCVgtpG+l5hwPR+ZaYLaJKqF5y1NGa9yYLyHKMG1BGr00BlbwgLm+qwF/RgP+vbw2Z1jIHVN
 JmQs0OpSdKDaPtisnV7IQYMc4aFYqedzK+XkSvYJl9NMlcpFpuex9QtFCy+fQlp8IZbW5pqDX
 A0EPZsb7sdg/5EBSNEZ1LgpICagnPK3Yp5Vt4k/ACaVmxJXKK73i81IE9fTNCqWat4KsaDALN
 yJMb0emP5S0ptXZH2Ox5lTiZ+/piCxxWsAgxahhaiOAksuZnyt2pZrJ5Js3YBrPfZLCz+DT/s
 sLtPSSP9RWHiQ6FBro3189R4zh9JTy5G/sW05phuZa3bUbE5s7xWPbbcnVEng1mq5w/f64mOE
 Lw9k+UXL+NpVtu18ZKX9V/6l9MMAge9G81Y973yby4p6LOyWPL4548jt0zneZwIo6gAEFdOHa
 MHl/sIa0LuCP8IQxlJ4kXvO3NS7zMAcMLT3AlHFs+RI5Ep3lnWOGPFKMT4px/g+HUekhl1QfF
 gcPGnWVyho4RsA2WvB7cj3H24V/iennJoLLfcCNlRl3ITm2Ko7p/fPMzzoXawukutlgGPP5Ha
 Mwqbny54OM4HUQyhIQHDhkJXJiQPQShGN+vKadU8p4eBgxnfVRFp4WfQwZWqn99DhPxkFR/kH
 KUKp6Uc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1160187855-1478699787=:72596
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

When comparing a value of type `enum todo_command` with a value that is
outside the defined enum constants, clang greets the developer with this
warning:

=09comparison of constant 2 with expression of type
=09'const enum todo_command' is always true

While this is arguably true *iff* the value was never cast from a
free-form int, we should keep the cautious code in place.

To shut up clang, we simply introduce an otherwise pointless enum constant
and compare against that.

Noticed by Torsten B=C3=B6gershausen.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/enum-warning-v1
Fetch-It-Via: git fetch https://github.com/dscho/git enum-warning-v1

=09Peff, if you would like me to include more of your commit message,
=09please let me know.

=09I will adjust the sequencer-i patches to keep the TODO_INVALID
=09constant.

 sequencer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5fd75f3..f80e9c0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -619,7 +619,8 @@ static int allow_empty(struct replay_opts *opts, struct=
 commit *commit)
=20
 enum todo_command {
 =09TODO_PICK =3D 0,
-=09TODO_REVERT
+=09TODO_REVERT,
+=09TODO_INVALID
 };
=20
 static const char *todo_command_strings[] =3D {
@@ -629,7 +630,7 @@ static const char *todo_command_strings[] =3D {
=20
 static const char *command_to_string(const enum todo_command command)
 {
-=09if (command < ARRAY_SIZE(todo_command_strings))
+=09if (command < TODO_INVALID)
 =09=09return todo_command_strings[command];
 =09die("Unknown command: %d", command);
 }

base-commit: be5a750939c212bc0781ffa04fabcfd2b2bd744e
--=20
2.10.1.583.g721a9e0
--8323329-1160187855-1478699787=:72596--
