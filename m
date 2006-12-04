X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix Atom feed <logo>: it is $logo, not $logo_url
Date: Mon, 4 Dec 2006 14:09:43 +0100
Message-ID: <200612041409.43543.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 4 Dec 2006 13:07:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=r9xE96N1ywJYSR6g6lgtoI0iW1nIaKgo5K3n3Rw0MKfGzSNy2lPNXHCah3C9VLzbLUCAK6zHSaGjfnc8lS1dEMiYHP2CE5iVaz9wiyHqhl+wlNEDjkaAeqq+q8krYJZ2mWiwMp/LfdsFqA65ao7505ZAbK1/Ki2TpFtEBlO/+bs=
User-Agent: KMail/1.9.3
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33194>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrDXv-0002z7-Nt for gcvg-git@gmane.org; Mon, 04 Dec
 2006 14:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936807AbWLDNHo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 08:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936808AbWLDNHo
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 08:07:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:47659 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S936807AbWLDNHn
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 08:07:43 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2988476uga for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 05:07:42 -0800 (PST)
Received: by 10.67.119.13 with SMTP id w13mr12003486ugm.1165237661857; Mon,
 04 Dec 2006 05:07:41 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id m4sm14768349ugc.2006.12.04.05.07.41; Mon, 04 Dec
 2006 05:07:41 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Fix contents of Atom feed <logo> element; it should be URL
of $logo, not URL pointed by logo link.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Do anyone use Atom feed logo? This error was from the beginning of Atom
feed generation in git.git version of gitweb, and nobody complained.

I wonder why it is <logo>URL</logo>, and not <logo href="URL" />...

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 093bd72..ffe8ce1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4282,7 +4282,7 @@ XML
 		}
 		if (defined $logo_url) {
 			# not twice as wide as tall: 72 x 27 pixels
-			print "<logo>" . esc_url($logo_url) . "</logo>\n";
+			print "<logo>" . esc_url($logo) . "</logo>\n";
 		}
 		if (! %latest_date) {
 			# dummy date to keep the feed valid until commits trickle in:
-- 
1.4.4.1
