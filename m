Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87517403E9D
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427697; cv=none; b=VS6EQAr0caOCflHJThCA22PSCij2Le3OZi//LPxCJuEfcc1Ujjo97lPgJfn8OojwZiAg8yT82KKgG6suxpDTE17X9yHgIDNsjODlsDKqu8HMt56Emh1p2lyRXnbSZ0E25LD/QycAXJt+fBHAnNQYZccwTcm7VZaoqY67D49ViVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427697; c=relaxed/simple;
	bh=nyBer2mwy2qqmpAojtZShh0dYjfYiVgCPVooq8aHYxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r0mmGXsH8cMJp0nbaJKlg3R9pyF8D8zJu+p+LUewJeWAiKYKQ0AHCiTbXPPF0jPleVOHx4bpYJ8fRZTlQsrLQaQtgmqze8q2H8NQEPEDjnbLLq5CuDDZfsoz5AMXF2iZGg2uEBfqw/09K0zwDJSdre5s9qcsaVXtVfjd1WB1yrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXDhXwi+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXDhXwi+"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so4510795e9.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 02:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788427694; x=1789032494; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bJurWvjRjqYT6Esh4VHi5cw5Hv8cOsQESJLnnbskSpk=;
        b=CXDhXwi+tvqFDWaVqUvtIv64bm7w9vhHcEQvdeqZ4ru59m4zbwFwNJd8pC5vOOGph+
         vhkgYE7qQroCqXw95Dvqwq/h+ArplBsR+t4MYuN9otIY/fZeZyEhUUFBzNsh+Wi4jYgG
         OsJLt76oVCZKgYubYXlDXMZ77Dhf/kf1dBSw5HhwxcTMx7QxNrAtJMuNkIE6uJJEPdGM
         LdA+qBj2fyzdQJw4nf9kS4ySq4PwusyL0WGyjCEJbAM598grf3yOPzIEwTmIhwvYA38b
         5aizxAVtUywooLWa/a8KIPXAODWMk4Qsg5bnTrXFX8yfluNL7RLkCYE9blKq/EOTKbQp
         ltMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427694; x=1789032494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bJurWvjRjqYT6Esh4VHi5cw5Hv8cOsQESJLnnbskSpk=;
        b=czaseclh6A6BYRVorzP3mBoMdrRRj/o1/sJ6/fPlC1w4A8Uw5hqziEssgfZ564cCIJ
         VQxzaThMO3EEsPyWMi1btnIeswg24Br9F8qATAbc4Xdja9OplICMCXkRcg9PzDLSW4Di
         q5Q/zjZPAjxj18HC1byMSVcNFlypI/J2fi9anZ0iAtL3JskHwHuRKE3Zlafwy8i4Eu0w
         gyqOBD2cTiQ7uOXZRV0uQe1umMZH1FHX1t5km8Tp34VURGAGWcds4B/DsT+dknpkl4aS
         61h/PM2Y7ydIiw8SzxjaurR0Ok47PoT6lo6wYtKcWG97cSrOfBzlE3nTYzpW7iQ494Pt
         OISA==
X-Gm-Message-State: AFuF++kUc2nfr3b3XfyANhkhhrdYCYqY/GW2yJl5TB4WOwLNdfQFVkYj
	Bqv5CQ7HO3QCrMJVlP08rVhUNgE3sH6Rl6lfDhFYkDSP7cMwSZ+vAw0e
X-Gm-Gg: AYBFou1EHx9d5agYZAH2O4NQ2+OJPUzFd4pj4OQzoGAdv0tT53Wxvk2QJqSDk3LnH67
	ZpM/+sea+HeLdeGNXtjcNOZHp5Oln1kqisAA0p+B2gl+Atzzqmaio3a3SaoJoGKwf+oAEFME0wQ
	/f50E8Px6+zzdpjgncRAVduzZ0w1YIVgg4qdCsGcVgJtFCeFGuP0wLsJh6pE0BOMJhDJvUEZyih
	3FtebyDv8dV+FFC9bjVIlmcJoymMp4JhCC1kpmJ6HspduPAJNzMPAPQtvRXlF1aN/ozPfmr4ZGx
	15+8G0IgIvBsXxIJNX1vJco2wbg90bS4ctJzvqyc9EnYYmAwSGhnZLz1UHXhgNeno4fdK6anc6H
	lUGJZpZ4B3DLq7fSi+kJWpQVyc9Yky09Lv0vf+AXtHNwkga4nrHrpUPNlm+ElD8oiwy13s3g6+q
	E19g9s9mGrM/nPusj16ZHIyYogdCvL06NVgPqkiE1rGjn1r5ryVZeXmmwht8EIIKQ7RFP2EMCKd
	x90sdZCAh+g8yCpk1rUO+iixKY=
X-Received: by 2002:a05:600c:c162:b0:49c:f13e:e52 with SMTP id 5b1f17b1804b1-49cf15c92damr24607665e9.15.1788427693340;
        Thu, 03 Sep 2026 02:28:13 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:56e2:6e6b:ebf7:2587])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60d8a6sm55553105e9.10.2026.09.03.02.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:28:12 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 03 Sep 2026 11:28:00 +0200
Subject: [PATCH v6 3/4] receive-pack: move message generation to separate
 function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-758-introduce-hook-v6-3-6283b1fb9b1c@gmail.com>
References: <20260903-758-introduce-hook-v6-0-6283b1fb9b1c@gmail.com>
In-Reply-To: <20260903-758-introduce-hook-v6-0-6283b1fb9b1c@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4460; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=nyBer2mwy2qqmpAojtZShh0dYjfYiVgCPVooq8aHYxA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqZPaj0hSkb1sInhmGzyxHp3g4drh8n+6qMo
 QpNrNSpV4Jv+okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqmT2oAAoJED7VnySO
 Rox/F0sL/A2ucFHwRgDcRtogIqS1gTCr5CbOYNTJDOsdXF7QvMzwGRg9xy0zNgSbVtR597zlVsO
 gM4IHhnqbKt7nbs7aDz2UX1rLJN2i60qROYWxM+NzAv4Lf3JQBdGitOa6LTtTSVpTdKfw4xAAW9
 uLldgg1OBXxhB1BSN13YNu2pL2wsaFwAhGtQErPZKkACruri7shvl+OSzGCgfhGm5mQbjlcjbkk
 j3E6QF9ebpCruSH0jS4c6pwkmDOTDJ0c8298ex7UO7Xyw+1ZWyVh4oVdq/ewJggoYtBA1lFiaJf
 FuU8CYDWR/AXsuvtIQqS4dWc6ihkZoqaufV8SKqg38e/CH40MKvYASy/pa+XbAlvxVR98M0vnwi
 YnvZgILLqYOZ1r3B6Zf841ZVNZNlNggyy5OA8kFMJJzmWV2oQsttLbTw9C1d47wSqkVzZ2eo6e1
 LycW3KkAwvieMiW8EQ6TyZ2iB//dQI0MYgnjicim5iLqiJlpczO8Jsykz0XDTfdO+ftvOqdKGV7
 DY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

After git-receive-pack(1) has committed the reference updates, we call
either `report()` or `report_v2()` to report to the client which of the
references we have updated successfully and which updates have failed.
The only difference between those two functions is that the latter also
knows to provide a more detailed report about how exactly a given
reference was updated.

In the next commit we're about to add another site that wants to
generate these reports. Refactor the logic into a shared function that
can easily be reused.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c | 85 ++++++++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 40 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a9a3d21c24..9ac10465ac 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2535,67 +2535,72 @@ static void update_shallow_info(struct command *commands,
 	free(ref_status);
 }
 
-static void report(struct command *commands, const char *unpack_status)
+/*
+ * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
+ * For v2 protocol, set `detailed_report` to true, which will also add detailed
+ * report per reference update.
+ */
+static void generate_report(struct strbuf *buf, struct command *commands,
+			    const char *unpack_status,
+			    enum report_status_version version)
 {
 	struct command *cmd;
-	struct strbuf buf = STRBUF_INIT;
 
-	packet_buf_write(&buf, "unpack %s\n",
+	packet_buf_write(buf, "unpack %s\n",
 			 unpack_status ? unpack_status : "ok");
-	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!cmd->error_string)
-			packet_buf_write(&buf, "ok %s\n",
-					 cmd->ref_name);
-		else
-			packet_buf_write(&buf, "ng %s %s\n",
-					 cmd->ref_name, cmd->error_string);
-	}
-	packet_buf_flush(&buf);
-
-	if (use_sideband)
-		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
-	else
-		write_or_die(1, buf.buf, buf.len);
-	strbuf_release(&buf);
-}
-
-static void report_v2(struct command *commands, const char *unpack_status)
-{
-	struct command *cmd;
-	struct strbuf buf = STRBUF_INIT;
-	struct ref_push_report *report;
 
-	packet_buf_write(&buf, "unpack %s\n",
-			 unpack_status ? unpack_status : "ok");
 	for (cmd = commands; cmd; cmd = cmd->next) {
+		struct ref_push_report *report;
 		int count = 0;
 
-		if (cmd->error_string) {
-			packet_buf_write(&buf, "ng %s %s\n",
-					 cmd->ref_name,
-					 cmd->error_string);
+		if (cmd->error_string)
+			packet_buf_write(buf, "ng %s %s\n",
+					 cmd->ref_name, cmd->error_string);
+		else
+			packet_buf_write(buf, "ok %s\n", cmd->ref_name);
+
+		if (version != REPORT_STATUS_V2 || cmd->error_string)
 			continue;
-		}
-		packet_buf_write(&buf, "ok %s\n",
-				 cmd->ref_name);
+
 		for (report = cmd->report; report; report = report->next) {
 			if (count++ > 0)
-				packet_buf_write(&buf, "ok %s\n",
+				packet_buf_write(buf, "ok %s\n",
 						 cmd->ref_name);
 			if (report->ref_name)
-				packet_buf_write(&buf, "option refname %s\n",
+				packet_buf_write(buf, "option refname %s\n",
 						 report->ref_name);
 			if (report->old_oid)
-				packet_buf_write(&buf, "option old-oid %s\n",
+				packet_buf_write(buf, "option old-oid %s\n",
 						 oid_to_hex(report->old_oid));
 			if (report->new_oid)
-				packet_buf_write(&buf, "option new-oid %s\n",
+				packet_buf_write(buf, "option new-oid %s\n",
 						 oid_to_hex(report->new_oid));
 			if (report->forced_update)
-				packet_buf_write(&buf, "option forced-update\n");
+				packet_buf_write(buf, "option forced-update\n");
 		}
 	}
-	packet_buf_flush(&buf);
+
+	packet_buf_flush(buf);
+}
+
+static void report(struct command *commands, const char *unpack_status)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	generate_report(&buf, commands, unpack_status, REPORT_STATUS_V0);
+
+	if (use_sideband)
+		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
+	else
+		write_or_die(1, buf.buf, buf.len);
+	strbuf_release(&buf);
+}
+
+static void report_v2(struct command *commands, const char *unpack_status)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	generate_report(&buf, commands, unpack_status, REPORT_STATUS_V2);
 
 	if (use_sideband)
 		send_sideband(1, 1, buf.buf, buf.len, use_sideband);

-- 
2.55.GIT

