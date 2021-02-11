Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5A1C433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 22:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44E2A64E35
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 22:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhBKWUV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 17:20:21 -0500
Received: from mout.gmx.net ([212.227.17.20]:35997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhBKWUU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 17:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613081922;
        bh=brA9B3qxCTeCqZyWGdAzkNkNU8rFqcKoZSgT4qTaibM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ym0O4ABTxhLuLeKkUJ5tdKT8ILtCeKvLNGt1xJ5VW77Izi7x6Yr9hq1QVt9JEuhpS
         bOdOzuMdVi7IMWBp6PN5STnvejFyCDGEoxIR7zlRm7jq8lOgISe6mVXcjxWRzOxO2+
         3sEk38dDQPUUBj/ki6cOVMoS8q1J24zpx3paYE3o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([213.196.212.209]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnJlc-1lZRuo1B6C-00jFVf; Thu, 11
 Feb 2021 23:18:42 +0100
Date:   Thu, 11 Feb 2021 23:18:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 12/12] test-lib-functions: split out {debug,path,text}
 helpers
In-Reply-To: <xmqqpn18yee4.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2102112317330.29765@tvgsbejvaqbjf.bet>
References: <20210209214159.22815-1-avarab@gmail.com> <20210209214159.22815-13-avarab@gmail.com> <xmqqpn18yee4.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-261980271-1613081923=:29765"
X-Provags-ID: V03:K1:77/v5krUqC8Hi48ryySlprijlh6MUTZ54XAoY4Jj5501HSd234/
 MY7gHivnfry0F8L2zCAF/0N7GpfyzSOxN4505v2dwjUpSnxrsgk2RurzEPhyrtXKHPJgJ9p
 +HamqkuBjP1RaK8sdkWlO05iM72zXK1tUthPACNl/+VOgrEoZKHOH6igPSsg8U2jqI3z5z1
 k1C92Q5ixjgCKta4Qesag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6LXLD+JJ0Ck=:5S37+rWkEycnsyiY5HVaeg
 /BXFxGTiI5nAgKsddF8lxWl90B2yyfarSczTzvZyUE03i+qeCsqxRM94UbjWikzkO4pNsOvaA
 EcwgqzN1gzV9KhEY+0n/Z8NbhRhnPh7c2F9s2nFFkEDH1GfjAhK7MizllKknbke5C1RbAzZu8
 M8CTWjsHIS9f1Qi5lFzpmq/e77JZJdB584VrsYUbai/3/uWE/jn6GSM99KoixC9Cv9meN5J59
 ZVeU5wNB2ZmSUtZ0527UbS4fh+JXxeO2j77+lBep3V8f1ERBLl2Hkoym1vKuxRjbwi/xOa7Mu
 aaj8l2nii08XfYO2rH6CO/A6IDWC6rhk+0vTLhVYM3UeW3NPF+hhWoT2KAzPUz1mpPABC6sl9
 OIbKLbmbpGg+3L+4MJLskzK5+ky9ASAxKiqRSpMiTH+r2I4hNjlEgBtFJiWzPqmTjNJyfxoFl
 yJoQDn9ARE2ecbViamKm8NiFxmIu9aMEEHYKHVVrT6xwpqwGOE/x0U5YeDQI2jcWJeaAY+e7p
 maSe8sebrLuM4071MDvc8DZyIajXphBnqc5JRx5Uyl1dj90CPIQvzGo99AM0CRKdXvcoaH3X0
 T/+mz5ygz6qFfJgZ6/Uw628Ujl+8Xu3iDQS2Tadin/uVL7Hgl4GXCxXNCe08gcWz1QRhxTQNV
 MKax1NqinAxtlkc5eE1qObdvnScWCJd3Q7w7Ytf9P5+TLTyBaEmwrulY/kSQYx65Kvh8Aj4y1
 ijOT/Rpq2PuTUwzloAq38dM6bncY3XEEtO6dCqtaLMRgJ2p5QisvAT7WHktaHtm6hRcM/qSbn
 crDaWcGvSQXwR7xcPHksKXUhgVhyxDfQWQld6rqzrL0WdG/86MQy6WfUUXIznkjzVFqZZUmqz
 0mqF4BcYzwQrGUXKXVXB0pQ97epXh3ya33oMF3JlE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-261980271-1613081923=:29765
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 9 Feb 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
> > Split out the debug, path and text miscellaneous helpers into their
> > own files. The "test -[efsd]" etc. helpers were not all in one place
> > in test-lib-functions.sh, I think moving them into their own file
> > makes it easier to follow the code.
>
> I'd prefer not to see this done.  It would be fine to move them in
> different sections but still in the same file to group related
> helpers together, but I am having enough trouble when deciding to
> look into which between test-lib.sh and test-lib-functions.sh in the
> current organization already.  And it will make the situation even
> worse if we did this, no?

As much as I would love to see a better organization, I agree with Junio
that this split would make it more tedious to find the correct function.

I had a look over the rest of the series and like what I saw, leaving only
one or two comments.

Thanks,
Dscho

--8323328-261980271-1613081923=:29765--
