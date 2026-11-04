Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822004;
	b=Rb6/RegknDHrevwK/VZ1GmfP8AgRwJRikCgTkO2CVOaJ9WWr568rs34VaH3FDZQhGvaI
	 mukJISnttNCXE1ZK+cz5Jfmq59GJiqOHR0QgI6FQVTUY9w5PtVyx+vXgo7hudPDVT9bIA
	 Jq8OJ2+ibhWqsQ//Cw2qJeexqXnvNL4C1yg9oaV0XTtHcgAWiiuTNTE+Ds/fIL0b0irJ6
	 CwFrX6QvX2JVmjeAfm6FjVMIdhyTRbmhsAr+/IS6TzNjXHduzR0BQNvcKbGugGfX+zQJy
	 1EpR1bpquTEeqL44ziqhfZ67RxMK1eOi/UQ4ez7B3CsziLRyKTIEC0TEZk3GVGUoriA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=UFFNHs3T4jSpXVkW3luxqP6vdtI94sFEC0+14WNIqsE=;
	b=MrhgMPgtOvj16rL1vLi7W7EN/tMUAYLeHDdItkXbXSX9Ftp7weQTYZaWeAnEii2A18hN
	 shIVPwRll9vD40KgDFD1uWtet8w6dQlUvriXw1aQ5WJdrW1NdP4QJv23IM5BtO/azUJfA
	 GjMv4U59ykOvP+8GKjBaNffwg7CQgCDaMS3sERx5lFY4SM3e/jz/yvmhWKzyK5l8TIxEw
	 wDDZHs8zlLSYb0KxRBbPb9bjbMj87bA1pUidwXMA1bKmfrEAKWKUwRA0YMDHMQcnHzngW
	 uVYPh5P7Ux/ilPFBCCKREObL6+TDWyOmGdK20U7T9QsshNun3NljAkxLC0V/mUZHpqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CaDWe7qi;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D687F60DD35D
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 19:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D687F60DD35D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CaDWe7qi
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36a1947498bso2584678eec.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 11:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793822003; x=1794426803; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UFFNHs3T4jSpXVkW3luxqP6vdtI94sFEC0+14WNIqsE=;
        b=CaDWe7qib+YCElMSjMlPrAOe7PSWKNBTDvMkIUI4iOOTarjjZe1aUbpwN6Vrts6QIq
         7/+3j8EV9hXh4dVSvRwfcVO+0Hg/wNL9RrsAHSTVkebG4JUy2glg196HxMmRp7VHFXcD
         T5YzGX5cxV9vhw+OEeiTREu5pCWkm5EPPz2KBq+yo7/8bRTKVvn9VrvuY+geTrEJPkko
         OAacsyZvV4rZvteBEEmwyOH+D/9r22MFfYT1r4YV+qswPY2mHjxpM9hU5UY8g8BNkWRG
         3sn2HLlZSIgwoTMA1WwFIjPjoUWZOAEWvA4qZSHSSqbScdLOWKJtVHCIXiXwV+Q68a/R
         iq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822003; x=1794426803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UFFNHs3T4jSpXVkW3luxqP6vdtI94sFEC0+14WNIqsE=;
        b=sVkQgRb1jsScRv/X1T51mT1V2u4wlvbW1100JrNckIlTf3eZoKOPO4AtH3k9ARLciZ
         nbJXd+Dqc4MXc6oYPDDjcUJJCtctqmDCxNSpItl4DCHIOEZgqXHFIWxj1Spc0/M3rHLN
         HBfCrqVfrdbkN2iU+mR02y4u3dLFKbE+JRsGN7zKS7GtUSeuahbk1wxlbyuH92RhNZLp
         EKdveCF9RTk7AGs9xdMubteDqSnvEo0rpPGeArl2l6zYHqex+GhOJHfyBfDC6oqQKUgW
         pF6QegFbkosc3kNShZsQyrHjndhwzdRgkiHghWH/T3sPrjg/9KbUDP3kPGDu/BO8eiZ+
         tavQ==
X-Gm-Message-State: APuU4Z+S/KLTzoyzLX67dRhv7jo4mShnBr86R4tROf1/XdrcRQmTfrlj
	NQZSlki0g+5cwB/4S3ArwdO9a5wQ9FtmC7CmhWvJ+IG36//QkqWNsrG/ktzRT3PZ
X-Gm-Gg: AYBFou3xGv+B/PVNRHDDkogn8GUbtlAWMjuzdlJpPzEm5vGxQfOmBGQVh+VbecbiPjq
	zGE812j0xPBdxuE4YrINJpuE7rYhPK+gY+TZ9Go1ELgGoPBBZJkeNsMszSQbuj7cMwSzbqQQKOD
	dew7Z8jMZ+uxCsldJyt7XbNLpZLREaCaYrXsuuyGGZpyTEM3uYz9TZ4Tbvjp4ViK4+PqaKn+u57
	YDg/nOXWcMinNv3EseoGb5Sd3YD+3Oq0tXf45quFiq2/PE9icFwlDlejbNbdAYnpBQFJVWsDiz3
	LJNvSBf8jRriIl8zLJngbx4Atp9I8VKHcYt8sWEzFVB+GISyBrdI1vC/eS0z5++c6uDJrFYoRSK
	Za+vijK1ZOd0Zn03q+QidNB06rhbdhJ9swkkFB/2x+gj5AdfLHXU/hp3oocq+mbWHxYOJhRqTsn
	/ZiFRKg94NTowyJcaD+ZE6k0FOm+DViQCNb9Sen8+AJy271Xrzo5rmOcuEvu8WNFkE79idpXJ3a
	ds7qpxhypsIAEEesbu7HdYFXeBo0FQmBcrzq24digpaGCVSIg6Qnac5qZ1nrCrJzEzSxbEEVxDh
	V5VdBKmOoljhapF/S7dtsU/NprnSiwpylp4=
X-Received: by 2002:a05:693c:41c2:20b0:36a:5042:85b1 with SMTP id 5a478bee46e88-36a50428d57mr23658161eec.2.1793822002842;
        Wed, 04 Nov 2026 11:53:22 -0800 (PST)
Received: from [127.0.0.2] ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3788bffsm9598670eec.1.2026.11.04.11.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:53:22 -0800 (PST)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Wed, 04 Nov 2026 11:53:14 -0800
Subject: [PATCH v2 1/3] credential-cache--daemon: do not apply
 core.sharedRepository
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-fz-credential-cache-race-v2-1-ddccd0831eba@gmail.com>
References: <20261104-fz-credential-cache-race-v2-0-ddccd0831eba@gmail.com>
In-Reply-To: <20261104-fz-credential-cache-race-v2-0-ddccd0831eba@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Patrick Steinhardt <ps@pks.im>, M Hickford <mirth.hickford@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Jeff Hostetler <jeffhostetler@github.com>, 
 Farid Zakaria <farid.m.zakaria@gmail.com>
X-Mailer: b4 0.15.2

init_socket_directory() creates the leading directories of the socket
path with safe_create_leading_directories_const(). That function
honors "core.sharedRepository", which is meant for files inside the
git directory. The socket lives in the user's home directory, e.g.
"~/.cache/git/credential", and the repository the daemon happens to be
started from has no say over its permissions.

Use safe_create_leading_directories_no_share_const() instead, which
ignores "core.sharedRepository".

Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
---
 builtin/credential-cache--daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 65cc619bec..5cc39cd172 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -271,7 +271,7 @@ static void init_socket_directory(const char *path)
 		 * condition in which somebody can chdir to it, sleep, then try to open
 		 * our protected socket.
 		 */
-		if (safe_create_leading_directories_const(the_repository, dir) < 0)
+		if (safe_create_leading_directories_no_share_const(dir) < 0)
 			die_errno("unable to create directories for '%s'", dir);
 		if (mkdir(dir, 0700) < 0)
 			die_errno("unable to mkdir '%s'", dir);

-- 
2.55.0

