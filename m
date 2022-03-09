Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D07C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 21:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbiCIVrn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 16:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiCIVrm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 16:47:42 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9940F11E3C4
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 13:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646862397;
        bh=Flmy8DkHsFVoiGVqeesMpuMojjmN3QWl12r2dnVC88o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=f7q+uk7//nkGADOUsF4oeXeG+rq5vplUcE+UcS/nsonQvH117+gGTSfx7BFWB9Jr6
         tHvkIde7d5FfjdKLRobSWH68FpWBSpocRBWlIUJyMWfobQiCRYKJOM48idsn7nkb3x
         SR4cOVYpX0lwtkwWhlqToIqnOINyBhq9MN4UUL4I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([89.1.212.224]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6qv-1nv4UA2HV5-00paLo; Wed, 09
 Mar 2022 22:46:37 +0100
Date:   Wed, 9 Mar 2022 22:46:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>,
        Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v3 1/2] t/helper/test-chmtime: update mingw to support
 chmtime on directories
In-Reply-To: <052b3dd9bba8a79890863ace0992aaee41874402.1646201124.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203092234440.357@tvgsbejvaqbjf.bet>
References: <pull.1166.v2.git.1646127910.gitgitgadget@gmail.com>        <pull.1166.v3.git.1646201124.gitgitgadget@gmail.com> <052b3dd9bba8a79890863ace0992aaee41874402.1646201124.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DYIR0FQyi2eeNfwG3eZ3EKU1WOJIMUvIfUO9JiFzT+efCk6c008
 lrDB1gFsuLMev1OfwjOxN0I/6gfQoeS6wloIPgnPx0g/fBFJYCZeBqoMGQIRyjuTtKSNDQo
 1Sa60dtpRny81RWYLMzT2lExnAZBcR7ndoYAIHBxzuNdHckGey3689ETN8ilX8LOBSDUeMP
 33j3odGJW8ygmrTg0ozCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gaEYo0gkVW8=:NXyzaF+QfewuSLtxxbwwpR
 QY2b26hPZDulevVIHXuzZ0v7UDhqZJUNUR/IT/9SZkJYPmBZXHwbGwpCCNtisHZYWC7TenmhG
 JKf+hGGVD2rL3g6KXpCjmz76SGmfehGXo0IOWRFWdO+cAYh29SylA/VKwmQHipup1nibg0GDF
 ls3QRLHqITh47dAaBv/liaEaabrtvV5Q6bAEbsPowKyOodL6syABHiDzapQ/77pVoiMnBsQSI
 dSPUciNELDlGe14psH9BZigw52i5H7mnr19Jkr6uHeKUCW0YY1D1azckM/Ojh+fdJNbD/6HzB
 6Kh7bwpXE0Niy4xVpoNPrlR55BkOtTVqXx/Pg2qd0C7td3l+uoxsH6lHSVJPc2PY1aoWkM0yQ
 XzikaPpTAJgtTwT1Dw0XFitA+jX3SDiqSaj45OiAKSPzx5Ho+Z4IcrfM6wPDVy8X+Lw95xhLt
 jN+tXflmx84YtGjJWC4c0KH/2sepW8sOvKJ3IfqebZnzcIAN5WvHraFqxw1ZAy+8aMHF16l/z
 k9L/zJuSZ7TcV3/V9WBtBt7oaje+gsMvUfYqz8/tS5GSQm15S1tFyoG1TWK3VHQWl8UPktdds
 I3RSw2LOLC4221fwjGgUO+PZB7F1YcKHMo2SdP8S7CEYN3BN/vRvLkBc5PCECdBWlwwWglqfG
 IfOhv0anlvZBwdJRhAOPlFOrYuaOipwbL0CHbyJvYEyJHkQK5PNWqxgs/mArsHl8HC9A5e309
 /BnznQ8vMF4+BmzNNV0ngR206B/wAFbNJ0Yw2P4wyWnNKdvkNfTkIGhG15aiAheAa6C5S89lS
 rhddyBQOktm/Ot/JO/AXp/Ly5mkZq280wV5N6DBen5I0Tu9MsM3IUdXoHVxY8/9VO2kjxLcod
 FCm4/TnNMadsEz5+jhe0HPXs5Qt00lZYZ7fr/FsGTsvX0cWjsPk2ZpM05fmFp2EgBhdsK2nhF
 MmCA5F7k5Cd+YnMYJwfJX4hClk0Jnx2+A0rCA+h7jCmHZ928jUE7PDjVawjz/B6LTOlMULEYX
 fVHKaFhIQw0ewDvEDbDwjW9zOzp41FwFgWVWFsWb9VLwegOrcyL33yRpMdlXHtOkYXJWtQFzP
 CiUEeip3cPtPAU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tao,

On Wed, 2 Mar 2022, Tao Klerks via GitGitGadget wrote:

> diff --git a/compat/mingw.c b/compat/mingw.c
> index 03af369b2b9..58f347d6ae5 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -961,9 +961,11 @@ static inline void time_t_to_filetime(time_t t, FIL=
ETIME *ft)
>  int mingw_utime (const char *file_name, const struct utimbuf *times)
>  {
>  	FILETIME mft, aft;
> -	int fh, rc;
> +	int rc;
>  	DWORD attrs;
>  	wchar_t wfilename[MAX_PATH];
> +	HANDLE osfilehandle;

I would prefer the short-and-sweet name `handle` here. _Especially_ since
we are no longer using `_get_osfhandle()` at all anymore, meaning that
the name is actually misleading.

> +
>  	if (xutftowcs_path(wfilename, file_name) < 0)
>  		return -1;
>
> @@ -975,7 +977,17 @@ int mingw_utime (const char *file_name, const struc=
t utimbuf *times)
>  		SetFileAttributesW(wfilename, attrs & ~FILE_ATTRIBUTE_READONLY);
>  	}
>
> -	if ((fh =3D _wopen(wfilename, O_RDWR | O_BINARY)) < 0) {
> +	osfilehandle =3D CreateFileW(wfilename,
> +				   FILE_WRITE_ATTRIBUTES,
> +				   0 /*FileShare.None*/,

Hmm. I wonder why you don't want to allow shared access? Like, why
disallow changing the mtime while a file is being read?

This is a change in behavior, and I think we should avoid that. Wine uses
`FILE_SHARE_READ | FILE_SHARE_WRITE` in its `_wopen()` implementation
(there are a couple of layers of indirection leading all the way down to
https://github.com/wine-mirror/wine/blob/1d178982ae5a73b18f367026c8689b567=
89c39fd/dlls/msvcrt/file.c#L2261).

The closest already-existing code that creates a file handle to a
directory is in `mingw_getcwd()`, and it even adds `FILE_SHARE_DELETE` to
the fray. That would probably be the best here, too.

The rest of the patch
> +				   NULL,
> +				   OPEN_EXISTING,
> +				   (attrs !=3D INVALID_FILE_ATTRIBUTES &&
> +					(attrs & FILE_ATTRIBUTE_DIRECTORY)) ?
> +					FILE_FLAG_BACKUP_SEMANTICS : 0,
> +				   NULL);
> +	if (osfilehandle =3D=3D INVALID_HANDLE_VALUE) {
> +		errno =3D err_win_to_posix(GetLastError());
>  		rc =3D -1;
>  		goto revert_attrs;
>  	}
> @@ -987,12 +999,15 @@ int mingw_utime (const char *file_name, const stru=
ct utimbuf *times)
>  		GetSystemTimeAsFileTime(&mft);
>  		aft =3D mft;
>  	}
> -	if (!SetFileTime((HANDLE)_get_osfhandle(fh), NULL, &aft, &mft)) {
> +
> +	if (!SetFileTime(osfilehandle, NULL, &aft, &mft)) {
>  		errno =3D EINVAL;
>  		rc =3D -1;
>  	} else
>  		rc =3D 0;
> -	close(fh);
> +
> +	if (osfilehandle !=3D INVALID_HANDLE_VALUE)
> +		CloseHandle(osfilehandle);

It is quite obvious from the diff that it is quite impossible for
`osfilehandle` to equal `INVALID_HANDLE_VALUE`, because if that is the
case, we specifically `goto revert_attrs` which is two lines below:

>
>  revert_attrs:
>  	if (attrs !=3D INVALID_FILE_ATTRIBUTES &&
> --
> gitgitgadget

Therefore, I would prefer the `CloseHandle()` to be as unconditional as
the now-replaced `close()` was.

Thank you,
Dscho
