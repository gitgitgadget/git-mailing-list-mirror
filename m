Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7417FC433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 10:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241934AbiATKgN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 05:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiATKgM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 05:36:12 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EA6C061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 02:36:12 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id z15so88788vkp.13
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 02:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qXT+24fPR96MuZPapSfrtM5k2+SCv2tvy5/4QXUq5PE=;
        b=f8PeeCHIdNlNeH1fLyFpfKeG9kgx9CZv44nK2SI+Md5DTIIJ46bsfE/OV73sL66S0h
         JwfNyHR2eXvOr3nhoTqLOAmtBxVSgwPMjonPs8JPaTYmyWkjXJ6KW7FwdvW6xDJ6YVEF
         jQiFQH3IDfUNHKjD7EtBfgQ7SlRGri8EeZMKdB3EuI7kOUt6YG8aHZtkBo/ZdLmIyxiy
         gQra4d3wxviSvjM1QXNycMfKQy9KuUk55OZ7AwwbiLUWJhzE8qvP4qoLBO0b1M2yzOHV
         luKDpP/mmw6+OCTdvkUOHJDmTSh3KkKW8dCIz5xgBRdXTkIxTAacMB4MJvAOSDate3Uz
         GODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qXT+24fPR96MuZPapSfrtM5k2+SCv2tvy5/4QXUq5PE=;
        b=vpQQZY+xFYaiVmKcOXlz2XxyBrwVPcICJhBAy2dAuUVxrPGaYJ5ye8lYMgxokZ+K2u
         Q3/LmjOov/U13x89HUB3DKR11MZAnzYvqZy63b9HvI0+00JJPVgc+E2eG3gn3ql4jSQf
         AbJF7K64XsAl+co+s+9TBvIEoi9vNh4Qsrjg5IBNHBOpjEIGSZv9T7jwxCEL0+e6qPPy
         cGRmhy8xwxWcU44iFSYGXTPBgq3D75+haPMo3Qs27GqewzwppsG24G8WlZuXt70SlCwt
         cc37d3cIetzl90kXXEO0onx6+szZ/CVo5L0XIk8AlitbkoOl9RkwWDLvsaF4zfj4fygi
         4bwA==
X-Gm-Message-State: AOAM532HyaofEU+kQSXHxQu90pzgfkP0haEjRMF3l1Y1tdAQXHtb0HfR
        S1ttX/DAw1en+LsvlzyWt0g6+QK7pQr4eQ1Y7qs/YDsOvtrGSw==
X-Google-Smtp-Source: ABdhPJw9IHtAW7eB8q4Abq99/5pC90oRAh7Dpf3ntJ15+qNO72ULD1HnJHkFiRDoz8sJ/BeMCNAWYkSgmcS8JUHg9ZA=
X-Received: by 2002:a05:6122:c8a:: with SMTP id ba10mr14612197vkb.37.1642674971381;
 Thu, 20 Jan 2022 02:36:11 -0800 (PST)
MIME-Version: 1.0
References: <xmqqwnivjgtg.fsf@gitster.g>
In-Reply-To: <xmqqwnivjgtg.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 20 Jan 2022 11:35:59 +0100
Message-ID: <CAFQ2z_PA4zHV8xc1f+sMW9DnaF1E4AQrvkCav_Sx-bKRkgDLtw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2022, #05; Wed, 19)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 20, 2022 at 3:12 AM Junio C Hamano <gitster@pobox.com> wrote:
> * hn/reftable-coverity-fixes (2021-12-22) 18 commits
>  - reftable: be more paranoid about 0-length memcpy calls
>  - reftable: add print functions to the record types
..
>  Expecting a reroll.

The reroll was sent on Jan 12. I dropped the "reftable: be more
paranoid about 0-length memcpy calls" from the series.

Should I send it again?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
