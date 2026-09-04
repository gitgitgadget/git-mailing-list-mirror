Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1956B434E56
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788557346; cv=none; b=kAaZXY4sO1UYKtFg8NGIpRknMhz3EMX3Um3xB6qNZAsj4kK0bfb9COWqIjKOkcVrKWKwiMLv28thSN8BbHSuADbWxNYATj2H8MeIQ8HK47ctFeZM3SYZgHRfdF2KRqHceNIM3UgUPnxozUW2vWVIYCHh28hR5oLMXev+bt9CMH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788557346; c=relaxed/simple;
	bh=KAvqbCG/yAT7MNpPqhNvtjexjUu+g4e8Ff4WuL8og84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eExGCbFz9mH7Qu7CJbixNvOh1uQ534//gHj0MVtbtOu0VQOGFrSR/skUn4RwCzYkqg42TjYSYySmxPucxb6usCVwKUhJnLrFb6OKLpz+5+G8r9HYmupUYeIF3PT1eSsyKfzIz5IS6Cqa2t9eL423qL/rbTon8JfD3cUKJbVgcHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlmSPycZ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlmSPycZ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-484362f5c4aso1790658f8f.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 14:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788557341; x=1789162141; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tuwxhOxnQOmVeKMH2Sb/ZkMLtGEzwhpsojhdfScSjiA=;
        b=ZlmSPycZFv8ELkm7ynhAu11lOxWlDJqXI46FRpvibNBoBz2FDEm20XqDzzeJ2m+Lvl
         psugc9J7RIPPSqfa0lvmoHWFkYoaytQ1XbbO7JAAe0Y4l0/rGn33kxeOgiPQudCKTN/y
         bIZDnlQVqN4G9QpCTWJ/27dJdW8pPrnWv9WR33KPHIqvmNSMqGgA2Dl/w2pNWx6iwTmD
         2nkBRg27xD3lCmLgfiAMMHOXQrDcEiFX524iOPqNitk0OmoqBHBGUqLPtkbAEL2AuEEq
         g3Xm5jAV4bEJnHM+Q/CYe7V1i9snlQTqfCETixrMwWtiUAtVpcEQFz7ahthInLmKjN8b
         27Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788557341; x=1789162141;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tuwxhOxnQOmVeKMH2Sb/ZkMLtGEzwhpsojhdfScSjiA=;
        b=bE2WybOQf8ccK71EcV4SmCN2w1jbZUnzXc0tSuE2hNH232Sgaz9FXGt2gynz70spjh
         0W5ehj01cFMR0ty9+r3U/rT3qdqp6OiqDX4vFgHCIfjklFBYu+DMWdQhlo20S0MuACnt
         K2lTxhEGBACDDRp56/m7D93NEEf+AgDpR49hh+6UGoAOIW2yT6kVAGPyVASuVwqsxy9V
         8VX+ObdPM7TFmdyHoGjouAibxUX+3xhTmggUpSdLpC8SgWfv44Sk0//Pp8Lk2KQNvbfR
         1z5cTq9puecKFhr6kxpOYuA8xigLYD7FSAKHA4HWs+pHErQ76UYjVDmYJWpUs2phXltx
         FQLQ==
X-Gm-Message-State: AFuF++nkbjdtboMw2eoQePuNpz5gGTOLpcRJi9a4UiBWC2DDmyRnZO1/
	OLy9aFbSmjTDew6G+3wlbDdgmvXEyQ4BBRNJTuxY+XdYZF6/Utp5iuxb
X-Gm-Gg: AYBFou2kP+WX2uhk37T9+PSmpF6VW6YER5DIXwq+/DEAevzzSYEGj+MdI81dyAoKvHn
	kVj6+ZHcnOrdww1PlapH//7eWg0r5w2J2SmxoS0V61uLnwU1i5FMAjJXhSVLROOGwIFvJ8iN3OM
	Cdg5LcJNzX1UhvaBbJGRSgJVJlXjhIbjfcps8L0RPk4QkQmnr7Zwot6T4eObEobvHKlrqdWyzrv
	TNKh7OXTwkT8MDCNgro0PIfs3fdZ7lMeobt54VT+RH2aj/PrTIP+M42GtSS7357M08HtwNDV9/n
	Qkf4F+iRsYtCKc/+i8RrbLS2PEY1HisewHV642UOyQUFODGAQjnN3F7W88wrJnyfsQDnREvUP8T
	lODH7hokFuJw+Cql3MR0K3nNdsTEmj8Fmru9uMXmP9JaGWgw2ZNMn7JWC30jx/7RUz36ctgDZNA
	eFpWYPBv0iKh0kpjMU5mnev+lqKrUnZ7ctkHQPVE5jltxsePSM2ge4OBT2vhRto1sLEdKj1lDTD
	bPHI9fnDlWKiAGX4whH32BfAw==
X-Received: by 2002:a05:6000:29d6:b0:482:e6ec:4edb with SMTP id ffacd0b85a97d-48587085dffmr14073017f8f.15.1788557340570;
        Fri, 04 Sep 2026 14:29:00 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1faf:874b:d20e:6b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c074asm8820051f8f.23.2026.09.04.14.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 14:28:59 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 04 Sep 2026 23:28:51 +0200
Subject: [PATCH v7 3/4] receive-pack: move message generation to separate
 function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-758-introduce-hook-v7-3-6c66f0a3a572@gmail.com>
References: <20260904-758-introduce-hook-v7-0-6c66f0a3a572@gmail.com>
In-Reply-To: <20260904-758-introduce-hook-v7-0-6c66f0a3a572@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4699; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=KAvqbCG/yAT7MNpPqhNvtjexjUu+g4e8Ff4WuL8og84=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqbOBVJRPEcLFTP1ksltHh02atbxW0ydGqnW
 IkXutK9Fl6ecIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqmzgVAAoJED7VnySO
 Rox/OPAMAIjQAlUCzzZuqTgkZYf6IYUyz4jxXgwhzHwOvZl+Cejuyk5UX4EQnsQ5tPXHMdRu3yv
 mwsFupREn3CoaEk+CGOxkQVekOLa/TeOrWC1ZuoMAm2y/+q/9Pg+O0u27FgNiD1cnkxWq/KHF98
 fMSCFzhHBb9b/MhEMZ96o+ThKNYrI4zeUrymuPmPKEaZIQrsCTLr88ltgR7mKfx9fSkqkMaJqHp
 yTi9XNTmqcpjoSMhlXmAmdOHmesmbf7W0wJg2gVODLP54Cz9E7jrLObYp6xHxlhP2eAkRK+8Yh0
 McyJMa3HU3o6PSd8qNfgyafaKh9Gp/N4fFIh8fHeRqhoIuuDNSS95GUFPp3vHRBt+dJUhwPcm0k
 rzqHQLbAQxbmKbsTST4bi7BhurVQ6AA4/zBc6KifWjlrNw+R5braLdG2LEXuZwQEGaMdPst3/zF
 EpTFBfgal0pbv9vTnNKAdyCj0BBWIU6tEEw5F4mKXs/g9dw983S8wpSzGUb6iopf/Poo2yaU9x5
 xE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

After git-receive-pack(1) has committed the reference updates, we call
either `report()` or `report_v2()` to report to the client which of the
references we have updated successfully and which updates have failed.
The only difference between those two functions is that the latter also
knows to provide a more detailed report about how exactly a given
reference was updated.

With this, also drop `report_v2()` as both report functions now are
similar in structure with only the `report_status_version`
differentiating them.

In the next commit we're about to add another site that wants to
generate these reports. Refactor the logic into a shared function that
can easily be reused.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c | 77 ++++++++++++++++++++++----------------------------
 1 file changed, 34 insertions(+), 43 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c356e34cd8..9c70da9ba1 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2414,67 +2414,60 @@ static void update_shallow_info(struct command *commands,
 	free(ref_status);
 }
 
-static void report(struct command *commands, const struct strbuf *unpack_status)
+/*
+ * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
+ * For v2 protocol, set `detailed_report` to true, which will also add detailed
+ * report per reference update.
+ */
+static void generate_report(struct strbuf *buf, struct command *commands,
+			    const struct strbuf *unpack_status,
+			    enum report_status_version version)
 {
 	struct command *cmd;
-	struct strbuf buf = STRBUF_INIT;
 
-	packet_buf_write(&buf, "unpack %s\n",
+	packet_buf_write(buf, "unpack %s\n",
 			 unpack_status->len ? unpack_status->buf : "ok");
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
-static void report_v2(struct command *commands, const struct strbuf *unpack_status)
-{
-	struct command *cmd;
-	struct strbuf buf = STRBUF_INIT;
-	struct ref_push_report *report;
 
-	packet_buf_write(&buf, "unpack %s\n",
-			 unpack_status->len ? unpack_status->buf : "ok");
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
+static void report(struct command *commands, const struct strbuf *unpack_status,
+		   enum report_status_version version)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	generate_report(&buf, commands, unpack_status, version);
 
 	if (use_sideband)
 		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
@@ -2605,10 +2598,8 @@ int cmd_receive_pack(int argc,
 
 		switch (version) {
 		case REPORT_STATUS_V2:
-			report_v2(commands, &unpack_status);
-			break;
 		case REPORT_STATUS_V0:
-			report(commands, &unpack_status);
+			report(commands, &unpack_status, version);
 			break;
 		default:
 			BUG("unknown report status version");

-- 
2.55.GIT

