Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795361144;
	b=V+rzXk6Dd/J7YqMYsxw26rAknKNJRoelVgUDg+GBcPG2F4MqJpnbqjkoFLLJj72+abbL
	 6DgjoeTgSBIUigSBDV7rHPvn/QjLgF1Z/M6e08vGEWRp7d+PHnIxXzCcCLrh1UFTYjMyH
	 tPXmLgz63n8HgVqC+vl9oREdPWQ3VQxMqQKNs7nlFT2e+GWSTtB/R6vEfv2N/wS4VoWBi
	 XN/fRdTHR136QpXVT8XVKDWhyqrUYn3qwfkTBNqZ1utTkCB+29bAVB8Wj6MYAoP64furH
	 eQJSfRllEmrecfsoAiPCVca1Awz+7PDcjsngOhY/NPRv19rZheSGLgCrLaDySvPvhXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795361144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=I8FZ0pEJAA3mCkzDpTG3a0ddqCkI35FvVeJmJXwsPbk=;
	b=XaiuJwZeOb7dLgHF2G9wC2yYkumKg69Jf/EHbCM0O+vNQp7WbZ788QvoRPyQ4DsHciUe
	 XTDQ/MR9CEvJRtWLDlpOgdleOQGaTdfJaE++KXLYwtbgsPSXAxXkngYnQ8BdFlGxD5w09
	 U4ZywlrvfI4rdYVuZ8I5XRQPOqMFHgCPhdqTTko7JOjCImXx/pqf5wyt+wf+8FYiS1rDz
	 /1tpcQQOeHd9PID+Y4v8l8y3Y756xhL5MIr6sGLtVJWqM4/8nY43DO0PZGJvilJT895Fo
	 /gFTa0OH61I29Xuh11vFntGeO/NPomBvbiZ8KWfs+5X4sFYBNPKGXhofHSXpXjrVZrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gyLgy2Tt;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10D6606A682
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 15:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E10D6606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gyLgy2Tt
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c513a854320so419143266b.0
        for <git@vger.kernel.org>; Sun, 22 Nov 2026 07:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795361142; x=1795965942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I8FZ0pEJAA3mCkzDpTG3a0ddqCkI35FvVeJmJXwsPbk=;
        b=gyLgy2TtepWequm4cJc/+rcgSDUpM1LhFbRUDTG7HlR9XPcJ/Qx6GoAiDSxFBQUUnk
         AeVBMP2RWi7YQi9o9j6xGW9XgFDRfWOAf2CV4nO3UxDL1VCUFbMqtpo9TqNiG9VJuI8A
         EVfeqUujQF6g+F79BGQHDSBOhGyERqX47u7gpij+aimIlKxkDwrk+JNHr4RfO0i7Ogcz
         Oa35/vzzgyOx+ccVhRyvPWVFQcuOtzFR65IlvQ56teqvCGvEscIjvgUCKFloXHoLAdNb
         vskK5H/iaYbu49FvcQ1/YcWF9SzXHMErjcA1iJcqaWAbRqRgmfvtpRRisCB0DI0zRkwG
         lfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795361142; x=1795965942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I8FZ0pEJAA3mCkzDpTG3a0ddqCkI35FvVeJmJXwsPbk=;
        b=hVtGoqxdVhsIJdjYhn+9zdBzln1hcev7qRKIc3VeXzXa14fRDXdavCdQwnC+pM6bKH
         fc67u6VtWl76cUmt8T1M7Q/9poJEvkqryN3tOmhMkmHAw5Mr8ygeY/gApPOZlGqm5er1
         PNL0GvdRtFeaC1i7XpCsegDmcALdLwZiMppJ3EMzGLPwzCJXLvaBTgucl+FhPmXO+/w4
         ofjnSF50nlseFwoLNaxfN7JFImOLPOb7NsyETQCeIMKvcfRsd+Ymu24CNTGE5bctW1qs
         hPnbvGV2QfS23jMB1eS2L4olBDkd0EW8AV3H4steaSjz6ItkaE9FYqtJ/m0r7RuGd+7d
         hZpw==
X-Gm-Message-State: APuU4Z8V5UdCvQl7AjeNDeeUVFuXJHXI7nEmAcMLt6zVH9rDqawyLJ59
	pWMbOhW5RJPeSH9RscXjBGPCDZwXFmFe97A6mXP8To7Ker8OvVrgsW+iULxcZg==
X-Gm-Gg: AZFdTZdOWpyFB/gSdil5ENnfkhk3UVURhQpMhNnLILJSLoXSbwlfNtiDg3jomdhShV0
	m6fngc4pg8Sx/qmRlzqQ6HTWTHMIW7DQU+phYA4yaM6ofRguI0Wcs0YSDetW3z+IcbmXp0biCRE
	FFcRer9OFyRcA11PWIoFwph70Hg/e8GX0lYZIVubC9cJVlmBNSqN/029B4cUajwDaU2FkVlS/9e
	sYUVK1tEPOc4fffEjYrENmF2DEreurFNOd6jg+LulRcqK3QeURgkmM372cl0OgEa5eA8N2EaWnZ
	Hkq+vh1PnxK24xRK5WJjdmIuB3ACTSfoUWW7Jtj0+onyY646uzb5JQ8bBH4yi7XKT2LXNIu6djQ
	yFoJYfJZ8TnFznfAYb0rp2PeTMuvXpbInVtfz4L6d3lcJCzab5nbo0YmZbrVAb6yAVNZe+c8lzy
	b9aKkwdbGmxIoNzXoJLniVuMFjdwrvctNqlFdZVrvs2qnwQ2nUQKtyS5xLni31tadGUto2x2shp
	Tppww69Ecs661IXhCxx12xun8YuQAvLOprHP1WLCVXrK0daQ/spNSRtznKx7YB3AyC1VU5a90ua
	42yzKN3pF+4IDuKRMY3HdclvplhiEQ==
X-Received: by 2002:a17:907:9605:b0:c50:f309:a437 with SMTP id a640c23a62f3a-c513a41f471mr718409466b.7.1795361142032;
        Sun, 22 Nov 2026 07:25:42 -0800 (PST)
Received: from omris-tuxedo ([217.71.1.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc244asm320581766b.55.2026.11.22.07.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:25:41 -0800 (PST)
From: Omri Sarig <omri.sarig13@gmail.com>
To: git@vger.kernel.org
Cc: Omri Sarig <omri.sarig13@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] doc: update-index: Format options correctly
Date: Sun, 22 Nov 2026 16:25:37 +0100
Message-ID: <20261122152538.107580-1-omri.sarig13@gmail.com>
X-Mailer: git-send-email 2.56.1.dirty
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The update-index man page had references to several options, which were
missing the relevant markers, causing them to be formatted as text
instead of as references.

Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
---
 Documentation/git-update-index.adoc | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-update-index.adoc b/Documentation/git-update-index.adoc
index 9bea9fab9a..9b956216d2 100644
--- a/Documentation/git-update-index.adoc
+++ b/Documentation/git-update-index.adoc
@@ -57,21 +57,21 @@ OPTIONS
 	updates are needed by checking stat() information.
 
 -q::
-        Quiet.  If --refresh finds that the index needs an update, the
+        Quiet.  If `--refresh` finds that the index needs an update, the
         default behavior is to error out.  This option makes
 	'git update-index' continue anyway.
 
 --ignore-submodules::
 	Do not try to update submodules.  This option is only respected
-	when passed before --refresh.
+	when passed before `--refresh`.
 
 --unmerged::
-        If --refresh finds unmerged changes in the index, the default
+        If `--refresh` finds unmerged changes in the index, the default
 	behavior is to error out.  This option makes 'git update-index'
         continue anyway.
 
 --ignore-missing::
-	Ignores missing files during a --refresh
+	Ignores missing files during a `--refresh`
 
 --cacheinfo <mode>,<object>,<path>::
 --cacheinfo <mode> <object> <path>::
@@ -145,7 +145,7 @@ you will need to handle the situation manually.
 
 --force-remove::
 	Remove the file from the index even when the working directory
-	still has such a file. (Implies --remove.)
+	still has such a file. (Implies `--remove`.)
 
 --replace::
 	By default, when a file `path` exists in the index,

base-commit: 03b41523c576f26ad34085378717a0c1b287470f
