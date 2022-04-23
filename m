Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3910AC433EF
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 10:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbiDWKQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 06:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbiDWKQY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 06:16:24 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5488610C1
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 03:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1650708793;
        bh=LVZ3IN4ChLZ0tDIytJ/Amdf99Le65tX0rZJQ3o5xKa0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fgcqxrVWC7FC8nHqJ9mIyfooh/6s2hHiP7P5LD9hontyNDRTiuDJHaIdBYSHdCf+w
         wRKsFBQtfLfR4+thPAL/om9Fhuv8ZInMIaJfpwpXMtqLAbo3GFhOLbC4HM6dtSRp0R
         nhJmhuERmGvjYG2kEThMLSbax8WLp4KtuxChDurc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1rP8-1nkPgX2VuC-002Crx; Sat, 23
 Apr 2022 12:13:13 +0200
Message-ID: <737bd2f8-dfd7-6a51-b7f5-33eefa33e975@web.de>
Date:   Sat, 23 Apr 2022 12:13:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: gitk regression in version 2.36.0
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Matthias_A=c3=9fhauer?= <mha1993@live.de>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <AM0PR04MB6019ECF053F1FB7B29D75AB7A5F69@AM0PR04MB6019.eurprd04.prod.outlook.com>
 <xmqqpml82vkd.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqpml82vkd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E3cLiCgN7YcptJMjlwfkfOa4e38x3Is6C0DnxIPvlsikPFKkjLG
 kQEFRU5JAPNXP+4E/zLw/bWUc2RPNW69hM5/Av1FFAN7jhXAfEILXM85kE95JEHIGnndUoF
 TqBsInoJ8OvT4PpzD07a/P1hOWKw5iLUSC+7+NjrjW+Sb32OKz7DH9Y4sO9Egt632gnHU5t
 F8WumoRGbXDl+0PQyrb7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EtbZ3qemtrY=:GKYi8OdYx//sxGiAauQxoQ
 eVCFppuWsiiC7O9FRZFtT6wP7VEgG3W/jD5Y0Rf1uwayBwqHq4QWah34r6yE2etOWn1YXjRvL
 JhToV0xQliqSFPuk1jqdwF9RT59LOqP/g/CFdBlJBHMle2W03j8d6s0kTwHTyLz23i8gJrNlX
 mnmY0AzO2DrqaiW+XQ6IHcXqq3mvdnC9OC59161Yiw7sVZ0vY8632Xb+SOrZMuGUl6KPwNiYJ
 hAHNdo0qD2IZyH8+IAFeqV0YkhuD7SdXVm3ipNx59zli4wmMPgVDuYwNsRaSkI7+MqNWxqDYc
 pXJ8IDjK94hmMj4YEyeeW6xxQGHL3rSNDxkJCBbcuSStNyyIblktAeX+ltV11KQMFuaOqXwJF
 Yrtn++YYZGIZUDXkh2RF8MhhReqCLWz0x8BY3MzTY3DfBThg1xynWFNvAVS2B/TumM1qC1y5v
 UdWd6edPU+7nhDU5heRi/WXaStCY7MY0WTnMsOuR65nntxscZ8BidyVRYPXGkrwfkIs8gK3y3
 rhQFGzoqhdMQ/7apxusmpU6ErOr6vKedq5lPoImHugqkYZ8zt88mKWoae7cRgtANza0x6WwnE
 6swjW3JAVPXFhk/2RxEzzoQI98xof8tk6qoWkK/EhfHEnhlToa5MFjdiriVF0wlpceo4xMD5s
 mmwiFHDv4EMwwlUM5TLf4DZcnsLxAWv1nDG0xWuMQ9oObGFkssYeSudra5H9SATUpPJ76UvSm
 iRP7z2/xthTvlQP48Gp3D13Sjw5O1DPMHWHXsstqC/Vj12DA1UCky9jJfRvklv0XwC/V7/93l
 DV0oCQUd5WGAzbSnKcHJBz4ur941Y4ltoOBrda29KeMavQ7s1sJvdUAQIJ40htC6C0w2lHYpv
 jSahN9lFUsi76e1V5gz1PEazzjRyXxzR1FEsvwgDVskptZ+hCDVAlt1VRwkKAMhxIZLCLOTps
 h9oCXJ/K3OCpS2TQ80+gZtfChlPkZcMHJNcscJXhg+1OBcQ7JuRXu4CSCBkTbFbvSoBZ/i6IM
 BkAN+jj7kRq9pFKdDzKdrMlrcuQNgsnCThl6EM55BEz4guMTb6S8TluJusgFk9r54w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.04.22 um 07:54 schrieb Junio C Hamano:
> Matthias A=C3=9Fhauer <mha1993@live.de> writes:
>
>> Git 2.36.0 (or more precisely 244c27242f (diff.[ch]: have diff_free()
>> call clear_pathspec(opts.pathspec), 2022-02-16)) introduced some
>> change in behaviour that causes gitks highlight feature not to work
>> correctly anymore.
>
> I am reasonably sure that reverting that commit will be the right
> thing to do.  It is somewhat unfortunate that it would reintroduce
> resource leaks that having clear_pathspec() in a wrong place (i.e.
> diff_free()) was covering up.  We should instead need to find the
> place where a diff_opt struct goes out of scope (after being used
> for zero or more times, calling diff_free() after each iteration to
> release resources consumed per-iteration) and call clear_pathspec().

Right; a small memory leak is better than wrong output.

Finding those places is a bit complicated by diff_options often being
embedded in struct rev_info, though.

Ren=C3=A9


PS: And I need to learn to download new posts before hitting Send
(or become faster); sorry for my near-duplicate reply.
