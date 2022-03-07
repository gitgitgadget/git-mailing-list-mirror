Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73F0C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 19:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbiCGTjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 14:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiCGTjx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 14:39:53 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A4B13DE2
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 11:38:58 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id g1so15222581pfv.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 11:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6fJ37ysopPkermhORVW0htJDHs8QN4udfn1bzw86+0=;
        b=fYS0/zTPgOwH2mWvHZmilIdNbOdeZoe9TAIy2KwjVH/G4Q7EK9/wDotfTGjPdPZGlV
         nEfEW3qi+8gOwNy9Y8EgD6uhNFyMPvyf2ZUuMuHSvOvfHgkOpmJ1loF/M45SrlwZtvHF
         +yvFpRg4o40sbw5uLo6AtmzYAFdr3DbyJpR+mxSSFMsTfYVdPDS8j2JYNSqLL599IkhK
         93DBQA/0MsviS18zJERZ3a8+UNaXjsbPuXQSaH8jLjR5Ap9HMnU6l5Trhi1YPrBlMLrz
         YVTy4uct58FN+cwov4AWhXzrUgTQvHhda5hDcfsE8OGtJs41fGlIG4Zyz9TLQOmeRur4
         vX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6fJ37ysopPkermhORVW0htJDHs8QN4udfn1bzw86+0=;
        b=Bvv4DHX2a7286HnnqsW/+nM675cYJmyMMTkKoGVdhMRpRO4dUqaB/mRntgFZM0KG7K
         /v5aoushmPUKTij765ylXubofxlKwgsdV05C0PAn0PU5gvyzt3kzUeNNjTxra4byde3v
         CTT0gPz2/01yLXDYVOo2XFDMSMDVcg8XUBfdrqAKd8o3GDytEu/JbPC5DOnu62XplMg1
         bPzBpSZe/9nbAi5E2AJ5Zko6cNaDzJyX4aKEFIeTfTIcYkor03CEDf6GXoYDhT1ns6Az
         zAEkzy4JtHRI9Cqde1qQA5W5GQJQyZm5/iLNgvZ6AxxeQva8vdlraikAhYM75IIQzvMH
         NxoQ==
X-Gm-Message-State: AOAM533SQ5TWQEsN3d8KE++qldxymrhPG7dj3txH7hfDn9iMRVeBipZ4
        l2wjjAFIPvTyu30+x+fkehHjmC+vxSKHyZhqwoclvPuBRQLIuA==
X-Google-Smtp-Source: ABdhPJwaO7pxktLBAUCVSKRzxsVvFM1ZAN8VljgA9gWp2XUo9bikWKROaC+0hI+vJgWPIxnnByMZlrOsZilh/GzY9Cg=
X-Received: by 2002:a63:90c7:0:b0:37c:7a8c:c2d3 with SMTP id
 a190-20020a6390c7000000b0037c7a8cc2d3mr11213372pge.473.1646681937396; Mon, 07
 Mar 2022 11:38:57 -0800 (PST)
MIME-Version: 1.0
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
In-Reply-To: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date:   Tue, 8 Mar 2022 01:08:46 +0530
Message-ID: <CA+ARAtquQOtcDtc0nCWkxyP2enb_QbxyoK9b3HWf-2JzbaKbkQ@mail.gmail.com>
Subject: Re: Git in GSoC 2022?
To:     Git Community <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Hariom verma <hariom18599@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I'm glad to share the news that Git has been accepted as a mentoring
organization [1] for GSoC!

Since it is possible to invite mentors now, I've invited the mentors who
have suggested ideas[2] so far. I've used the e-mail mentioned in the
ideas page to send the invite.

Some upcoming GSoC deadlines for reference:

1. April 4 - 18:00 UTC - GSoC contributor application period begins
2. April 19 - 18:00 UTC - GSoC contributor application deadline
3. May 12 - 18:00 UTC - GSoC contributor slot requests due from Org Admins
4. May 20 - 18:00 UTC - Accepted GSoC contributor projects announced

Full timeline available in [3].

That said, there's still time to propose new ideas. In case anyone has
ideas that are worth pursuing for GSoC contributors, do feel free to
share them.

[1]: https://summerofcode.withgoogle.com/programs/2022/organizations/git
[2]: https://git.github.io/SoC-2022-Ideas/
[3]: https://developers.google.com/open-source/gsoc/timeline

-- 
Sivaraam
