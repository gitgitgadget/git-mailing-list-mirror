Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A4640DFA8
	for <git@vger.kernel.org>; Thu,  7 May 2026 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163285; cv=none; b=cbxrk+nBP4kxYIgT+dk3Bl1y75x3Kka4gnHxnkp0ZUAo+fadCDub2oxU2ipfJwKa2Fi3c9dNLW5/M92UukeR8+YHgrxOdwFksuHQavBMpc9MXqLApxe19JQ6rG5DFIVVqJwoyrF0I444QsOA8cxqKq+8zww5Vg5QTMLtIHKmL8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163285; c=relaxed/simple;
	bh=pp0CGAC2dx98+W3+c4/57qalEuIWw0in2XpJKKwv5ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nhzcbYNiRGgxODq0W6w8uXlber7gk7QJfDl92JaXcilVbNamtb1KmDReCi3yP7T0hGSHWJ0D5R3zl9K5wIuMfCFAuD2f2F/7a2UAxiPT0wuv+0kLDjDZPCN8XxvPg2txVZ9MGql54TMjAzpTEcce8FW1x9KJ9+yc9oMUSzZfKkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/viQ1Kz; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/viQ1Kz"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50fbd79350dso7186241cf.3
        for <git@vger.kernel.org>; Thu, 07 May 2026 07:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778163283; x=1778768083; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+x0+nMrfc2laBBLDiOtZrfkRtizboODSHec5bPeJJOM=;
        b=X/viQ1Kzpw2xrSTepRZQii6042eii33mAB3WQXuPKahWFlTIsEPScg1zuWNP9S5Irq
         sgpT+gKRFDWgq9ppP/b7qrsbxpNmMA4YSPgPDxpQ6TD0ulZmYPR30eoG8d/veQUmiOGD
         HYGUy8H4rHX5r4BWzSAxUsb2ZxHVFk4OLE84N+iuNUetIA2QooacCLP1Fu+4Qf+tVBu4
         DPLNC7/hJdbXYRCeUg1Lz2CQSOJXXm6q4uS6w6cGQ9A3Z06gka4Ucb490pZ3YcbHii9o
         VUw/ZLK66sW/i/tA0dNT+i9snMrsQHjQNPwJoRGV28fBgiJKOHLczj4oMoyngCcoYkyl
         8rJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778163283; x=1778768083;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+x0+nMrfc2laBBLDiOtZrfkRtizboODSHec5bPeJJOM=;
        b=rqk8tL66z2CxAmjfp+0bSeozAnkpddfWsHVjqVMo/Gw69DrnjVc/YpPe7JcubMfQ4m
         NWCEN4+OnqrrFSTMrq1nwH8CiYREKYxHd3y4+oh00tbhYMg7QvUck5FFrjBut8vRQwyW
         YgWNnDoL8me96FAbyC3HV5pdhuVZxxIbXYjQp1vH7BOCwYCZYP5xguTKonHrjwMTpu8o
         vbfALSnqecQzv2eLhyJqSf96OLBfP9GlVskJu0laHzBlGuge4/aI9S+K0WMtC4Vbrfv7
         iIRcwqvHZDeEuSQMF52M4fpDoFCfUuCJ9kF6T3joKYqvliZiLkoy+G7vf7Cq8aoMQ456
         0UYA==
X-Gm-Message-State: AOJu0YzZQI3Q6XbvzEWiGnT6vlXnXDeKHQrblBQoT2kgMqSd0E76C3TB
	++AdAt1ERAzckdw4kKgRtjYKE5rETtVIdKX+dLVBr5Pq6Hi+xf5wloL5VW8OLcJW
X-Gm-Gg: AeBDieuxNhuORm8msKvkEni8XViEkxOOq1DN1xTETSyNh6d3dxVJe1IoAUogm4EMJTg
	di3To23p+kM1W2uV9dbwaHEcHZYw4bGc/dYS0uk/bfV1Kz+kLXKqz3nW4WHFpACGUNNbUwusmt6
	y7TYYpLbmOnvZWRsh2/6ZTugr8LNDwSP7FM3S1Nu43JgM3i5gWN4sqHE94s8RSqnOdbAcraP3zU
	l1Za6LfpLWiSdPmkvgpdMPP6feRv4qxjggJfk4gON+JBMEYLmA0iKPb+LxQYwT14hBCksabCUTz
	SIEFdWfVPwtKlvBChtxC6cyx2h9PXMWOdMvEw1p1GPmOm0a7p+j72yCpMek+k5CXvbq4OiBxqFz
	m6KapF72SbZoPdsyp8cScKa5zpU6zR3wap1hwPbFkpQJ0G3C3i88+3cy5z2rN+hqUFzVnhA8+2g
	lk0CyX1MFx3f3cICd86X5DK4tbtVfLrV5rL7BdsjLVC+YlgUuQis0/GkyrGiwI90ONp9/t6Zm2F
	3R8CuTowh+95oZGQAEYrabZhCLlQ7Fvn9/Zq6I3a8mxmlT/eB8Jjcri4Tsy/bVF8/LF84Lj+yvZ
	lS80uKrEfl6ZkPzxw90gAEh8OySdhI3vvnBZto/qqbQNz9e23idaAjGApOvGZEw=
X-Received: by 2002:a05:622a:550e:b0:50f:b1be:76f9 with SMTP id d75a77b69052e-51461e27350mr110196351cf.24.1778163283168;
        Thu, 07 May 2026 07:14:43 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([208.80.35.35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51467169c24sm39038201cf.1.2026.05.07.07.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 07:14:42 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 07 May 2026 10:14:39 -0400
Subject: [PATCH] doc: git-log: document --no-follow
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-document-log-no-follow-v1-1-46ce02490eba@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBA0auQWTtJW4JNuIpxodMBh9SOaUFNC
 Hen6PIt/l+hcBYu0DcrZH5LEU0V9tQAPW5pZJRQDc64s+mMx6C0PDnNGHXEpDhojPpB76htA9n
 OWA81fmUe5PsbX65/l+U+Mc3HDbZtB2kT+Lx6AAAA
X-Change-ID: 20260507-document-log-no-follow-72c33dc15017
To: git@vger.kernel.org
Cc: =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>, 
 Junio C Hamano <gitster@pobox.com>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1778163282; l=2224;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=pp0CGAC2dx98+W3+c4/57qalEuIWw0in2XpJKKwv5ks=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBzAXHvSHSiVYCEVsf68JLFcUOv12T1GwwTx9Dq9lSsirCtDy1j+l+degB1aIlcUDdjiDsdrPzO
 /8urXGHUlgwI=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

The --no-follow option was added by aebbcf5797 (diff: accept --no-follow
option, 2012-09-21), but git-log(1) only documents the positive --follow
form.

Later, 076c98372e (log: add "log.follow" configuration variable,
2015-07-07) taught git log to act as if --follow were given when
log.follow is true and there is a single path, with --no-follow
overriding that default. 1e9250b5aa (diff-parseopt: convert
--[no-]follow, 2019-03-05) preserved the negated form while moving the
option to parse-options.

Document --no-follow alongside --follow, and mention the override in the
log.follow documentation.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Documentation/config/log.adoc | 2 +-
 Documentation/git-log.adoc    | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
index f20cc25cd7..58147dff9b 100644
--- a/Documentation/config/log.adoc
+++ b/Documentation/config/log.adoc
@@ -54,7 +54,7 @@ This is the same as the `--decorate` option of the `git log`.
 	If `true`, `git log` will act as if the `--follow` option was used when
 	a single <path> is given.  This has the same limitations as `--follow`,
 	i.e. it cannot be used to follow multiple files and does not work well
-	on non-linear history.
+	on non-linear history.  This can be overridden by `--no-follow`.
 
 `log.graphColors`::
 	A list of colors, separated by commas, that can be used to draw
diff --git a/Documentation/git-log.adoc b/Documentation/git-log.adoc
index e304739c5e..58a2be60a1 100644
--- a/Documentation/git-log.adoc
+++ b/Documentation/git-log.adoc
@@ -28,8 +28,11 @@ OPTIONS
 -------
 
 `--follow`::
+`--no-follow`::
 	Continue listing the history of a file beyond renames
-	(works only for a single file).
+	(works only for a single file).  `--no-follow` disables this
+	behavior, including when it was enabled by the `log.follow`
+	configuration variable.
 
 `--no-decorate`::
 `--decorate[=(short|full|auto|no)]`::

---
base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
change-id: 20260507-document-log-no-follow-72c33dc15017

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>

