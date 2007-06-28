From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Ignore end-of-line style when computing similarity score for  rename detection
Date: Thu, 28 Jun 2007 01:16:37 -0700
Message-ID: <7vejjwo5ne.fsf@assigned-by-dhcp.pobox.com>
References: <46831F70.2060403@midwinter.com>
	<20070628024603.GA1534@midwinter.com>
	<4683619A.F753C97E@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 10:16:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3pBD-0005Am-4H
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 10:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761278AbXF1IQk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 04:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761138AbXF1IQj
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 04:16:39 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:41673 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760791AbXF1IQi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 04:16:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070628081637.URDF6565.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Jun 2007 04:16:37 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GwGd1X00F1kojtg0000000; Thu, 28 Jun 2007 04:16:38 -0400
In-Reply-To: <4683619A.F753C97E@eudaptics.com> (Johannes Sixt's message of
	"Thu, 28 Jun 2007 09:22:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51088>

Johannes Sixt <J.Sixt@eudaptics.com> writes:

> Steven Grimm wrote:
>> 
>> Signed-off-by: Steven Grimm <koreth@midwinter.com>
>> ---
>> Okay, let's try this again with an MUA that won't change my tabs to
>> spaces -- sorry about that.
>> 
>> A couple of source files got checked into my code base with DOS-style
>> end-of-line characters. I converted them to UNIX-style (the convention
>> for this project) in my branch. Then later, I renamed a couple of them.
>> 
>> Meanwhile, back in the original branch, someone else fixed a bug in one
>> of the files and checked it in, still with DOS-style line endings.
>> 
>> When I merged that change into my branch, git didn't detect the rename
>> because the fact that every line has a change (the end-of-line
>> character) dropped the similarity score way too low.
>> 
>> This patch teaches git to ignore end-of-line style when looking for
>> potential rename candidates. A separate question, which I expect may be
>> more controversial, is what to do with conflict markers; with this
>> patch, the entire file is still marked as in conflict if the end-of-line
>> style changes (but it's still an improvement in that we at least detect
>> the rename now.)
>
> I think that nobody would object to have a use-case description like
> this in the commit message...

Oh, yeah.  100% agreed.
