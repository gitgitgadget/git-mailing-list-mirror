Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4C531F404
	for <e@80x24.org>; Mon,  3 Sep 2018 12:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeICROQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 13:14:16 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35803 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeICROQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 13:14:16 -0400
Received: from null ([172.19.249.47]) by mrelayeu.kundenserver.de (mreue101
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MMWCs-1fySnA0Dew-008Hrt for
 <git@vger.kernel.org>; Mon, 03 Sep 2018 14:54:14 +0200
Date:   Mon, 3 Sep 2018 14:54:13 +0200 (CEST)
From:   thomas menzel <dev@tomsit.de>
Reply-To: thomas menzel <dev@tomsit.de>
To:     git@vger.kernel.org
Message-ID: <2056463102.521974.1535979253941@email.1und1.de>
Subject: git log --author-date-order not always working
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev36
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:gD8IGfHyg6uYnv0vkhYtQPATO/6Mxr43Y+o0ySRlJgQF9i50e77
 YhZHKv5xkXTWWCzmdUuj63h/xmd1e5EjmUGtzC1LYK5lQPvogRELvNjgN/gq+Setz9ZWGQ3
 3bUUVYlKPacFlzeEIAPTlXglmgo+/4EcFo8jI2ylobCJLrBI88+2j5/1gjsyWNxGQLbAyCF
 K70k/26DKRlovmt8++/wA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O3/t3cFBvzU=:OgCwn5Bx/4OuleJmzQfrbe
 3isbPxhVSI941aydI/Hgzksv95PfQNZcjJ7IAYJSAHlo21P57nRfUxazqac6YBcXjkX1pZzxy
 108IXFOuJ2y+/c5Oc2fja+O3SGoyMo75J5X2PCVI1UIPkIFRIeDUJp9lg7PYeXv+s86NX5zC0
 d5DDPFMc9I6jAmiE7xhYaSEd3uDBKMOe+IXuII8Spd0stY5fzqVb+lupgSOe4h5tkyMpd9Yok
 OfcSGRPk3P/q3EUhZ2ntnPlNic64TRd/RvhxlAr1V4HHMxm+BHyB3Tgum5pocx6Sph8EkGgOb
 TppKYl8aPl3Rz60kRrtDnmOCrZwQOVN0lBZay2XAj89V0LTuI8t4xACHy+U08ITopErfu+Pl1
 pmJY6ZkQ0YZeUNMJXkEhBDwkpXL1QH1gPlil/bhsSVldY74hIt/ZjOKwYUDQtLgQuVIosmSR9
 wVhDcueedRuUe4Qrgv43FPchsPi6F+Lhw3RNVK2ldCZYIZ9D8pHnIv7DSM5rBZDwxX1CHI/H3
 v2e5HWA9izp3feDx6MejmYmQEnimDvv4rJPgVFbOZYe9LNPgt0TBJL4JuenHTItKhHuqH4X2j
 hh37rJ7MPR0ETaP6XFFxmWH8uVe2z0gUklo8S8cOCJmXFO6s/J1Dk3yB8c1h0PBM45iG1E/Gy
 BrRrLlI/o6aHCtf0qSiU4D5zuscHPwXBGTyAcspliwmkxNu/P5X3Wq3PiMsK/hG2kZ0Uzpw1M
 FOb6nx+Xe8ZtUGNW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi,

i just ran into this little possible bug but cant pin it down any further as it happens against a git repo for work project that i cant share.

when i run this git log against my repo i get this wrong sort order (1st col is authored date and 2nd is commit date):

$ git log --author=menzel --since=2018-08-10 --pretty=format:"%ad %cd %h" --date=short --author-date-order --until=2018-08-20
2018-08-20 2018-08-20 f2ff8245
2018-08-17 2018-08-17 d8afbdb7
2018-08-17 2018-08-17 853fdeca
2018-08-16 2018-08-20 7dd7b234
2018-08-16 2018-08-16 41fcb077
2018-08-16 2018-08-16 f081f38c
2018-08-15 2018-08-15 95466702
2018-08-15 2018-08-15 d8e6f91d
2018-08-15 2018-08-15 c1cd6e14
2018-08-15 2018-08-15 4bd06ba3
2018-08-14 2018-08-14 6876182b
2018-08-14 2018-08-17 6fb982ee
2018-08-17 2018-08-17 d2323219
2018-08-17 2018-08-17 b35793b4
2018-08-17 2018-08-17 ab784faf
2018-08-10 2018-08-10 9ede6a8d
2018-08-10 2018-08-10 e4959669
2018-08-16 2018-08-16 d146a71b
2018-08-15 2018-08-15 37396218
2018-08-15 2018-08-15 554042c5
2018-08-13 2018-08-13 39c80c8f

whereas this works:

$ git log --author=menzel --since=2018-08-10 --pretty=format:"%ad %cd %h" --date=short --author-date-order --until=2018-08-17
2018-08-17 2018-08-17 b35793b4
2018-08-17 2018-08-17 ab784faf
2018-08-16 2018-08-16 d146a71b
2018-08-16 2018-08-16 41fcb077
2018-08-16 2018-08-16 f081f38c
2018-08-15 2018-08-15 37396218
2018-08-15 2018-08-15 554042c5
2018-08-15 2018-08-15 95466702
2018-08-15 2018-08-15 d8e6f91d
2018-08-15 2018-08-15 c1cd6e14
2018-08-15 2018-08-15 4bd06ba3
2018-08-14 2018-08-14 6876182b
2018-08-13 2018-08-13 39c80c8f
2018-08-10 2018-08-10 9ede6a8d
2018-08-10 2018-08-10 e4959669

Note that the different location for the 2018-08-10 entries!
The only difference is in the --until parameter. 

It appears that after a certain commit date the ordering after the authored date gets broken. 
Any1 with a clue on what could be the cause?

Context
- same behavior for a colleague of mine
- we run on git version 2.16.2.windows.1 in git bash

cheers

tom

PS: i will try sometime later to check this repo with the latest linux version
