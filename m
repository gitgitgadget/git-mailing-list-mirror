From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] bash: add support for 'git replace'
Date: Fri, 09 Oct 2009 22:49:06 +0200
Message-ID: <4ACFA1C2.6020001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 09 22:51:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwMR5-0006uo-Dz
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 22:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758819AbZJIUtq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2009 16:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755690AbZJIUtq
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 16:49:46 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:54140 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754940AbZJIUtp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 16:49:45 -0400
Received: by ewy4 with SMTP id 4so986024ewy.37
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 13:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=s2Ap8+pn9e9tA/V/KnJGaRpRjmHlfJKQwZ/p3t1tpYA=;
        b=H42p0RptHV92eEmVri/Ls7VAVfC6vyLOa+xba3afqYqUgUp1VcRIwUu18ptm35kzZR
         UmQgb3S86O6qm/8vGyn1sa6lm4hFr/KogF7m/+S1UuLScPd4vwsu1C1Zj6+ITscZ+x0b
         c2fbGrz3Um9WcGWNbL7UzR2btM374D1jo/jAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=XA/YXNsS0nfViwy7IiCMilFx5B9JkYJO6/iT0Pl3Zfw017u7JeRdpp6V/wLaKPdALf
         mIuUUtGEzoq/tS1PizSwp7c8cJsrKGSDpYa6B+QGauq+X9IpFRny7wogT0AfuDevw/Nf
         fEnFWSVf4mxJgFXZLFgAM9dBCOjfPerBMVP70=
Received: by 10.211.153.14 with SMTP id f14mr3696647ebo.36.1255121348294;
        Fri, 09 Oct 2009 13:49:08 -0700 (PDT)
Received: from bitis.local (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 7sm202640eyg.35.2009.10.09.13.49.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 13:49:07 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129840>


Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 contrib/completion/git-completion.bash |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 88b1b3c..60009c5 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1794,6 +1794,11 @@ _git_remote ()
 	esac
 }
=20
+_git_replace ()
+{
+	__gitcomp "$(__git_refs)"
+}
+
 _git_reset ()
 {
 	__git_has_doubledash && return
@@ -2162,6 +2167,7 @@ _git ()
 	push)        _git_push ;;
 	rebase)      _git_rebase ;;
 	remote)      _git_remote ;;
+	replace)     _git_replace ;;
 	reset)       _git_reset ;;
 	revert)      _git_revert ;;
 	rm)          _git_rm ;;
--=20
1.6.5.rc3.2.g9b675
