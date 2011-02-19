From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 0/3] Fix failure-causing warnings in Gitweb + improve gitweb-lib.sh
Date: Sat, 19 Feb 2011 15:27:39 +0000
Message-ID: <1298129262-10468-1-git-send-email-avarab@gmail.com>
References: <1298124654-12051-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 16:28:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqoj4-0006AV-J5
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 16:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574Ab1BSP16 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 10:27:58 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34998 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755470Ab1BSP15 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 10:27:57 -0500
Received: by ewy5 with SMTP id 5so1925810ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 07:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=C5tMHIkgtt8y90oLCJaKsUiGbH8vgnIPlvIc0mjAFRk=;
        b=Kqc2k4eoJG651S1/ZSKER1CUNhFALGlizniWs5am5OaYGVmj4qvCApUfVcmNBShFTh
         aoFJk7a2syxqPekXcpxF0v4qUe2q3XRvcR3fKrh/TnXNNgZLFX8Da2Nlx8L6JXFD5Co5
         LI2QUUfAycR/JC89pn1jJ8W6Bkr4+RxUkKSIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=W/DS2rni9jIrCHtPXCJV+SXEdUDJ+wfT8eq6/PwyJ2J4A1fkocRPR1UzA12a8ht9gb
         WXD81EY5INgK1Tddc6FOnmoPHAHLJmCwY6jg2W+hRCY90mJebiifb/Ec5msV9y4y0cn2
         xvSKuLuHsFzJy8dCApZJ5MSvyiGmsJRf+6B2E=
Received: by 10.213.14.148 with SMTP id g20mr2341210eba.43.1298129276110;
        Sat, 19 Feb 2011 07:27:56 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id q52sm3006362eei.15.2011.02.19.07.27.55
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 07:27:55 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298124654-12051-1-git-send-email-avarab@gmail.com>
In-Reply-To: <1298124654-12051-1-git-send-email-avarab@gmail.com>
References: <1298124654-12051-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167286>

Ignore the previous patch series to fix the qw(...) warning. I missed
some spots.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
  t/gitweb-lib.sh: print to stderr when gitweb_run has errors
  gitweb/gitweb.perl: remove use of qw(...) as parentheses
  gitweb/gitweb.perl: don't call S_ISREG() with undef

 gitweb/gitweb.perl |    6 +++---
 t/gitweb-lib.sh    |    7 ++++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

--=20
1.7.2.3
