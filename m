Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5874CC433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39385610E5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239419AbhJFUuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 16:50:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:55605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231749AbhJFUug (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 16:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633553313;
        bh=c0kgMRrQVXJeBuVf8cXfpod4CpqmgIxjRhf5d2pnN9U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FOmY7x7I8DjSPzGmanAXj+o0O1FMA2kKS6S7vuLgsv95shON8bUBv87RMfmAVOeTl
         1cAKiMCEuYUoDsdIVDVfQP4Bceh7AChvrPARDZF9a8bkx1mFxBkgTmgmZadoq+NbhL
         jskaoOjk7fEBV9fpMzH3aviA9Tuq0gQrjMxoYvJ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.23.42] ([46.183.103.8]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9yS-1mG8l10E4I-00IAzJ; Wed, 06
 Oct 2021 22:48:33 +0200
Date:   Wed, 6 Oct 2021 22:48:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matthew Cheetham <mjcheetham@outlook.com>
cc:     Elijah Newren <newren@gmail.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v4 13/15] scalar: implement the `delete` command
In-Reply-To: <468CE4B8-D2C9-4FBC-B801-739F86C88ACB@outlook.com>
Message-ID: <nycvar.QRO.7.76.6.2110062243420.395@tvgsbejvaqbjf.bet>
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com> <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com> <914c16c7fcd948374fb2c0582c435d0d6ac775a0.1631630356.git.gitgitgadget@gmail.com> <CABPp-BGzw4XUhEnUSnp5C1q-7qHcLP-8owbpqTfnbrCuwVkMQw@mail.gmail.com>
 <468CE4B8-D2C9-4FBC-B801-739F86C88ACB@outlook.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AEICRzoHDq1OF9wQJ7EDkWt1FuYSxZwg4tCtUt0VlORe8oZxz+/
 3sY9cCcQnuI4PvEEnLiUglAixTFtu+r4g+05sqBgE2usq8afa8YnB8WyiYuJmdGJNi86OyV
 gu6z2JTtYmvsvX/BWfhx34T025kRlMS0YySJVTqI1sC/8I5kfkaTw50UdkylF/OKOWUKwm1
 0m682C2aJd3QOLrIRC2qA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XUbvcWFHy4o=:wxCLgIO5YuJZnU8mzNt6yr
 ztJBK3OtIktJlaCOh4U3M8t9pmn0//0/Vw5EDBvfncjetJBaz7zsDTI67fZN+rZMaEt30+oOP
 H3mSLleMVm21RWDrxb5Zage5E60FY4ZDw9r9ugqKE0qDGseqa0lY1P2RsSZpV8xnhwOJ6T/o6
 l9xo/ZuhRQPCEhZfEPF+niLRf5xEmhvit/xzGakEqT3DPKtqZ7yNcdxnuhyBgtH1riCqfcX10
 4jJ6w4M//AJRzGYkqrIdnKyDIWss9SffRpxqNycRW3K/iWEemg7yyKW8KniLsdmWcN9rwYsAX
 nHJg/IGb89rQ6XAmfY2Zy1VHL79hrjgddDUF9t2esPHkCgh9MXS7J4tw2/yzeoPvMleo7mjPC
 aEEZIKzhK8HOzf8Hfj0bqLlfkvsk+zDGCY9bEd7KgBD1kF/tmYBR0njLal3C/Db9d01ERg8BT
 UxVuOFH6mqo3mKEP4DScHqfe8OVLs7v11tZ018IaLyFpVslTzI0UzvVaQjZUOCzzJXYL4soTa
 mMtZBd3sedMpaQ/BR8aSDojPAX5bwuqmf7HN0jAXHMLDDN0OoDjeSqiNJ3pv+LyxaTIBm8Fjm
 4eC2xGnS1Tura3OdOUcUvZxJVKOrUJ9/vSXqnoHNWldZ+1B8/SskARnqkdeyCSpBokroETipD
 PgXgdR1QcJ+7d/9ORErHwPr4JFhOQuZSy9o4lK6trDSjISixlYyfexJh3vxOe8kR0umTVnRyo
 xek1i8A+iLbni+IU8crDf/O+kliLlVsij126xmm6k+JNf9r3qqO1q6VGHPYdfgUDOjZavy+n9
 mEHqvfmGpHqWRMD4ZjGoPvrY9TYwG3q69fqehPpA/B4reyoZEhnGZcmq+CeTH7zVL8bj5+ajm
 QBJBQLDW8TNJYIHeinpn6fUUfhazDspLWZ3jQqWNhjPhZP48+H8AkZQ9gGJbHPF40i9A7y+iZ
 ZAuDcz5Lw12mrmiD5EZ4nG1gol3fRuAoCEXeMSK7UUL/oEC1wBejSeas7oNLtb3uX7hfbuc/9
 SopKJNaq7MkZUA95X4HuIwTbxyqejcVnYGx775XLyojFNR+h3Ut7qR1u9JPlDRnFsry3IVTbp
 tC6/hjm1iAX0YmHmTHwrvt9TeByMNhK64PF
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matthew and Elijah,

On Mon, 4 Oct 2021, Matthew Cheetham wrote:

> On 28 Sep 2021, at 7:24 am, Elijah Newren <newren@gmail.com> wrote:
>
> > But if the current directory is inside the enlistment's directory,
> > didn't that happen because the parent process' current directory was
> > inside the enlistment directory?  Or was there some kind of directory
> > switching that scalar itself was doing causing it to be inside the
> > enlistment directory?
>
> Yes to the latter. `setup_enlistment_directory` changes the current
> directory much like `setup_git_directory`.
>
> > If the the current directory was inside the enlistment's directory
> > because it inherited a parent process' current directory, wouldn't
> > that also prevent deleting it?  If so, should there be a special check
> > for that case and pre-emptively returning an error rather than
> > attempting the recursive directory deletion and just spitting out an
> > error when it fails?
>
> You are correct. Speaking to Johannes about this I believe he is looking
> to add a check/error in a new patch series revision.

Indeed, I did notice GGG#1037, and I changed the code so that it detects
whether `scalar delete` was called from within the enlistment, and refuses
to run in that case. Users will have to call `scalar delete <path>` from
outside the enlistment.

Ciao,
Dscho
