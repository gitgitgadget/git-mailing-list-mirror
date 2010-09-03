From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 4/4] instaweb: disable logo and favicon by default
Date: Thu, 2 Sep 2010 21:19:51 -0500
Message-ID: <20100903021951.GC29302@burratino>
References: <20100812131152.2333.9604.reportbug@octopus.hi.pengutronix.de>
 <20100902221211.GA4789@burratino>
 <20100902223624.GA9613@dcvr.yhbt.net>
 <20100902235237.GA6466@burratino>
 <20100902235722.GE6466@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Sep 03 04:21:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrLuV-0002zl-Ob
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 04:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869Ab0ICCVm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 22:21:42 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44173 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682Ab0ICCVm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 22:21:42 -0400
Received: by qyk36 with SMTP id 36so2739715qyk.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 19:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YItKMOYmHJnUjHCmZuLBeSR5/ZiK6tEGsukMEwg2nGA=;
        b=O75OYdCw5E4R1RzOBJn8NtfyJj/Vt+JCic1ezpxOgw+RnsS20PEK9QRORFGnRlkyRe
         CZT1xkx2jSOmg0xBmwwIb9HyrSuRMHpYnNuF23FWfGCz2VWKZ+fRvlvP+W/W16y2LqvH
         r7oT6yci2aw1w9MCt4GfD6OFdfQydsMVuJQF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=D/OuraZXDaIeY91P6d0ymuoGDiFOcVi51zzQ6MYrvD94cmF8UEdsUCVclj1OuXT09t
         a7OaPs2r6noNCauynQo/aCV1oNTEv5VLoGdk3Ogw6WFSeok9wQ9GJfWAWnjkurNR5ZsU
         7nq/nAcX9V+x4YxyUSyRxBIUNK98Pj6ruscXI=
Received: by 10.224.54.140 with SMTP id q12mr685592qag.233.1283480501290;
        Thu, 02 Sep 2010 19:21:41 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id f15sm1270019qcr.1.2010.09.02.19.21.39
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 19:21:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100902235722.GE6466@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155232>

Avoid 404 errors due to the missing git logo and favicon.

Reported-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Eric Wong <normalperson@yhbt.net>
Cc: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:

> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -376,7 +376,9 @@ s#^(my|our) \$projectroot =3D.*#$1 \$projectroot =
=3D "'$(dirname "$fqgitdir")'";#;
>  s#(my|our) \$gitbin =3D.*#$1 \$gitbin =3D "'$GIT_EXEC_PATH'";#;
>  s#(my|our) \$projects_list =3D.*#$1 \$projects_list =3D \$projectroo=
t;#;
>  s#(my|our) \$git_temp =3D.*#$1 \$git_temp =3D "'$fqgitdir/gitweb/tmp=
'";#;
> -s#(my|our) \$GITWEB_CONFIG_SYSTEM =3D.*#$1 \$GITWEB_CONFIG_SYSTEM =3D=
 "";#;'
> +s#(my|our) \$GITWEB_CONFIG_SYSTEM =3D.*#$1 \$GITWEB_CONFIG_SYSTEM =3D=
 "";#;
> +s#(my|our) \$favicon =3D.*#$1 \$favicon =3D undef;#;'
> +s#(my|our) \$logo =3D.*#$1 \$logo =3D undef;#;'

Stray apostrophe; sorry about that.  Here's a replacement.

 git-instaweb.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 6279f4d..0725596 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -376,7 +376,9 @@ s#^(my|our) \$projectroot =3D.*#$1 \$projectroot =3D=
 "'$(dirname "$fqgitdir")'";#;
 s#(my|our) \$gitbin =3D.*#$1 \$gitbin =3D "'$GIT_EXEC_PATH'";#;
 s#(my|our) \$projects_list =3D.*#$1 \$projects_list =3D \$projectroot;=
#;
 s#(my|our) \$git_temp =3D.*#$1 \$git_temp =3D "'$fqgitdir/gitweb/tmp'"=
;#;
-s#(my|our) \$GITWEB_CONFIG_SYSTEM =3D.*#$1 \$GITWEB_CONFIG_SYSTEM =3D =
"";#;'
+s#(my|our) \$GITWEB_CONFIG_SYSTEM =3D.*#$1 \$GITWEB_CONFIG_SYSTEM =3D =
"";#;
+s#(my|our) \$favicon =3D.*#$1 \$favicon =3D undef;#;
+s#(my|our) \$logo =3D.*#$1 \$logo =3D undef;#;'
=20
 gitweb_cgi () {
 	cat > "$1.tmp" <<\EOFGITWEB
--=20
1.7.2.2
