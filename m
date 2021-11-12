Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49620C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 06:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26CE060F93
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 06:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhKLGUp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 01:20:45 -0500
Received: from mout.web.de ([212.227.15.4]:33717 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232277AbhKLGUo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 01:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1636697868;
        bh=fnFuIwF1u6Xg9tEJGLrlJQH7nJ2ir1N//hRQnRBNrps=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=KETFb2SmnWNmR8ACvLRdRknULw+RyxyJHjyMxtxnCq7e8NYO80qh0kZGugQ8Sy57U
         R83wj8gB4YIIvHerFBTXyalUR2yaSlCw1l8sDZ7o3q7/L7dcqAnJj4eAg1mBl3D0g4
         +AGXiz4t/7hiDxBn/xqoC3UgNgBc9Wc0UGD9eoFs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.20.171]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MpTxo-1mMJPc0i8S-00phPh; Fri, 12
 Nov 2021 07:17:48 +0100
Message-ID: <6da5e984-1dcf-4c55-976c-49ffb8d128bf@web.de>
Date:   Fri, 12 Nov 2021 07:17:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH 0/2] am: support --always option to am empty commits
Content-Language: en-US
To:     Aleen via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Aleen <aleen42@vip.qq.com>
References: <pull.1076.git.1636693095.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <pull.1076.git.1636693095.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:upQlnc3+GdHsgUzK+1hVxyJaQ0E/PlqFGYBTOvpsr97Ms2q1ZIF
 C83Y81mS5VFajLcYtSTVJnPpSVDRnYTLmJkrrNLM97qDtiXy1KaeqIkCPA/adMlo9lgwuTA
 rMTasjH6ruBVBttSy+Kf2hfd11v6d6AUbGBQYO9DpmH0mBFZRGjqQqwAB5k57fP8HE8kYz9
 ddw6lJ8Cn4O2Kq0+YbkIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1/7tbadkXog=:XMTjQV/aMWbYAj6uaJ3I2V
 p37p95EpWeQdMZMG6c0gq6IqQwk+fOWsptfOHI7FhUCCi5jqdAZZEG6iY9i3EZnaY6n4d3bY2
 IxM+bY3ZEqFYb9gzAOZ2TE3NceJ25YPWg6c6cFqQAw00OlVuh34OsyAtZzcsLcM+/m61jbiGp
 pkNEWLPCHt6APQphCFzVQa9A4bzrQIYPREqUuBRPyOm5p+X4nKfPSV5TtYTUsmgbgyIGJzvGc
 xTq0hhBCu3VPXDk22ExjWrXm5NKdhuLRfvT1TQte8lp+rcIcm7S6ku1oEN1cQRda/lzgy0c8I
 SrOacCGqV+vYcGrwPpESer/A3Pvg9TbwMcbSi/59+GAvChyOhdBOIn1S817Fz/HMF4xjBoNk/
 SmmiYjWnkX+5pJWrtiehwF/lUCk8lPcen3J1sv5U+iYAPwJTIzP52fe1UudaI/tyUpOVR/sGb
 M0UUbBT1i5MQETpmjs1rQG36qV0Pgob91W2xUWV+QoK3CLSN2A4DLeRme6XMSN0b5Avo2Y/sH
 HaozvTDKQHfY9Pxg+FaOG004/3hP1IkIKe9H5t0rJfNyf4a06yX3AIoQPhqzVNVndiw03hM2u
 5lGdVXGQh/xSCZ7qaFyTV4JolGqsxahiBsTDQCLcHWWSR6/yMIV/GQlradW1+DBnTeY5o41UU
 gj+p2SvB5x2WHsrOdcnBN4QYgoTHZvemXGv65GZy+u+Bs1tfUNVk6DT9AtAtnR7k8cWjffQ/W
 ZwCn3paZCfEDmUloXwOMaBROkZsOKTTnwVFPoBvgwKGjoTJj2x1dO0aGXofzFIMU8tEh0Ib1K
 fXGvyOqs8xbNY+cp0PCbs9+TSPz0gjIlXDd14o9zlhRTU3RN6AnI5XCg1EnmUpk2EaGMav+dp
 +l+LVo/7e2G1ylpaSBaNoQ6644ZqeWKN12TIqo5DABAs/tNuq3gzgyaqRSdi8PGU2TyuJsYIK
 dhun26XjtPFtCC2/0Z+9iEaqpWOgS60CFuc/scVsHzA4z1Ry+xVU0U7qtEowv2YxYXOcMuXIe
 expOyPFJ+3bg5IXRPGVWC3VfmQXU6HOdQSavB/O7DU6GzkHpBLFftnDhMf2vLuv65g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.11.21 um 05:58 schrieb Aleen via GitGitGadget:
> Since that git has supported the --always option for the git-format-patc=
h
> command to create a patch with empty commit message, git-am should suppo=
rt
> applying and committing with empty patches.

The symmetry is compelling, but "always" is quite generic.  I can see
e.g. someone expecting "git am --always" to imply --keep-non-patch.

git commit and cherry-pick have --allow-empty, which is (a bit) more
specific.  That seems to me a better option name to copy for a commit-
creating command like git am.

Ren=C3=A9
