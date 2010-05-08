From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] git-svn: Remove unused use of File::Temp
Date: Sat,  8 May 2010 16:40:41 +0000
Message-ID: <1273336841-31461-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 08 18:41:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAn5I-0002ql-LG
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 18:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945Ab0EHQkz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 May 2010 12:40:55 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43406 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab0EHQky (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 12:40:54 -0400
Received: by fxm10 with SMTP id 10so1416139fxm.19
        for <git@vger.kernel.org>; Sat, 08 May 2010 09:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=YWBlRwYs3eJCWn7Do9Cb1ZQXk3z+6KXOE4QOeq3pojA=;
        b=TWBxLP3IlJrw1hUlyu2IO2fJCAlemxv/OgUA+bGIGilLfS+1vBl4mjBcqUhgu6CBIY
         cYicKYrgCLKj95DBztPp7rF2u/1e697nLPYUTcnpPRF5ddPcTMMqzJ7P/GKLv1iRP1le
         7bSl3mFtvG0J4uN5rocQWAxgAahLOCaz2+jfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=NCo4lGBoX6htjNemEC+Gls+hbCCoqt2EJ8QNbIu8eNSc3uETYQKZ4gPGEOBTpcideQ
         ixkQL/KthGLC3HpAp98aUcgv+IsSLvfEbwzoxUQIIRokHZb8EA+qpWEVyiQf5UvaQcGH
         cR4siVBGvutWvGZ1gsDLRHNo8G8+6H0TsXNww=
Received: by 10.223.64.205 with SMTP id f13mr1677070fai.98.1273336852974;
        Sat, 08 May 2010 09:40:52 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 2sm12279247fav.13.2010.05.08.09.40.51
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 09:40:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146665>

The use line was added in ffe256f9. File::Temp calls were later moved
to Git.pm in 0b19138b, but that commit neglected to remove the
now-redundant import.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-svn.perl |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 2c86ea2..cc3a54c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3998,7 +3998,6 @@ use vars qw/@ISA/;
 use strict;
 use warnings;
 use Carp qw/croak/;
-use File::Temp qw/tempfile/;
 use IO::File qw//;
 use vars qw/$_ignore_regex/;
=20
--=20
1.7.0.4
