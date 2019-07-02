Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C406F1F461
	for <e@80x24.org>; Tue,  2 Jul 2019 12:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfGBMGe (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 08:06:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:52933 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbfGBMGd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 08:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562069180;
        bh=2emDEVaiwwoa+SWSAwbk0ZK6cLokUkb9S7xAOoRe9ps=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bYiSxm6tf8ynJ+i8wIsaOcT3EkE+Ghku8dHLm+CU1rx/bi2V5m8Bi4loPwpLBuOFn
         NdSHyO4mCo8M4UtRC4lKv+VyBoqmITkh5iCQYMWuyAjDHnomyYBm98ir8vigHJpfCY
         AEvUP/cdp3Kt/ij4cwC0knC0ibP6x6z6W9j6bs1A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lhf3N-1iLnHp1QUD-00mr2H; Tue, 02
 Jul 2019 14:06:20 +0200
Date:   Tue, 2 Jul 2019 14:06:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, peff@peff.net, j6t@kdbg.org,
        sunshine@sunshineco.com, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] t5319: use 'test-tool path-utils' instead of 'ls
 -l'
In-Reply-To: <fec75453eb3e4c286f84c538c142c3da02f75826.1561986978.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907021202000.48@tvgsbejvaqbjf.bet>
References: <pull.280.git.gitgitgadget@gmail.com> <fec75453eb3e4c286f84c538c142c3da02f75826.1561986978.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KfoXclDd4YCghgFmgfZWbIy9LfwTEHVjV45scdu4M+gQoI61myy
 l7AsZRZtypvnGBmQIlwdf8QCLpMyYh/ooaJglWkt3SQ0DLzkz64Kk3+1M2R89dnuY3qJwJ6
 Ea/+I5we+FN7dbdkVGty0YnVpbD6vM8zZGoYPNOkdBWRla57skN9j31cMaDEGhgEb0Ojlg7
 xku+1iRitXmgvKkmfwC+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9iy3E/z4DeE=:gHl82v4i68kPifcZa83ecy
 oM1QXwpNdTioy0kOX+lwj1+SxsDSjRWMgKICuBHZpI27r9XOWw/VgdO6bzqXIhPq+V2b9Tiun
 v5IfUqiUB9aGT86uCXDveGryi5E1ZXKVw7ik6+ry1R9SpEA9LwJ5Lsa4Ot2+TJu+vQUVWuKqv
 jjhfvJ+aco8L581Vw4cePLCI9Ogi3TOGp5V5lgTtlpEEnkIb3aDBNzwKlANQW4KuM1X1TQm/a
 1tynffj641jUQAVLIzUD329AT74WESx80XB2+lNv6eQXDhdDnxWwuzpq+cPATwiRwzOyBlDIj
 4BM68pa5uzd4+Aou9ULvs6bIHM4BE0aMktTnTWzOyKsTrpMxrdL0fKrb4vLNbi6G4geRZF4tl
 srjWNW76BrlSmKyuxKf7Zdp99gRg/dNnNwlnG7Du1+7GibJyrNyns5PfpwoFwzCYMUpMdMFt4
 zxcJYtmbwFBOfU7AKWCaACaeyFnycHpHU88hDc/K8AHuEyRNbcKctVJIpTE8teBpGOTpXB11r
 2I/vSCn0BzlHt6bNS0s9w+iFo9875NOifwtuYPSabi12rLA0X0/9NmwA61vKDoJekSAbv7ugR
 rWJsqAM8l31HWLWr6IwIEH/aOxvkCMXexK4PS1NI4S8Nls6vMQdfzdje7m9cRUFjfjwYw8Ho6
 1nt35UqORO2UbkdEdPxZZaRE576o4UOkSFpAcHnQkF1xEWzmuenY/jR/wDIocuIYGFoNBvWHn
 TXUWA/FdRm/MBIhZ7gh27h209tNj4Vzc7zyDhgTJRyYUYJ1QXhRuPCoJ40NjLhC2gSX2XQqMt
 U9LFyPP+UtDLVqr/Id6XEEp6OPRd8oe5DeyrxdVir0C/eRn08GW3PUFNeLMwewZjOs+b5BHXn
 /aD8IVGkq9YKqFRSwB0tG/OGwFlNqvBt+0Auv4KWWVWBdAaEtmyyOAcrwrBt+V0NVRrd3LZgE
 QigEARscRGIEbc5nWic50qr1WB7j9eJM7PGD5YRVZ5xOsJpGxqYezjLdv3bIys2AHp+WBzrK/
 p9HdpyzntK5gWAlDCl6sjrH2PGLx5AwQXgNy0vyPZT5mAWFNZ4TOBNId/l4RaHdXjmDrYNrIv
 G6mB3g4pWQPhbDncXRHiaJCaX0sbMxzp38a
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Mon, 1 Jul 2019, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Using 'ls -l' and parsing the columns to find file sizes is
> problematic when the platform could report the owner as a name
> with spaces. Instead, use the 'test-tool path-utils file-size'
> command to list only the sizes.

Thank you!

> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 79bfaeafa9..c72ca04399 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -443,7 +443,7 @@ test_expect_success 'repack with minimum size does n=
ot alter existing packs' '
>  		touch -m -t 201901010002 .git/objects/pack/pack-B* &&
>  		touch -m -t 201901010003 .git/objects/pack/pack-A* &&
>  		ls .git/objects/pack >expect &&
> -		MINSIZE=3D$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort=
 -n | head -n 1) &&
> +		MINSIZE=3D$(test-tool path-utils file-size .git/objects/pack/*pack | =
sort -n | head -n 1) &&

You know, we could also add a `--show-minimum` option...

> @@ -455,7 +455,7 @@ test_expect_success 'repack creates a new pack' '
>  		cd dup &&
>  		ls .git/objects/pack/*idx >idx-list &&
>  		test_line_count =3D 5 idx-list &&
> -		THIRD_SMALLEST_SIZE=3D$(ls -l .git/objects/pack/*pack | awk "{print \=
$5;}" | sort -n | head -n 3 | tail -n 1) &&
> +		THIRD_SMALLEST_SIZE=3D$(test-tool path-utils file-size .git/objects/p=
ack/*pack | sort -n | head -n 3 | tail -n 1) &&

I guess the `--show-minimum` option is no longer such a smart idea ;-)

Patch looks good, thanks for working on this,
Dscho

>  		BATCH_SIZE=3D$(($THIRD_SMALLEST_SIZE + 1)) &&
>  		git multi-pack-index repack --batch-size=3D$BATCH_SIZE &&
>  		ls .git/objects/pack/*idx >idx-list &&
> --
> gitgitgadget
>
