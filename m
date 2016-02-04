From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 00/20] refs backend rebase on pu
Date: Thu, 04 Feb 2016 17:44:03 -0500
Organization: Twitter
Message-ID: <1454625843.5545.20.camel@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
	 <1454443734.5545.1.camel@twopensource.com>
	 <xmqq7fimrcab.fsf@gitster.mtv.corp.google.com>
	 <xmqqmvrhjpzc.fsf@gitster.mtv.corp.google.com>
	 <1454548352.5545.2.camel@twopensource.com>
	 <56B2AF64.5020502@ramsayjones.plus.com>
	 <20160204025821.GA21105@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 23:44:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRSdM-000184-FU
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 23:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbcBDWoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 17:44:12 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33517 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932366AbcBDWoH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 17:44:07 -0500
Received: by mail-qk0-f177.google.com with SMTP id s5so27541576qkd.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 14:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=ShnNYFFX+Tu516mTPFmHKcPhPN9UpIW+DpXJxvqKxRY=;
        b=Vg/ezfqK0KZ/VMU/ggT6y9C98ETpSqtvwRkgutqM6GD5pLMXqpkJFdDExX8aZungW5
         B4MRVTdJbBnU+yJl88dx4nkNwZCObb7Vc6nMqjzzCZfLKoP6k1REY17vHr/y3wGuYQcK
         xBF5A7RDNs1LXwGs43SWA1KBv1ai2DtV7eOb9c2Pmz4fpgl/aXUVFvUauu/M2dxSu8bu
         BaQxs+TUze0ygL44vvCHi+O/8ydDS46av7RCO1WK6AKI/YpYWuyQb3bHE2gDrD/bvWm4
         wRLkO3VVSJicfLQuhH0hDpEDPmozuk5iXxp6oaoywLIHRniqd/9IJQMN8H8SLOaFWIb8
         KGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=ShnNYFFX+Tu516mTPFmHKcPhPN9UpIW+DpXJxvqKxRY=;
        b=A6iHK181LN3eKLu0K3SDJoWeNaQVlHWPHr3aYUlbAHl7UjJGAgvQIQaWyCNmtHESM8
         vnSfTSqLpriNpdF+HP+YbISqa/3JsFRQbuQocSqkMDbP5uRDF66X9GOu+0rjAKWR+xvY
         oGM/zUQboMibA++KdUXibMm4OXcofNijJkuYrlzBbDMq/bg+CoNmNC7aDx5zcgThtPpB
         o1WH1lPQOCZEV9n9wwzyu1YfWhvvhUCt4sgNyDSQdwY/V5RzXXDLc33nOKf1lil3WR0D
         x7imJ25c1TNO2XTRw6UZPp/8neDTvu0BDDp/bkSUUr4dzQVpX18u2Yb845/2UPSz5jCF
         PlGg==
X-Gm-Message-State: AG10YOQrsjPOoBavXP3XTaNSidBsYlVxvxOXZWwqtE0bxplWVll4WNmNvdrPwORLiDtmWQ==
X-Received: by 10.55.72.207 with SMTP id v198mr12731284qka.65.1454625846044;
        Thu, 04 Feb 2016 14:44:06 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id c190sm6305836qkb.27.2016.02.04.14.44.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Feb 2016 14:44:04 -0800 (PST)
In-Reply-To: <20160204025821.GA21105@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285513>

On Wed, 2016-02-03 at 21:58 -0500, Jeff King wrote:
> On Thu, Feb 04, 2016 at 01:54:44AM +0000, Ramsay Jones wrote:
> 
> > > They were working for me as-of the time I sent them.  I guess
> > > something
> > > must have broken since.  I'll rebase, test, and send a new
> > > series.
> > 
> > I didn't spend too long looking at it, but I think this interacts
> > with
> > Jeff's patch a2d5156c ("resolve_gitlink_ref: ignore non-repository
> > paths",
> > 22-01-2016) which introduces the new test in 't3000-ls-files
> > -others.sh'
> > which fails for me.
> > 
> > The change which Jeff made to resolve_gitlink_ref() is effectively
> > side-stepped
> > by the call to check_submodule_backend() in the new
> > resolve_gitlink_ref().
> > (Jeff's change is now in the 'files' backend version of
> > resolve_gitlink_ref()).
> 
> Yeah. The check_submodule_backend() function calls
> strbuf_git_path_submodule(), which unconditionally requires that the
> path be an actual submodule (the irony being that we are using it to
> find out whether we have a submodule!). So I don't think there's a
> conflict between our code, so much as that the new code has the same
> bug
> I fixed in a2d5156c (and we didn't notice earlier, because there was
> no
> test).
> 
> The solution in a2d5156 is to use is_nonbare_repository_dir() before
> assuming we have a submodule. I think check_submodule_backend() would
> want to do the same thing. This is the minimal fix:
> 
> diff --git a/refs.c b/refs.c
> index 3d4c0a6..7f86c49 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -313,9 +313,8 @@ static void check_submodule_backend(const char
> *submodule)
>  	if (!submodule)
>  		goto done;
>  
> -	strbuf_git_path_submodule(&sb, submodule, "%s", "");
> -
> -	if (!is_git_directory(sb.buf))
> +	strbuf_addstr(&sb, submodule);
> +	if (!is_nonbare_repository_dir(&sb))
>  		goto done;
>  
>  	strbuf_reset(&sb);

+ one other place, yeah, that does fix it.

> That gets the test passing. But I noticed a few other things, some
> related and some unrelated, while looking at this function:
> 
>   - in files_resolve_gitlink_ref, if we do find a submodule, we cache
>     the result with the ref_cache code. But here, we would read the
> .git
>     file repeatedly (and in fact, it happens twice per call, as
>     submodule_git_path has to read it itself).
> 
>     I don't know if it would be worth adding any kind of caching at
> this
>     layer.  It may be that we don't typically resolve more than one
> ref
>     (or do more than one for_each_ref iteration) for a submodule, so
> the
>     cache is pointless. I didn't implement it specifically in
> a2d5156,
>     it just came for free with the existing ref_cache code.

I'm going to punt on this for now; we can fix it if it becomes a
problem.

>   - check_submodule_backend knows whether we have a submodule at all
> and
>     is worth proceeding, but does not tell its callers. So we'll end
> up
>     in the backend files_resolve_gitlink_ref and make the same check.
>     It's probably worth moving this logic to the outer layer so each
>     backend doesn't have to implement it (and then the check in
>     files_resolve_gitlink_ref can actually go away).

Fixed, thanks.

  - for the common case of submodule==NULL (i.e., the main repository),
>     check_submodule_backend should be a noop, but it allocates and
> frees
>     the submodule_storage_backend string. Probably not a huge deal,
> but
>     it can be easily bumped down, and the first "goto done" turned
> into
>     a "return".

Fixed, thanks.

>   - if the submodule does have a backend configured, we leak the
> memory
>     for the default string. I think the submodule_backend() config
>     callback needs to free() the previous value.

Fixed.

>   - the config callback unconditionally dereferences "value", which
> will
>     segfault if the submodule's extensions.refstorage is a pure
> boolean
>     like:
> 
>         [extensions]
> 	refstorage

Fixed.

>     That should never happen, of course, but we should be checking
> and
>     dying for "!value" rather than segfaulting. Using
>     git_config_string() will do this for you.
> 
> Hope that helps.

Thanks!
