From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC - draft #2] List of proposed future changes that are backward
 incompatible
Date: Sun, 15 Feb 2009 18:42:50 -0800
Message-ID: <7vskmff6fp.fsf@gitster.siamese.dyndns.org>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 03:44:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYtT4-0007ol-AI
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 03:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755546AbZBPCm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 21:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755527AbZBPCmz
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 21:42:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36552 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754996AbZBPCmz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 21:42:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F1AB52B385;
	Sun, 15 Feb 2009 21:42:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 25C882B384; Sun,
 15 Feb 2009 21:42:52 -0500 (EST)
In-Reply-To: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 15 Feb 2009 13:31:50 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 82A8937E-FBD3-11DD-9CEC-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110114>

Let's scrap the first thread and try again, this time a bit more careful
wording, so that premature and unwanted discussions would not cloud out
what really needs to happen in response to this request.

Here is a draft of a message I am preparing to send out around 1.6.2-rc2
is tagged to this mailing list, and mailing list of the projects that use
git to track their changes, to announce possible future changes that may
affect the users in a backward incompatible way, and solicit comments.

I am asking three things now from the readership:

 - For items that are already on the list, help improve the way the
   planned/proposed changes are explained.  Discussion on the desirability
   of the change itself is NOT WELCOME in this thread.  That is for the
   discussion that follows the final version of this document.

 - If a change, that was discussed on this list recently and saw general
   consensus that such a change is desirable, is missing from this
   document, please send in updates in a similar format as you see below.

 - If your favourite project that uses git is not listed in:

   http://git.or.cz/gitwiki/ProjectContacts

   or it does not have "Forwarder" field filled in, please add the project
   with an appropriate address for the message to be sent.

   Be careful NOT to list a mailing list address that non-subscribers
   cannot send messages to.  For such mailing lists, we need to find a
   subscribed volunteer to forward it.  If you are volunteering, great.

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
  out fail by default.  You can countermand this default by setting a
  configuration variable in the receiving repository.

  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007

* git-push to delete the current branch will be refused by default

  Make "git push $there :$killed" to delete the branch that is pointed at
  by its HEAD fail by default.  You can countermand this default by
  setting a configuration variable in the receiving repository.

  http://thread.gmane.org/gmane.comp.version-control.git/108862/focus=108936

* git-send-email won't make deep threads by default

  Many people said that by default when sending more than 2 patches the
  threading git-send-email makes by default is hard to read, and they
  prefer the default be one cover letter and each patch as a direct
  follow-up to the cover letter.  You can countermand this by setting a
  configuration variable.

  http://article.gmane.org/gmane.comp.version-control.git/109790

* make core.quotepath=false the default

  By default, "git diff" output quotes bytes in pathnames with high bit
  set, primarily to avoid corruption during e-mail based transfer.  This
  however is inconvenient for human readers, and also makes some poorly
  written user scripts that do not unquote them fail.  Change the default
  so that they are not quoted (note that control characters such as HT are
  always quoted).  You can countermand this by setting a configuration
  variable.

  http://thread.gmane.org/gmane.comp.version-control.git/110033
