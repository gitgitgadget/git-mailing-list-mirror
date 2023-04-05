Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AC3C761A6
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 13:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbjDENXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 09:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbjDENXK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 09:23:10 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A47213F
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 06:23:10 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id u97so375493ybi.10
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680700989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iX1yUOKZBmNQB80GMKIRopFgCv7l1RWNuqqepDObRA8=;
        b=T3lVEQ9AgPjODZZXJFULne5+ZhMlKpv74yyGKCwPxlbuWt4ysPcFb9gnzPnFoTzSNP
         6auuYOMJ2wJKyro0Wpg7F5z4hEtvPDOFmN/ytRW8fnCi3PxmMYFYov7v26iFhhNCJJQ1
         WdPqAZ0m+TuxOGy0AOWhxGHEFfjYuL+CkfCrMSxV9Zx0oW5bAtua5jDP4mp9WJe7HDdM
         tLGzDG3LYS/VgGd0ePpJY8oPmUHt9KWkr/2OQCDWtJcLXBZ8lqtnEPD0q6UD0Go+s4Eo
         r8QY5pJSCXItQ76YB9bpzzU2WcJ7/39tIqWjRKHsnuXp0DOUvLMTDuZzyEqq8EuirH1R
         PvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680700989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iX1yUOKZBmNQB80GMKIRopFgCv7l1RWNuqqepDObRA8=;
        b=Om6AsUBiIvSctZ6nmb1Bd4Gjjcws/k6E0k+h6eVm20tYdmjTK1EuorG5axGvS/CIY7
         t6TF/mQVc1SRUn8GEnQEjL1V9IrgHfVXpaJzoqJBEuWAP/ocHGmNQWFGbvgmF2TuoxM/
         Wrfa3o/AxyaHu/bhNLXaLdAOTvel/L5P6h6HHT3R1QVlGb+Y1iRtV2j5xirbY1NXeihN
         QYqoF5EHbPch2Y59CzQcj1WCP6IkT7Zc5L5GalOf3/JQPPjP1olqicPcsBwwPrmTK0s6
         h8wFNYsjij0O7ZJcWVc3s9FSLk993FFylQaYJqoETaNRzhGXeJLE5ws/mMWBqfGzKyxr
         ZpHg==
X-Gm-Message-State: AAQBX9e/L3lIpqCMarj0XrJpCerrs6a6Gn/46fGyKGTrti8V8ymAMxo7
        wtvtsQY8yi8um5CEIqXlW9sk586ZXtlt/f3lP6jd1SkS
X-Google-Smtp-Source: AKy350Y2DMPJyFhRuPbaReK4yhH1ZFMKuf3ZLjme23nMS7bJ2rvKhIDD0zcDZy0tjzBvkVq87UrFY910A3DVM0aTg50=
X-Received: by 2002:a25:7491:0:b0:b48:5eaa:a804 with SMTP id
 p139-20020a257491000000b00b485eaaa804mr3560956ybc.0.1680700989294; Wed, 05
 Apr 2023 06:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1510.git.1680661709616.gitgitgadget@gmail.com>
 <CAMP44s15E0xJwXv8qGp8FqQvB_KaxS2TXenNZNH_VzvXpXv4Hw@mail.gmail.com> <owlyzg7mubui.fsf@fine.c.googlers.com>
In-Reply-To: <owlyzg7mubui.fsf@fine.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 5 Apr 2023 08:22:58 -0500
Message-ID: <CAMP44s128zFcMrK7URUK73ZmzETDRA5SNkWwoHgukZ9Q3f+5Qg@mail.gmail.com>
Subject: Re: [PATCH] MyFirstContribution: render literal *
To:     Linus Arver <linusa@google.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Emily Shaffer [ ]" <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2023 at 12:39=E2=80=AFAM Linus Arver <linusa@google.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

> > And for what it's worth I would revamp the whole section, something lik=
e
> > this:
>
> > --- a/Documentation/MyFirstContribution.txt
> > +++ b/Documentation/MyFirstContribution.txt
> > @@ -1136,18 +1136,18 @@ information on how to handle comments from
> > reviewers.
> >   We'll reuse our `psuh` topic branch for v2. Before we make any change=
s,
> > we'll
> >   mark the tip of our v1 branch for easy reference:
>
> > -----
> > +....
> >   $ git checkout psuh
> >   $ git branch psuh-v1
> > -----
> > +....
>
>
> While I see the four dots (....) being used to denote regions in other
> files like SubmittingPatches, they are not used at all in
> MyFirstContribution.txt. So I am not sure why we would want to change
> this.

"We" probably don't want to change it, *I* do. Because in AsciiDoc
there's a difference between a listing block and a literal block, but
the Git documentation does a very poor job of being compatible with
AsciiDoc anyway. It doesn't even use the modern syntax. So it probably
doesn't matter.

Cheers.

--=20
Felipe Contreras
