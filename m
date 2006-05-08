From: Junio C Hamano <junkio@cox.net>
Subject: Re: Implementing branch attributes in git config
Date: Mon, 08 May 2006 02:00:17 -0700
Message-ID: <7vody8howu.fsf@assigned-by-dhcp.cox.net>
References: <1147037659.25090.25.camel@dv>
	<Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
	<Pine.LNX.4.64.0605071718440.3718@g5.osdl.org>
	<Pine.LNX.4.63.0605080303410.13588@wbgn013.biozentrum.uni-wuerzburg.de>
	<1147051300.17371.32.camel@dv>
	<Pine.LNX.4.63.0605080327490.13794@wbgn013.biozentrum.uni-wuerzburg.de>
	<1147053329.17371.52.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 11:00:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fd1bS-0003xG-U6
	for gcvg-git@gmane.org; Mon, 08 May 2006 11:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWEHJAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 05:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWEHJAU
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 05:00:20 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:16349 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750873AbWEHJAS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 05:00:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060508090018.CBQT25692.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 May 2006 05:00:18 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1147053329.17371.52.camel@dv> (Pavel Roskin's message of "Sun,
	07 May 2006 21:55:29 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19760>

Pavel Roskin <proski@gnu.org> writes:

> On Mon, 2006-05-08 at 03:27 +0200, Johannes Schindelin wrote:
>> > Now, how can I get a description for the "netdev" branch by one
>> > git-repo-config command, without pipes?
>> 
>> 	git-repo-config --get branchdata.description ' for netdev$'
>
> No, it doesn't remove "for netdev".  What I really don't like is that
> git-repo-config treats it as "not my problem".

Stating what you do not like about something is a good first
step to improve that something.  It should not be too hard to
extend the parser to grok:

	repo-config --get branchdata.description '\(.*\) for netdev$'

and when the value_regex has a capture return what matches
instead of the entire value.  I think that would do what you
want.
