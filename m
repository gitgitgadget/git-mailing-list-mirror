Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C572E1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 08:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbfKHIu3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 03:50:29 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40258 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfKHIu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 03:50:28 -0500
Received: by mail-pg1-f194.google.com with SMTP id 15so3548744pgt.7
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 00:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HsP8yWfoIrPoNj1jgYfem69TOkRIpDfhNTF3WmKqwI8=;
        b=U50fkrqIcvpRYh/+cYsKfUz7+gauWtLRydQ6wwqwWCrsmvPbegb/z2hRhbXNBWJO/H
         F4+jzl/c8sjpkb1u2HH9QJW7aHS7gLJz8KBj1MFc/Z8nzvfVMuQB62B1NTCSHVtcNrZr
         EKYSf3QY6yw0mA5EqvbsAWK8EmjRLUqPPGE7KPKm/cIRZy5n1TlPh/iK925H5NHuRwVX
         QSNj8us6r7PLkavE61QadmyBvtIDPrba1MEa99ja8/3jt8t/yqIZ4y0gtbQA0kjKavom
         VyuNGK/bMXqL9TxUf29lKIzVbz5kcZpzdyDRuRgFjsxZE5HZaFHVVMbVRSVqBY2FfU6c
         abDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HsP8yWfoIrPoNj1jgYfem69TOkRIpDfhNTF3WmKqwI8=;
        b=gYB8DQ2yVRu1uFBJiaUTOPqADUOiKyIAGB+qnwnSocM9J0SlWjEnoPS2pfnrvi9+0U
         5hkShcKANJxfqCDzBbKBt2eeOV6yHc6MYbXAKCXKEOQ12X9jCBwEEZKmnN3Gn+uktlz8
         Bi4TkFxbPW6cesx223VM/yHKkrMjmFwk5igiso5hhJKYeF/lwT3Q+MNaBgNCHzEVjkUs
         S7gyb7EWZ7JjEDGSkEQuo0sxh9OEdtqynF3N+nDnnsoK8cWf3yWXSqjyPwzBOXvjBuWC
         PGHrVYYLVq0L+BQRlLzlWs0R7wtuIT2xyY3RTCjl5zqqLvAie3RUwyX+mXDtg2mHo6+b
         BQUQ==
X-Gm-Message-State: APjAAAWvLbktzU2Zm+R9BPtFJn2PCC3PVOwv9wOozkpN35zIoWtxcpWl
        BDt5maBL2JmzNVaG/oSETZtNl9Ea
X-Google-Smtp-Source: APXvYqyB9fGAA0wfr1a/EOO8b5P7YPlZ0ZMG/6/9nEMXNYayli1KOvphNPgvLNpxPD694RPgpiiQaQ==
X-Received: by 2002:aa7:8e15:: with SMTP id c21mr10561521pfr.122.1573203027710;
        Fri, 08 Nov 2019 00:50:27 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id x2sm5331754pfn.167.2019.11.08.00.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 00:50:26 -0800 (PST)
Date:   Fri, 8 Nov 2019 00:50:24 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/8] reflog-walk.c: don't print last newline with oneline
Message-ID: <20191108085024.GA26530@generichostname>
References: <cover.1572897736.git.liu.denton@gmail.com>
 <449c58009ae46d43ec2bd0499674c9858b706d04.1572897736.git.liu.denton@gmail.com>
 <xmqqwocdtwpa.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwocdtwpa.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Nov 06, 2019 at 02:12:17PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > Subject: Re: [PATCH 6/8] reflog-walk.c: don't print last newline with oneline
> 
> Please find a better phrasing that does not mislead the readers to
> think "eek, so now output from 'git log -g --oneline' does not get
> LF terminated?"
> 
> I think you are just changing the place where the LF is given from
> the callee that shows a single record (and then used to show LF
> after the record) to the caller that calls the callee (and now it
> shows LF after the call returns), in order to preserve the output,
> but with the given proposed log message, it is not clear if that is
> what you meant to do (I can read from the code what _is_ going on,
> but the log is to record what you _wanted_ to do, which can be
> different).

Yep, I'll reword the subject line.

> 
> > @@ -661,8 +661,10 @@ void show_log(struct rev_info *opt)
> 
> In the pre-context before this line there is a guard to ensure that
> we do this only when showing an entry from the reflog, so the effect
> of this hunk is "when showing from reflog in --oneline format, show
> LF after showing a single record" ...
> 
> >  					    opt->commit_format == CMIT_FMT_ONELINE,
> >  					    &opt->date_mode,
> >  					    opt->date_mode_explicit);
> > -			if (opt->commit_format == CMIT_FMT_ONELINE)
> > +			if (opt->commit_format == CMIT_FMT_ONELINE) {
> > +				putc('\n', opt->diffopt.file);
> >  				return;
> > +			}
> >  		}
> >  	}
> >  
> > diff --git a/reflog-walk.c b/reflog-walk.c
> > index 3a25b27d8f..e2b4c0b290 100644
> > --- a/reflog-walk.c
> > +++ b/reflog-walk.c
> > @@ -285,7 +285,11 @@ void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
> >  		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
> >  		get_reflog_selector(&selector, reflog_info, dmode, force_date, 0);
> >  		if (oneline) {
> > -			printf("%s: %s", selector.buf, info->message);
> > +			struct strbuf message = STRBUF_INIT;
> > +			strbuf_addstr(&message, info->message);
> > +			strbuf_trim_trailing_newline(&message);
> > +			printf("%s: %s", selector.buf, message.buf);
> > +			strbuf_release(&message);
> 
> ... and this one is what gets called from the above caller; we lost
> the final LF (if there is) from the output, that is compensated by
> the caller.

Yep, thats correct.

> 
> How well do we work with the "-z" output format, by the way, with
> the hardcoded '\n' on the output codepath?

From my tests, `-z` plays well with my changes. I'll add some tests to
be sure, though.

> 
> Making a new allocation feels inefficient just to omit the trailing
> newlines.  I wonder if a helper function that takes a "const char *"
> and returns a "const char *" in that string that points at the CRLF
> or LF or NUL at its end would be warranted.  If we do not care about
> CRLF, this part would become something like...
> 
> 	if (oneline) {
> 		const char *endp = strchrnul(info->message, '\n');
> 		printf("%s: %.*s", selector.buf,
> 			(int)(endp - info->message), info->message);
> 	}

Yep, I think that this works. In fact, we can probably just do

 	if (oneline) {
 		const char *endp = strchrnul(info->message, '\n');
		int len = strlen(info->message);
		if (len > 0)
			len--;
 		printf("%s: %.*s", selector.buf,
 			len, info->message);
 	}

because...

> but I didn't trace the code/data flow to see where info->message
> comes from well enough to tell if we need to worry about CRLF.  I
> thought reflogs are always written with LF termination, though.

I think that you are right. Reflogs are always written with LF
termination. This can be seen in get_reflog_message():

	void get_reflog_message(struct strbuf *sb,
				struct reflog_walk_info *reflog_info)
	{
		struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
		struct reflog_info *info;
		size_t len;

		if (!commit_reflog)
			return;

		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
		len = strlen(info->message);
		if (len > 0)
=>			len--; /* strip away trailing newline */
		strbuf_add(sb, info->message, len);
	}

> 
> Thanks.
