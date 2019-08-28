Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D6271F461
	for <e@80x24.org>; Wed, 28 Aug 2019 15:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfH1PGr (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 11:06:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:42991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfH1PGr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 11:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567004796;
        bh=YhoEk+Az8NfzcBnVQG7k8zVnue68EgLof62YB1Ao6cU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ExOldjh+CX+TzqDOZwGjo9V0EswHq5nb0pHPJQN2pliqiPFtVv3yzb0KUgIcKHHtN
         5ELRYVgsWdGEsXhxDl3PfQ1WLB5HPoWXU3hPdZQ2SiMpAxBkjqvRIjkKY5C0LNCbFn
         PzFxHDs9mExH2/3qJKqsT5fKld4VpaffcbZRtIaM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCtZ-1iagWJ2RLL-00bNe3; Wed, 28
 Aug 2019 17:06:36 +0200
Date:   Wed, 28 Aug 2019 17:06:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 01/11] Start to implement a built-in version of `git
 add --interactive`
In-Reply-To: <xmqq5zmi2qkp.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1908281705230.46@tvgsbejvaqbjf.bet>
References: <pull.170.v2.git.gitgitgadget@gmail.com> <pull.170.v3.git.gitgitgadget@gmail.com> <0a5ec9345d2f9cc6cd348231219d4af428a28e94.1563289115.git.gitgitgadget@gmail.com> <xmqq1ry6qeg2.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1908262317250.46@tvgsbejvaqbjf.bet>
 <xmqq5zmi2qkp.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RNqfwE4Y3mp1wSO4Fbpnk3QlHvPpEoFe4wV5ICO1eB0lV7hGICP
 y1mE+dDedqbwpHT6XsEQaEgMQ0Xqg/sBTuK/5ohlYsHoZfIB3dxWasFOvFVUPg/yEQlyFAe
 PpvicnR+pgrwUUP474HV23WVj95pzHDpPo5kmchFbr0RlpAhw0T2ecFpiAfrJvw1rIEKlbF
 +47n37Gk8voWJDQqMQe1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u+dUAtXGB0s=:ZARV4WNlT4DYTGuIGzJA2y
 1byKMWRf37ygSFIZffEraEhsTQ+yyfF5GiMFirvVI3xpvkwhelae19rM+W6Rj2PMLMx8t1kGm
 fIZmUfWfZG9yVyARsMO8VHuUvTjfB6CaaO3b7ip8puKF+RauGgZ7coH3z4xeFgu3wRbthTV6F
 7OLRY73CpsJ3wVb3zVPVj321I7fxZfXbvEyQKFctiMHvnE7hU+t97UxtPx+ZUErbI/Oczx11l
 9279dXe672G+rjo4zR+sIrdjh/C+hHqBxPwV1p378GKx8JATyRKKApzXl4I3TFfK0uv+iZec2
 maNZabGaxJmVhG9/Ny+hF/9LTpbTvZuQH2WmzD87HZnJlnDMHZdxI3VtVCc0q9oeonm2/6ZHi
 UM9xL+4DKYOMDHCBJKrwglSJdCbAeHtnjc/ZFjQ/7dkigYUiUT+8mbN5eDh75r4Kb0lL2RqnH
 8n5ccXwFiXL5j2OVeee7vx3tFxcQABBQPB6arwPYHsDkS6/YRinVugDidsHaDtr4VF81RQ6yV
 Xyr3NDq3hMQDDiK7RTII7rE3zo1E6BAn+4MRqobu/i/5Cbiw7Poev5Gn3J+yz/zUxdYIxIifl
 d7c41DxaHvzkaJfqiW2a6Q4K8fM8Xa2QEeXW6AFm2v/IUWOdL1z5Qmb7qChM6dz7icf3ZP/pp
 CwW8vWpcVnldRolt4lglvDWRnJkP4SlpNHPVagYBUp2b4Pg3FuFrRgdHkD43e6YhwiKi5N1V6
 VcVasi1xNlt6FJVuQbj5jxHgmAfntBkvASBp4Z+Fhj3DHP+3GmVJBBUSIaKWBHWGKdc4SBkui
 vVCFqfGoCQ/4FMfYEhQT6O0cdJIoEky6veLIfe/gf7CYne4a3SmhvReOVKQrKYZFfd7d74JuX
 OkAbwDB+MUnCwaF15AO8IoH3PO7E77PZ90VmxIL6zm7uwgrbq8nRU/j7yHe4RNyGavPwuu0s5
 ofCkjUc9WZZl8DZmtBZruLhPjYXXAvhiy29qRjb3N93w1PIwlJTdJqOCmf1olRARFwDWQxD5i
 RvizZWU+V/np6NFoPWfbFS/cgfE+OKZH6nSTvatCgnBLWjftwRECjf3SCtXsT+LSR2PkeHK8o
 YzlaFM/qkFnvoZGi0OhG8Wbf6G1ekt/t5rsu24Fw+13AtiskqN62S4doJA3bjkvOIstLlU6lD
 M7AEfgHRnBLaeOUikgdp3Eu2kBLTAb0783mz77J3saLq8VEjNVFz4UM+SI2Y2/hyzvwFk=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 27 Aug 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Besides, I really hope that this would be only temporary,...
>
> Oh, no question about it.  This should be temporary knob.
>
> I still do worry about giving a bad example for others to copy.
> People tend to copy & paste without thinking.  Either we come up
> with and use a two-level name, or we add a comment to explain to
> developers (not users---as this is merely a temporary thing) why
> they should never follow suit using three-level names for things
> like this one written in big red letters, or something, then perhaps
> we won't have to worry about too much?  I dunno.
>
> >> > +	if (use_builtin_add_i =3D=3D 1 && !patch_mode)
> >> > +		return !!run_add_i(the_repository, pathspec);
> >>
> >> I am hoping that eventually "add -p" will also be routed to the new
> >> codepath.  Would it make sense to have "&& !patch_mode" here,
> >> especially at this step where run_add_i() won't do anything useful
> >> anyway yet?
> >
> > The `&& !patch_mode` is here to allow for a gradual adoption of the
> > built-in parts. ...
>
> Ah, so "add.usebuiltin =3D interactive patch" can (eventually) choose
> to use the C code for both while "add.usebuiltin =3D interactive"
> would not use it for the patch mode, or something?  Or even
>
> 	add.interactive.usebuiltin =3D yes

This is what I had in mind.

> 	add.patch.usebuiltin =3D no

And this is what I should have done ;-)

But maybe I should do

	add.useBuiltin =3D wheneverPossible

?

Ciao,
Dscho

>
> perhaps?
>
> > Of course, eventually this will be handled.
>
> Yup, again, the knob is merely temporary.

