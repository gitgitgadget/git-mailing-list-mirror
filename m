Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50B4C352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 21:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91B1218AC
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 21:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ESlvyjx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgBMVS4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 16:18:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61672 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgBMVS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 16:18:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BB5454FD6;
        Thu, 13 Feb 2020 16:18:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=A/K5UGOcNmtL
        AZN5Ud7VmTO2Wj0=; b=ESlvyjx6oDq9k/l6NuDwqf0H9qQRDSGZI/VtOqvYmU2a
        uM4lupHvmDi/czZdr1LMDLWQjeAp3yTjSXbYVRaibttmT5Vv+cIPGZgOx7TUEe3S
        sdX8eFl/1U6w0qkIFcWGW4ZWTUDxN1uOXYVgbb4LGrDxcaC5HNcwFcgAtLZWF2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Z6T2av
        DOOemUcRBXrvvlZIZjra/5bVEuSzj6V7r4ORNkzDLvNgaRFMxlAhgCSSL4VWuoto
        MW0zPzNp1lP9c9JCRDhuF/gzWiWOFEPZhN3l6Bi3ZpB0JkJM0w8Hn7ODd+eHW3d4
        j4bThREViWiLL1GBHaSVWHR+WUNq/pSJ7uqT8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8365B54FD5;
        Thu, 13 Feb 2020 16:18:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E46C254FD4;
        Thu, 13 Feb 2020 16:18:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Yang Zhao <yang.zhao@skyboxlabs.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: yz/p4-py3, was Re: What's cooking in git.git (Feb 2020, #03; Wed, 12)
References: <xmqqo8u3tqly.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2002131401130.46@tvgsbejvaqbjf.bet>
        <xmqq7e0qtqsm.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 13 Feb 2020 13:18:52 -0800
In-Reply-To: <xmqq7e0qtqsm.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 13 Feb 2020 08:06:49 -0800")
Message-ID: <xmqqk14qqj7n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 700AA70C-4EA6-11EA-9B1D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> OK, any one of you wants to do the honors of wrapping up the
> proposed patch with a log message to replace the tip commit to allow
> us to move forward?


So the diff was taken from <20200123175645.GF6837@szeder.dev>; with
Szeder's SoB (and possibly wordsmithing the log message) let's tie
this loose end.

Thanks.

-- >8 --

From: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
Date: Thu, 23 Jan 2020 18:56:45 +0100
Subject: [PATCH] ci: use python3 in linux-gcc and osx-gcc and python2 els=
ewhere

Python2 reached end of life, and we have been preparing git-p4
(which is the sole in-tree user of Python) to work with Python3
but we haven't told our CI jobs to use Python3 anywhere yet.

Pick two jobs and use Python3 there, while leaving other jobs
to still stick to Python2 for now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/lib.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index a90d0dc0fd..c3a8cd2104 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -162,6 +162,9 @@ linux-clang|linux-gcc)
 	if [ "$jobname" =3D linux-gcc ]
 	then
 		export CC=3Dgcc-8
+		MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python3)"
+	else
+		MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python2)"
 	fi
=20
 	export GIT_TEST_HTTPD=3Dtrue
@@ -182,6 +185,9 @@ osx-clang|osx-gcc)
 	if [ "$jobname" =3D osx-gcc ]
 	then
 		export CC=3Dgcc-9
+		MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python3)"
+	else
+		MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python2)"
 	fi
=20
 	# t9810 occasionally fails on Travis CI OS X
--=20
2.25.0-462-gba6e6679b4

