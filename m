Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFFFC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 12:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiEXMjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 08:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiEXMjr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 08:39:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEEE9729F
        for <git@vger.kernel.org>; Tue, 24 May 2022 05:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653395983;
        bh=ISMUWWXQCdZ68K8peDca2drvmZH4/C8cQp764N3yjoc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W4ceUPWAWuk9vs5K5FNWlzcpxIjVsIU39v+ZpLNpWBppPPQQPGLeGFRY91ZtuNmTP
         eEicJBYfNN382bzrFCHPsEPjWDIV3Oadvx2LePc009lA4q4AdqUVRKhg7/brKAPq82
         VwaB/fZ2Aa+LVFMzs4Qx8/xXOs+5z/DTO6yOUmqk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6llE-1nv7ib0qYI-008KMf; Tue, 24
 May 2022 14:39:43 +0200
Date:   Tue, 24 May 2022 14:39:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] compat/win32/syslog: fix use-after-realloc
In-Reply-To: <d0ade6531bc77b654c28cf7b1bfa42523150c015.1653351786.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2205241431400.352@tvgsbejvaqbjf.bet>
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com> <d0ade6531bc77b654c28cf7b1bfa42523150c015.1653351786.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:05ZnwG9fVPo8/HOl7pYyDcNlTirjnuvbycOz0D7B3tNTCiJv948
 D+EHCY/kqtKv6tm6Z44Y9TZzaSxPNYFm8b626DM+/Vludg3Tn6aygl18I53+3z23Lnfp2tE
 XzspDWp0GuijAoVKOZO7ZxqYkTLtmrU4MoVZqh5ms7vXBgPZfmDrBJKO6gXy1jNS8bh2Ayf
 AsGZGCtAb8opoe8QCOqtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G89VI3jLjc4=:2/+loNU83yqieeo2M2mtoH
 aoWWKsMPOFH8DMVLuoY0NF6SFmzEPsm+OM9AzAwPMzGLwOZSa6Rh+zrCAPbi16Mtl6KhWsVMq
 zc2aSYNu99euqaqWaxJHSaBxfl9fOVHabx40eAjAbQ/UVDeit27hUrTxWTrkWGkw6qs6Chuvh
 7XXI3shpSQeEZn2DMvkro1f8zLEGxI06LHsPya50jzVF13FUAxBAOS/F1yvGmJNKsdgAM3yB6
 gY6u67rMjadAmkHyNQURXUKr/WEYE/sr2+rcUwkCl+sqhakz2aZiDDTlgRV/Y5fWIGHJmVeCl
 K7k2LT2J6gc+apGHg5mdftGI1QEjN7/kqtz48sDRh+tjrMzdGYy3IP0b4yHAzox6KyGItr152
 XVq3C8O23l5HNuo/NufgXG18qeJdpAWqqRhJBX2JShTypOKyjG4aFGV7ksfBHCcjHZqAsYXL4
 dsKMLgxamGYuwLfLEDkSGIoLVtUt+PReEp93VLSQiKPCMpxtB/eNQdkh5ZEATtpW/teldNGd0
 JELuFhD7UlXKywRFCryJDIqY8ZEfsd2MfG+NSRVf5MsEZgEcrBfbyLhIkNnCTYFrLWgjW65PF
 PhY3Y4DMnBR4BkArENg1UhSfOd2IT3F689oY3ClWGRIg/zU4I4zewRqw6Hz1YWxrlGVwNIhZ0
 lhpDrvWc+7a5q+vTBqnt1QBELoWV0ixcczc3+V7igtIj9Ln3xpYnZTj4zE3hJ9F3oJy1Jb7CA
 Eh27N+9aQhAkx8XefY8YI2EBeuqag+nUmQ9O9qmQZ9FuhtjAwnAEMtPtc2Oa8UXIXhcXcXsJf
 U16uf0iZVTyuHY7w8btZoHYSah9lDtMkazGnb99EE/BUh0d5rKauisPc4RnUEZPikKN6proMs
 JPAoZEFwn7xL54HHdD5uOWUrtL1aMrnC3q7O0ZPdTQm7TBMX3Z6mSVDlrsI+zrbhX9cxE7QNO
 ewAu0hdZ7YL5vaIDQpiY7W0tfVEFuRUTCwyP1BPBSXkXxzl8fMeAiVgrozHnZYeCS35i+tzel
 92NquDevFinzBve0yOZg5HjwcUsuC81OU0z89oA6xzDH2qsv39T9mV43tFu2mo1OlK6+IrTfM
 vK4PWZw44F8iVmTmHFnYjatnV58IuVbqQnkz4MzEK4U2ZOveHvdsZ5a5w==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 24 May 2022, Johannes Schindelin via GitGitGadget wrote:

> diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
> index 161978d720a..1f8d8934cc9 100644
> --- a/compat/win32/syslog.c
> +++ b/compat/win32/syslog.c
> @@ -43,6 +43,7 @@ void syslog(int priority, const char *fmt, ...)
>  	va_end(ap);
>
>  	while ((pos =3D strstr(str, "%1")) !=3D NULL) {
> +		size_t offset =3D pos - str;
>  		char *oldstr =3D str;
>  		str =3D realloc(str, st_add(++str_len, 1));

Since it has been raised elsewhere: Why is that `++str_len` not turned
into an `st_add()`?

The commit adding that `st_add()` call (50a6c8efa2b (use st_add and
st_mult for allocation size computation, 2016-02-22)) does not really talk
about it, but the explanation is simple:

Before this `while()` loop, we allocate one more than `str_len` (see
compat/win32/syslog.c#L35), and we do that already using `st_add()`, so
that the string and the terminating NUL fit into the allocated memory.

Therefore, the first time we enter the loop, we know that `++str_len` is
safe.

Now, in this very line, we then increment `str_len` and then `reallocate`
one more than that, again guarding it via `st_add()`. So every subsequent
iteration will already have checked that `++str_len` is safe, too.

By induction (https://en.wikipedia.org/wiki/Mathematical_induction), it
follows that this line is safe, and we do not have to change it to a
clunkier two-step assignment where we first use `st_add()` to increment
`str_len` and then use `st_add()` to allocate enough memory to also fit
the trailing NUL.

Now you know,
Dscho

>  		if (!str) {
> @@ -50,6 +51,7 @@ void syslog(int priority, const char *fmt, ...)
>  			warning_errno("realloc failed");
>  			return;
>  		}
> +		pos =3D str + offset;
>  		memmove(pos + 2, pos + 1, strlen(pos));
>  		pos[1] =3D ' ';
>  	}
> --
> gitgitgadget
>
>
