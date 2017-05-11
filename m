Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C16B20196
	for <e@80x24.org>; Thu, 11 May 2017 17:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933394AbdEKRgJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 13:36:09 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35022 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933348AbdEKRgI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 13:36:08 -0400
Received: by mail-pg0-f45.google.com with SMTP id f131so3228374pgc.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 10:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VxdD5HcjYdGeqAmfCq2d3lSn1qmdPDEcoNDHyvExJTA=;
        b=GWRyzqqQbB9Wa4B57GfXz4r7y10jPyt27ooom+KUmVALJh5CtRdBppOoECJNkj/XA3
         ENV1xSPCRQoqw5T+DrMGe5SJZXsbXA5A6z2o/8YkEHiNKowB0cgnX0yyMi2EMbk5xMjC
         2M8e+lXMWp15fjkqic5luQs+OHH3corQdvpYc3EBMYA0y2dgECAdi5joXlB77cddaHtr
         RS2WQfbUDq5iZmx29FaqiFD+QBfbOk23GgGojGAqj0jkCoXD0uji41J/N6A7mIuMWmzP
         VtGqjqrxcPyx8ixc0WpzYoJOLFyaGIV+GcCuUWI05u/+pJsoRS0ceABzD3+oxH9ErH1E
         g7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VxdD5HcjYdGeqAmfCq2d3lSn1qmdPDEcoNDHyvExJTA=;
        b=JezP/XN2J8wA9nYGXjpLtC6tFOhlg2jNAZn3S6nbF/dMMkUf29NEouaHIM6L6Ja8Es
         EdZ0JrmIIJc0Uh5Fo3DPKirJo9EZDuZpdN0fWFgIHXky4KoNa+a9prCW9I7OC+wR5Dnt
         Xdg4PS8Un/GFfobGiCaZdoGZd+Zhh6XneOIyL1wCWAix+8T2sUvJ0lBYs1UqK7sKzqWW
         4F1evMmMFo2xxL2k7VkcQlbVBBfyYRAorBuLz56k76Rmqco3Z0ebrYU+R8aQwJYhlara
         7tiTQZV8FpdJG3tNJaxGN+0t3chZNmmsotsaBgPf2o1Jgv11STtmzR0Rokc1E8lEKjne
         evww==
X-Gm-Message-State: AODbwcCoEtYsTlMcb3/L/2LAPtsMJKBBUpF7tlF2aW9hkBt9Tc7Br15+
        r964hE82LJNkT5o1LZe9hQ==
X-Received: by 10.84.178.131 with SMTP id z3mr291394plb.175.1494524168095;
        Thu, 11 May 2017 10:36:08 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:938:3d1d:44aa:d816])
        by smtp.gmail.com with ESMTPSA id n5sm1242077pfa.78.2017.05.11.10.36.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 10:36:07 -0700 (PDT)
Date:   Thu, 11 May 2017 10:36:05 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 8/8] pathspec: convert parse_pathspec to take an index
Message-ID: <20170511173605.GB83655@google.com>
References: <20170509191805.176266-1-bmwill@google.com>
 <20170509191805.176266-9-bmwill@google.com>
 <xmqq1srxxn72.fsf@gitster.mtv.corp.google.com>
 <20170510170226.GB41649@google.com>
 <xmqqh90sw4dr.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh90sw4dr.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/11, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > ls-files is the only command (that I know of) which does cache pruning
> > based on the common prefix of all pathspecs given.  If there is a
> > submodule named 'sub' and you provided a pathspec 'sub/', the matching
> > logic can handle this but the cache pruning logic would prune all
> > entries from the index which don't have a leading 'sub/' which is the
> > common prefix of all pathspecs (if you didn't strip off the slash).
> > Meaning you'd prune the submodule 'sub' when  you really didn't want to.
> > This could probably be fixed to have the cache pruning logic to prune by
> > ignoring the trailing slash always.
> >
> > So there's another option here if you don't feel quite right about
> > piping through an index into parse_pathspec just yet.
> 
> Oh, don't get me wrong---I do not think passing an index_state
> instance throughout the callchain (and perhaps later we may pass an
> instance of "repository" instead) is a wrong move in the longer term
> for various APIs.  I was just wondering if we have callers that can
> benefit from this change immediately---manipulators like "commit" do
> already use multiple instances of index_state structure.

I didn't get the feeling you thought it was a bad change.  I really
appreciate your thoughts since they are things which I also was
wondering about.

> But perhaps you are right---it may be wrong for the contents of the
> current index (or any index) to affect how a pathspec element is
> parsed in the first place.  If the current code (before this series)
> uses the_index only for error checking, we may want to separate that
> out of the parse_pathspec() callchain, so that it does not even look
> at any index (not just the_index).  And that may be a better change
> overall.

I'll polish up the other version of the series which does the processing
(using an index) outside of parse_pathspec() and let you see how you
feel about those changes.  Note that if we go with the route to not pass
in an index now, it doesn't necessarily mean that down the line we won't
have to pass a 'repository' instance into parse_pathspec().  Just food
for thought.

-- 
Brandon Williams
