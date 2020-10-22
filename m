Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9961FC388F7
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 13:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10CAA2417D
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 13:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fsaIXLGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899431AbgJVNQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 09:16:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:47023 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442003AbgJVNQO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 09:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603372571;
        bh=oPK6+X98d5wVtnbELhxFDkp0aCcA62RRV0e8Wci1kI0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fsaIXLGRiZXnlQmf87qBV/f3uwB4oGAOkMXuadvOjXZnfAbCd0jYag7Ll5C62f5bu
         gkBe6BByNnu+BESaUkv/iMbXFOG/0uJgAto994Bs0glJ7gLhQVNE1i8vffRV113zQr
         Kb+99vkT0yxr16AZx8vFJvP6XbTKC2iLltsOvtzw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.45]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlT2-1k6jIT2OYQ-00jtAK; Thu, 22
 Oct 2020 15:16:11 +0200
Date:   Thu, 22 Oct 2020 15:16:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: mr/bisect-in-c-3, was Re: What's cooking in git.git (Oct 2020,
 #03; Mon, 19)
In-Reply-To: <xmqq5z7371i2.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010221515560.56@tvgsbejvaqbjf.bet>
References: <xmqqr1put77h.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2010211647050.56@tvgsbejvaqbjf.bet> <xmqq5z7371i2.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hTJKjJRpvQPGdIXnVsnn8g53A8ETyYusengJ4JMIATwf6F1jKG+
 RJcBVYQitxSO3u7YWVwdNt6uVG7OY0P83S/C0zbGUMU52BM3JFN34zr41xSboIEmCIrP2N4
 cngkQfzD9YD0OI+Q/qGubrcvcciqfBxgcONIB65nmu9iqYLAgMlZAoRtHayMV/iP8roLxPf
 G6yzvQmGvQ/YD497NhV0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QWqqCvjQrRI=:noR9Rcu3vzC5LQa/64lIsG
 PRZ6ip57EKdrE/3XhOanLsEtLn/oZHVfPPL6SJja0OUiI/6g5Z+OTsU+EwVvI8cFKy+nny/fw
 csODxE2Mj15ui9MWv7Zp5kFn8NWgXmZII3iJhUVei7wfIdDy8ZZH7nn7H9f7OoTbB08TVh39K
 /2Pl0a/Q1X5wh8dXJCaVoNtACL1zqbbSKlmolugQEqkuy56bX8tDnOwhgYUnP1ODRczwXMCGT
 uc+WWtMyxiCRkouTGTQiQnmHhuF/FAAwnho6StjPdHdGDZCSmffwhIK06aknXooWIWXEzkQMy
 7t1ubXFCNqhYiLsn5RFOBUZwBY0RGrdhbax5zqoPNHQJsAc+ojdTBr5tIOGtiCeZKS/cc6zKx
 tiypV2rocATG0EFP5wPdm1ma3uW8/qC/Bq6Ro48sK91zohcKIxMQoG0txoJrC88LC1x9n5+M/
 ZIdGGMYGfrHSgbNc8Dnq3Cbyb8qOgGCqa5pSw38dqskfOR5j+ptUGCC1C4vYbe7eY7aZmPKax
 BuFyD9V019/ji9rnmCfXNOvzQXLWrvoNsQo/BMHljcGddwzmnjAVsPLrh3RUxu3Iya/TVDsd1
 nzdJDCM0qMPDaF0G7btmxXH+jAzmnNsGi9B6n2paKLF2mwl0Y1kj16EnOpco9W88dWnmEfOyh
 t43zzOWIdYr2NFBXOEXGQ6N2U0YxZ47cjr5GiMbSd4gBEta0inL2cTSQ0GWmRp5di52OjMDo1
 NoEnsyo3ofPNLTdvn7bGvCXStyT8CJejbvoil60MblXT0JIi8l5Fl5YjqVZ4i8GiBT8BM7Er4
 YCozuK/nOkPXyoonwqhAd6YGGn24L3Y0rOGnvmZCYmnqeCvkXFHf75ww8R80bck7HNlZKKE8c
 VtKElJb7U/rPb+IJTZdJ3nNgZK8Vx2Wu3+DaoAgeg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 21 Oct 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Mon, 19 Oct 2020, Junio C Hamano wrote:
> >
> >> * mr/bisect-in-c-3 (2020-10-16) 7 commits
> >>  - bisect--helper: retire `--bisect-autostart` subcommand
> >>  - bisect--helper: retire `--write-terms` subcommand
> >>  - bisect--helper: retire `--check-expected-revs` subcommand
> >>  - bisect--helper: reimplement `bisect_state` & `bisect_head` shell f=
unctions in C
> >>  - bisect--helper: retire `--next-all` subcommand
> >>  - bisect--helper: retire `--bisect-clean-state` subcommand
> >>  - bisect--helper: finish porting `bisect_start()` to C
> >>
> >>  Rewriting "git bisect" in C continues.
> >>
> >>  How ready is this one?
> >
> > It has been reviewed _quite_ a couple of times over the course of 9
> > iterations, and I think it is ready now.
>
> Oh, numbers I can count.  I wanted to hear "yes, all previously
> known issues have been addressed" from those who did read everything
> in it and gave their feedback.
>
> Do you want to give your "reviewed-by" now?

Yes, that's what I meant to say.

Ciao,
Dscho
