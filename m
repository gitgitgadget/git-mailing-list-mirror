From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] add -p: make the beginning of the hunk easier to see
Date: Sat, 13 Feb 2010 12:07:51 +0100
Message-ID: <4B768807.3030003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 12:08:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgFqy-00018d-3W
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 12:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678Ab0BMLHz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2010 06:07:55 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:60513 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376Ab0BMLHy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 06:07:54 -0500
Received: by ewy28 with SMTP id 28so2430569ewy.28
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 03:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=0Bxz643sJN0wpST1DdoMLMmCUrHeh3DCImhDpZwVOx4=;
        b=MoVLQqXzqzSJLFE6YGgmz0qMOSTUeRSraXMw8mM485jwYT3E48nluGx4CSiIIfZ09Z
         60GIge/hwjnG9yxGLh4MV7t+uFgr7tAVgaY4ceidQFnSnFsNRtH5vOIgqjGaF+TlXkxF
         xOBdqMzp5KD/O/EnpvBQA7Eyo6qH9GWz5J6DM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=ltbZYrIUrUjOWxwhFzNJDxMCTTbk5upsJRA7Dqe59O/FWakkKhxNNTO7lAHemJrkPe
         F3NyLtFuvIkvGqWzD8/mfZvOssqa6MQ/8IPx9fHcXWzLDiaT58fZWmV8fZxvXAZIH6KN
         WCfQIN/KWnT1toJ3poGq0HJxgRUTQM+G9tw6Y=
Received: by 10.213.98.143 with SMTP id q15mr1897072ebn.67.1266059272462;
        Sat, 13 Feb 2010 03:07:52 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 13sm2941106ewy.13.2010.02.13.03.07.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Feb 2010 03:07:52 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139783>

When using "git add -p" to selectively add hunks, I find
it hard to quickly see where the current hunk starts and
the previous stops, because the new hunk starts right
after the action prompt for the previous hunk.

=46acilitate easy scanning for the beginning of the current
hunk by adding some blank lines and a line of equal
signs before the current hunk.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 git-add--interactive.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index cd43c34..4eb7c7c 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1439,6 +1439,8 @@ sub patch_update_file {
 					 !defined $hunk[$ix]{USE});
 			}
 		}
+	} continue {
+		print "\n" x 4, '=3D' x 72, "\n";
 	}
=20
 	@hunk =3D coalesce_overlapping_hunks(@hunk);
--=20
1.7.0
