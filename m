Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C3DC433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 15:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352338AbiDZPdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 11:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352334AbiDZPdi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 11:33:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16CEE025
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650987016;
        bh=9WaOMnrfSthWBDr6OWPo7jSnO9G+d7sINCDL/wUGrHI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lr74+qhtiN4OX16lQhTjhUQlb+66N2nZ/KKBedNMpz977JAg7K2ys3UAT943Ej7RQ
         s2eIp+KRIKqUClcRsFWx4Xibr89SVSgW8t8ioxgDbXBfSLK0BEIU+nDpSy7Hk0iknQ
         jOm/LgTIaMGUuCt3AjORv9mRMTyCAZ6KBKh/cSuM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.146.35] ([89.1.215.71]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mg6Zw-1oMYVy1GQQ-00hiSp; Tue, 26
 Apr 2022 17:30:16 +0200
Date:   Tue, 26 Apr 2022 17:30:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Philip Oakley <philipoakley@iee.email>,
        Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
Subject: Re: a problem with git describe
In-Reply-To: <xmqqczh73hns.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2204261726460.355@tvgsbejvaqbjf.bet>
References: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de> <3d762060-b817-0246-c4a2-8eb35096cb7f@iee.email> <xmqqczh73hns.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+87wZyAuA9ImKg0sBn8+ZhBNINtX80hk5jQui2DlLYI60BHvGKW
 7qJKpo6Uuc2ldPEjS7dw1Ic6GZ2N5QoVr+nOS40K4Q92C0cC7FNK4goD4BjqFRZ4iFTrvKG
 XkzjVHR/3LB63Ys+2Y4rzgYdkWeY6Lg/MRjg3gU1EopZ4G1y0T2Q84k7oOiBt0j182lbmm8
 +zEeakbN+Tp3Y+mnMiCTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uR6l0/B9z5o=:UHHeJOopIR/JRjC9Kf8CSF
 J9lpAkQ7LDWWMNDK/8goFhy+/KLazUoMQCuYp/mOnQ3Z7B2/6dy+MyitBe9tSUByPylWwdTw/
 FRMpxiGIlcZPuNRrKUMof+Nheg+YDYOUYZMkWAbrMGelgCMPqxJ7c2j4KvL1rHGIvMWukRsqJ
 tS8Fp96E7XojyEngcIaD+PvaMLcAtezftQiI7UrLtm+UkOUvcdCtuNxXjXhyIOHk0BfEOHwoh
 YJRWL8IsdLTDg2dG9pGwEuD14eVLphzQnRehnXIUmF4xQe9E00SLGc7bgOorVKp0PNlzDdsxD
 oV/EvAGqHAJPKshGmgwyJVJz52Qnf4+oNi7JyIweOTwOeX91ph2KdO9GZMZXtghjThSpKG56g
 xtA3VlIZDFHqqcwVh3UKvyK4O4sNRMdZ3yXW3gjr0i3lrI8Xth5bIEWwbQhm4MN54WCDi+Ht0
 h1ZEqgMCxt8jZLFMSNNA+ho0tsEL37caGsKLCx10YSR4dIR8QdojLZHxgwUG57JjhiC4F/nZ4
 LGBWq0swDAly4MebyxdAhaUjhnbOy7A+tn6++nlP9ZOWVi3tlENDBbAoXOlg05GDce3djnrLs
 NjRMeIxcKwTrUsuaY1Zyr+MjHG/EbImC0h/tLJcPP9GKy+9d/b1YvfBDtJMRzjJNMdo1uyD93
 cZj1bxz99rbTPZV115TbBEk4fE9RtTfo1DBQMw3RpMbTaTFqsP5bT7UwfthamyIntEOeSFdWz
 nMmC7WhsG+3nVBnmu+KatZt+fHvyKHt729fCmkGqhggbTkAMnO+8Tc5DFudEhcz/R0Aa1V9uV
 Vkr7L8b88coI+pEGSusN3x2ZTHGXGKrixSmvUPu+cx8L7Q1siesHDZoANaUQVrp/U3jhwOmiv
 ilB+QRI0fBU6iI9sRKKq4WRkdHZ9TGRuVF68ebHTRD0it3ddfDs9U5P6cRg0J4ep5Lua+V4Tl
 V5LxUVD7Z+mbrM9ZKUqwo1LVVqoLadgM8N0Bzj5XDzY31TNSBicgb2l6j5WDZrZcdPEiM6fGW
 KnP0RdnHxyZQW/8oKyQxnTlYhqFFnC/4IyLdA/znbCEFGiYs/9Hz5jax9uZsOutmkYCsh7edo
 aT/sUD1RRTrnUM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 23 Apr 2022, Junio C Hamano wrote:

> Philip Oakley <philipoakley@iee.email> writes:
>
> >> guy@renard ~/Software/uncrustify $ sudo git describe --always --dirty
> > ...
> > There has also been added an escape hatch of allowing "*" for the
> > permitted safe directories. but do check the updated manuals, and the
> > git mailing list archive (update the search in the above link).
>
> In this particular case, I do not think '*' is needed, but you need
> to be careful here.  Whose configuration are you suggesting to add
> such an entry?  Yourself?  ~root/.gitconfig?

One relatively simple work-around might be to call `sudo chown root .`
before running `sudo make install`, but of course this would require the
`rm -rf` to be run via `sudo`, too.

> I wonder if we should loosen "the same owner" check somewhat to
> cover this situation better.  I expect people also run the
> installation in repositories they own with "sudo make install",
> and complaining "euid does not own that repository" when it is
> merely because they are running as root (and their real identity
> is still in ruid) feels a bit too strict to be useful.

It's too bad that your fix to include euid seems not to work. That would
have been my preference.

Do we want to make use of the environment variable `SUDO_UID` that is set
by `sudo`?

Ciao,
Dscho
