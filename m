From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 04/73] Makefile: "pot" target to extract messages
 marked for translation
Date: Fri, 25 Feb 2011 01:22:12 -0600
Message-ID: <20110225072212.GC23037@elie>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-5-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 08:22:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pss0Q-00071C-H6
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 08:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765Ab1BYHWW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 02:22:22 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44649 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361Ab1BYHWV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 02:22:21 -0500
Received: by vws12 with SMTP id 12so1151438vws.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 23:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=da0W32+fW+/8yaKIBPC/tydiS6G8K2Cd2kfv102GUlw=;
        b=Lwb79N8v9RuJUWCPPWp0PcHUza9TmGI69/26ywlrEEgAjCJKlZYK63jcogEg9V1xm+
         yTpXQVaoKKgn1VgJOZ0b2ZsDDO0GIsT/Q5jrNtcG/0tsv480ewQM2MPsFgCZZsEjXW12
         tO8OKIXc7/f9k8KzLUtmjKez8c9MlBAoXQyt0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=DyWq+/NrxbZQVxZ08KX2fWDngVStEZeRJ+hs/Ip32TR7FTIPpih1nv2YcDxQANUz2C
         sENwTyXaSafr+Q429D5PPWH14iB3U4MA4qgYXFWyYKYh7ICkMcteJWo/mIZiNXMG0oM3
         D2TAkYMeDWAewxSQxEnVJmWwcNBQm1dlggkzs=
Received: by 10.220.202.6 with SMTP id fc6mr490711vcb.129.1298618540036;
        Thu, 24 Feb 2011 23:22:20 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id e10sm223514vch.43.2011.02.24.23.22.17
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 23:22:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298418152-27789-5-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167879>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Add rules to generate a template (po/git.pot) listing messages marked
> for translation in the C portion of git.

A forgotten piece.  Not urgent at all.

-- 8< --
Subject: i18n: "make distclean" should clean up after "make pot"

This is in "make distclean" and not "make clean" to avoid needlessly
changing the POT-Creation-Date in the following scenario:

	make clean;	# cleaning up after an old build
	git pull
	make pot;	# regenerate po template if necessary
	msgmerge po/my_language.po po/git.pot

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 1cc6c60..7497835 100644
--- a/Makefile
+++ b/Makefile
@@ -2340,6 +2340,7 @@ dist-doc:
=20
 distclean: clean
 	$(RM) configure
+	$(RM) po/git.pot
=20
 clean:
 	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o vc=
s-svn/*.o \
--=20
1.7.4.1
