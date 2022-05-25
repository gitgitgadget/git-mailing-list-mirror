Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC09C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242075AbiEYKYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiEYKYG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:24:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F102E8A056
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653474229;
        bh=xmkRyubfGVFntvm9Fsn5DY2n6Pcia4QsR3H4QqJvN6E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XMUt/4CXzGo4W7FDN5Wl8qImQL3OiXcuW9ZoPJ8Uy/FjOXK/MwDaLzbcIwURp6GnI
         GDgYlEtx3zytVTd5Jf9n3IaERz6zGjRSmUisS32m1L5GpOzEPL55+AsGWPtlSfFCpB
         YzhzmlNdCtX+Vqk245AwFyS5hbfoACHJwaVBoguI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3HU-1o4rr31Q7c-00FPrv; Wed, 25
 May 2022 12:23:49 +0200
Date:   Wed, 25 May 2022 12:23:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler <git@jeffhostetler.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Torsten B??gershausen <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 00/30] Builtin FSMonitor Part 3
In-Reply-To: <dc1bd9f6-f83f-5cb1-9b0c-68d28a4cc216@jeffhostetler.com>
Message-ID: <nycvar.QRO.7.76.6.2205251223180.352@tvgsbejvaqbjf.bet>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com> <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2205241357410.352@tvgsbejvaqbjf.bet> <dc1bd9f6-f83f-5cb1-9b0c-68d28a4cc216@jeffhostetler.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/YHFn1ktFQGqMPDrsI7y9gLIUbXrhkCts0zoBKry4nqKpFJfmba
 w8vXEvhBvTSH1mXIf7h7C4KMnSYgfnVu7Nba0tiCSY4QApuUAX6s7vQd5nyoltTB4j0QcHQ
 CUbmpq0AKQSj5ph/FzcQk5EBZfsrtG4bPq2c8cOM/nBRVsBxgbMlCCPKpjMVgzzSG5b4M6u
 iUNTjV2w8Pk3UE1QsDpew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fW2OiOuTldI=:EkknT0zGS1n9dDmRN+C2gl
 y+DRS8bw9SSaMicgboj525oav4gy97vvWko6LNcUlIG+mEALs0dEE81+gTemvRgTDtw7sdALa
 JNCdxIT3Lcmo+AJbn9D7/YYOoxovhobtd2CLy1dXt+xCokNGtCSf+cyuggUdMWgmxjmePvAvz
 o9B270NQ03a+aYyuFGKkFXeI/MFHuaRmalsJy5WJ9NVzXpEAIBeGIinItFz29ztEZz9mnyO9g
 AJN9GvZKYpq+MiC0vdfmeE7TpCJS8QSIrEVltZzsu1opvA6xKxXnsFaUpadu0edNMEEqH9I9j
 +bKMcwwMqXThDAUFXdzFRpTLLW6+k3OzBe19Z525SQLOZmCFihs+10H9ku1tQLSUUO1YAeHtQ
 Q2WFqH5cKD4iEPpWM4uAEQXcgBn+/mEiiXCw7/Cb/VXkjLICXnM8RrFna0zF/L3EWHwIMNgxW
 VuKt/hoh4OZEj5Lm62IjQzVbhqYLbSJP69kmXRytYH6AwNaaMDdeuxJXzgUFdm5qkTZDadU5V
 9gmp9b9M7Cp/7sEukrfThOWIm2pywv+e7nSSBeyAMZFW714/wGdy4jap9mc+BPD83vkOf6OVn
 jNLp2hHH59ux9+LWABppeVAfhQ43GpqDpekGO+LLNe6JhZ3F6XjFXKsPP1D+wiTEq9RgQkfdY
 sSO1czeYpZtFGwVOkSWq6nq9nxjtRSig0tsaOSXV270VhJDX5iiJQCaw9sA8MnBQujrqNStqo
 kx2r0WNCwm67GzCAtooP83ZZ9rmWAuAdwWupEqZVcCfUd7hFskNf14pEuzL4KgeuFqbs4r3N6
 IH9gMx8Zrk3EdGY7BMLK4zhdHiQ2GgffB/PZqGWxkAUwXfD17zjFwXaIcG5AbRwboVDJNoCGZ
 nld4AA0mfNvjQYjNeJCGW5EJjYH4DbXQU9BIYagM6l2/iXXiaXWuxvNkZanoz0X66hZxotJ8Q
 IX5KWliZq1588xRatqmrLUJJe9zDG8MmKMkjhad/Ccj7+eC+lPe5xqu9igywjhKPIiyqq+ftx
 qaZFI2EZkGTJdMdzyi9YQPBX7eiLsdHWrIgpy3BG7Py1OwEge+aMB45DbyaAlzIW6SHjrprFA
 ojBtMinxxYsPrCPq40INxBZdioAVXx7UfqUFG/ghyHThZ0nkwDCgTJgtw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Tue, 24 May 2022, Jeff Hostetler wrote:

> On 5/24/22 8:00 AM, Johannes Schindelin wrote:
> >
> > On Mon, 23 May 2022, Jeff Hostetler via GitGitGadget wrote:
> >
> > >   1:  8b7c5f4e23 !  1:  26144c5865 fsm-listen-win32: handle shortnam=
es
> > >        [...]
> > >      @@ compat/fsmonitor/fsm-listen-win32.c: static int
> > >      normalize_path_in_utf8(FILE_NOTI
> > >       +{
> > >       +  wchar_t buf_in[MAX_PATH + 1];
> > >       +  wchar_t buf_out[MAX_PATH + 1];
> > >      -+  wchar_t *last_slash =3D NULL;
> > >      -+  wchar_t *last_bslash =3D NULL;
> > >      +  wchar_t *last;
> > >      ++  wchar_t *p;
> > >       +
> > >       +  /* build L"<wt-root-path>/.git" */
> > >      -+  wcscpy(buf_in, watch->wpath_longname);
> > >      -+  wcscpy(buf_in + watch->wpath_longname_len, L".git");
> > >      ++  swprintf(buf_in, ARRAY_SIZE(buf_in) - 1, L"%s.git",
> > >      ++           watch->wpath_longname);
> > >      +
> > >      -+  if (!GetShortPathNameW(buf_in, buf_out, MAX_PATH))
> > >      ++  if (!GetShortPathNameW(buf_in, buf_out, ARRAY_SIZE(buf_out)=
))
> >
> > Nice touch using `ARRAY_SIZE()` here!
>
> Thanks.  And hopefully it will make the GFW downstream MAX_LONG_PATH
> fixups easier too.

As a matter of fact, it already did!

Thank you,
Dscho
