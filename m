From: Richard MUSIL <richard.musil@st.com>
Subject: [PATCH] git-svn: Minimalistic patch which allows svn usernames with
 space(s).
Date: Tue, 17 Jul 2007 19:02:57 +0200
Message-ID: <469CF641.4020707@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 17 19:33:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAqvG-0007QK-UB
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 19:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987AbXGQRdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 13:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755511AbXGQRdQ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 13:33:16 -0400
Received: from s200aog12.obsmtp.com ([207.126.144.126]:57564 "EHLO
	s200aog12.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860AbXGQRdP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 13:33:15 -0400
X-Greylist: delayed 1800 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Jul 2007 13:33:15 EDT
Received: from source ([164.129.1.35]) (using TLSv1) by eu1sys200aob012.postini.com ([207.126.147.11]) with SMTP;
	Tue, 17 Jul 2007 17:33:13 UTC
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E597EDA57
	for <git@vger.kernel.org>; Tue, 17 Jul 2007 17:02:59 +0000 (GMT)
Received: from mail1.prg.st.com (mail1.prg.st.com [164.130.59.16])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B047F4C02A
	for <git@vger.kernel.org>; Tue, 17 Jul 2007 17:02:59 +0000 (GMT)
Received: from [10.139.4.224] (pcdyn4224.prg.st.com [10.139.4.224])
	by mail1.prg.st.com (MOS 3.7.5a-GA)
	with ESMTP id CIH47213 (AUTH "richard musil");
	Tue, 17 Jul 2007 19:00:17 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52783>

Changed filter for username in svn-authors file, so even 'user name' is accepted.
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 01c3904..975075e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -740,7 +740,7 @@ sub load_authors {
        my $log = $cmd eq 'log';
        while (<$authors>) {
                chomp;
-               next unless /^(\S+?|\(no author\))\s*=\s*(.+?)\s*<(.+)>\s*$/;
+               next unless /^(\.+?|\(no author\))\s*=\s*(.+?)\s*<(.+)>\s*$/;
                my ($user, $name, $email) = ($1, $2, $3);
                if ($log) {
                        $Git::SVN::Log::rusers{"$name <$email>"} = $user;
--
1.5.1.6
