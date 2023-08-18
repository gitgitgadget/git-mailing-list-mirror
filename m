Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07B1C7EE2D
	for <git@archiver.kernel.org>; Fri, 18 Aug 2023 15:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377983AbjHRPK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 11:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378000AbjHRPKm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 11:10:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F973E5F
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 08:10:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so1268667a12.0
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692371439; x=1692976239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8TmXTbWf7gRj2IRTALOkB3j4W0cDB17istLFj0hVZQ=;
        b=HgRg1Q+mf9vSGPQYb9j9LnMQ4Oc/k0/2Bq+secV10fQrd2JqknbsOpMP0xxtOQ6AqV
         xYfL6dixd4AG6Pa49AIN76mypYyRQmB1h0tPIiQDFY9N0DmDzNtKlMEn5QAM+JvyKsae
         YJrcZI/tK66PJxE47iZ7UZqKdq0GdcehRzL9cTNUs3oorgxtZ+BWfmGf+AVRDhHFgUgy
         CTsXNoAolt4DSPh+BkEBEZyHrqM9Taaqxgu9bCADh7QlaXMt8lv94757BU7J8JYXc0Gq
         m6GaSTOUzrky/AssyCtzB+6/K9E3cbpiHsOi6YQ/fNQxwwg7XA/VZH9hwVv4KyTuEo+m
         WCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371439; x=1692976239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8TmXTbWf7gRj2IRTALOkB3j4W0cDB17istLFj0hVZQ=;
        b=TVTmBe7h7A/EgNbj/KWEQvUFaZtD8gr83fh7nbnfE2Wv7h/Bb0iFqqc351SweOnwLN
         Fwy/ycIv63U1sj9l3trVUltSVg6jhusXvLTPtkeL1jlHwIqOf5NYllVTj1JDg+1VG9Bv
         QCzBcBuz/UwO1CneYqd3XL1gmqClAyKp5MtomyqRiUXwGDuGECPRHhhp3yy0FaHZjAPa
         IU/luHhrN6yOTHh6sngEAq1yiu0oFnbIEl+q4TEGv+8kPe6fuP3jzSpGNFreBZGSSov6
         7WIRqBR2VPE+HDbR76rto5JIS3xJrN3CRy9oaP4pfeKmp0KEz78piDT+VZE4BpOMNJSn
         M53w==
X-Gm-Message-State: AOJu0Yw8WI+SGfgDnqM7ynMQbHIHY0iHPCtRow1YajcqNVznmIEy+EUv
        NFokCDBAI7Xf7OWwxqxsXbxwtrGFsERFvt1zV54=
X-Google-Smtp-Source: AGHT+IHTkHxrXrPpluy35nBtpIOVKoBVG7DCpgiTU9fIu/fwxm5ub+oriuh3Hou00sBuIv5EhOIuJXfaAgNN8F2PBZU=
X-Received: by 2002:a05:6402:1499:b0:522:cef7:83c3 with SMTP id
 e25-20020a056402149900b00522cef783c3mr2398533edv.8.1692371438916; Fri, 18 Aug
 2023 08:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <ZNwhVOggObU7aVTr@nand.local>
In-Reply-To: <ZNwhVOggObU7aVTr@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 18 Aug 2023 17:10:25 +0200
Message-ID: <CAP8UFD2Yw1XazomxEj0QB20FoaxkO16t_xgRurtnqCCOuhX-eQ@mail.gmail.com>
Subject: Re: Git in Outreachy? (December, 2023)
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Adding a few people who could be interested in helping with this in Cc:)

On Wed, Aug 16, 2023 at 3:07=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> Christian and I got an email from the Outreachy organizers asking if
> the Git project is interested in participating this year. Last year we
> submitted projects, but ultimately did not select anybody from the
> program.

Actually we actually selected someone and a backup person in case the
first person was not eligible to participate, but unfortunately it
happened that both of them weren't eligible. And we learned that after
the selection process was closed.

The year before we had no applicants for some reason.

> I think it would be good to participate in this year's December cohort.
> September 1, 2023 at 4pm UTC is the initial community application
> deadline.

I agree it would be nice, and I am willing to mentor, or if possible
co-mentor, someone.

> If we're interested, the project submission deadline is September 29th.
> By then, we'd need:
>
>   - Volunteers to act as mentors

I wonder if we need a few Org Admins too.

>   - Updates to our applicant materials on git.github.io (project ideas,
>     as well as potential microprojects).

Yeah, I can start working on the applicant material after my current vacati=
on.

> If folks are interested, I'd be more than happy to answer any questions
> about participating, and overall logistics of the program.

Thanks,
Christian.
