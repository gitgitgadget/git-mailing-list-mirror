Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBECC433DB
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 20:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1177964EB2
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 20:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhCNUAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 16:00:54 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:13048 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhCNUAi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 16:00:38 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 966281033;
        Sun, 14 Mar 2021 21:00:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        in-reply-to:references:message-id:date:date:subject:subject
        :mime-version:from:from:content-transfer-encoding:content-type
        :content-type:received:received:received; s=dkim20160331; t=
        1615752020; x=1617566421; bh=nHkj/Im2h9inQLw6pNWSZO5R2C7rCByUL3V
        cK6UhGeE=; b=WeIyow0+x4b+zdJ6TQzJhXog+yO6ofEuq1KG8RO7zG3glkOf+3D
        nFq8iPvYcr4IgtHHROxzdUYofPk4U8wdGnIBtdR93VFg5hd/uos8dXXml8jX9DFI
        RosQrM6vRZYS7EJam3HAK4siDAtJIWHUbF3S69BDRvv+TQtSjTAP3/b84v5wtJaM
        QYaR4Cpt4yjsP/jldYsSY0JJe88uTBEpQ9QJKlQ7n/JPcho1XBor2qlh1ZlzZyos
        gLza8oae6U9QyuLU2Y0UH1oJRWHyzpdreuBQ4KJeFMp9Ferhvi/YgWh7ECmPdZnJ
        wIjmXC5OFcPuiWGrU1HCQyizs3XWg1xYkGBmauBcmEvGdEBubSvo+bSFvFPjavtf
        va5aJxZCDYs/pXrhb4vh0XyZjltkIAM2OrArylS/2URbobQsp7t816hgpG1NXKw9
        oVOipQDMDTk7+T95PMPZnMMZb6WYJYEQ4u0wNasGyYoHjKOk1ZbxVw3k4tRCzBIr
        0Uzyslk7ZE723ocNVucMR6vuPGoex4Bau6f+0S/PM4nB2r63tiRs5XtZpYwDAAdp
        kiUj2by+GH/RAilFfHTMH6b75Iz64vXSzZCcAgq/qFmxZdhP1g7laFrdfjj7+Ca/
        n4unQBZtqv+x4CGTA2aPswGf9A1FZaHXgSJc5h/b5WFqKJ6VhKLDCjpA=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LrjPPjLNGq9a; Sun, 14 Mar 2021 21:00:20 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id F2BC449E;
        Sun, 14 Mar 2021 21:00:19 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 8F5E433B8;
        Sun, 14 Mar 2021 21:00:18 +0100 (CET)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andrzej Hunt <andrzej@ahunt.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 8/9] parse-options: don't leak alias help messages
Date:   Sun, 14 Mar 2021 21:00:15 +0100
Message-Id: <9429174D-660C-44B9-8EA7-C1B22ACBA45F@ahunt.org>
References: <4397c1fd80205d142fbd184c6d13fd07c4dbfa21.1615747662.git.gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <ajrhunt@google.com>
In-Reply-To: <4397c1fd80205d142fbd184c6d13fd07c4dbfa21.1615747662.git.gitgitgadget@gmail.com>
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 14 Mar 2021, at 19:47, Andrzej Hunt via GitGitGadget <gitgitgadget@gmai=
l.com> wrote:
> +    for (i =3D 0; options[i].type !=3D OPTION_END; i++) {
> +        if (options[i].flags & PARSE_OPT_FROM_ALIAS) {
> +            free((void *)options[i].help);
> +        }

Oops, I did it again: I=E2=80=99ll remove these unnecessary braces in V3.=

