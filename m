From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC 1/2] Use remote information in .git/config
Date: Tue, 22 Nov 2005 01:49:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511220139120.6187@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511211452470.13775@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4q65sst3.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511212109440.4213@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vhda5lf4t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 01:50:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeMM0-00030C-PR
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 01:49:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVKVAtf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 19:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVKVAtf
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 19:49:35 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:9926 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964809AbVKVAte (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 19:49:34 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A5E6613FFED; Tue, 22 Nov 2005 01:49:33 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8791B9F3B1; Tue, 22 Nov 2005 01:49:33 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 735118E9C2; Tue, 22 Nov 2005 01:49:33 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 64AF213FFED; Tue, 22 Nov 2005 01:49:33 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhda5lf4t.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12512>

Hi,

On Mon, 21 Nov 2005, Junio C Hamano wrote:

> Once we start thinking about allowing the template mechansim to
> give default "config" information to newly created repositories,
> having everything in one file may make things a bit awkward to
> handle.  When you managed to make your colleage interested in
> git development, you can let her copy your remotes/junio.  Once
> you moved remotes/ to .git/config file, while you would not want
> her to use copy of your .git/config verbatim without updating at
> least user.name, you would want to have her use other pieces in
> the .git/config, including [remote.jnio] bits.

Well, obviously I would patch git-fetch/-pull/-push to have an option 
("--store") to store the current parameters under a certain nick name in 
the config ;-)

Or add a little option (which is easy) to generate commands which can be 
piped into a little script (think "xmodmap -pke").

> The following comments are not about your patch but I am having
> a feeling that we ended up having too much flexibility.  It may
> not necessarily be a bad thing when we view git as pure
> plumbing, but it makes things confusing to have too many "you
> could do it this way if you want to gain XXX, as long as you are
> careful about YYY".

I wouldn't be so sad about the flexibility. It is an open source project, 
and the strength therein lies in many people having many (yes, even 
stupid) ideas, and trying to get them in. In the long run, the dumb ideas 
are thrown out, but what remains is a collection of gems.

So, it might be confusing for a noobee, but that's what we have 
Documentation/tutorial for.

> Most of the time, what we recommend are the BCP, but
> knowledgeable users can deviate from that, to gain some
> advantage (e.g. reduced disk space using an incomplete
> repository, convenience of having more than one checked-out
> trees at the same time, not having to migrate to all UTF-8
> system) over the BCP if they are willing to sacrifice something
> else or their use pattern is not affected negatively by what
> they are losing (e.g. can live without an access to ancient
> history, be very careful when pruning and fetching, do not have
> people whose names cannot be spelled in KOI-8).

'xactly. For example, I can do

	ln -s .gitgrafts .git/info/grafts

and have the effect that Linus just called "nasty". Point is, if I choose 
to do so, I can. Easily.

Ciao,
Dscho
