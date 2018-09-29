Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9938A1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 07:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeI2OY6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 10:24:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37339 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbeI2OY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 10:24:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id y26-v6so4189949wma.2
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 00:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YfYJKmX0sDC4LC/GDn91BoqCOYf0tUAVAP0L9ZN+RpY=;
        b=u1Ie/xis4UZU9NfuKkMxnvvfwv4xA9xT7BXCrejIzZRwm9IjzVUsc4o1W85FnB8Kms
         zn51opNjkwo9VzEJ6xA1kyGYHa51AET0sERvDAYTdisHKXKFzCp1zGdzgQTfqCKEk9E0
         Vn24cPd1SptFScf4Oic8B3LQ2b8BSti/uIGZV5ARUW1Bbru6e8Sa6L7yJeSzl06QeDZN
         vkLsNEqwuv+6Ztk8bLrjt/W8vXQtH23OMafqdRAOX9ZoCJhiwuRfM6lmNLdoOYet0I5C
         UJJAdgsJ1v3/X0YFoXMvABUw+GHjPI05vXH9OaNcILlGIHXvpUiPKxxfrwogbo+ibx4N
         sZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YfYJKmX0sDC4LC/GDn91BoqCOYf0tUAVAP0L9ZN+RpY=;
        b=HSuAQMDizkAEJQooYpibZ+ONZbzlG1d1vjWa5rLjW9tYfgUuVZMrStpDgvbbBpQG7n
         HEKAXmMuy2jgUfIzWMGOhb2ei5kGwtBUttYdH98XazmyQXKDHYQtybHMIZwTR6I25WSI
         HZAYG//+1ox3vxO+k8Vb3pDT/zMjY0v1WTmdyIoLYuxKgDvESrzgsN0WIASnmFEF9EZA
         kbuRuq/CYikx3WneyGwQW9IX/dYJ1XhZTMLJO1b/e2Vkyz8Jd2seikeytAzzayfcKpYU
         tlfExkfPF2tujfpKWXw8F/5D2WQ1soOIrPX/qA4Q56EIErmY4AyTFvua1yD7J3oGoBh7
         F5Ew==
X-Gm-Message-State: ABuFfohaJ6fBqnOWabaRliqAUDv/+rAr/bzfJWYUQb/ygnqC9yGNMYl6
        tCvj7SEhymJBiUuNUA950wg=
X-Google-Smtp-Source: ACcGV63Z4M4Yunyv6usGokooKQ2DnAeAJlmy7Qjgr/Buxh5fg7FLpi3cY+BFtw8bxRYQsyRK4KRJ0A==
X-Received: by 2002:a1c:5505:: with SMTP id j5-v6mr3825428wmb.146.1538207848884;
        Sat, 29 Sep 2018 00:57:28 -0700 (PDT)
Received: from localhost (x4db14438.dyn.telefonica.de. [77.177.68.56])
        by smtp.gmail.com with ESMTPSA id 184-v6sm7932293wmv.6.2018.09.29.00.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 00:57:27 -0700 (PDT)
Date:   Sat, 29 Sep 2018 09:57:26 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 6/6] split-index: smudge and add racily clean cache
 entries to split index
Message-ID: <20180929075726.GE23446@localhost>
References: <20180927124434.30835-1-szeder.dev@gmail.com>
 <20180928162459.17138-1-szeder.dev@gmail.com>
 <20180928162459.17138-7-szeder.dev@gmail.com>
 <20180929052136.GA20349@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180929052136.GA20349@duynguyen.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 07:21:36AM +0200, Duy Nguyen wrote:
> On Fri, Sep 28, 2018 at 06:24:59PM +0200, SZEDER Gábor wrote:
> > diff --git a/t/t1701-racy-split-index.sh b/t/t1701-racy-split-index.sh
> > index fbb77046da..5dc221ef38 100755
> > --- a/t/t1701-racy-split-index.sh
> > +++ b/t/t1701-racy-split-index.sh
> > @@ -148,7 +148,7 @@ done
> >  
> >  for trial in $trials
> >  do
> > -	test_expect_failure "update the split index when a racily clean cache entry is stored only in the shared index $trial" '
> > +	test_expect_success "update the split index when a racily clean cache entry is stored only in the shared index #$trial" '
> 
> The the new '#' before '$trial' intended?

Yes, they only cause troubles for 'prove' (or in the TAP output in
general) in 'test_expect_failure', all the previous tests already have
'#$trial', just like the related tests in 't0010-racy-git.sh'.  And
many more tests have '#' in their names:

  $ git grep 'test_expect_success.*#' master |wc -l
  121


> 
> >  		rm -f .git/index .git/sharedindex.* &&
> >  
> >  		# The next three commands must be run within the same
> > @@ -170,8 +170,6 @@ do
> >  		# entry of racy-file is only stored in the shared index.
> >  		# A corresponding replacement cache entry with smudged
> >  		# stat data should be added to the new split index.
> > -		#
> > -		# Alas, such a smudged replacement entry is not added!
> >  		git update-index --add other-file &&
> >  
> >  		# Subsequent git commands should notice the smudged
> > @@ -182,7 +180,7 @@ done
> >  
> >  for trial in $trials
> >  do
> > -	test_expect_failure "update the split index after unpack trees() copied a racily clean cache entry from the shared index $trial" '
> > +	test_expect_success "update the split index after unpack trees() copied a racily clean cache entry from the shared index #$trial" '
> >  		rm -f .git/index .git/sharedindex.* &&
> >  
> >  		# The next three commands must be run within the same
> --
> Duy
