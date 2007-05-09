From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add --no-reuse-delta option to git-gc
Date: Wed, 09 May 2007 01:15:07 -0700
Message-ID: <7v3b26xvjo.fsf@assigned-by-dhcp.cox.net>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
	<11786309073709-git-send-email-tytso@mit.edu>
	<11786309072612-git-send-email-tytso@mit.edu>
	<11786309071033-git-send-email-tytso@mit.edu>
	<Pine.LNX.4.64.0705090056231.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Ts'o <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed May 09 10:15:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlhKN-0007Kb-OZ
	for gcvg-git@gmane.org; Wed, 09 May 2007 10:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbXEIIPL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 04:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753107AbXEIIPL
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 04:15:11 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:44169 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbXEIIPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 04:15:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509081508.IIRW1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 04:15:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id wwF81W0031kojtg0000000; Wed, 09 May 2007 04:15:08 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46678>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Tue, 8 May 2007, Theodore Ts'o wrote:
>
>> This allows the user to regenerate the deltas in packs while doing
>> a git-gc.  The user could just run git-repack -a -d -f -l after
>> running git-gc, but then the first git-repack run by git-gc is
>> a bit of waste.
>
> Maybe git-gc should have an option for "compress hard"? It seems to me 
> like a two-sizes-fit-all solution would be good here; "git gc" for daily 
> use, and "git gc --squeeze" for when you want to make the result as small 
> as possible, with compute time not being a major factor.

I think that sounds saner and more user friendly than specific
knob to tune "window", "depth" and friends which are too
technical.  It has an added attraction that we can redefine what
exactly "hard" means later.
