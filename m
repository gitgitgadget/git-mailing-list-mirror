From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] Add cpp macro implementation of treaps
Date: Sun, 30 May 2010 04:31:51 -0500
Message-ID: <20100530093151.GB5513@progeny.tock>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
 <1274650832-7411-3-git-send-email-artagnon@gmail.com>
 <20100529071811.GA6648@progeny.tock>
 <AANLkTilHgXD1mzrTE0PQKeLWM7uheNmZ62ZJGGxuh-7E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Jason Evans <jasone@canonware.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 11:31:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIera-0001Nn-Ah
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 11:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416Ab0E3JbR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 05:31:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64480 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab0E3JbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 05:31:16 -0400
Received: by iwn6 with SMTP id 6so310041iwn.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 02:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Y5o16MMMNGTsyVZMwlzXbMLD3f4aec5aihCh16kHpfs=;
        b=fQxZ4fMpUkTjZ44sdo+SltlsXqScHopKVsf9wJSvT79KssfKw0JEHQuwQkQ7ROk1+a
         Ai8/zIt5uoOX4UiHmH1f0oMU1Xu/d+qGYg2zBTCXgnUGITYs/vP8EAtCimwAPJA2Nj/O
         KG8jjzOqnkgjHR+ovOB9JJ3rx8TrUaxdbt9tI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=KNcv14m544dAwPnKWtyVuHhzZ8lP6ppUYqOM2xzIqHppqj7d2R/d7GjT/Wjz6GifDx
         nBUITNr10kKpdYL5/lIJuceujONs/AkWSr4ArUMsrJQSruyKkWuj95UGytGhAX3uBX4s
         vhsxIgdzPHfS/68qLTi3qmB5eI698sFsLw21I=
Received: by 10.231.149.203 with SMTP id u11mr3746396ibv.6.1275211875182;
        Sun, 30 May 2010 02:31:15 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f1sm20341141ibg.3.2010.05.30.02.31.13
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 02:31:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTilHgXD1mzrTE0PQKeLWM7uheNmZ62ZJGGxuh-7E@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147993>

Ramkumar Ramachandra wrote:
> Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Also: http://www.canonware.com/trp/ seems to provide a test program;
>> do you think it would make sense to include it as well?
>
> Probably in documentation/technical?

I was thinking in the toplevel, but I wasn=E2=80=99t thinking about how=
 much
of trp.h was removed.

Of course svn-fe itself is a pretty good test that the treap is
working as it should.  So I wouldn=E2=80=99t worry about it.

Jonathan

 Makefile               |    1 +
 t/t0070-fundamental.sh |    4 ++++
 test-treap.c           |    8 ++++++++
 3 files changed, 13 insertions(+), 0 deletions(-)
 create mode 100644 test-treap.c

diff --git a/Makefile b/Makefile
index 2f5d631..a26bceb 100644
--- a/Makefile
+++ b/Makefile
@@ -403,6 +403,7 @@ TEST_PROGRAMS_NEED_X +=3D test-path-utils
 TEST_PROGRAMS_NEED_X +=3D test-run-command
 TEST_PROGRAMS_NEED_X +=3D test-sha1
 TEST_PROGRAMS_NEED_X +=3D test-sigchain
+TEST_PROGRAMS_NEED_X +=3D test-treap
 TEST_PROGRAMS_NEED_X +=3D test-index-version
=20
 TEST_PROGRAMS =3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 680d7d6..7522bdc 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -12,4 +12,8 @@ test_expect_success 'character classes (isspace, isal=
pha etc.)' '
 	test-ctype
 '
=20
+test_expect_success 'treap data structure' '
+	test-treap
+'
+
 test_done
diff --git a/test-treap.c b/test-treap.c
new file mode 100644
index 0000000..f94a931
--- /dev/null
+++ b/test-treap.c
@@ -0,0 +1,8 @@
+#include "git-compat-util.h"
+#include "vcs-svn/trp.h"
+#include "vcs-svn/obj_pool.h"
+
+#define NNODES 32
+#define NSETS 200
+
+tests go here
--=20
1.7.1
