Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0013469F4
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176323; cv=none; b=m2e6ZFS2igLIgV1vN6MGR90vfYwOF8Cz2CMDGU/LjgppI04g4epSsKIfFs0ybNOvhnf1tw1fGKloNtIc5amuGGc6qTKpWqPQQWZC/Fv0IpbcSJaCkM99d3YEN/aTARXCuccoXyQaPiyk+hTmNbxjmPljhUmwsyGftmiIavJJ4+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176323; c=relaxed/simple;
	bh=TFLcTS4KlvYZtDwmoV72blsf4SS5MxUkvUhCEvokqu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ty9XgZjn1evEG18CQMRbX1KWvTpUIYhYw4/qlLjqWKXMxnqSe7/HZ4g+wqY2MQ7gZNT0JTnBTeOiCGKuqp44y7zHOUIeIje/2SY/QepQyeVdFUsnnwmLGgrnXErUSaKxdih08dmdJfLj3XReqKo3I/F+WmeOlcIJ9bDtkRiOg1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7G3jtBF; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7G3jtBF"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82a655cfab5so4665496b3a.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 07:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776176321; x=1776781121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IwtF6tvNpLyxBevjpJ0VC82eCCB2LE5sxINBxeclKnM=;
        b=K7G3jtBF7VlUDPlEtkJW46ztQf/b22cyRkqTtfcuF52H3w/IsJEb8Ft9PbTWCz1GP0
         kygk0otoNkz9zbs3XnU/sbRSZiVHHBQQujtaD8/8wbaQx53ytiHARQvNlttgUVctDzs7
         CooQiZma5Y8BULMU/oRk8Wuoc96PeY/AF0vlO5sEYq0vyddw9K1QyO+83cDcYnZY8NnJ
         lGAfLHqCMNpTAP44FQ4v6VHaOOG4hLp+r0UEYdau6u7awWFo9adC8QMPlz9qSs/LwA14
         GaXMG3jQ2engA9uVUwHfSh9L1EF6qMZXU3D5ExvwTsgwTr6yjGVX22Hv1Cgxs7lZ+oSi
         vWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776176321; x=1776781121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwtF6tvNpLyxBevjpJ0VC82eCCB2LE5sxINBxeclKnM=;
        b=QRmP7fbcDjXGFk50jsO3OUBZHq+Ps0M157jp2/jjbAhZswzmStU99Aws7EDTK2iUPi
         ECGzm46+KBsGmmBNK1BUi7YjZzNEMVWtFaGYmtu1/BnAGPpq0ZnBDwcZb59NRpmgsZIG
         wO9ouNSzflaeAwlF1aoaXFcQhV3gw2OIm1bu9Hz7PZdKiBEsdA0YAU1wNSjJGMEiBnaN
         Tlr9DAN5x7znOzjMj39MF9NF3pQnqve/PlLFn86JXdQoZayNA/KqKPMrmQDxxKJd2ETj
         ojP5X/d321puh415iw6GUKm9Rt0viuI4c2NiiSOSgXzsav7MsUxx1dvOA7zpmJH6c+d+
         qCww==
X-Gm-Message-State: AOJu0YzJX5USJ5V+868tNM3E3WOTtx3NCgSgj/+BrWWLcHUmn4FXlbEA
	hEuqcYz6EIasMLx0oDS+rL4xXjen4NV/DZ4/8YsVzUFLInOIUjoyfBPbrCONDw==
X-Gm-Gg: AeBDietI1vS5dFcvdQ2c9dOOBWIJD0ryco8gOdBHCLtXDjzCJxqth6PsjI7S2VoXzwc
	LpLnfM1UbigqAtXxp1Eg5YYRYK+X0HXRsr+tCJWLvO5QxoUCYGPmRMBeO6YZYRrlAMrpAyRM6+3
	C0tv3X+wgwJxeiBuJGtK6iw8VbZfCG1MPnthbcX94LNqBuaycQyQ9uotZZvuoBdpLZzKjMkuU0A
	I2xtNoxMHYwktilgU4TxvPUl3c1r0hJ4kiNSSWXkW2LJcpyW+aqB2LRZnnmdDzbYoZycJQu2QCW
	obUBTUAFhpjSi50vAT4TMhjztRZ21fyNz2a79tkxmFVU4XejfFORMQD6Tg5CJknSZ54BWxFLIUo
	QI/L/IejU0QxWRJuMiDjXwUriOa9vbF3X019I8KJLoKGzRUiWWcZxlxLDn+jaSSIJWuncixpZHy
	vy4d6VckE7l0xWM9wuqnl5M41hYVSkOHjcn9NvoZcKPS9rMNgLzHzZFFCwbTQeGXL71TCNcm9Rm
	xNGU/H3Trf0/0Bl4G3uiEoq5crCPnA60ljyq1HA+Oxatpb0iUcMnYfweQ6qmWeZSQ==
X-Received: by 2002:a05:6a00:1305:b0:82f:b5:8044 with SMTP id d2e1a72fcca58-82f0c1e261amr18728252b3a.6.1776176320541;
        Tue, 14 Apr 2026 07:18:40 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:79f3:3c56:74cd:64f0:3838:afaa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30ee32sm15145048b3a.7.2026.04.14.07.18.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Apr 2026 07:18:40 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	abdobngad@gmail.com,
	ps@pks.im,
	bence@ferdinandy.com,
	john.a.passaro@gmail.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH 0/3] t7004: cleanup and modernize brittle tests
Date: Tue, 14 Apr 2026 19:48:25 +0530
Message-ID: <20260414141828.27576-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses some brittle testing patterns in t7004-tag.sh

The first patch follows a suggestion by Junio to remove redundant tag
counting in the invalid name test. The second and third patches extend
this cleanup to hardcoded global state and modernizing subshell patterns
that could otherwise suppress git exit codes.

---
This series is a follow-up to my previous patch "t7004: replace wc -l 
with modern test helpers". Thanks to Junio for the feedback on the last
patch. I have applied those changes here and have gone through the rest
of the file and fixed similar issues.

Siddharth Shrimali (3):
  t7004: drop hardcoded tag count in invalid name test
  t7004: dynamically grab expected state in tests
  t7004: avoid subshells to capture git exit codes

 t/t7004-tag.sh | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

-- 
2.51.2

