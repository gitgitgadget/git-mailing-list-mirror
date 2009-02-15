From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC - draft] List of proposed future changes that are backward
 incompatible
Date: Sun, 15 Feb 2009 13:31:50 -0800
Message-ID: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 22:33:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYocE-0001IB-Tz
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 22:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859AbZBOVcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 16:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753817AbZBOVcA
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 16:32:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43974 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbZBOVb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 16:31:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 51D599AB30;
	Sun, 15 Feb 2009 16:31:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B16B69AB2F; Sun,
 15 Feb 2009 16:31:52 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 139CF4A0-FBA8-11DD-8DF8-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110059>

Here is a draft; please discuss items that are already on the list to
improve their wording, and propose changes you would want to add to the
list, so that I can send the final message out when I tag v1.6.2-rc2.

I originally considered to Cc: mailing list addresses of various projects
that use git when sending out the final message, but I do not think it is
practical, as I suspect some/many are subscriber only (and I am not, and
would not want to be, a subscriber to them).

So instead, I'd like people from the projects that use git to forward the
final message to the mailing lists they belong to, and we would want some
coordination among volunteers to avoid duplicated forwards.

Somebody, please volunteer to keep a list of <project name, volunteering
forwarder> tuples.  It might be a good idea to create a new page that is
linked from http://git.or.cz/gitwiki/GitProjects for that purpose.

Thanks.

-- >8 -- cut here -- >8 --

To: git@vger.kernel.org
Subject: [RFC/WARNING] Proposed future changes that are backward incompatible

Here is a list of possible future changes to git that are backward
incompatible that are under discussion on the git mailing list.

None of them will be in the upcoming 1.6.2 release, but some of them are
likely to appear in future versions.  If you think we should not introduce
some of the listed changes, here is a chance to voice your opinions and
make a convincing argument against them, so please do so.  Many people
complained about the removal of many git-foo commands from user's PATH,
which was done in 1.6.0 based on user input, after it happened.  You do
not want to see such a mess happen again.

Thanks.

* git-push to update the checked out branch will be refused by default

  Make "git push" into a repository to update the branch that is checked
  out fail by default.

  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007

* git-push to delete the current branch will be refused by default

  Make "git push $there :$killed" to delete the branch that is pointed at
  by its HEAD fail by default.

  http://thread.gmane.org/gmane.comp.version-control.git/108862/focus=108936

* git-send-email won't make deep threads by default

  Many people said that by default when sending more than 2 patches the
  threading git-send-email makes by default is hard to read, and they
  prefer the default be one cover letter and each patch as a direct
  follow-up to the cover letter.

  http://article.gmane.org/gmane.comp.version-control.git/109790

* make core.quotepath=false the default

  By default, "git diff" output quotes bytes in pathnames with high bit
  set, primarily to avoid corruption during e-mail based transfer.  This
  however is inconvenient for human readers, and also makes some poorly
  written user scripts that do not unquote them fail.  Change the default
  so that they are not quoted (note that control characters such as HT are
  always quoted).

  http://thread.gmane.org/gmane.comp.version-control.git/110033
