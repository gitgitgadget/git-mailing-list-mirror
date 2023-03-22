Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889ECC6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 21:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCVVJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 17:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCVVJg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 17:09:36 -0400
Received: from st43p00im-zteg10062001.me.com (st43p00im-zteg10062001.me.com [17.58.63.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA5921A0D
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 14:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
        t=1679519374; bh=AGioCT7o+pAbTMGSvr4xhN3g15d524BO6tEVJuvw48E=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=N9i6jnrrqtAIHB84UwiBwoFeW8tk6Z7SqLHIvV1yV5RH6p9HXoEaJCedPNx5tvP6N
         2JfDjv/pirG6oXp786h7RZCJJOAD2t+rzfKM1ljsii+HtOvl28mVzQBWtBvttvONnK
         IbG5tPaYbLqx1yJK1ZyjdEJDqNqVGa9lBp2ks1zR7nXKCTQ0EuqCTdc7jAu1zXCDoa
         D7u2J6+O1RECMMxezIzVWr4YV22nwXCSYggfJo/hb+YBMOfzQYfRyJWbrAfCgmHjPd
         UqTwDGGeYGjSIaMFNAbBFNBdmFfdB0nd9L6o7HzgldZY02jlf85XKvWU6XzmsiwXKX
         w1K0NyD/TA5dg==
Received: from smtpclient.apple (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-zteg10062001.me.com (Postfix) with ESMTPSA id D34B9800A9D;
        Wed, 22 Mar 2023 21:09:32 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: BUGREPORT: Modified files on a fresh clone on M2 MacBook Pro
From:   Sjur Moshagen <sjurnm@mac.com>
In-Reply-To: <34c11cee-d73e-4de0-85f1-5ecd5fe54c71@app.fastmail.com>
Date:   Wed, 22 Mar 2023 22:09:19 +0100
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D9EA587E-1B31-40EC-BF00-BB37DA29DFC4@mac.com>
References: <593742E7-F0FC-471C-AFF5-1E855A3788B0@mac.com>
 <CAJoAoZkKTGzgVyL2wM9a4VcFObx4YpjMSatH9Bpqcgyi=zzBrQ@mail.gmail.com>
 <3FC6072C-5856-437F-9B4F-BC182921426D@mac.com>
 <73af529d-e918-445d-b0ee-9506e28188af@app.fastmail.com>
 <xmqq355wegsd.fsf@gitster.g>
 <34c11cee-d73e-4de0-85f1-5ecd5fe54c71@app.fastmail.com>
To:     Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Proofpoint-GUID: qapx49bN3IC72oHWntxQAlfW2VTF2i0G
X-Proofpoint-ORIG-GUID: qapx49bN3IC72oHWntxQAlfW2VTF2i0G
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=769 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303220150
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

22.3.2023 kl. 21:00 skrev Kristoffer Haugsbakk =
<kristofferhaugsbakk@fastmail.com>:
>=20
> On Wed, Mar 22, 2023, at 20:18, Junio C Hamano wrote:
>> The attribute file says "assume everything is text unless otherwise
>> noted below", which you probably should not lose.

I have now added all missing binary file types I could find, and kept =
the default as text.

> On Wed, Mar 22, 2023, at 19:47, Sjur Moshagen wrote:
>> I will add this and other missing extensions.

Done in =
https://github.com/giellalt/lang-sma/commit/0f461c63ade00a623da2b2533fbe5c=
a4b986c1f0.

> By the way, when I first cloned the repository on commit 357c7cf01950
> (text, 2023-03-21), those two binary `txt` files showed up as dirty =
for
> me (before you removed them in 6b0acd78f9c9 (Remove accidentally added
> files with uncomprehensible content, 2023-03-22)). I guess it was the
> same for you.

Yes, it was, should be ok now.

Thanks to all for the help and friendly comments and suggestions.

Sjur Moshagen=
