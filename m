Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9291F461
	for <e@80x24.org>; Tue, 14 May 2019 14:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfENOFH (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 10:05:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:50105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfENOFH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 10:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557842698;
        bh=3X0K0mo8hKIdsJczEKVUy26HRAFcmRJqFlopY2dCQfo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=a+XaFr8YEDckqvGxwKvNyMlnVfMWLpsWTBxMJDywrgJRfP7QEQVn/+77cOKjtGNDs
         TtYeDLnSbnsXl9Is1Wjzz8zc2z1rKqFHM6sjxK+29yOPnXsy7QjypvP5EyrmQbTPsV
         f5lfATEIihFn1n4u2wnUtdHq36GG83AbGKc7Q0X8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWAOQ-1hAZVb3wF8-00XbiN; Tue, 14
 May 2019 16:04:58 +0200
Date:   Tue, 14 May 2019 16:04:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Slavica Djukic <slawica92@hotmail.com>
Subject: Re: [PATCH] tests: add a special setup where prerequisites fail
In-Reply-To: <87ef51w3yd.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905141603160.44@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1905131531000.44@tvgsbejvaqbjf.bet> <20190513183242.10600-1-avarab@gmail.com> <nycvar.QRO.7.76.6.1905140945220.44@tvgsbejvaqbjf.bet> <87lfz9wexs.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1905141434040.44@tvgsbejvaqbjf.bet>
 <87ef51w3yd.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1111533669-1557842698=:44"
X-Provags-ID: V03:K1:ZqwoYWreyWPPb6EJthIbSX3A21X2lw7PRJ/HD9qR7h1GXZitWkI
 Z0nzIwRuvgoqRuRxNFl10tlkEmW3CCdP1LWUlPH1Cy6iEAONW6JlvSWPhjD3kjiF69GG1pG
 chhF1TRoVqAsUaPeDR4K3zdz938OykARJPl9Hg8jqEsb07U6CD6mdUudQto8IJMqZCxkeO1
 KFxKdpFxnqsI4VMTytJ7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bKE5AFlftFg=:or13s+Ejn4LVPay2Huqr3q
 s0cEQw1tXVEt6TJybmhiL5IReBLxPjjm8dD9KotHY0qFt9qVMREF+uIPmkcjm40jePT/RbgUg
 jMS7l6nBtwNOr+smpUATo+GCCsYMSmRqGEGVZCqOcq61de4j7552gPNr8sMUketzzJyDWAdnH
 jFRt/UeeIsxVOEL0GE4ypaqhESdXth92vnqOoZW8kv42SMZGZVpupJub1F6tPV0ia8wE5OxL1
 X7UabjMpK2h9hlu4iL4GC7+aoaT1l+WfjEfpLyUU3katbBXUIR9Vgktux0dR+WnPQbGTqr394
 ABSX6IY+hl0sj/5LTtb2wE84DKTqw2huW4tMPn4HL7rg3q8RxdSdlBRnHV7vAYoM2NNRwnKTv
 Jt8vM55/Z9nwZHmSsaqza32hdySfVoo6F0CTU5zbru6ja6Yd6NQoBZKGQLEwls4ZcPzlgfuc4
 Se0ozmFQRadhiIq1f9a1huM4ucXQW0QBbAcMxq4t6lHCuUTFbOOTtiOBYAk6Zgdq6mzf7jvWJ
 8UTD42XiOwthFBFmM/BXv7jTlLDAI5mxQftaqrScRUfFSi3i79CveZCUj9nFp1ptP2U7SwqQJ
 u3K/E+gVt0TusoEGViEcBwQlyrbC5RmHtavbBX5JohaaYYuSaCp3asdKq8sketjsBfKnIb4aW
 QVIdV9xL1ANMdH44mpyHhk4gljn2HdDfPGxuvf1YTApcdTVvei9jFv3z16yBv9LzgYu/j9qGf
 0j9rwx5EMFqp2h4QaO7/e4+jdRcoFsvvB0t9hdL3fUxocWHh7tKGfyddWjREe76OFdvjPqCeL
 E9WFwsS3g2YvKrlzD3f9z01FsADLw+1VrVam2M/lDZnoHRA9t9BW0Zi844BUicg2mi2rwI2mD
 5F0Sw2vPzhvfn6mXIe96e60OXzNRNgojNOeyAzhmc86ALvtoAysH4BS649a0wOg1v2BhblGrE
 dmtjOBhVMkQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1111533669-1557842698=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Tue, 14 May 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, May 14 2019, Johannes Schindelin wrote:
>
> > On Tue, 14 May 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> >> On Tue, May 14 2019, Johannes Schindelin wrote:
> >>
> >> > What would you think about a mode where random test cases are
> >> > skipped? It would have to make sure to provide a way to recreate
> >> > the problem, e.g. giving a string that defines exactly which test
> >> > cases were skipped.
> >> >
> >> > I am *sure* that tons of test scripts would fail with that, and we
> >> > would probably have to special-case the `setup` "test cases", and
> >> > we would have to clean up quite a few scripts to *not* execute
> >> > random stuff outside of `test_expect_*`...
> >>
> >> I think it would be neat, but unrelated to and overkill for spotting
> >> the practical problem we have now, which is that we *know* we skip
> >> some of this now on some platforms/setups due to prereqs.
> >
> > I understand, but I am still worried that this is a lot of work for an
> > incomplete fix.
> >
> > For example, the t7600-merge.sh test script that set off this
> > conversation has two prereqs that are unmet on Windows: GPG and
> > EXECKEEPSPID. On Azure Pipelines' macOS agents, it is only GPG that is
> > unmet. So switching off all prereqs would not help macOS with e.g. a
> > bug where the GPG test cases are skipped but the EXECKEEPSPID test
> > case is not.
>
> It won't catch such cases, but will catch cases where a later new test
> assumes that whatever the state of the test repo it gets is what's
> always going to be there. In practice I think that'll catch most such
> issues.

That's fair. It will also raise awareness of these issues, which should
also have a quite beneficial effect.

Given that your patch is not even large, I think you're right, it *is* a
lot of bang for the buck.

Ciao,
Dscho

--8323328-1111533669-1557842698=:44--
