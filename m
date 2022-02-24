Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E0DC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 15:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiBXPO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiBXPO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 10:14:26 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A81C20A384
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 07:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645715627;
        bh=8mMOVBUFU2zStCEN6rNCj1PSh9o4IXr0RV+49jmiNOE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HNJER7A+ilqGXk/S8qoyeqavt7+s3KkMoQM9nnTo1ZVxhTAsO2hC8+hAVqb37wtuK
         8gyZS8acukFH266H6BFKNQsbCGLrktYpkCypGjfjZ+jsi2lFdU02+DUVw4njdI4lq0
         pJmo82cz7RQ+2yKK5+ppYpu9uRFuUcQ9k9W6174I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQvCv-1nYcdJ3nVf-00Nxnw; Thu, 24
 Feb 2022 16:13:47 +0100
Date:   Thu, 24 Feb 2022 16:13:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 16/30] compat/fsmonitor/fsm-listen-darwin: add macos
 header files for FSEvent
In-Reply-To: <a3b881315faea153fb6f4839d7077caf6fc8899c.1644612979.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202241612340.11118@tvgsbejvaqbjf.bet>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com> <a3b881315faea153fb6f4839d7077caf6fc8899c.1644612979.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eNqzWRkq5vSzBSzw5oGsyRARgjGiGn5LnldfTWwWYwZl1pZ2I07
 SyMfw2o+pbSfBIUegfyFc3K4uyk7lDJdSnkR43M7CaoZeUi8naLRkymH8o/iTpX3cA5YzA8
 /1ulEqJj6SgmMc4iuFyn4LfVxZO8vHF59mCZolJShe+TRi7GwtxuAJst2q0x3FnXAnVJG7i
 icLZgYgDTNerzUof3WMeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AlOUs8pZBPw=:tkj+bG03L612GWgDzTTWYG
 wwe6oPoEfUFiboBptkIGE4EeQqRXJ576dKbqYjjKB/AJQKHxexrRARu2Vm5GvJySDyY1uJaMn
 3auoni0M86Fe1RBVjc5opVAJGIC2wrd/7wlzaSfBwZCQrtcwnAw5u4mHTcKKCZ7sBZKugf4os
 SrD6Pe0yBUxg2JIy1nIM6TCkxCshS2bgcPUTlbCuZ50L5unX0/Mlf7eksGVEj+OI/3km8FDWv
 JdcPl/bRdPzMcjbDu60RbPfjVCrJsfZpYVRxSBw8GPWIaVpbCHklNMCnmCSMe8WMdNjHdIg0a
 iReeF3UTDGej6iJO1D6QdxePs44SgdUUuoytTUyXKMK6+cQzfWjlJg/yCX92n8Akiojz8SFT6
 mWggN/Xmjso4wQ40VEMBq1/gquzv7AXsE/NYzJkunoDaQppIpyWJGUFxfX0Mc9MYYo+zkjGno
 mkaEGlwuuvdrpgg3bvupePrvq9jlrcFldebGrSV5voX5BDJt3vSpO5Ut+G37dyKNfalcyrBEZ
 XL0aiOMSCr92CBvqko1880D+MJwy6bgyE8LzrRzhVEQcUPEPhajrz0CXuq4DaaLCZJzeT0XsC
 yJK3ZULYj+deVNVYPnMh4kWF8xy4207BStY8QEMHrDPNlqB8fEZ7ohuhQP1j5U2dyO2nowUhV
 cbsIGbyVPtVwfa4Z/AidYrr7a07vTU8W1d9vsvajyP9G2kiYQ7t481+sQRf5wP+noBSQOw4pi
 +ipyljLLH0BKdpFQn61oQbhTtMhKT5+3B463vWrw4nMeLCTfwK91vTN16hUfVMSWdNZxb0e3/
 2dQhleGbdwKd+3D2+/xH3lnSHJ84s26/TQrJdVWjnTj0NnYuCaQH/s3BwV+p09cCv0WAOfyUw
 L2jYcXvrhs540tv6O+YJ+xtjODNLDJlIldjjC30iodRA50uCwWbndBj/FD+i/faTOBge8dsaX
 kxuvSp8pPoj9BFSDzxHJ7FKc1wHlhP7UvgHi3+RBZMeaJTQvCLt8yN/I+Qe6E/ZPh3skZL1go
 RB1y94rH0cYG+gwNRqItTF5ealdMzbz7T3k7ESrRxHMu8Z2V38o5tLAN9IYRznXw2nyhhxlOK
 dlkEsTdKh9nNvk=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

just a quick note:

On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:

> [...]
> The underlying reason is that GCC (rightfully) objects that an `enum`
> value such as `kAuthorizationExternalFormLength` is not a constant
> (because it is not, the preprocessor has no knowledge of it, only the
> actual C compiler does) and can therefore not be used to define the size
> of a C array.
>
> This is a known problem and tracked in GCC's bug tracker:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D93082

I just checked and the bug is still marked as "NEW". Therefore we still
need this patch.

Ciao,
Dscho
