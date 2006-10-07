From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC PATCH] Add WEBDAV timeout to http-fetch.
Date: Sat, 07 Oct 2006 15:24:10 -0700
Message-ID: <7vvemvpxx1.fsf@assigned-by-dhcp.cox.net>
References: <20061006212616.GA5175@lumumba.uhasselt.be>
	<20061006220542.GA5890@lumumba.uhasselt.be>
	<BAYC1-PASMTP08A34A8FB0703E4D2ABAF9AE130@CEZ.ICE>
	<BAYC1-PASMTP11CF83A008B0B3BA5F6B15AE100@CEZ.ICE>
	<7viriwsa75.fsf@assigned-by-dhcp.cox.net>
	<20061007193559.GA27920@poseidon.issaris.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org,
	Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Sun Oct 08 00:24:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWKaq-0001vz-9U
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 00:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWJGWYN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 18:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWJGWYN
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 18:24:13 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:16791 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750922AbWJGWYM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 18:24:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061007222411.OSAN13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Oct 2006 18:24:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XaQD1V00f1kojtg0000000
	Sat, 07 Oct 2006 18:24:14 -0400
To: Panagiotis Issaris <takis.issaris@uhasselt.be>
In-Reply-To: <20061007193559.GA27920@poseidon.issaris.org> (Panagiotis
	Issaris's message of "Sat, 7 Oct 2006 21:35:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28512>

Panagiotis Issaris <takis.issaris@uhasselt.be> writes:

>> > Maybe the real solution is just to figure out and fix whatever is
>> > going on with the WEBDAV server and forget this patch.
>> 
>> I think it is prudent to protect the client from a broken server
>> and it is independent from "fixing" the server side.  It would
>>[...]
> Wouldn't most users ctrl-c the program before the two minute timeout occurs?
> Especially since their appears to be nothing happening?

I think we are talking about the same thing -- after you kill it
with C-c you would want to work it around.  The question is how?

You would want to re-run with timeout value of 0 second (or
WEBDAV disabled, if we can have such an option); if it works
then you would want the tool to remember that you want to use
that particular settings but probably only when talking to that
remote.
