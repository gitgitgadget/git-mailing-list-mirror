From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bug: git-rebase goofs up \n in commit messages
Date: Fri, 25 May 2007 23:13:21 -0700
Message-ID: <7v3b1knmda.fsf@assigned-by-dhcp.cox.net>
References: <465750FE.9000406@iii.hu>
	<20070526004028.GA8940@sigill.intra.peff.net>
	<20070526011036.GA4169@gondor.apana.org.au>
	<20070526034236.GA18169@coredump.intra.peff.net>
	<7vps4onps0.fsf@assigned-by-dhcp.cox.net>
	<20070526060748.GA20715@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Szekeres Istvan <szekeres@iii.hu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 26 08:13:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrpWq-00069m-EU
	for gcvg-git@gmane.org; Sat, 26 May 2007 08:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbXEZGNX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 02:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbXEZGNX
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 02:13:23 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:60659 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbXEZGNW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 02:13:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070526061322.XLBR22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 26 May 2007 02:13:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3iDM1X00D1kojtg0000000; Sat, 26 May 2007 02:13:22 -0400
In-Reply-To: <20070526060748.GA20715@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 26 May 2007 02:07:48 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48453>

Jeff King <peff@peff.net> writes:

> On Fri, May 25, 2007 at 09:59:43PM -0700, Junio C Hamano wrote:
>
>>  * I suspect we would declare either "war on echo" or "harder push
>>    for builtins" triggered by these.
>
> Cry havoc! More fixes below (just a diff -- maybe we want to aggregate
> these into a single commit?).
>
> These are the ones I noticed that use commit messages (which are
> probably the most likely to use backslash). There are _tons_ of uses for
> heads and filenames. I think we either should stop with commit messages,
> or go all-out and simply remove all uses of echo (because there are
> literally hundreds otherwise).
>
>> -		echo "$commit_only" |
>> +		printf "%s\n" "$commit_only" |
>
> Is "\n" portable to all shells (i.e., do you need '\n')? It works with
> bash and dash, which are by far the most common, but who knows what evil
> lurks in the heart of Sun?

Gaah, you are right.
