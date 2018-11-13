Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E10AD1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 19:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbeKNF16 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 00:27:58 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33298 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNF16 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 00:27:58 -0500
Received: by mail-ed1-f66.google.com with SMTP id r27so8574636eda.0
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 11:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BWtfBB/6yfecikpNTvuiY381mouMbUsmznBzUQJVrLQ=;
        b=WLCdx8skSq+4GgzbS2W0omJk8DzAhce4jAcpuDiTB0BRPSoLYraCDYxfdURz7BrHyT
         RYMK9OR6ehhlKWoSwBl8PNFXmFYd15lO1r4if3SdB6lCHu1as/VcxyBO8urJEep1pOkH
         L6SPy0RapFav/d4WnDmEWQmSqP+edEHS5Y0xfg9eLBEmmAa+cx7plNsY+QxMcmb/IUxn
         f3l95ghYUxAbfGIfOOtMxVR7ZjrP871AWCVw0k5PjQNdKTKCUPe0dBBeriZLcrj5XALO
         g5x+nrBLtJdsHulehH+rUC7SMLR/26QvOaGmbjP5zNRXcQb2SdVGx08kmAWgbx2wuwGs
         0sQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BWtfBB/6yfecikpNTvuiY381mouMbUsmznBzUQJVrLQ=;
        b=IVRXL2pednUmvWyazynuVDF8WE+Qo6up5Rw8UerFxzYTbG76Jwt+RqW5xvNfdmOR1E
         6cA/IJ7Bg/YzStGVrQUHNR5QNN2DbzRUDAldZrg9qJAe+q2j1ovVDsBMhDSc23TPoM8P
         hS34APF4NADizuMtZNShfUASm69f9jwDgjpvjZiajVOim2/JJjKCiMBCWfksZcApJbjJ
         D/P2Jz7w6a2q9xzO29OryrB+obTzZgm13Hgs5foa7MiFcvtzHttQlfpQJy8H9WpdMEUz
         PGm30YNFi7fpmuYzJr8+KflV2iR/hBew97a2uKter8sonKiuDFWIZsolV6qqxRR6K0gq
         xAbw==
X-Gm-Message-State: AGRZ1gKuBZcQNPskjxTA9d1DuSq3vytWpEd5bIPMTuH1EEBqjG0LSVNR
        5H0SqY+q0tVyrK/uzra6ISJRijcRdQBDVGv4ChhGhQ==
X-Google-Smtp-Source: AJdET5dqT26FPa3mtGYq1D2PCrq8zB/I1lrCL3lr6//nPAE9rwJ8UWsoqFy/ISzq9TrsXBjp5YW2jbkfsdm2/B6Myas=
X-Received: by 2002:a17:906:b7d1:: with SMTP id fy17-v6mr13368359ejb.70.1542137304922;
 Tue, 13 Nov 2018 11:28:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.79.git.gitgitgadget@gmail.com> <6276372ad3dc6fa4b9b352abb2b0192a6d010528.1542121775.git.gitgitgadget@gmail.com>
In-Reply-To: <6276372ad3dc6fa4b9b352abb2b0192a6d010528.1542121775.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Nov 2018 11:28:13 -0800
Message-ID: <CAGZ79kYR_mQmtOuW7SEZ92K_o0f_C2enJJ1Yt=V3tyvi-A53+A@mail.gmail.com>
Subject: Re: [PATCH 1/1] bundle: refuse to create empty bundle
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        gael.lhez@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 13, 2018 at 7:09 AM Ga=C3=ABl Lhez via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: =3D?UTF-8?q?Ga=3DC3=3DABl=3D20Lhez?=3D <gael.lhez@gmail.com>
>
> When an user tries to create an empty bundle via `git bundle create
> <bundle> <revlist>` where `<revlist>` resolves to an empty list (for
> example, like `master..master`), the command fails and warns the user
> about how it does not want to create empty bundle.
>
> However, the `.lock` file was still open and on Windows that means
> that it could not be deleted properly. This patch fixes that issue.
>
> This closes https://github.com/git-for-windows/git/issues/790
>
> Signed-off-by: Ga=C3=ABl Lhez <gael.lhez@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

The code and the commit message make sense, but by reading the subject line

I would have expected a different commit. Maybe
    "bundle: cleanup lock files on error"
