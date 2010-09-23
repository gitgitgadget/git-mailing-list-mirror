From: "Pat Notz" <patnotz@gmail.com>
Subject: [PATCHv3 0/4] Add commit message options for rebase
 --autosquash
Date: Thu, 23 Sep 2010 10:23:13 -0600
Message-ID: <1285258997-12497-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 23 18:23:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyoaC-0002KF-VH
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 18:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597Ab0IWQXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 12:23:33 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:51488 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179Ab0IWQXb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 12:23:31 -0400
X-WSS-ID: 0L97K72-0C-7JT-02
X-M-MSG: 
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 173374F65E3
	for <git@vger.kernel.org>; Thu, 23 Sep 2010 10:23:25 -0600 (MDT)
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Thu, 23 Sep 2010 10:23:17 -0600
X-Server-Uuid: AF72F651-81B1-4134-BA8C-A8E1A4E620FF
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id o8NGN7qK014459 for
 <git@vger.kernel.org>; Thu, 23 Sep 2010 10:23:08 -0600
Received: from s919422.srn.sandia.gov (134.253.71.44) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.2.254.0; Thu, 23 Sep 2010 10:23:15 -0600
X-Mailer: git-send-email 1.7.3
X-PMX-Version: 5.6.0.2009776, Antispam-Engine: 2.7.2.376379,
 Antispam-Data: 2010.9.23.161514
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report=' FORGED_FROM_GMAIL
 0.1, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1100_1199 0,
 BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0,
 DATE_TZ_NA 0, __CP_URI_IN_BODY 0, __CT 0, __CT_TEXT_PLAIN 0,
 __FRAUD_WEBMAIL 0, __FRAUD_WEBMAIL_FROM 0, __FROM_GMAIL 0, __HAS_MSGID
 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0,
 __PHISH_SPEAR_STRUCTURE_1 0, __SANE_MSGID 0, __TO_MALFORMED_2 0,
 __TO_NO_NAME 0, __URI_NO_MAILTO 0, __URI_NO_WWW 0, __URI_NS '
X-TMWD-Spam-Summary: TS=20100923162318; ID=1; SEV=2.3.1;
 DFV=B2010090808; IFV=NA; AIF=B2010090808; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230332E34433942374546362E303039353A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAABAKR1FwAAAAAAAAAAAAAAAAAAAH0=
X-MMS-Spam-Filter-ID: B2010090808_5.03.0010
X-WSS-ID: 6085A17F29K4559416-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156873>

This patch series adds new command line options to git-commit to make
it easy to specify messages for commits correctly formatted for use
wit 'rebase -i --autosquash'.

The 2nd iteration addressed concerns raised earlier:
http://thread.gmane.org/gmane.comp.version-control.git/156369 .  Most
notably, --squash=COMMIT now works with -m/-c/-C/-F and uses the
editor when appropriate.

This 3rd iteration adds documentation links from --squash and --fixup
to git-rebase(1) and updates the tests to conform to established style
(editor script moved into t7500/ directory).

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
