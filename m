From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Optimized cvsexportcommit: calling 'cvs status' only once instead of once per changed file.
Date: Thu, 10 May 2007 00:08:44 -0700
Message-ID: <7vd519m9z7.fsf@assigned-by-dhcp.cox.net>
References: <0056A63A-D511-4FDD-82A6-A13B06E237E9@zib.de>
	<200705092230.16027.robin.rosenberg.lists@dewire.com>
	<380B28A3-5CD0-4371-A717-1D2629E6302D@zib.de>
	<46a038f90705092353x107c738foa7db547ab29b1748@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Steffen Prohaska" <prohaska@zib.de>,
	"Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 09:08:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm2le-0001av-CO
	for gcvg-git@gmane.org; Thu, 10 May 2007 09:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbXEJHIq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 03:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752658AbXEJHIq
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 03:08:46 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:39335 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbXEJHIp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 03:08:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510070845.TRCR2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 10 May 2007 03:08:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xK8k1W0081kojtg0000000; Thu, 10 May 2007 03:08:44 -0400
In-Reply-To: <46a038f90705092353x107c738foa7db547ab29b1748@mail.gmail.com>
	(Martin Langhoff's message of "Thu, 10 May 2007 18:53:51 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46833>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On 5/10/07, Steffen Prohaska <prohaska@zib.de> wrote:
>> I'll post a patch soon that takes the best of both: Call cvs status
>> once with the list of touched files and parse the output. Only one
>> connection is needed and only the minimal amount of status data is
>> transferred.
>
> Yes, please :-) I wrote cvsexportcommit originally, and use it on a
> huge cvs checkout that is hosted on SF.net (slow!). My commits are
> small (3~5 files). I agree with using only one connection so commits
> with many files are sanity-checked faster, but status needs to ask
> explicitly about the files it's about to touch.
>
> cheers,

Sounds like you are perfect guinea pig.  A test in the real-life
use followed by an Ack is very appreciated.
