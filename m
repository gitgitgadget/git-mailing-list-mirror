From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: verifying git file contents without checking out history?
Date: Mon, 19 Nov 2012 06:32:50 +0100
Message-ID: <1353303050-sup-4193@nixos>
References: <1353287836-sup-270@nixos> <7vtxsmxkcp.fsf@alter.siamese.dyndns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 19 06:34:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaJzf-0007h3-Qd
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 06:34:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715Ab2KSFcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 00:32:55 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:54857 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753709Ab2KSFcy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 00:32:54 -0500
Received: (qmail invoked by alias); 19 Nov 2012 05:32:51 -0000
Received: from p4FF8AC60.dip.t-dialin.net (EHLO mail.gmx.net) [79.248.172.96]
  by mail.gmx.net (mp071) with SMTP; 19 Nov 2012 06:32:51 +0100
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX19Ta6onfkxTz+noU05l7agzHy6VUQ/jImhq7kq73B
	XNQMcCOBtI+QFB
Received: by mail.gmx.net (sSMTP sendmail emulation); Mon, 19 Nov 2012 06:32:50 +0100
In-reply-to: <7vtxsmxkcp.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210041>


Excerpts from Junio C Hamano's message of Mon Nov 19 05:55:18 +0100 2012:
> Define what you mean by "contents".
contents = the files git archive HEAD would put into an archive, those
determining a build result.

How could the repo be compromised:
1) An attacker triest to find a hash collision in the HEAD tree.
  However finding a hash collision which also is a useful attack should
  be very hard.

2) The attacker modifies a file the way he likes (thus the attack is
  easy), then he tries to modify the history in a way causing the same 
  commit hash.
  Probably this is very hard, too.

Does this make sense? I feared that having a HEAD^ you can manipulate to
change the hash of HEAD makes it easier to cause a collision without the
user noticing. 
However adding additional useless files to HEAD could be used to cause a
imaginary hash collision, too. Thus having a second hash would not be of
any benefit. Thus referring to commit by hash (using all hash digits) is
best you can do. I finally got it.

Thanks
Marc Weber
