Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8A9C433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 11:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68275206E7
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 11:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="f5ckn1pV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgIBL4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 07:56:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:45971 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBLzv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 07:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599047746;
        bh=Jgarqf4llV0K/2YEsu1VMkES5S7X/QJKTn12dvdx+PI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=f5ckn1pVvUQGC9IY4QxfJ0CTAhePaRM+ZxTICWVatc74C0u0akalcruO+f2Z3kGrL
         n30FhQ02ZhH6yzwYO7sfeF8ikR+Qt/ax/IPJEfkEp1n4Yn68EPvLxWzhxPFrp6jQ+u
         hug57lwPSsRhK+fs0vVPsWCyl7f7hgEhKLEZ5mEA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([89.1.214.253]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MoO24-1kxXli0yW8-00ojp7; Wed, 02
 Sep 2020 13:55:46 +0200
Date:   Wed, 2 Sep 2020 09:06:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ci: stop linking built-ins to the dashed
 versions
In-Reply-To: <xmqq5z95xu5f.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009020902080.56@tvgsbejvaqbjf.bet>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com> <pull.411.v2.git.1598283480.gitgitgadget@gmail.com> <ea23ba5e269305b660a1722254e2a933c14e5b57.1598283480.git.gitgitgadget@gmail.com> <20200825134714.GC25052@szeder.dev> <xmqq364a3f6r.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2008260615280.56@tvgsbejvaqbjf.bet> <xmqq5z95xu5f.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ArQWUBXzlUoed25yu4ax4nXv2PYRjBDbNob5ILFTte8pXsJ40ad
 vXk4M4pyMnR4S//LtBfGlVz0c9Qwtv/Jl4Gf3pBGMRU/l6dia4cH5cQyvSgQBVhG08TVvK/
 SLjhFbOSQ0khsTdtExr++x0izvfuukj96GHEmxxL7ByNbQcG6PAdkIT8gylcd4W4RP6wUtJ
 LOmrrYE24VXOE7B2UnrDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G/cCoHZG1F0=:xQLU2V048X4sFLKU143bfl
 fL8pEIrn7oYtt3I5JR0+o3ALQvqkq7z6GMftHNgxpmDaUn89HDK6HcUcIfBWSpJcKyEaOpV+G
 /lpulxu+aNCJzRGgtHzVRlzJizt95ZtLcrAQvgJ9hwjctl33LK7EW/R7lS6jrHWXRp6See6yQ
 M+Fb0E0PEtZ9VpVKibDAO6BQf1+nxIOOvu2k8sm+pdIBAOp3qAjrCRcDnZ8+OCGt1jRDciGd0
 nAjNhAuiWJ6HgJfBbgevP3QV9Na/INyLf+q/2Kcjf2ZfHwqwVYQDBK6wxPAGM6TjFaDwRlCk3
 sTaZCsv1j+LufmM1i/sz36VZCASQwBXyoHmO1BfUMaNqzwZvFi6SKb9h6fONOF0sAZ+ZFBZUj
 sp8YdBUzrxwmn1UCz/XshmZe/ZTqte9Ks/fJJlOycddiwq+PAwBpAkK2XNsONajACVB9Yc28A
 3faVQKSNVwiGtTPbwhZRr+2G3EwtwUmlrNsZn3FbO62egfNtDlAVf1MU7AQxdEYhbB6y/2lmv
 7021KQhY/3VW1AsJGx1+ZVQnQSc8lnjQx1yNEpEh38UrUHqZvAMTpe9/P+B2RdyqrYlatMny9
 DjKn8PtkIeHi09ZZMVS+0WmlRm4WIX/+xLXcKX5O7k8t+355M7A9Ez64HxMGbR5cjbT2ESgww
 QEt7QTBpthIMHdzp3c8/toVVH+addqQIzHPOUkK9PfVxwROjetCWo0e6Gwu1dWuniS0n7IvK5
 R0/6o+4U6RUwCATtiMUyltOQEvvhK8WbS1xpcBzgD+p/zxsK21k6bkOtylxMLpASifMTkyHSi
 GVBRKVjfxghD6wtXgDHn57q571AfDfzgX9jsK9VcPtBmQVgYHDhcPyJ1qGzs2AOGSjKLTYKOj
 hm/pqD4XDNqLkRxhkxrjv4q5bZpg8fyM+48OtlN4KhXZ4eaZI2l4PTAHd5meAr8Hb6r/4h980
 A1WH+JRQhE3RhIqcM/l1lSPCYN7BCgqBBSwLO/fgWYt0HpadKwnF+2Lu1LiX3BFU9Uynk5fq9
 01jkD424vpHHpof0z1sGcrBTexyilzWbf0th7CUNyfafAr9GYG1P65zklmE3wj9An7Wyoqxsn
 Z8LzVFrVHN2zDkpUGpwSi45Yn8435x5y2teT7NFk3OmJA5euqawxPIS7qFBd1BsJWDcbtX36I
 u3BC+f+5YcaEu55fNPTtjhJtMkTiRzyPXJl08wV4SZ5+UNQj7taSTzzzhvJGv/KGnYrdhb/AE
 YSQZ2FKVvP0DIbJouXUWV9j++jCgF+/PleEfMpQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 26 Aug 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Actually, `SKIP_DASHED_BUILT_INS` does not _only_ have an impact on `m=
ake
> > install`:
> > ...
> > See how `git-add.exe` is linked in the first, but not in the second ru=
n?
>
> OK, that is one more reason why we do want to have 3/3 applied not
> for all tasks in the CI , but for subset of tasks that includes the
> Windows task.  If we had multiple Windows tasks, it may even be
> better to have only to some tasks, and allow other tasks build
> git-add.exe, so that both can be tested for the primary intended
> platform.

If you want to skip this patch, that's fine with me.

But I would like to clarify what I perceive as a misunderstanding: this
patch is not about testing whether it would install the necessary files
or not.

What this patch does is simply to complete the mission of e4597aae6590
(run test suite without dashed git-commands in PATH, 2009-12-02): to make
sure that our very own scripts do not use dashed invocations of built-in
commands.

In that respect, I find it to make more sense to either do it, or not do
it (even if I don't quite understand why we wouldn't do it), instead of
doing it only for one platform.

Ciao,
Dscho
