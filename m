Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D9E41F462
	for <e@80x24.org>; Tue, 21 May 2019 18:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfEUSTy (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 14:19:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35584 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbfEUSTx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 14:19:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id p1so3439047plo.2
        for <git@vger.kernel.org>; Tue, 21 May 2019 11:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=frSvqIJSVmG9ivERJ5ZR2XSm2MHKVu3QYf3HX9UPTUI=;
        b=unah+FISgFBarnHSpDujRoE95xeg0gyB4mnRy86K0YoSIOvkIgSS0Z6LcAPDZ+SXBE
         59xjZKBMgDTyzr0Oe99b4BdJsFQwSUMEcgmnx2gtEiNgQ76z2OsKDJ3lC1A9Qh5597Lw
         eWlsXc+BYD0uY0YsqUdGS9dMic0e7A8mGI8g+h/RO7k3/hVkARCD0ow0XXolfdImAIJs
         +LCtfL8NUuHZ6Az8g7v8Xp2uz8jUxaWHLpWZTqYrvEZBe0wTNYFwaF2DHJHvy6Jf7jXo
         bXagjcLy1BSBUbkiQdbS5v8oFd1v7NtTQSZqB6j/gmuJXhZkcYCIGp9C/q0n4+EKjTKq
         auZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=frSvqIJSVmG9ivERJ5ZR2XSm2MHKVu3QYf3HX9UPTUI=;
        b=kG2RnsdLNEivZEgF4c2U1Csr2H7G3FB4CT1SFlb85VRCgnQL2d4jOr+gaW6DyaSoN5
         EcHm6dytKXJlDGn97RScsAyooh5FRyn/LlKA++ijWfXiFo/bh45Cu1O+X783wu0KVneD
         VveL0Z8v7yLXsEy3YPnbXbyA9r9PLTS2XPM3fME/dQRH46ErIKm39t8++Y1UZtuJY4xC
         JjbKtiAB3BR0NG/D7eRuNlVFY78vyVc+7YW1dSeZC2G/9DrKjAhCt+GYF24lYJkQISS/
         biUFhhwb3ERyPrQv5PROubtC4fO5ncp+iH1toktrzaoj7aGESRJQoKl17DvIEnMXMiRm
         DCBw==
X-Gm-Message-State: APjAAAVG3UiaJ0cGmpTxtaJuyp1kMYypyFaV0x+iBwBi0gZahIXT6Qv3
        I1QvNp4TLiYh5AjZmb7UatDEZg==
X-Google-Smtp-Source: APXvYqzmD/ZD+mfE48kQkmdvLlFmJ1Go07HkcPhVY3LImv2x/G+dmUPhO/cqPqwSipbFR8Hb3bWb3Q==
X-Received: by 2002:a17:902:12f:: with SMTP id 44mr38392608plb.137.1558462792683;
        Tue, 21 May 2019 11:19:52 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id 14sm25681045pfx.13.2019.05.21.11.19.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 11:19:52 -0700 (PDT)
Date:   Tue, 21 May 2019 11:19:43 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] doc: hint about GIT_DEBUGGER
Message-ID: <20190521181943.GA82620@google.com>
References: <20190517204826.45308-1-emilyshaffer@google.com>
 <20190521010036.70378-1-emilyshaffer@google.com>
 <CABPp-BHehO4dJCpNHws=PAaqxTyoeLyb3N1BGFG+AEEgBYVtBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHehO4dJCpNHws=PAaqxTyoeLyb3N1BGFG+AEEgBYVtBQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 21, 2019 at 09:06:18AM -0700, Elijah Newren wrote:
> On Mon, May 20, 2019 at 6:01 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> >
> > We check for a handy environment variable GIT_DEBUGGER when running via
> > bin-wrappers/, but this feature is undocumented. Add a hint to how to
> > use it into the CodingGuidelines (which is where other useful
> > environment settings like DEVELOPER are documented).
> >
> 
> Two very minor nits:
> 
> > It looks like you can use GIT_DEBUGGER to pick gdb by default, or you
> 
> I think it'd sound better without 'It looks like'; perhaps drop that part?
> 
> > can hand it your own debugger if you like to use something else (or if
> > you want custom flags for gdb). Hopefully document that intent within
> > CodingGuidelines.
> 
> Maybe just leave out 'Hopefully'?
> 
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  Documentation/CodingGuidelines | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> > index 32210a4386..e99af36df9 100644
> > --- a/Documentation/CodingGuidelines
> > +++ b/Documentation/CodingGuidelines
> > @@ -412,6 +412,12 @@ For C programs:
> >     must be declared with "extern" in header files. However, function
> >     declarations should not use "extern", as that is already the default.
> >
> > + - You can launch gdb around your program using the shorthand GIT_DEBUGGER.
> > +   Run `GIT_DEBUGGER=1 ./bin-wrappers/git foo` to simply use gdb as is, or
> > +   run `GIT_DEBUGGER=my-debugger-binary my-args ./bin-wrappers/git foo` to
> > +   use your own debugger and arguments. Example: `GIT_DEBUGGER="ddd --gdb"
> > +   ./bin-wrappers/git log` (See `wrap-for-bin.sh`.)
> > +
> 
> Other than the minor nits above:
> Acked-by: Elijah Newren <newren@gmail.com>

Made both the changes you recommended; I'll hang onto it locally until
this afternoon in case anybody else has something to say. Thanks for
looking, Elijah.

 - Emily
