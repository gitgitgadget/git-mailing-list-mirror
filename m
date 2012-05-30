From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 03/65] i18n: archive: mark parseopt strings for
 translation
Date: Wed, 30 May 2012 19:25:34 +0700
Message-ID: <20120530122533.GA28235@do>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com>
 <20120528224729.GK14606@burratino>
 <CACsJy8ANyMxLNCP1P28AKywssGdSQP3QnE_HZHHGzkX-4oqFtw@mail.gmail.com>
 <20120529121428.GD14697@burratino>
 <7vmx4q4ycj.fsf@alter.siamese.dyndns.org>
 <CACsJy8BvZSbsXyh3ct-M3rcWQf9Fw4VDX2VYVy+0Hv+53AQWnw@mail.gmail.com>
 <20120530062424.GA19114@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 14:29:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZi2A-00076m-LT
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 14:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367Ab2E3M3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 08:29:46 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51656 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185Ab2E3M3p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 08:29:45 -0400
Received: by dady13 with SMTP id y13so6864537dad.19
        for <git@vger.kernel.org>; Wed, 30 May 2012 05:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9/HnEN4SXNxqtSldX14rTSsSYfBar5cRD2wXmCv3AfY=;
        b=lkHV3Akwoal9Vp1I/XJS67Q7hhF3ovDT9Uag8d1hS64w7a8VZcTxocmzDU3xiRIpVv
         5I1nZiXc5Jkzqc6PS7ib4grxOEfYOcWa+KT1z5Mon9mXY0ymRLodxvZfN7d+oQFZU1M0
         7KFuVVC0/DEsD9ZTwghQ90Wki//eeXOEQl3c0/h3W5fFF/ZUD4czoMtWdRwbdbvVC2UN
         e1qORZVZz5J4DE9nUHCp5Aye6XGWAr/g/h4EVrfvDPq+gZniPbb/bgxmh+5FSVYiqylB
         ETolwTFkSwFI1QindPlIXZ2P5ewvaXWzNZZGvwkKoxcu0q5ifyf+h7aiJE57Z1It2Fl4
         nRCg==
Received: by 10.68.238.228 with SMTP id vn4mr48769523pbc.132.1338380984705;
        Wed, 30 May 2012 05:29:44 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.14])
        by mx.google.com with ESMTPS id ub8sm354678pbc.44.2012.05.30.05.29.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 May 2012 05:29:42 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 30 May 2012 19:25:34 +0700
Content-Disposition: inline
In-Reply-To: <20120530062424.GA19114@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198807>

On Wed, May 30, 2012 at 01:24:24AM -0500, Jonathan Nieder wrote:
> Nguyen Thai Ngoc Duy wrote:
> 
> >                             Or generate a poisoned .mo file, then make
> > git use that.
> 
> Yes, I would like that very much.  I had vague ideas of using some
> valid language code that doesn't correspond to a human language, but
> an alternate GIT_TEXTDOMAINDIR might be simpler and work better.

We're half way there with the following PoC patch. Now if only I could
trick gettext into accepting a fake language like "foo". Right now
"vi" is the sacrified one

$ make po/build/locale/vi/LC_MESSAGES/git.mo
$ GIT_TEXTDOMAINDIR=po/build/locale ./git st -abc
error: unknown switch `a'
.................................................

    -v, --verbose         ..........
    -s, --short           .....................
    -b, --branch          .......................
    --porcelain           .......................
    -z, --null            ..........................
    -u, --untracked-files[=<....>]
                          .....................................................................
    --ignored             ..................
    --ignore-submodules[=<....>]
                          ..................................................................................
    --column[=<.....>]    list untracked files in columns

We also need to improve the shredder to recognize shell variables,
then we can turn on GETTEXT_LOG_UNTRANSLATED to catch i18n messages
that are not marked

-- 8< --
diff --git a/Makefile b/Makefile
index 96ebcf9..cd55650 100644
--- a/Makefile
+++ b/Makefile
@@ -2345,6 +2345,18 @@ LOCALIZED_SH += t/t0200/test.sh
 LOCALIZED_PERL += t/t0200/test.perl
 endif
 
+shredder: shredder.c
+	$(QUIET_CC)$(CC) -o $@ $^
+
+po/build/locale/vi/LC_MESSAGES/git.mo: $(LOCALIZED_C) shredder
+	mkdir -p `dirname $@`
+	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
+	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_SH) \
+		$(LOCALIZED_SH)
+	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_PERL) \
+		$(LOCALIZED_PERL)
+	msgen $@+|sed 's/charset=CHARSET/charset=utf-8/'|sed '/^#, fuzzy/d'|msgfilter ./shredder|msgfmt -o $@ -
+
 po/git.pot: $(LOCALIZED_C)
 	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
 	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_SH) \
diff --git a/shredder.c b/shredder.c
new file mode 100644
index 0000000..ea12c10
--- /dev/null
+++ b/shredder.c
@@ -0,0 +1,62 @@
+#include <stdio.h>
+#include <string.h>
+
+static const char *header =
+"Project-Id-Version: git.git\n"
+"Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
+"POT-Creation-Date: 2012-05-15 06:42+0800\n"
+"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
+"Last-Translator: 2012-05-15 06:42+0800\n"
+"Language-Team: gettext poison <gettext@poison.org>\n"
+"Language: poison\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=utf-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=2; plural=nr != 1;\n";
+
+static int is_fmt = 0;
+static int shred(int ch)
+{
+	const char *terminators = "diouxXeEfFgGaAcsp%";
+	if (is_fmt && strchr(terminators, ch))
+		is_fmt = 0;
+	else if (!is_fmt && isprint(ch)) {
+		if (ch == '%')
+			is_fmt = 1;
+		else
+			ch = '.';
+	}
+	return ch;
+}
+
+int main(int ac, char **av)
+{
+	const char *first_msg = "Project-Id-Version: ";
+	char buf[32];
+	int gotten = 0, len = strlen(first_msg);
+	int ch;
+	while ((ch = fgetc(stdin)) != EOF)
+	{
+		if (gotten < len) {
+			buf[gotten++] = ch;
+			if (gotten == len) {
+				if (!strncmp(first_msg, buf, len)) {
+					fputs(header, stdout);
+					return 0;
+				} else {
+					int i;
+					for (i = 0; i < len; i++)
+						putchar(shred(buf[i]));
+				}
+			}
+			continue;
+		}
+		putchar(shred(ch));
+	}
+	if (gotten < len) {
+		int i;
+		for (i = 0; i < gotten; i++)
+			putchar(shred(buf[i]));
+	}
+	return 0;
+}
-- 8< --
-- 
Duy
