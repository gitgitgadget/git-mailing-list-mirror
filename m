From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv7 2/9] gitweb: uniform author info for commit and commitdiff
Date: Sat, 27 Jun 2009 11:38:28 -0700
Message-ID: <7vskhlikt7.fsf@alter.siamese.dyndns.org>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1246104305-15191-2-git-send-email-giuseppe.bilotta@gmail.com>
	<1246104305-15191-3-git-send-email-giuseppe.bilotta@gmail.com>
	<200906271810.23119.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 20:38:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKcnN-0004Y9-86
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 20:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbZF0Si2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 14:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbZF0Si1
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 14:38:27 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:46835 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbZF0Si0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 14:38:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090627183829.IPVF25927.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 27 Jun 2009 14:38:29 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 96eV1c0024aMwMQ046eVwQ; Sat, 27 Jun 2009 14:38:29 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=boqP4a8FSW4A:10 a=pGLkceISAAAA:8
 a=A1X0JdhQAAAA:8 a=nlT8ApQr69qcW-Z8gdkA:9 a=BIDQC-Jy8VvqPzKoomMA:7
 a=frsTvg_tKKljMOG3I0-vHoe8u8YA:4 a=MSl-tDqOz04A:10 a=Y6qChIQXU1wA:10
X-CM-Score: 0.00
In-Reply-To: <200906271810.23119.jnareb@gmail.com> (Jakub Narebski's message of "Sat\, 27 Jun 2009 18\:10\:22 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122379>

Jakub Narebski <jnareb@gmail.com> writes:

> I would use:
>
>   Switch from form similar to the one used by 'log' view
>
>   	A U Thor <email@example.com> [date time]
>
>   to the form used in 'commit' view
>
> 	author       A U Thor <email@example.com>
>   	 	     date time
>   	committer    C O Mitter <other.email@example.com>
>   	             date time
>
> (i.e. use spaces and not tabs to align).  But this is minor
> issue, not worth worrying about IMVHO.

These extra blank lines make things much easier to read, and explicit
mention of switching from WHAT to WHAT ELSE is very much appreciated.

> On the other hand side IIRC 'commitdiff' uses short (one-line) 
> authorship info because the main point is the diff, and multi-line
> author and commit info like the one used in 'commit' view takes
> a bit of vertical space.

In general, we might want to make the committer information less prominent
than it currently is.

When looking at a repository that is used like CVS, author and committer
are always the same.  When looking at a repository that is owned by a
single integrator, the committer is a single person.  The only time
committer information for every commit would help is when viewing a
repository of higher level integrator in a project that has subintegrators
(e.g. Linus pulls from David who commits patches from others).

So at some point, it may not be a bad idea to introduce a per-repository
option/feature to hide committer information from certain views to
allocate more space for other information.

But certainly that shouldn't be a part of this topic.
