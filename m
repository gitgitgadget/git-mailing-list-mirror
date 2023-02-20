Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1E1C05027
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 09:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjBTJq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 04:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjBTJq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 04:46:27 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1D213D48
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 01:46:26 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-536bbe5f888so4872237b3.8
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 01:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RjF65YhArJmF9PNbmSQvj9bjt8ml8CV3NhtFBYkxe1k=;
        b=XsRtHI82eRRCgamsmgCacaEfa5o4PP56S4mGZ9eqFGgCuCAoG647sS8A56n+mk9zrR
         1eSo2yR17lCriwtHYHf+QvPDlCPpnef6MFC+UEboCyuwj0HDL1+UXEGSdCIqwwlO2FgI
         wIeXrq8qQ3QAIp/tHvMEAQcEy1+3nuq9OY4xl0jI3zAQ/4qN3pPepKFKmB+CN9ZB0E5c
         mt0ZoLl+qrxAuDln8QBVCgkTngNYjXvtjL/DBvQISN+lo/V+UY19kdue9qX10N3XkDy5
         y2E5oIq0nfk/AfvI6TUSvvQ72HzjTyNVyzUOhsQpCXbXI7K4j4rjhV+J1vTYVUmQV9Js
         2PlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjF65YhArJmF9PNbmSQvj9bjt8ml8CV3NhtFBYkxe1k=;
        b=ClbHkJzQhBCF5ErQXsLJGdoUuHPQb75vI/SV6FcUeTXA22JQtpSe0hW8NKHLJf+d9r
         2C0oiN3+xU83gyPCms3Xjajn4FaEEWlfJ7hLBeNkuKStfu8bZMFyDuSElW8gamVH9634
         alQytOM/2pSXrklnU9GkpuKjOwYZh9jAefVOJyDfLjqnm76lRl5w3HgbdZ6eYRVY1Dry
         llFktNiviASjHKVr+dJcVW0TnrMBq+3JajUXji2TkTUPRYocIzjAMWJE6Pxxyr+KSw4B
         2VRyPqaDgFa/8jC/u6ioqi/lT4puNnauk6Ig45AVJganhuCp79F4w/uUc5CACwtCuZxv
         R8kQ==
X-Gm-Message-State: AO0yUKVUWWqM3s5q6fM2eVgbmjKBbxzXl/SSW460ZhLYvSUsk34mCRdH
        +lthIxShFzzPHLalpcAB7wTUrBPvTQeX0hxlMJ0=
X-Google-Smtp-Source: AK7set8rffupeDOHXUoLHz/IBczvoiZ1wTdUHi4GH+sjn/0qxvbvRrzfDNsKwDWsZrGz/JlBEhCRbQ4daHiN0xCCWvE=
X-Received: by 2002:a0d:f8c2:0:b0:52e:e6ed:3097 with SMTP id
 i185-20020a0df8c2000000b0052ee6ed3097mr83011ywf.535.1676886385971; Mon, 20
 Feb 2023 01:46:25 -0800 (PST)
MIME-Version: 1.0
References: <CACkQP8tskwh6CcSFRCzyf82eoo9q_aLfSKD=2=jL+hgYH=f3Rg@mail.gmail.com>
In-Reply-To: <CACkQP8tskwh6CcSFRCzyf82eoo9q_aLfSKD=2=jL+hgYH=f3Rg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 20 Feb 2023 10:46:15 +0100
Message-ID: <CAP8UFD2bTBz2wTVjV+amtipQ-U78oW0ApE2pKCiLC+A1Nj_Z-A@mail.gmail.com>
Subject: Re: Regarding candidature for Google Summer of Code 2023.
To:     Anushka Saxena <anushka.saxena.iips@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Feb 19, 2023 at 10:20 PM Anushka Saxena
<anushka.saxena.iips@gmail.com> wrote:
>
> Greetings team Git!
> I am Anushka Saxena. Currently, I am pursuing an integrated Master of
> Technology in Information Technology from International Institute of
> Professional Studies, Devi Ahilya Vishwavidyalaya, India. I have a
> strong interest in open-source technology and the Git versioning
> system.

Great!

> I am excited to introduce myself and express my interest in
> contributing to Debian as part of the Google Summer of Code program.

Contributing to Debian or to Git?

> I have been using Git & GitHub as the primary version control tools
> for all of my projects and have been impressed with its stability,
> security, and flexibility. As a student, I am eager to contribute to
> this innovative and widely used distribution of Git and learn from
> experienced members of the Git community.
> However, I am new to the project and would appreciate guidance on how
> to contribute effectively. I have reviewed the Git documentation
> and familiarized myself with the project's goals and objectives.
> I would be grateful if you could provide me with some guidance on how
> to get started with contributing to Git. Specifically, I would
> appreciate any advice on how to identify good first issues, best
> practices for contributing code, and how to collaborate with the
> community effectively.

About good first issues, we have the following documentation:

https://git.github.io/General-Microproject-Information/

There is also the microproject idea page from last year's GSoC:

https://git.github.io/SoC-2022-Microprojects/

We haven't updated it for this year yet, so some ideas might be
outdated. It might be a good idea anyway to discuss a bit your
micro-project idea on the list when you have found one before starting
to work on it.

Thanks and welcome to the Git community,
Christian.
