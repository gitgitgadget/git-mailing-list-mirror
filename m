Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD5EC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241843AbiEYKWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiEYKWO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:22:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E47A8A056
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653474108;
        bh=PTYyslefO3PoXwdCfTcc7RiRsBOFHHOYOqaITi/lC5c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NQiSYPY5CEBN/tCM23gHmp+XUUvNif7AWV8e6GuuVdrORX4hAkAkrdGNvP3A1GjJh
         RDoHFDRvv1ZeUvgPHN0fxg53NWmlg8+7GECDrpLPg2YHMUPMP0z97QY5xTp1CoKJWY
         IVW/5HrVFU4DxMCM15Xz24ezKqwSCGLPoP/0NNyc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwwZX-1neMad2gLj-00yUWx; Wed, 25
 May 2022 12:21:48 +0200
Date:   Wed, 25 May 2022 12:21:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v7 26/30] t/helper/hexdump: add helper to print hexdump
 of stdin
In-Reply-To: <xmqqbkvmhfoc.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205251220260.352@tvgsbejvaqbjf.bet>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com> <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com> <6f2e935f148e826609153378751c04807858e76c.1653336765.git.gitgitgadget@gmail.com> <xmqqk0acosks.fsf@gitster.g> <nycvar.QRO.7.76.6.2205241415040.352@tvgsbejvaqbjf.bet>
 <xmqqbkvmhfoc.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IwQhka53ztTnaWoL6BgFuhe+w1k2ienEHkFE3ASfj46aemxlp9x
 HnVBjkv3d9sHN1V3AkHN01kkpXFd5ZynlImkNCdkida5wmimdThhP06WFUOhmKOefyPF4vk
 qrPPWVZ+XsFVIi4ij66U+a9ynokuAvqVV9HMrC7f56GozS3aV+Pfk3sLiFTvMAa4vh7Aa9T
 K8Nxk/hi9xYVvvPaU3gFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w09Fl4b4gbo=:0JqJDjbeQtvz2ncdClpCmZ
 emb2GgPqZvW3hZ1yXaZQ6qAVI75jBpuXuHyfpzIM+1/G+mVS15493fK2U2grY5V+jdz2YnTPc
 vsX1wmCYZ/R/rAnEdafL2pk3aJfzQHUvRPbR1LzMFUTCJqjCIDRcy6MFtmyBTZCxqrr+46tK3
 1qifyI6eLSgEOZHjf9ZIP7dU36NhrVvI1mW80aFTgmF5rS+WrhWf2GfLZ8jzSYB5iLtxzDfYr
 DznhLJOgP+HuQ2LEFHFuxKb3NXGjepGg7HLxR5n0ZhqJOWK+T/IW7JejhX0+A0hBeOnQlC03X
 qpeEcnZSItw0ZqLHhIxATh17bCeNnyeVKvaHPYXA4oLugwqT2J3cr9EsuX+CDa5YA8aWSAnZs
 Lwbps5F2/iVMK+sLDv+aZtLp89a9NOhqlS4x61PkHHoGplsYqxih2tzCNwoQdKlAaUlhbWMcS
 VE9O21xMnTZV2vkFStuGGAA9e1ae0avHyyfg1biUbpRwt0xtHLo4MNd8eYN8CkrVa4eJsdXrS
 10DpQWokNDLlPzY3gRMqjn+UO1jXUX7ERNrzlfeZctOCFQE2U5P2QOlcC+TmvlqPFoXP0BSQI
 cDvcH3F8YVjVxaIaWQ5os2e4pIy+cy/gMKl6MasbnAQcPUfWzyyHLS4xkGXi6NQm164GP34Q5
 BR1Hcwb11nFKjrIb9P6ZDgKR8uJtChmcYl/adA1OGiH1KlVrK/QB5t59lWERFpXiTLHOIS5SO
 C+86E9yFkWTfjtrHCu8mvN2Fgb48NtqYTeF6/Kh1NpBTKCLo/Iogq9saPPxKpsPP3RtsVx5DF
 lKO7zjl1OD3RHG5TnBkojlx+u3qnuJEZ6F2+Ss4j58yf6ojrQ6trl4RUzq5VdHt2572UXrZ1w
 ermBytt1mLGXjr6hSTXT7TdpvFEvAIFD/E5Uh3g+tesuGNtLaL8bqernYfJWjlS7cEuOntmDX
 GzhNhXKL3fQXxdijLYdAiF3NJkoI8nXeYASDUqG34T6Ab1vs06TGvYEVxVM0N58j+4SGzlkjy
 SWSdQD+ERusoUCLVywKsuCYBHTNCmT90dXPT0/jtMvTSz9UADb0/PmX7vMOMFq3l5r6FPPCeF
 CsWQF9FHViSEyWOb5DGUkW3QSjq0mRrG1Qh9dHYOTzKWf8qGY5LLlGJKA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 24 May 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Do you know of any `grep` implementation that has problems with text
> > missing the usual trailing newlines?
>
> I recall that we had reports on BSD variants, but please do not
> quote me on that.  Perhaps all the BSD variants are good now, or
> perhaps some aren't.

I did not recall any such reports, but take your word for it.

> In any case, I do not take the "if it works on Windows and Linux, we
> do not care about the rest of the world" world view,

Just in case it was unclear to you: we're on the same page here.

> so finding the answer to that question unfortunately does not give much
> input to the issue in either way.
>
> And in this particular case, it is much simpler to mak sure that the
> file does not end in an incomplete line than us exchanging e-mails
> back and forth, so that would be the most economical solution I
> would prefer.

Indeed, the trailing newline is easily added and fixes a known issue, so
I'm all for it.

Ciao,
Dscho
