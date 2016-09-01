Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A2A01F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 15:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755543AbcIAPRO (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 11:17:14 -0400
Received: from mout.gmx.net ([212.227.17.22]:55101 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755044AbcIAPRN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 11:17:13 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lwnem-1azoIk3jxI-016NT9; Thu, 01 Sep 2016 17:17:07
 +0200
Date:   Thu, 1 Sep 2016 17:17:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/34] sequencer (rebase -i): add support for the 'fixup'
 and 'squash' commands
In-Reply-To: <1472718808.4680.19.camel@kaarsemaker.net>
Message-ID: <alpine.DEB.2.20.1609011658300.129229@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>  <5488a031ffe14373b7434d497b7fd2f2e5fe55bd.1472633606.git.johannes.schindelin@gmx.de> <1472718808.4680.19.camel@kaarsemaker.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Dkrt+v0kM8xNJn9I0PeeX/WzUz9ri+9ZErtLajX5IL61xzYBi3w
 qjMDpkXo/af30cLPlgJAqMY2AFi1sZ31GF8aHkdluhJ3HawAiQvXlzQUwvTegfmL7Ztw5Oy
 RQ5qArvRE9cukdYxfDAOnqbnRAVoh+1WN2cuo2ZoWAxq+x1Q6BS6+07uy+mZ1Tfe/kMjkP0
 kOoPyYQape4crjuWEFKvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k40Oq74kMpU=:QFxphCI3LuR4tj6sLCfTP6
 Q1dub17iqwwsg+yf+SUQpdjwuzU6u3PcdXT8ysFQJ4c7ST4c0nZTCFG6uu/NBaqwxnV62510C
 KT1dCkftn2A79f9nu9aDYL34yT46pxctguHvNdlI+APPbAdl1r+NTH3OO8rkbzC/4Ld9wPDDW
 e3GHko13yYlbHhK0xZG1iARMM65rjT0/kaeQ2n7TvRhlIz4fPvpIvDbYvdx+oWbsQJ7wv4H8U
 njzX6+2I1mmCWLK3GkHYJWuyU7t17NLZouhAWAP+Jzc6tV34SR+qMIJ01le1CsuwsDS7YZmhh
 ogxdWR1A05Q970yblRDMUj/Hcjl0F51rQcyR2ne3vhDpggIlOqcuujRyrlPAOS56ZTaxiYixj
 cug3ZlBrntyuDwnvfAclwgFyR2n+/VXAqXFs4/e7S4h7iwNT+6xYyltp8bU3/T3W0hJFFEemt
 gs8/qlV5fyChLIgFiJboz6NBc9rSNx6HCChbIJWfGfG4rKWCdBqIPlrK+RSB0w3LGCwVu0Yyg
 7ql5IcU7JznVOXlUjobsixzmvOupqCPjKXTldJWu7ZATHg1xJba80RrOoxqEPTtHmxIYZMT8K
 3nKQM59j16T02pj3JJwXb9l3Qw5EgsGoY6b8uET3DudXCm8a+qZooMQgQHbyrcqjR3l7cPoNv
 F3kRAqg5CeFyO7NCs7VMe7vGh2LVJqc3LKUQMgf72XDCYA8EURwPELjyfqx3LdHcyO+GsZBuu
 2BSJp+nKu3FDiN9Y3OYs4NTtX8iG+XRLY+kICER6gSkCRnbpJoJgfeHCFjPhzHhzorVgVKIJ+
 /EqPcwD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dennis,

On Thu, 1 Sep 2016, Dennis Kaarsemaker wrote:

> On wo, 2016-08-31 at 10:54 +0200, Johannes Schindelin wrote:
> 
> > +static int is_fixup(enum todo_command command)
> > +{
> > +	return command == TODO_FIXUP || command == TODO_SQUASH;
> > +}
> 
> It sounds wrong to have a function named is_fixup return true when the
> command isn't a fixup but a squash. Maybe name it
> changes_previous_commit or something?

I can see how that may sound confusing, unless you understand that a
squash is a fixup that lets the user edit the commit message, too. So
essentially squash = fixup + edit, if you will.

Maybe the name is more appropriate in that light?

> > +static const char *nth_for_number(int n)
> > +{
> > +	int n1 = n % 10, n10 = n % 100;
> > +
> > +	if (n1 == 1 && n10 != 11)
> > +		return "st";
> > +	if (n1 == 2 && n10 != 12)
> > +		return "nd";
> > +	if (n1 == 3 && n10 != 13)
> > +		return "rd";
> > +	return "th";
> > +}
> 
> >8---
> 
> > +	if (command == TODO_SQUASH) {
> > +		unlink(rebase_path_fixup_msg());
> > +		strbuf_addf(&buf, "\n%c This is the %d%s commit message:\n\n%s",
> > +			comment_line_char,
> > +			count, nth_for_number(count), body);
> > +	}
> > +	else if (command == TODO_FIXUP) {
> > +		strbuf_addf(&buf,
> > +			"\n%c The %d%s commit message will be skipped:\n\n",
> > +			comment_line_char, count, nth_for_number(count));
> > +		strbuf_add_commented_lines(&buf, body, strlen(body));
> > +	}
> 
> This way of handling numbers is not translatable, and I really think we
> should mark these strings for translation, like they are in the .sh
> version.

Ah, this is the risk of working on something as big as rebase--helper.
Back when I started with it, the relevant code in git-rebase--interactive
read like this:

	nth_string () {
		case "$1" in
		*1[0-9]|*[04-9]) echo "$1"th;;
		*1) echo "$1"st;;
		*2) echo "$1"nd;;
		*3) echo "$1"rd;;
		esac
	}

I merely did a faithful translation of that...

Now, I see that git-rebase--interactive was switched to use eval_gettext,
which in turn is handled in git-sh-i18n whose code is quite convoluted. In
the absence of gettext, it uses git-sh-i18n--envsubst, which has no C API
whatsoever.

And I see that the beautiful ordinal computation was given up in favor of
a lousy "#1", "#2", "#3", etc (it used to be "1st", "2nd", "3rd" etc).

In any case, translation is not my main concern until v2.10.0, so I'll
take care of this after that release.

Ciao,
Dscho
