From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] Strange patch formats (aka tricks with unified diffs)..
Date: Sat, 14 Apr 2007 02:55:13 -0700
Message-ID: <7vbqhrb7r2.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704121436050.4061@woody.linux-foundation.org>
	<17951.6252.457936.428919@cargo.ozlabs.ibm.com>
	<46a038f90704122307i76f96029n75425410bc40ad82@mail.gmail.com>
	<7v3b34hjdh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704141051350.18846@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 14 11:55:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hceyn-0004gp-Q1
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 11:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182AbXDNJzQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 05:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754198AbXDNJzP
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 05:55:15 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:42328 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182AbXDNJzO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 05:55:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070414095513.OCPE1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 14 Apr 2007 05:55:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id mxvD1W0081kojtg0000000; Sat, 14 Apr 2007 05:55:13 -0400
In-Reply-To: <Pine.LNX.4.64.0704141051350.18846@racer.site> (Johannes
	Schindelin's message of "Sat, 14 Apr 2007 10:59:44 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44455>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 12 Apr 2007, Junio C Hamano wrote:
>
>> [...] the --color-words (whose implementation I happen to hate) [...]
>
> I know that we talked about it previously. And strictly, I think it is not 
> the implementation that you hate, but the rules that were implemented.
>
> I'll have a look at what you wrote back then, and try to come up with some 
> sensible alternatives, so you don't have to hate the code so much.

One sensible behaviour would be to show exactly the same output
lines as the regular output, but color-code only the words that
changed.  E.g (the words are capitalized to illustrate instead
of colored here):

        diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
        index 6a5fcfd..535214c 100644
        --- a/Documentation/git-cvsserver.txt
        +++ b/Documentation/git-cvsserver.txt
        @@ -125,7 +131,7 @@ By default it uses SQLite databases in the git directory, named
         temporary files in the same directory as the database file on
         write so it might not be enough to grant the users using
         git-cvsserver write access to the database file without granting
        -them ALSO write access to the directory.
        +them write access to the directory, TOO.

         You can configure the database backend with the following
         configuration variables:
