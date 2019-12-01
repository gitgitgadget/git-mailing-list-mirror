Return-Path: <SRS0=LEOb=ZX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823BAC432C0
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 09:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BEE02146E
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 09:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VYpvvNno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfLAJxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Dec 2019 04:53:47 -0500
Received: from mout.gmx.net ([212.227.15.19]:54679 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfLAJxr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Dec 2019 04:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575194022;
        bh=FhJppdjDQ+RXDgYLiRaJl4/4zS9+nNJRmsGbxwWS028=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VYpvvNno2YfyQlYzUiRGmB7BlTkrb/wsFqG0+sGx6cz0R+exzFcQY+qHV560UV1dX
         lHiRD4zSzq4nDBNDG17MGqiLTLkZnyxF83fpFZwoLFDIn9WfdSgd4YJk4wUT5/hYum
         osBAV+kWXKXEEzVa7l13/f1nPDf7mLdofCOtWoM0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N33Ed-1hejU039en-013Lfm; Sun, 01
 Dec 2019 10:53:41 +0100
Date:   Sun, 1 Dec 2019 10:53:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Brown-bag fix on top of
 js/mingw-inherit-only-std-handles
In-Reply-To: <xmqqfti41rz1.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912011042460.31080@tvgsbejvaqbjf.bet>
References: <pull.480.git.1575063876.gitgitgadget@gmail.com> <pull.480.v2.git.1575110200.gitgitgadget@gmail.com> <xmqq5zj12qc2.fsf@gitster-ct.c.googlers.com> <6beaf25f-1369-3e77-fd54-fdb5a1e63707@kdbg.org> <xmqq1rtp2k01.fsf@gitster-ct.c.googlers.com>
 <xmqqfti41rz1.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:N6HFRwRVuEtmkL3yMP4uuYYRWpnJsaGkw4ba3juSp6QkliAC/Ib
 ufFOlQsLkEE/9ApwKjFZvvpvqQZN/Csnurjt5UvIRl+ERK8OjWNO6r/20Rg3bgrFYSCeNqf
 orkzuKvHljkrTA5NWSGoxuJsXGQ/xFaph5/c6LTiELisAYo1eORnqP8LmUYvHWTEgkSeX4k
 tuJ12inh6Oo7UweNL+5kg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yHmoLYSt82I=:8i7DctxgKjDXCyVhzyAD9e
 5t2EgPdiek5P7cL7M8gW8kCozq7wsEDFFmout+zoqLnq394XHuajd+7D2lQsnYWlQuOz3CMBW
 MCHz5/6wR+/sL0/2H9XjAwp1BxXmfGbQ77V+/oOqVzhDHygrxrddgvOt+kDdwVEsXcqdupaWz
 eSnE4eQTvdm8EyrlRPuzNyMKBGG1ArQYfkz0MGxR+GbhVvMmOSdDXLBT/XbSnv3uWSiqHxvd8
 Fu4KEHN0Szta6ZDYgl5wN2Qdy7bHiJ9hfC6BLo3Sjfe68ACG27Gt3IlUrGT584RFXxD0ZKlx2
 WlVPZKpAFQ8Y3nh+uhNi6naLpj3tJxkiMZ3tsiLsIggHRDIc9wbXQIq5vEt3pc5WAuQQWSNy2
 Skl4JhPmWJ5H6RFWAzGlcEAZYn84A8bPPcM5cMgOFVlyRk1J0u5GKKHBGWleeXEIX1HRrme6g
 48QrAZYZOJkMtJ0yflOvOoIp0dj334v743Va4sJRU2GTtmfE+YWfdSIWmYkGbHWsnQ2D6Tf2m
 xdry0Q+XZz6eNhcEgUC5v5zM4hbSmIiwszrBx1hcxPxXuBcgOdZSImiF3YD/E5LRxJwLLkO7h
 QV66b8yH9s5xsIrJCpbm7I2VtXKLi8h7EpVlO0ua8dkl0Ps5JDnemWmeElo7PF0qEvz18l+uU
 rQuQ39rva6W0iyQd5R9tu0gYR25IF8qeVzXmdcWx3+yqGiVjcEZVa8rqdDEWTEjlVmKT4OIIT
 YrAFT7XpK8AXjboEwkFN0/agPtguK3vst+GLpnq4JYMqp49+ACrbRkxUcrMQg6DZVSQi66HZp
 APsJrQtuEUCH8pfbpYzoElPv+i5AGAD1pex/u8ougQjOTPPDUjAZmysvqwFsyuwoY6BtlQ1v4
 wSbdRzVlqLq3bcMvgibK1S412CBwBSag2KImp3XpH67W3Fs7XFf92ERp5QCgj5AA+yV/hX7s+
 Co66vh21s6/BKR/DMTqsjgs6+4etgn+Lh5zOe3hGUuIK0To2+ynNOzjaxhHEFamdKpM8Z7v8q
 UTlXrTpVQU6CkKxV96Ea4ABLNmcFxyWGyq+0KaUyW0svyMpDMOPd30zABsGLcfUuMLVZSYK7j
 kCmdWGnGvEF4I44ONLgFaRy5IZiEXSuQ2Qvz7M2BtOmGUNysz80dNSMR0kM1hYka28MZwWita
 fj9E/mA5Lue6PPUtjxbrF1V0LpdoNhyYJP0T+BhKjjod2Q0P//cca8RRUWeOAOIqtf6xSp3Kg
 8C8gP0AI0C5mLLESXRv1+0plQsRGdhqh036oVN7JHY+LpxJvPoXHvJBGazc0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 30 Nov 2019, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Johannes Sixt <j6t@kdbg.org> writes:
> >
> >> Just like on POSIX the value of errno is indeterminate after a
> >> successful system call, the value of GetLastError() indeterminate aft=
er
> >> a successful Windows API call. Therefore, the err_win_to_posix() woul=
d
> >> not be able to point at a bogus caller reliably. For this reason, let=
's
> >> consider the function as a simple error code translator, and then
> >> translating ERROR_SUCCESS to 0 (or is there ESUCCESS?) makes total se=
nse.
> >
> > OK, that makes sense.
>
> Actually, I do not think it makes that much sense, especially in the
> context of this patch that claims to map success to 0 (assuming that
> no E_ANYTHING has the value of zero---I am not sure POSIX gives such
> a guarantee) "for good measure".

But the intention is not to help correct callers! The purpose of mapping
`ERROR_SUCCESS` to 0 will help _only_ callers that try to report an error
when none happened. On Windows, which is the only platform where the
discussed function is compiled and used, `strerror(0)` has the
well-established behavior of returning "No error".

Now imagine that a user encounters a bug where a code path does indeed
incorrectly report an error where no error occurred (or where Git is
looking for the error too late or something like that). You probably agree
with me that we should really avoid reporting "Function not implemented"
in such a case and rather say "No error", which will help figure out the
bug much quicker.

And that is what this patch is all about.

Ciao,
Dscho

> Even if Windows API makes the GetLastError() unusable after a
> success call (unlike POSIX, where errno is left alone), the API
> calls themselves would be signaling their own success or failure,
> right?  So I would have imagined that any kosher caller would be
> doing this:
>
> 	if (SomeWinAPI() !=3D SUCCESS) {
> 		errno =3D err_win_to_posix(GetLastError());
> 		... possibly other reactions to the error ...
> 	}
>
> If using a value grabbed from GetLastError() after a successfull
> Windows API call is a wrong thing to do as you taught us in your
> message, then an unconditional
>
> 	SomeWinAPI();
> 	errno =3D err_win_to_posix(GetLastError());
>
> would be wrong anyway, and touching errno unconditionally, when the
> previous call may have succeeded without checking, makes the pattern
> doubly wrong, no?
>
> Having said that, I do not expect myself to be looking into and
> fixing anything in compat/*win*.[ch], so I do not care too deeply
> either way, but I thought that it would help keep the sanity of
> developers involved if we touched errno only upon a failure from an
> underlying system.
>
> Thanks.
>
