From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-sh-setup.sh: make GIT_EDITOR/core.editor/VISUAL/EDITOR accept commands
Date: Wed, 01 Aug 2007 18:00:58 -0700
Message-ID: <7vhcni3g39.fsf@assigned-by-dhcp.cox.net>
References: <7v7iof3uc5.fsf@assigned-by-dhcp.cox.net>
	<S1752294AbXHAWCj/20070801220239Z+281@vger.kernel.org>
	<85ejimrjb2.fsf@lola.goethe.zz>
	<7vy7gu3kuh.fsf@assigned-by-dhcp.cox.net>
	<7vtzri3kpr.fsf@assigned-by-dhcp.cox.net>
	<85sl72x0x5.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 02 03:01:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGP3o-0002om-OF
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 03:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbXHBBBA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 21:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbXHBBA7
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 21:00:59 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:55566 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbXHBBA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 21:00:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802010057.BWKA14885.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 1 Aug 2007 21:00:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Wp0y1X00N1kojtg0000000; Wed, 01 Aug 2007 21:00:58 -0400
In-Reply-To: <85sl72x0x5.fsf@lola.goethe.zz> (David Kastrup's message of "Thu,
	02 Aug 2007 01:58:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54508>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> It is not just "won't apply".  What if GIT_DIR had spaces (which
>>> is fine) and single-quotes in it?  Wouldn't it percolate down to
>>> $@ because it becomes the leading directory of the temporary
>>> file name?  And you quote '"$@"' and eval it, now what happens?
>>
>> Ah, I spoke too fast.  It is fine --- the shell that actually is
>> doing the eval then interpolates "$@".  Clever.
>
> Since eval folds all its arguments into a single string separated by
> single blanks, actual blanks (which can be multiple or interspersed
> with newlines) must not yet be seen.  The string '"$@"' contains no
> blanks and thus gets through unmolested.

Yup.  I just misread the code.

Thanks, applied.
