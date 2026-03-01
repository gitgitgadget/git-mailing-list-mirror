Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F64D307492
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772402259; cv=none; b=jjJn5IiGKioGbqViy5NOfKogbzpEYoBtHE17kjI6/OUcg6DACEJLtc5Sgcjbqyyaej2V42FDRSeTwXJORtNvQK3femvqXe/NPHWaGpHCOnHUPKTzs+qj4xHxliQklUfgaAn189VkSVfHYlxvBzvHBajsxzL+n16XuNPjkFArI0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772402259; c=relaxed/simple;
	bh=J/Ebiy5G1GBZkDM2fqsOeicH6y3yudcX8KwqAO28/AA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=lwG8x5l87UQ8sj/Sdx81LJfAwVQIAHRqI2ywxpwoQ8IftLHnEy1xQJ7hxyFAf1Wtz7ZdB86ZEN/QbVz9yg6p5cMx8YHiXNdk3PfQyVOHgGaQP4aW04s+CCKvi7HtB/+D/7cYpbSQg5X7rBpO8bqCxfdU9c1HXtl8s1bG/fsbYww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com; spf=pass smtp.mailfrom=wolfgangfaust.com; dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b=Lxym1jly; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W5LfpFZs; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b="Lxym1jly";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W5LfpFZs"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A9E17A0099;
	Sun,  1 Mar 2026 16:57:36 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-01.internal (MEProxy); Sun, 01 Mar 2026 16:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	wolfgangfaust.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1772402256; x=1772488656; bh=P8ct7ORZ73nZugh0+IVetti/g30IDQ+w
	fV7RXPOk3NQ=; b=Lxym1jlyUdfAuihPmMK4blDxBi+Bx2RE44mooYroJ2Vpz+Pm
	+lM1Fg/oKmmRnq9+JTxkW4S8UdACiWq3bTUDjdtT65E/sWQD9HY6snmbm1ZiHKOq
	3ruggAogBWMf3fUBHe/Fxf/2aRfE0rArTt9G6V8qyAp9Lc+yzEQJiFwrzRzXlRKu
	Dln5HaNHmTnz+ZHnFGsgdtx1dmqcn6OcggX5cIaLRofMcQBAHRBY/jyNhL4rqq9K
	avUWz/YlwBTWwsb4FjJBsecS2DcnnK6p73l3n3JIW9nbj6AeMk+Q7TGpEKVFdt2h
	+mNd1wCm3cwZaISYl5eYv7snqjnuwJhYqObrjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1772402256; x=1772488656; bh=P8ct7ORZ73nZugh0+IVetti/g30I
	DQ+wfV7RXPOk3NQ=; b=W5LfpFZs10SZvaAEbHAoz2zaLwLQnM4u0sPxhFuDQV/g
	aYnJKM9tp7j5PPsdoGjpUCi0JFrLmByJWX6+iqDwQtT+OSE7matOtMIoC2R9ULr/
	GZB3nDdxZVn0ob46eureOM1bOes4Q+eKKZeeb6CDvb3Rmv+PQNResbp4vuM4yBRH
	u2mhMP7OF62sUqo/bEbQSFJf8XhVBLHJZ3JyRrr6CyRoYzGRLgMVffLJ84WzABqB
	oTEqoHbSDA63Y9p/6PaTFOUp+onRhX0A8PEHTwFySgf8c9PQasDM7zZ4+YX42ZxQ
	+2dBh75WtGANjUs+LA1kVmSDxHGRuUhaIr0sZkryuA==
X-ME-Sender: <xms:ULakackYJLSTY7eXpbSbKdLVzjecPLFKONKsSm0ZIHvDhRtMO_kujQ>
    <xme:ULakaWr3fSR6dbiRrylk8ePRQf0BVrdnq8lN8f9GPYTU5A0a4DMEkH5nxdtXFaC6H
    kkp2rNulofvPLgJgP7daB6dcVwHw9fkXlIIYQ4rx9UKw0r1Ji58PuI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheehleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkufgtgfesthejredtre
    dttdenucfhrhhomhepfdghohhlfhhgrghnghcuhfgruhhsthdfuceotghonhhtrhhisgdq
    ghhithesfiholhhfghgrnhhgfhgruhhsthdrtghomheqnecuggftrfgrthhtvghrnhepge
    ehtefhgfdtjeevgffgkeevtdeivdeitddvkeetvdevudegjefggfekkedtkeffnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghonhhtrhhisg
    dqghhithesfiholhhfghgrnhhgfhgruhhsthdrtghomhdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ULakaTREupsrL0Kd84LWRdaUJGgadsTx3xYB__WVyZdbbKktJ2df4g>
    <xmx:ULakaSsLYMe-MK-NXaWd9TUqSdDHfVO2x6gUGeCUtK6C2RGLJWCzNg>
    <xmx:ULakaQbhV60KFL046Ulo_utAsfmJRAnRYey9l_lvv7i2aeh2_zc74A>
    <xmx:ULakafsetgXWlNOBCvXN5gp6OwZmlJ5f-1SqdMRGtkYZReDigBqvzA>
    <xmx:ULakaSnkHyIJrTGqc_AGD7tPboyfXDw-Jv7nNCtUTgYyIxGxzzUdQJBv>
Feedback-ID: ifd814412:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F40022CE0078; Sun,  1 Mar 2026 16:57:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AT0JpTLFp3rB
Date: Sun, 01 Mar 2026 13:55:58 -0800
From: "Wolfgang Faust" <contrib-git@wolfgangfaust.com>
To: git@vger.kernel.org
Cc: "Johannes Sixt" <j6t@kdbg.org>
Message-Id: <a72715e2-c3ae-4050-95e3-7fc7f9b74b5d@app.fastmail.com>
Subject: [PATCH] git-gui: highlight comment lines in commit message
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

These lines are stripped by wash_commit_message, but there is no indication
in the UI that they are special and will be removed.
Add highlighting to make it clear these lines are special.
Signed-off-by: Wolfgang Faust <contrib-git@wolfgangfaust.com>

(I'm not very good with tcl, so I suspect this code could use some work.
In particular the regex being a mangled copy of the one in the wash
procedure seems like a code smell, though I'm not sure how to improve
it.)  
---
 git-gui/git-gui.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index d3d3aa14a9..3a0c08aa38 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -3900,6 +3900,25 @@ if {[winfo exists $ui_comm]} {

     backup_commit_buffer

+    # Grey out comment lines (which are stripped from the final
commit message by
+    # wash_commit_message).
+    $ui_comm tag configure commit_comment -foreground gray
+    proc highlight_commit_comment_lines {} {
+        global ui_comm comment_string
+        $ui_comm tag remove commit_comment 0.0 end
+        set text [$ui_comm get 1.0 end]
+        # See also cmt_rx in wash_commit_message
+        set cmt_rx [strcat {(?:^|\n)(} [regsub -all {\W}
$comment_string {\\&}] {[^\n]*)}]
+        set ranges [regexp -all -indices -inline -- $cmt_rx $text]
+        for {set i 1} {$i < [llength $ranges]} {incr i 2} {
+            $ui_comm tag add commit_comment \
+                [$ui_comm index "1.0 + [lindex [lindex $ranges $i] 0] chars"] \
+                [$ui_comm index "1.0 + [lindex [lindex $ranges $i] 0]
chars lineend + 1 char"]
+        }
+    }
+    highlight_commit_comment_lines
+    bind $ui_comm <<Modified>> { after idle highlight_commit_comment_lines }
+
     # -- If the user has aspell available we can drive it
     #    in pipe mode to spellcheck the commit message.
     #

base-commit: 7b2bccb0d58d4f24705bf985de1f4612e4cf06e5
-- 
2.52.0
