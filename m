From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH] git grep -O -i: if the pager is 'less', pass the
 '-i' option
Date: Wed, 14 May 2014 17:50:10 +0200
Organization: <)><
Message-ID: <20140514155010.GA4592@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
        msysGit <msysgit@googlegroups.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBNFBZ2NQKGQEOCFZCRY@googlegroups.com Wed May 14 17:50:13 2014
Return-path: <msysgit+bncBCU63DXMWULRBNFBZ2NQKGQEOCFZCRY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f64.google.com ([74.125.82.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBNFBZ2NQKGQEOCFZCRY@googlegroups.com>)
	id 1WkbRd-0001em-0w
	for gcvm-msysgit@m.gmane.org; Wed, 14 May 2014 17:50:13 +0200
Received: by mail-wg0-f64.google.com with SMTP id m15sf198566wgh.29
        for <gcvm-msysgit@m.gmane.org>; Wed, 14 May 2014 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:mime-version:organization
         :user-agent:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=Ur5EkUNzpvTrjmhC0ZhaDi1FsX2ZrcZQ6JlWWv8OMEU=;
        b=xUosfHZy+RiMJqxU27HBB2S0gl6Bam5NoCRbLd2kfWKYTlySqm+rzz8b9+18t23Uco
         rhBpRQ1S6xLw64oqRl+smQ4Crl9FCgbns7qHE7N/I2Rbb4BKi0PG3fvd3KfmelZARpxY
         eBxoMEgSbGN5Dc+i8R0XmqGfW+HoZOpFXtQF6ZI1U/rwjAKkklT5y4p4wttqnmjw6nKt
         3mIcj0xJ++DCDYV1M7H0MLrS2VPFELD9dKAlMwIvRg9MFZmXz16EoF8DU9sAMM8GXt0l
         KNTWBwadQWSX8UwZVjMzMKVJuOsG0CFEcYP+e90LqXpZa4+iD84+NEhn6a9qMXHCGrRu
         PJ5w==
X-Received: by 10.152.2.228 with SMTP id 4mr15072lax.37.1400082612718;
        Wed, 14 May 2014 08:50:12 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.153.6.12 with SMTP id cq12ls128052lad.86.gmail; Wed, 14 May
 2014 08:50:11 -0700 (PDT)
X-Received: by 10.152.36.226 with SMTP id t2mr432422laj.1.1400082611714;
        Wed, 14 May 2014 08:50:11 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id u49si773218eeo.1.2014.05.14.08.50.11
        for <msysgit@googlegroups.com>;
        Wed, 14 May 2014 08:50:11 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 6BEE61C0089;
	Wed, 14 May 2014 17:50:11 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s4EFoBqR004598;
	Wed, 14 May 2014 17:50:11 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s4EFoA7v004597;
	Wed, 14 May 2014 17:50:11 +0200
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248922>

From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Tue, 8 Feb 2011 00:17:24 -0600

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
Hi,
this patch has been in msysgit for 3 1/4 years.
  Stepan

 builtin/grep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index 8073fbe..6c82a29 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -897,6 +897,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		if (len > 4 && is_dir_sep(pager[len - 5]))
 			pager += len - 4;
 
+		if (opt.ignore_case && !strcmp("less", pager))
+			string_list_append(&path_list, "-i");
+
 		if (!strcmp("less", pager) || !strcmp("vi", pager)) {
 			struct strbuf buf = STRBUF_INIT;
 			strbuf_addf(&buf, "+/%s%s",
-- 
1.9.2.msysgit.0.335.gd2a461f

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
