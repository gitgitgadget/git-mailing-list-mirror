Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234F513AA2F
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 03:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743476495; cv=none; b=UXzNeKpHMjRck/sr0/6o1rkkpHcAG7r4oN/GC3mYOc5ditiAY+DWYl8kEQcrgLMolMoGfKJ7vBU3x8CbbmYOMkeQMbSImhNaTwIxpiq4YHvagwTpxcs1nx/GBEAsKcfT5pgq3+1yGWonVKD4Cl/8fyZ7Ny0WTalXhXT4JzGMLts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743476495; c=relaxed/simple;
	bh=LOdxJlvrZQOqWTuGtK5BBGqO563I2OsdJ1nOqLB6Li0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSEaXRy0di+ohYZVSKZrS0yomcElrNvYRHMi8n/dTmPvEh2gQHOmS8HKHHaj0T9WC7okl8nv4q3aotnC4p4mxwQVj49/SaI82Ueu5C9qkkFgpJdvKI+UrZo3EzZGPhPB2c7aB2HB5/7+hS/liCuCXhINlR8KCAiESSGFgvUZS+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AL5yC+nA; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AL5yC+nA"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47692b9d059so70788911cf.3
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 20:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743476493; x=1744081293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDlsfqhNXOHD6byTvJ7madClDJDS0EZblW/2tMtPN64=;
        b=AL5yC+nAL/JMXktCAQa7HW/FCauPkQ+gdkt8RdPpTGh4tGG+n8fOg38JaBq7+9H/VD
         zqij6QYbBIdf3rk6nHCPHMeQ3K9ZKMx6Gz5Wlyy8gj18lueZCgwr49fyBdfNz75NBbzo
         z3C0kManI86py1KgVbAm/3IvPoO3QAZg4r5PEIRDSC7LtkE3M53ujgQBsk5+gT1jgESb
         JEzf0YEJ1EAjbjx6/LOpy7/4Z9t8oDVl3UVW/EwNXh+uo45t26bCy+rJnOi0SlB90Axm
         Q9QxrUmCXQLPO9aLfXu4ww6IGpvxdwXv5rnpac3TamzIJUwhc4zbvIi1kTnxwXT6lIzo
         1T2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743476493; x=1744081293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDlsfqhNXOHD6byTvJ7madClDJDS0EZblW/2tMtPN64=;
        b=BU7fLPJ2w/gl+1dRHOmptQNcoPkMvwloKoT4i57j1CMrTTe7RaVxzQeRPsDHxqv0cP
         XWUfCIdgrSJwPWmmVwfdluDjEVyuIJMKtI2PypAfSNJ4MT7DqKJYl6El70rcdmKu+ZSx
         DoONMZntTLNpESfZRJBCOmz1ulPDMpJKYqYYMwytKgvVPvGrpC04gEKSSDedp24lA/P5
         HrLCK/A82LQltCCGJMdGs3daT6vclUrCoGQMhhd5rBKmW212gQbH3h+q+b4glsdSbDV0
         Vfd6vW9aRZAJCXJ3ak5ZG4zKktdfcweU254ppzggMY3YJMoNd7pq+OH/lHRmMGhzoAL5
         YKdQ==
X-Gm-Message-State: AOJu0Yxn1oNCz9+2Q+GewH/LSSkDDKtkbZM1aXJLwhvWNR60iJ7h3VtF
	t60IjDVnaO3dbt1CRvPQeBcQ+bFZYvn3DvYrA9XKtaeQscZuAtYg
X-Gm-Gg: ASbGncsZ2ZezLaYxglVIiwpTtxujRJM3U7h25Civq/21aq2I8uO2ERHYbM+mC1fo/Dh
	/g7fZRQqnvAxzZgZwxOkw36ZnetrGsVwV8lBdse4RQYJmYL4UbzfBNUxc8U6hVtVCYEAYm1XN9A
	mnjTKcNlfiXuLlvD0eQti+XyIymC3oO/MNSJwr2WwgPffDttFA/LK5FAPh9J0LPCkAtBHrinz85
	Jdq0FsH7EGpAK1sArv+73psx8FaCm1G2VB2JFmW6Cyn45RTcZUqP5u+IUkx5aUJScqclix8lJOO
	+/2YgibaqLKx2+PyfZPD9PawSTyf
X-Google-Smtp-Source: AGHT+IErFHzAoYfaYRZe/fHsq/YX7764+WK2Fy2RSQFXhbpiz+sKwJftLxg2VBqZAfvST/1/kJiLeQ==
X-Received: by 2002:a05:6214:b63:b0:6eb:28e4:8519 with SMTP id 6a1803df08f44-6eed61dd097mr227061046d6.21.1743476493036;
        Mon, 31 Mar 2025 20:01:33 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:2644:5100::387])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec96284d7sm55209556d6.1.2025.03.31.20.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 20:01:32 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: j6t@kdbg.org,
	johannes.schindelin@gmx.de
Cc: git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v2 2/3] gitk: _search_exe is no longer needed
Date: Mon, 31 Mar 2025 23:01:01 -0400
Message-ID: <20250401030102.297272-3-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.49.0.99.31
In-Reply-To: <20250401030102.297272-1-mlevedahl@gmail.com>
References: <5b09f1c2-be58-43a2-9908-7243b5207251@gmail.com>
 <20250401030102.297272-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The _search_exe variable allows specifying the suffix used for executables,
typically {} on unix, .exe on Windows. But, the override code is now
used only on Windows, so _search_exe is no longer needed. Eliminate it.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 gitk | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index a101b07..e4d0500 100755
--- a/gitk
+++ b/gitk
@@ -27,7 +27,7 @@ proc is_Windows {} {
 if {[is_Windows]} {
 	set _search_path {}
 	proc _which {what args} {
-		global env _search_exe _search_path
+		global env _search_path
 
 		if {$_search_path eq {}} {
 			set gitguidir [file dirname [info script]]
@@ -37,13 +37,12 @@ if {[is_Windows]} {
 			# Skip empty `PATH` elements
 			set _search_path [lsearch -all -inline -not -exact \
 				$_search_path ""]
-			set _search_exe .exe
 		}
 
 		if {[lsearch -exact $args -script] >= 0} {
 			set suffix {}
 		} else {
-			set suffix $_search_exe
+			set suffix .exe
 		}
 
 		foreach p $_search_path {
-- 
2.49.0.99.31

