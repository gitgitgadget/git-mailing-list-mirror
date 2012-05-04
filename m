From: Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>
Subject: [PATCH 1/4] t1411: add more selector index/date tests
Date: Fri, 4 May 2012 01:23:14 -0400
Message-ID: <20120504052314.GA16107@sigill.intra.peff.net>
References: <20120504052106.GA15970@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yann Hodique <yann.hodique-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Andreas Schwab <schwab-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org>
X-From: magit+bncCN2hpKqZChDFz439BBoEWbAfUw-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri May 04 07:23:22 2012
Return-path: <magit+bncCN2hpKqZChDFz439BBoEWbAfUw-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-pb0-f58.google.com ([209.85.160.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCN2hpKqZChDFz439BBoEWbAfUw-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SQAz8-00076h-Jh
	for gcvgm-magit-3@m.gmane.org; Fri, 04 May 2012 07:23:19 +0200
Received: by pbbro8 with SMTP id ro8sf2636164pbb.3
        for <gcvgm-magit-3@m.gmane.org>; Thu, 03 May 2012 22:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=4H8KUz0zv1Xfu8l0hEv75L4XBAjbihTOPIEhaDNK1gk=;
        b=wNgNvR8RNXz682963qp04qFp6jHjg7BW9hmKRqTKtRR1CnhqZzhjbvcu7ZujIGzdzS
         bT9V14RFJuupwtLNZrCxx8sIskCH2XwIasswe/WHpFjcmS0DCzpRsfG5fTbE5NLmbJwK
         zgzN2M0cierNgFM+gRlgWn2qvQEvVxhLj7boI=
Received: by 10.50.154.166 with SMTP id vp6mr298685igb.4.1336108997342;
        Thu, 03 May 2012 22:23:17 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.231.77.208 with SMTP id h16ls803449ibk.6.gmail; Thu, 03 May
 2012 22:23:16 -0700 (PDT)
Received: by 10.42.151.132 with SMTP id e4mr3532354icw.2.1336108996833;
        Thu, 03 May 2012 22:23:16 -0700 (PDT)
Received: by 10.42.151.132 with SMTP id e4mr3532353icw.2.1336108996820;
        Thu, 03 May 2012 22:23:16 -0700 (PDT)
Received: from peff.net (99-108-226-0.lightspeed.iplsin.sbcglobal.net. [99.108.226.0])
        by gmr-mx.google.com with ESMTPS id xn7si916414igb.1.2012.05.03.22.23.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 May 2012 22:23:16 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff-AdEPDUrAXsQ@public.gmane.org designates 99.108.226.0 as permitted sender) client-ip=99.108.226.0;
Received: (qmail 15058 invoked by uid 107); 4 May 2012 05:23:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 May 2012 01:23:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 May 2012 01:23:14 -0400
In-Reply-To: <20120504052106.GA15970-bBVMEuqLR+SYVEpFpFwlB0AkDMvbqDRI@public.gmane.org>
X-Original-Sender: peff-AdEPDUrAXsQ@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peff-AdEPDUrAXsQ@public.gmane.org designates 99.108.226.0 as permitted sender) smtp.mail=peff-AdEPDUrAXsQ@public.gmane.org
Precedence: list
Mailing-list: list magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact magit+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <magit.googlegroups.com>
X-Google-Group-Id: 752745291123
List-Post: <http://groups.google.com/group/magit/post?hl=en_US>, <mailto:magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:magit+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/magit?hl=en_US>
Sender: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:magit+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:googlegroups-manage+752745291123+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196988>

We already check that @{now} and "--date" cause the
displayed selector to use the date for both the multiline
and oneline formats. However, we miss several cases:

  1. The --format=%gd selector is not tested at all.

  2. We do not check how the log.date config interacts with the
     "--date" magic (according to f4ea32f, it should not
     impact the output).

Doing so reveals that the combination of both (log.date
combined with the %gd format) does not behave as expected.

Signed-off-by: Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>
---
This takes us up to 9 tests (3 cases by 3 formats). It's almost enough
to make me want to write loops, but I think the boilerplate would end up
just making it more confusing to read.

 t/t1411-reflog-show.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index caa687b..4706f4c 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -65,6 +65,14 @@ test_expect_success 'using @{now} syntax shows reflog date (oneline)' '
 '
 
 cat >expect <<'EOF'
+HEAD@{Thu Apr 7 15:13:13 2005 -0700}
+EOF
+test_expect_success 'using @{now} syntax shows reflog date (format=%gd)' '
+	git log -g -1 --format=%gd HEAD@{now} >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
 Reflog: HEAD@{1112911993 -0700} (C O Mitter <committer-hcDgGtZH8xNBDgjK7y7TUQ@public.gmane.org>)
 Reflog message: commit (initial): one
 EOF
@@ -82,6 +90,43 @@ test_expect_success 'using --date= shows reflog date (oneline)' '
 	test_cmp expect actual
 '
 
+cat >expect <<'EOF'
+HEAD@{1112911993 -0700}
+EOF
+test_expect_success 'using --date= shows reflog date (format=%gd)' '
+	git log -g -1 --format=%gd --date=raw >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+Reflog: HEAD@{0} (C O Mitter <committer-hcDgGtZH8xNBDgjK7y7TUQ@public.gmane.org>)
+Reflog message: commit (initial): one
+EOF
+test_expect_success 'log.date does not invoke "--date" magic (multiline)' '
+	test_config log.date raw &&
+	git log -g -1 >tmp &&
+	grep ^Reflog <tmp >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+e46513e HEAD@{0}: commit (initial): one
+EOF
+test_expect_success 'log.date does not invoke "--date" magic (oneline)' '
+	test_config log.date raw &&
+	git log -g -1 --oneline >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+HEAD@{0}
+EOF
+test_expect_failure 'log.date does not invoke "--date" magic (format=%gd)' '
+	test_config log.date raw &&
+	git log -g -1 --format=%gd >actual &&
+	test_cmp expect actual
+'
+
 : >expect
 test_expect_success 'empty reflog file' '
 	git branch empty &&
-- 
1.7.10.1.10.ge534bc3
