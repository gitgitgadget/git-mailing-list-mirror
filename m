Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D410720951
	for <e@80x24.org>; Fri, 17 Mar 2017 18:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbdCQSZ0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 14:25:26 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34731 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbdCQSZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 14:25:25 -0400
Received: by mail-pg0-f43.google.com with SMTP id 21so13925184pgg.1
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 11:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/oUYA239hv6jgyS3BO89Ogv5QoE0+1zmjcSaOPXvPTY=;
        b=oR6tT65uDKhU16GnAfTaMoWOd/UrPCiNV/bpdWOYTq8kYjjq3fp+pXl+7OE573pTmA
         VyNugDMa4ZFhdKql6F6ErK79BUE3BJzFG3+1U92ogsrNZLwvVl4abxZNmxA98Ttl+wZR
         vrK8vvwrcvjVUDMdUG89Yy1vXoqoCZeqQMCTsFXFzkAAp3a1hQAxxKEC1qre9H4FTa+e
         dVSsGNnCTfYket7WuGMtNIaD52hcPL+4EQWniBiYQPn/dk/jUofZgZllMDy719/s1nqI
         7oIuYLBWRJRd48WeIDEtiYELNWdICYqs4k3buWgB/elcxH+LzNpLPw6nrIE2Q9Wm4c4Y
         TRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/oUYA239hv6jgyS3BO89Ogv5QoE0+1zmjcSaOPXvPTY=;
        b=D2P6C2Vg9TqcqAP0yolO9xlQjcRLosI71P5XtBU9/SQkhfC0hHABqQEV19A8rLSeif
         1mg3hEOqSsgTq8gknxXbBDqQgAL4ZvkMkcrCXE0oFx3GvOCcXEKreTUbv5/RYQox5TzZ
         ovg1aImzCXARPMPY9Wo/nH3te8IWVOQWHFW9MHyPZwcSUe9Ya4zQtgZNAhd4rbWjG9b/
         aIPlbkP8RDHR+cbgmNJRdUK1wV6sWzMHhPaBn1KKY0YHs+LmIYmT3/wvNUu+wJBrx8W/
         qUvA59nB220uEkrBKHTiJ+eefzMgwV/jTWVIPz/ZU1VAgi5B2c71AsgL11VCvTpYdm0J
         dhSw==
X-Gm-Message-State: AFeK/H2Ga7M4Lphz8bG4PSsfvfWSV3aXDOVSdzlKfCvsccxSgnxVoqLIa1H8JR12CU7uvefU
X-Received: by 10.99.96.130 with SMTP id u124mr17332825pgb.216.1489775045579;
        Fri, 17 Mar 2017 11:24:05 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:c001:d329:ba91:25ca])
        by smtp.gmail.com with ESMTPSA id s13sm18162781pfd.46.2017.03.17.11.24.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 11:24:04 -0700 (PDT)
Date:   Fri, 17 Mar 2017 11:24:03 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rahul Bedarkar <rahul.bedarkar@imgtec.com>, git@vger.kernel.org
Subject: Re: [PATCH] grep: fix build with no thread support
Message-ID: <20170317182403.GA110341@google.com>
References: <1489729656-17709-1-git-send-email-rahul.bedarkar@imgtec.com>
 <xmqqy3w37ptd.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3w37ptd.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/17, Junio C Hamano wrote:
> Rahul Bedarkar <rahul.bedarkar@imgtec.com> writes:
> 
> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index 2c727ef..4373d79 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -183,11 +183,13 @@ static void *run(void *arg)
> >  		if (!w)
> >  			break;
> >  
> > -		opt->output_priv = w;
> > -		if (w->source.type == GREP_SOURCE_SUBMODULE)
> > +		if (w->source.type == GREP_SOURCE_SUBMODULE) {
> > +			opt->output_priv = &w->out;
> >  			hit |= grep_submodule_launch(opt, &w->source);
> > -		else
> > +		} else {
> > +			opt->output_priv = w;
> >  			hit |= grep_source(opt, &w->source);
> > +		}
> >  		grep_source_clear_data(&w->source);
> >  		work_done(w);
> >  	}
> 
> This is not a part of the "fix" but merely a code clean-up, right?
> Just double-checking.
> 
> > @@ -538,7 +540,7 @@ static int grep_submodule_launch(struct grep_opt *opt,
> >  	int status, i;
> >  	const char *end_of_base;
> >  	const char *name;
> > -	struct work_item *w = opt->output_priv;
> > +	struct strbuf *w = opt->output_priv;
> >  
> >  	end_of_base = strchr(gs->name, ':');
> >  	if (gs->identifier && end_of_base)
> 
> OK, so the new code points output_priv at a strbuf; work_item
> contains an "out" strbuf, and that was why the original code was
> passing one, but this codepath does not need a full work_item to
> work with.  Is that what is going on?
> 
> > @@ -593,10 +595,10 @@ static int grep_submodule_launch(struct grep_opt *opt,
> >  	 * child process.  A '0' indicates a hit, a '1' indicates no hit and
> >  	 * anything else is an error.
> >  	 */
> > -	status = capture_command(&cp, &w->out, 0);
> > +	status = capture_command(&cp, w, 0);
> 
> And this is consistent with the above change.
> 
> >  	if (status && (status != 1)) {
> >  		/* flush the buffer */
> > -		write_or_die(1, w->out.buf, w->out.len);
> > +		write_or_die(1, w->buf, w->len);
> 
> So is this.
> 
> >  		die("process for submodule '%s' failed with exit code: %d",
> >  		    gs->name, status);
> >  	}
> > @@ -641,19 +643,19 @@ static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
> >  	} else
> >  #endif
> >  	{
> > -		struct work_item w;
> > +		struct grep_source gs;
> >  		int hit;
> > +		struct strbuf outbuf = STRBUF_INIT;
> >  
> > -		grep_source_init(&w.source, GREP_SOURCE_SUBMODULE,
> > +		grep_source_init(&gs, GREP_SOURCE_SUBMODULE,
> >  				 filename, path, sha1);
> 
> Likewise for w.source that happened to have grep_source, but passing
> a bare grep_source is sufficient for the purpose of this codepath,
> without giving it to w.source?  
> 
> I didn't look at code that this patch does not touch, but if
> anything still looks at w.out and w.source and expect these to
> contain the string accumulated in the strbuf and the grep source the
> work item is working on, they will get broken by this change, no?
> 
> The first hunk that had a pure clean-up shows that w->source being
> the correct grep source seems to matter.
> 
> > -		strbuf_init(&w.out, 0);
> > -		opt->output_priv = &w;
> > -		hit = grep_submodule_launch(opt, &w.source);
> > +		opt->output_priv = &outbuf;
> > +		hit = grep_submodule_launch(opt, &gs);
> >  
> > -		write_or_die(1, w.out.buf, w.out.len);
> > +		write_or_die(1, outbuf.buf, outbuf.len);
> >  
> > -		grep_source_clear(&w.source);
> > -		strbuf_release(&w.out);
> > +		grep_source_clear(&gs);
> > +		strbuf_release(&outbuf);
> >  		return hit;
> >  	}
> >  }

Thanks for pointing out the bug (there seem to just be more and more in
this grep code...but what else can you expect from my first
contribution! :D) but I think it would be better to make the way the
recursive code output's more consistent with the way the rest of the
grep handles output.  That way we can get rid of some of the special
casing that I had done here.

I'll send out what I have locally in just a second.

-- 
Brandon Williams
