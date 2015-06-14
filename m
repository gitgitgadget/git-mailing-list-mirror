From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: [ANNOUNCE] git-multimail 1.1.0-rc1
Date: Sun, 14 Jun 2015 19:30:12 +0200
Message-ID: <vpq4mmaci57.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 14 19:30:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Bjh-0008I1-T4
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 19:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbbFNRaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 13:30:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42770 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982AbbFNRaP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 13:30:15 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5EHU9Fu018584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 14 Jun 2015 19:30:09 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5EHUCKC032566;
	Sun, 14 Jun 2015 19:30:12 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 14 Jun 2015 19:30:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5EHU9Fu018584
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434907810.65017@NGmF5s9qTZmjSHBUFnhP+w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271642>

Hi,

I'm happy to announce the first release candidate of git-multimail 1.1.

git-multimail is a tool to send notification emails for pushes to a git
repository. It can be downloaded from
https://github.com/git-multimail/git-multimail (the release itself can
be seen here: https://github.com/git-multimail/git-multimail/releases ).

The main new features are:

* When a single commit is pushed, omit the reference changed email.
  Set multimailhook.combineWhenSingleCommit to false to disable this
  new feature.

* In gitolite environments, the pusher's email address can be used as
  the From address by creating a specially formatted comment block in
  gitolite.conf (see multimailhook.from in README).

* Support for SMTP authentication and SSL/TLS encryption was added,
  see smtpUser, smtpPass, smtpEncryption in README.

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

* A new refchangeShowGraph option was added to make it possible to
  include both a graph and a log in the summary emails.  The options
  to control the graph formatting can be set via the new graphOpts
  option.

Internally, I've improved the testing system (plug travis-ci.org on the
GitHub repository, check PEP8 conformance in the code and RST on the
README). Hopefully, I didn't break too many things ;-).

Next on the roadmap:

* There's a long standing pull request (#52) to allow filtering out some
  refs. We still need to figure out what the best way to do this is.

* Once this is done, there are other pull requests on top of this to
  support Atlassian Stash and Gerrit.

* At some point, we'll need to start supporting Python 3.x, but I'd
  rather focus on features for now.

Please, test, report bugs, send patches ... and have fun!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
