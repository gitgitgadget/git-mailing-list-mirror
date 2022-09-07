Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF62ECAAD3
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 09:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiIGJFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 05:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiIGJFC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 05:05:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8E14A82E
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 02:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662541497;
        bh=6pMM2SBVGlxGGEtT0ZXuORtfiGUqcK8kQDbD+CXh2X0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W4yVJXMXvQaanujE/jQUHk+1GI9oJ+re5qeV5JIneFh4g9QafHbiByWq+N5F9Rk3z
         +fD3xNvQ1pJmqPhI/Zt3XoXMf/1oYuVU1ZK9OZSXgVWAFEkQIm45Cqlxz0Kr540Ns2
         MzridepH2zvGAIYFdtYOZS1zgL6aedIStUkxu8JE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzFr-1onezQ28Xp-00I0c5; Wed, 07
 Sep 2022 11:04:57 +0200
Date:   Wed, 7 Sep 2022 11:04:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] tests: replace mingw_test_cmp with a helper in
 C
In-Reply-To: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
Message-ID: <s8625r17-6p9q-n28o-31sr-o90ps09948rs@tzk.qr>
References: <pull.1309.git.1659106382128.gitgitgadget@gmail.com> <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:b6PbGqJqiXEApRMCt+N6hnIF1lJFl773fodLkVkycWVPbd5R53o
 /75YxaOgr5IPpKCPYB5MZ7H6RFOI7jGbY5KxX/vIiRm44WwEyX1l8cXvpg2rPY02YhVPGH0
 dO57tZWH3D4UolEzA3nww9E+eirVVTTu30zdlP4Y70Y5PIGEV1O6xb51GGo2s0yAwaulRE/
 MrN9lPKcBxXjG4w+QRbNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SX3EalC3k7s=:7o4ZKlC3I2uSLdCAvP/m9G
 SVPvgaSkw1PXYOw9f0eS6fq1TqV75kytt48OhWjkaVDq7SC/sTbEEEuonJp8fxrSCuusQTNb0
 3Mk3TK56xfmLb8BUsvOlShK4SyfbrghyIx+fl/6fPM03JNIhUKu+6B2HYYWNWZq1Bo8rQQTf9
 htyS8tjZnBZW05JzJ1pdY878NWXY1WrhPv9qMbGZc8M1CMJtpEWbZW93UwL/BARpaAb8FO8Lm
 NB1EVhmYPP2Zuh5Gg1YdrQXJQDIcPTdNC/udr8U1c6Gby3FHRG2Kz3qhEQjqRnLU6VBFC3Knu
 vvKF9z7V72rzBmJCs+xDIxkunX1K7JD3rZMFPrsMN9gV5hCXLmoo68fEp65RDGhi6Oo620tbd
 0Pr+QPGHEDjH5DBG1wRpSwpfr6tmdhKTE7ZtXA5vEHOJn3JIDx4LXySDEn3GGRs6yPGf9QOxr
 Gre5ax6iEHxPNcHsPfooZshySiMXx8PsM8QyjwvZ5HXuSIjJMj4ZiSVpWKw0iq3XmYJ5Fk5kd
 4K+lnuhCgpPzR1UNr+B4ZhtOBs/uEeICp5mCEJFvkuOqKD/rdyWMWMMvmQNR6l27oYcYD9Y4d
 DrQzftYauLkVynOPlDblnEIRMiEQEtc/O7IKydaAJn0l3RVY0Zc86vIl8gZQd041NYaicIjTV
 IHZQr03OeNm+hhn7/jyg0//9KLBUOuYfO9x7XrdCTzBSx3bLmiS9oCI1e7cLdFsJy3DJL5DC3
 LAurRxe6aKo3N2FkywsNktpsGQOHV1tPEoPlkmGabx5GjvWUAuZO0Bb1N/ZUbBrgTqZtACbkA
 kUh6M2S/5UyHyPtC1xxgb6ZDMtZeZ2OEotISTmH4+AU2ex57RqqIm+8FnDUxBxxMlEdzD78le
 drUiICRZVPGccKw7RZKrOQ6HHNvJCAyoS+rXnXH2hUARVjGhtq0i78spQYYapxQ/Jaipj/qr1
 k1X+HhzolKMZiyK0H/2gsZJMyT0rXqA3PEO/5mIHe7fQvCz8TADfIecx+NlXTuEPSSc7cxrlQ
 ufiYR+Dnm63bHBAq5pM6INRZqUytiE+x5nBzqb4bqGK6IRgvEye4wdUaNx5EIK5yKOw22Epc5
 wYTP/23RyzpDtRHJyljO1RgitOKQwhpNvTuERbi+KEwaX0MT+fMIpc0TXLh9Dgcxa0XSWvzsM
 kXuEkm3xMoH4jEJ/pAbYGpFCT+
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 6 Sep 2022, Johannes Schindelin via GitGitGadget wrote:

> Changes since v1:
>
>  * Fixed double "with" in the commit message.

Whoops, I totally forgot to mention these two things:


- Renamed the test helper to `text-cmp`.
- Made the `diff --no-index` call more robust by using a double-dash
  separator.

Ciao,
Dscho
