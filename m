From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rename dirlink to gitlink.
Date: Mon, 21 May 2007 16:32:51 -0700
Message-ID: <7vodkdbvmk.fsf@assigned-by-dhcp.cox.net>
References: <20070521200828.GC5412@admingilde.org>
	<e7bda7770705211612w3ce1b7dew8d48f1ddeb7d100e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Martin Waitz" <tali@admingilde.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Torgil Svensson" <torgil.svensson@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 01:33:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqHN6-0004fW-Dh
	for gcvg-git@gmane.org; Tue, 22 May 2007 01:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756906AbXEUXcy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 19:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756925AbXEUXcx
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 19:32:53 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:59502 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756906AbXEUXcx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 19:32:53 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070521233252.RFU15717.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 21 May 2007 19:32:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1zYr1X00L1kojtg0000000; Mon, 21 May 2007 19:32:52 -0400
In-Reply-To: <e7bda7770705211612w3ce1b7dew8d48f1ddeb7d100e@mail.gmail.com>
	(Torgil Svensson's message of "Tue, 22 May 2007 01:12:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48063>

"Torgil Svensson" <torgil.svensson@gmail.com> writes:

> On 5/21/07, Martin Waitz <tali@admingilde.org> wrote:
>> Unify naming of plumbing dirlink/gitlink concept:
>>
>> perl -pi -e 's/dirlink/gitlink/g' -e 's/DIRLNK/GITLINK/g'
>> ---
>
> Does this mean that the link doesn't necessarily has to be represented
> as a directory (even though current code does it) ?

I do not think the patch has that much deep meaning.

Personally I think the patch is similar to renaming "cache" used
in the code to "index" --- needless code shuffling that does not
buy you anything.

As an internal symbol, S_IFDIRLNK makes _much_ more sense than
S_IFGITLINK, exactly because it is a mixture of S_IFDIR and
S_IFLNK.

The only excuse that we _might_ want to consider the patch is
that S_IFDIRLNK has not lived that long, compared to the use of
word "cache" in our codebase.  It's only two weeks old -- so if
we were to apply this patch, we would need to do that right
away, or it will be never.

But I am not _so_ enthused about the renaming in the code.
