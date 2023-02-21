Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B007BC636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 22:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjBUWeu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 17:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjBUWet (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 17:34:49 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892E531E11
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 14:34:47 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cq23so22947176edb.1
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 14:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RKKnm9GRI1y1f4cPuTYT/cDf0xurPFsaY+fbi7ctY/Y=;
        b=AR7Bb/8cPwnGU+sTt5brixWHqQVrmIB66ZltxA+WpZl82s8Yz82nbhmohTuMIxlSQ9
         9fp4ODWfpeTRYbKlWu9ldoY9mmgfDhqgpRCEjEWpX8lGhR9VXguBE9kX5REopkbhV76i
         fhiWTTi1oR1M0CXeO3KasrqgkPeNiM9s+E6ENy4Q/ltVfFYrcyhg2e05imkcZHWnCv5U
         hoFDkWJhU2/GAq1EXlDpzyCqI0Ei2v4uETMmjhx8ZBpy/NmFevAmuh1KnO+/tTdC2Zi8
         pb6SKHmd3009EawAbnEXSy831ZjGOzfoTRM7XAbvpCBDpJFd1T2IQtuazZOoTitECBa3
         WOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKKnm9GRI1y1f4cPuTYT/cDf0xurPFsaY+fbi7ctY/Y=;
        b=ACQupb8EbheaTXxEicSfQ/D2Tkf/VZYLevoqPG9XKvN2oVLV8UJSd6thQj++mF8nSA
         +e3bhh+yCbMNj0ORL4ePmpolSIwJMCBOb1Ec2DQ26T3gSnTCXkL3EtErccWdzH2qpsaa
         DVzf3kyAxZdbMUJfU+lJJk608MispzBTCVXoAEuzhXM+T5vKBag+cCoM2C7sue/MayxC
         NauGkYtYnENex8Uyd21fE98Bu+hrUvxIs6zqOujHEWUuyLaJeDmSyFITDfRgqRdYqEnY
         wDV+QbvFvOzXd0+3hWjpYUfVXZvjbZzOjeGB3p5AfGsRO8wn06D6BCpu6QPWx+BziZLB
         j5cA==
X-Gm-Message-State: AO0yUKWSI6bT4ZDsYC1nabj6n0x67Q1Q0XlbDBV9YQHLT3XcwBFiWW3d
        UjRFuUW/JTW2+H9mrXqk/BfUXHbXeZbc4WvdwNyzP4855hU=
X-Google-Smtp-Source: AK7set/mAscjO8Qy6ZAwaPkiDIWCCon4uww8k3p4+IygjhI+fgNFFNPFxYFc+fm63rqMBpHr8k0f9lsrFAdRs7GpACk=
X-Received: by 2002:a17:906:a96:b0:8b2:d30:e728 with SMTP id
 y22-20020a1709060a9600b008b20d30e728mr7224067ejf.1.1677018885929; Tue, 21 Feb
 2023 14:34:45 -0800 (PST)
MIME-Version: 1.0
References: <20230220235121.34375-1-gvivan6@gmail.com> <20230221214653.85830-1-gvivan6@gmail.com>
 <20230221214653.85830-2-gvivan6@gmail.com> <77734da5-e711-f653-b022-ba3b26823701@github.com>
In-Reply-To: <77734da5-e711-f653-b022-ba3b26823701@github.com>
From:   Vivan Garg <v.garg.work@gmail.com>
Date:   Tue, 21 Feb 2023 15:34:34 -0700
Message-ID: <CADupsJMGgOzrd7L+Et=5t0a9vXNpZqhT4qzFi_7YbHwMMR6KWg@mail.gmail.com>
Subject: Re: [GSOC][PATCH v2 1/1] t4121: modernize test style
To:     Victoria Dye <vdye@github.com>
Cc:     Vivan Garg <gvivan6@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, hariom18599@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2023 at 3:17 PM Victoria Dye <vdye@github.com> wrote:

> The new commit message is sufficiently descriptive, thanks for updating. In
> terms of readability, it is a bit of a run-on sentence (the comma after
> "lines" could be a period, i.e. "...separate lines. Therefore, update
> the..."). I don't think it needs to be updated, but it's something to keep
> in mind for future contributions. :)

I've taken note of it. Thanks!

> Whitespace looks good here. I think this is ready-to-merge; thanks!

Thanks again for the review!
