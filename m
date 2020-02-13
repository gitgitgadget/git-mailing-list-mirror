Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E43C2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 12:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3AB217F4
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 12:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XbVF9+YG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgBMM0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 07:26:42 -0500
Received: from mout.gmx.net ([212.227.17.20]:33071 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbgBMM0m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 07:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581596795;
        bh=UAXGDXFfGimmJuoB+49nFj2O/MAln1rG5s8jiXWMbyw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XbVF9+YG4swGoc05okfh5n46BKWdpMHWy8ibuLI36DFxzuzs+9M8jN/8D9Yx//44o
         zKNg8lB/IFW0ksFdndWfMRbUWTI8gD4cFg+i4nGwe0A07uKd6XLnEjwXcZplDEIjdP
         nsDrcPvgZCfNbO6RO/7HR3OJPdjvQmlsGfIGGMuE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJVG-1jfQXV1PLa-00fTHK; Thu, 13
 Feb 2020 13:26:35 +0100
Date:   Thu, 13 Feb 2020 13:26:34 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: bw/remote-rename-update-config, was Re: What's cooking in git.git
 (Feb 2020, #03; Wed, 12)
In-Reply-To: <xmqqo8u3tqly.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2002131325580.46@tvgsbejvaqbjf.bet>
References: <xmqqo8u3tqly.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZvZmByR5y3cSgvxodxoVY+I+beOLKqxvhSe1AoaPjlnGmBZ9Hwe
 c8Fx0Gqqum4nzQKbEWFer69aOWorB9Jrg7vWJ6tgPcWQ/q507FMnTJ2FNYYwJxdCsVgWSzd
 gAW4rw+H9UjNLMrmijVFqRbjEL8GcUVGMzq4SiShg/xhIrYOkpA2mi4Gx0m/2u8hvhLKJ6x
 2UMXUZ7ZUCaqnqkceovTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sc94zbJxyXU=:fCSwsXDubB2oS0xbViBQqZ
 umOaOeaIIQgsG/Uj+ZwZ4cWcYLjCaL5TGT72BkXjSoLwGDfUJTbFkLWX6FO+x0uSUBR6l+rT7
 aiCY65Cd8ECjiC4c3dgCLB+955Y74xmxzCUhV/BLZS85xr1fXvstWRTruTjorKCQIdsUkI0KO
 XvrHhCnE/GZJm2Vnix9hdYMzNCgF5kgBCisYNqT807VrB4JMDdEJ5KHrYNwd8OUZffvX//7Iu
 9tm0b/serQXEx/rE2szyLepl/tgal6JciUPeJpFDPqVwBgCSDGVpl+NNzEUbrUcJcYTDoa32f
 y6kFqBJwwSyNZTtqIC5xXpzPITpRfdGWtxclKe2gp/CFOQd6MgutZuRMs9eh2/xjDvJbQPHam
 TNKjChHq8Db84vEhxoI9T41ARlYFfLRVD3SU5z5rjJoMGTB6vNdlj/Zl/XmNmbZfpBoyDi3+p
 5kyX+cKmdIwAJ522m7maRet8qeH9jdWYMJgVJA77YpnsALGtj7V4RHTD708s9KcXDtsvRHRk7
 RxGsVxP0VeINIsKaqSl1jhQEqRNybSwITjXmh1F3lcUZpOCu5ti48b1H5PaxK7eohAl0Ayt/D
 4tlgDOMXmmImG34740uHuK+0qYwhN2Nvoez/g2lwIEAnniETJ0/abnCo0lwY25admByODQeH6
 ldT1EtNYQMfcVGU6vehpEdgV80RAV+IvR8ID+HMk+qoXfvWaSvyFqlfbONtVQ5cdGx6JjNXTo
 uR+1G8PV77x19WjKg6/C7wZq36aO6hDM9n6Llb+XYanMSGX1JOiCwEGvJGf+q0UbkXx9O6Is4
 Ksp+Pr3hYWKbLqb23HVbqIE4JDDS8mO6KOAkiMLkdsA254pPJSHTRobX63YVCfDXLT1mEOP1F
 87V3CgIp45VPAMlfeJrqiAiNKWu37PTGWA+eEHJd50IcDOEBXSrMaoQPHXDMuhO4ygfJ7zkKf
 PGiw626uEgPttWw8IWlygpr0Df+VSrdwtGdPEepb+Hpw8x/aFPVczeE/4xxc2XQUCoZJw1N4c
 UjX+FLDEvutc22LZcmYS7QTO0Q6r12pgG6MpMRu3/Z+jtpsg/W75T/oCFwBtS9MbJ8loeAaqr
 gB6y/dhyyr7NkfDyBjbg1o4LfUYyn+sr0qjJkTZEEzgaO4f3Nnq27WFOmuyh2T1h2fm3Ed7iu
 VFZNlIJGCdUaivvYn1X0M3qND/ScX8LkpF53NZClw46eSF8H4UxNZZ7acWNdQcg35mhNnrD8W
 hZJB159vnifvFTAHf
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 12 Feb 2020, Junio C Hamano wrote:

> * bw/remote-rename-update-config (2020-02-10) 6 commits
>  - remote rename/remove: gently handle remote.pushDefault config
>  - config: provide access to the current line number
>  - remote rename/remove: handle branch.<name>.pushRemote config values
>  - remote: clean-up config callback
>  - remote: clean-up by returning early to avoid one indentation
>  - pull --rebase/remote rename: document and honor single-letter abbrevi=
ations rebase types
>  (this branch uses mr/show-config-scope; is tangled with es/bugreport.)
>
>  "git remote rename X Y" needs to adjust configuration variables
>  (e.g. branch.<name>.remote) whose value used to be X to Y.
>  branch.<name>.pushRemote is now also updated.
>
>  Will merge to 'next'?

I think so, yes.

Thanks,
Dscho
