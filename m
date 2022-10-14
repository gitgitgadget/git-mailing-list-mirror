Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5583C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 09:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJNJsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 05:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJNJr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 05:47:59 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCC81C73FF
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 02:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1665740873; bh=fyne7NZZrHG6zOrQgxATalKSRUwOznvtS1pdqm8ldFY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=sM6IUDx2TOi39pMnVlWCswE6zM7v083HSexrnMfR5kFvIA4IiwNn8Ei2uQojTXBGr
         fQTr1UcNLyb7oJtJUuGStP9Yb8/l0uvZE/3eSQNECEkXGj1mr+njY3ILu7tZxR3cSu
         P9C2AlnA+W3suya0chqk0hhyT4YV9MPtv4p6kOiMGWHf2uCdNB2sHVj8MQNEYNEDqD
         iEgs5dmfWvTr4VRjwZooR3ZSMrTBrAl2i8xkUyspT+XD6RcakG9YezxP+VQyAHeHQm
         QLkVZmAQEO/UxwM4FsLa0s8JTpYbgLHLEEZ4ph2DflY24yTvysN/fzNwGn2kQ805pr
         ez4fwZbIjBK/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.161]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVaYw-1obcJZ1LL2-00Ryqc; Fri, 14
 Oct 2022 11:47:53 +0200
Message-ID: <b0d36edc-cd9a-e4a1-3bc1-d35654f4843b@web.de>
Date:   Fri, 14 Oct 2022 11:47:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH v2 0/2] archive: Add --recurse-submodules to git-archive
 command
Content-Language: en-US
To:     Heather Lapointe <alpha@alphaservcomputing.solutions>
Cc:     heather lapointe via gitgitgadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
References: <pull.1359.git.git.1665597148042.gitgitgadget@gmail.com>
 <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
 <97a82675-22bb-b996-deac-3f13a91f3df4@web.de>
 <183d33ad4dc.b3e5b5ca123845.2982022328880074553@alphaservcomputing.solutions>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <183d33ad4dc.b3e5b5ca123845.2982022328880074553@alphaservcomputing.solutions>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Boj8Ccd8ozREy05I1lxEKQqicyysjQNj19UozFJJCSmq8NqPjbw
 2rmlVk+JcKq3vaMkTYSmlBXMUznH4b2oSchPglmXYwvF3BdMbUmv0SB3xGTSodOa+ePA3qm
 3a8GOBXAtNSrELBUkI/7bbhZuF95192vE85a/z3/cckCTgCqAPH8OqNKC7sxLI5OivgdLlB
 fZF4OQrPe1tVDTJAn58Ug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YfqnQWgnz30=:L/V0okKuyiqouocuV034Re
 6s4aTbAGGmOZe89e+8l9jp+TjW8tETYqdCd8BPSY7ZAID8VfINYqjEZPUZHfxOyPoJ5hIncyY
 Dx5c8Cd33N205x2gTVR8MC4rUk5tZoQLo3x+MFYNlp8o8iB0ccLVBZTEidfe26lwfQJKbD0Qc
 0tP3hF/fpnH7hEUG0izNBCdWfpxq3ZEdo/P3pO8tmqdU+Rquykv6lNREHC6jsGbKVxE8fXhfz
 ydAOLYh1Px1jZeTpQaoWK4+GLYqS88D1KlIF2tqOuTnoFP3+n15g5SF00xBG0SxGXYdUxljtj
 Xb3GEAkwkMunRMf92wVvHiwkljaeePV57//g+Ys8a+CcgiTr4E7lqXXwpzvhHs94J2dk5L6QH
 yJGZKM9drwi0jDOd11lpPYZR4U6MH9qjkOte+dHQnBmnCua3GIlXOYE0eZE7v8mDYaoSvVWNY
 itGVY29tI7kYqM7jKpEMPQRnAhDFbiDpmsucLXZKy7k8nnXH9uSbnP3RIDqK6X/QnMLJI6VSG
 6YyIdeEzQ1NqFKTXkXUJS+uNhxQWirH1Nh863F9uNbEi2VS8PWr8WIf6hXlgbCOmwSVkt9M+R
 pt9thtdH4K5HhSXXRmA64EOW1YH/jX6u6llAsf5I6MDBinhKPFF1YeQgcacbzE0fUlL8WORV0
 Xr+XNLHucQ0TY8hnqFhr+5InjFCnUCh4eqzQvSBZZOy198QivAhKqUrXjTozOTHvQD+jxjwW8
 WXhdsKfL3SEanTWmZn1XN1jDAkZenbbSRBrQB9/mkM8reH3aAYqFdLkwBxuiGrv/k+I2SndsE
 G4UzsWL4q59emhlVSe+UvxMalqR6zIQ/smGwv7JaUxh5hmCPqzmFu5iQoeGBJc89sVb4K9JxP
 Wp8MDbTb8CtgRcstJuzGGS7HSQGsZlqnPnDqEmxUQpsXQEmrr8DYDQ4bVF4B1EXqmHmDIP2Cn
 BMMhxifu8z2s2pg4oXQvLs9FWdYQHNZOjUuZCfXvI7B+VlNitug0zedag7dFuBdQh5Pw70Rkb
 19oerqnpHkpdN8Zqsa0Bx3xIGoXrTpuq681zbOuf66CHiFeG8vWM7fmCZjbm1YZ9NdKaqYdLJ
 0WC4LisCq0i/m8vhvNM5zdkh+pVq+viNTb4RYpl3dBXqeox2YpZ6p0rTpVORQEC74vGIos7IR
 kX2zrwmCvBAX0NfZe4sEJiwxMwBA8bjKcZraidhG7tyvDjtwxogk51r90neIxpeUU4ib6rMiz
 hlF3tVLubQd2yNfSWLer3FJr7XngwWEHINcdB6cfaNMeM1lSI7Va95zsAzRrHM0YsXXVU9ahL
 ixSSo2eHU5CSIvGOgbXrXVg9dNL8xUJIHocsZZNGrSlX+3P9Ftnxlp550J+xDCgFBievtThvF
 TxGywq3rZK8AEZR3epDeN7pSrITmcMMxoEJ+SKtzOpb/GvlznQ4zxRNt7qFP/9v2vtMknoNTQ
 MQ4CaXheUNnyLY6Ou3pdS0lo1n1FVJ2Xc+hiSQuFfQUOtrOimqr5ys622/MloT/n7FGGHkYxG
 ByRfjPkSeVqHCoetEgUPWxt9LJNeG7IYofvn0y2t33a3d
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.10.22 um 23:23 schrieb Heather Lapointe:
> I had been using checkboxes in github, which look like `- [x]` for
> ones that I have completed. They all got converted into items that
> look like they needed doing via GitGitGadget.
>
> The only remaining one was to update documentation.

I opened https://github.com/html-to-text/node-html-to-text/issues/260 to
see if they are willing to support this kind of to-do lists better.

> Does this mean I should create multiple PRs? Or should they just be
> split up into individual commits. I will work off assuming the
> latter.

Right, I meant multiple commits.

> Should each individual patch be completely standalone? (To the point
> where each set, with the previous patches should produce a working
> application? Or is having the patch broken up by groups of changes,
> with some level of expecting the final functionality good?)

Yes, each commit should leave Git in a working state.  Adding new global
functions that are only used by later commits in the series is fine.

Ren=C3=A9
