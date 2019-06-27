Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 932201F461
	for <e@80x24.org>; Thu, 27 Jun 2019 18:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfF0SrN (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 14:47:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34085 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfF0SrN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 14:47:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so1771435plt.1
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 11:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BkEiTgULfGFjCNHjO6vKe6R74f/tB4+uRzkq4LZbQhU=;
        b=Hh4hJVfQoJomgF0ymKPtIXaG874LNJr42f9/QQ0i0vJAhSRQNW/LS6UzVUegQ6ZxDR
         4+TVDfYFS94BAs2AjWt7eNrY2e4KtcC5v6yTIaEzxONtjfc1W53kkVa2ND+M+GGdIesO
         QZOMRpVLnryIfbLzIL7NB0X0gFy4JSUubR1qplm6IUBn9Xs2M97pt43syMTuIOp//ozR
         6XbttX56FgvfQ1akAhHeGbmvNghsi+cH9T5ZHCgKftNf+4VC0WpNsTMyInc4VDsZWKMV
         ouK1PlZQUQuMy4r5U40yANZLZ7M1cjGlyS3m217vdemiz9VApC3a7yXsGA4BSm8CwjMH
         9a6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BkEiTgULfGFjCNHjO6vKe6R74f/tB4+uRzkq4LZbQhU=;
        b=HXUEQtdUnmX7R9jPX8+4PD8RC1265u/IpZw0wmFXXEIr/vGO5lD19eVNdhuUESSg06
         WKz+24bjEHVvVV2FmiOPZmz6kD37RVwfXOCWalvnZjw2fqSw9k6xJ4opP4VnbmivV5+u
         xQgnBmsmPrv9IQLvZt+bXcVKdZQ6oJnAueD2MhMYIATBJVR0uQ9Oi0lU0x9tPdv/FCWW
         koBllQvIEObEwzXgVb8q+5ynJfDyYosOpsN22Z43j1WOS6/1hbICL53UH+/o3sOoFEBU
         C4us+S2vLvCM+RTOdkKc77BsaLx5fRIYFzxvkD42ynYw5Pw6oEYkl7RUFE1FnUx40vvz
         Vqkg==
X-Gm-Message-State: APjAAAVLkL7Ni74x9SfSuDKUENm5Ojre282KYRn3Owc45REPrTB6VTyb
        YK8q8TyfsO0wvCqw3eXBprghJaP6IqE=
X-Google-Smtp-Source: APXvYqxHjuE8HEdZJSwCMQv/9DSWQKPFj7bmvCHgAU5a1gbvFp1sceLetGhXVJy6padQdmAm2IWUQQ==
X-Received: by 2002:a17:902:59c8:: with SMTP id d8mr6534855plj.55.1561661232157;
        Thu, 27 Jun 2019 11:47:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id g92sm5905157pje.11.2019.06.27.11.47.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 11:47:11 -0700 (PDT)
Date:   Thu, 27 Jun 2019 11:47:07 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [RFC PATCH v2 04/13] walken: add handler to git_config
Message-ID: <20190627184707.GB245941@google.com>
References: <20190626235032.177551-1-emilyshaffer@google.com>
 <20190626235032.177551-5-emilyshaffer@google.com>
 <CAPig+cT4=qMers5QTGCCPJx9=ej6rPUHjA94SqChxXBdJDTdmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cT4=qMers5QTGCCPJx9=ej6rPUHjA94SqChxXBdJDTdmg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 12:54:15AM -0400, Eric Sunshine wrote:
> On Wed, Jun 26, 2019 at 7:51 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> > For now, we have no configuration options we want to set up for
> > ourselves, but in the future we may need to. At the very least, we
> > should invoke git_default_config() for each config option; we will do so
> > inside of a skeleton config callback so that we know where to add
> > configuration handling later on when we need it.
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> > diff --git a/builtin/walken.c b/builtin/walken.c
> > @@ -24,11 +25,36 @@ const char * const walken_usage[] = {
> >  static void init_walken_defaults(void)
> >  {
> >         /*
> > -        * We don't actually need the same components `git log` does; leave this
> > -        * empty for now.
> > +        * We don't use any other components or have settings to initialize, so
> > +        * leave this empty.
> >          */
> >  }
> 
> Meh, I don't think this change has anything to do with this patch. If
> the rewritten text is the one you prefer, then just introduce it like
> that in patch 3/13 where the function itself was introduced.

Whoops, yeah. I removed this change, I don't think it's significant.
