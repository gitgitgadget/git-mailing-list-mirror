Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71FF31F464
	for <e@80x24.org>; Sun, 15 Sep 2019 22:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfIOWGB (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 18:06:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40498 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfIOWGA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Sep 2019 18:06:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id m3so8026654wmc.5
        for <git@vger.kernel.org>; Sun, 15 Sep 2019 15:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XDemCzR/cxm+pj+GxJOZq1rT0rwtMk29B3M7LR9jSfo=;
        b=JsYrIUrNOXUgA4jgMp0zh+wT7HyUHlGwO9PCj9SuynKFyQBHArPQt0R7VnYeHG25E0
         ZvYWrvWFZJozfb4hdb7lFiNBUZd1yEe8wwYpCj35vevSTLSy48goOqX9s5v/imEwsI59
         m/TSbuOavKePXfHZ99Zn3tO3hEjsclFgQrLaWzFbJuEkaCWJCHusWFJRx5v8cQWwObwo
         cqxQZVsoZ4YxKlwrIh4AzTUK/5J53m7l7A5siDMRabvFIiO0suj0Pihig5kGz01orDH1
         ZL3VIC35mzcqN8PhlT6m54JIgUtzfNEFSq6jzFrnl1DE9PjFH9yqkSO2j3NqGbQiYPWj
         puXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XDemCzR/cxm+pj+GxJOZq1rT0rwtMk29B3M7LR9jSfo=;
        b=OmGMawlX36Bt5z/ydSubUDiDIoYe9EmLGLEdxEIwI/iZuJWnkbzOrV1/ciEj+9yBY4
         8gVtfoftja9nSartqdHUQbWB1pCprrGMAV5xn8GCasMFYKwj7FGY3ARYdCRh1JObkqcP
         mYNsW6l16Ll4PLsJtZ9GaRaYP1XX2sdpEXR7axvj3YApDmP0NpLkNMrxJuh8/d0l7D8y
         9x/pG/VE3LrGFAAxZnYj+KWenG/tgGTc//BVSYS9xXhK4kyW1Twn64pZ0oC350iWlsDg
         ce+HBIAVH2dm0g6hgV/7VnVpb9W91CppJXspxezJzWNQpwBBiPtQghqK+6xmrzC3P4wC
         A1pw==
X-Gm-Message-State: APjAAAWhG/aoYRRhkHbPNILIJ1KZ8STQCg509exaQPUpRUN1+YmQZz4V
        wsBR83SaEj7FDBCOLhYnkcToJkDB
X-Google-Smtp-Source: APXvYqyjw7UuoeX0WOIYqCsrISAG5neXye2OJp3ns0g3PMJSRKGpVp4QAH8KS0A2am7SP6Peo9kjyQ==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr11413975wmb.151.1568585159006;
        Sun, 15 Sep 2019 15:05:59 -0700 (PDT)
Received: from szeder.dev (x4dbd3c27.dyn.telefonica.de. [77.189.60.39])
        by smtp.gmail.com with ESMTPSA id a190sm10114042wme.8.2019.09.15.15.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Sep 2019 15:05:58 -0700 (PDT)
Date:   Mon, 16 Sep 2019 00:05:55 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Documentation: fix build with Asciidoctor 2
Message-ID: <20190915220555.GB6190@szeder.dev>
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
 <20190914194919.748935-1-sandals@crustytoothpaste.net>
 <20190915095952.GA6190@szeder.dev>
 <20190915212621.GV11334@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190915212621.GV11334@genre.crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 15, 2019 at 09:26:21PM +0000, brian m. carlson wrote:
> > > diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
> > > index d49089832d..b3e76ef863 100755
> > > --- a/ci/test-documentation.sh
> > > +++ b/ci/test-documentation.sh
> > > @@ -8,6 +8,8 @@
> > >  filter_log () {
> > >  	sed -e '/^GIT_VERSION = /d' \
> > >  	    -e '/^    \* new asciidoc flags$/d' \
> > > +	    -e '/stripped namespace before processing/d' \
> > > +	    -e '/Attributed.*IDs for element/d' \
> > 
> > I haven't seen this latter message in the CI builds, neither with
> > Asciidoctor v1.5.8 nor with v2.  Do we really need this filter, then?
> > Where does this message come from?
> 
> I see it and it definitely fails on my system without it.  It comes from
> libxslt, which has been patched in Debian to produce deterministic IDs.
> I suspect we may not have seen it on Ubuntu systems because they are
> running 16.04, which is likely older than the patch.  If Travis updates
> to 18.04, we may be more likely to have a problem.

Thanks.  Indeed, I kicked off a Travis CI build using their Ubuntu
18.04 image, and that "Attributed..." message was there.

I think this future-proofing is a good idea, but I also think that
this should be clarified in the commit message.

