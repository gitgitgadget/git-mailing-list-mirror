Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B49481F462
	for <e@80x24.org>; Mon, 17 Jun 2019 20:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfFQUaY (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 16:30:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34503 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfFQUaX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 16:30:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so4615505plt.1
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 13:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NpRdu/dVheP2SOThS1AMDAmxvLz/Gp6+sRyATFej2Eo=;
        b=Fl4y8k7RDpcSz0tC0az+3P8sVcLIRl/BTdQ6acpbviBHALCeXyKSChJ6GfeVU+SaQs
         uiig2l4YQ9/LJaPtXFAZqcmwYH13yvazNjmq+qeoNd1QO+4MTz/UPX4wQ0n+lTyLmOhg
         /aKifRGyvcdEeYrlgR8/XDovBYVxVKgD4DqHbkLWXU3QPY7pRKvnX5Fay183os/AhSdC
         T2dNFUr0TjR9Y0Ne5knAX0WoDHGS/Orw9qag/IkvQ76xMPDXyhEEehavOxHK/JRYYjFh
         rxwY+rCYZYOu1BLZlsI9raEMokTXqKG9rNv7mSPDinbZ9oaXQOATQSUKVVtbbDtPIXWK
         du6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NpRdu/dVheP2SOThS1AMDAmxvLz/Gp6+sRyATFej2Eo=;
        b=N3+7UspE9VPZHrULWFxwRDUaYyg3unS1NGF12Ol76J8pjO+Ge8zPFXFPGJFlptZCEz
         HjF6K/dTOKgmmrqVzSPZ7lW+TuSA5wtj9yh25yMF1gNB1epUsF71c8JSzsCwEkM4Hp4W
         TSe9k3sSkEWebwg2XmVduZ4eFXBipQOhunkDPKofyYEHqQpuujc+ljbBU2JT3JNdjT9j
         641AwlcMPxA4PjLSPifOuR3yVHCD/uyqFV9r3MwvEx+sk2E4J5/D4iQQb7TZZuaplCb9
         7Wy8wFQphBh2ze3HG1I8FLUo8rYY/6SHpdQxxnw8MFozdBxMRkL0GZq2ev5QSbt3a6jZ
         SERw==
X-Gm-Message-State: APjAAAWTBf6y5O2CkcuWdpioDwL9gW/dD5VgtCtgdG+eUTmbLjIKYzMm
        LYMzALFy90kECILnBqKmhDZdmbftLks=
X-Google-Smtp-Source: APXvYqwPwvQQJpXmjYS3oL2XLOYqBE3b1tPE9xCSHAubSvmqY1Bb77IJ+ljJHNSL0XoyMY2BCRnn0A==
X-Received: by 2002:a17:902:4643:: with SMTP id o61mr57044427pld.101.1560803422327;
        Mon, 17 Jun 2019 13:30:22 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id y22sm21556787pfo.39.2019.06.17.13.30.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 13:30:21 -0700 (PDT)
Date:   Mon, 17 Jun 2019 13:30:17 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 11/13] walken: add filtered object walk
Message-ID: <20190617203017.GA100487@google.com>
References: <20190607010708.46654-1-emilyshaffer@google.com>
 <20190607010811.52944-1-emilyshaffer@google.com>
 <20190607010811.52944-12-emilyshaffer@google.com>
 <712ced21-cc7a-0a4a-9cf2-64b1e7c5127a@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <712ced21-cc7a-0a4a-9cf2-64b1e7c5127a@jeffhostetler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 07, 2019 at 03:15:53PM -0400, Jeff Hostetler wrote:
> 
> 
> On 6/6/2019 9:08 PM, Emily Shaffer wrote:
> > Demonstrate how filter specs can be used when performing a revision walk
> > of all object types. In this case, tree depth is used. Contributors who
> > are following the revision walking tutorial will be encouraged to run
> > the revision walk with and without the filter in order to compare the
> > number of objects seen in each case.
> > 
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >   builtin/walken.c | 18 +++++++++++++++++-
> >   1 file changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/builtin/walken.c b/builtin/walken.c
> > index 408af6c841..f2c98bcd6b 100644
> > --- a/builtin/walken.c
> > +++ b/builtin/walken.c
> > @@ -13,6 +13,7 @@
> >   #include "pretty.h"
> >   #include "line-log.h"
> >   #include "list-objects.h"
> > +#include "list-objects-filter-options.h"
> >   #include "grep.h"
> >   static const char * const walken_usage[] = {
> > @@ -154,7 +155,22 @@ static int walken_object_walk(struct rev_info *rev)
> >   	blob_count = 0;
> >   	tree_count = 0;
> > -	traverse_commit_list(rev, walken_show_commit, walken_show_object, NULL);
> > +	if (1) {
> > +		/* Unfiltered: */
> > +		printf(_("Unfiltered object walk.\n"));
> > +		traverse_commit_list(rev, walken_show_commit,
> > +				walken_show_object, NULL);
> > +	} else {
> > +		printf(_("Filtered object walk with filterspec 'tree:1'.\n"));
> > +		/*
> > +		 * We can parse a tree depth of 1 to demonstrate the kind of
> > +		 * filtering that could occur eg during shallow cloning.
> > +		 */
> 
> I think I'd avoid the term "shallow clone" here.  Shallow clone
> refers to getting a limited commit history.  That's orthogonal from
> partial clone and the filtered tree walk that operates *within* a commit
> or a series of commits.
> 
> Granted, a user might want to do both a shallow and partial clone (and
> then later partial fetches), but I wouldn't mix the concepts here.

It's a valid complaint. I removed the mention of shallow cloning and
replaced it with a reference to the documentation for --filter in
rev-list. Thanks.

 - Emily
