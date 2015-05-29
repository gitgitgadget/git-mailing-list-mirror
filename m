From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: git-multimail resurected!
Date: Fri, 29 May 2015 15:10:06 +0200
Message-ID: <vpqr3pz5y35.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 29 15:10:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyK3n-0008Ru-6J
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 15:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387AbbE2NKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 09:10:46 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41346 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752833AbbE2NKq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 09:10:46 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4TDA4DF002431
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 May 2015 15:10:05 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4TDA6cA000332;
	Fri, 29 May 2015 15:10:06 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 29 May 2015 15:10:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4TDA4DF002431
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433509806.44966@OtnRYCN8MyczVhMm/DqN0A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270239>

Hi,

This is my pleasure to write this first message as git-multimail [1]
co-maintainer. git-multimail allows sending automatic notification
emails after a "git push". It was initially written by Michael Haggerty
as a greatly improved replacement for post-receive-email. Michael has been
a great developer and reviewer for a while (and thanks again for that!),
but lost personal interest in the tool a while ago, and asked me if I
wanted to take over the maintainership when we met at Git Merge. We
currently co-maintain the tool.

I finally got some time to go through the pending pull-requests. I could
close 19 PR, and we still have 10 pending. For more details about what
happened recently, see the GitHub pulse [2]. Pleasant to look at :-).

Other than fixes, we have the following new features in master:

* When a single commit is pushed, omit the reference changed email.
  Set multimailhook.combineWhenSingleCommit to false to disable this
  new feature.

* In gitolite environments, the pusher's email address can be used as
  the From address by creating a specially formatted comment block in
  gitolite.conf (see multimailhook.from in README).

* Support for SMTP authentication/SSL was added, see smtpUser,
  smtpPass, smtpEncryption in README.

* A new option scanCommitForCc was added to allow git-multimail to
  search the commit message for 'Cc: ...' lines, and add the
  corresponding emails in Cc.

* If $USER is not set, use the variable $USERNAME. This is needed on
  Windows platform to recognize the pusher.

* The emailPrefix variable can now be set to an empty string to remove
  the prefix.

* A short tutorial was added in doc/gitolite.rst to set up
  git-multimail with gitolite.

* The post-receive file was renamed to post-receive.example. It has
  always been an example (the standard way to call git-multimail is to
  call git_multimail.py), but it was unclear to many users.

Next to review&merge on my TODO-list:

* Add an option to show a graph of commits in addition to the log in the
  summary message [3].

* Allow filtering on refs, so that mails can be sent only when pushing
  to a subset of branches/tags/... [4].

I plan to tag a 1.1 release in June. Don't hesitate to join the fun and
help by reviewing pull-requests or submitting new ones!

[1] https://github.com/git-multimail/git-multimail
[2] https://github.com/git-multimail/git-multimail/pulse/monthly
[3] https://github.com/git-multimail/git-multimail/pull/90
[4] https://github.com/git-multimail/git-multimail/pull/52

Cheers,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
