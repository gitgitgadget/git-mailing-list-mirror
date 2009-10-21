From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v5 1/8] imap-send: remove useless uid code
Date: Wed, 21 Oct 2009 19:04:44 +0200
Message-ID: <1256144691-2908-2-git-send-email-kusmabite@gmail.com>
References: <1256144691-2908-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Jeff King <peff@peff.net>, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Oct 21 19:05:33 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f163.google.com ([209.85.221.163])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0ecv-0007fq-3i
	for gcvm-msysgit@m.gmane.org; Wed, 21 Oct 2009 19:05:33 +0200
Received: by mail-qy0-f163.google.com with SMTP id 35so5684134qyk.24
        for <gcvm-msysgit@m.gmane.org>; Wed, 21 Oct 2009 10:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=uMM95RxNRDbbUQzBiP8+uP+i4GtUMsfvXrbmBN9HDM4=;
        b=XThtJVqiUk1jfRm4dLuGvUg7JvX6pGezj+rmOIYJKACOe5DQNMaUiisiNi4OnslH8p
         yt1YI/78PCzlK4d5+B6tEZIh3jTiFyVGcNW/zi8GffojX6lLjd6lTv6xQiNPCAy/R4QR
         PA8ZeaSEDbJGa0TBZQg5sKsZcFQyRuQf49er0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=yb1Ot7wSS3WSgkTSGdFcH/0b5EzNQYK9WmP0TLB6+8BCXfETKA08k25ywqVuC05NUq
         qiAbO29WPtJ1K14YdCZpudc6iDLno3n1NwP+fjsc5GUxxPjj8sZ9B3Ph2fycGgvlzeUh
         ZZ88dBo4P0xT0NNxCPWsGickQyx5fGjQaNst8=
Received: by 10.224.125.85 with SMTP id x21mr403438qar.5.1256144726593;
        Wed, 21 Oct 2009 10:05:26 -0700 (PDT)
Received: by 10.177.105.17 with SMTP id h17gr7476yqm.0;
	Wed, 21 Oct 2009 10:05:12 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.153.19 with SMTP id f19mr720104ebo.8.1256144711136; Wed, 21 Oct 2009 10:05:11 -0700 (PDT)
Received: by 10.211.153.19 with SMTP id f19mr720103ebo.8.1256144711106; Wed, 21 Oct 2009 10:05:11 -0700 (PDT)
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.148]) by gmr-mx.google.com with ESMTP id 14si44907ewy.1.2009.10.21.10.05.10; Wed, 21 Oct 2009 10:05:10 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 74.125.78.148 as permitted sender) client-ip=74.125.78.148;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 74.125.78.148 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by ey-out-1920.google.com with SMTP id 13so1285021eye.2 for <msysgit@googlegroups.com>; Wed, 21 Oct 2009 10:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references; bh=MyZ9dbh5ixsC4I80Z8ve0wi5a/oqIUZ2ulbTJwzguRY=; b=YX6+GqSJuD6aBb6QPK+TJnNpOuEdWRLWztJmYXvEAbCN2N0YkqmrFaOmRMfjublb3+ 7sITwp6+C/aY1K8cMUQ6fYLczvFedCPn/RBCU7Im8k+dVPahGvpvQmCnKQDEhjWfzmma U93OqL2tzrmbP/lljgTVG1hbxh++hQtKR2/mk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=hY8PQNuaOMaUgISJL/sBk7qn8+JiGng6RpA3rPJo/WHIzksDxlWws+LO7qX56g47yD N5g3cjtGA/St1kLRvpQYxJkgWBEQyZzIVVuO0wcJKccbXri8OKpzJNGwJ7ADA1pjY+Pi 5lL2SJ5/MP6Y111tino8RXqVrJ0f8AJ74/ZgY=
Received: by 10.211.159.19 with SMTP id l19mr9042607ebo.83.1256144709981; Wed, 21 Oct 2009 10:05:09 -0700 (PDT)
Received: from localhost ([77.40.159.131]) by mx.google.com with ESMTPS id 7sm1080991eyg.1.2009.10.21.10.05.09 (version=TLSv1/SSLv3 cipher=RC4-MD5); Wed, 21 Oct 2009 10:05:09 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1256144691-2908-1-git-send-email-kusmabite@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130932>


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
1.6.4.msysgit.0
