Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796A0C4332D
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 07:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7C620753
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 07:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ggaVw7u6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgCVHbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 03:31:08 -0400
Received: from mout.web.de ([212.227.15.14]:48281 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgCVHbI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 03:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1584862265;
        bh=RQ7sY8qsCIKigmbcIsFM6cL83ESrVSS+FfbJFmiO5GI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ggaVw7u64Jz0861cdr0M2OdciprO3B8le38l9hF3Az1vXDB3WgPS/xgktoZLjtUqe
         RDKBoanTs7rINWWI/W3DxM+xlZ5Pm3krJzj6m+fpUb7JihT0w6KpJ1G34p+BFl9saF
         oXI3v2AfwyoShxefcahcyE1GjPJLTMmBR6CJSo1Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LcDJt-1jf70O39q1-00jZYV; Sun, 22
 Mar 2020 08:31:05 +0100
Date:   Sun, 22 Mar 2020 08:31:05 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?iso-8859-1?Q?Andr=E1s?= Kucsma <andras.kucsma@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: GIT_ASKPASS absolute path detection bug on Windows
Message-ID: <20200322073105.zh2tqycu2fgydf3e@tb-raspi4>
References: <CANPdQv+tCnfy_csM8EwuqAYBtgkJ3RhRvo+ALbzO=BcZA7qJtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANPdQv+tCnfy_csM8EwuqAYBtgkJ3RhRvo+ALbzO=BcZA7qJtg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:VjBcQuouj/VtueKCxoSLZpcQhEHSw2UK/PmgBXIjsXOVfwzoozF
 7iQppLbxIO1Paml7uLhQb+LuKP1x2ZAlfgDugQprtUePYei8qealTrl+W2qcLhi1kNcqMHU
 vk9NR9kYhvtmICCANQYJUhS1L8Zkr59lKYGpg5rNBO3irGvkrqxEgmqQ4LJzSPpUtyrFXl6
 C/QhzJFvWOl982Yx4kCcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GYfzAJrYyS0=:K0RGA2K23VS7zeeQZ3yHyX
 bMpQakVSRdC/JhNGnh0U3V0D2Y37crIT7Rjn/pjFUJzQRHtPvT3SRH8AaPHGkmmLiZvkd0tlm
 WqraMqP/SUgbcyanvKdhWNUsipSVmBOkl/SBXGiCca9uJzcYEJKn0vwgQorEkKTuKwkGJnz7V
 SoDSR7OmCbsoli1RUZy9JeQi2FqZUnmET351YApmz0wCUhIdNJOtbQG/+rmxOkjbfS67GNoyx
 h7EGHFkz5FgDq+hLlXjuJgZY/c+ZZMexaMKNfWKf2MTHr/SDqhNXu6WLTRuJ4TkC8G6HGm8yo
 YbzrdwWlxkuDFKkDmdhdiO4wdjMx+cl0n7fb/ykowLn3gmwq3+Xwz/6n7vBY4FhS/wfuiYQ1G
 enWxtu3OXJlSRwA/82ttCiKa02lZ4PZ2blyjwWwSO3H58jDmH85TJEtt1bWyyZkbQJEuhsAPb
 QJud8jB5kQcmQ3rwuF4KixQqfO3ZHC89POmHiRE0INhfSAprjVHKT5Uvkg9S2ohgc5T7JzU6Z
 rUqZKGUeBpMyB7zL0o1vSaNdspQHeNfrpNutG2JfphPe0IADXtRWTq/a+c/GwoeMmPpAhSTmU
 9xWrHnniNiV7xWoBhU4ZGnemKLVOQDi6K1tZ3fhDTMrrlLZHU40B4vgG9YcYhSkx0E06L/xCf
 uVZekb/ABBAF0Ka0vdPq0otbNy3XaslSpT7XwdJaPezoDtnYUgj/rszAPV1E9q91Ok6+vlaaT
 tPfkGKgUQbeGYyyzcsn72j/Haqh94EWSL/UDww0cPDaGFl2GWo9x3AePx/kUpevvpFYO1T6sQ
 M/cPw4Bv4qEVWNYmDysNUf6HP5DcS/cnckI/ClzNdkfXezX64srU2SG+3wvxEeEMpK8UC07oI
 bSFoCwL3KrkUfAzwEaOz+58zP6SPCWrccLgTwPLVDaOlCY0HWb3CPFh9062yHxc4PlO/vM8X6
 xtjppds8zeWDGRbCIbE0gH2bT5HLwGl1LPcU3pWGMsDrk4nFfxzfQS53GI/DXqZgycxPT3MbU
 g8IpxTmPEwtTNOdzePdKC+uZY80foHsGXDdpSFWB26vYmqemhE3sXU0jKnyntPr2G8ICEHKVp
 6Fn3rZmMMcyZsEGxcnLSHW33yjvoWcWquDMvqnxDg2kR7msckIydtndsv55bglLwAHgExXOEe
 UTyYprBfwj66WAXnkikajCbQKuVygVktn+CXeW32fG6ENqiXvcaJ0nTqXChKmGDJRCzukXBsx
 PHmtPOHXkLFE6+Yaw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 21, 2020 at 12:42:50PM +0100, Andr=E1s Kucsma wrote:
> Hi All,
>
> I believe to have found an issue regarding properly executing the
> GIT_ASKPASS binary. I'm using Windows Server 2019, with git 2.21.0
> installed using cygwin.
>
> ## To reproduce:
>
> Assume you have the askpass binary at C:\askpass.bat. In CMD the
> following commands reproduce the issue:
>
> C:\> set GIT_ASKPASS=3DC:\askpass.bat
> C:\> git clone https://<private_repository>.git
> Cloning into '<private_repository>'...
> error: cannot run C:\askpass.bat: No such file or directory
> [... proceeds to interactively ask for username and password ...]
>
> On the other hand, if we change the GIT_ASKPASS environment variable
> slightly, so that there is a forward slash (/) instead of a backslash
> (\), things work as expected:
>
> C:\> set GIT_ASKPASS=3DC:/askpass.bat
> C:\> git clone https://<private_repository>.git
> Cloning into '<private_repository>'...
> [... success ...]
>
> ## Some context:
>
> The source of the problem, is that if git doesn't find a forward slash
> anywhere in the path, it assumes it is not a real path and has to look
> for the binary using the PATH environment variable. See in
> prepare_cmd():
> https://github.com/git/git/blob/98cedd0233e/run-command.c#L429-L439
>
> You can see that the "cannot run" error message is printed here, just
> after prepare_cmd() returned -1:
> https://github.com/git/git/blob/98cedd0233e/run-command.c#L749-L753
>
> I believe this was introduced in late 2018 around git v2.19.2,
> although I did not actually bisect the issue:
> https://github.com/git/git/commit/321fd823897#diff-7577a5178f8cdc0f719e5=
80577889f04R401-R415
>
>
> I hope I'm sharing this bug at the right forum. Please direct me to
> the proper place if not.

Yes, you came to the rigth place.
Thanks for the report and the detailed analysis.

A quick fix, and a begin of a patch, could be to use
has_dos_drive_prefix() which will look for C: and will therefore even work
with C:\

	/*
	 * If there are no '/' characters in the command then perform a path
	 * lookup and use the resolved path as the command to exec.  If there
	 * are '/' characters, we have exec attempt to invoke the command
	 * directly.
	 */
	if ((!strchr(out->argv[1], '/')) ||
	    (has_dos_drive_prefix(out->argv[1]))) {
		char *program =3D locate_in_PATH(out->argv[1]);
[]

If you want to play around with the code a little bit, and send us a "git =
diff",
we can convert that into a patch.

Wellcome to the Git community.

>
> Thank you,
> Andras
