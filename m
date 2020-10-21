Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B7DC388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 14:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E6AC223BF
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 14:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EpDffy8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443299AbgJUOLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 10:11:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:60603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437123AbgJUOLA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 10:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603289455;
        bh=dAlAk1HZy3xY3IbjSw/UOGGyUlyniKrG1NrZALd5kcI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EpDffy8GqRFVP0XYXgkgY2YAUX2FnKB9d1z4auY2/LdegmD+fEh+bAWWxRCXKhDaH
         yEXUeSssOkwD8xHkfKYLdSiZiv8TIrdDQ2NJWGCirTtAasFTtRwevcax1oovxWRG6T
         jv6Ob9fAGHzS26hkMav4MB9S4n2Gf+hOEaCLxYGs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.235]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhyS-1kaF243dVi-00Dq8U; Wed, 21
 Oct 2020 16:10:54 +0200
Date:   Wed, 21 Oct 2020 16:10:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Michael Forney <mforney@mforney.org>
Subject: Re: SKIP_DASHED_BUILT_INS does not install git-*-pack
In-Reply-To: <xmqqtuupd5m2.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010211609520.56@tvgsbejvaqbjf.bet>
References: <CAGw6cBsEjOnh-ZqXCPfFha=NYEdy7JDddha=UzAau0Z1tBrWKg@mail.gmail.com> <xmqqtuupd5m2.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eWvWCS7wIS1EC6TJ+AgZuonfdZrn87CpI2SjVU3zT0VN3beEQ4Y
 FoEvsWkKV7Gzqm82geSug9GJHXPzAIkGmeK/c46IjKt5zQtn/0g5iWbT0slTMANAFYDXgIX
 omKQgtwJYsUaK6Fkx05povpbyp1Of+jZME3ncIo8RDrfiB5ngNrDnBeHq2WlLsTKAtY6h+w
 n5gGxmEIxfcNccQi4FXmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N1yE3I7sryM=:rjVE+ir0T3t/y6zGW4YOEm
 sCJe7ZuttNSpguLacOtm5S8e+rp2XCeRuvLkN64Iq3TtsjakpIZg3vVawhIHgVO/HKnPz9L+w
 5RcrzInUnS9v4U5obh+Tn2FBgmukQF858uHvDAAlf+w518TVdU6DyD8WJ4sHU/eu7e//jOY+e
 XayLfAvT2EOJLBSN30893Ud40V+JrGlF7cnO+1qN2Ofwx+4pVk4+ZoPNdZcTlzn61+PVTKoG7
 7ujv8SJg5YTf/Av9Ngl7q2O4aGVEtsT0tspTXQbkJxWn5wir7WVStzitrS+X0Gz77DP3LTOo+
 gltX2qnzZJ/K7XGSPtrrQ4s3o7ua4iczpSECqkiq9hop8Gzg6yk0CUpNBakQCfPbxlDo5532T
 z/sN0oBGBoBnxyfI/qk8ikLWHA7gxGxITTjtSqxZMWhQiTUOSIQWvhfpA2W11lZiRDtfhb0h5
 WsjOkt+Yl/CPmedG4NOHNlTb85qcFlAhTE9rFJzwFD3q6gPI5OvOeCIvB5OwoXWK3+Ymgpl6s
 hppNvyyQvQ5zzIXPbzWFFW24wjJ8TTmDpNUxrKYKeiaUFpqlua+T3t7pNx7/g3WibORgBFwLD
 fx5AJONOTGjtcNWJqC8jUWY1FBQuT/pTuWwdg6Yfk6z/YWxznHsPcynZeQWgDA6poPnX8BbX7
 JZP5PC9kO7Tu55SduNIaapFK4HGYmk12pM+AOi4dBhtRpyeQ3i+Az4T7eFlBZrhwV/GorjTJU
 3TJl0x1QBlu1XF4IylhHQLq6+zi4YJde2aP15D7TuCbeLY4JpyBhe+upy3zWU2DU9JyuYkHag
 BT3MKTz6QKK/OckVJPsEDAa7egCbxBYGpae0H1L9dB6d+Ksbe3QkG2hWpKmjeDIoIcaiqEWji
 N5y3xx+yFScgnQf/jKtiV4Gy66P7HA81e3TruHVc4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Michael,

On Mon, 19 Oct 2020, Junio C Hamano wrote:

> Michael Forney <mforney@mforney.org> writes:
>
> > I saw that git 2.29.0 introduced a new make variable
> > SKIP_DASHED_BUILT_INS. However, after testing it out I noticed that it
> > skips installation of bin/git-receive-pack bin/git-upload-archive and
> > bin/git-upload-pack as well.
> >
> > There is a comment that says these commands are special and expected
> > to be in the bin/ directory in dashed form, so unless I'm missing
> > something, I believe this is unintended.
> >
> > This seems to be the offending hunk:
> > https://github.com/git/git/commit/94de88c986712e79c20813ba54e797c4ca83=
137b#diff-76ed074a9305c04054cdebb9e9aad2d818052b07091de1f20cad0bbac34ffb52=
L2979-R2993
> >
> > Reverting that hunk restores git-receive-pack, git-upload-archive, and
> > git-upload-pack (and only those).
>
> Thanks for a report.  Dscho?

Hrm. We have this, specifically:

```
ifeq (,$(SKIP_DASHED_BUILT_INS))
ALL_COMMANDS_TO_INSTALL +=3D $(BUILT_INS)
else
# git-upload-pack, git-receive-pack and git-upload-archive are special: th=
ey
# are _expected_ to be present in the `bin/` directory in their dashed for=
m.
ALL_COMMANDS_TO_INSTALL +=3D git-receive-pack$(X)
ALL_COMMANDS_TO_INSTALL +=3D git-upload-archive$(X)
ALL_COMMANDS_TO_INSTALL +=3D git-upload-pack$(X)
endif

```

Will have a look,
Dscho
