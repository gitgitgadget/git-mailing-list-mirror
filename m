From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 0/2] git-multimail: a replacement for post-receive-email
Date: Sun, 14 Jul 2013 10:09:01 +0200
Message-ID: <1373789343-3189-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Chris Hiestand <chrishiestand@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michiel Holtkamp <git@elfstone.nl>,
	=?UTF-8?q?Stefan=20N=C3=A4we?= <stefan.naewe@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 10:10:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHNt-0001SX-Ap
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782Ab3GNIJt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:09:49 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:48889 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751674Ab3GNIJd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jul 2013 04:09:33 -0400
X-AuditID: 1207440f-b7f786d000001f20-9b-51e25cbcc5d6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id E5.68.07968.CBC52E15; Sun, 14 Jul 2013 04:09:32 -0400 (EDT)
Received: from michael.fritz.box (p4FDD4B13.dip0.t-ipconnect.de [79.221.75.19])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r6E89Jwk013667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Jul 2013 04:09:29 -0400
X-Mailer: git-send-email 1.8.3.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqLsn5lGgwaMbuharZj5mt1j77A6T
	xbWTi1ks9nZ3slp0XelmsmjovcJsceP8LlaLtzeXMFpc+rye1aLxSZHF7RXzmS3en/3P7MDj
	8ff9ByaPc3sXsnjsnHWX3WPil+OsHmcfPWD2uHhJ2ePzJjmPA5cfswVwRHHbJCWWlAVnpufp
	2yVwZ7Sue8RasF2y4uXBL8wNjE0iXYycHBICJhKvd05hgrDFJC7cW8/WxcjFISRwmVFi6aJ3
	jBDOeSaJ5R92MIJUsQnoSizqaQbrEBFQk5jYdogFpIhZYC2LxNwDh1hBEsIC3hKTnxxhAbFZ
	BFQl7r9aD9bMK+As8efHVHaIdQoSy76sZYaIC0qcnPkEqJ4DaJC6xPp5QiBhZgF5ieats5kn
	MPLNQlI1C6FqFpKqBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0TfRyM0v0UlNKNzFCooIf
	6Jn1MocYBTgYlXh4L+x/GCjEmlhWXJl7iFGSg0lJlHd/6KNAIb6k/JTKjMTijPii0pzU4kOM
	EhzMSiK8y5SBcrwpiZVVqUX5MClpDhYlcV71Jep+QgLpiSWp2ampBalFMFkZDg4lCd7qKKBG
	waLU9NSKtMycEoQ0EwcniOAC2cADtOF+NMiG4oLE3OLMdIiiU4yKUuK8Z0AmCIAkMkrz4AbA
	0tcrRnGgf4R5r4O08wBTH1z3K6DBTECDb6+6DzK4JBEhJdXAWNt7TeD+qWVev/R4T1yQOt+7
	vqEhxXa11enHnwy2pGdkfq3PvmfM9iPP/Pnlt2+dQlaqqvgzJO+MbIyPj66Vdoqf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230310>

This is the fourth iteration submission of git-multimail to Git.  The
earlier submissions have all gotten a lot of good feedback, which has
mostly been implemented.  This submission differs from v3 in the
following ways:

* Renames the directory within the Git project from
  contrib/hooks/git-multimail/ to contrib/hooks/multimail/.  The
  "git-" seems redundant within the Git project [1].  I have no strong
  feelings either way.

* Includes the latest version of the upstream project.  Highlights:

  * A change in how git-multimail is configured via Python.  I wasn't
    happy with the old method; concerns were not separated well
    enough.  I wanted to get this right before more people start
    writing against the internal API.  The new version uses mixin
    classes, which is a technique that can easily be overdone.  But in
    this case I was happy with the way that it permitted different
    aspects of the configuration to be disentangled quite well.  (This
    doesn't change how the script is configured externally via "git
    config"; that has been stable for quite some time already.)

  * Fixes a scalability issue for repos with lots of refs that was
    pointed out by =C3=86var Bjarmason.

  * Allows an arbitrary program to be substituted in place of
    /usr/sbin/sendmail when using the SendMailer.

  * Improvements suggested by Ramkumar Ramachandra's code review
    (thanks!).

  * Various documentation improvements.

* Adds a new file, README.Git, which explains the relationship between
  the Git and git-multimail projects, and documents the version of the
  upstream project that corresponds to the code being submitted to the
  Git project.

* Adds a notice to contrib/hooks/multimail/post-receive deprecating
  that script and pointing users to git-multimail.

The upstream project also now includes better tests.  Though I am not
including the tests in the code submitted to the Git project,
obviously the code benefits from them.

[1] I also got the feeling that Junio prefers the new directory name,
    though there is a good chance that I read more into one of his
    emails than he intended.

Michael Haggerty (2):
  git-multimail: an improved replacement for post-receive-email
  post-receive-email: deprecate script in favor of git-multimail

 contrib/hooks/multimail/README                     |  486 ++++
 contrib/hooks/multimail/README.Git                 |   15 +
 .../README.migrate-from-post-receive-email         |  146 ++
 contrib/hooks/multimail/git_multimail.py           | 2394 ++++++++++++=
++++++++
 contrib/hooks/multimail/migrate-mailhook-config    |  270 +++
 contrib/hooks/multimail/post-receive               |   90 +
 contrib/hooks/post-receive-email                   |   17 +-
 7 files changed, 3414 insertions(+), 4 deletions(-)
 create mode 100644 contrib/hooks/multimail/README
 create mode 100644 contrib/hooks/multimail/README.Git
 create mode 100644 contrib/hooks/multimail/README.migrate-from-post-re=
ceive-email
 create mode 100755 contrib/hooks/multimail/git_multimail.py
 create mode 100755 contrib/hooks/multimail/migrate-mailhook-config
 create mode 100755 contrib/hooks/multimail/post-receive

--=20
1.8.3.2
