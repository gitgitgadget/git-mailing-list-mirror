From: Simon Ruderich <simon@ruderich.org>
Subject: [PATCH] git-add--interactive: warn if module for
 interactive.singlekey is missing
Date: Mon, 3 Mar 2014 22:16:12 +0100
Message-ID: <f5d9de10d80bd2087e6082ba1e12ef65d3f083e3.1393880573.git.simon@ruderich.org>
References: <xmqq1tyjqfbh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 22:16:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKaE1-0006rr-FW
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 22:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337AbaCCVQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 16:16:17 -0500
Received: from zucker.schokokeks.org ([178.63.68.96]:33862 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbaCCVQP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 16:16:15 -0500
Received: from localhost (pD9F549CD.dip0.t-ipconnect.de [::ffff:217.245.73.205])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Mon, 03 Mar 2014 22:16:13 +0100
  id 000000000002008B.000000005314F11D.000052E8
Content-Disposition: inline
In-Reply-To: <xmqq1tyjqfbh.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243271>

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
 git-add--interactive.perl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 24bb1ab..d3bca12 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -58,6 +58,9 @@ if ($repo->config_bool("interactive.singlekey")) {
 		Term::ReadKey->import;
 		$use_readkey = 1;
 	};
+	if (!$use_readkey) {
+		print STDERR "missing Term::ReadKey, disabling interactive.singlekey\n";
+	}
 	eval {
 		require Term::Cap;
 		my $termcap = Term::Cap->Tgetent;
-- 
1.9.0.11.g9a08b42

-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
