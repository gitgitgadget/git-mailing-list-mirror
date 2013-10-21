From: james.moger@gitblit.com
Subject: RFE: support change-id generation natively
Date: Mon, 21 Oct 2013 10:48:00 -0400
Message-ID: <1382366880.8925.36578285.27469B22@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 21 16:48:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYGm9-0004KH-JH
	for gcvg-git-2@plane.gmane.org; Mon, 21 Oct 2013 16:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293Ab3JUOsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Oct 2013 10:48:05 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38054 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752872Ab3JUOsE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Oct 2013 10:48:04 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 52FCE21DF8
	for <git@vger.kernel.org>; Mon, 21 Oct 2013 10:48:00 -0400 (EDT)
Received: from web5 ([10.202.2.215])
  by compute1.internal (MEProxy); Mon, 21 Oct 2013 10:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=gitblit.com; h=
	message-id:from:to:mime-version:content-transfer-encoding
	:content-type:subject:date; s=mesmtp; bh=Vi2qBY3PfOg0DVQXl4zKscO
	keZU=; b=fNCpheAa864Y8tVLu+1jJybqSL4Oe5DA+OGP3Q9MtPSDsYG/qq7e7fX
	ocYELbeA8eRqZIib3YVi4A3ctyr8j/sX+VkDDTPddJ4mPBg6bWEwHyfdf5G96Yrj
	DyWR+QPrgia4OQLm9LOTwRMLxUF8hC+ng3JcdUVTjJP4zvki7KDo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:from:to:mime-version
	:content-transfer-encoding:content-type:subject:date; s=smtpout;
	 bh=Vi2qBY3PfOg0DVQXl4zKscOkeZU=; b=JDz6GsWehOszjifP50huGApn1CYg
	KXb9XZsPShJ6EPuHoIW/p5g9Rkq+hAXkzDWzWg5qKz4Ywk9pwLh2iEQIO5Qdidmz
	pl+pZKg4IW/GT4YNyyYeq0WisCn/mhEiUA/LBTLk0tfP2ze5tEQ3tkmu8EyMuV3A
	OLTCSU9/e+ESEko=
Received: by web5.nyi.mail.srv.osa (Postfix, from userid 99)
	id 8B169A75A16; Mon, 21 Oct 2013 10:48:00 -0400 (EDT)
X-Sasl-Enc: 03Z+ipVxo+mitXIL1GjHWZdZBCAGKX7RY1bNykROrDre 1382366880
X-Mailer: MessagingEngine.com Webmail Interface - ajax-0cc2f9cc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236429>

Hello Git Community,

TL;DR:
It would be a really nice enhancement if the commit command natively
supported _optionally_ injecting a "Change-Id: I000..." footer in the
last paragraph of the commit message template and then substituting the
"I000..." value, on commit, with a generated value _without_ having to
rely on a per-repository, native hook or a global hook that affects
every local repository.

Full Request:
Gerrit has established the change-id footer as a prominent and
wide-spread collaboration identifier.  For those contributing new
patches to a Gerrit server, it is required to either use EGit/JGit
(Eclipse) to generate commits [1] OR to use a commit hook script with
native git to insert a change-id footer during the commit process [2]. 
This per-repository hook script requirement is an obstacle.  These
communities would be better served and it would lower the contribution
barrier for many open source projects if native git supported change-id
generation & injection.

I acknowledge that not everyone uses nor wants to use Gerrit and the
change-id footer.  That is fine, but it would be a _tremendous_
usability improvement for those contributing to open source projects
(myself included) if something like a "--change-id" flag  was
implemented and maybe even a config setting to always generate a
change-id on commit (EGit currently supports this as
"gerrit.createchangeid=true").

Sadly, my C skills are lacking as I live mostly in the world of managed
code, but I'd be very happy to cheer for a change-id champion; I suspect
there are some out there who might rally to this cause.

Thanks for your consideration.
James Moger
gitblit.com

[1]
https://git.eclipse.org/c/jgit/jgit.git/tree/org.eclipse.jgit/src/org/eclipse/jgit/api/CommitCommand.java?h=stable-3.1#n288
[2]
http://gerrit-documentation.googlecode.com/svn/Documentation/2.0/cmd-hook-commit-msg.html
