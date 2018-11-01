Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D134E1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 19:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeKBERk (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 00:17:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46624 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbeKBERk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 00:17:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id f8-v6so5064576edt.13
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 12:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17JMAvowgN1vcjdZJvVvp9UAzVhJWzdOP9lVStpMobY=;
        b=kiuvUlBY0yVGSduYPATsUht9I1uXmelAOGYqhGIiwha6ODEgP7p4FuZvw4GVzArUHc
         dHFKT/JWeamOWuHGbBDeif3GU5UJXjnbRMVbs0m2AajNP+ZBUuAtdvPX3u8Rd+yF0/4u
         zMOp5kwTkKwdSFDawuHIyFMDfXUMDtCAA/MjQkIMVzoqw+ywLYmIEag65mn9H3H8Z7ke
         V9i6Y9vrV1FeLJTwrUO5NXJKdoZ05Aost9cOcYxHDEEcMVc56HMDxHQuO5meZFabSCdK
         LtP8xs1oViASRxAPoy6IX218k6aTbT6rv1Ec42NGfj83EQNPE/tddEt0CclVAsnkoc0g
         9BXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17JMAvowgN1vcjdZJvVvp9UAzVhJWzdOP9lVStpMobY=;
        b=Cw+tcpN3vQkQQbM1QMTrP85+fvgC5SUK5dpIVZ9mVwqH4sxbpZAY/De78/xpXa/1W1
         0psbXKDklmQOYz0+01hcb9nKw/rDhZp6mxABYqKoM+JdeYhTOwCXST5Wvy1Aj7PxeOn8
         k1NUDa5Bg1U7EPJoXquXCpRED/NlbhgaHWZQK8b9PQrQ5mYxR5JwBQEKvnMAfHRhr8IH
         qnXCQl6dpOAyEJqHaSaVjtKkZWRjqtwXjMjBseWDJ4O04PZTxj5OcI1pmCtrETnfGPSZ
         CIfx4+92MwKr/wYbcWDjEn/YAcZerGfMS+cac5Iq6QAHZuQp0pVPZhPtvzk4006rRoK0
         EyBA==
X-Gm-Message-State: AGRZ1gJVo/NWCcFAv/f0gvLkUviMe28pq0i9SjkgGmk6Z+94TCHIed0l
        JKdXI4et5NveCna0I+0MZZh7HzaBzll/KdEv1uouHVKNT+v+eA==
X-Google-Smtp-Source: AJdET5dA7Kz9wcvU19YJGsibjB3Vo+fdGRua0dPSJWbADXjICyIfKSG9yJ0B2NGk+nmSXPC1p5g0JOWdfZjLQldBbPs=
X-Received: by 2002:a17:906:f45:: with SMTP id h5-v6mr4749652ejj.106.1541099602238;
 Thu, 01 Nov 2018 12:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com> <20181016233550.251311-19-sbeller@google.com>
 <ab0f5b37-b4f1-3efc-b30f-f3b34f2a11cb@gmail.com>
In-Reply-To: <ab0f5b37-b4f1-3efc-b30f-f3b34f2a11cb@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Nov 2018 12:13:11 -0700
Message-ID: <CAGZ79kanW632k=LHzT9RhmDMSpCTK8K2sPswsF7H0RRC1aLqVQ@mail.gmail.com>
Subject: Re: [PATCH 18/19] submodule: use submodule repos for object lookup
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 31, 2018 at 6:38 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 10/16/2018 7:35 PM, Stefan Beller wrote:
> > @@ -482,14 +483,46 @@ void prepare_submodule_repo_env(struct argv_array *out)
> >                        DEFAULT_GIT_DIR_ENVIRONMENT);
> >   }
> >
> > -/* Helper function to display the submodule header line prior to the full
> > - * summary output. If it can locate the submodule objects directory it will
> > - * attempt to lookup both the left and right commits and put them into the
> > - * left and right pointers.
> > +/*
> > + * Initialize 'out' based on the provided submodule path.
> > + *
> > + * Unlike repo_submodule_init, this tolerates submodules not present
> > + * in .gitmodules. This function exists only to preserve historical behavior,
> > + *
> > + * Returns 0 on success, -1 when the submodule is not present.
> > + */
> > +static int open_submodule(struct repository *out, const char *path)
> > +{
> > +     struct strbuf sb = STRBUF_INIT;
> > +
> > +     if (submodule_to_gitdir(&sb, path) || repo_init(out, sb.buf, NULL)) {
> > +             strbuf_release(&sb);
> > +             return -1;
> > +     }
> > +
> > +     out->submodule_prefix = xstrdup(path);
> > +     out->submodule_prefix = xstrfmt("%s%s/",
> > +                                     the_repository->submodule_prefix ?
> > +                                     the_repository->submodule_prefix :
> > +                                     "", path);
> > +
> > +     strbuf_release(&sb);
> > +     return 0;
> > +}
>
> Based on the recent test coverage report [1], this xstrfmt() call is never
> run witha non-null the_repository->submodule_prefix. Is there a way we can
> exercise that branch?

No it's dead code, actually. the_repository never has submodule_prefix set
as it is the main repository. So this is overly cautious to enable the
'any repo'
case.
In a resend we'll go with xstrdup(path);
