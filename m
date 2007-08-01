From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff on touched files: bug or feature?
Date: Wed, 01 Aug 2007 12:07:04 -0700
Message-ID: <7vvebz3wh3.fsf@assigned-by-dhcp.cox.net>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<87vebzkrid.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 21:08:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGJYK-0000PQ-MQ
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 21:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759738AbXHATHI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 15:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758699AbXHATHI
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 15:07:08 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:45953 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803AbXHATHG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 15:07:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070801190706.COTU23215.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 1 Aug 2007 15:07:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Wj751X0021kojtg0000000; Wed, 01 Aug 2007 15:07:05 -0400
In-Reply-To: <87vebzkrid.fsf@wine.dyndns.org> (Alexandre Julliard's message of
	"Wed, 01 Aug 2007 21:02:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54466>

Alexandre Julliard <julliard@winehq.org> writes:

> .... For
> instance in vc-git.el the workfile-unchanged-p function currently has
> to rehash the file every time to see if it really changed, because we
> can't afford to refresh the whole project at that point.

Maybe I am missing something.  Why can't you "afford to"?

"update-index --refresh" looks at only the files whose cached
stat information does indicate there might be chanegs.  It does
not rehash already up-to-date ones.
