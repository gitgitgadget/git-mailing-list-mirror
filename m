From: =?UTF-8?Q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
Subject: [PATCH] gitweb: Escape attribute in chop_and_escape_str()
Date: Tue, 29 Nov 2011 00:27:34 +0100
Message-ID: <CAKD0UuyOMRFHE6DvuDj0ancfwFfg8ADKab6emv99+FN5RfZ=mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 00:29:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVAdJ-0000dU-01
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 00:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755620Ab1K1X17 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Nov 2011 18:27:59 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33886 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574Ab1K1X14 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2011 18:27:56 -0500
Received: by eaak14 with SMTP id k14so2357415eaa.19
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 15:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=KCiRHksd48PPveuZG6J8EJlYAwizvHF9Q2ZcceJI8PA=;
        b=H3x05D+PGpPbx0rGjo/PxfBNjIXujg6wENUwnvJtPkUNGA0BEpmf6PU6qVcX7ciaxS
         SZUVaxs4pk4mrkQDpm+MC/+X1QT/TLLl+4lrcY4IKRTP9LlAzcDNn9HLXZ3scnozI76g
         9GAmKNWiTDG0SDH4OynVx0XRSbPj5rywBtnIc=
Received: by 10.227.208.199 with SMTP id gd7mr16487727wbb.2.1322522875041;
 Mon, 28 Nov 2011 15:27:55 -0800 (PST)
Received: by 10.180.87.37 with HTTP; Mon, 28 Nov 2011 15:27:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186037>

=46ixes the title attribute in <span title=3D"J=C3=83=C2=BCrgen Kreiled=
er">J=C3=BCrgen
Kreileder</span>
for example because to_utf8() is called implicitly now.

(Not sure why the attribute is there at all in the example. From my
point of view
nothing got chopped.)

Signed-off-by: Juergen Kreileder <jk@blackdown.de>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4f0c3bd..fd76407 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1699,7 +1699,7 @@ sub chop_and_escape_str {
 		return esc_html($chopped);
 	} else {
 		$str =3D~ s/[[:cntrl:]]/?/g;
-		return $cgi->span({-title=3D>$str}, esc_html($chopped));
+		return $cgi->span({-title =3D> esc_attr($str)}, esc_html($chopped));
 	}
 }

--=20
1.7.5.4
