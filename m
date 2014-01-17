From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 1/2] prefer xwrite instead of write
Date: Fri, 17 Jan 2014 15:17:09 +0100
Message-ID: <1389968230-1224-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncBDR53PPJ7YHRB3XW4SLAKGQEAQOSY5A@googlegroups.com Fri Jan 17 15:17:23 2014
Return-path: <msysgit+bncBDR53PPJ7YHRB3XW4SLAKGQEAQOSY5A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fa0-f56.google.com ([209.85.161.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB3XW4SLAKGQEAQOSY5A@googlegroups.com>)
	id 1W4AEb-0002oC-97
	for gcvm-msysgit@m.gmane.org; Fri, 17 Jan 2014 15:17:21 +0100
Received: by mail-fa0-f56.google.com with SMTP id m10sf366624fae.11
        for <gcvm-msysgit@m.gmane.org>; Fri, 17 Jan 2014 06:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=/XofXR3BdcGcxF15hRR84ZkPtl0mmFOdiNK5GWB55Ik=;
        b=FZHC2NnRF96MLLomWuTLyjr306kmIGBA9Okl3EA8mQaQGgdFiXq0xVWHBsSdRclXGV
         JIqmPtu/Kpq7Cvr7IqaYNYlEfihTjCBd1Mw8CBYo2t41efpvgnIKEBBoD68aHP16ykuH
         ZRHjymsNu67t/KuquT5UTPDE4h46VeJS/rU6GZKRgooX+wvgd6biQHZnYY2hhfqYo8oc
         8B/znFNmUeK2VaLk2+s/Bq5/Jv0oQXLk9o7vi9c5MZgs3MqRQhTCTNSNi1IeR47OIfsx
         K73J/+/bQgmqOzYcNbJYQJ5/WgiUpvIHJvU4Clt5+n4YTBLnNm7T99sJ+/YARRsbvuff
         oPMA==
X-Received: by 10.180.218.195 with SMTP id pi3mr19631wic.20.1389968239675;
        Fri, 17 Jan 2014 06:17:19 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.76.16 with SMTP id g16ls130904wiw.7.canary; Fri, 17 Jan
 2014 06:17:18 -0800 (PST)
X-Received: by 10.180.77.133 with SMTP id s5mr1230549wiw.0.1389968238488;
        Fri, 17 Jan 2014 06:17:18 -0800 (PST)
Received: from mail-la0-x229.google.com (mail-la0-x229.google.com [2a00:1450:4010:c03::229])
        by gmr-mx.google.com with ESMTPS id z12si1407157bkg.3.2014.01.17.06.17.18
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 06:17:18 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2a00:1450:4010:c03::229 as permitted sender) client-ip=2a00:1450:4010:c03::229;
Received: by mail-la0-x229.google.com with SMTP id mc6so3671420lab.0
        for <msysgit@googlegroups.com>; Fri, 17 Jan 2014 06:17:18 -0800 (PST)
X-Received: by 10.152.21.74 with SMTP id t10mr364549lae.65.1389968238312;
        Fri, 17 Jan 2014 06:17:18 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPSA id np10sm6857241lbb.7.2014.01.17.06.17.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 06:17:15 -0800 (PST)
X-Mailer: git-send-email 1.8.4.msysgit.0
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2a00:1450:4010:c03::229
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240597>

Our xwrite wrapper already deals with a few potential hazards, and
are as such more robust. Prefer it instead of write to get the
robustness benefits everywhere.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
With this patch, we don't call write directly any more; all calls
goes via the xwrite-wrapper.

 builtin/merge.c    | 2 +-
 streaming.c        | 2 +-
 transport-helper.c | 5 ++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 4941a6c..9383c31 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -367,7 +367,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 			sha1_to_hex(commit->object.sha1));
 		pretty_print_commit(&ctx, commit, &out);
 	}
-	if (write(fd, out.buf, out.len) < 0)
+	if (xwrite(fd, out.buf, out.len) < 0)
 		die_errno(_("Writing SQUASH_MSG"));
 	if (close(fd))
 		die_errno(_("Finishing SQUASH_MSG"));
diff --git a/streaming.c b/streaming.c
index 9659f18..d7c9f32 100644
--- a/streaming.c
+++ b/streaming.c
@@ -538,7 +538,7 @@ int stream_blob_to_fd(int fd, unsigned const char *sha1, struct stream_filter *f
 			goto close_and_exit;
 	}
 	if (kept && (lseek(fd, kept - 1, SEEK_CUR) == (off_t) -1 ||
-		     write(fd, "", 1) != 1))
+		     xwrite(fd, "", 1) != 1))
 		goto close_and_exit;
 	result = 0;
 
diff --git a/transport-helper.c b/transport-helper.c
index 2010674..bf64ad7 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1129,9 +1129,8 @@ static int udt_do_write(struct unidirectional_transfer *t)
 		return 0;	/* Nothing to write. */
 
 	transfer_debug("%s is writable", t->dest_name);
-	bytes = write(t->dest, t->buf, t->bufuse);
-	if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
-		errno != EINTR) {
+	bytes = xwrite(t->dest, t->buf, t->bufuse);
+	if (bytes < 0 && errno != EWOULDBLOCK) {
 		error("write(%s) failed: %s", t->dest_name, strerror(errno));
 		return -1;
 	} else if (bytes > 0) {
-- 
1.8.4.msysgit.0

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
For more options, visit https://groups.google.com/groups/opt_out.
