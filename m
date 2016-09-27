Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 393F220986
	for <e@80x24.org>; Tue, 27 Sep 2016 20:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935813AbcI0Udn (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 16:33:43 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33843 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934047AbcI0Udl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 16:33:41 -0400
Received: by mail-pa0-f49.google.com with SMTP id gp7so8947298pac.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 13:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IezSQyUvzvx65JsLxtGrlpeSqVar+aUUsjOjU7v4280=;
        b=Bp5evUdFYNzgEX/vbQJJVOFx343wjpsZaIFpyhiOZc/ku0WSGpXrofefp8RkYsF9y5
         GOqIJljoJYCPlsC413d/Nw1TGHqnAOLWMI506CwcbCnFqGyF6nJ7AkTA35lsmkWthp7y
         1e7eae/9DPmQDSlhu+cJfb2JwQVi2X5ntJKdHnGW6xi43RwHR7o52+0LpiBFxvHDT/oD
         qFx0doPb/uENHIGMSm+1fqmj5wPuRpevZd+tPxW0aQALi/UfSVdYqvXnHHafLCMH/ONF
         EwAwIzbpNFPdbIyG1MCryVwAjI3uUSvbgmIMep7PQPNp0f0x6SAC6W9yqodcMVinAkYJ
         Y2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IezSQyUvzvx65JsLxtGrlpeSqVar+aUUsjOjU7v4280=;
        b=C+Ojtwv2TeJbA+9FaJcjptdx8mjmTjDCiwYqBPAfMMZek1xeZTF2DR7G9VxTrTZbFj
         /ziP4Gm98VuEkrf5LJZ1t3K9z2ecY3mgn9+jHtsoNWEy2pHKcdpwO5yCO0DmmV3oBig2
         GMhR7HqygiA99y7Ou2ygPzfakC8cz+CUjS4jNJc9mHF17HJRgtfogFAJk2M18ZAtIzf0
         NBr2hQBnJALSaDjLkDgWHZJ7ko+570p/NEzec+iHonWJ9l/tEAwYQaAcc8TocdXj2vWJ
         H6KaRk62HkW5LwIHDtUulkau+eAPw08ZZCKXgSq2llgaNAT9zpQOwYiU9UVrACGm4wzT
         GteQ==
X-Gm-Message-State: AE9vXwNBoZlIMa5/ibfhmJNQ4jJV/CVh4c1RkAaup/JfGlI5a+Ghiw03m7bZvA7AeraOGuKv
X-Received: by 10.66.119.136 with SMTP id ku8mr51005529pab.6.1475008420503;
        Tue, 27 Sep 2016 13:33:40 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:3959:5f82:1885:1644])
        by smtp.gmail.com with ESMTPSA id t5sm6940102pfi.26.2016.09.27.13.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2016 13:33:39 -0700 (PDT)
Date:   Tue, 27 Sep 2016 13:33:38 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4 v4] ls-files: optionally recurse into submodules
Message-ID: <20160927203338.GB32565@google.com>
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
 <1474930003-83750-1-git-send-email-bmwill@google.com>
 <1474930003-83750-3-git-send-email-bmwill@google.com>
 <xmqqlgydnqlh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlgydnqlh.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> > +static const char *submodule_prefix;
> 
> I would have expected this to added to environment.c in the previous
> step, but it is OK--I'd imagine you'd grab this from the environment
> and carrying a piece of information from git.c to here by setenv()
> followed by getenv() feels somewhat roundabout, though.

If it would make sense to do the caching of prefix string in
environment.c I can move it there and add a get_submodule_prefix()
function which either reads the envvar or the cached value if its
already been read.  Would that be a better route?

> 
> >  static const char *prefix;
> >  static int max_prefix_len;
> > @@ -68,6 +71,21 @@ static void write_eolinfo(const struct cache_entry *ce, const char *path)
> >  static void write_name(const char *name)
> >  {
> >  	/*
> > +	 * NEEDSWORK: To make this thread-safe, full_name would have to be owned
> > +	 * by the caller.
> 
> As Peff mentioned in his review in another thread, a large number of
> functions in git are not reentrant, and I do not think we would want
> to give the impression that those missing a warning are safe to use.
> 
> Other than that, this step looks OK.  3/4 and later would be a lot
> more fun to review ;-)

Oh yes, I can remove the comment.  Seemed to miss that bit while
rerolling the series.

-- 
Brandon Williams
