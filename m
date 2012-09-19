From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-blame.txt: --follow is a NO-OP
Date: Wed, 19 Sep 2012 12:36:56 -0700
Message-ID: <7vzk4lg5yf.fsf@alter.siamese.dyndns.org>
References: <20120906151317.GB7407@sigill.intra.peff.net>
 <1348022905-10048-1-git-send-email-n1xim.email@gmail.com>
 <7v627aiq47.fsf@alter.siamese.dyndns.org>
 <20120919182715.GF11699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <n1xim.email@gmail.com>,
	gitList <git@vger.kernel.org>, Matthieu.Moy@imag.fr,
	andy@aeruder.net, chriscool@tuxfamily.org,
	dmellor@whistlingcat.com, dpmcgee@gmail.com, fonseca@diku.dk,
	freku045@student.liu.se, kevin@sb.org, marius@trolltech.com,
	namhyung@gmail.com, rene.scharfe@lsrfire.ath.cx, s-beyer@gmx.net,
	trast@inf.ethz.ch
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 19 21:37:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEQ58-0007Cv-SC
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 21:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062Ab2ISThA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 15:37:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55323 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852Ab2ISTg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 15:36:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 507F69CBC;
	Wed, 19 Sep 2012 15:36:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DM9Adg71H7DwV03ytWLObmBBYjM=; b=UMVRB6
	1EhrLKzLWlJRg2hFSPVcJ9utxsua153aRlUu09zoLcE5lfqQcPtQMniyPl99KSwK
	mp8VY9xrW0ylWCyYuvaqXnyRd9fG+uAIjUQ3hi26s6ps5k36+gJ7k4grtuc5o08U
	k+Rlg+7P9Vt4pfLqKn4d+iNwIhh+YCjOlkJeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l5gvw7iEna/lTarIVw4igaeXxgaVn9La
	Sp1+xcZxu2e8na1mAlE+H0XdIEVaf/rkVrxKKD3ouroJOcM2uQe0pE+/ByoBc253
	C6LKpFLrWOqnv+OHdDcSVC2vqMkK1UYD0iuQcUnr9cDsjaUnRZB7pVojEwb9aPir
	3ALVBSWO2zI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A40C9CBB;
	Wed, 19 Sep 2012 15:36:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B4029CBA; Wed, 19 Sep 2012
 15:36:57 -0400 (EDT)
In-Reply-To: <20120919182715.GF11699@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 19 Sep 2012 14:27:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5FDA033C-0291-11E2-BA8B-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205982>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 18, 2012 at 09:38:32PM -0700, Junio C Hamano wrote:
>
>> That is a totally wrong message to send.  You failed to teach the
>> reader that there is no need to do anything special to tell the
>> command to follow per-line origin across renames.
>> 
>> So if anything, I would phrase it this way instead:
>> 
>>     --follow::
>>           This option is accepted but silently ignored.  "git blame"
>> 	  follows per-line origin across renames without any special
>> 	  options, and there is no reason to use this option.
>
> I think that is much better than Drew's text. But I really wonder if the
> right solution is to simply disallow --follow. It does not do anything,
> and it is not documented. There is no special reason to think that it
> would do anything, except by people who try it. So perhaps that is the
> right time to say "no, this is not a valid option".
>
> Like this (totally untested) patch:
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 0e102bf..412d6dd 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2365,6 +2365,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  			ctx.argv[0] = "--children";
>  			reverse = 1;
>  		}
> +		else if (!strcmp(ctx.argv[0], "--follow")) {
> +			error("unknown option `--follow`");
> +			usage_with_options(blame_opt_usage, options);
> +		}
>  		parse_revision_opt(&revs, &ctx, options, blame_opt_usage);
>  	}
>  parse_done:

This patch would not hurt existing users very much; blame is an
unlikely thing to run in scripts, and it is easy to remove the
misguided --follow from them.

So I am in general OK with it, but if we are to go that route, we
should make sure that the documentation makes it clear that blame
follows whole-file renames without any special instruction before
doing so.  Otherwise, it again will send the same wrong message to
people who try to use the "--follow" from their experience with
"log", no?
