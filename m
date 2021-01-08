Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124E3C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 19:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C537123AA8
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 19:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbhAHT5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 14:57:09 -0500
Received: from pv50p00im-tydg10021701.me.com ([17.58.6.54]:55826 "EHLO
        pv50p00im-tydg10021701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726059AbhAHT5I (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Jan 2021 14:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1610135772;
        bh=wWT4OLwpv3zFf5WdhVY/I5qstHF9tlaCDhtfSEfOHmY=;
        h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:To;
        b=U6ST0re5XP3h/CHQOnXte5APzut3ClH2SGSlnAqFbDCLNvrCtSo66juaz7qCMCTQi
         NtbIUg5tCZ+2OIl4Qb4/uj6OBKuOfqGSER2EXuYSI5a6Skh18m6WETd2QIllTBWYDe
         GQlsP/cgmQEQbKh0RQEA8EBOVFgvdTIm/3PagqRzgAt30lI35QG3pQDQBQma8uJEhL
         PttJRXXBA0twVeeYzNvjTqwQpFq/Aqfb6iPGk68k73xaYA/U/XIOoRtZh9rx2NDXP3
         uMibPxUQAgAVmSI3m/2Sop2zGa7zOheNTXacWvuF22eaS5MoS+zaRS31XbNWyKIOSq
         n28VX5G1AO9ww==
Received: from [192.168.1.101] (unknown [90.129.214.206])
        by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 0227C8403FE;
        Fri,  8 Jan 2021 19:56:11 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Daniel Troger <random_n0body@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: Re: git-bugreport-2021-01-06-1209.txt (git can't deal with special characters)
Message-Id: <7B64BC13-CB54-43CE-8C01-D45E25591E2A@icloud.com>
Date:   Fri, 8 Jan 2021 20:56:08 +0100
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: iPhone Mail (17F75)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-08_09:2021-01-07,2021-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=788 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2101080104
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> That did the trick, the test case is now reproducible here.

> It seems as if there could be a patch in a couple of days, but no promises=
.

That's great news, thank you all very much!

I was already afraid at first it was some weird macOS filesystem bug only ha=
ppening on high sierra and earlier which was never going to be fixed.

In the meantime I have managed to add "both directories" to git (with git ad=
d paulbr*). It's funny, now one directory shows up twice when viewing my rep=
o on gitlab.

And this is the message I get when cloning:
warning: the following paths have collided (e.g. case-sensitive paths
on a case-insensitive filesystem) and only one from the same
colliding group is in the working tree:
  '[...]/paulbrunng=C3=A5rd-springyard/main.ts'
  '[...]/paulbrunng=C3=A5rd-springyard/main.ts'

What will happen with the two folders in the git repo after the patch?

