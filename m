From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Replace "git-" with "git " in *.[ch] comments and notifications
Date: Sat, 30 Aug 2008 12:08:03 +0200
Message-ID: <48B91C03.3000702@op5.se>
References: <20080829234751.GA2396@zakalwe.fi> <7vvdxj2ucl.fsf@gitster.siamese.dyndns.org> <20080830011509.GA16289@zakalwe.fi> <7vr6872qv1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Heikki Orsila <shdl@zakalwe.fi>,
	Heikki Orsila <heikki.orsila@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 12:09:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZNOI-0004Qu-Ev
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 12:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbYH3KIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 06:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbYH3KIF
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 06:08:05 -0400
Received: from mail.op5.se ([193.201.96.20]:53406 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbYH3KID (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 06:08:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id D2BAD1B800AF;
	Sat, 30 Aug 2008 12:13:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i2PYf0Qa6N+l; Sat, 30 Aug 2008 12:13:02 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 8CCF61B8008F;
	Sat, 30 Aug 2008 12:13:01 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <7vr6872qv1.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94370>

Junio C Hamano wrote:
> Heikki Orsila <shdl@zakalwe.fi> writes:
> 
>> On Fri, Aug 29, 2008 at 05:56:58PM -0700, Junio C Hamano wrote:
>> ...
>>> I do not think a single patch with the above hunk (which I think is a
>>> mistake) and other bits that are obviously good (e.g. the first hunk to
>>> builtin-apply.c we see below) is reviewable, but I cannot think of a
>>> better alterantive.  Sigh...
>> ...
>>> I did not look at the rest.
>> Is the concept OK for this change? I can submit another patch.
> 
> By "concept" if you mean the goal to stop implying to the end users as if
> it is a good practice to type (either from the command line or in their
> scripts) "git-foo" dashed form, the goal is obviously good.
> 
> I however am not sure if posting a single patch that is 1300 lines long
> would be the most effective way to achieve that goal.  Splitting them into
> a handful batches, spread over a few weeks to give reviewers some
> breathing room, might make it more reviewable.  I dunno.
> 
> Let's see hands; how many of you on git mailing list are willing to review
> a re-rolled series, when Heikki posts one?  How can we make it easier to
> apply "many eyeballs" to make the issue shallower?
> 

I've started doing the exact same thing, so I'll happily review some.

I'm currently fiddling with the linkgit asciidoc macro. Since I know
nothing of asciidoc macro syntax, it's very slow going and immensely
fun :)

> One thing you might be able to do would be to separate user visible
> strings and in-comment strings.  Frankly, when a comment talks about a git
> subprogram, blindly replacing s/-/ / makes it _far worse_ and the
> resulting text is harder to read for git hackers (who are primary
> audiences of comments).  E.g. taking one random example from your patch:
> 
> diff --git a/builtin-init-db.c b/builtin-init-db.c
> index baf0d09..81aa822 100644
> --- a/builtin-init-db.c
> +++ b/builtin-init-db.c
> @@ -37,7 +37,7 @@ static void copy_templates_1(char *path, int baselen,
>  
>  	/* Note: if ".git/hooks" file exists in the repository being
>  	 * re-initialized, /etc/core-git/templates/hooks/update would
> -	 * cause git-init to fail here.  I think this is sane but
> +	 * cause git init to fail here.  I think this is sane but
>  	 * it means that the set of templates we ship by default, along
>  	 * with the way the namespace under .git/ is organized, should
>  	 * be really carefully chosen.
> 
> I do not think this is an improvement.  We are talking about a single
> subprogram, not what the user types from the command line.  Either of
> these two would be easier to read:
> 
> 	... would cause git-init to fail here...
>         ... would cause "init" to fail here...
> 
> than:
> 
>         ... would cause git init to fail here...
> 
> Among these three, I think the second one is the most readable.  Perhaps
> dropping "git-" prefix when we are talking about a git subprogram, and
> quoting the word to make it stand out, could be a good approach , than
> replacing it with "git " prefix.

I concur.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
