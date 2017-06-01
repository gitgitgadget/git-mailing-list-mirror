Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A89D820D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 21:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbdFAVJP (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 17:09:15 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35378 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdFAVJO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 17:09:14 -0400
Received: by mail-pf0-f177.google.com with SMTP id n23so37581184pfb.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 14:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BxO5oHjCPyQpna1CLOOCBKPgWKspbnnt923uZzuzto8=;
        b=ujPrf/6SfaTYSQqWdTnZCCji11gcZ4ODpZGhEIMpQfduwA1y2KeY+w/0F58HVP/d+U
         Sd+RttYm9QRHC5GD0Y+eFjPQ/KA/uQzmTjpzrKW+nTDSBEVvqVMGMHAeGmqxEyijssOm
         bpwGGw4zB7ysK8rZuWC1BHHCYM/q8RBue7EtSjGF+MBH11OMB6W6UKx5m26vZFn2pH5f
         7bdnsGvMs1wIhpzs4PHwbPaKogMfnbvaKgCkNUdCj8Lpd505uwPaDtDBignrb1nbG9HG
         23dSbyweSwy1zgn21f7QzkRoWAeuUoag/Bd0DcDs/goh2o7W7WqX4b/ANh+4WbDadg1J
         5V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BxO5oHjCPyQpna1CLOOCBKPgWKspbnnt923uZzuzto8=;
        b=t9ez2m7wgECq9a7fxkiXQhDVteylyLwesL40GZI6ObY93WtuXaVfYzJyyVrufH0CA/
         PpPIJGm9Qd9ESg6QXLtb3lgWYQmToIyIm9QTw5WvyYRUzgVueZnsIpkROe/h9HpHCagL
         yviTsJqtIptdOa6sITZPA5mvPMLjCmMOHkzuCVQO+e/6/ilvAK2ZTc16M3B6PVchrOYo
         LlAe8XHBt8OAYIzZ3/NEKOSuUA8MEqlzFhnF0CXtJBfPnI7riOh+9LbFP8mWlSeA5xBt
         DkfgoeIBBlXHJcbTbSQoQEn/nxqFDjUAyOIyadIxX6O5v60ZJnuuTtgJMKBadXA6cTa1
         4DJg==
X-Gm-Message-State: AODbwcBQ4VMGKEIjNQpqpeaAHuS6UbzDWadDI9n2xjDK4kVeRtIqwyle
        SXu6iCxh8vgZJHQ6
X-Received: by 10.98.138.68 with SMTP id y65mr3016708pfd.131.1496351353661;
        Thu, 01 Jun 2017 14:09:13 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:21ee:55f5:50a0:9409])
        by smtp.gmail.com with ESMTPSA id a187sm8084469pge.45.2017.06.01.14.09.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 14:09:12 -0700 (PDT)
Date:   Thu, 1 Jun 2017 14:09:11 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 05/31] environment: remove namespace_len variable
Message-ID: <20170601210911.GA159608@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170531214417.38857-6-bmwill@google.com>
 <CAGZ79kZF3mk40P1rRvV57X=JWveNoCmdvKmkUO=fo8Ts=BkZrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZF3mk40P1rRvV57X=JWveNoCmdvKmkUO=fo8Ts=BkZrA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/01, Stefan Beller wrote:
> On Wed, May 31, 2017 at 2:43 PM, Brandon Williams <bmwill@google.com> wrote:
> > Use 'skip_prefix' instead of 'starts_with' so that we can drop the need
> > to keep around 'namespace_len'.
> 
> Looks correct.
> 
> Performance wise:
> The strip_namespace function is only called from {receive/upload}-pack
> and http-backend, so all network operations, whose actual operations
> should far outweight the tiny CPU saving that this reverts.
> We should be fine?

Actually there should be zero performance degradation with this change
(maybe a very small improvement) because both functions need to do a
char by char comparison, just skip_prefix returns a pointer into the
string with the prefix already stripped.  So no need to do a strlen()
calculation on 'namespace' as well as no additon operation adding
'namespace_len' to 'namespaced_ref'.

> 
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  environment.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/environment.c b/environment.c
> > index a73b08f5d..e035f6372 100644
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -98,7 +98,6 @@ char *git_work_tree_cfg;
> >  static char *work_tree;
> >
> >  static const char *namespace;
> > -static size_t namespace_len;
> >
> >  static const char *super_prefix;
> >
> > @@ -190,7 +189,6 @@ void setup_git_env(void)
> >         git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
> >                                                           : "refs/replace/");
> >         namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
> > -       namespace_len = strlen(namespace);
> >         shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
> >         if (shallow_file)
> >                 set_alternate_shallow_file(shallow_file, 0);
> > @@ -231,9 +229,10 @@ const char *get_git_namespace(void)
> >
> >  const char *strip_namespace(const char *namespaced_ref)
> >  {
> > -       if (!starts_with(namespaced_ref, get_git_namespace()))
> > -               return NULL;
> > -       return namespaced_ref + namespace_len;
> > +       const char *out;
> > +       if (skip_prefix(namespaced_ref, get_git_namespace(), &out))
> > +               return out;
> > +       return NULL;
> >  }
> >
> >  const char *get_super_prefix(void)
> > --
> > 2.13.0.506.g27d5fe0cd-goog
> >

-- 
Brandon Williams
