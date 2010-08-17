From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v2 3/3] t/t7008-grep-binary.sh: un-TODO a test that needs REG_STARTEND
Date: Tue, 17 Aug 2010 05:17:13 +0000
Message-ID: <1282022233-32692-4-git-send-email-avarab@gmail.com>
References: <AANLkTik4FL56EM4HdpfZ7ha8GNkbLsJeb415WFWUh+O_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paolo Bonzini <paolo.bonzini@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 07:18:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlEYj-0002kb-Hm
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 07:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419Ab0HQFRi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 01:17:38 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40532 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633Ab0HQFRd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 01:17:33 -0400
Received: by wwi17 with SMTP id 17so567112wwi.1
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 22:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=cwJrB7nNeBR6tYRYI1fh6KypIDZi4Q1taB0F1C5v+C4=;
        b=AQtwoeATY9AOzTk3m+5bJ6UuUL0JfJmGo0FoF6gCuqzhHu3DjArjlD2gBxex8yR5DI
         nMRj6NezYlOSjeKknLYi+9tMFfMpjI+7PL5R/xwcbR5n7FWReuPYae7w+CdGk53j/moh
         r/2GnzQjnbyoX0F62WDETYx4hByWHLeWUp5u8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FffXFzF2hEQP8fAB2CZKm+pdKMonrfJWlJe4X4b4G4m81diBFRwct9Byt3oXc5VTc6
         Vv0wf8YPEJHvpW83D4eIj9xh6iRvOSogWl2OtDYoU8WUFDkaapw/UeQE8619aLo8by93
         UuhxUX95BrsbX2kRtBhwrH/huA3gjHTsLTMNo=
Received: by 10.227.138.5 with SMTP id y5mr5205184wbt.204.1282022252163;
        Mon, 16 Aug 2010 22:17:32 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w32sm5362564wbd.1.2010.08.16.22.17.31
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 22:17:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.389.gc3d0b
In-Reply-To: <AANLkTik4FL56EM4HdpfZ7ha8GNkbLsJeb415WFWUh+O_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153699>

Now that we have a regex engine that supports REG_STARTEND this test
should fail if "git grep" can't grep NULL characters.

Platforms that don't have a POSIX regex engine which supports
REG_STARTEND should always define NO_REGEX=3DYesPlease when compiling.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t7008-grep-binary.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index eb8ca88..c0f9f3f 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -61,7 +61,7 @@ test_expect_success 'git grep -Fi iLE a' '
=20
 # This test actually passes on platforms where regexec() supports the
 # flag REG_STARTEND.
-test_expect_failure 'git grep ile a' '
+test_expect_success 'git grep ile a' '
 	git grep ile a
 '
=20
--=20
1.7.2.1.389.gc3d0b
