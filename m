Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625A5C433E0
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 13:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA3920772
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 13:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="K+MsqE1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgFCNyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 09:54:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:49061 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgFCNyH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 09:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591192443;
        bh=IF+xfJBpu2lBzUnnHRIA/O1PLhY89HiX+VD1nKX+Z64=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=K+MsqE1sS6mhiTMmbufqQX1fEyjwu46VyrLKVz1RTGdWofunb206kP1uIEj+gUAUy
         iXMxKDn/D6yXfPVTQ8Jhq2CcC9xP1fPupdek89Qxa41aUACFfoZUTNdFPI/em3muk7
         FeuxaMzAqC0q5qyEbbNTHRWS98c13sk9tdL7XLl8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.16.94] ([89.1.215.145]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Kr-1jbGm13PFb-005GeI; Wed, 03
 Jun 2020 15:54:02 +0200
Date:   Wed, 3 Jun 2020 15:54:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: symbolic links in Git for Windows v2.27.0, was Re: [ANNOUNCE]
 Git for Windows 2.27.0-rc2
In-Reply-To: <xmqqlfl5rwug.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006031550400.56@tvgsbejvaqbjf.bet>
References: <20200526204539.6181-1-johannes.schindelin@gmx.de> <nycvar.QRO.7.76.6.2005282322580.56@tvgsbejvaqbjf.bet> <xmqqv9kats3k.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2006022232340.56@tvgsbejvaqbjf.bet> <xmqqlfl5rwug.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ai0isMFbN9c7o3JjMl/GwGQmmdxNgH/ficZ/9ORPooVbqlos3TF
 LldUop/XOycfFAvmfLoy23xEuQFOGsvc9JyGNyYieugrPLnVUkIi61u24JtO/2FBnbS34wg
 30i7ZRlP9QO53eTSNCa0Cs8Ol24cvWvBggpepeBZrJnAxE5R0N5MxBfV6Ep7R+1M8W8m1MT
 /AsAXnk5844IehOZK/WmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DshZr8EUU1o=:Kxql8+hIOw10pZTFmwOH46
 fAHPEZhOryN6Xa1m54x8nFINB3yJP/bek5pVYmQYNbSDaCIoZOFYPNCcxPivJutN6zkIUnmbl
 538hRdXtAkGLjjkF/jcfs1MdQnmdT4X/YUnBlzF31ljCyj84DmmDOBnAB+su+H1nNMXjvaSkV
 f0V2FH5niCpaMl/B2UxwfpStuepOiD8BFD7GdxQqMP1c02yzWqgKfM4Tpk2o68xqALlWDLBxh
 2ZF5JCZREFWzNVDlGWywYNDsuAkt0dnBXb1wApoPyRhz8dGhsW6LlbSkJnVBeGW7mICXB5c+c
 Z8Jk/NxcGR6lIiRBNnazbkAqDKAsVYlJpATgjbVZDSzNwMUJTDNDv6ZxQXlS/KmSVK3Y9DXxf
 yvlWT5DI3Opt/CK2XFqDrlhAIJwFASdx9URItTaReGCWz/w9EuIV6vKBqxbmi1Rs+O8ECSVTs
 /kOWlNaJtni5X7yVxhrKKLsQ/Q6wRV9Mmg/TRXd7OyBgoXPnPhgz+UWOhbyhUqZABDbWvRVHT
 hoeFk8zG8pA77oSAtne1bB6mrIZQFbjgys3yjG4rWHRC4giLB0w5aGlku6O5k4BhJS2O7oHTh
 I31oe90YGeUDu0+uDbuUadw/TQJx+RWVvMcI6/cMxQTfLFrDWPFzZ0DpL94vx+yQm5zFwrBpP
 DDBoG84dkEj174TsP15b/tz32DO7WaPi7k3AynDSEuoOgLIJzD5neq5lHryTLzL9Z6myXGcHt
 0Sme1i3oL2ows2FEZJd8k/VVjFW0z8GgJkJbdNBHzlZpt5F0XdOLge4wmzjpa52NWBHaldbZt
 4rLfGu97ZJd+U8QMF3WGlAQxLo/0khSo89R320rNZwu2C4JtG3Nd1CG1c5T1vU8ZZ38nGnU98
 fmnZY1Zq7xnUZbBPLJhp5wOXjS6RtZYqGYAc1TgsJJqrDBNSGygxx22ky0pFgKi/thEZP9+d3
 vAflfSgV1FHhS5brs3u5egJjcZNGsLNOE3JxZHWAN0jFhwi/9/vHitnEr9vMo41biqo62gQCl
 dr3//D3FSNPuRHgZDAg6U5DmJCvXjIa7mwQJosfXfYRhLimw9oZxg23MHRj6i05cgwmdSdmo6
 bXzLMsy6T6vKU7RDrjrWDEFTvny8b/ugcwd6jv8jg3p1vxQD/R+QI42qDAO/ZV4IFFmP4GCdJ
 jy6kV6Ii6Wz6q7vIwyL7Qn6RbIxI9EVm33qRCs0UMntkZXRv72QBPwKyKKSsvJAU6DlsCcVRG
 MeY5eOBIQRyGCdc3J
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 2 Jun 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >>
> >> > Git for Windows v2.27.0 will be out on Tuesday (or even on Monday i=
f Git
> >> > v2.27.0 is released early enough).
> >>
> >> Thanks for a reminder that Europe is ahead of me by about a bit less
> >> than half a day ;-)
> >
> > You're welcome ;-)
>
> I'll remind myself that I'll try to tag and push out the final
> before 1700 UTC, which would be around 10AM for me ;-)

That will work. That's 7pm for me, which is still safely after-hours, but
it's better than 2am.

On the other hand, I do not even think that Git for Windows versions
_need_ to be released on the same calendar day as Git versions.

For v2.27.0, for example, in hindsight I would have preferred to wait
until the next day so that I could have tested it much more thoroughly.
The symbolic link stuff we were talking about does not work correctly, and
I had missed that because I just "rushed out" a release on what was a
holiday for me.

So while I appreciate your concern, I think you need not bend over all
that much, it is not necessary.

Thank you!
Dscho
