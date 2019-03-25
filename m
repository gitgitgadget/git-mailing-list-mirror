Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D38E20248
	for <e@80x24.org>; Mon, 25 Mar 2019 11:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbfCYLjS (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 07:39:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50476 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfCYLjS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 07:39:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so8591518wmi.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 04:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FWERJbzG7LcNxFfwX8QI+mvQcYOnM7GFoBg5afcoWGA=;
        b=LhciZY/16zbz7BKys3ZN4uh675EoLfKicnMLyh2pel0vxtt4Pp7sXRaMT4DxkvwPWh
         thddOj+LwnQ/YGsgQkICgImfUPEU3MvJXUJc/lhxq9Hq2V+Xb5pKE4q/bUd+UTgzNhhd
         C71pJGJpgSswSXKHRmZu1n18tDFO8IroyWclzlovLZFaAz5X5neT1lw376EQgS8JjmQy
         AH9ca1SLwrGnGf0x7xWPhOB2ghqKXYQrpzyNGeX9+YG62wJ3NGYaRynPDiIHS56XRTBI
         KpwpbrzT8MpEVmcxBX+aGUqrDcakHdA3t200T23zHLkN5Bc0DkH5KZ4h5weUZytuCJEt
         RIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FWERJbzG7LcNxFfwX8QI+mvQcYOnM7GFoBg5afcoWGA=;
        b=NFGDl/Ii5qASGsUQ899V8l5YEn4B71hW+UE6C1DtuwsGMJLb2qRsmA3XixvkA4lt6x
         jzL+BKDcKfWEHkAJB72XyqjPT1pIrPRmwezf/ZoVG3u9LUITeEBnAJVmeyh5DoAty9ly
         VOhpVPV+vAXG6Wcxyjd7NQiw3r4dsTPca+7nAFEJfjYt2GbbROVuUKx1bzgBc4YwEwaz
         r1dg8W+VmefJAOlAarFSh4aA2jIq3tFxgF5gPXdA9ZpCjIbHEmT+3iJ3mka+x0rc52Eh
         R/yfIiTd8snHcLox/v2wE1BKYPvyZygVfg6CniQp+BNoUWlCSnVF1ulKnZcUuUQTuzcB
         L4Ig==
X-Gm-Message-State: APjAAAWqdqGjn+f5eH0egSMqxUMAMBu3zcalvI4jnmHZp8BPMCvT2+0E
        64qnJILdHEM7k6KBnebs3qM=
X-Google-Smtp-Source: APXvYqyG5gp71s27qycmbUjBtK9x9KUIhk80zAk0i4Wb/vEBYRnNYPYpgqc5KHGR/xDsgCnIQF5Vrg==
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr12088940wmj.18.1553513956258;
        Mon, 25 Mar 2019 04:39:16 -0700 (PDT)
Received: from szeder.dev (x4d0c296b.dyn.telefonica.de. [77.12.41.107])
        by smtp.gmail.com with ESMTPSA id b3sm18936105wrx.57.2019.03.25.04.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 04:39:15 -0700 (PDT)
Date:   Mon, 25 Mar 2019 12:39:13 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Luke Mewburn <luke@mewburn.net>
Subject: Re: [PATCH 2/5] progress: return early when in the background
Message-ID: <20190325113913.GL22459@szeder.dev>
References: <20190325103844.26749-1-szeder.dev@gmail.com>
 <20190325103844.26749-3-szeder.dev@gmail.com>
 <8736nbcitc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736nbcitc.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 12:08:47PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Mar 25 2019, SZEDER Gábor wrote:
> 
> > When a git process runs in the background, it doesn't display
> > progress, only the final "done" line [1].  The condition to check that
> > are a bit too deep in the display() function, and thus it calculates
> > the progress percentage even when no progress will be displayed
> > anyway.
> >
> > Restructure the display() function to return early when we are in the
> > background, which prevents the unnecessary progress percentae
> > calculation, and make the function look a bit better by losing one
> > level of indentation.
> >
> > [1] 85cb8906f0 (progress: no progress in background, 2015-04-13)
> 
> CC-ing the author of that patch.
> 
> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> > ---
> >  progress.c | 26 ++++++++++++++------------
> >  1 file changed, 14 insertions(+), 12 deletions(-)
> >
> > diff --git a/progress.c b/progress.c
> > index 02a20e7d58..b57c0dae16 100644
> > --- a/progress.c
> > +++ b/progress.c
> > @@ -86,28 +86,30 @@ static void display(struct progress *progress, uint64_t n, const char *done)
> >  		return;
> >
> >  	progress->last_value = n;
> > +
> > +	if (!is_foreground_fd(fileno(stderr)) && !done) {
> > +		progress_update = 0;
> > +		return;
> > +	}
> > +
> >  	tp = (progress->throughput) ? progress->throughput->display.buf : "";
> >  	eol = done ? done : "   \r";
> >  	if (progress->total) {
> >  		unsigned percent = n * 100 / progress->total;
> >  		if (percent != progress->last_percent || progress_update) {
> >  			progress->last_percent = percent;
> > -			if (is_foreground_fd(fileno(stderr)) || done) {
> > -				fprintf(stderr, "%s: %3u%% (%"PRIuMAX"/%"PRIuMAX")%s%s",
> > -					progress->title, percent,
> > -					(uintmax_t)n, (uintmax_t)progress->total,
> > -					tp, eol);
> > -				fflush(stderr);
> > -			}
> > +			fprintf(stderr, "%s: %3u%% (%"PRIuMAX"/%"PRIuMAX")%s%s",
> > +				progress->title, percent,
> > +				(uintmax_t)n, (uintmax_t)progress->total,
> > +				tp, eol);
> > +			fflush(stderr);
> >  			progress_update = 0;
> >  			return;
> >  		}
> >  	} else if (progress_update) {
> > -		if (is_foreground_fd(fileno(stderr)) || done) {
> > -			fprintf(stderr, "%s: %"PRIuMAX"%s%s",
> > -				progress->title, (uintmax_t)n, tp, eol);
> > -			fflush(stderr);
> > -		}
> > +		fprintf(stderr, "%s: %"PRIuMAX"%s%s",
> > +			progress->title, (uintmax_t)n, tp, eol);
> > +		fflush(stderr);
> >  		progress_update = 0;
> >  		return;
> >  	}
> 
> This patch looks good, just notes for potential follow-up:
> 
>  * Is the "is_foreground_fd(fileno(stderr))" case worth moving into
>    start_progress_delay() & setting a variable? It's a few C lib calls &
>    potential syscall (getpid(...)).

It depends on whether you consider the following case worth caring
about:

  $ git long-cmd
  <shows progress>
  Ctrl-Z!
  $ bg
  <silent>
  $ fg
  <shows progress>

Or:

  $ git long-cmd &
  <silent>
  $ fg
  <shows progress>

By moving the is_foreground_fd() check to start_progress_delay() and
caching its result, in the first case we would print progress even
after the process is sent to the background, while in the second we
wouldn't print progress even after the initially backgrounded process
is brought to the foreground.

I think the current behavior makes sense (though I'm not quite sure
about printing the final "done" line, as I think I would be annoyed if
it were printed from the background process while I was typing a
longer command... but I don't run git commands in the background in
the first place)

>  * Is that "|| done" part in the "progress_update" case something that
>    needs to happen? I.e. can we entirely skip the "setup signal handler"
>    part in start_progress_delay() if we detect that we're not in the
>    foreground, and then rely on the stop_progress() call to print the
>    "done"?

This, too, depends on how (or whether at all) we want to handle the
user sending the process to the background and bringing it back.

>    Although we set "progress_update = 1" in stop_progress_msg(), so it's
>    not *just* the signal handler but also us "faking" it, and we'd still
>    need to stash away "progress->last_value = n" in display() in that
>    backgrounding case.
> 
>    So maybe it's as simple as it's going to get.

