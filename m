Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0B0A1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 18:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbeIFWnG (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 18:43:06 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46508 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbeIFWnF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 18:43:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id k14-v6so9591642edr.13
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rQ54sFRTWAx6kB4089Pov2O8Y8GP5LK7JHl1q8rQvaU=;
        b=NipafIhB0n3/8DyRu+uz6ablX/H1rNSz0fa9izTCRc18SyYl8icadBs0Dz9TUyx3wB
         EaIXNeOpqLZpd07nJBsMKVTarYZhymc39ytzeWiJZQA4ZUr1wqHYVuuu188yktGtxObE
         bDSgkvdqjSjJCle5m0hD0o3I2Lo8GmO2BDmHKfg7ZyEy7zjvHrq09/LYbaLvWr8L+izJ
         awSyE4G/kLOAE45HlggoRA5dRicKymDNvbowLOwtv1BLj51YqH4azY/mXOCbJ457Tpi7
         AlB2RaOgMZ6IIcbit4cevHvvegwbNywHd0M9CZ2fOChNtiFa6qr65/uYp+EgvSaUr+0P
         5UWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQ54sFRTWAx6kB4089Pov2O8Y8GP5LK7JHl1q8rQvaU=;
        b=R4TfSF8ZVjBD7xfz+6i0S86pPM4ff8FgrdnghDtsnOlQvYIzrCYB0ECf6wHUm71Wn8
         mI36gnB2MkHR3KbEnCeVucz2DClHizJ0MlmDGp5lGMRfkF3tX5AUpN6MJK7pCgG3yUgG
         uSWN6A8s+amt7Ye5Igjpgm26pIY2cjc7ovT62ykq1dL4WI1gUg841rMpxga0op6YOSKo
         mgydD8GXKSnA0aMHGJ1UDbEdZgpb+vfMnDi+gLoAF4K5Kx8lSjbkckL8KSY3tIrmpmhJ
         Cq/4vGR1AXwwH7ikDLAtQP460v2Nae/7f1uOV4YAQCcNQUYL5cHGZH1MRxCPIUWLZdYD
         yuRQ==
X-Gm-Message-State: APzg51DKmh/WhIiqSRzQ9aLeUnHRAAAEX2V21iAMQp/XSVX6tbFPA859
        esZdn2do4HLKJZPw4jVT9yHKh/RZDS7bIx9jBMMWPw==
X-Google-Smtp-Source: ANB0VdZ/xZC+SF/NkeV4bfA6W4nkWfKzx6B5czcM29IR4agz4/mkqxP5EPd8yeU0UqisMup6fuQ2ark65sVLWP5QONg=
X-Received: by 2002:aa7:c314:: with SMTP id l20-v6mr4728422edq.53.1536257186227;
 Thu, 06 Sep 2018 11:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180905224825.13564-1-sbeller@google.com> <20180905231006.GC120842@aiede.svl.corp.google.com>
In-Reply-To: <20180905231006.GC120842@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Sep 2018 11:06:15 -0700
Message-ID: <CAGZ79kY_O+y0=1qMr2tw2cw3ULhhjTPQ-G5swa+KNXKLKSOSYw@mail.gmail.com>
Subject: Re: [PATCH] submodule.sh update --remote: default to oid instead of master
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 5, 2018 at 4:10 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Stefan Beller wrote:
>
> > Subject: submodule.sh update --remote: default to oid instead of master
>
> Yay!
>
> Nit: it wasn't clear to me at first what default this subject line was
> referring to.  Perhaps:
>
>         submodule update --remote: skip GITLINK update when no branch is set
>
> [...]
> > --- a/Documentation/gitmodules.txt
> > +++ b/Documentation/gitmodules.txt
> > @@ -50,11 +50,12 @@ submodule.<name>.update::
> >
> >  submodule.<name>.branch::
> [...]
> > +     If the option is not specified, do not update to any branch but
> > +     the object id of the remote.
>
> Likewise: how about something like
>
>         If not set, the default is for `git submodule update --remote`
>         to update the submodule to the superproject's recorded SHA-1.

... recorded object id.

sounds good.

> > +             git add .gitmodules &&
> > +             git commit --allow-empty -m "submodules: pin in superproject branch"
> > +     ) &&
>
> I wonder if we can do simpler by using -C + some helpers: something like
>
>         git config --unset -f super/.gitmodules ... &&
>         test_commit -C submodule ... &&
>         git -C super submodule update ... &&
>         test_cmp_rev ...
>
> Unfortunately test_cmp_rev doesn't accept a -C argument.

and the lack of fortune goes further, as test_cmp_rev needs to have
2 revisions in the same repository, i.e. both need to exist,
which is not the case.

> Broader comment: do you think people will be surprised by this new
> behavior?  Is there anything special we'd need to do to call it out
> (e.g., print a warning or put something in release notes)?

I guess. Not sure how to approach this best. Maybe we can
extend the output of 'submodule update' to print that branch names
instead of hashes for the configured case and keep printing hashes
only for this case. Although that would not help someone who relies
on the default solely.
