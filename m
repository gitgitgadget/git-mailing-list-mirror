Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A0AE1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 20:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfKDUpJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 15:45:09 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35557 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbfKDUpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 15:45:09 -0500
Received: by mail-pg1-f194.google.com with SMTP id q22so4636934pgk.2
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 12:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n093xly8FfXQezbq99WPa8pFO+bQV8We4LsoxbWsnxw=;
        b=OkHXVXn3V6kuZf7OAqNs/uMVzmtdYyu5rLA1N50tn+3sJ3ebriEvELFPYXF6bfUD6Q
         qaPAYym/fVR8dXujoejlGdqwwhTIODfZeQFjIJvdVR4Slt1R4XdiTbMrfDbAeVhlw/iP
         XfzQLIMuht770QtS5wtu3HIPrlUFySLqo6QSu9tsLRzAZinljpyYjo2lsteeyjZotCKp
         Gw96YUjPioCnzK5YKzMrQoA2rp/ORm7VMOBPLiuQwbaP/loS1wQ8f+g0Q5nFYIMmePOd
         vjRnuj+SOuSpy9aovkFqBWErZ1dcw37sM5/M2GiSuIwWevQwVDd8Nj5PHsEbrUtj1fEZ
         qCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n093xly8FfXQezbq99WPa8pFO+bQV8We4LsoxbWsnxw=;
        b=bt3LMM6xRpKWiFCgnDAzCXpw/uA4Jved4HjF4KCKKLZFd4gb+O1dUo959t29/wLDXd
         sSCuu5kRb6O+L6xn5Tl5SMTCFxAhNqsefoJMiWy4ZDu/zJmubqus11ddMhWLwmZ4/3AY
         ds9EYaaRmuDyhX/CChW3hr/yOl+hMlv6vRswawgbWggtYPNmOzC7Oi0+5+chzepxqtzm
         /m6PZ8rbYxiseCmeEHUweD9dq8U51PWBZ24wZD9dYLvZWCV0NllbWb5nxeYe744biE3d
         R7TeoIX46D7swE9xjV4WXC+ux5hRlXIyoc23Ng/w6laRMbwiritd8JddVZ7LmpgQCpyv
         0atw==
X-Gm-Message-State: APjAAAVCML1y+HKmwQxOzqPjnU0PBzQl7exUxZ9FZCrtUTZL/9Kj5WNS
        W9vQ0mJciAWdQW36XHBq0us=
X-Google-Smtp-Source: APXvYqwHl5GMCwePdPcwopuM9z+XXtF0IQDxISaWJmUShhY9S3D091CnKvEUU1Wd3yWo9jZMydfgXA==
X-Received: by 2002:a63:e156:: with SMTP id h22mr31657883pgk.266.1572900308729;
        Mon, 04 Nov 2019 12:45:08 -0800 (PST)
Received: from generichostname ([204.14.236.210])
        by smtp.gmail.com with ESMTPSA id i71sm19162462pfe.103.2019.11.04.12.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 12:45:08 -0800 (PST)
Date:   Mon, 4 Nov 2019 15:45:05 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 7/8] pretty: implement 'summary' format
Message-ID: <20191104204505.GA8559@generichostname>
References: <cover.1572897736.git.liu.denton@gmail.com>
 <64b6f7c9d7434ba39929220c1aebcd9a1fd0ad6e.1572897736.git.liu.denton@gmail.com>
 <CAPig+cRVgf3q6-mHeMgOThCrhseTGtYt+S6x1ikUSEKGbUTz4g@mail.gmail.com>
 <20191104203558.GA8004@generichostname>
 <CAPig+cRqYhUACkUKKzy2bCY7pZn=mZFVdxepKuiKuvwBEBJ5xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRqYhUACkUKKzy2bCY7pZn=mZFVdxepKuiKuvwBEBJ5xA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 04, 2019 at 03:38:54PM -0500, Eric Sunshine wrote:
> On Mon, Nov 4, 2019 at 3:36 PM Denton Liu <liu.denton@gmail.com> wrote:
> > On Mon, Nov 04, 2019 at 03:16:56PM -0500, Eric Sunshine wrote:
> > > On Mon, Nov 4, 2019 at 3:04 PM Denton Liu <liu.denton@gmail.com> wrote:
> > > > diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> > > > @@ -63,6 +63,15 @@ This is designed to be as compact as possible.
> > > > +* 'summary'
> > > > +
> > > > +         <abbrev hash> ("<title line>", <short author date>)
> > > > ++
> > > > +This format is useful for referring to other commits when writing a new
> > > > +commit message. Although by default, '<abbrev sha1>' is used, this can
> > >
> > > Why does this talk about "sha1" when patch 1/8 removed references to
> > > SHA-1 in favor of generic "hashes"?
> >
> > Good catch. 1/8 modified pretty-formats.txt but this message references
> > the content in SubmittingPatches.
> 
> I'm not sure what you mean. This change is touching
> pretty-formats.txt, not SubmittingPatches.

My mistake, you were referring to the patch text which is also indeed
incorrect. I skimmed your message too quickly and I thought you were
referring to the commit message which also references "sha1" but in the
context of SubmittingPatches.
