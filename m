Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3E4C76195
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 12:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjC1MQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 08:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjC1MQC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 08:16:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E33B93E5
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 05:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1680005756; i=johannes.schindelin@gmx.de;
        bh=bePVXWwcGCpwvxJrk93E1ir21F8ewBryWnzBT1dSt+k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dNAhS9pvhvyuDjYXUx2Wi5acazyabZT/P2XGVWiEPth78gzyKmlTPXEjjoimxJjs1
         /9iw179Eu84FdFrhvrdMAqXus7FL16Zl+gq0b1k5zqK0MflPs7IrK51Rao4/JVLehF
         Jy18ntAhQVo8BDF49bi8WprUpIFCNb+dRl442Mlmrz/VszGRY86HGMcYtcsh8wfpqz
         eLQiZ1xrLaJwq5nKN9R2l4TNKmWhnnjUBu+s9X4Hvzd6K1zE29bHyE+z64EeIBnUsF
         T0NEJL2aQ24ZH4Xx+pcJh5dWeGVayxM9kbzfVXYorS9fb324lnExA79RitzauE7IXc
         JbJYxrPkY7Wnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1pfliO46Ln-00HS94; Tue, 28
 Mar 2023 14:15:56 +0200
Date:   Tue, 28 Mar 2023 14:15:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Harshil Jani <harshiljani2002@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] credential/wincred: include wincred.h
In-Reply-To: <pull.1496.git.1679707396407.gitgitgadget@gmail.com>
Message-ID: <8511e030-8167-715c-5ed4-1646e6e9ef85@gmx.de>
References: <pull.1496.git.1679707396407.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jhQcRm4MNhl7wOc++39V/bfC16dtQ8Gio5TO4iaz5eeiwNbeHHa
 aQ61aUYccF3K5kijCQj5xXkRqRcFcyVv5hRh40U17Mpqe+FcZTZ1/vSkTJD3Tl8v6w9MqRd
 XD0Gx90YChcSfRoSHMTeK7E0slkvnu0lk1aIZ9EurgKFmxsliDUSWHGqdItjK7FGDmmNSCp
 C7eFWf+Uwsc9HCprZbSoA==
UI-OutboundReport: notjunk:1;M01:P0:pILe9VCJ8Bo=;sLQzX+1SKP1qxFX2VLVrhjmL8xY
 xiYYbp2iJ44cVnpoTrc5Ji5svVvFFhwYmFjRxLQ7RH1wqFfPxi0KEl8EuuZELik++edhFj7sX
 bPNltkuX+wv6nU3PgLKZEkE/KFq3u2xq7PrU7z3x/s+oL98whw5PXAlG7HQ+b/VqWOrD8HGTm
 hpduQ1K2xjapEpzNh9eXzIEXor0nAbiH7Sg5LCrAvgMqTqn1bICp2CLtagDr+wekYHQQ7xg1e
 StGJCIdr7yE0Dx3gAqKXQRF0Ljfdyo9hVnwRVzWPBS1xXHNiljvbG9GxUBTEnaugVmGDLm8v3
 J3o8s1jo5DMBIocpUPDCTuTmDbwyYvGZDlr2+rqA6A2oiEM/2OSURSjzA1+EM5Zn4rzLtZs0L
 8dPjUptStfQKSJc7UHudTZafODvRsgZVEj6sdwAX8ih46TqJejNdyESaBFexXOy3Twr+wlPt/
 bYPrQ2iXYL4km3TxVVNw1PgVx7vfseuXTQlCB9fm8z1403FDgcgY0Ap06ybWqIKep+MLHTn1K
 F7/0mJMlq5jKp3Tbq/mB4+AbaBDzX/wV0aiyVOCqhSmwCmGtXm2uB3ZlmEEqsNktw2KgmshJA
 tmI53zNCFj5JwMWqB8lh6h0gAxojdFnnWL+a9bPPHE5+DdQU1xs30I2V6AD77+p7XIx4Ce2se
 q2gs8dPphNjRB7ah0r3aXO+GWwbvcQMsyeDooFfGovP8fNAcx3RUdP4LuwDquDwBxpH+buC4P
 lHdfHSrfJr9rK2/ocY3HA46kr381MeWMwLgJLNGWo/3M6h6OqcMw24TxI+9arvOBZ5F9HNah0
 3ZLv8fmT8C6wsJxmWIewhNGxfAML6xeogaJ7xAijlDXdzCFnBmIlQCDhEUNDANVeGM/OM3p/L
 Xv9g9lnfG22SHKqxqCuJOfDt48gct8to4aIhfAZ/rozX2MzGxwmataE3Kxv2nRrqaRExVXGQw
 3anGldApW+Oj/nAi/Y74QRLi34I=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi M,

On Sat, 25 Mar 2023, M Hickford via GitGitGadget wrote:

> From: M Hickford <mirth.hickford@gmail.com>
>
> Delete redundant definitions. Mingw-w64 has wincred.h since 2007 [1].
>
> [1] https://github.com/mingw-w64/mingw-w64/blob/9d937a7f4f766f903c943304=
4f77bfa97a0bc1d8/mingw-w64-headers/include/wincred.h

Sounds good, and the diffstat is nice. But not as nice as it would look if
we retired the `wincred` helper. As I pointed out in
https://lore.kernel.org/git/35e1ebe6-e15b-1712-f030-70ab708740db@gmx.de/,
I'd much rather spend my time on other things than reviewing patches to a
credential helper I consider unsafe.

Ciao,
Johannes

>
> Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> ---
>     credential/wincred: include wincred.h
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1496%2=
Fhickford%2Fwincred-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1496/hick=
ford/wincred-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1496
>
>  .../wincred/git-credential-wincred.c          | 61 +------------------
>  1 file changed, 1 insertion(+), 60 deletions(-)
>
> diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contr=
ib/credential/wincred/git-credential-wincred.c
> index ead6e267c78..6e5a91a7168 100644
> --- a/contrib/credential/wincred/git-credential-wincred.c
> +++ b/contrib/credential/wincred/git-credential-wincred.c
> @@ -6,6 +6,7 @@
>  #include <stdio.h>
>  #include <io.h>
>  #include <fcntl.h>
> +#include <wincred.h>
>
>  /* common helpers */
>
> @@ -33,64 +34,6 @@ static void *xmalloc(size_t size)
>  	return ret;
>  }
>
> -/* MinGW doesn't have wincred.h, so we need to define stuff */
> -
> -typedef struct _CREDENTIAL_ATTRIBUTEW {
> -	LPWSTR Keyword;
> -	DWORD  Flags;
> -	DWORD  ValueSize;
> -	LPBYTE Value;
> -} CREDENTIAL_ATTRIBUTEW, *PCREDENTIAL_ATTRIBUTEW;
> -
> -typedef struct _CREDENTIALW {
> -	DWORD                  Flags;
> -	DWORD                  Type;
> -	LPWSTR                 TargetName;
> -	LPWSTR                 Comment;
> -	FILETIME               LastWritten;
> -	DWORD                  CredentialBlobSize;
> -	LPBYTE                 CredentialBlob;
> -	DWORD                  Persist;
> -	DWORD                  AttributeCount;
> -	PCREDENTIAL_ATTRIBUTEW Attributes;
> -	LPWSTR                 TargetAlias;
> -	LPWSTR                 UserName;
> -} CREDENTIALW, *PCREDENTIALW;
> -
> -#define CRED_TYPE_GENERIC 1
> -#define CRED_PERSIST_LOCAL_MACHINE 2
> -#define CRED_MAX_ATTRIBUTES 64
> -
> -typedef BOOL (WINAPI *CredWriteWT)(PCREDENTIALW, DWORD);
> -typedef BOOL (WINAPI *CredEnumerateWT)(LPCWSTR, DWORD, DWORD *,
> -    PCREDENTIALW **);
> -typedef VOID (WINAPI *CredFreeT)(PVOID);
> -typedef BOOL (WINAPI *CredDeleteWT)(LPCWSTR, DWORD, DWORD);
> -
> -static HMODULE advapi;
> -static CredWriteWT CredWriteW;
> -static CredEnumerateWT CredEnumerateW;
> -static CredFreeT CredFree;
> -static CredDeleteWT CredDeleteW;
> -
> -static void load_cred_funcs(void)
> -{
> -	/* load DLLs */
> -	advapi =3D LoadLibraryExA("advapi32.dll", NULL,
> -				LOAD_LIBRARY_SEARCH_SYSTEM32);
> -	if (!advapi)
> -		die("failed to load advapi32.dll");
> -
> -	/* get function pointers */
> -	CredWriteW =3D (CredWriteWT)GetProcAddress(advapi, "CredWriteW");
> -	CredEnumerateW =3D (CredEnumerateWT)GetProcAddress(advapi,
> -	    "CredEnumerateW");
> -	CredFree =3D (CredFreeT)GetProcAddress(advapi, "CredFree");
> -	CredDeleteW =3D (CredDeleteWT)GetProcAddress(advapi, "CredDeleteW");
> -	if (!CredWriteW || !CredEnumerateW || !CredFree || !CredDeleteW)
> -		die("failed to load functions");
> -}
> -
>  static WCHAR *wusername, *password, *protocol, *host, *path, target[102=
4];
>
>  static void write_item(const char *what, LPCWSTR wbuf, int wlen)
> @@ -300,8 +243,6 @@ int main(int argc, char *argv[])
>
>  	read_credential();
>
> -	load_cred_funcs();
> -
>  	if (!protocol || !(host || path))
>  		return 0;
>
>
> base-commit: 27d43aaaf50ef0ae014b88bba294f93658016a2e
> --
> gitgitgadget
>
