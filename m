From: Junio C Hamano <gitster@pobox.com>
Subject: [WARNING] Proposed future changes that are backward incompatible
Date: Wed, 25 Feb 2009 17:28:20 -0800
Message-ID: <7vy6vux9zf.fsf@gitster.siamese.dyndns.org>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 02:30:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcV4X-0004NJ-HR
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 02:29:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756595AbZBZB2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 20:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756500AbZBZB2d
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 20:28:33 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42377 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754915AbZBZB2c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 20:28:32 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 770A59D29C;
	Wed, 25 Feb 2009 20:28:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 240969D295; Wed,
 25 Feb 2009 20:28:21 -0500 (EST)
Mail-Followup-To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C5BBF218-03A4-11DE-969B-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111519>

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

* refuse push to update the checked out branch in a non-bare repo by default

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
