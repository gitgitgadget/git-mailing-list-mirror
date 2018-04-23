Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BF4D1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 12:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754802AbeDWMWv (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 08:22:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:55121 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754710AbeDWMWu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 08:22:50 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0McPvw-1esv7C3SSW-00HeFa; Mon, 23
 Apr 2018 14:22:42 +0200
Date:   Mon, 23 Apr 2018 14:22:26 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v8 06/16] sequencer: introduce the `merge` command
In-Reply-To: <0b0555fb-9fec-cd9d-f2f2-cecb51412128@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1804231421330.15174@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524139900.git.johannes.schindelin@gmx.de> <cover.1524306546.git.johannes.schindelin@gmx.de> <7360a072f6fdd276d30839613434329b645e2cce.1524306546.git.johannes.schindelin@gmx.de> <b05915e6-2259-5dee-69d8-90a5a524662d@talktalk.net>
 <0b0555fb-9fec-cd9d-f2f2-cecb51412128@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YX0hP/CzTjntzzXNdmicjbLsByWbIQUKLYFhoF4aGYQjx6wpMN9
 hkONlfUKNrq5VnrrlBPphG+JHemcM12ke5qu5SF7ULBEvQhES9I3yVwyjDW7U5Q/BdJq6eC
 NWcdatMH9GcpIUrN+Y+Wwy4k2u8gqBVLVhLVDAQTIGXUVP03XyAJQdLwQPE6NxOIWKjSpaI
 ekmKgF+Tql0mSWJ2dnwlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ShnqTbIt5NA=:zxgPxYH50CMgcwtRQIC40x
 qGsIhZxijzKewic+sG6hUrbtNlZwS7ax1sGaZXbTcTa2rpTBf+dcYJQwmRPA8COtAN1qvBGwn
 y96QQqu3AOOjGkrbJAzDAulQpjpVrKAj2gslrh2RxUW5x0AhPTmuHKWeylYpFyexQN9vMEVti
 IFmyD6I4FSv8jP1+OtoM/Ht2OojRvfbKG3zYaMqCmqdShZJjYwHGr1nmaL4p3GxGW0AezfEww
 5jC2AlM88XNfPnVrE5+Z++TK9MSCSeC3gOfAfgOmNpho/173nKOUHDQd573EvaQysiGuTzU7p
 ygiFaRKgYF9FGTb8mJFeCI/1hgEw3Zawrad/SX8JsDbTRCczKCc/VPM46g91m41+ml/uZfwcr
 +D4fNcZTUKl8u/7hyohgYVPsIbEP/zYMNHbMxDesofaYRKqi3EXR463ToEMK4VpXFr0I4ErMt
 uTW92JqysRfMM72rg82qLONCnGl0Pa+W7GHbyzU081tlMD/Zk80rFecYT+hZ42G5UryLyQZ0q
 jLsxIxCISUg1A2ojWgoCE7cGwm70xiQRDDD0DAO0f7zdVGF6wdLy/f36U8w/qzcjR78UuGOD2
 PZpo40kpMPBhV6XLT5yOTp8VtJrr7GohcdG7qEvQWmW5/TSdm+gl5rDSQd8BcQHVCYxL+dzVr
 uvP34+mQoE9Nr/JIOr18wmkG6HGofm7bQxXfxS8vQx5/sDBbrXWk/d9WSOQhiZljv1nVYuoLi
 isVrMeu8ku79TJPNNHJW+Orfz7KIdkoJ++LBpZA3hiBWGca51ZdyNfXb2ZuzlAGQ8sioo3MlK
 Fj5BZalqlEuRhBMXoR8Qj4Jgl+HUj1zI/5QovkOWdeppcxq6CA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Sun, 22 Apr 2018, Phillip Wood wrote:

> On 21/04/18 16:56, Phillip Wood wrote:
> > On 21/04/18 11:33, Johannes Schindelin wrote:
> >> This patch is part of the effort to reimplement `--preserve-merges` with
> >> a substantially improved design, a design that has been developed in the
> >> Git for Windows project to maintain the dozens of Windows-specific patch
> >> series on top of upstream Git.
> >>
> >> The previous patch implemented the `label` and `reset` commands to label
> >> commits and to reset to labeled commits. This patch adds the `merge`
> >> command, with the following syntax:
> > 
> > The two patches seem to have been fused together in this series.
> > 
> > If the reset command fails because it would overwrite untracked files it
> > says
> > 
> > error: Untracked working tree file 'b' would be overwritten by merge.
> > 
> > Followed by the hint to edit the todo file. Saying 'merge' rather
> > 'reset' is possibly confusing to users. Perhaps it could call
> > setup_unpack_trees_porcelain(), though that would need to be extended to
> > handle 'reset'.
> 
> 
> > Also it currently refuses to overwrite ignored files
> > which is either annoying or safe depending on one's point of view.
> 
> Looking at the existing code this is consistent with (most) of the rest
> of the sequencer. The code to fast-forward commits will overwrite
> ignored files, and I think the initial checkout will as well but the
> rest (picking commits and the new merge command) will not.

I never thought about that... but then, I never came close to encountering
such an issue, as I do not typically turn ignored files into tracked ones
;-)

Ciao,
Dscho
