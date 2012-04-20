From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] push: introduce new push.default mode "simple"
Date: Fri, 20 Apr 2012 14:42:47 -0700
Message-ID: <xmqqy5pqkrl4.fsf@junio.mtv.corp.google.com>
References: <vpqfwbye9re.fsf@bauges.imag.fr>
	<1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<1334933944-13446-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Apr 20 23:43:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLLbd-0000LP-Bs
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 23:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242Ab2DTVmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 17:42:51 -0400
Received: from mail-wg0-f74.google.com ([74.125.82.74]:52601 "EHLO
	mail-wg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878Ab2DTVmu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 17:42:50 -0400
Received: by wgbdt11 with SMTP id dt11so536733wgb.1
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 14:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=kmLITvlcFP0ZFl9QbWjIAgf6p9pkGAyc5DeKfitLaNc=;
        b=AdpbeLQsyKHiNhhJLlieLyGltuxAyRnwE3O8sjdofJFQ8789ZN9DRgdFoTQd9oQgBY
         lT+aMYRhDYgIFz9pXIwDtDtjvggvG2Oo9K9KjJXt/cv69QzxyekiEaXHiTSxjQA0QTTy
         2XgY5u8erVkuWcfh7nMryj1dR3eJJ1D7w9H3wh0GfYugtwKyaW2esKxqGUAduRO5uNeY
         aA0x0VI3zPcdbxbnojGg+LZ4uiI7bhMr2rORi9sRWWt1j9fMgDhkERXNfR84b6VxRrgJ
         GllJfkCiuA+fS4AkodKPmoR032TOhhNN5kIYfBFJCHC3jzR/oeo0cfID4Ma/mglVoYY/
         bzVw==
Received: by 10.14.101.16 with SMTP id a16mr2219215eeg.0.1334958169132;
        Fri, 20 Apr 2012 14:42:49 -0700 (PDT)
Received: by 10.14.101.16 with SMTP id a16mr2219195eeg.0.1334958168927;
        Fri, 20 Apr 2012 14:42:48 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id a14si6427240een.0.2012.04.20.14.42.48
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 20 Apr 2012 14:42:48 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id B75CB2000E5;
	Fri, 20 Apr 2012 14:42:48 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 15E4EE120A; Fri, 20 Apr 2012 14:42:47 -0700 (PDT)
In-Reply-To: <1334933944-13446-3-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Fri, 20 Apr 2012 16:59:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmwIgl56rnBG1HudbRtk19umZ6rG4+YKFpfEo4O5g/POwNgwIyUp6x2nJE147iZBrDWvRtyidS/K2M6+JQlAfei1t+tqzu9kZvQYXR5jyURZ2fXqMDprePXxXsuN5pCTmWahQoYg6MfzBOPmYRRFyI+At2vXMT9bNsMQfT0oLuG6lUxZZk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196027>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Except for the broken-ness, this adds the last line in the warning message:

Hmm?  What brokenness?

> +		      "To chose either option permanently, read about push.default in git-config(1)\n"),

Nice ;-)

> diff --git a/cache.h b/cache.h
> index d8f6f1e..5e419a1 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -580,6 +580,7 @@ enum rebase_setup_type {
>  enum push_default_type {
>  	PUSH_DEFAULT_NOTHING = 0,
>  	PUSH_DEFAULT_MATCHING,
> +	PUSH_DEFAULT_SIMPLE,
>  	PUSH_DEFAULT_UPSTREAM,
>  	PUSH_DEFAULT_CURRENT,
>  	PUSH_DEFAULT_UNSPECIFIED

I think SIMPLE should come between CURRENT and UPSTREAM in the order of
logical progression, i.e. CURRENT < SIMPLE < UPSTREAM, because CURRENT
is appropriate in the simplest of workflow (you clone and get master and
devel branches, work on master and push it out to master, work on devel
and push it out to devel, without any need for @{upstream}), SIMPLE is a
bit more advanced (you can take advantage of @{upstream}), and CURRENT
would be the most advanced, in the "one branch at a time" camp.

> diff --git a/config.c b/config.c
> index 68d3294..024bc74 100644
> --- a/config.c
> +++ b/config.c
> @@ -837,7 +839,7 @@ static int git_default_push_config(const char *var, const char *value)
>  			push_default = PUSH_DEFAULT_CURRENT;
>  		else {
>  			error("Malformed value for %s: %s", var, value);
> -			return error("Must be one of nothing, matching, "
> +			return error("Must be one of simple, nothing, matching, "
>  				     "tracking or current.");

And this should match.  I think

	nothing, matching, current, simple or upstream.

would be more natural.
