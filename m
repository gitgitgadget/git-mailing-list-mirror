From: zzs <zzs213@126.com>
Subject: [PATCH] fix gitweb syntax highlight utf-8 encode bug
Date: Thu,  4 Aug 2011 23:52:55 +0800
Message-ID: <1312473175-28195-1-git-send-email-zzs213@126.com>
References: <CALkWK0kOTXyevPy0Ys+pWwGjr2NSo3+ifhWuPVU+=FL=LC=J7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>,
	=?UTF-8?q?=E5=BC=A0=E5=BF=A0=E5=B1=B1?= <zzs213@126.com>
To: <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 18:22:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp0gw-0002lL-Pn
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 18:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098Ab1HDQWd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Aug 2011 12:22:33 -0400
Received: from m15-112.126.com ([220.181.15.112]:53638 "EHLO m15-112.126.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754126Ab1HDQWc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 12:22:32 -0400
X-Greylist: delayed 1876 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Aug 2011 12:22:31 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Received:From:To:Cc:Subject:Date:Message-Id:
	In-Reply-To:References:MIME-Version:Content-Type:
	Content-Transfer-Encoding; bh=Fv6QyGJQMiEqTuxjdk77sNjtHRtdl12WDu
	S3aywsNyo=; b=NOrxe788uiwuSJqcRT+dUkh0L0l3FSSQV4tqOJRKqSHzXOSGMk
	b2X9WQndLyBlEfA5dUhKUimaxOTe6EiFDmHd45BDskUqTK8p2N/H0rslNZlj2na+
	Q4/2aNp1x9/aqLM++/HK5W9eNDLNNr9sJRupGAtsWUokPDEBtfFzGSt6s=
Received: from localhost.localdomain (unknown [119.6.72.17])
	by smtp2 (Coremail) with SMTP id DMmowKCbn6PmvzpOxTtoAg--.48600S2;
	Thu, 04 Aug 2011 23:51:03 +0800 (CST)
X-Coremail-DSSMTP: 119.6.72.17
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <CALkWK0kOTXyevPy0Ys+pWwGjr2NSo3+ifhWuPVU+=FL=LC=J7A@mail.gmail.com>
X-CM-TRANSID: DMmowKCbn6PmvzpOxTtoAg--.48600S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF4DAr47trW3KFW5ZrW8JFb_yoWxZrXEva
	10vFnrKFWjvFy29r4jvF43Gw1fXayxurn5Ww1Yvrn3u34jqF1UJwn7Gw17AryaqrnrCFZx
	Kw1DtFW3Cr4jyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUmL95UUUUU==
X-CM-SenderInfo: x22vjiat6rjloofrz/1tbiZhuRGUm+KiuV1QAAsD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178750>

=46rom: =E5=BC=A0=E5=BF=A0=E5=B1=B1 <zzs213@126.com>

Signed-off-by: =E5=BC=A0=E5=BF=A0=E5=B1=B1 <zzs213@126.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index dab89f2..48def38 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6465,7 +6465,7 @@ sub git_blob {
 			$nr++;
 			$line =3D untabify($line);
 			printf qq!<div class=3D"pre"><a id=3D"l%i" href=3D"%s#l%i" class=3D=
"linenr">%4i</a> %s</div>\n!,
-			       $nr, esc_attr(href(-replay =3D> 1)), $nr, $nr, $syntax ? $li=
ne : esc_html($line, -nbsp=3D>1);
+			       $nr, esc_attr(href(-replay =3D> 1)), $nr, $nr, $syntax ? to_=
utf8($line) : esc_html($line, -nbsp=3D>1);
 		}
 	}
 	close $fd
--=20
1.7.4.4
