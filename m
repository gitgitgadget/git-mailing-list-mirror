Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189551CFBC
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 01:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737338174; cv=none; b=OpZMchSvf/kXVCmm99CnVdG4JH3BWeWCi3s3s89AjX5VibbEePyaiWgR82RmLOOzaZbZAWZ6EJDWn24INWQ1KVBjG6RPaX35EAXtr6gEnioNBcgE+AnJdXAH9ESQHMZliyeHkW49ysqR9wbckT+wM0MMosRe0EmnxQ6EfEZEaEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737338174; c=relaxed/simple;
	bh=Txtxnr1MJukawzbGsz+3RaepnNE3QJEIxpbR+hN3Mcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrP7aDMYuVf2D9LbChRAuZ9F8T14csb3O2njgUIAUY8GlQf39Gg5VmGrH14CU4cd68v7TQpRE0GPKZD3ANud5ZN0eFhGvU36xDuc2tr+Jd9NO04H76Ih5mZEykqDTlikhATtrtEF/hPsTjQQHsTz/QKaA1jxRzLk6+MDlxWMPRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=K+4K7OSu; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="K+4K7OSu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1737338171;
	bh=Txtxnr1MJukawzbGsz+3RaepnNE3QJEIxpbR+hN3Mcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=K+4K7OSuoy8VDPN9hy4DeQy6x9YhPK59qxAP4ohHMiGyRSneAwOO86SOsbVca8nnk
	 lHgFAGEKB/FNF+VcTmcwKb7vQLUH0FgRNefl6F10Mbbgvx5TqBEPDbTnyu76TaYmeJ
	 P8ResC6MhvSHHxbsKyV4ahXa0gKz1BmuAc3oL/7O6oSrv0HGxNxjTwCvr3Qsyf77hQ
	 tEMi+FMK6yXnlSagUVQu7YW6cgWs0XVjX066wXWJV04jTCbINOI/0iTMNfOr+gfmsU
	 TvRzO0eKCEZsQtPkMrXb+lCZ59mTgrP++4i74dN6wN81BRH2ZfabZtpGjqiW+NpOrB
	 nY5cN9P6B3gJm5yy47E7KSckTU6ffFaPk2mzU52SJQSj8DLj6vyfg6BF+u5HV3qfyA
	 CzhMx05YfkcLHR523jmiOdL7jkhwD+JJttoDCiD30qgh2633v6qojAaGJ8OWMB6pCj
	 Sz1sMpRahfFDU2yAMKnmNZaFT4+T3coQmI4Wt/kTdH2gQUe+fZ4
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1C30C24451;
	Mon, 20 Jan 2025 01:56:11 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: [PATCH 3/5] gitattributes: mark AsciiDoc files as LF-only
Date: Mon, 20 Jan 2025 01:56:01 +0000
Message-ID: <20250120015603.1980991-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.48.0.rc1.219.gb6b6757d772
In-Reply-To: <20250120015603.1980991-1-sandals@crustytoothpaste.net>
References: <20250120015603.1980991-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a future commit, we'll move the AsciiDoc documentation files to the
".adoc" extension rather than the extension ".txt".  We need these files
to use only LF because they are read by generate-cmdlist.sh using the
read builtin.

If we allow CRLF here, the CR at the end of the line is treated as part
of the synopsis, since a POSIX shell doesn't consider it special like
LF.  In that case, we generate synopsis strings in C that contain a CR,
which the compiler does not like because it believes that the double
quote string terminator is missing, and as a consequence, compilation
fails.

Because we rely on LF-only endings here to compile successfully and we
want Git to continue to be able to compile on Windows, mark these files
as LF-only in the .gitattributes file.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 .gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitattributes b/.gitattributes
index 158c3d45c4..b38cfd499b 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -8,6 +8,7 @@
 *.bat text eol=crlf
 CODE_OF_CONDUCT.md -whitespace
 /Documentation/**/*.txt text eol=lf
+/Documentation/**/*.adoc text eol=lf
 /command-list.txt text eol=lf
 /GIT-VERSION-GEN text eol=lf
 /mergetools/* text eol=lf
