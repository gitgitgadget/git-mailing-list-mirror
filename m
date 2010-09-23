From: "Pat Notz" <patnotz@gmail.com>
Subject: [PATCHv4 0/4] Add commit message options for rebase
 --autosquash
Date: Thu, 23 Sep 2010 11:14:32 -0600
Message-ID: <1285262076-20134-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 23 19:16:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OypP0-00040g-Qe
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 19:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938Ab0IWRPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 13:15:07 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:50565 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755932Ab0IWRPD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 13:15:03 -0400
X-WSS-ID: 0L97MKY-0C-017-02
X-M-MSG: 
Received: from sentry.sandia.gov (mm03snlnto.sandia.gov [132.175.109.20])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 1235D4FAA9A
	for <git@vger.kernel.org>; Thu, 23 Sep 2010 11:14:47 -0600 (MDT)
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Thu, 23 Sep 2010 11:14:43 -0600
X-Server-Uuid: AF72F651-81B1-4134-BA8C-A8E1A4E620FF
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id o8NHEKMr026702 for
 <git@vger.kernel.org>; Thu, 23 Sep 2010 11:14:33 -0600
Received: from s919422.srn.sandia.gov (134.253.71.44) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.2.254.0; Thu, 23 Sep 2010 11:14:36 -0600
X-Mailer: git-send-email 1.7.3
X-PMX-Version: 5.6.0.2009776, Antispam-Engine: 2.7.2.376379,
 Antispam-Data: 2010.9.23.170030
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report=' FORGED_FROM_GMAIL
 0.1, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1200_1299 0,
 BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0,
 DATE_TZ_NA 0, __CP_URI_IN_BODY 0, __CT 0, __CT_TEXT_PLAIN 0,
 __FRAUD_WEBMAIL 0, __FRAUD_WEBMAIL_FROM 0, __FROM_GMAIL 0, __HAS_MSGID
 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0,
 __PHISH_SPEAR_STRUCTURE_1 0, __SANE_MSGID 0, __TO_MALFORMED_2 0,
 __TO_NO_NAME 0, __URI_NO_MAILTO 0, __URI_NO_WWW 0, __URI_NS '
X-TMWD-Spam-Summary: TS=20100923171444; ID=1; SEV=2.3.1;
 DFV=B2010090808; IFV=NA; AIF=B2010090808; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230322E34433942384230332E303144363A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAABAKR1FwAAAAAAAAAAAAAAAAAAAH0=
X-MMS-Spam-Filter-ID: B2010090808_5.03.0010
X-WSS-ID: 6085548929K4566323-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156883>

This patch series adds new command line options to git-commit to make
it easy to specify messages for commits correctly formatted for use
wit 'rebase -i --autosquash'.

The 2nd iteration addressed concerns raised earlier:
http://thread.gmane.org/gmane.comp.version-control.git/156369 .  Most
notably, --squash=COMMIT now works with -m/-c/-C/-F and uses the
editor when appropriate.

The 3rd iteration added documentation links from --squash and --fixup
to git-rebase(1) and updated the tests to conform to established style
(editor script moved into t7500/ directory).

This 4th iteration adds missing '&&' to a couple of lines in the tests. 

Pat Notz (4):
  commit: --fixup option for use with rebase --autosquash
  t7500: add tests of commit --fixup
  commit: --squash option for use with rebase --autosquash
  t7500: add tests of commit --squash

 Documentation/git-commit.txt |   21 +++++++++--
 builtin/commit.c             |   58 +++++++++++++++++++++++++++---
 t/t7500-commit.sh            |   80 ++++++++++++++++++++++++++++++++++++++++++
 t/t7500/edit-content         |    4 ++
 4 files changed, 154 insertions(+), 9 deletions(-)
 create mode 100755 t/t7500/edit-content

-- 
1.7.3
