Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143AEC433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 02:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E48D560FF2
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 02:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhJSCvZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 22:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhJSCvY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 22:51:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3326DC06161C
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 19:49:12 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 5so6702060edw.7
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 19:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rxmefxfjf8f3qj1rbYQ5jR23UnzKYT+byNFy/cikCKo=;
        b=RxmAbQQKj+NS8tceqbf1NYih8/ZThL27yViQ3Uviplz/5ZhAYAqr/yLoB2zUqFHqmI
         iO+aNVVc4l3AlNq/6U5DZZTsRNbYvPw+CBhHgESWdAta8Zvp2DITUp4FaqwrGTUhHdVt
         sHRgfo4xcANgUg18F90/uFw/IBJT5atp+x16rTfenK/W4tq9S5wVQYkH6Bwk+sjOZCim
         uHqUMopeFDoVatNu6fM67J+O8wia73zNZ91taDMubFimpVAPCOl2E+bYewRBigTBvyvg
         /I8D8fg3lDZJYJ9X0RJg8j7Rfxj36aQVj5Yg399PqdD20614pggL7HA8M1vdtY02ZmUt
         qPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rxmefxfjf8f3qj1rbYQ5jR23UnzKYT+byNFy/cikCKo=;
        b=ssAs2SdUtf5oejQrNSGYZv1E93IBVkg3aUCKZZhGMhjpe5PgyP9VGBh0Y1OhUyPueg
         4pugz2xZT/158x2+55a2iEu670R9v0wmt+yW9TB7m5IuGIHPyAPI9CfJ+1wxQBYOdWvf
         eWBIlB7wcoje3xsnUScSu8TSrd0ewJtl+4BELXnmDrt0H04UNvXRTAxbiHGMI2QnjqDf
         wSvxoQ8ctvH0AYmpcS6ObGGV3kFXRAZYph9wsEo3eDu3L2g1CDU6pnUpBQo62LQNBKGc
         UNeDrMO2Ko2JvgAylNfTdLzy3zyDogdVI2XTBZkBF0/yaI/MGbU8wCKnXzwwdIHcMaYl
         KRZg==
X-Gm-Message-State: AOAM532F0yq10U+K8nYubx6sGBbakbTIruH+GYLzNMcv5cGSrS2kjrHn
        J6Bnna189A9Xn1/I1QRfmkmuauTN5hjzXMJpoeIN8f0CLGmE4A==
X-Google-Smtp-Source: ABdhPJxRN+u0+2gzSDv5L8MKy08F3JwfrY1KOY6TT7IGIDmhUMiWmxiI43PIvxCh0FdDPGyTQM/wE4yHWyjGiadpf70=
X-Received: by 2002:a17:907:2dac:: with SMTP id gt44mr35811414ejc.265.1634611750599;
 Mon, 18 Oct 2021 19:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <001401d7c490$e7d57620$b7806260$@xeltek-cn.com>
In-Reply-To: <001401d7c490$e7d57620$b7806260$@xeltek-cn.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 18 Oct 2021 19:48:59 -0700
Message-ID: <CAGyf7-GV62dHzsiV7KD2h8Rgg2HBWn1TgimodzcPUWravowUGQ@mail.gmail.com>
Subject: Re: Git failed to pull after upgrading to 2.33.1, using choco
To:     LL L <lll@xeltek-cn.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 18, 2021 at 7:34 PM LL L <lll@xeltek-cn.com> wrote:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> 1. uninstall git for windows 2.32.2
> 2. install git again with=EF=BC=9A choco install -y git
> 3. git pull emit error:
>
> git@e.coding.net: Permission denied (publickey).
> fatal: Could not read from remote repository.
>
> Please make sure you have the correct access rights
> and the repository exists.
>
> 4. I am sure it is caused by the upgrading, I observed same issue on my o=
ther windows 10 machine..
>
> What did you expect to happen? (Expected behavior)
>
> pull from origin;
>
> What happened instead? (Actual behavior)
>
> git@e.coding.net: Permission denied (publickey).
> fatal: Could not read from remote repository.
>
> Please make sure you have the correct access rights
> and the repository exists.

Most likely you're running afoul of an OpenSSH 8.8p1 upgrade in Git
for Windows 2.33. OpenSSH 8.8 disables ssh-rsa key exchanges by
default[1], which results in this sort of error. Git for Windows
2.32.2 was using OpenSSH 8.7 (or perhaps OpenSSH 8.5).

[1] https://www.openssh.com/txt/release-8.8; see the
"Potentially-incompatible changes" section.

>
> What's different between what you expected and what actually happened?
>
> It doesn't work.
>
> Anything else you want to add:
>
> coding:/mytex on =EE=82=A0 trunk [?]
> =E2=9D=AF git pull
> git@e.coding.net: Permission denied (publickey).
> fatal: Could not read from remote repository.
>
> Please make sure you have the correct access rights
> and the repository exists.
>
> coding:/mytex on =EE=82=A0 trunk [?] took 13s
> =E2=9D=AF ssh -Tv git@e.coding.net
> OpenSSH_for_Windows_8.1p1, LibreSSL 3.0.2

These details end up being for the OpenSSH Windows package, which is
_not_ the SSH being used by your Git for Windows install--it's almost
certainly using the bundled OpenSSH 8.8p1. You should double check by
explicitly running the ssh.exe that's in your Git for Windows install
instead.

> debug1: Reading configuration data C:\\Users\\LL L/.ssh/config
> debug1: Connecting to e.coding.net [81.69.155.167] port 22.
> debug1: Connection established.
> debug1: identity file C:\\Users\\LL L/.ssh/id_rsa type 0

So you're using an RSA key. This may be a problem.

> debug1: identity file C:\\Users\\LL L/.ssh/id_rsa-cert type -1
> debug1: identity file C:\\Users\\LL L/.ssh/id_dsa type -1
> debug1: identity file C:\\Users\\LL L/.ssh/id_dsa-cert type -1
> debug1: identity file C:\\Users\\LL L/.ssh/id_ecdsa type -1
> debug1: identity file C:\\Users\\LL L/.ssh/id_ecdsa-cert type -1
> debug1: identity file C:\\Users\\LL L/.ssh/id_ed25519 type -1
> debug1: identity file C:\\Users\\LL L/.ssh/id_ed25519-cert type -1
> debug1: identity file C:\\Users\\LL L/.ssh/id_xmss type -1
> debug1: identity file C:\\Users\\LL L/.ssh/id_xmss-cert type -1
> debug1: Local version string SSH-2.0-OpenSSH_for_Windows_8.1
> debug1: Remote protocol version 2.0, remote software version Go-CodingGit
> debug1: no match: Go-CodingGit
> debug1: Authenticating to e.coding.net:22 as 'git'
> debug1: SSH2_MSG_KEXINIT sent
> debug1: SSH2_MSG_KEXINIT received
> debug1: kex: algorithm: curve25519-sha256@libssh.org
> debug1: kex: host key algorithm: rsa-sha2-512

Looks like the server supports more secure RSA key exchanges, which is good=
.

> debug1: kex: server->client cipher: chacha20-poly1305@openssh.com MAC: <i=
mplicit> compression: none
> debug1: kex: client->server cipher: chacha20-poly1305@openssh.com MAC: <i=
mplicit> compression: none
> debug1: expecting SSH2_MSG_KEX_ECDH_REPLY
> debug1: Server host key: ssh-rsa SHA256:jok3FH7q5LJ6qvE7iPNehBgXRw51ErE77=
S0Dn+Vg/Ik
> debug1: Host 'e.coding.net' is known and matches the RSA host key.
> debug1: Found key in C:\\Users\\LL L/.ssh/known_hosts:28
> debug1: rekey out after 134217728 blocks
> debug1: SSH2_MSG_NEWKEYS sent
> debug1: expecting SSH2_MSG_NEWKEYS
> debug1: SSH2_MSG_NEWKEYS received
> debug1: rekey in after 134217728 blocks
> debug1: pubkey_prepare: ssh_get_authentication_socket: No such file or di=
rectory
> debug1: Will attempt key: C:\\Users\\LL L/.ssh/id_rsa RSA SHA256:SzTwSmfm=
iLOTlZGuTIhP2VctForj8wVH866bFSWWLH0
> debug1: Will attempt key: C:\\Users\\LL L/.ssh/id_dsa
> debug1: Will attempt key: C:\\Users\\LL L/.ssh/id_ecdsa
> debug1: Will attempt key: C:\\Users\\LL L/.ssh/id_ed25519
> debug1: Will attempt key: C:\\Users\\LL L/.ssh/id_xmss
> debug1: SSH2_MSG_SERVICE_ACCEPT received
> debug1: Authentications that can continue: publickey
> debug1: Next authentication method: publickey
> debug1: Offering public key: C:\\Users\\LL L/.ssh/id_rsa RSA SHA256:SzTwS=
mfmiLOTlZGuTIhP2VctForj8wVH866bFSWWLH0
> debug1: Server accepts key: C:\\Users\\LL L/.ssh/id_rsa RSA SHA256:SzTwSm=
fmiLOTlZGuTIhP2VctForj8wVH866bFSWWLH0
> debug1: Authentication succeeded (publickey).
> Authenticated to e.coding.net ([81.69.155.167]:22).
> debug1: channel 0: new [client-session]
> debug1: Entering interactive session.
> debug1: pledge: network
> CODING =E6=8F=90=E7=A4=BA: Hello eyl, You've connected to coding.net via =
SSH. This is a Personal Key.
> eyl=EF=BC=8C=E4=BD=A0=E5=A5=BD=EF=BC=8C=E4=BD=A0=E5=B7=B2=E7=BB=8F=E9=80=
=9A=E8=BF=87 SSH =E5=8D=8F=E8=AE=AE=E8=AE=A4=E8=AF=81 coding.net =E6=9C=8D=
=E5=8A=A1=EF=BC=8C=E8=BF=99=E6=98=AF=E4=B8=80=E4=B8=AA=E4=B8=AA=E4=BA=BA=E5=
=85=AC=E9=92=A5.
> =E5=85=AC=E9=92=A5=E6=8C=87=E7=BA=B9=EF=BC=9Ae9:6c:54:c8:72:42:36:ac:b2:2=
9:7e:ad:b1:a5:09:42
> debug1: client_input_channel_req: channel 0 rtype exit-status reply 0
> debug1: channel 0: free: client-session, nchannels 1
> Transferred: sent 2624, received 1924 bytes, in 1.5 seconds
> Bytes per second: sent 1791.8, received 1313.8
> debug1: Exit status 0
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.33.1.windows.1
> cpu: x86_64
> built from commit: 05d80adb775077d673fab685009ede4a1003ed92
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 19044
> compiler info: gnuc: 10.3
> libc info: no libc information available
> $SHELL (typically, interactive shell): <unset>
>
>
> [Enabled Hooks]
>
>
>
