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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CE0E1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 18:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfF0Sk6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 14:40:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39897 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0Sk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 14:40:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so1662010pfe.6
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 11:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R00GMVghcJMvyD6IP+WFxOTJjsHGh42vT4K4qDBA50I=;
        b=XcaWzRN70Gp6j3SQsiaKuVZvbpmYiR24rAX1sIKsVYB1s2y676liMtPGtYGlumtNVF
         7K1Co/sbSf9nfkFxHIxLQ5cuUPRMOIOGCGDgacwJdEba2CnfQf0QTbZHedT84vwLrR6i
         Lrswajzr7q5qZW/DX2Xi9gF4ac+KcDVILtYonVYm6rjN1AUnj1EZ8u+use8Ztgwqpfps
         Zw8x5ItabG0FJrwx89QPNsWeAiKfqjUZOG5WQH4UewoUw64UTaHLJwnsuxL5E652jpRL
         Kdby8jBb8y+jzv9tbua+hNhwlRAm+mfIHpU3LDTHLmZ+4P2TLnZmuwkZ+DGFOe6nfdwF
         XXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R00GMVghcJMvyD6IP+WFxOTJjsHGh42vT4K4qDBA50I=;
        b=YB/0ZewgNyVRjz+Fy7zQ5m+XQCP2ubSkzVh78sM7kirmsZUIjayq0bPBaFqcpqx1Ax
         XxKWCy4Ji0BHEEa6pHNKuuorKBcXbq0gNLRC5U3OQyLOZeIL84m4Q6Te4EkMdAVqJw4E
         Tya0LTynnoVUZKLkMBsuYZC+p/DJlNBlwpLwWNnQ1nuu4eZ2nK6tvbYnfsY0rQvA3esv
         HQcI1Ntgkezn3PQrl2MNPnGHc4NhWMV0ci3wysKDQynlFTHyh7qNNOicHNwJ3UBbr/6K
         BHb5lyAMkpI+T+Eevk28IcjVqOCKO7IYxDRrRAOqeK6BM3w9xM01+ftOwmUmMIRYPoJb
         Q1cw==
X-Gm-Message-State: APjAAAVLEaNok7Yze8TfxxPses5H6mbUnY4YymmTAka2sPsyDTTg62oJ
        NRLnt8V7j1ANLhGDVqwJngPgI3SfmKQ=
X-Google-Smtp-Source: APXvYqyXY3V6UDMH4SOUnoFGtVVuSYwLR2biXXkSatEshTLoz3OgOgj3J1u7/XWnMRFU0gXjsaPlJA==
X-Received: by 2002:a65:63d1:: with SMTP id n17mr5230531pgv.382.1561660856682;
        Thu, 27 Jun 2019 11:40:56 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id l23sm2339842pgh.68.2019.06.27.11.40.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 11:40:55 -0700 (PDT)
Date:   Thu, 27 Jun 2019 11:40:51 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [RFC PATCH v2 02/13] walken: add usage to enable -h
Message-ID: <20190627184051.GA245941@google.com>
References: <20190626235032.177551-1-emilyshaffer@google.com>
 <20190626235032.177551-3-emilyshaffer@google.com>
 <CAPig+cQxt7rZRkQLpUZabwfLfWpzvVrWNd11RkQvt83K8zPZ7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQxt7rZRkQLpUZabwfLfWpzvVrWNd11RkQvt83K8zPZ7w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 12:47:25AM -0400, Eric Sunshine wrote:
> On Wed, Jun 26, 2019 at 7:51 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> > It's expected that Git commands support '-h' in order to provide a
> > consistent user experience (and this expectation is enforced by the
> > test suite). '-h' is captured by parse_options() by default; in order to
> > support this flag, we add a short usage text to walken.c and invoke
> > parse_options().
> > [...]
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> > diff --git a/builtin/walken.c b/builtin/walken.c
> > @@ -5,9 +5,34 @@
> > +const char * const walken_usage[] = {
> > +       N_("git walken"),
> > +       NULL,
> > +};
> 
> Unless you expect to reference this from multiple functions, there is
> no need for it to reside here; instead, it can live inside
> cmd_walken(). (And, if you do leave it in the global scope for some
> reason, it should be 'static'.)

Thanks, done.

> 
> >  int cmd_walken(int argc, const char **argv, const char *prefix)
> >  {
> > +       struct option options[] = {
> > +               OPT_END()
> > +       };

Fixed the comment from your other mail too.

Thanks!
