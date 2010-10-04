From: Viresh KUMAR <viresh.kumar@st.com>
Subject: [PATCH] send-email: Clear To: field for every mail
Date: Mon,  4 Oct 2010 11:07:12 +0530
Message-ID: <a9b17bd454e57abb75f6cd2a7da63ec7738f5e7b.1286170305.git.viresh.kumar@st.com>
Cc: bebarino@gmail.com, Viresh Kumar <viresh.kumar@st.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 04 07:37:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2dk0-00011H-3t
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 07:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144Ab0JDFh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 01:37:28 -0400
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:51672 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752017Ab0JDFh2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 01:37:28 -0400
Received: from source ([164.129.1.35]) (using TLSv1) by eu1sys200aob101.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTKloDD7KZHZoQUzXPfqfaPDDB8F2epFn@postini.com; Mon, 04 Oct 2010 05:37:27 UTC
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 43FF179;
	Mon,  4 Oct 2010 05:37:15 +0000 (GMT)
Received: from mail2.dlh.st.com (mail2.dlh.st.com [10.199.8.22])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7CFFB1544;
	Mon,  4 Oct 2010 05:37:14 +0000 (GMT)
Received: from localhost ([10.199.16.92])
	by mail2.dlh.st.com (MOS 3.8.7a)
	with ESMTP id CUF01073 (AUTH viresh.kumar@st.com);
	Mon, 4 Oct 2010 11:07:13 +0530 (IST)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157979>

While sending multiple patches with a single git-send-email command,
To: field is not cleared after every mail. This patch clears To: field
after every patch sent.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Tested-by: Viresh Kumar <viresh.kumar@st.com>
---
 git-send-email.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 1ccfb80..cf17704 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1150,6 +1150,7 @@ foreach my $t (@files) {
 	my $author_encoding;
 	my $has_content_type;
 	my $body_encoding;
+	@to = ();
 	@cc = ();
 	@xh = ();
 	my $input_format = undef;
-- 
1.7.2.3
