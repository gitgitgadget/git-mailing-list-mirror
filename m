Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE445513552
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863231; cv=none; b=VGQPAC6UdXeYbwts5pM6XMbBDW20OaVBhCDLY7HixT/duOBxewHxvrHTUNJI9mcl8C2Hpn+Ium5mlkWMmxlBPf+9crHEoRznf/R8LdtElsOi3Bn2srGG2iqlrgII/kCAoiu9gwrEi2n8rt8Md7mpjJI5K4XHRLn4KjK5no+lQvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863231; c=relaxed/simple;
	bh=QdRCQKJo9lm9bgLM4kX89oNfXc7f9nmWqt2pvN1gmv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lJBdmgLvBvzeWIJRoVnzmOEFMvu4GPJAlTNNO2ituTsiFAzz+YTqqNcMZwUNz4WDm4IzeYoRL2FdajrIYQfDeRlFT9ccEK3F1InlMdqJzFw/Hhq9a5qLL4UWmxC6gfuT71rpVCksaTOlu2q2cqi4yCisQkJE2WSFPvuHdutY0yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+eSN6E9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+eSN6E9"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-484392e3d33so3162211f8f.2
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 03:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788863228; x=1789468028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WqMJryxxstr6TNYMEMYcHilFp86JWnfmvfOKmCWuPi4=;
        b=Y+eSN6E9EGeXZXmk2uaLn1sZn1aXWOrDjBBIIVSFzK0tKHMnr5q/pEoI9p9U+EsqCP
         Ta2l2Pr8ydCyxV9gaSQvMIqb9w+Vq8xKuc584PqSLUvEzGP1oDrg9ULWUK6xF0YuQz1l
         Y7sg1i3Ng4rn7E/rkS10yF+0i6YZWxS4Z+swTmorm7I962ZTKDBkdNVoUZJxBLfF+ibd
         pex1YvmMeJbfS6XjyhqAmsrE3KcsNkcoOMtzd6AI5FYc4U1m+gt5Fm2w465q5p1Ds61U
         4ud+X7UDrBjjQisneEY5lnvaBoclymqAyUEUToHXhwxgocrsIHpj+ceAbuzyQ2tuvGtg
         j2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788863228; x=1789468028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WqMJryxxstr6TNYMEMYcHilFp86JWnfmvfOKmCWuPi4=;
        b=eanjSzzUtJ2igM3fCX29RI4C/qZcS8cNmleuwIETp5seWAi1OCMyg+LPGJ2l9U3Dfr
         zug2IogaQqWc+kMVLSYQXsm7BdnkTYys5K/5MOrVBBoeGPUFLVXN2ITIxw92K5VCP8Mh
         rGfF/n2SITQSG6h6sWmlBO4Odnh6DkpKQHhcF7KeviYo1elOxMLht4+uuKWVfwm+JP2j
         N/XFNlvTrGOZMEy0XpT72vMbxLzO0X+c2SWoYP4hQj03xVm5gzDxAAsKpRW0VgsTXxGh
         7m+/lTcGOTEUFXSaLuAofSgPEC/JICHd5CNixMHNJa+kKMmFYHyNKni4LlFewvG7dW73
         EcuQ==
X-Gm-Message-State: AFuF++kcNjf/dmtHOPuRi5X1piLAuBsNxWymQ8DRDV4FP0MReg6ht9kP
	nvVvWz6qwTnB+V6XthXTi7X65IBlNHEtBn0as9Yq11WDAKcOJF0oFwto
X-Gm-Gg: AYBFou06aFopXoCdpmz/DgzmLodjSWxvIwLoV3dK1i0u2MeYq8YpYuH8DFGfxFal+b0
	AdrktVSuZbN6Z7avuB429GyiiFaYliKsa75514VEqdcI8eRBw7DtHeXNqqAu5lFq8aZslIWeAlZ
	G09/wrvo1XD3bOPtynzEFMfFFq9G+7scRjpL2B+GuDmacmEFLY9XCIWG/+49c97IHzomvCQR6qa
	g/hZW+LIBBK/YA9yAReLMKLxbFdlkrK/dUatZC+EaCTwmv5+ir2wvLDSac4eJzfaWfyL/gDTyaS
	TQ8ZcX1tQB8OtksKP3LZM+u+5DX0tJNxNfsZaZ8f1SoFKPFPM80uIhWaY3lWP1bfXsoTtzF+nHb
	PRYZzPCImbL7hesruRc8mT86ItuuEq+DNd7nCneY9ha8YvKai3jGhfmu0JeQEReSpvGBi0AiWuv
	esyImMVnhQPFzrNkxCKVaGmPEW1oAoB7DkfKLliv0s4RzN4i7/wmBwxp141ZiSSHG3Vzfv/7Frr
	9Hz0Md+GtqKVTKR/yt09A3wkOY=
X-Received: by 2002:a05:6000:1882:b0:485:8313:9f43 with SMTP id ffacd0b85a97d-485872b86b9mr30872234f8f.25.1788863227961;
        Tue, 08 Sep 2026 03:27:07 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ed36:96cf:ac4a:2747])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885be1c1sm34446572f8f.32.2026.09.08.03.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:27:07 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 08 Sep 2026 12:27:03 +0200
Subject: [PATCH v8 3/4] receive-pack: move message generation to separate
 function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-758-introduce-hook-v8-3-be88a671ae1f@gmail.com>
References: <20260908-758-introduce-hook-v8-0-be88a671ae1f@gmail.com>
In-Reply-To: <20260908-758-introduce-hook-v8-0-be88a671ae1f@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4583; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=QdRCQKJo9lm9bgLM4kX89oNfXc7f9nmWqt2pvN1gmv8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqf4vdNbhEsEd8d5lCOUIhgvEDxLmt9z4oQb
 Ln+4anvHwseEIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqn+L3AAoJED7VnySO
 Rox/8G0L/iyb6QYU5xlB4pitLP1/IN67aOSW4h6mMGTYaeCFOzL+pPrIW4dk/X6E57DVcSXR76e
 r6DYq2M8LpCFwJjGGynRsOlU4APh3a/bCp9lqbSruLtoYFeWHWjDlpD7eNi0D9GqKn61xeCsjRl
 KbzZQe1tP/gUwSSRWahTwP1HAgJVhr9FyqXE4MSWlYyDrnO81YSOBYn0tp8yjXPJrw/3Qfrc1R7
 fs4O2SeMv9fp+x95wQgAeqpEJu0M8zkxeUH1ubdBqpa113czXA1w8ZaEayALxx+qZHhQaeRWJkH
 vpcj35DHgzHQbtQ91HfQLPDuE+/SzO3UMERROfEv1QK6KIcTevRZn2QnDpgHSHgs1Zvnsw5BQdQ
 vLMH1hV1su8lTePI/kbLumg+XqNn6f4IW4RliPWbnSklonJ+j1LzO1br0ub0KkkF/aJwxjMbAY3
 EUPaJHV/1hhHxg6n3PhSp8Lh9SBzFlNv7WL3V0ZMoudV42vsS/R0eX/wsKuTrvfsrrc1waciSX7
 ic=
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
 builtin/receive-pack.c | 75 +++++++++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 43 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index f7ff6a9abe..8310844ab1 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2414,67 +2414,58 @@ static void update_shallow_info(struct command *commands,
 	free(ref_status);
 }
 
-static void report(struct command *commands, const struct strbuf *unpack_status)
+/*
+ * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
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
@@ -2605,10 +2596,8 @@ int cmd_receive_pack(int argc,
 
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

