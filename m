From: Anders Kaseorg <andersk@ksplice.com>
Subject: [PATCH v3 1/4] describe: Use for_each_rawref
Date: Thu, 9 Dec 2010 01:42:25 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1012090140390.23348@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu> <20101203084348.GD18202@burratino> <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu> <20101206073214.GA3745@burratino> <alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu>
 <7vfwu9qvew.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.02.1012072204371.23348@dr-wily.mit.edu> <alpine.DEB.2.02.1012072341570.23348@dr-wily.mit.edu> <alpine.DEB.2.02.1012072344000.23348@dr-wily.mit.edu> <7v7hfjkhfm.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.02.1012081800540.23348@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 07:42:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQaD5-0005U5-Sr
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 07:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859Ab0LIGm3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 01:42:29 -0500
Received: from mail-qy0-f177.google.com ([209.85.216.177]:40663 "EHLO
	mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843Ab0LIGm2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Dec 2010 01:42:28 -0500
Received: by qyk27 with SMTP id 27so1615936qyk.1
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 22:42:28 -0800 (PST)
Received: by 10.224.28.81 with SMTP id l17mr7844016qac.282.1291876947821;
        Wed, 08 Dec 2010 22:42:27 -0800 (PST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
        by mx.google.com with ESMTPS id m7sm968556qck.37.2010.12.08.22.42.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 22:42:26 -0800 (PST)
X-X-Sender: andersk@dr-wily.mit.edu
In-Reply-To: <alpine.DEB.2.02.1012081800540.23348@dr-wily.mit.edu>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163267>

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
