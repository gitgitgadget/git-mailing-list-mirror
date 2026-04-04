Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA2126CE11
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775323706; cv=none; b=rdoTBbrInROpzGGPtrnbZSjO0tthIhjSvrQPMaSH/HGOUkObjw+YSHFRKq9bYIlti2CDMzUj5CAjCLu2hio0BlXJ2liEpBjVuPmVapkKfJkegbf4l9QyE4ppovLDHc8330KgNmszQ2WfP9usC9WVwMKkjmFVprFQCVj7+FtDoG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775323706; c=relaxed/simple;
	bh=+BbZQbxgaX/xmjeUR6djiM9AKkAQt7zPz9I3uv84eKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fgORH62nb33YeG+P1c2URUqThFTgG/6Yow9dKzcxpx4f3goYdWGQ+97B42XscPRZn5PdfVtL1MU2Knq45c13bCQ+tVOQjjzOjhR3TwPxWNNsB+v4E7xuIShIXVzqRXgstpxE47mxHLHQK/FBO3ypmSY7+/7/442bo7aIWjaHILQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpkXBmom; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpkXBmom"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d02a71526so1614908f8f.3
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 10:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775323703; x=1775928503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TZCf3w0nKttqZqymKyaAc+iWh1901HXvsfwv3Lw0dBs=;
        b=FpkXBmomzD4hMkeJYHfvRqk56qKhUYfqM421b6Ad6tYLu6R0Zp0MGmpf2TLRMrh0xx
         8BzO8bDRbPHAHflYI0ytRYFQ7KUBgHI9himONt+xxHRKcghMR1rZCGXzmc2U4DZDwwND
         63NG/xGow3nkM5gwxgtJguGUK8kWFxhjYvbasWeVQ5wSjJmAj6sZygh2vZQD6NmMRAMs
         3SVkMZAS35ljeXKzhaOFZJ7lihTpA8Uu8uPulUYtS/U8pLG1BRbQYgiX1QZwY6gXSi0q
         cnq+qeywKE57Y+1VeQbm4beejUcoyDjuxYu/dr2FMGtkdVm/108n19TqrVxsVdUAsT0E
         xd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775323703; x=1775928503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZCf3w0nKttqZqymKyaAc+iWh1901HXvsfwv3Lw0dBs=;
        b=f9F9pMmT/1mSJZSDgDdibRXJS2923Q3B/SwP3ob9Y5IlFA1Dc7uD6EXkFTo5XI5G6H
         EDp/ibUJg6LZGAKQ0Y2GR1TpMFmyvnC8vAyvcxx2V0PI4Rg5uqlWUD/1OhNIRL64AMqf
         8e6yOyBm9YFLcRdEbIM1JTYFgs49FZZtNe1vMqFWPabdMk2UOfkhuRkRBVo4XxQ7Z0H1
         70V/0I2f659HQmyAozB6nX4+/r71AXFZNmO7EWaJ1/xToczFE6e9nm09s1YrKjQ3S4Ak
         gGW38PnRprHzzbFliQ/nlAp1kXJ/ggISMP274C82m7y0Z6GrXIoYqSnoxDNK84OCluX5
         vYEA==
X-Gm-Message-State: AOJu0YwHLbq44ABLnhCKxHqgpk3rjn7RM+jh8mwHBXCCszYOsn2CzhoR
	dk5P2RrP6rpyzOcgfFVwU6J6OYppXEZYUOxheLDVcTUIU7so9y3SaMRW25YjZv4h
X-Gm-Gg: AeBDietgimsc+OhxsFMzW4ZWOq2K2p+xmO67H/Zycn3RSIa/Sd4nPAGuBodAoWrvfjf
	BsX80GUu9FdAJrz/bmXzv3sJV58F2k9ZgHoDLMMzNpQTczEKr3sOYmFIwNtyMEGuUqBWn9wr7Gf
	4Ug0bcjzR4D5a5YkV+xDUluhS0FCBXcnBBgHApUfX/062aKvaZGjdPQqw83pX8rZDn0eKogz2rG
	oHRc5kQLX7snkzIqU4HmvVyOmQ+v+1ExOmXT8mL9syWT5/aAeuBUxi+2hvNPSZ5CuNW9lmMSm1H
	XESejXrXK/29oclf1wrDhc0sug+0HEsBx/+xF0yBZyqeNQcrwLxJQyOvbhQKvEczhSLD7VD5WJ4
	tyI8+Om3j1BoxjcExSDv3W/qeeJevcCOiWS1HdJYf9v2Ab97zJph1DPqb5viCauDQILD6K2G2io
	fPp4iHD/O6Y/uwMICmnr6B23GS5QsfY7HF6TbSgNIEPTBSL/71ah+GSAeebnHmzt51ixBqBOnir
	HX8EvcSpLKw0G7MCa4OsmAIGnie3A==
X-Received: by 2002:a5d:64e7:0:b0:43d:2be:e54 with SMTP id ffacd0b85a97d-43d292ff487mr10824047f8f.39.1775323702869;
        Sat, 04 Apr 2026 10:28:22 -0700 (PDT)
Received: from luca020400-archlinux.lan (host-79-30-45-36.retail.telecomitalia.it. [79.30.45.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d282esm26122395f8f.18.2026.04.04.10.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 10:28:21 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: git@vger.kernel.org,
	cat@malon.dev
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>
Subject: [PATCH] object-file: don't use object database without a repository
Date: Sat,  4 Apr 2026 19:28:17 +0200
Message-ID: <20260404172817.2995133-1-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.54.0.rc0.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running `git diff -- $file1 $file2' on large enough files,
index_fd() attempts to use 'the_repository->objects', assuming it
is initialized, but that's not the case for non-repository usecases.

When git diff is invoked without a backing repository,
INDEX_WRITE_OBJECT is never set in flags, meaning only the hash is
needed and nothing should be written to the object store.

Enforce the use of index_core() in this case.

Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
---
 object-file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index f0b029ff0b..68303aa99c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1654,7 +1654,8 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 	} else if ((st->st_size >= 0 &&
 		    (size_t)st->st_size <= repo_settings_get_big_file_threshold(istate->repo)) ||
 		   type != OBJ_BLOB ||
-		   (path && would_convert_to_git(istate, path))) {
+		   (path && would_convert_to_git(istate, path)) ||
+		   !(flags & INDEX_WRITE_OBJECT)) {
 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
 				 type, path, flags);
 	} else {
-- 
2.54.0.rc0.dirty

