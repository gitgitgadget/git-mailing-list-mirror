Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA50C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 12:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiF3MWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 08:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiF3MWC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 08:22:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C92620F4D
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 05:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656591701;
        bh=tb+pz7pL0ZnbdejZ+ggxEAwbQGBaO5tA4qvVwi3u0l4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PJypYDGAl9YqbZDVD5Xzf1iFybyDT/OU7jbmBepQOK8gDClXM0Xqi/XXUE8HNpbXB
         zk39jbzgcZDTYNph72HFoRda0UqNh11c5nZ2ElqZKGuL0S/SLgLHLvhphRCzZzLvf5
         dA+j9EU62cbEzexRAKkUA0yL0vThdB4xFGyX/BVY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.204.148] ([213.196.212.94]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mz9Z5-1nl5420pjX-00wE3l; Thu, 30
 Jun 2022 14:21:41 +0200
Date:   Thu, 30 Jun 2022 14:21:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Han Xin <hanxin.hx@bytedance.com>,
        chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com, ps@pks.im
Subject: Re: [PATCH v3 2/2] commit-graph.c: no lazy fetch in
 lookup_commit_in_graph()
In-Reply-To: <xmqq35folmgf.fsf@gitster.g>
Message-ID: <5n35o008-pso2-6440-424p-q387q9n4so41@tzk.qr>
References: <cover.1656044659.git.hanxin.hx@bytedance.com>        <cover.1656381667.git.hanxin.hx@bytedance.com>        <3cdb1abd43779844b8e8dc094e2fd2da1adc461a.1656381667.git.hanxin.hx@bytedance.com>        <220628.865yklgr6g.gmgdl@evledraar.gmail.com>
 <xmqq35folmgf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-844489475-1656591701=:10220"
X-Provags-ID: V03:K1:zGPGX7sifEp7SDygkxLA5fvCPcukO39Eda6Y1AwyZSbZoia33s/
 D0vHErUTVx1eB6JV4Ykn2V7pEAd82Si9hNHbl7AGQsM0yQoA2g41V8p+CpIcp67lEgT0tdV
 0TLlrtWd7Qb46s03ANY5y5rfAsGvnZ6pRP8GnHhcsq5btita9RYt9Z7R48aAhqcy86UiUqi
 lqdDqs7d8JQuOSVxMcwkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bodMk46bsvk=:2Uo/cK7EFHBp7COKX7kQ+U
 48XyaCIxS5BIe0W7eD+Q70PnOM7psAsZ3y8gxCos9DxqcSNNLtm/ZBJKYz+OaMbvIBnAYqcDc
 k99gs60wBaP+lZQmMUsYucrAb10CaI6wTqMlNY7No98exNIy0z0x1vZGeJ2aTRKIiXlKay4aK
 +g+xCyh8mgreSNPZ5ketKTUXuTInPz51Sq42bv43h70X0uKssaQd2dI3pMw9+2Nf89hlmHcwW
 SuQJ0RA9HrAPXfsxTLAt2OZqN/x2fluqTVt4fzz1eDx74LT3n8opQnQlJH54D4MwbhZBVdyXG
 ZUKbOEDpPunk4yYAuaZR5ioINJv7Zxg+ipFuqBvz+6Ox7Jb6gv9GAYQAmrkUSeUfa2AL+wboZ
 AdqMOMvvLX29LBspUY6IfDBp/NkHELRIvlWje1Bq6zIb7LjcivGLGY6IpGVuk8u+J/tIJarYi
 QSqsprwdWVzKfXlpS+SlcaTgn52ZroFLsDtZAD3C+Q6ycDIQPYr4DTlX8svyH2yK0x2eawi9c
 T75eewVfhP9i+64DbqVdK2fHlF/NU5etMfvKy5INt5q8ByEXFGujHnH6i3ddOuv2Xzi3mjHj7
 wzevNDj8R5RfXwlPZ7DAu0GXyTkYVcPTJiRbOIyk8UzwwEBsFPYaSJb2Sq8utlPUQZCL0cTzf
 cz68r3dB/TJKclO09TsB/J9dJ0djZ+XW0Txd1tQOFgASlGpUsIVkpou9JWwm3HdC+XNdrIrxX
 vCXKwRn8QHsjHy7tYmN0b6mjgV3ajYt8yK7JjgT98BtFOweVVux7RO1waDPRZEUDBGnyHCpKM
 gXsaGZ78GlOGaIL7OLgOf9yM9BXNXPMJLDv2d40wkROTCeE3F9nlUEij2Vg3YVos8PvfFVXC6
 Jqlni1AbDJ9I5UmwUKtPFRkJ7FoCUXQx6O/WAALGrmL8Xyf3GlvPftYe0m9+xDvCGyRWQDZLS
 T/kyRvSUYu3YFfk9hDLNjX/tQmH+nJEiRzuA8MF3L4IeBDFn9HRsRfjojrA8928y+9cXTxjbk
 JoinBL8Rv3jMFj3RLKZZFrD48oOpAj0neOwIxV6/LuSKZc5lJMmVA9uwHAuWqZeDsEHhSkO+b
 t7++zePIb2MybsJdrzq87KhoBk2mKGFfO0zJszzFuy817TEc7bOi3nCAg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-844489475-1656591701=:10220
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 28 Jun 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> >> +test_expect_success 'setup: prepare a repository with commit-graph c=
ontains the commit' '
> >> +	git init with-commit-graph &&
> >> +	echo "$(pwd)/with-commit/.git/objects" \
> >> +		>with-commit-graph/.git/objects/info/alternates &&
> >
> > nit: you can use $PWD instead of $(pwd).
>
> We can, and it would not make any difference on non-Windows.
>
> But which one should we use to cater to Windows?  $(pwd) is a full
> path in Windows notation "C:\Program Files\Git\..." while $PWD is
> MSYS style "/C/Program Files/Git/..." or something like that, IIRC?

Indeed, and since the `alternates` file is supposed to be read by
`git.exe`, a non-MSYS program, the original was good, and the nit
suggested the incorrect form.

Thank you for catching this before it was worsimproved,
Dscho

--8323328-844489475-1656591701=:10220--
