Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA188C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 11:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiHVLQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 07:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiHVLQj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 07:16:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46A732BBB
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 04:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661166991;
        bh=0aYUiZREbxE06rzZMSEPjrl4g6YdEtbbEp3nXY4x6Bo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Whg78MbtFwh9IzCXLx2rRCCLJ8tPG+0SR3a+FTYlY4AUZG/XGfuJcUeaQzqoxOjYi
         R2TaNfnqceY/LaaHb0XLnKg2YiNFynJHsrA3Md7dQLLS9YbVUhcAK/lVXJJcRztDr7
         8sjyTbzgzRWzSNbzQ41Bt/b8elOUrih4A06V63aA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.137.196] ([89.1.212.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiJZE-1p4Nz704hS-00fRVO; Mon, 22
 Aug 2022 13:16:31 +0200
Date:   Mon, 22 Aug 2022 13:16:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: en/ort-unused-code-removal, was Re: What's cooking in git.git (Aug
 2022, #07; Fri, 19)
In-Reply-To: <xmqqbksfirfm.fsf@gitster.g>
Message-ID: <s23s44s7-4ps0-nn7q-2s43-759o665pn3qp@tzk.qr>
References: <xmqqbksfirfm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KxJjoWZxfxNKIBVxO+qDPRJheX01T0Dy6RwWTBkNRt0pOFxI5lQ
 iWNT8PxcSi0GMkqrISk+RMqW/rHoyqQA6EhyHT/ZhwnxdGASdQ3+vJlq6OERwR70zPe7TG4
 LOuFZe2Ju2B6emsJT5Q+/ykFdAu5inOwB96pOljfvcOqGmdd2U/uxfuHxip6RCRAAADX/hN
 +xJNS4Hi0+rorzOmTwTPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/GlPecRnO/k=:WxjZT5JH8cVPQ8z7ut8SrH
 I0z5j06CFPeRXrShrQvdw4P5FM1TRLCN3vUBULW9xrTO5cbZ1MaJ2hDD7A2/HQpoDMbiBLwD1
 sujIeFK4V94F2Tuy5wayyh2FMvlZM/Gj4J5R1kIiiO9hLDfSAYbEODro0BWFf7kpqvpZuX2ik
 IuwLRzqtNY8ZmoZ0LIZwMexcuZX3mHjdMwSJA4SLTzcM+JUNFssN1T58yiInvpcx4mHBP2+De
 82YU0fNlwjPAbxHGapfBE3JjVzUT4BXySo6SRXCCcHSsol0I0JAxhZ4Hg8/UwMl42+10e8hGl
 MHSANCNqgj2OBPEKph+rHr6XwU1EpBZm/b/DPHZDh9MKTnhVdCwtDXOOk7+CEXzMBJqDC4Rlg
 7bc31UgRb4exzF1XsGbr4ZtycIy6kGiJQhq/3rasWW1K1J0irY7dAvRSc0ch/JAHmZYkfZAnR
 ctvUgLYZ/jZAxMsBt3KMhwvK3EBhGMqPlLqT9JopIBF7e6c9SLtX4R0g0Kuh5VghA3fQfv2Gh
 eQabeTxMnAjPs97OQ8nR4/2+1COXy7EYlWL0VLI8eV4W8GhFI1W5bVyv4WTOz8ps9toagdOZq
 7VkwVLRiwGOQyShChvrPTjXBgjmA0kTKJlRTea4q9K4pz+Vb2fZTrCC5Ne2FRy4mEtVBH6Kcx
 pXY5lC98VOkc5o9IIWbieIlkxPw0x9TM85ud7AoObs6wVUNMnOviAdHjupu6xkiDtSbq2rAL4
 lv0SnRlhJ4XdxVsAQ4a++Rgy4s36GG1rjC1BTmCuil/+QITetP7aL6oJLF/ZWm0dt2dBt+s5H
 IonB9C8VOUaPRywVrz+WP10B8G1G16W7ZeuB7wghReHeSN4PAFQNe86njXxj85Bjsx8MYAi+e
 07g6zkC04IZQvO2PUwLFpKkYb3RNVQpjz8dbwcWYwzSvozYUVPMWnhLzBQkAzDOBu8cVYt+vO
 9BU4xqOWj5eb2uT8y7wYe+qzlYUhahZrCzqN1IVTJ3El6Vhd792nSFVyFx2mskP9H8GTH1dq3
 TEN/wqJMiHSfxK99TZiaBOpV4PXHJNMZ8yafdbYM82F/YdFb8bC9ysJIjqudDykT8b8XZnTyt
 Ox4XJI4baOxyqHpHgd4AeObdlb7vNImyNezLzNRLYMgtJkiLl0lHc+VYg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 19 Aug 2022, Junio C Hamano wrote:

> * en/ort-unused-code-removal (2022-08-19) 1 commit
>  - merge-ort: remove code obsoleted by other changes
>
>  Code clean-up.
>
>  Will merge to 'next'?

Yes.

>  source: <pull.1302.git.git.1660884355643.gitgitgadget@gmail.com>

Ciao,
Dscho
