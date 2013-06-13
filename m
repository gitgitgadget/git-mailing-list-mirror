From: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH RFC] show-branch: use pager
Date: Thu, 13 Jun 2013 08:43:31 +0200
Message-ID: <1371105811-3112-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 13 08:44:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un1GK-0001Uq-J5
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 08:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778Ab3FMGn4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Jun 2013 02:43:56 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:62729 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab3FMGnz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 02:43:55 -0400
Received: by mail-la0-f54.google.com with SMTP id ec20so8682776lab.13
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 23:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=ZugFtAYZN54MO2vwdlpqr9PlNImC/Lz5HAKMBSqjKfQ=;
        b=dT5lXNwxmrkDV3I3WOavYSdHL4L9LtOaWbJUSrTyhUfncLHU/Nflo/rOPJLlyC1Jip
         Ll+Yf/tyVT+9axSH86u5xb8b1Icl7KZxGIXFsHf+NarbliVkQOzjj3QDHAjd6eHbTEFA
         Sm4BNvLzmEF3PTNL4RusLROujB3YuuksESg4slNZwFiPwlf2grtRRPHQDnKk6j3HJyAl
         eoXiBblML0+yzCs0ZCccpAk+X1NHwFbmnoLk9T73M5tgs8C+kuZH7CiD5jAHTHL8WKUD
         yosJibfxSERebS+08pW9ZfCGplxFalQ7tttlBuUmFkRp8LMZYSanuBIHO/UsEBnrNbAI
         SwLA==
X-Received: by 10.152.44.170 with SMTP id f10mr11073756lam.68.1371105834200;
        Wed, 12 Jun 2013 23:43:54 -0700 (PDT)
Received: from osse-w760.lan (147.137.202.84.customer.cdi.no. [84.202.137.147])
        by mx.google.com with ESMTPSA id e9sm10201949lbj.3.2013.06.12.23.43.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Jun 2013 23:43:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227699>

This is for consistency with other porcelain commands such as 'log'.

Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
---
The rationale for this patch I hope is consicely explained in the commi=
t
message. I was rather surprised it didn't use a pager as I've gotten us=
ed to it
for most commands.

I marked this as an RFC because of Jeff King's comments in
daa0c3d97 where I got the impression this this might not be a good idea=
=2E
However I haven't found any bugs and all the tests pass. It is more a h=
uble
suggestion than anything but I thought I might as well send it as a pat=
ch.

setup_pager() is already pulled in via cache.h so there was no need to =
add any
#include directive. I suppose this is as close to a one-liner as it get=
s :)

Best regards,
=C3=98sse

 builtin/show-branch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 90fc6b1..bd3e10c 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -683,6 +683,7 @@ int cmd_show_branch(int ac, const char **av, const =
char *prefix)
 	};
=20
 	git_config(git_show_branch_config, NULL);
+	setup_pager();
=20
 	/* If nothing is specified, try the default first */
 	if (ac =3D=3D 1 && default_num) {
--=20
1.8.2.2
