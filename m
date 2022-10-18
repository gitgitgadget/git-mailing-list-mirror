Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE05C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 20:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJRUnd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 16:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiJRUnb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 16:43:31 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0D05755F
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 13:43:20 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id be13so9040057lfb.4
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 13:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ddvNfQ6Ibr9QiZ6W4i2ag2t4xfOCgEMx7byORPBUAJM=;
        b=ZZPk0AkrV/dWGHWUfJNbLSND0PD5zlmwlc9Q68q1mrnYIVQLFck93Mgc0ZrVY8n4wS
         nT1T5NnY6m/xIHSRzraJ2V+5pAmgftUNGvqlMzGrRuawxKcDT4pITORjwqxhjbsz1VAY
         fJZiO7M7HYI9QdxQ/7+tdvqli6BdeN5p2l//f7XxBZ/UdYRC+ckNueVl5cVTOVSRkPlA
         7tTC693G931/8TjP11DsFUGOj7jvcXmdw3eOFH1NFN8xGPF8lSUDmrHltJe2mbPmDbT5
         rZjuxGMXnJq0pg1lHDTmjVgMLFgQ1MYQsCDAem54KlM0u87o/rHmibqoUFA7uGLIamkX
         KxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddvNfQ6Ibr9QiZ6W4i2ag2t4xfOCgEMx7byORPBUAJM=;
        b=stwx/kWd6njIkzZ++TJFgwwqcYky8heIvT086kP8l7iIBJvJF/lFH8n5xP3rD8W9rl
         hPhM8NbiLUV20HePMV4SCXGuS4+oOeutq2DUB3CEB1ZBXtH5wVJpS9+yYQ5W8ehc1IEz
         iy5z+4lBFMcPrVKYsMEUdtHGgge2KkhLVYaJmde8XMOg4Ks7XLpwCFQKgyognyyM3sqd
         27bLlsJnRYs2MpQ45ChEZt5BglTjhuHjSV7FJi6AoMraJz/1Cn89Ozjnl5Ky5jwsTrQa
         FMIQRGiXiMyxQcpBj+aueLnjEtrXRcn9mGljNwPoKuGebgwa/BQrX2NIF1nIcz6zeY0A
         pMpQ==
X-Gm-Message-State: ACrzQf3L/myuHyD7vduaQYP/WsjLeaJUrFYoGYO30P8xIweCJu6ClClv
        4zz5n/vIor13JB6TYvy1NhJNxQ8poI/F2cJ9tF21vQ==
X-Google-Smtp-Source: AMsMyM6usbNAaWbthjXIvPY6C2O1Pf4qDvd0ivRgcEUg8lExfwqzGSsQpj1Cg39NZPQU8NVwQz9tnszHc0YRTSpHsOo=
X-Received: by 2002:ac2:5e6f:0:b0:4a2:8018:60e9 with SMTP id
 a15-20020ac25e6f000000b004a2801860e9mr1688022lfr.192.1666125798785; Tue, 18
 Oct 2022 13:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1345.git.1662071998812.gitgitgadget@gmail.com>
 <xmqqa67h8zac.fsf@gitster.g> <CADq8SzUUoi6=6ggxkeTUf2y0WmeAMMjuq8_OCej0smF7OabPiQ@mail.gmail.com>
 <xmqqtu4rv2wb.fsf@gitster.g>
In-Reply-To: <xmqqtu4rv2wb.fsf@gitster.g>
From:   Julia Ramer <prplr@github.com>
Date:   Tue, 18 Oct 2022 13:43:07 -0700
Message-ID: <CADq8SzWW+_uGMOwyyyT9pFWpOQW2eWUh2Ndn4qYQJ1fAqtXnew@mail.gmail.com>
Subject: Re: [PATCH] embargoed releases: also describe the git-security list
 and the process
To:     Junio C Hamano <gitster@pobox.com>,
        "Veronica Giaudrone (SHE/HER)" <Veronica.Giaudrone@microsoft.com>,
        "Bri Brothers (SHE/HER)" <brbrot@microsoft.com>
Cc:     Julia Ramer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Julia Ramer <gitprplr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[adding Veronica and Bri to TO:]

On Wed, Sep 28, 2022 at 10:12 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> >> > +- Once the review has settled and everyone involved in the review agrees that
> >> > +  the patches are ready, the Git maintainer determines a release date as well
> >>
> >> s/maintainer determines/& and others determine/ or "stakeholders
> >> discuss and agree on".  You might want to mention that the schedule
> >> for disclosure and release tend to be constrained by so called patch
> >> Tuesday, which is the least flexible among various binary packagers.
>
> By the way, this "we account for patch Tuesday" is not "the only 800
> pound gorilla in the room inherently has rights to dictate their
> terms".  It is merely that "other packagers are being nice and extra
> accomodating", and when another even less flexible packager requests
> a prolonged schedule, we might accomodate their needs, depending on
> the nature of the issue.
>
> On the other hand, the git users community may not be able to wait
> for the next month to apply an unusually urgent fix, and a binary
> packager with a coarse release granularity may have to be creative
> on such an occasion.
>
> In this hypothetical timeline:
>
>     A---B-B-B-B-B-B-B-B---C
>
>               D0----E0           D1----E1 (next month)
>
> where
>
>     A: problem reported
>     B: solution proposed, discussed, and finalized
>     C: public coordinated disclosure and release date
>
>     Dn: cut-off date for "monthly security updates" for a packager
>     En: date "monthly security updates" is issued by a packager
>
> the wider Git user community may not be able to afford to wait until
> date E1 of the next month by delaying C, even if date D0 for this
> month's "security updates" for a particular packager comes before
> the solution gets finalized.
>
> If the coordinated release C falls after the deadline D0 for the
> upcoming "monthly security updates" (not singling out Microsoft by
> mentioning "patch Tuesdays" anymore, as this applies generally to
> anybody whose release granularity is more coarse than other distros
> find comfortahble for security fixes) for a packager, but if an
> early round of proposed fix is seen, they can independently make
> their own judgement to include the non-final fix in their binary
> release at their cut-off date D0, while withholding the source at
> least to the agreed upon coordinate disclosure date C, for example.
>

If I am understanding this particular scenario, I believe you intended:

s/coordinated release C/final B/

> They may later want to update to the final fix by date D1 to be
> included in their next "monthly security updates" on date E1, which
> would be an extra work, but that is the cost of running a coarse
> release schedule.
>
> I do not know how to concisely phrase the above to fit in the
> framework of your document, but some of the above issues were
> brought up elsewhere, so I thought I'd better share it here.
>

I can take a stab at concisely phrasing this to fit within this framework,
first paragraph for context, second is the addition:

Once the review has settled and everyone involved in the review agrees that
the patches are ready, the Git maintainer and others determine a release date
as well as the release trains that are serviced. The decision regarding which
versions need a backported fix is based on input from the reporter, the
contributor who worked on the patches, and from stakeholders (e.g. operators
of hosting sites who may want to analyze whether the given bug is exploited
via any of the repositories they host).

While the Git community does its best to accommodate the specific timeline
requests of the various binary packagers, the nature of the issue may preclude
a prolonged release schedule. For fixes deemed urgent, it may be in the best
interest of the Git users community to shorten the disclosure and release
timeline, and packagers may need to adapt accordingly.
