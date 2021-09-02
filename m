Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32923C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 059AE610CD
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbhIBNzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:55:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:46165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229625AbhIBNzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630590862;
        bh=qzXnEtieqLLx9Vxyvo2XiI8w+VHTpImyAyzgCRFpnRA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EnP0oopM3dVdWxQVuyP5T4wjmT3c2HKa7Jjg+cxShD9uge/njJyOC6VgTfHikIvhX
         8dIG/Bdtd5aqPd64H/Nmd0fcGXWiDFidhB/sGxnDimJjyVOl/3nFo/Ft8+VUnonfwl
         XQP76jYZZqSmhb3L+q+rotPpMh1lWgH5bWTdOHvY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6llE-1mLE8m2pDy-008GLT; Thu, 02
 Sep 2021 15:54:22 +0200
Date:   Thu, 2 Sep 2021 15:54:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 5/7] rebase: drop support for `--preserve-merges`
In-Reply-To: <8735qowknu.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109021553510.55@tvgsbejvaqbjf.bet>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com> <pull.195.v2.git.1630497435.gitgitgadget@gmail.com> <eb738b1bf05dceb1d119e3adcd732d968407c757.1630497435.git.gitgitgadget@gmail.com> <8735qowknu.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1936974659-1630590872=:55"
X-Provags-ID: V03:K1:IkXaQdKglRd06zhypBW7DvdvfrkXWDaeYiF4JPlidk6ackFC30c
 wRgJ26zRerikP7+XKFBweEcQ190MAkvoUKN7wOrl29RmSfNZEROHTlVC6oBYu4no47Mf+Me
 12o3lrxk0IHdPgOcxUz0JPcz6ZaCNgmSuipRwGRSvprC6nETKEy0+UIS9JCpQRlJsTCQpfK
 I5LVHX62H2ABLYEkJkMkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GBN1NXZLO48=:JyBVbg93KGk2P/DBv7rQIn
 uzDDuMpfUG5z7UNrcw4FE0XVaP3B8qzMDehz+Ka6ro8YFFAMZ14A3YL036jEZi7t3hxWsxiRK
 S5nIFNpbKux63ZZC6zU41fOKLgSvL+BcqiRZGkbOC8WHYhJfnQNHXzp+h4iWhzUdKwxlqeTuY
 xAr/yMGz1gqp0q96tsYMChi5ETM6bS0KR9c6PPwqhcLsMkbmkUDEaBgRVXRyJ1TTPjU6Wl1Fc
 H+BFlFMwgs9SRaIKjQBbhqNBWvxQvT71YSi0qu+pcAUoXKja8gt6K1GcluXUSb2SkF0yshzTC
 Xv9bwEm6aNcJ0QoQa05YOYKHwD1keVJtSFZa1UnptIYBCcc+RVw5mGAqx4+F+oeEaOmw6t6gH
 Nty6nUm4xsKAOFD1TgnQpteFqFH2RLebN6b+qPtpJyGYaF7nyk1Se6OMG0zpyczEDRXig+Thk
 P8Gf/LuRWkuX8IOOnjki1bWtBSvJedbZQrMDDzSFcFUYDMRpqFL9oAkV09JZKhCRi31hC782D
 Mq+6+LvVeDl06sjzTBWVJn6sb8AIEsF6EMgaTHm1VYXAVKMCdwTa7iUCS4Z1Hh982OD15YJ27
 /OGwcCY5X1+gLSIWt9STmH4k+AFEwMqRYWBgfM7piYhItdgXd5rxjdHKib0InE/Qq+lICUohW
 TU3nPbTuhYP5SA4YuDJfDv/EBAT7JqHNZRMKkosdqnlPnZdfP56vbmmC3bnfDHZvdste/hiUq
 UgCBCwa5Ed5fS6rOX5coAwxOggt/YH+XdFq9CmxbqxrA+U0PoQvhUBdY+2xJcQQSK4gXwBOMu
 MWlQXe2mp5+NBBA7GUz//ksLnQXqlI8LNKC42kWziglXzlifxjT6dTvAt4A6dMbB7Swv0xsGY
 sTDAUaemaVIekfnQMifqqSR5SexOzMLIugP3cXZa7EcJW4WZzHZiDASo6hijikYlf/mUadGD3
 zxNDYT2qMAPqqpU367487ZjUZauiWUo57dh2fIWLnjc7jqqqI9on0KJvTIBJmhtmj+a5VMIxp
 W1W4zIX7V6LwpQ4I3C4bo4RSCPPA06DN8LJmMOxcjH3O2bNFTxO24HxDRSP0psWD/DOFgHdAx
 8DQP/7YSl/NtbDWfghbCIi6g440qnaMtd99yV0tfh6vDhx0HNY6zgZ+uw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1936974659-1630590872=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 1 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Wed, Sep 01 2021, Johannes Schindelin via GitGitGadget wrote:
>
> > -	struct strbuf script_snippet =3D STRBUF_INIT, buf =3D STRBUF_INIT;
> > +	struct strbuf script_snippet =3D STRBUF_INIT;
>
> You end up removing all uses of script_snippet except the
> strbuf_release() for it, so this & that can be removed too.

Valid point, I missed it because compiling with `DEVELOPER=3D1` did not
complain (because `strbuf_release()` "uses" the variable).

Ciao,
Dscho

--8323328-1936974659-1630590872=:55--
