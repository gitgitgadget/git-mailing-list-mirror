From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 13/12] Makefile: tuck away generated makefile fragments in
 .depend
Date: Sun, 31 Jan 2010 15:23:53 -0600
Message-ID: <20100131212353.GA4636@progeny.tock>
References: <20100123144201.GA11903@progeny.tock>
 <7v3a1u6bfz.fsf@alter.siamese.dyndns.org>
 <20100126154357.GA4895@progeny.tock>
 <20100126155714.GM4895@progeny.tock>
 <7viqaic8gs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 22:24:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbhH4-0008K4-PJ
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 22:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666Ab0AaVYA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jan 2010 16:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299Ab0AaVX7
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 16:23:59 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:48695 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106Ab0AaVX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 16:23:59 -0500
Received: by iwn34 with SMTP id 34so332043iwn.21
        for <git@vger.kernel.org>; Sun, 31 Jan 2010 13:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5G7FkYhGIqfr+tq/SDBCd+Nbneiah3szFYLYKY4c79U=;
        b=GwLivtphQ/TgLcF5ZRLvsbJXaifHAp6GctCZgkMtzhzYNbUb8es+LUgo8ynprSiqcW
         9bdkpOOPTBomtHaUR5OhJLL67NU6r2fLUr+00wDNAqZi5rC/hc4u+22ftmVsEBeKTmcY
         JSojmeKFz9CRxTx2qJqNkp0Q0w+2VWxr0hbVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=h17qOgShYnfFOKyxibpiE7zGKmqyh4/g4Z7/KsILNCUIz06awm1oRaVfnwe25qCZIb
         BK8ZL5OVNto86sQHDHv/jGKb/6oq/AG7W8zCD9s3awLYq7WZTKTsg8gCTRwYm1CghL4X
         +2SNox/Jr13VD6VZAsTLBCPTXWNyZkU/pVWp8=
Received: by 10.231.168.136 with SMTP id u8mr1462990iby.56.1264973036393;
        Sun, 31 Jan 2010 13:23:56 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm4698134iwn.8.2010.01.31.13.23.55
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Jan 2010 13:23:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7viqaic8gs.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138563>

When building with COMPUTE_HEADER_DEPENDENCIES on, save
dependency information to .depend/ instead of deps/ so it does
not show up in =E2=80=98ls=E2=80=99 output.  Otherwise, the extra direc=
tories can
be distracting.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

>  * "deps/" should probably be ".depend/" or something less distractin=
g;

Good idea.  Here goes...

 Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 45b1f54..c939139 100644
--- a/Makefile
+++ b/Makefile
@@ -1692,15 +1692,15 @@ XDIFF_OBJS =3D xdiff/xdiffi.o xdiff/xprepare.o =
xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
 OBJECTS :=3D $(GIT_OBJS) $(XDIFF_OBJS)
=20
-dep_files :=3D $(foreach f,$(OBJECTS),$(dir $f)deps/$(notdir $f).d)
+dep_files :=3D $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
=20
 ifdef COMPUTE_HEADER_DEPENDENCIES
-dep_dirs :=3D $(addsuffix deps,$(sort $(dir $(OBJECTS))))
+dep_dirs :=3D $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
 $(dep_dirs):
 	mkdir -p $@
=20
 missing_dep_dirs :=3D $(filter-out $(wildcard $(dep_dirs)),$(dep_dirs)=
)
-dep_file =3D $(dir $@)deps/$(notdir $@).d
+dep_file =3D $(dir $@).depend/$(notdir $@).d
 dep_args =3D -MF $(dep_file) -MMD -MP
 ifdef CHECK_HEADER_DEPENDENCIES
 $(error cannot compute header dependencies outside a normal build. \
--=20
1.7.0.rc1
