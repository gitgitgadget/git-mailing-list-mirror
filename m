Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CBEC433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 17:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D65DC207FC
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 17:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YtXT0YkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406909AbgFYRqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:46:11 -0400
Received: from sonic314-19.consmr.mail.ir2.yahoo.com ([77.238.177.145]:38671
        "EHLO sonic314-19.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406906AbgFYRqK (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Jun 2020 13:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1593107168; bh=M2nWOBT3cXO7HZNQ4wjO0TdrQexAzHsKeC+9fUqQoYs=; h=Date:From:Reply-To:To:Subject:References:From:Subject; b=YtXT0YkXo86ppRbKZckQ+DTt4ZrjajLZtvHtgkDuuGCQ4sI64dM0Vzm3dnzf0FRUuejCJadxaugfT38trh3sAAKc6yAVapT91++bdNcjB0Qt1Cyoq71AH3bCG5ZRiP76HDWPQIr6upzlsreknlUoRiMn02tzXjQsySdhlbVNRmEvZkGd8lV2LNHjbXx8nhZ5RoMesiYRXkOToEkGDkfz5zqX0FVAlyXNz23+RUGDVbsFCzlcci3KDXZVO5+K47JnrN05ATt9b7L04mmGbO+whECbS1CWihzjga/k84TWsn5P/Bvu4jsMPD5DD/uc28hBtFZmDQL+8cc227s7G0ai3g==
X-YMail-OSG: f1tfrJcVM1nU2RrCMJK852XMFJxRKJihFewQbNroS6jOLqArQcVVHTWiCmfiFLy
 cYtCeZM7wxhvTRhYKcm5W9pasq4kTAkjxvuvmLhkP57kvxdTG94tFuwrzXdtX42w6lT4kwO5Zx4e
 mdX6zpdgic0nww_dTKbvpT57AZa6n9_tT8QVefkc5RbgUthCwFTH3VYpXXe75J532M3WDxM9Op_0
 qUVjtiQ7zC6rno9II6hGiv_gBvLvV7M445riyBmi4YnuNkQmgeleaurt9lKoyCbjMjCWCyZ06_Jq
 C34rk2jd9Jv43q3dCsE2X7H5mRdBYKRopfK15oAQqYeVDfmBUDVIinbb7maYPGb0Pvks2VIHCAA6
 QV0p9xNDRFT6a3AD0vaMQagns4wIrH7Tw2lGU45.PH5gsxCS5R7MqKizrUoBM4.7wbTtZDFjaFkD
 tIJteztPBXPPJdg8G288RW7lH.eOI216wCNWLTKhDzPvjU9tXGEHYGlg_IKkbm6i1CHeLevd4xpR
 wD2bOnFiqU3V19pK4xBCaYZIxA4XAOU8QwX82mI7OiOYnmKG5kP_l.jG4hYyMnMHz5D4OIVvZNmd
 ZsiQZhQQsLNvAhYwECvdsj6mfyGXVSBrVqw3PmxAIYshE8YLjqcaiOpC79yeFoEoT_IHb1AvbKQF
 3CWJ_M2Wf2aifZoaLToQJjtk_23IpO7c9gPro98g2rCZKxu_FlQwkR6sgTjelzFVJgMd0mm3bJrK
 j987uGHOABvgsbTUUmmN77FWaxx8HrGfQblA8T7l8d.F.cdmpZNRmF._o6bgYO18unfYHXSI8OT4
 ZXQF.i7pPW40w4ZjlZJgoVfgtdYDaQIiZTeUfxnSXu.5R8wOLH_2eCGGv3JzUkMX9uo7WhOeeSRv
 w384gdIy3sO5WxayO6JjUjjIjfc3EJuYWHnZRQx_XHHt36oFEMirysnGK38mth0kPkl.nhQQ2cVA
 oR2Tiuo.gZNRBIQv4rnR.9rxZVpJgglEGIGSNsOkg41DoCOPsxgLqxm.Tg4Ht_wte_WihJoeE6Wh
 L1bJS0mGI3UDx6RAo7HcJq8qPho88ly08NFKxhBT6nObNUvpZ3IYdwrXZWmHJG56uQ9xDH.a6k1F
 1Fq9zxozMnsQOqgmTN1IiNEKYwQH7zXJG0GU1MRqVq8tSmib7kUYH3ASDVrJBVIYl86TbgAGQb5_
 BA_QLF427rJwUqRQkqO_pCqXI7iNAno13QaJDSp3d1mazMyBF7FR0sDo_8IGzxtujBiokLo99EJ5
 tKtAUth46jLwy0AbOwWb7DpMFszORqTovAZHyfQIh7QLR2fobFgsNEjGxl.f.n4_nP_ZpyuJD64P
 FsQRGiSt.B4pevqd5h095n9fOUzA3Mad4c_2kG5wgayMUDoX1SiObn1ihUQCoxiDBDm.kECM3nBf
 SJ193yd6dgiqO
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Thu, 25 Jun 2020 17:46:08 +0000
Date:   Thu, 25 Jun 2020 17:46:05 +0000 (UTC)
From:   Hin-Tak Leung <htl10@users.sourceforge.net>
Reply-To: htl10@users.sourceforge.net
To:     git@vger.kernel.org, git@vger.kernel.org
Message-ID: <1731755010.6694064.1593107165458@mail.yahoo.com>
Subject: git doing large refetches
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1731755010.6694064.1593107165458.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16138 YMailNodin Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0 Safari/605.1.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Lately I noticed that git occasionally do very large re-fetches, despite the difference between local and remote being not large. For example, here are two aborted fetches (see how small the emumerating / counting /compressing are, compared to the receiving object number):

$ git fetch torvalds
remote: Enumerating objects: 19374, done.
remote: Counting objects: 100% (19374/19374), done.
remote: Compressing objects: 100% (4016/4016), done.
^Cceiving objects:   2% (161673/7478285), 80.54 MiB | 2.78 MiB/s

$ git fetch sound
remote: Enumerating objects: 52009, done.
remote: Counting objects: 100% (52009/52009), done.
remote: Compressing objects: 100% (5480/5480), done.
^Cceiving objects:   1% (74819/7481898), 37.92 MiB | 1.98 MiB/s

I don't see any real pattern, as the last few times I fetch from either of those two are also quite small ( a few days ago).

$ git --version
git version 2.26.2

stanzas from my .git/config

[remote "torvalds"]
	url = git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
	fetch = +refs/heads/*:refs/remotes/torvalds/*
[remote "sound"]
	url = git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
	fetch = +refs/heads/*:refs/remotes/sound/*

Another general issue is that, I used to have just a few small files under .git/objects/XX, with a few large ones under .git/objects/pack . But at the moment, ".git/objects/pack" is 4.4GB, while ".git/objects/" is 5.2GB .


Also, is there a "best practice" if I like to track multiple upstreams (and the convenience of it), while keeping the local repo / heads (the part that "I do", and requiring back-up, etc). I thought of splitting the two into a "mine" repo with "info/alternates" pointing to a pure-fetch-reference-upstream repo; but I am a bit worried about doing a fetch on "mine" before or without updating the "pure-fetch-reference-upstream" repo, in which case I would end up with duplicate objects ending up in mine, and also, would be vulnerable to upstream doing rebase, for example. Any thoughts?
