From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: bugfix: a.list formatting regression
Date: Tue, 22 Aug 2006 15:34:52 -0700
Message-ID: <7vr6z8mmb7.fsf@assigned-by-dhcp.cox.net>
References: <20060822085540.1104.qmail@web31812.mail.mud.yahoo.com>
	<11562409683011-git-send-email-jnareb@git.vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Aug 23 00:35:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFepo-0002Sw-8Z
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 00:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWHVWey (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 18:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWHVWey
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 18:34:54 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:55264 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751337AbWHVWex (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 18:34:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060822223453.MLCK29796.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Aug 2006 18:34:53 -0400
To: Jakub Narebski <jnareb@git.vger.kernel.org>
In-Reply-To: <11562409683011-git-send-email-jnareb@git.vger.kernel.org> (Jakub
	Narebski's message of "Tue, 22 Aug 2006 12:02:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25878>

Jakub Narebski <jnareb@git.vger.kernel.org> writes:

> From: Jakub Narebski <jnareb@gmail.com>
>
> Fix regression introduced by
> commit 17d07443188909ef5f8b8c24043cb6d9fef51bca.
>
> "a.list" being "bold", makes a myriad of things shown by
> gitweb in bold font-weight, which is a regression from
> pre-17d07443188909ef5f8b8c24043cb6d9fef51bca behavior.
>
> The fix is to add "subject" class and use this class
> to replace pre-format_subject_html formatting of subject
> (comment) via using (or not) <b>...</b> element. This
> should go back to the pre-17d0744318... style.
>
> Regression noticed by Luben Tuikov.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
> ---

I haven't seen an Ack from Luben for the proposed renaming of
the class, although I very much like naming things for what they
mean (i.e. "subject"), not what they do (i.e. "bold") myself.

It might be worthwhile to do a full sweep of the pages we
generate and identify what classes we would want.  I have a
feeling that we overuse a.list for example -- they are all in
some form of list alright but they might benefit from a bit
finer logical separatoin.  One list is enumaration of refs and
another is a chronological sequence of commits.

Then people who would want to tweak the presentation would have
an easier time changing only gitweb.css.
