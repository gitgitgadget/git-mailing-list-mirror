Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C8AC43334
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 13:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiFSNrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jun 2022 09:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiFSNrr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jun 2022 09:47:47 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4F96378
        for <git@vger.kernel.org>; Sun, 19 Jun 2022 06:47:45 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1016409cf0bso11148482fac.12
        for <git@vger.kernel.org>; Sun, 19 Jun 2022 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tRythMsIYUeyoIEKTavtjAQb07i2wzcnWZ/AgnqKMbo=;
        b=CD6JxPwn3vM4/SWWRBhqKK8HyzYvoriSvlZD6PZOsjA6Fa1ZWiNGiHGGicOec3wo2p
         0znXFdvnl/k8KOrtGH8MIahO2aI2AXFmcaALOgD4g2aF+KaYCMeJ4WPpTz5vzbXRDjKV
         4jHtbdn9UxWxVse/ZmEY691GidxU60SeNemGiZHE2bOvflKtYd8uIxqxbUOS6XhfKnft
         BC1UBFhihaqSDCRNtKO7mmaW3GgxGMd70U119+h+6+gcmx2K3f1aY698J2rfkGASgkn6
         jJGxMNSUYg80Dg14IfWG32Hk+x+G2xZi/u8sfCBSYyRqlf3H5nq1rgo3+RlFsQzGmaw6
         oITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tRythMsIYUeyoIEKTavtjAQb07i2wzcnWZ/AgnqKMbo=;
        b=zqB43CTWALbPa2W9s1j1+EEPH2n75709UnZ2QxGroqqiADZqQhTNuvvWl2lZ0eSgUK
         lAGoJBv5PvjqqG+TzzM+pbv8sLMSyPvcK7VyBQOA321gwWPeIw3bF353lb2D99LPYdKe
         K9VbHpbFRvNNiEQWv61LehyfDF4MyyrqDy8PnQwQZ7xUN27XnddCaE56vFAvLtNqQwI4
         kcZzAm+FCiVqIddbTA9ldCSDpu75Hcj5kM5kErEO4ug0W1oBsNf0k8rJVOKpTX//fOrx
         VtzC95pdXpVQFYI9kEP6soGlqBGDDc4KbJxeaz7QnQJHs1D5PsFkDY1rx+95mWyNBCgK
         6Qrw==
X-Gm-Message-State: AJIora9LKyYCfBE3dJ9jhzqX6UT6vYC3TxiLzT8NmOp7y4FN2MZ6jlpF
        I5viRH/gezN10IllkO5CnOh6rVpaXUTdm8vQnKw=
X-Google-Smtp-Source: AGRyM1sJt6rdij0/yVZomqDbKi+9H4tDwnmi12qe1UglBUQ34q9sG/yOo2/MAKNjlmHlBc9TmIu6ZjJcQc5eesKChFg=
X-Received: by 2002:a05:6870:3320:b0:fd:a944:1abf with SMTP id
 x32-20020a056870332000b000fda9441abfmr15622283oae.251.1655646463553; Sun, 19
 Jun 2022 06:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220614112858.16576-1-worldhello.net@gmail.com> <CAPv0VGvKFEbVzZEdn+eb-4Bb9KfQWCa=pM3iC_Dyu-6AKGCcug@mail.gmail.com>
In-Reply-To: <CAPv0VGvKFEbVzZEdn+eb-4Bb9KfQWCa=pM3iC_Dyu-6AKGCcug@mail.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sun, 19 Jun 2022 20:13:58 +0800
Message-ID: <CANYiYbGWoMpCOA43k=5a_kio2thf91BV69nfSySwhHZbbMOSkg@mail.gmail.com>
Subject: Re: [L10N] Kickoff for Git 2.37.0 round #1
To:     =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Cc:     Git l10n discussion group <git-l10n@googlegroups.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 19, 2022 at 4:02 PM Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwild=
man@gmail.com> wrote:
>
> On Tue, Jun 14, 2022 at 6:29 PM Jiang Xin <worldhello.net@gmail.com> wrot=
e:
> >
> > Hi,
> >
> > Git v2.37.0-rc0 has been released, and it's time to start new round of
> > git l10n.  This time there are 92 updated messages need to be translate=
d
> > since last release. Please send your pull request to the l10n coordinat=
or's
> > repository below before this update window closes on Sun, June 26, 2022=
.
> >
> >     https://github.com/git-l10n/git-po/
> >
> Done, please pull!
>
> $ git log -n1 --stat
> commit 22262d3c1947626e296418ffa3543d3584995653 (HEAD -> master, origin/m=
aster,
> origin/HEAD)
> Author: Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman@gmail.com>
> Date:   Sun Jun 19 07:48:40 2022 +0700
>
>     l10n: vi(5367t): Updated Vietnamese translation v2.37
>
>     Signed-off-by: Tran Ngoc Quan <vnwildman@gmail.com>
>
>  po/vi.po | 37548 +++++++++++++++++++++++++++++++------------------------=
------
>  1 file changed, 19003 insertions(+), 18545 deletions(-)

You forgot to remove file-location comments in "po/vi.po".  If you
send me pull request on GitHub, a CI workflow will be triggered to
execute the command below,

    $ git-po-helper check-commits --github-action-event=3Dpush <rev-list-ar=
gs>

and you will receive the following report:

---------------------------------------------------------------------------=
---
INFO [po/vi.po@22262d3] 5367 =E6=9D=A1=E5=B7=B2=E7=BF=BB=E8=AF=91=E6=B6=88=
=E6=81=AF.
---------------------------------------------------------------------------=
---
ERROR [po/vi.po@22262d3]        Found file-location comments in po
file. By submitting a location-less
ERROR [po/vi.po@22262d3]        "po/XX.po" file, the size of the Git
repository can be greatly reduced.
ERROR [po/vi.po@22262d3]        See the discussion below:
ERROR [po/vi.po@22262d3]
ERROR [po/vi.po@22262d3]
https://lore.kernel.org/git/20220504124121.12683-1-worldhello.net@gmail.com=
/
ERROR [po/vi.po@22262d3]
ERROR [po/vi.po@22262d3]        As how to commit a location-less
"po/XX.po" file, See:
ERROR [po/vi.po@22262d3]
ERROR [po/vi.po@22262d3]            the [Updating a "XX.po" file]
section in "po/README.md"
---------------------------------------------------------------------------=
---
WARNING commit 22262d3: subject length 53 > 50, about 63% commits have
a subject less than 50 characters
INFO checking commits: 0 passed, 1 failed.
---------------------------------------------------------------------------=
---
INFO update pot file by running: make pot

ERROR: fail to execute "git-po-helper check-commits"

Will turn on the switch for file-location checking by default in
git-po-helper check-po, check-command, etc.

--
Jiang Xin
