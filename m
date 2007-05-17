From: Michael Hendricks <michael@ndrix.org>
Subject: [PATCH] git-send-email: allow leading white space on mutt aliases
Date: Wed, 16 May 2007 23:15:16 -0600
Message-ID: <1179378916698-git-send-email-michael@ndrix.org>
Cc: Michael Hendricks <michael@ndrix.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 07:15:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoYKm-00006x-Qx
	for gcvg-git@gmane.org; Thu, 17 May 2007 07:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866AbXEQFPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 01:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755953AbXEQFPU
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 01:15:20 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33269 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755866AbXEQFPT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 May 2007 01:15:19 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id A694A211D70
	for <git@vger.kernel.org>; Thu, 17 May 2007 01:16:42 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 17 May 2007 01:15:18 -0400
X-Sasl-enc: JMyTVnyEzJYZ040qKhioM5hBukCdQ11t4qaMYyxljdVm 1179378919
Received: from localhost (tameion.ndrix.org [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTP id A1AF320DE7;
	Thu, 17 May 2007 01:15:19 -0400 (EDT)
X-Mailer: git-send-email 1.5.2.rc3.39.gaf9b-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47501>

mutt version 1.5.14 (perhaps earlier versions too) permits alias files to have
white space before the 'alias' keyword.

Signed-off-by: Michael Hendricks <michael@ndrix.org>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 404095f..eb876f8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -212,7 +212,7 @@ my $aliasfiletype = $repo->config('sendemail.aliasfiletype');
 my %parse_alias = (
 	# multiline formats can be supported in the future
 	mutt => sub { my $fh = shift; while (<$fh>) {
-		if (/^alias\s+(\S+)\s+(.*)$/) {
+		if (/^\s*alias\s+(\S+)\s+(.*)$/) {
 			my ($alias, $addr) = ($1, $2);
 			$addr =~ s/#.*$//; # mutt allows # comments
 			 # commas delimit multiple addresses
-- 
1.5.2.rc3.39.gaf9b-dirty
