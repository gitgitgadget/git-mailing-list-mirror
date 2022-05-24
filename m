Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498ECC433FE
	for <git@archiver.kernel.org>; Tue, 24 May 2022 11:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbiEXLwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 07:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbiEXLwL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 07:52:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A5B562D5
        for <git@vger.kernel.org>; Tue, 24 May 2022 04:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653393103;
        bh=wqhNNdbIIEF3QeY6kbCbFxyGg54z/FSupPm3Crz8ULQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fichSjEGvq94xw6jIUSYj1u6oFFW2Hx1FvlpQV6l2zJ6a45OLeDbQJgplHk6wiR2E
         uGZbQNtEyyQd78CUXnOFoAQSChld07+wiXPBhAU6YAtUxMqw5ZDor3sDXBUEfJLkyh
         Z6D2sIC2HofXB44plSdbcDDVKsjQ3eNPHHASqMbo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNcA-1nK8Fz2J9M-00ZR0o; Tue, 24
 May 2022 13:51:43 +0200
Date:   Tue, 24 May 2022 13:51:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] urlmatch: create fetch.credentialsInUrl config
In-Reply-To: <xmqqr14kqdag.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205241346590.352@tvgsbejvaqbjf.bet>
References: <pull.1237.git.1653329044940.gitgitgadget@gmail.com> <xmqqr14kqdag.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BoojhLL/kTrGiY7vpLZS/bSr7PZfsClzElj7IsUmLV2+aLjBGs/
 IZTGDGGYtExKYhoEOxESkqCB5t2Q+C6H1Pv1IRCKgxY35aBKUV4U7sOSRTTjknw34ZygODB
 dQAC64Qr401nh28VuIGW1jDpunSTnxdYJDOXPyqXC1tOYonINOB2axpD+DOM3Fb+8hmEjA2
 KhC75yMqILElBUBfFxOPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6riJeFidjOg=:Thf2kqrXN87UgetLBHt69p
 TuNsCVj2n6iN601tjiY6lNb+sz//POYBRR5AwlUTgcv78BhACex+73S5RV5Slb+Dd33DEms3u
 iAIxbyuBHvZB/BahdmoG9zVxyousQqz+eLteiHVnYCC0RB5kXOh71d3JYGDRPW7i5WCExQ9NT
 pUzmdYb/rOT42Y5Me0PEkdIPc/ZegJoNOn4zsHddxlzlE2VD9P7Oda7iTRw5mHY+MLxDQUlLv
 oeF4q9wd+ia7sbATtc6CvOVhs2dMK/EBXydEdbESM1rhZfJaXwl3hQey36Q6QTDZeAiHm/7en
 vuGcOYZMjdt6/K6Xt9s+4QHWllN/XThr6UDnTBYdGzhisXvaWA7serUqLrD2jAicDM5f6gJ/W
 Ux0B/ACMi5Dd+IgwBZ9QNzslxmMRwlkaiNfVtiMlD/McIyGHYUbKS0Hl2rpymWAobhbTP/Fqn
 g8qencvGwnnEY2/ZfAb+eFeFkKbYmuwALGaVZqSw5Ksp6F027Bj4HeihCthLtv/pJ+KnFOs8+
 ktiogoNZ6cbQork614tZAaJCL5mDk5fnSDD0g1HHN2CPnd+Bb2hbFivwk2Sg0R/5/fcqK7O4l
 DU97Vb/n0qzEzfdS6LXPSoZVOlDmqbAvEAJd3MJ8UWok4mijBCHbOD5wu4ogZpBkZ8RsASym+
 EaBcpHyYOVlDN2zMD+wp/J8wwM0sHFucbNlNrF9SqKBVajlGQdLxUaailWvG9fdFQhptypLCz
 9fuG1B/RyE0YOas0K3LXAxAOPumNukJ72qFkecm8Vf2GkyjXdhOpvokci6KlsMeSOcjkyYDQG
 8xqE4L+nGaUr9dPK+LaFzGkNPr5wqHJAR+wU8g8s0W5Qiw2fkwSiJnQ2hOnCtgcaF1KsIlEZb
 w1b7pP3FSrdjWRvRHJsNlX26Xi0EsZNCq1e9UVW1GesbtDhkyJOeLrX9ooStuTR0N30lMrT8r
 b+vH9DBStXqT8mKJKTJOIV/4XjdQJ5FGNJTuxX748wW6xND5gyagtcMBODUEy4eErA/U/DW3S
 a3uhoSbYGsU80DG7p3yFjSKr1Ff6ZqLz4cI0h8jrgjbYXIqKxD00B3tIt1AE26dJ0raLrVDBU
 BWh1q7XLZLzuNr90nVtq9dmcYEaRUZYBIdxVoC/t2ePDNKiLgcG0t6+Lw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 23 May 2022, Junio C Hamano wrote:

> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >     urlmatch: create fetch.credentialsInUrl config
> >
> >     This is a modified version of the patch I submitted a while ago [1=
].
> >
> >     Based on the feedback, changing the behavior to fail by default wa=
s not
> >     a good approach. Further, the idea to stop storing the credentials=
 in
> >     config and redirect them to a credential manager was already consi=
dered
> >     by Peff [2] but not merged.
>
> I just peeked [2] and I am not sure why we didn't X-<.  The solution
> there covers "git clone" that records the origin URL but this one
> would cover URL regardless of where the URL came from---as long as
> an insecure URL is used, we warn or die, and it is even against the
> URL that came from the command line.
>
> In a sense, I think these are more or less orthogonal.  [2]'s "clone
> can strip the user:pass from the URL it writes to the config, while
> passing user:pass to the credential API", especially if it is
> extended to "git remote add", would stop two common avenues that
> such an insecure URL can go to the configuration file.  The approach
> taken by this patch would complement it to a degree, as long as the
> user cares.
>
> I am not sure if there is a legitimate case where the user does not
> care, though.  For a script, it may be handy if a URL can contain an
> ever-changing user:pass pair, where the pass is generated by
> something like s/key, for example, and for such a command line that
> knowingly have user:pass pair, having to set the configuration to
> "ignore" may be cumbersome.

To provide one data point: a few of Git for Windows' automated builds use
the `https://user@pass:host/` form to clone and push, using a Personal
Access Token as password (that is of course marked as a secret, read: it
will get redacted out of the logs).

So yes, there are scripts that rely on Git's current behavior to work.

If Git changes behavior, I will have to adjust those build definitions.

In this instance, I believe that the benefit of safeguarding Git's users
outweighs the burden of having to adjust such scripts/definitions.

Ciao,
Dscho
