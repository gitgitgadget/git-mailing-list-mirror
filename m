From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 13/73] gettextize: git-add "remove '%s'" message
Date: Tue, 22 Feb 2011 23:41:32 +0000
Message-ID: <1298418152-27789-14-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:48:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1xV-0001bt-8z
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807Ab1BVXrV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:47:21 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39375 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756Ab1BVXno (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:44 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866600bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=V8kVBi3IrNGsDu8Eti0hNiiuE8QMM+Q1P1T4rv/GYoo=;
        b=TnP1lvsUxCY+EseKkn/9haSLu4EEguZbrg0sU7d5P9TPQUrZc2t9fdja7y6vKKQTUk
         9rTbVfZOqR2bpVjyiykRvMPvJ+2yTAN6T0b7spE8PGvUcbhmP65HmXwxls8VX4evzXE3
         kejqaj7yaSHpytHwOoyNGBypZ70rVvU41e7AA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ebiH21cAv6lM2vTs4SuZ9Djl1h8I+2lO/20ZVujSHt1W0gzTy0Ux7nhXxN+Squ1JtQ
         /vvRsWejhBwlXm81u1R6WlfGTZJMsf/G27q8tfLKXAIw7cHiBkv+jC0APLn8PoK5LYM7
         liqr6xOcyQa1E/bNU5ii6PFMxjPlt1O2iWqvg=
Received: by 10.204.72.137 with SMTP id m9mr2972067bkj.191.1298418223490;
        Tue, 22 Feb 2011 15:43:43 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.42
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:42 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167660>

Make the "remove '%s'" message translatable. It's displayed under `git
add -u --verbose`. Also skip the corresponding test when output is not
in the C locale.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/add.c         |    2 +-
 t/t2200-add-update.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ffbd459..33b9970 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -74,7 +74,7 @@ static void update_callback(struct diff_queue_struct =
*q,
 			if (!(data->flags & ADD_CACHE_PRETEND))
 				remove_file_from_index(&the_index, path);
 			if (data->flags & (ADD_CACHE_PRETEND|ADD_CACHE_VERBOSE))
-				printf("remove '%s'\n", path);
+				printf(_("remove '%s'\n"), path);
 			break;
 		}
 	}
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 0692427..856e7da 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -111,7 +111,7 @@ test_expect_success 'touch and then add explicitly'=
 '
=20
 '
=20
-test_expect_success 'add -n -u should not add but just report' '
+test_expect_success C_LOCALE_OUTPUT 'add -n -u should not add but just=
 report' '
=20
 	(
 		echo "add '\''check'\''" &&
--=20
1.7.2.3
