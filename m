Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DEFC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 12:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ED01610E5
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 12:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240636AbhHYM2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 08:28:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:52611 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240418AbhHYM2P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 08:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629894448;
        bh=+mPHxd9l823Ley0TWLnsPSkJAXKu8BI9OiS7xERSIf0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=g5u1eNCDdhcZOT0w1wZoRHYk7aQ4mUYwQ4G+Uv24102LJwoZhBPYZZ0TNk10Nd22b
         OMAjtGUfUaQBnz8nyiOuLrKDNe91DBIzQS+9J5fxAzJX37FcteT6wxf/HEGTzP8yXV
         VFD/C5aiu21ebIXww9zSD3jI5zjKyZa73vS6H8lY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([89.1.214.7]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNt0M-1mh83L35p2-00OKKj; Wed, 25
 Aug 2021 14:27:27 +0200
Date:   Wed, 25 Aug 2021 14:27:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Gregory Anders <greg@gpanders.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t9001: PATH must not use Windows-style paths
In-Reply-To: <4f5c5633-f5a2-3c99-329e-3057b8d447d2@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.2108251427020.55@tvgsbejvaqbjf.bet>
References: <4f5c5633-f5a2-3c99-329e-3057b8d447d2@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wTdGWPd1FNzL0eWggbkBjpSAQ+faaLs2ctmtSS0XyHYkbIdIq0R
 7xqGYv/99JP4FqG8g/T7wizBgQBCVKMZ9cS3NCRLwOw23www2Hck/P4R2auhNTGsxe+0yr3
 ZgbOKkFSChiGNZPcPhxmrRxDWnZ++Equ9XBGs2V+T2x4PVLdUMuURDGcTQ7EDYPF6e5T5gQ
 Z+Nb2wvQcBAi+1cNRa6kQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/H1eAhYm7CQ=:9p1PKa59I2xVjHCohv5O+n
 d3XxyOCGjk5cjSMFfWj5r/QT2n73GZjZSjWUT7PrfVEpD79RPgdxItyqgC3RYWjmDU7sYqJXB
 kOXT3TtdDeq+esK08ZanmzbX8xE5wWUEbcemVbbW8Ckh5e4tnEI8E2cDMvnq7Xpxzfq7Aux24
 ok4MiiLhlDqwT/pSnSBqnwyKMucG4uqMKn5Z4HnlqNMM1woITON7MOLr5tHcbreulqrBfsrTN
 kbh10vdKy7Pbeg3dskWoeaqJ26wKmDolzgDYp2JKDSK87ps2deuvw/yA66b4slu4QmyCEbs0j
 1kUCeW1l3RpcQMKaBzOgK0LrajzvBzTvqPJeiJAOVTPhauPYCGnPww0x+bkc5TyrpCQz2P1Ue
 vAd3mdRb/4fWTSq7rAzCunsnc+UQOVg3KRcDj95oNfpDsYSfA0bKEtg4BmK6kA5oT5aaQ5vEq
 NlSd3h5qQPfaq59gbKxW/4CTRT9a2fE9+7MTIcoKHWSTi/+eQ4aBpRSsTDZNehjmhX+yvqZr2
 L5L/NVDibDonT0eKDlyE7j2beqYtNmXQkYzQ8KhVnhWaXK8wSNFBxlPcT6hBBeaojBYleX77F
 /h3U++PGMP0yvmSOAMKwDqXsSH1UE3A7tS4gchJRerTEyKQg1sSEbJCBarSPSQKOVM7rlFZU8
 5/n45FgPJqsY2cCIl1vXujYK4WTK1tFWEP/M/3theOq7V5eLkDyVUI8+tM89FsxXjXD716oLI
 CfLAZAsfAD+5f3Si5GCaryJDQW3uMIIYiFFBmhHnctzYp3mc8H3hYZN2MwWQazl3zxFCsvWS1
 DOVJO8VwD8KUZUhMOjzCUQ3+cmZQ/YSHeKvdt0Duw+WRps+apR4jApOxaL6Dz+4Al4fVqGJ5w
 10He4SFU2FX9YY4m82yhelE7OXZ0U0MYCDkIny63d/IY08ByNPaW93FeYY6gSHsOCMe1VU9bG
 J4N4aE2HhPjKRMG+EXn+K3+958sE8SoUDDi0RE5UDN6H7b8J2Gn7kY31XEmsTl9ZhEX2lXbn9
 v1EnBnc7Q0oULv4i/wIncBWjxYDIwl+QOvbaYNOpB/517KiwukqXQwn7EydlVc2+dvdLAilUs
 zbAZUkjzVGedYpHLzg1LhEWMKxmgd74MrG+M6YQWGrLhkYzUR4Ufe+HKQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Tue, 24 Aug 2021, Johannes Sixt wrote:

> On Windows, $(pwd) returns a drive-letter style path C:/foo, while $PWD
> contains a POSIX style /c/foo path. When we want to interpolate the
> current directory in the PATH variable, we must not use the C:/foo style=
,
> because the meaning of the colon is ambiguous. Use the POSIX style.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thank you,
Dscho

> ---
>  This belongs on top of branch ga/send-email-sendmail-cmd.
>
>  t/t9001-send-email.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 57fc10e7f8..595cbad372 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -2198,7 +2198,7 @@ test_expect_success $PREREQ 'leading and trailing =
whitespaces are removed' '
>
>  test_expect_success $PREREQ 'test using command name with --sendmail-cm=
d' '
>  	clean_fake_sendmail &&
> -	PATH=3D"$(pwd):$PATH" \
> +	PATH=3D"$PWD:$PATH" \
>  	git send-email \
>  		--from=3D"Example <nobody@example.com>" \
>  		--to=3Dnobody@example.com \
> --
> 2.33.0.129.g739793498e
>
>
