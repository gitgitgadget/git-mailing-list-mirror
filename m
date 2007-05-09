From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add --aggressive option to 'git gc'
Date: Wed, 09 May 2007 13:19:54 -0700
Message-ID: <7v4pmlu4ut.fsf@assigned-by-dhcp.cox.net>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
	<11786309073709-git-send-email-tytso@mit.edu>
	<11786309072612-git-send-email-tytso@mit.edu>
	<11786309071033-git-send-email-tytso@mit.edu>
	<Pine.LNX.4.64.0705090056231.18541@iabervon.org>
	<7v3b26xvjo.fsf@assigned-by-dhcp.cox.net>
	<20070509194839.GB10280@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed May 09 22:20:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlse4-0005if-Tm
	for gcvg-git@gmane.org; Wed, 09 May 2007 22:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754984AbXEIUT4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 16:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757493AbXEIUT4
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 16:19:56 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:55002 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757255AbXEIUTz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 16:19:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509201954.DJMO13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 16:19:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id x8Ku1W00D1kojtg0000000; Wed, 09 May 2007 16:19:54 -0400
In-Reply-To: <20070509194839.GB10280@thunk.org> (Theodore Tso's message of
	"Wed, 9 May 2007 15:48:39 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46781>

Theodore Tso <tytso@mit.edu> writes:

> On Wed, May 09, 2007 at 01:15:07AM -0700, Junio C Hamano wrote:
>> > Maybe git-gc should have an option for "compress hard"? It seems to me 
>> > like a two-sizes-fit-all solution would be good here; "git gc" for daily 
>> > use, and "git gc --squeeze" for when you want to make the result as small 
>> > as possible, with compute time not being a major factor.
>> 
>> I think that sounds saner and more user friendly than specific
>> knob to tune "window", "depth" and friends which are too
>> technical.  It has an added attraction that we can redefine what
>> exactly "hard" means later.
>
> OK, here's a patch that does exactly that.  I choose git-gc
> --aggressive, since I thought that was more descriptive than --hard or
> --squeeze.  Junio, would you be willing to apply this?

Willing?  Yes.

It's tricky that it defaults to 10 and still called aggressive.
When the configuration variable is left unspecified, the only
reason it is called aggressive is because it passes '-f' to
repack, right?  It was not very clear at the first sight and I
was about to ask why the default is 10, not higher.
