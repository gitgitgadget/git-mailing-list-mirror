From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 2/4] apply: apply works outside a repository
Date: Sun, 22 Nov 2009 20:43:42 +0100
Message-ID: <4B09946E.6050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 22 20:43:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCILe-0005v3-It
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 20:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbZKVTni convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 14:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753846AbZKVTni
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 14:43:38 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:52054 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbZKVTnh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 14:43:37 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so1206009ewy.21
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 11:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=2mLJl27hyfmx5KL2R5PKvS2FivduJrzvpFMRwIhs//Q=;
        b=u8U5MKiP+wMkq44mPIotYSAr672qaRSDS2cEZZUlLkcS22nL24Oha9ObfljdL9oFYX
         Q+QM1Ibn/kkHztMFtr7/jRrv4uJJNuFznVpjNPb6OV+UGnaOoHREA3qNKH11XuwVMrRb
         dHzhsEETUOD8qegW5G4W78OI5VB7lrM3yfxZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=rnwYOlVDEHXyBLNIqitqp3PLbZijfSJ0exKMMtaeu6VwgUj7dFK+4q3fvwpmDUgF2P
         2dBK7HPuWNg6IRvq4mHl9uFZY4cjLfR3GPEc612Wq3LVvzCrj86Koa0WajUmBlXiy7Kf
         UlEsLbAcpwoPRCvrtDlET5CUfJRyJR4ZrwDgM=
Received: by 10.213.23.151 with SMTP id r23mr3828319ebb.63.1258919023832;
        Sun, 22 Nov 2009 11:43:43 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 10sm872171eyz.7.2009.11.22.11.43.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Nov 2009 11:43:43 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133452>

The documentation for 'git apply' talks about applying a
patch/diff to the index and to the working tree, which seems
to imply that it will not work outside a git repository.

Actually 'git patch' works outside a repository (which can
be useful especially for applying binary or rename patches that
the standard "patch" utility cannot handle), so the documentation
should mention it.

Thanks to Junio for suggesting better wording.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 Documentation/git-apply.txt |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 0156ca9..0c55ca9 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -3,7 +3,7 @@ git-apply(1)
=20
 NAME
 ----
-git-apply - Apply a patch on a git index file and/or a working tree
+git-apply - Apply a patch to files and/or to the index
=20
=20
 SYNOPSIS
@@ -20,8 +20,11 @@ SYNOPSIS
=20
 DESCRIPTION
 -----------
-Reads supplied 'diff' output and applies it on a git index file
-and a work tree.
+Reads the supplied diff output (i.e. "a patch") and applies it to file=
s.
+With the `--index` option the patch is also applied to the index, and
+with the `--cache` option the patch is only applied to the index.
+Without these options, the command applies the patch only to files,
+and does not require them to be in a git repository.
=20
 OPTIONS
 -------
--=20
1.6.5.3.298.g39add
