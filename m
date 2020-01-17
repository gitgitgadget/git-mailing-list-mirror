Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45840C33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 09:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13ED12082F
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 09:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DkPq72uf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgAQJtT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:49:19 -0500
Received: from mout.gmx.net ([212.227.17.21]:42631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgAQJtT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 04:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579254554;
        bh=+PZmCy5NEXQL+Ds3tUwqsRw02V76f2kWnJj6Nr4pwQk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DkPq72uftvI77aOk+U8iSs10GDCIIXgiqqVXGAb64q0/ufzmQjWjsH+Phx+6YuYAM
         GRLJZVhKJUEBLKXy0v+Kpj+2ILgWJs3hqTBtQS5czKM3MFyHO3c6Ug3AcSCLfwOe9L
         1Tq7PGnw7mJEk8nzQ2/LkXXEEMdnjbNvGg0mspco=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33ET-1jdOH10UhB-013MSb; Fri, 17
 Jan 2020 10:49:14 +0100
Date:   Fri, 17 Jan 2020 10:49:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
Subject: Re: [PATCH] remote: rename also remotes in the branch.<name>.pushRemote
 config
In-Reply-To: <xmqq7e1rf0zg.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2001171046460.46@tvgsbejvaqbjf.bet>
References: <5a8791ef1e262d2078a4ca26b87bfbd777bd4432.1579209398.git.bert.wesarg@googlemail.com> <xmqq7e1rf0zg.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FW+HOJy/xBkOGMDrv/FUaR134ox+V+9Zrjm5f4e9utjqcH22YKN
 TSWLFiWWglqEsNd+851nRuOCipn5LIvSBKJtYfADq5SJMzH1U9ShObG4gjhMI8TyDALmT3R
 3exZXlS/hhxYjPg2+TOl9CpyetM5eo7dwxzbqYz+gzQEDC96PTnW6UiuRd7e8AWshXS7Hwb
 LwnFXdE9ztnzzfSMaLizw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lHre8R1hlkk=:V2gM1VylMBrdM81Uh/kc2L
 bgtQHhUvlXRtejvdIJY5bHdfNx/Z6JxMgHaqCxLONzMeihB+oslgovzqpXDCgD9+J31KcqvIr
 dzFK6PTtqNonG9UEHYXLnlz+n8oWKOiB9j6lb5tZ+THGw9Pwn+9cZmKt3YHzmCtn8SCYwg2ds
 x6lS0J9QsO++ioM2fIoK1h+/f37ROvZrpEO4dKNQ8q42rjB7B486G39rbouP3mCHt3oL8LAqq
 i3nJp3VHZIMM3o9UFzIoA6jUJHLFFJQ3jKI3BHmyXm+XQAd3c7GsEJVgnRAcsEJfW4etrdH/h
 fZ/v6XWYGtlWz3dn01b919TzvWMG4Qh1M5cNngPuJXeapEPe7+dVftYesMmgGQjOHOmikaTei
 RmNopW520Q+m5cHtv9Lt/ZLCUVmRBXY0mWXoChPkARCDmW7b97I0kGnAqTpApGDKgWTUdrgNi
 fOfz3AgXP0Tl6toVhrbQGZde8E7PfddV7gd8ieAedoQX7ZUu7trh+xmupd7VABb7cyptpOrfH
 vbXwtGeYASrFkz4lVyYTHO6QWRJ8GWvQZsOetisAnwD88DP6fQRPuRtz3WeHNXH8Tc8pbuocB
 CWIxMOKBFLtyHr83VJJKNX9/1PERsYfxz4THc++5PE6Ee/j3tcHrX2widoZgteUl7ivMrtOMy
 ZgBO8KbYyhxD/ZB7TmKZen0WEUzbBoGLnjTvPUS4j8J2qJS9lMqIpbaLB8z6hgQPT3zU6y1DP
 TGfJq1yOsoxFOj0AJCY7a+cyBt2B8dADzvSnbN1SFlANypMZKjqLlaapVQm8xcSGUMQfI5dJo
 AO80ejJ8coo8rbImaEc74t88EP9aYJXRlTOCn00z7EiNLWOdx2bIiQtTZFPyxJj8fzlLqFt9g
 Y4RNhN3h5SlyWEFrfJjbCU6JC6TS1dnyCnnF7QW36m2/gHK8OJu0u3fpWjLaRjyr1a61jYOB9
 z9XHJFRHcD1ta27DpflhpBVRMiGYyxIFkDH9HU9Uy6eVhTxv7EwAKhzEZsHbUeVW1oLUypJkB
 VeCyDNoK2in7e4Y+qzxUOrnfixPyPCYcQLR3YTjNc4m58nlT5im0Y0/N18f8nei5xrwYHXN/b
 1mtY15xzDXstnokxroMFQKC1HH4aLxT68h0Mvnm0omKyTiNt72sjXzU2GQKAn8wGX3Ocv6X/6
 RnyNZm7czNVGGd7v+t/MF4XKEijiIowCsQ8Hhe5ImJnjqLFM2Pi5zYKcORSeqwcM21zf4Y7Lb
 NWmu6VoDXNYAEPWtFpuilzg+slO7JQe3CDQcSTq3/uG/LVCZh2Onj0V9pwp0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 16 Jan 2020, Junio C Hamano wrote:

> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
> > diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> > index 883b32efa0..59a1681636 100755
> > --- a/t/t5505-remote.sh
> > +++ b/t/t5505-remote.sh
> > @@ -737,12 +737,14 @@ test_expect_success 'rename a remote' '
> >  	git clone one four &&
> >  	(
> >  		cd four &&
> > +		git config branch.master.pushRemote origin &&
> >  		git remote rename origin upstream &&
> >  		test -z "$(git for-each-ref refs/remotes/origin)" &&
> >  		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" =3D "refs/rem=
otes/upstream/master" &&
> >  		test "$(git rev-parse upstream/master)" =3D "$(git rev-parse master=
)" &&
> >  		test "$(git config remote.upstream.fetch)" =3D "+refs/heads/*:refs/=
remotes/upstream/*" &&
> > -		test "$(git config branch.master.remote)" =3D "upstream"
> > +		test "$(git config branch.master.remote)" =3D "upstream" &&
> > +		test "$(git config branch.master.pushRemote)" =3D "upstream"
> >  	)
> >  '
>
> OK, so the issue the patch wants to address is
>
> 	git remote rename X Y
>
> ought to rename branch.X.Z (for any value of Z) to branch.Y.Z but it
> forgot to do so for Z=3D=3DpushRemote?
>
> If that is the case, I have to wonder if the patch is making the
> situation better or even worse.  Shouldn't we be not even caring
> what Z is by not having to list these specific keys?  I dunno.

I think what the code does is not rename branch.X.Z to branch.Y.Z, but for
every `branch.B.pushRemote` whose value is `X`, it will now be set to `Y`.

So we really should not touch, say, `branch.X.description` because it has
nothing to do with any renamed remote.

And yes, I agree, the commit message would have made for a splendid place
to explain something like this.

Ciao,
Dscho
