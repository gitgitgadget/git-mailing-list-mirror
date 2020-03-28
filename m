Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0E2C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 14:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657FE20723
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 14:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="YhthKENG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgC1Oso (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 10:48:44 -0400
Received: from mout.web.de ([212.227.15.14]:34829 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgC1Oso (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 10:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585406916;
        bh=B8cWtIDPUMvb8P3b/iUgIefkEITtimYR4Y2reTDFCI8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=YhthKENGBpKy5y+iPwIrDZAPSvLukZEsjPR9AskFMvqhuIj7xATZWf+eHyePKqjdk
         EAk2jeDkg2r/Yiwc9RvAvzyKFBw/w4fIbIAWus/1PJ1r3vCcepDvpsJaEdmU35JV8N
         8oqhA7Scwux4XOx0S64g6O8vAjrqg5K1v1QMTYEE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.21.89]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MVLY6-1ijTw21QTO-00Yk9N; Sat, 28
 Mar 2020 15:48:36 +0100
Subject: [PATCH 2/1] pull: remove --update-head-ok from documentation
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?B?5aSp5Yeg?= <muzimuzhi@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Dongcan Jiang <dongcan.jiang@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <CAEg0tHTMHD1+3QaSe3Z+ymRKvOkbHnVqv-Xp2xhOT56SoHTmwA@mail.gmail.com>
 <a406c273-9a2c-72ed-c5e3-4c19848f0f94@web.de>
Message-ID: <c94f8c43-625c-8e99-fa04-aafb0c7cdd78@web.de>
Date:   Sat, 28 Mar 2020 15:48:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a406c273-9a2c-72ed-c5e3-4c19848f0f94@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f5jAcKArpOFlkbRCwVsh5DgUNooNEJY66KY9yoEOmFsd2Y4GYd+
 YtliS6dqoqPK0U04kL4Q23j+VuM5Di9djoELHb65DIp+Vmduej4I/AMM/Pq2Aq+v65D1qog
 u5kU4nDMBpEY1I/d9W/khVV35D9l/+FIYAvpbGzkYruVR/PPs2Y3+3a2X6jRc8t0T1buXaf
 /quIJovkPQjUdgFvhFpHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m3TbW2zbOIk=:TZzqHyk0l/dUnwTnSykOTr
 /sWxG9HBS/HHDadzKUqh8T2Hn5Nkm0ZMyXbNUhJUsZvVtQ6gC3XDxj2r8LslvH5J7HemSsdRu
 4JvNuhLOCJ/QzfM74aV3nM/u2LbvLlkkkltTKEgOtNbxLwuO273yaS3Vmg1NIDftKQAowRgHx
 1afI9cPfQCaSMdbSsfR8zxbxLU8nDo1Fk1zyiTgQImyk6BVJ7KoTX/ck951lr5j+vVxPkBp2J
 ZEprTLE0VYD4OLg3+QBk5RtQ3IcyQx+JTqy2QUQHEfHtRLBRw+O7bGUnxS0zPuWt9kZsekyHz
 JT60qX9eBZxOoxCD7z4ajKhNpwDCjQuopeAe8Vvm+/6vTorSJNpV0mhXJPLRmi/tHTifB+dBa
 KWrp9Rnb0opFJ7+SCIkd9PDSIHin1c/TkvyuL3u9XZO2xZAPLhzTT93Rqrff/fJeN//O8wLkW
 3XN5T87H2BCWCSpWKd42zIwynrK9hPPaevANVxZx/T4HitcQFrzFYP6HxG9JZrQaL3lZHLwbt
 UddK51v6gk12bAnw5TYgHlwJ1bwAPPK8ktIcWpK3lv6haGQsdnWOnLvwNx90B/ewc7wli7z0F
 NfKgURz808ukFL+Fb8p8510fXab22easzhxAxi6qp8ANLpMIP49seQsmR4SWa4mxn5rnRs2Oy
 twdkxK/uIYeKy2Kr5VFJDOxz4FhVfsjfCa4iB0gOilxNKHUf9kYU8W+yqj4+wkCP8zu0J8HEc
 DNVLXC/NRxbkUHyf9cLySinhCeRl5PxCNYn2Drd1iTD75nyUsms6WNGkBWFIvQIxmP9WZgmJh
 B/YdCAgsuNm5JrTm5WvsPGKehaV2iYFZQG0rODpq06qUZs/PXrtNb4iUC3U4hdiEcn/g9fH65
 us40pqknOlEp5JxD/cgLAZtAcvJr2bfSpObUnCmenqNcjUN1Ih2jCVY0gyccugpdIffsCaoVu
 XbLkIQXkalKH2eEcwCrqES/lidi+0BqjAoeP2UTB1Rw+1woP/UrhyAZyDeIFPZI3J6hTk/8df
 JB1ImdSvA11ccaPWXBfWeLYiPcyq0Fjqmf75TqH0HtfBqtBasQ1an4Su4x+7olirg9c6+K2+6
 84KmEF/Lzcx3RczB7pfcSzY28IOO3Dnn82iu2/rpHdiQuTRLplvwEv4N93Qd2V3e9o+vdjnkl
 Xdkbkf8wFlb5ulh7Cw6DXXwUTlNIwIW7vntTjrX0lv+C3GqKuCoy2rprh4gO5sajXAjj4P50B
 gYI2bFv2iB7OnBvuT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git pull' implicitly passes --update-head-ok to 'git fetch', but
doesn't itself accept that option from users.  That makes sense, as it
wouldn't work without the possibility to update HEAD.  Remove the option
from the command's documentation to match its actual behavior.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/fetch-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options=
.txt
index 00d03ec8c3..05709f67a1 100644
=2D-- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -204,7 +204,6 @@ ifndef::git-pull[]
 	recursion (such as settings in linkgit:gitmodules[5] and
 	linkgit:git-config[1]) override this option, as does
 	specifying --[no-]recurse-submodules directly.
-endif::git-pull[]

 -u::
 --update-head-ok::
@@ -214,6 +213,7 @@ endif::git-pull[]
 	to communicate with 'git fetch', and unless you are
 	implementing your own Porcelain you are not supposed to
 	use it.
+endif::git-pull[]

 --upload-pack <upload-pack>::
 	When given, and the repository to fetch from is handled
=2D-
2.26.0
