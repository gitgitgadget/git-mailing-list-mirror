Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F864C433EF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 19:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D93600D4
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 19:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbhIDTmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 15:42:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:56175 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229669AbhIDTmr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 15:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630784501;
        bh=lQohU6PlbLVWdLa7dW+THjFXbHud9CDk72JOLQycf+8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fd+R0b6KLN+CkD0tQXy4LOp10EsfAXYuNJCd8P1hKV8ZBiC34Xdyzd9wXuE2tOS5/
         48rZWB5dpbNEg2n3VMwrcscWALHgx3pvYrETYuX8Sn5KYaf7KhZ61O/cN3Cs1Mak6s
         eejz7nazDmThlud6SUh8g19Dx9Rs6TwhOiIVnW6Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjS9I-1moXR03RDm-00l18l; Sat, 04
 Sep 2021 21:41:40 +0200
Date:   Sat, 4 Sep 2021 21:41:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 5/7] rebase: drop support for `--preserve-merges`
In-Reply-To: <87lf4f9gre.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109042138410.55@tvgsbejvaqbjf.bet>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com> <pull.195.v2.git.1630497435.gitgitgadget@gmail.com> <eb738b1bf05dceb1d119e3adcd732d968407c757.1630497435.git.gitgitgadget@gmail.com> <87lf4f9gre.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1550222341-1630784513=:55"
X-Provags-ID: V03:K1:qt/Zv/+R1M7lhqC6Hbi7SxyLChMmJRRbLD3v3tcYi648igHIlTd
 tOQmtVw+pT+pL+nl9HcHUHoW3g2ZzWa8xUt5f7jyfilcnlYr+fadPFcgsnBOcFi+renVOx2
 VufwxIvsPImjITcRpyUAsxEaX61Fs3+sh0LkxKLjq/n7LkHBhLC82sTaVfRN3ONEuTK4s3U
 X46eA+TmXatBmv+We466w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xuil/qBRw8U=:96PdnOVYeKK5uRH00jOn+P
 9IxT+N62yhLWCclay3UPEkNE3IHmJeNYOqZHIs/kIq69G6/PFD9hzosEpBc+ZXQ5dk6EKWEM/
 Rh/wMURt6fzGLeMIDpp5QrMZweo5kg4dLqLMIY7gH3hgsXx7fQF9zpJvueUJvzhwwMAtJKOjd
 i88kqM/tvLwdl4dMU857NkGC96JPc/sxTV0rqThWzp3UIJHQ2hS3kfMDjlyeN00B/wXqxFwyF
 9v/Lw2ODzqnNsh11ZJGbRnvsJfx2ehYCSZT1gC17gVovr0gI8bueTjbtAJ7S5oRS/+ay/PQEK
 oThRtld+LqwCIqMlcFl98u5ZzJbMDt7fzrn5QlM/qWgC8QAiwBamTHe6SJsKXba/j64llPnE9
 qUrN4aMKJUj5gF8GDCBkxV25xkQ4i3ztUCPEIj5JCkid9/G4+XHH0KMGu4WGsyFOBh15ZoWrb
 Q9aJ+WYyKqg3759AHzZXYybNXUoaCga48eedJf2THvTkCtycQmwxsoYxl+6jPrbuJXNASCJay
 eS+pLcVn1Dd3gBnz4EYU37+Kn0TSV6Li63zLqzbkV3S6iMgpCZOtHLoEQq+aYwvl/iow6Vwky
 OxfF3n7azAOE6++55KMyMBlzZ6mHDA99CjsWMG99vB4bXm9kqqSnAT4CJYyrc3BgQqQpUOIss
 iEUuUiLEHat7kPM0nR4BOXqoId221/DtHrmYO9KkCWFWCfRvrXDdXA/n2cZppf8j4nMnyBpQ1
 SE3Em10ywG5dWfe8d90FD/NONHzWkDlC8z7lMg1Z6IoP4RM/uosKfSfX2W8Cb4Pnq4ZWcdqJN
 Cw9FMHeFOCjfIl+ZIsoa4cMDnI9U74HPiOSa7bbFHqYzGkpO0yIMJ4k2WkLSJt1iQdZ2nbFvm
 caJjkk8/M09znDKBFq73v0B+Y8pVTrkrhvVyt20AmstSG9ObNx5WLJmNqjpH1GRbjUi5G+H/L
 y/cyp7jW0Q7QdGXkjYToXU2Afs48TDSEUsGz08nXSzDFmtnx2ozm8hGn3xOiW6KhQNMLkguMU
 HGYjm0YWWS3UdcrK8ZN5U0uauBLnULaNfkKbxpbmfxHie64eDhICfK26TfYrCWYeyQkjB0uFy
 33/xPgh3DbhPOJK1Ecl8hK/h7fB1nMNdU/shMgPnU2rLypA6oRCxQavZg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1550222341-1630784513=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 2 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Sep 01 2021, Johannes Schindelin via GitGitGadget wrote:
>
> >  git-rebase--preserve-merges.sh | 1057 -------------------------------=
-
>
> You could, but certainly don't have to, squash in the below. I.e. this
> is the last user of eval_ngettext!

s/last user/last in-tree user/

Since we install `git-sh-i18n` and semi-advertised it as something to use
in user scripts (which makes removing it somewhat questionable a goal,
certainly when you do not even offer a deprecation period), and since the
removal of such things is completely orthogonal to the intention of this
patch series, I will not include this patch, let alone squash it into a
commit whose purpose has nothing to do with gettext whatsoever.

Ciao,
Johannes

--8323328-1550222341-1630784513=:55--
