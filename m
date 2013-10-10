From: Alexander Kurz <alexander.kurz@heliocentris.com>
Subject: [PATCH] Fix: Handle ampersand in branch names properly
Date: Thu, 10 Oct 2013 16:19:55 +0200
Message-ID: <5256B78B.6050801@heliocentris.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------010008060902020804010709"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 10 16:20:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUH64-000785-CG
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 16:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427Ab3JJOUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 10:20:00 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:55058 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263Ab3JJOT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 10:19:59 -0400
Received: from srvhelioex.Heliocentris.com (vpn.heliocentris.fta-berlin.de [141.16.91.70])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MITed-1VV6Is27jT-00494X; Thu, 10 Oct 2013 16:19:57 +0200
Received: from [192.168.22.58] (192.168.22.58) by srvhelioex.Heliocentris.com
 (172.16.56.99) with Microsoft SMTP Server id 8.2.255.0; Thu, 10 Oct 2013
 16:19:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
X-PMWin-Version: 3.1.3.0, Antivirus-Engine: 3.47.3, Antivirus-Data: 4.93G
X-PureMessage: [Scanned]
X-Provags-ID: V02:K0:s0x95nJKlQ0oj/xPZDNhv8Y1L3Td0a0vgzFho9im3Va
 ccg0Tu81+aSxsGiRWo3MaSrk+BMneq+QmRo9cOIU4L0B24/m0w
 eCynQPRS6kD4mras4MeXtFtxCdmLhU7eTEkUmYR4D9Ta5OaSSw
 6aSMjxvH9Gi0u3PoHewy6VeNbwJ9DBApRH6zAQlfyuG8Seev42
 tF9Lf9DZPENr8TI+8n+f6HIphUNLJVjiKud2CS7MfFJ9LuH7Z3
 5yC0MEuGiIpNpNOHbtKLfRI0i+eP+q06GuJIzlswoc4VtakP5G
 urSu4bIyOH//07f3fydzEXHHydWqqM1VDvYK5U3VK1BgphBYdL
 Em2wTA2j0XVL0NVlqk8V2jNAw+3ZwE+NZ4IeDoHY8TtRUPVPoX
 NTC87xjioqovg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235863>

--------------010008060902020804010709
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Content-Transfer-Encoding: 7bit

Hello git maintainer crew,
  recently I stumbled about gitweb generating improper HTML after 
somebody merged from a branch contining an ampersand, e.g. branch 
name=fixes&features.
  Thanks, Alexander Kurz

--------------010008060902020804010709
Content-Type: text/x-diff;
	name="0001-Fix-Handle-ampersand-in-branch-names-properly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-Fix-Handle-ampersand-in-branch-names-properly.patch"

>From beccd85ba8b8421213056883f31365f33d6e4490 Mon Sep 17 00:00:00 2001
From: kurz <kurz@DP-KURZ.heliocentris.com>
Date: Thu, 10 Oct 2013 16:09:46 +0200
Subject: [PATCH] Fix: Handle ampersand in branch names properly

---
 gitweb/gitweb.perl |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 68c77f6..2963b1d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2026,7 +2026,7 @@ sub format_ref_marker {
 				-href => href(
 					action=>$dest_action,
 					hash=>$dest
-				)}, $name);
+				)}, esc_attr($name));
 
 			$markers .= " <span class=\"".esc_attr($class)."\" title=\"".esc_attr($ref)."\">" .
 				$link . "</span>";
-- 
1.7.10.4


--------------010008060902020804010709--
