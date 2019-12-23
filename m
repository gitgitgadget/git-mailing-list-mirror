Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A396BC2D0C8
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 01:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F38206B7
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 01:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="l5Za8QAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfLWBZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 20:25:48 -0500
Received: from mr85p00im-hyfv06021301.me.com ([17.58.23.188]:58288 "EHLO
        mr85p00im-hyfv06021301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726190AbfLWBZs (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Dec 2019 20:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
        t=1577064347; bh=mmSJQXjB0K7Gnj+WopWhRTulTiVVDOmiJKt60WvSPDE=;
        h=Content-Type:From:Subject:Date:Message-Id:To;
        b=l5Za8QAA/GMmVy5Ja5xo/JLwsMjPft3sQk33NS33mSW7A7ctBxuLYvQoZf8PxeWLx
         SQfrG0lgm1nm+SGGBv6y1YbrIoRTuLg8MEMzhYJCsLzrSwbA5jbe0e1PEZqP38oUoR
         hUNdIgZv+XUjC9E57fAPV3F9pz6XFQXxAPlwIk/WBLUMhObUJyG6TWbbQWZ7Gbv4Ff
         XDkgO0IJLlrFPcD0Xfppqc53Z1i8yTQ1yX6VBerFY93Nf9sD2oZs+2QBW30+aEP+ph
         nVPunxTk06mlIPOf3IpOVBM015CuMeXEIdv1JdzX9IEfbxo0xQLBFjwtxyIv2S/sbV
         ysB5X2PH6MTiQ==
Received: from [100.64.174.251] (122-56-197-197.mobile.spark.co.nz [122.56.197.197])
        by mr85p00im-hyfv06021301.me.com (Postfix) with ESMTPSA id 67595407E9;
        Mon, 23 Dec 2019 01:25:47 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Michael Clark <michaeljclark@mac.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 10/20] t5319: make test work with SHA-256
Date:   Mon, 23 Dec 2019 14:25:44 +1300
Message-Id: <61195D89-DD1B-4BE7-BC3C-D09E22FD6D1A@mac.com>
References: <20191222174751.GE163225@camp.crustytoothpaste.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
In-Reply-To: <20191222174751.GE163225@camp.crustytoothpaste.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: iPhone Mail (17C54)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-22_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912230011
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On 23/12/2019, at 6:48 AM, brian m. carlson <sandals@crustytoothpaste.net>=
 wrote:
>=20
> =EF=BB=BFOn 2019-12-22 at 00:06:47, Eric Sunshine wrote:
>>> On Sat, Dec 21, 2019 at 2:52 PM brian m. carlson
>>> <sandals@crustytoothpaste.net> wrote:
>>> This test corrupts various locations in a multi-pack index to test
>>> various error responses.  However, these offsets differ between SHA-1
>>> indexes and SHA-256 indexes due to differences in object length.  Use
>>> test_oid to look up the correct offsets based on the algorithm.
>>> ---
>>=20
>> Missing sign-off.
>=20
> Will fix.  In the odd case that no reroll is necessary, I'll include it
> here:
>=20
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

You have a fan for your work! This is the hard work. I missed adding sign-of=
f in my patch series also. Fixed in the branch mentioned in the email I sent=
 to the list, about alternative SHA algorithms.

I can review this patch series if you like. I=E2=80=99ve applied them in my l=
ocal tree and run tests. Nothing blew up...

Happy holidays.=

