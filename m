From: Anders Kaseorg <andersk@ksplice.com>
Subject: [PATCH v2 1/4] describe: Use for_each_rawref
Date: Tue, 7 Dec 2010 23:42:35 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1012072341570.23348@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu> <20101203084348.GD18202@burratino> <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu> <20101206073214.GA3745@burratino> <alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu>
 <7vfwu9qvew.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.02.1012072204371.23348@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 05:42:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQBrY-0003LP-Dg
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 05:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147Ab0LHEmj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 23:42:39 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62125 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab0LHEmi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 23:42:38 -0500
Received: by vws16 with SMTP id 16so599349vws.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 20:42:38 -0800 (PST)
Received: by 10.229.219.212 with SMTP id hv20mr6515647qcb.223.1291783358079;
        Tue, 07 Dec 2010 20:42:38 -0800 (PST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
        by mx.google.com with ESMTPS id n7sm144961qcu.40.2010.12.07.20.42.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 20:42:37 -0800 (PST)
X-X-Sender: andersk@dr-wily.mit.edu
In-Reply-To: <alpine.DEB.2.02.1012072204371.23348@dr-wily.mit.edu>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163167>

Don=E2=80=99t waste time checking for dangling refs; they wouldn=E2=80=99=
t affect the
output of =E2=80=98git describe=E2=80=99 anyway.  Although this doesn=E2=
=80=99t gain much
performance by itself, it does in conjunction with the next commits.

Signed-off-by: Anders Kaseorg <andersk@ksplice.com>
---
 builtin/describe.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 43caff2..700f740 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -418,7 +418,7 @@ int cmd_describe(int argc, const char **argv, const=
 char *prefix)
 		return cmd_name_rev(i + argc, args, prefix);
 	}
=20
-	for_each_ref(get_name, NULL);
+	for_each_rawref(get_name, NULL);
 	if (!found_names && !always)
 		die("No names found, cannot describe anything.");
=20
--=20
1.7.3.3
