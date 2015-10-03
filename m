From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 41/68] init: use strbufs to store paths
Date: Sat, 3 Oct 2015 07:58:48 +0200
Message-ID: <560F6E98.8030305@web.de>
References: <20150924210225.GA23624@sigill.intra.peff.net>
 <20150924210736.GL30946@sigill.intra.peff.net>
 <CAO2U3QjunOPoAbGSRjAmCwfk-TnoMveXOJhpb351eh1a_3Xp3A@mail.gmail.com>
 <20150930002347.GA23406@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 07:59:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiFqZ-0000nT-2d
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 07:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbbJCF65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 01:58:57 -0400
Received: from mout.web.de ([212.227.17.12]:50210 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbbJCF65 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 01:58:57 -0400
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MWjAd-1a9vsG24lP-00Xpp0; Sat, 03 Oct 2015 07:58:51
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.2.0
In-Reply-To: <20150930002347.GA23406@sigill.intra.peff.net>
X-Provags-ID: V03:K0:VLF5NS/l3KrNNd3O47bjSAakIIfkhIaHuY58BWnv4k/OyR4n0j5
 e2V3bkSB01YOfLUBKXw2X2LfGtEtgFy1VoaopQjTvXsNL3iTjTOXNiZ1TAK8HYSwwSjSn86
 5FZbffFMJl4mm6Y88xmXCSUPHRE8jiwXw2sbFJBx3uv1dsPpZjOTJWlUMsFdPahgjaaAro3
 2ct4X6v8jayZ/Pbuqldww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B8NLVMMjsTU=:wnrxM6u2mlgBAKZJIfdJaz
 H922m9zJTj8vuszSPDoK/3qMTOM2FYRBsD80ze8ssMfT0Ui7ZOrAcJTpzsEzWNk+Gq5mgTyjc
 whoHTHH7doz+OKfM567YeEDs+dIqat9G4BDFfhfkJJFLeR5oRn53+9V8ZB9xAsQnLPVORw45S
 DPIDZ/HTvNvHUqzLJk0NxcyRCbOJ7nV9hJoLB4Z03fnPYO+FyBGiHYM76RwSrI+JICkFjGLPp
 GOl7EtCU1Ud7yJt89LWxp6S1dvmVo0e1Ylbs+ClVTvwquzkkRxtb0RR9WtMi+Qss2NjvjDKob
 AqzaOf0YiVL5kGoq8pin716GadKB+hd3qv218WcTXlsj6RvKTKpXh/ZVq/tTFnn+QCVkvVjS8
 dR9RhU0fyktbi0JRWQUPZMHcPiozCNCZudCKn2CEp3z3MrLBVFpxBm3q8F35MWlg0SKCMIWq3
 2II+mvYeLr5lT/eYOseFNpOoyPlYuwKvA5D5Vn98DaqpOrddMQfSHOK865rrWEtW4Xu7tP3r9
 TDVNleQUNd4a9j5NG6qwIgq+jaCkfSGwF5ZcrO11Q26PIQuV2boxx8E/8gDhqik2EqocK1esh
 EXygH3VGXyymcZdAWe32dLvIFT/AkfwL526ngFRT3w8Teq8NW74ubxHzycsSgA+N4OKeCFRl1
 f9TluF2AlQCKGA1L6XDZgwSz9o2ifwnpx9tq1UpPBcsJseQXWi0SKJ0sVmlta9NV3cKqyVUhh
 WDi02kyO5rRsI6OL5xaAqLVC66qfPOXPOOZ4v2kTAKukYAA+jwwm+ug1cKNGPlLtEuO01qNO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278955>

On 30.09.15 02:23, Jeff King wrote:
> On Tue, Sep 29, 2015 at 04:50:39PM -0700, Michael Blume wrote:
> 
>> I see compile errors on my mac:
>>

This is my attempt, passing the test, but not fully polished.




diff --git a/builtin/init-db.c b/builtin/init-db.c
index 89f2c05..60b559c 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -276,7 +276,9 @@ static int create_default_files(const char *template_path)
 		path = git_path_buf(&buf, "CoNfIg");
 		if (!access(path, F_OK))
 			git_config_set("core.ignorecase", "true");
-		probe_utf8_pathname_composition(path);
+		/* Probe utf-8 normalization withou mangling CoNfIG */
+		path = git_path_buf(&buf, "config");
+		probe_utf8_pathname_composition(path, strlen(path));
 	}
 
 	strbuf_release(&buf);
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index b4dd3c7..37172a4 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "utf8.h"
 #include "precompose_utf8.h"
+#include "strbuf.h"
 
 typedef char *iconv_ibp;
 static const char *repo_encoding = "UTF-8";
@@ -36,28 +37,33 @@ static size_t has_non_ascii(const char *s, size_t maxlen, size_t *strlen_c)
 }
 
 
-void probe_utf8_pathname_composition(struct strbuf *path)
+void probe_utf8_pathname_composition(char *path, int len)
 {
 	static const char *auml_nfc = "\xc3\xa4";
 	static const char *auml_nfd = "\x61\xcc\x88";
-	size_t baselen = path->len;
+	struct strbuf sbuf;
 	int output_fd;
 	if (precomposed_unicode != -1)
 		return; /* We found it defined in the global config, respect it */
-	strbuf_addstr(path, auml_nfc);
-	output_fd = open(path, O_CREAT|O_EXCL|O_RDWR, 0600);
+	strbuf_init(&sbuf, len+3);
+	strbuf_add(&sbuf, path, len);
+	strbuf_addstr(&sbuf, auml_nfc);
+	output_fd = open(sbuf.buf, O_CREAT|O_EXCL|O_RDWR, 0600);
+	fprintf(stderr, "%s/%s:%d sbuf.buf=%s\n",
+					__FILE__, __FUNCTION__, __LINE__, sbuf.buf);
 	if (output_fd >= 0) {
 		close(output_fd);
-		strbuf_setlen(path, baselen);
-		strbuf_addstr(path, auml_nfd);
+		strbuf_setlen(&sbuf, len);
+		strbuf_addstr(&sbuf, auml_nfd);
+	fprintf(stderr, "%s/%s:%d sbuf.buf=%s\n",
+					__FILE__, __FUNCTION__, __LINE__, sbuf.buf);
 		precomposed_unicode = access(path, R_OK) ? 0 : 1;
 		git_config_set("core.precomposeunicode", precomposed_unicode ? "true" : "false");
-		strbuf_setlen(path, baselen);
-		strbuf_addstr(path, auml_nfc);
+		strcpy(path + len, auml_nfc);
 		if (unlink(path))
 			die_errno(_("failed to unlink '%s'"), path);
 	}
-	strbuf_setlen(path, baselen);
+	strbuf_release(&sbuf);
 }
 
 
diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
index 7fc7be5..3b73585 100644
--- a/compat/precompose_utf8.h
+++ b/compat/precompose_utf8.h
@@ -27,7 +27,7 @@ typedef struct {
 } PREC_DIR;
 
 void precompose_argv(int argc, const char **argv);
-void probe_utf8_pathname_composition(struct strbuf *path);
+void probe_utf8_pathname_composition(char *, int);
 
 PREC_DIR *precompose_utf8_opendir(const char *dirname);
 struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *dirp);
