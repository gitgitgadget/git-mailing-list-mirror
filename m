From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 04/73] Makefile: "pot" target to extract messages
 marked for translation
Date: Fri, 25 Feb 2011 15:20:10 -0600
Message-ID: <20110225212010.GC4580@elie>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-5-git-send-email-avarab@gmail.com>
 <20110225072212.GC23037@elie>
 <AANLkTim72p3H5zrELsApN8EM1CAU1H=FdjaoL+s=cJzH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 22:20:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt55M-0003K9-6p
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 22:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509Ab1BYVUT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 16:20:19 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:56737 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150Ab1BYVUS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 16:20:18 -0500
Received: by vxi39 with SMTP id 39so1756669vxi.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 13:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=2sOICvgUYns0SuSbJsoqBDJ9ClY0RlNHbCqAvnrh/50=;
        b=J/36Q3/Ad48fb2tOWEN+TxytXMCE0h0RF1nmchTxijjKGv6ZGvJc/UO3tDNNqG7axB
         Ms5Wr7phl6GC/FzwUm3zMp1XMVV/5hRuXRaZCc/cg7LJTYgM54g1KKBoz4T2hpyUw/fq
         izOw4au/5bAYSf5zijZIZ4GCLxtKGGbEY1Olw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LyMbKQICYB4ELT/cy1PjeYf+MlLERmupBhtHbuFKXBnx2qbdm6o0Uy6rd7XJN98GwA
         9RPcqtGb7d04/Mh0kDy5hjfijz9WXktVftHv9QBwloKHyqkJyDCz40RVouTcEA0k+8rF
         6wCxszij0OAbS9D/Mu0+tsAUj9FPUvAPCdKlY=
Received: by 10.52.158.102 with SMTP id wt6mr4906876vdb.0.1298668817548;
        Fri, 25 Feb 2011 13:20:17 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id y15sm561051vch.5.2011.02.25.13.20.15
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Feb 2011 13:20:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTim72p3H5zrELsApN8EM1CAU1H=FdjaoL+s=cJzH@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167943>

(-cc: Jakub)
=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> There's also one other (future) issue your `mv $i+ $i` trick confuses
> xgettext, which complains about invalid CHARSET in a later patch when
> there's more than one xgettext call. I.e. it doesn't like to append t=
o
> files that don't end in *.pot for some reason.

Hmm, I had been wondering where that message came from.  Maybe the
following would help?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile      |    4 ++--
 po/.gitignore |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 7497835..781af23 100644
--- a/Makefile
+++ b/Makefile
@@ -2068,8 +2068,8 @@ XGETTEXT_FLAGS_C =3D $(XGETTEXT_FLAGS) --keyword=3D=
_ --keyword=3DN_ --language=3DC
 LOCALIZED_C :=3D $(C_OBJ:o=3Dc)
=20
 po/git.pot: $(LOCALIZED_C)
-	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)=
 && \
-	mv $@+ $@
+	$(QUIET_XGETTEXT)$(XGETTEXT) -ogit-tmp.pot $(XGETTEXT_FLAGS_C) $(LOCA=
LIZED_C) && \
+	mv git-tmp.pot $@
=20
 pot: po/git.pot
=20
diff --git a/po/.gitignore b/po/.gitignore
index a242a86..e3a8c5d 100644
--- a/po/.gitignore
+++ b/po/.gitignore
@@ -1 +1 @@
-/git.pot
+*.pot
--=20
1.7.4.1
