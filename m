Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BE4C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 10:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiCAKTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 05:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiCAKTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 05:19:09 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEBF43393
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 02:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646129889;
        bh=MultCA5HAHlHljjt3ENrWgtRVnetUNpRv6E9urmJSr0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RtY/974IAUQe3plV8c9NOqATBEAHgP4EFcR7eMBWH+Nc4FtSm7oMRGapAPs9qKCHp
         nmtgf83UfZCbd7gebwjwGs/PkFtI1jMr+uOm910IhM4YRfiej9sRkPowrUJxliQlto
         einipKxBLLJoty+FA+XsSRHO0HXAbrwbXUU+GvhE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.214.47]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf0K-1o7Mfr1Qws-00ilz2; Tue, 01
 Mar 2022 11:18:09 +0100
Date:   Tue, 1 Mar 2022 11:18:07 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     phillip.wood@dunelm.org.uk,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
In-Reply-To: <xmqqee3mwf7k.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2203011111150.11118@tvgsbejvaqbjf.bet>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>        <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>        <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>        <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet>       
 <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>        <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com>        <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet>        <xmqqv8x2dd7j.fsf@gitster.g> <xmqqzgmd5uzu.fsf@gitster.g>
 <xmqqee3mwf7k.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:t/xj0GVzjJCK/x1EwqEK6ouumzxEWvERBaeSJ0MlzdwX3r+V/bj
 WjNrkZc2L8w58O4Iuqz7rN51WM9kanO0AtFhQj/HvDhTc97bx5EGdpxMCnns5DO0RU4TBrT
 Ekeezpgn2LIsob9gu61aNTiv+amUp+Wrmz1AC1+L4FJDrbkrWfuibC7dE078CzMV/txVtrJ
 RKpSE6SKaFZ08WlAR9C5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BpL/G2uXofU=:QckpyjJ5rwASvqUSVXPBlP
 qIceXFeckO+0jICU/LDCA4mfwkCNoPqxcBNtFpBq6UpbTgj6bbHFmYgdiKl2z+76W+4C+MOrS
 qioC3EI0FRmLr5fgwVZd92E1Yyrnt9rNAxwch2IG/cyNkD9zx7o5oNDc3BcQFJO64F6PvdBl7
 c6fIidtNXKyQzf8/VfFqcb/HDdivNNStBvkcU62WtkpfAzctb15YUz3UiLDwzrlNOD70rcNc0
 k2EifohB5GHnOp2Wfsf9HJZwJt34puvORbngab2/IqaqfpyT3qO/3txtp+aJGmyk2pVBcJKMD
 m/gQtLSbriwz0EhQG8z02XGTpVxl6UccsaWDGi60kaPIpt8cceO3RqC4ofhNQ3QioEXTjgWuQ
 MDWfvR6rmQ3MTyApjicZGM5+iyqRhQFf9lVzHUsP7k73taK/EQy4FKPOqiHQhnRWDEHYqX5eF
 e9597Ge1VrRJZJVfF/kTzn1I8qvzTbkdRdbr7hgk/5ciWQ6r99mPhylORVlQLo7R8LlyyPYC+
 kNqHCUKooe5BsTxBhqgXaMKxyUTAW9fPvjvKtfbaFb/44EO8ekxLOQCymRk+j1apKqLBcv4Qh
 Fy2STRefm55hCjycihio8DsOIWonahNn1SI+00OklsjR0Cyltr5vrNmEXUT41DSz28YvGhEmL
 M4JqCQ63FS/XBpnZKKQQi/YlF+QsTgmyr909q8ZNd6VjHh87zBlJ8KVSUoyR2GM4JrA4iO4N4
 7qnA8a9WiZ/DkWKFaHiDuMpxmU4KROs1Y8qGN0g4N1BBcLh9nwT1HV7EqZNNKgl82muza7IPv
 /hCkZzTpWykT0/g2v1xpgz06vaGfwXUMesuviDAdzbhXeOsmRMivQFgko2bxIglCibPYQC0OV
 gtOq+HDtp5aSLoBDqJMPJVnFIoDvHA3KxsFSqw1NsZatq5Lj5891KglS5sm9LAwI0gxFrsAmy
 8a9NJJEHJERi//02x+H4C1yZuQ3dnI2ZbFpT5Gtq5zKT0aUaxNJuK3J8KWi6rHzlFq3gCw1+x
 jc57J5NOEGgbV/q+dAydw3tnPXhEwm0epqZjTiUBfWXZ/t6GvE4GnZ4WvJGXrsl0R5lhiZS8Z
 3JUMoXmd0wNM4I=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 28 Feb 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > FWIW, CI run on "seen" uses this series.
>
> Another "early impression".  I had to open this one today,
>
>     https://github.com/git/git/runs/5367854000?check_suite_focus=3Dtrue
>
> which was a jarring experience.  It correctly painted the fourth
> circle "Run ci/run-build-and-tests.sh" in red with X in it, and
> after waiting for a while (which I already said that I do not mind
> at all), showed a bunch of line, and then auto-scrolled down to the
> end of that section.
>
> It _looked_ like that it was now ready for me to interact with it,
> so I started to scroll up to the beginning of that section, but I
> had to stare at blank space for several minutes before lines are
> shown to occupy that space.  During the repainting, unlike the
> initial delay-wait that lets me know that it is not ready by showing
> the spinning circle, there was no indication that it wants me to
> wait until it fills the blank space with lines.  Not very pleasant.
>
> I do not think it is so bad to say that it is less pleasant than
> opening the large "print test failures" section and looking for "not
> ok", which was what the original CI UI we had before this series.
> But at least with the old one, once the UI becomes ready for me to
> interact with, I didn't have to wait for (for the lack of better
> phrase) such UI hiccups.  Responses to looking for the next instance
> of "not ok" was predictable.

Let me again state my goal clearly, because some readers seem to be
confused and believe that I want to improve the developer experience of
veterans of the Git mailing list who are more than capable of finding
their way through the build failures.

My goal is instead to make new contributors' lives easier.

It is a pretty high bar we set, expecting a new contributor faced with a
build failure to figure out how to fix the breakage. It's as if we
_wanted_ to instill impostors' syndrome in them, which is probably not
intentional.

In that respect, a relatively responsive page that utterly fails to direct
the reader to the culprit is far, far worse than a slightly bumpy page
that _does_ lead the reader in the right direction.

In any case, thank you for integrating the patches into `seen` so that the
impact of the patches can be "seen".

Ciao,
Dscho
