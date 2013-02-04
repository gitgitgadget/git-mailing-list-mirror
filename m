From: Ted Zlatanov <tzz@lifelogs.com>
Subject: [PATCH 2/3] Skip blank and commented lines in
 contrib/credentials/netrc
Date: Mon, 04 Feb 2013 11:42:36 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87obg0vxmr.fsf_-_@lifelogs.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v7gmumzo6.fsf@alter.siamese.dyndns.org>
	<87pq0l5qbc.fsf@lifelogs.com>
	<20130131193844.GA14460@sigill.intra.peff.net>
	<87k3qrx712.fsf@lifelogs.com>
	<20130203194148.GA26318@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 17:43:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2P8G-0002Oq-0C
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 17:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756578Ab3BDQmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 11:42:37 -0500
Received: from z.lifelogs.com ([173.255.230.239]:54040 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756544Ab3BDQmh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 11:42:37 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id A3BAADE0C5;
	Mon,  4 Feb 2013 16:42:36 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
Mail-Copies-To: never
Gmane-Reply-To-List: yes
In-Reply-To: <20130203194148.GA26318@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 3 Feb 2013 14:41:49 -0500")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215391>


Signed-off-by: Ted Zlatanov <tzz@lifelogs.com>
---
 contrib/credential/netrc/git-credential-netrc |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/contrib/credential/netrc/git-credential-netrc b/contrib/credential/netrc/git-credential-netrc
index 92fc306..a47a223 100755
--- a/contrib/credential/netrc/git-credential-netrc
+++ b/contrib/credential/netrc/git-credential-netrc
@@ -192,6 +192,9 @@ LINE: foreach my $line (@data)
   push(@tok, $tok);
  }
 
+ # skip blank lines, comments, etc.
+ next LINE unless scalar @tok;
+
  my %tokens;
  while (@tok)
  {
-- 
1.7.9.rc2
