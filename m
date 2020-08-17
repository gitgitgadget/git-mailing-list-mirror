Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBA5C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 09:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA8DA2072D
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 09:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="akIiM6xC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHQJSw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:18:52 -0400
Received: from mout.gmx.net ([212.227.17.20]:40729 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgHQJSs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 05:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597655926;
        bh=FMDiAz6wEF5fPsEyToXSo5NYkziSRCN2Z6W84IfK0R0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=akIiM6xCfkkKvItizBg/GNduDNZrDBnt3XvNvNvQiPHAEcm4YfW1/+U4l/yLDPMHt
         vaYpT3EAPjrQwO7V9Elvh9fjLOXZJGtEyKugkxn/o+3SF8y0xhKB/wx6t5QmvLfqPc
         WRzSBxCTOntOby/d702u7iXUKqpbJG4dbKW7b840=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.215.233]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpJq-1kgNsK0Zf8-00Zwyx; Mon, 17
 Aug 2020 11:18:46 +0200
Date:   Mon, 17 Aug 2020 06:55:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] Optionally skip linking/copying the built-ins
In-Reply-To: <pull.411.git.1597655273.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2008170653440.56@tvgsbejvaqbjf.bet>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1494576974-1597640142=:56"
X-Provags-ID: V03:K1:ur+UKu2c8bYH7fLAUHkoIHO3YQN1RVnBbCa+1fFmyb3ZDskvzh+
 fbDhDdPUWRAtXn/k6D1SrpLvAgkvRGb5h4ZS3c6qHFBNV7jDHLg+0FsqkiHbBp0jMfb3P1/
 f3eOpCIWSN+t6JMsA31WA51evYXaatE/TJZOoL2K836fEdqYJ/kMg2sLJ6l6hC2jfrbgdSL
 7qPqFKnpQGpdWkZKnl8ZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yJTCdof7BBQ=:+8S9RF8Q1pnoeSbjmvMS9j
 HRCfbRZ2pu20PeiwZ7736nwI20KWRGji8AZeQSm+mMB6XxKYju0Eb2cJ+MMoG7qlmHZh6p1IZ
 aJnC7gbgQxQvVN1yUrmGABOEU2vUCBWB7zxotTpAPiNUrwpm//NsSblvqOL3EXhlpkKa0U/9f
 F9YrymrHycFdAJdLAWhyG2RnhtWXI9xHnyMhl2fFGbhleVfvjit/7ymcYkl56BXIvqUnxK+WH
 EPBZfHOXgknhhbL2htWzDW+uD6iDmEpc2QKqZIbxisOpLm4KvYtVeApVxPrBEpuzxbJUaRdVt
 u7Ml/eoVNO0DACV5keSZ0rZ9ncz3+qXh4+VxApCK+Pc97wfLuri59esNIABIhTfD7SZ1OHhZN
 GUQbuFmBi30wzNsM5JVEGZb6GAUnPDr5s9SI5B5BuXqIQY5os99QENNiCotsRmLQIDUvNTdDb
 B/UIW62eRZbcwktUeXHWgrMFoLeCkc1RTjWHK4ydD5DK/orkD1aoVwetIKl0xYYaOQU9/lHGF
 XD7xwPZ/UfSc1DfN8qZQ5i5tTfGyvFyGLXmYJypZXa1dz3JwF3MLUWORop4pZYXhYieKa+eO+
 ipQDWJuekrR+datHp4Pe/kz+XCzee6r+5olIq+iwoto7MJ/Fz4gwY7VC5zcvW3Xe/XiqqLmIx
 ROeRU9zmqlgfQZOhCEwPNJEhA7CbENU0skF6IMYqzWlcpjmU6B/s8GYyIGcSThkobWCsXvMh8
 XaiqB0RBfnjiAiR+Q/k369TcwNVk/C/AqwuA7frBh421xZxJ62TIba/59kZf9RHJVwYPMxUoS
 rZKs9F5QN7j+i/NtUuGs1vZGx1kUEXhaha4wQ5e74tdgnTpew8DGkXN7YZGglJqt/juSTHAeD
 0HXUynbO4sHDvGQS5g1qLBQ9LEJahvi9vcwNvGlWFIeZ3Gxzg4VkUlWFTDm3yiaChwrEruWDM
 wAmNbEzTuH9OuE0afTgkuUnkEVVWm556/SPUeUcpbz070lYrWEAQhjs315FTDlLlxFIVy0A3I
 zThtBioDduCTH52AhIkntSppakyMxmp6DzZHzp2ArBVAv66WosJGA2NT8OXto7g+BWLsPAHwH
 +TorJGmTgb1csxJIlqUvmXoDfi+xpgCmE5/5sNJRSbij8LSNQpGmaZI//FDBrbmrbQmj6ftHg
 fsUA4uePLPwnw/uWYXYZhmWlA3GO0hDTIJT/8SLGEbph+DjK5pB9Nk6sNVT04JRxI/QWSSxhw
 yrs15PTh9IJTakfsSOEodYjwxVYs2+PgpAmZSeQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1494576974-1597640142=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,


On Mon, 17 Aug 2020, Johannes Schindelin wrote:

> The dashed form of the built-ins is so pass=C3=A9.
>
> Incidentally, this also handles the .pdb issue in MSVC's install Makefil=
e
> target that Peff pointed out in the context of the "slimming down" patch
> series
> [https://lore.kernel.org/git/20200813145719.GA891370@coredump.intra.peff=
.net/]
> .
>
> This addresses https://github.com/gitgitgadget/git/issues/406

Please note that this GitGitGadget run did not work as intended. The
intention of https://github.com/gitgitgadget/gitgitgadget/pull/296 was to
use the actual author in the `From:` headers of the sent emails, with
GitGitGadget mentioned in the `Sender:` header, but apparently this did
not work, and I will be reverting that PR for the time being.

In short: please do not apply these patches as-are, unless adjusting the
author email to match my email address.

Thank you,
Dscho

>
> Johannes Schindelin (3):
>   msvc: copy the correct `.pdb` files in the Makefile target `install`
>   Optionally skip linking/copying the built-ins
>   ci: stop linking built-ins to the dashed versions
>
>  Makefile                  | 69 +++++++++++++++++++++------------------
>  ci/run-build-and-tests.sh |  2 +-
>  2 files changed, 39 insertions(+), 32 deletions(-)
>
>
> base-commit: b6a658bd00c9c29e07f833cabfc0ef12224e277a
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-411%2F=
dscho%2Foptionally-skip-dashed-built-ins-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-411/dscho=
/optionally-skip-dashed-built-ins-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/411
> --
> gitgitgadget
>
>

--8323328-1494576974-1597640142=:56--
