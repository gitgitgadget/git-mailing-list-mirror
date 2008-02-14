From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: another git rebase -i problem
Date: Thu, 14 Feb 2008 10:37:30 +0100
Message-ID: <20080214093730.GA20408@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 14 10:38:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPaXn-0002iu-LA
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 10:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbYBNJhg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Feb 2008 04:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbYBNJhg
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 04:37:36 -0500
Received: from mail29.messagelabs.com ([216.82.249.147]:24990 "HELO
	mail29.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752481AbYBNJhf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 04:37:35 -0500
X-VirusChecked: Checked
X-Env-Sender: Uwe.Kleine-Koenig@digi.com
X-Msg-Ref: server-12.tower-29.messagelabs.com!1202981853!5957094!3
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [66.77.174.21]
Received: (qmail 12678 invoked from network); 14 Feb 2008 09:37:34 -0000
Received: from unknown (HELO owa.digi.com) (66.77.174.21)
  by server-12.tower-29.messagelabs.com with SMTP; 14 Feb 2008 09:37:34 -0000
Received: from mtk-sms-mail01.digi.com ([10.10.8.120]) by owa.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 14 Feb 2008 03:37:33 -0600
Received: from dor-sms-mail1.digi.com ([10.49.1.105]) by mtk-sms-mail01.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 14 Feb 2008 03:37:32 -0600
Received: from zentaur.digi.com ([10.100.10.144]) by dor-sms-mail1.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 14 Feb 2008 10:37:30 +0100
Received: by zentaur.digi.com (Postfix, from userid 1080)
	id 1687F1B27B; Thu, 14 Feb 2008 10:37:30 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 14 Feb 2008 09:37:30.0336 (UTC) FILETIME=[37D96E00:01C86EED]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-5.000.1023-15728.003
X-TM-AS-Result: No-0.412400-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73868>

Hello,

this time it's more trivial, so maybe PEBKAC.

After applying the patch below, the test fails.  git rebase (without -i=
)
works.

The relevant history looks as follows:

	F - I+H+G+G - ... <- branch3
	 \
	  I

And moreover I have a more complicated history here with git rebase
failing but I think this here is not my problem :-(

Best regards
Uwe

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index e5ed745..4d2dec7 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -362,4 +362,11 @@ test_expect_success 'rebase with a file named HEAD=
 in worktree' '
=20
 '
=20
+test_expect_success 'rebase patch already merged' '
+
+	git checkout -b branch4 I &&
+	git rebase -i branch3
+
+'
+
 test_done
--=20
1.5.4.1


--=20
Uwe Kleine-K=F6nig, Software Engineer
Digi International GmbH Branch Breisach, K=FCferstrasse 8, 79206 Breisa=
ch, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 1=
3962
