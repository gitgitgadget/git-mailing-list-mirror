Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E24CC3DA7D
	for <git@archiver.kernel.org>; Thu,  5 Jan 2023 17:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbjAERv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Jan 2023 12:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbjAERvS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2023 12:51:18 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF78564C2
        for <git@vger.kernel.org>; Thu,  5 Jan 2023 09:51:17 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id t13so20062099qvp.9
        for <git@vger.kernel.org>; Thu, 05 Jan 2023 09:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hpc/oR7KYHTtxY4v57JD6eRTctd7s1QJuEamXPD3RFI=;
        b=Vdw7skkr1ZnzhiUuYq40Q4WFvgCZqtBoOTz0/HHPy4dv75HxO77B/zlttcgrnFcuPn
         6X3Vsx5FyaB/+cXCKNwU6Jz9cErKTJomBqwzueYDQ+NPScFEyTE02DXldwkzMU69LboL
         k+epMa4uxIeoUbyg0cY4Ym3AxQZb0+HCkvn3dnNBcT41f5skHOZu1GaBAm8DoNOdkFr1
         OcKi+iXd76Fd03RQc49DMZiwWshH41Um9ZgKNl9MSiGvIeqJkXEKm8A1tF0CATnPRRJM
         bq89BaIx9I7KViuUd/HEP+e+9g2a8Wun9KNrHEhzVGbejmY5Cyv6Y2vDCZtBtqWT9vRB
         p3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hpc/oR7KYHTtxY4v57JD6eRTctd7s1QJuEamXPD3RFI=;
        b=HwXNKRXtrblA0WZOBk3mJ0kbPw72Zi7gzS8uAR5+CBR+QUenNwIYwKMDaXAI4Jfw9+
         Gwo6/WKVpqxmPhkC6Hhq2rWkKj8BfaOZ41WOqz+qAM+ar/g1aUPhv9JbwDuOrExRxgCb
         IVhxFTumLWf8Z3ouO5EsC3/WvbgWQuQxnsHrOE3nZWm0kTSK3fwYQy29XYtv66IPqNcH
         JBVeSPr/n2s2BMItxAOiLuwLdTRSFa1VrbGTP6EcRmqaXyh6APMWgcgQnRyI/JFvQeWx
         Tgl9zHAAUyiazJ+mfmJdcAO0bRPacjAs7Fk9dZZT4/5TxzsZpyiYcgC3iCdSo8qIVY1C
         e7nQ==
X-Gm-Message-State: AFqh2kphEMT3pDrFqFjqxnrpUpR/W0OCgMLz2Cp5WLMCxblw7GuLPIHo
        zSEN4qBUl9aynNqsmpDJu+YYhtDz5J0wbqv5ahxGfHpTtg==
X-Google-Smtp-Source: AMrXdXsq53FEUrJJpaKcH2XN9fH7aG8vLFSHE4Mk+gVXD56hyd4TtQTz+2ZZyKJNg4EaxguiSNDRRdFW+CNrXie6ZA8=
X-Received: by 2002:a0c:e7c7:0:b0:4c7:8c1b:68d9 with SMTP id
 c7-20020a0ce7c7000000b004c78c1b68d9mr2710058qvo.52.1672941075976; Thu, 05 Jan
 2023 09:51:15 -0800 (PST)
MIME-Version: 1.0
From:   "Roberto A. Foglietta" <roberto.foglietta@gmail.com>
Date:   Thu, 5 Jan 2023 18:50:40 +0100
Message-ID: <CAJGKYO5UGmFZjZ2ucFY=1MojzVur69EjRgy=aWW7wnhZ6=DaVA@mail.gmail.com>
Subject: git.functions to improve the git users experience in your bash
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

 today, I have published this project which aims to deliver some
advanced functions for git and also a lot of smart shortcuts for the
most frequently used git commands. I hope you will like it and
possibly also contribute to its future development with your feedback.
At the moment, the project is limited to support bash. However, if
someone is interested in using it under dash, I will be happy to plan
a porting.

 https://github.com/robang74/git-functions

 Best regards, R-
