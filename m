From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: Unanticipated test error
Date: Fri, 21 Jul 2006 10:19:54 +0200
Message-ID: <20060721081954.GA29645@bohr.gbar.dtu.dk>
References: <20060720194013.GC24793@bohr.gbar.dtu.dk> <81b0412b0607210022o562ac326wd149c73cc529f239@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jul 21 10:20:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3qEz-0002Ne-2E
	for gcvg-git@gmane.org; Fri, 21 Jul 2006 10:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161013AbWGUIT4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Jul 2006 04:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbWGUIT4
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Jul 2006 04:19:56 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:1480 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S1161013AbWGUIT4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jul 2006 04:19:56 -0400
Received: (qmail 1378 invoked by uid 5842); 21 Jul 2006 10:19:54 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <81b0412b0607210022o562ac326wd149c73cc529f239@mail.gmail.com>
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24045>

On Fri, Jul 21, 2006 at 09:22:44AM +0200, Alex Riesen wrote:
...
> Well, there are differences. Correct translation from memcpy
> to strlcpy (aside the fact with \0 inside the string) would be
> something like:
> 
>  strlcpy(to, from, len + 1);
> 
> assuming your example with memcpy. strlcpy expects size of
> storage, and will never write more bytes that it was allowed to.
> That'll cut off last character of the source string, unless it is
> \0-terminated before the size of storage.

I see it now.  What I did was wrong.  Appending " + 1" to every
one of my calls makes the patch survive "make test".  However,
since strlcpy() calls strlen(from), it would have to be checked,
that 'from' is always NUL terminated.  The benefits of this patch
seem to shrink.

Thank you for your comment!

Peter
