From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v3 1/8] imap-send: remove useless uid code
Date: Tue, 13 Oct 2009 19:25:18 +0000
Message-ID: <1255461925-2244-2-git-send-email-kusmabite@gmail.com>
References: <1255461925-2244-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Jeff King <peff@peff.net>, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Oct 13 21:26:16 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f161.google.com ([209.85.211.161])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxn0g-0006e1-7H
	for gcvm-msysgit@m.gmane.org; Tue, 13 Oct 2009 21:26:14 +0200
Received: by ywh33 with SMTP id 33so5083562ywh.24
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Oct 2009 12:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=qoN5je92tb7u0O9XWUa7dPqEfNS0QtAe1NFS4GZc7gE=;
        b=MEJaILZx8HI3FM8HoShZYHKk9+6QEsh6vXysFlt91Fs6vF82O1C8n4GCbfyTCPpxP8
         tLx0eRFnsvBIQSfva41u6MWSx1bpE2yKZ5Fxz21JDUItL5lQeIceHQSvVjIadtHscE4A
         NI2k2AfQvoGcUUco96X9iKMarm48UWA4cruvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=D+IHPzpavX2M7R99rsCNGBNMCaPp879E4lHgl1lm5Emedcp3/qcpQrmCbfVS2+z4sR
         L0pcDCAT2tPjMyuphFMfCvHppw/0Im342TZBnYiEpP+cBnZE7+dA+wzaz/dzfS1EMboT
         eE2KpBPkEF0XSRZYMAx/KX8KzsnKbiOB6POLM=
Received: by 10.150.168.4 with SMTP id q4mr911714ybe.24.1255461967128;
        Tue, 13 Oct 2009 12:26:07 -0700 (PDT)
Received: by 10.177.5.4 with SMTP id h4gr7395yqi.0;
	Tue, 13 Oct 2009 12:25:52 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.171.2 with SMTP id y2mr1316840ebo.19.1255461949800; Tue, 13 Oct 2009 12:25:49 -0700 (PDT)
Received: by 10.211.171.2 with SMTP id y2mr1316839ebo.19.1255461949647; Tue, 13 Oct 2009 12:25:49 -0700 (PDT)
Received: from mail-ew0-f215.google.com (mail-ew0-f215.google.com [209.85.219.215]) by gmr-mx.google.com with ESMTP id 13si331809ewy.2.2009.10.13.12.25.48; Tue, 13 Oct 2009 12:25:48 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.215 as permitted sender) client-ip=209.85.219.215;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.215 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by ewy11 with SMTP id 11so11123173ewy.11 for <msysgit@googlegroups.com>; Tue, 13 Oct 2009 12:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references; bh=Wnco47Pj46fkDRCWXBz5cHmdZYFdmN4eswQilDLilPI=; b=qYx582PBA7eQfIaFC8ke0BQfv+p1AIN1+BduY8vecei+LshO3t2Y956NYwSCB4HI3M QdS8ficjoKKQ5ffsXJGSZLNxJD0YDp14UtCP+dloBqaU8mMURO8IMjOeTaFRz+/LOvGA 7Kqkrrt8jTwGwoQ3ihdxxG7OSDYEdZcbs3xo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=XaU8GbRNU2HucW/4ibFs31MEUxDwe+zSuGbcies20AMH/rxl2L9D+8YWQgOy+3Stm7 BgHj3PmP9+eszvKwX3RiS5qt5iWtunt5dlTE5JIakO0aE+ITL1TplVoEFTXyw6SE9u2H AdE6Gf2W4J1zhyFMpGtUtafwYfUDMMAcvyx0A=
Received: by 10.216.87.16 with SMTP id x16mr2512479wee.106.1255461948405; Tue, 13 Oct 2009 12:25:48 -0700 (PDT)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12]) by mx.google.com with ESMTPS id 10sm2485eyd.6.2009.10.13.12.25.47 (version=TLSv1/SSLv3 cipher=RC4-MD5); Tue, 13 Oct 2009 12:25:47 -0700 (PDT)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1255461925-2244-1-git-send-email-kusmabite@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130185>


From: Jeff King <peff@peff.net>

The imap-send code is based on code from isync, a program
for syncing imap mailboxes. Because of this, it has
inherited some code that makes sense for isync, but not for
imap-send.

In particular, when storing a message, it does one of:

  - if the server supports it, note the server-assigned
    unique identifier (UID) given to each message

  - otherwise, assigned a random UID and store it in the
    message header as X-TUID

Presumably this is used in isync to be able to synchronize
mailstores multiple times without duplication. But for
imap-send, the values are useless; we never do anything
with them and simply forget them at the end of the program.

This patch removes the useless code. Not only is it nice for
maintainability to get rid of dead code, but the removed
code relied on the existence of /dev/urandom, which made it
a portability problem for non-Unix platforms.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 imap-send.c |  155 ++++------------------------------------------------------
 1 files changed, 11 insertions(+), 144 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 3847fd1..8da7a94 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -123,9 +123,6 @@ static int nfvasprintf(char **strp, const char *fmt, va_list ap)
 	return len;
 }
 
-static void arc4_init(void);
-static unsigned char arc4_getbyte(void);
-
 struct imap_server_conf {
 	char *name;
 	char *tunnel;
@@ -489,52 +486,6 @@ static int nfsnprintf(char *buf, int blen, const char *fmt, ...)
 	return ret;
 }
 
-static struct {
-	unsigned char i, j, s[256];
-} rs;
-
-static void arc4_init(void)
-{
-	int i, fd;
-	unsigned char j, si, dat[128];
-
-	if ((fd = open("/dev/urandom", O_RDONLY)) < 0 && (fd = open("/dev/random", O_RDONLY)) < 0) {
-		fprintf(stderr, "Fatal: no random number source available.\n");
-		exit(3);
-	}
-	if (read_in_full(fd, dat, 128) != 128) {
-		fprintf(stderr, "Fatal: cannot read random number source.\n");
-		exit(3);
-	}
-	close(fd);
-
-	for (i = 0; i < 256; i++)
-		rs.s[i] = i;
-	for (i = j = 0; i < 256; i++) {
-		si = rs.s[i];
-		j += si + dat[i & 127];
-		rs.s[i] = rs.s[j];
-		rs.s[j] = si;
-	}
-	rs.i = rs.j = 0;
-
-	for (i = 0; i < 256; i++)
-		arc4_getbyte();
-}
-
-static unsigned char arc4_getbyte(void)
-{
-	unsigned char si, sj;
-
-	rs.i++;
-	si = rs.s[rs.i];
-	rs.j += si;
-	sj = rs.s[rs.j];
-	rs.s[rs.i] = sj;
-	rs.s[rs.j] = si;
-	return rs.s[(si + sj) & 0xff];
-}
-
 static struct imap_cmd *v_issue_imap_cmd(struct imap_store *ctx,
 					 struct imap_cmd_cb *cb,
 					 const char *fmt, va_list ap)
@@ -1198,88 +1149,20 @@ static int imap_make_flags(int flags, char *buf)
 	return d;
 }
 
-#define TUIDL 8
-
-static int imap_store_msg(struct store *gctx, struct msg_data *data, int *uid)
+static int imap_store_msg(struct store *gctx, struct msg_data *data)
 {
 	struct imap_store *ctx = (struct imap_store *)gctx;
 	struct imap *imap = ctx->imap;
 	struct imap_cmd_cb cb;
-	char *fmap, *buf;
 	const char *prefix, *box;
-	int ret, i, j, d, len, extra, nocr;
-	int start, sbreak = 0, ebreak = 0;
-	char flagstr[128], tuid[TUIDL * 2 + 1];
+	int ret, d;
+	char flagstr[128];
 
 	memset(&cb, 0, sizeof(cb));
 
-	fmap = data->data;
-	len = data->len;
-	nocr = !data->crlf;
-	extra = 0, i = 0;
-	if (!CAP(UIDPLUS) && uid) {
-	nloop:
-		start = i;
-		while (i < len)
-			if (fmap[i++] == '\n') {
-				extra += nocr;
-				if (i - 2 + nocr == start) {
-					sbreak = ebreak = i - 2 + nocr;
-					goto mktid;
-				}
-				if (!memcmp(fmap + start, "X-TUID: ", 8)) {
-					extra -= (ebreak = i) - (sbreak = start) + nocr;
-					goto mktid;
-				}
-				goto nloop;
-			}
-		/* invalid message */
-		free(fmap);
-		return DRV_MSG_BAD;
-	mktid:
-		for (j = 0; j < TUIDL; j++)
-			sprintf(tuid + j * 2, "%02x", arc4_getbyte());
-		extra += 8 + TUIDL * 2 + 2;
-	}
-	if (nocr)
-		for (; i < len; i++)
-			if (fmap[i] == '\n')
-				extra++;
-
-	cb.dlen = len + extra;
-	buf = cb.data = xmalloc(cb.dlen);
-	i = 0;
-	if (!CAP(UIDPLUS) && uid) {
-		if (nocr) {
-			for (; i < sbreak; i++)
-				if (fmap[i] == '\n') {
-					*buf++ = '\r';
-					*buf++ = '\n';
-				} else
-					*buf++ = fmap[i];
-		} else {
-			memcpy(buf, fmap, sbreak);
-			buf += sbreak;
-		}
-		memcpy(buf, "X-TUID: ", 8);
-		buf += 8;
-		memcpy(buf, tuid, TUIDL * 2);
-		buf += TUIDL * 2;
-		*buf++ = '\r';
-		*buf++ = '\n';
-		i = ebreak;
-	}
-	if (nocr) {
-		for (; i < len; i++)
-			if (fmap[i] == '\n') {
-				*buf++ = '\r';
-				*buf++ = '\n';
-			} else
-				*buf++ = fmap[i];
-	} else
-		memcpy(buf, fmap + i, len - i);
-
-	free(fmap);
+	cb.dlen = data->len;
+	cb.data = xmalloc(cb.dlen);
+	memcpy(cb.data, data->data, data->len);
 
 	d = 0;
 	if (data->flags) {
@@ -1288,26 +1171,14 @@ static int imap_store_msg(struct store *gctx, struct msg_data *data, int *uid)
 	}
 	flagstr[d] = 0;
 
-	if (!uid) {
-		box = gctx->conf->trash;
-		prefix = ctx->prefix;
-		cb.create = 1;
-		if (ctx->trashnc)
-			imap->caps = imap->rcaps & ~(1 << LITERALPLUS);
-	} else {
-		box = gctx->name;
-		prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
-		cb.create = 0;
-	}
-	cb.ctx = uid;
+	box = gctx->name;
+	prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
+	cb.create = 0;
 	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\" %s", prefix, box, flagstr);
 	imap->caps = imap->rcaps;
 	if (ret != DRV_OK)
 		return ret;
-	if (!uid)
-		ctx->trashnc = 0;
-	else
-		gctx->count++;
+	gctx->count++;
 
 	return DRV_OK;
 }
@@ -1483,7 +1354,6 @@ int main(int argc, char **argv)
 {
 	struct msg_data all_msgs, msg;
 	struct store *ctx = NULL;
-	int uid = 0;
 	int ofs = 0;
 	int r;
 	int total, n = 0;
@@ -1491,9 +1361,6 @@ int main(int argc, char **argv)
 
 	git_extract_argv0_path(argv[0]);
 
-	/* init the random number generator */
-	arc4_init();
-
 	setup_git_directory_gently(&nongit_ok);
 	git_config(git_imap_config, NULL);
 
@@ -1540,7 +1407,7 @@ int main(int argc, char **argv)
 			break;
 		if (server.use_html)
 			wrap_in_html(&msg);
-		r = imap_store_msg(ctx, &msg, &uid);
+		r = imap_store_msg(ctx, &msg);
 		if (r != DRV_OK)
 			break;
 		n++;
-- 
1.6.4
