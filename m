From: Michael Hendricks <michael@ndrix.org>
Subject: [PATCH] git-send-email: allow an email alias for --from
Date: Wed,  4 Jul 2007 19:11:36 -0600
Message-ID: <11835978963177-git-send-email-michael@ndrix.org>
Cc: Michael Hendricks <michael@ndrix.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 05 03:11:43 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6Fsk-0001mX-Jv
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 03:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851AbXGEBLk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 21:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756619AbXGEBLk
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 21:11:40 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48308 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756527AbXGEBLj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jul 2007 21:11:39 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 3D12A6309
	for <git@vger.kernel.org>; Wed,  4 Jul 2007 21:11:39 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 04 Jul 2007 21:11:39 -0400
X-Sasl-enc: 9moHDwbbr6FBhJocf/Ta+N/820uNpt7K2Dp2DjBWX7Ni 1183597898
Received: from ndrix.org (tameion.ndrix.org [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTP id 81A4317C53;
	Wed,  4 Jul 2007 21:11:38 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.rc0.16.g33ce38-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51651>


Signed-off-by: Michael Hendricks <michael@ndrix.org>
---

I don't like seeing all the output and confirming the From address
when I don't specify --from.  Since I have aliases for my own email
addresses, this is easier than always typing out the full address.

It also does what I would expect since every other email address can
be specified as an alias.  Why not From also?

 git-send-email.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 87f59fa..89f7c36 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -254,6 +254,8 @@ if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
 	}
 }
 
+($from) = expand_aliases($from) if defined $from;
+
 my $prompting = 0;
 if (!defined $from) {
 	$from = $author || $committer;
-- 
1.5.3.rc0.14.gebe8f
