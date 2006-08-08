From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Tue, 08 Aug 2006 13:18:10 -0700
Message-ID: <7voduvugl9.fsf@assigned-by-dhcp.cox.net>
References: <200608071626.52655.jnareb@gmail.com>
	<7v3bc82v7l.fsf@assigned-by-dhcp.cox.net> <eb8cdh$s6n$1@sea.gmane.org>
	<7v4pwo1a0r.fsf@assigned-by-dhcp.cox.net> <eb8e12$2aa$1@sea.gmane.org>
	<7vejvsyum8.fsf@assigned-by-dhcp.cox.net> <eb9m30$3ef$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 08 22:18:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAY1o-0007Oc-29
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 22:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWHHUSN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 16:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWHHUSM
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 16:18:12 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:38559 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S964951AbWHHUSM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 16:18:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060808201811.CMKP27846.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Aug 2006 16:18:11 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eb9m30$3ef$2@sea.gmane.org> (Jakub Narebski's message of "Tue,
	08 Aug 2006 11:38:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25086>

Jakub Narebski <jnareb@gmail.com> writes:

> `git-ls-remotes .` is suspiciously missing from the examples.

Because the point of show-refs was not to replace it only for
the local case.

> Format needs to somewhat incorporate line for referencing object for that, 
> if it exists.

Also I do not think you would want "ref^{}" style dereferencing
ls-remotes does for gitweb anyway.

What gitweb might want is "what type of object is this tag
pointing at" and "what is the object pointed at by this tag"
(both used on "Tags" list).  I think show-refs specification
allows you to do that inexpensively.

> Wouldn't it be better to (re)use notation of rpm's --query-format, 
> i.e. use %{name}, or %30{name}, or %-30{name} for single scalar values,
> use :typetag output formats,...

I did not do them because these enhancements are not needed to
unblock you from optimizing git_get_* calls in gitweb.  These
enhancement can come later as long as the initial syntax is
simple, clean and extensible enough, which I think it is.
