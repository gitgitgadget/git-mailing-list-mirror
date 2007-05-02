From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Makefile: use --unsafe option under Cygwin with asciidoc
Date: Wed, 02 May 2007 09:56:06 -0700
Message-ID: <7vslaf4121.fsf@assigned-by-dhcp.cox.net>
References: <ejlze97d.fsf@cante.net> <46388CBE.1080605@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
X-From: git-owner@vger.kernel.org Wed May 02 18:56:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjI7g-0003lY-MZ
	for gcvg-git@gmane.org; Wed, 02 May 2007 18:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766758AbXEBQ4J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 12:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766768AbXEBQ4J
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 12:56:09 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:65401 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766758AbXEBQ4I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 12:56:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070502165607.DBXP1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 2 May 2007 12:56:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id uGw61W00Q1kojtg0000000; Wed, 02 May 2007 12:56:07 -0400
In-Reply-To: <46388CBE.1080605@byu.net> (Eric Blake's message of "Wed, 02 May
	2007 07:06:06 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46038>

Eric Blake <ebb9@byu.net> writes:

> According to Jari Aalto on 5/2/2007 5:49 AM:
>> New: variable ASCIIDOC_FLAGS was introduced. It was also added to two
>> new targets. The old ASCIIDOC_EXTRA is set to --unsafe under Cygwin to
>> ignore asciidoc error about unsafe include.
>
> This isn't just for cygwin, since it benefits any platform where the
> installed asciidoc is 8.1 or better (asciidoc is currently at 8.2.1 if you
> build the from tarballs).

What unsafe things do we include?  Maybe _that_ is what should
be fixed?

Also the last time we checked (I cannot take credits for this
work -- see "git show origin/todo:TODO" and look for
"AsciiDoc"), AsciiDoc 8 had backward compatibility problems, and
you needed to add some pragma in asciidoc.conf to make it
compatible with sources written for AsciiDoc 7 (i.e. our
documentation).  However, the pragma is not understood by older
asciidoc (and worse, makes older ones abort, as far as I
recall), so we cannot just add the pragma and use either
AsciiDoc 7 or 8 interchangeably.
