From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] init-db: Store current value of autocrlf
Date: Sun, 23 Mar 2008 10:34:13 +0100 (CET)
Message-ID: <alpine.OSX.1.00.0803231032180.7541@cougar>
References: <f5d99ae7-e4b3-4632-ad86-8ebe0e683d49@d62g2000hsf.googlegroups.com> <alpine.LSU.1.00.0803101327390.3975@racer.site> <bdca99240803100611s3c8b3b9djb1b993c9fbad712@mail.gmail.com> <alpine.LSU.1.00.0803101448430.3975@racer.site> <cb8f4255-2bf8-4489-aeb0-c18d6e932342@s13g2000prd.googlegroups.com> <ab311292-809f-4e45-a19d-a600c2333ab6@a23g2000hsc.googlegroups.com> <alpine.OSX.1.00.0803221036230.7618@cougar> <7vzlsqfe2h.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803230310500.4353@racer.site> <alpine.OSX.1.00.0803230943500.7541@cougar>
Reply-To: prohaska@zib.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, tormod.hystad@gmail.com, msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Mar 23 10:34:16 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdMad-0001vm-LE
	for gcvm-msysgit@m.gmane.org; Sun, 23 Mar 2008 10:34:07 +0100
Received: by yw-out-2122.google.com with SMTP id 1so1328460ywp.9
        for <gcvm-msysgit@m.gmane.org>; Sun, 23 Mar 2008 02:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=gamma;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=lUXmEAqhjVhTNKPJTxM/rN9iwfkW1ls2ZBIaFrKb1/k=;
        b=2Xn/WhnS2kVzVSyEQrvpKepC0aAtWH9h/b/9xYirNSiRZZftIcScesHg10HzwAeCdmLgjCfSUTV6ITfrFv29xRtU9IWlpPGro4WgM8V6SxwJYK4itsZLPuzNIfDO8eEPo3nveFNw18bQWoy0u7LKo+O1qhKIZdlkpuv+uV4eeAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=gamma;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=R6RJVuxCHLF6eiDE5MTJBecF/YOJOygMgSaIRZIEtVp6vX/tYpHqEY0JOpQIkFgx9cTpD5TjUsDyrbn+n9Xp7QbJMB/km6msPQ2r5apBLoaqJ0liZxaTQUUAvShlyPouiEXbebhUzfEQ3GPZKlhd/5Bjo0ek+Tm2cCJ01EVH3yE=
Received: by 10.100.94.14 with SMTP id r14mr1330473anb.28.1206264807374;
        Sun, 23 Mar 2008 02:33:27 -0700 (PDT)
Received: by 10.44.52.9 with SMTP id z9gr1993hsz.0;
	Sun, 23 Mar 2008 02:33:27 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.35.13.4 with SMTP id q4mr6228124pyi.7.1206264806524; Sun, 23 Mar 2008 02:33:26 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id z53si7355900pyg.1.2008.03.23.02.33.25; Sun, 23 Mar 2008 02:33:26 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.14.2/8.14.2) with ESMTP id m2N9XMDw011518; Sun, 23 Mar 2008 10:33:22 +0100 (CET)
Received: from cougar (brln-4db97827.pool.einsundeins.de [77.185.120.39]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m2N9XLTv006301 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Sun, 23 Mar 2008 10:33:21 +0100 (MET)
In-Reply-To: <alpine.OSX.1.00.0803230943500.7541@cougar>
User-Agent: Alpine 1.00 (OSX 882 2007-12-20)
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77873>


Storing the current value of autocrlf to preserve it for this repository
even if the global setup changes is a good idea.  Changing autocrlf
later is tricky because the work tree's line endings depend on the
settings during checkout.  Therefore, it makes sense to preserve the
value of autocrlf that exists during the first checkout.  In this
regards autocrlf is different from, for example, author, because author
can be easily changed later without requiring any conversion of existing
files in the work tree.

This commit modifies the initialization of a new repository to store the
current value of autocrlf.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 builtin-init-db.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 79eaf8d..6c49a82 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -268,6 +268,22 @@ static int create_default_files(const char *git_dir, const char *template_path)
 			git_config_set("core.symlinks", "false");
 	}
 
+	/*
+	 *  Store current value of auto_crlf to preserve it for
+	 *  this repository even if the global setup changes.
+	 */
+	switch (auto_crlf) {
+	case -1:
+		git_config_set("core.autocrlf", "input");
+		break;
+	case 0:
+		git_config_set("core.autocrlf", "false");
+		break;
+	case 1:
+		git_config_set("core.autocrlf", "true");
+		break;
+	}
+
 	return reinit;
 }
 
-- 
1.5.5.rc0.21.g740fd.dirty
