Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14BB5474F
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 01:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772501933; cv=none; b=Iy7q0jOrhpF4fMOhexzq1jyG68MWJrEeCo9PC0hPinYb4+iM2YD3E1OQbVphGA890zrQYi7Jimnwtf2xa8+3DFfC7GoLhJod+3V8EMJfUGsYeNXb1wEMLrqy6aLnrioFkOi6//vAFH0I3Q4rMlVsGRjW8Zi+rRKwNg4bGIN1fK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772501933; c=relaxed/simple;
	bh=MJvj8uFV8GUo6C1OBFffldKS863BL2F9jOVxoeQxGks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ak3kxNHSkTtprPddjGMunl4gvK/waGp000/Af4f7HtuIHqGvaR9H6u+4e28jYrhjjlgLi0yy17ROJmUtFN4WL/yX8+5OqLab8Na5R0YPmFRkXk9I6CMsxX3e3Q3NmUZeHswffJYLMZZruCu9z0tX3Ja7IQWYYtSIqwG75Rpw2GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEQVRVXa; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEQVRVXa"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48375f1defeso38181205e9.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 17:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772501930; x=1773106730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R5d6hoPPmvzJVojnyblptU6kgwaPpoULMI3T7cmCckw=;
        b=YEQVRVXa/DjOT4ny24KXMVVgyC9j6Ci+0H6H2wvPBB84/F8gwQCtJJl9VUZzaGQUL0
         E4ZEsIESqOL1LbeCf+cc+V5ZUTscktwec6v3mg8464z3xIVdh4YW0tAdPEYUE8xeTKVB
         kmWQMCRNvhVwgEe84/OJVdQlYVh/zUwE+AmfSv+KpaxxL2sqswz31tq4ScS/0aV3EG4L
         iVz6+C2cjg2Ei9dOfSJhQ/oQy9+MdTMgDO2Eb/eY+dh444xT6NVnrRCGqabJSOkE6kc/
         6fSyQXwxRF/NN3H0sGAUGcvrnB7d9M7bFsp3AemqsSuovUcJTJ8S8QrWCUq/sfXoMn1W
         wp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772501930; x=1773106730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5d6hoPPmvzJVojnyblptU6kgwaPpoULMI3T7cmCckw=;
        b=c7Gu6yj/5mNof0m7BgVpr/J3/+ZLnBkmgGf3/uClByxAe5zlC3mMZtC0qHGGi8iAhf
         q5gp9bC0VwLxYCQh+NqDh2vU8JXeByFAen/ZdRPrD/wqVbvQbUx3471bHigjGsYhuKzQ
         uGnJxL5mh45ojdhON+yNdOyydr5Dq9eegRY0PrF3Sm6YhyzFSJzBzgKurCEwVh0yvgk8
         TRDEwUGLulQ5bU3dURo8WXW5UowoN69My/kIgWhAtnjlquvF+5bi0CBPwht4KzGlf2gp
         Pe3tbYalLiFiWdKyiHep9mAlXIvxy9dIjU9BInsR0L8FVENKxTXM4jDKvkHPxRVhuCdN
         lJJA==
X-Gm-Message-State: AOJu0Yy/SMJbuD3WgEJDMI1azaQhWjBVP88IPH7N6YnOuM1dd/eJT8gI
	SjKDhHLykc2kFkdict85NHOoF5hz5A/NAm/bi4FZoeu4jHJHdq4vLGCdv6pXFA==
X-Gm-Gg: ATEYQzzirTqYQtK3kWa1BdCkhUZuYlRqMF39AW6TZ2NTKCa2AA2hJuJNEGttSBxM2d9
	CPc4v3hEZfCRI7RNDH2zLjiywR9xuwIgiAr/IucgYIGwXznPo9/FEoWHiacSEXNbv2DMIdkCF9x
	GIRwh3ksD3UEUOtNkykgQFB8z29t3YrLDOpvxYTvqFn/MXPvoBJ6v7B9U9cH3oC2f6ULT+QAa7v
	WwCjj3TP9ZQdHRH4rKXHqOhpbwZkQnY2lqi08JQQA/P2YbXMYoDnxR8B06hNqrkURnD3Mu0Ykdn
	IEOhdvOeooO1c5fhwAgAeEnY8EAynWUCnyrEDib3/D+uKkCSwsB/UVz3jbRylXJhp3wUullNPyW
	ULZY9cu1YL9V7tl9XukJR6ZaUKuZxthROhOibWbZT6DdbAsXhMu/3y2A1koRnsN504Yj1UI1l1m
	ReC+cQHoX+a4ngAVx06cFoxvDSjx7D0SE/6mo=
X-Received: by 2002:a05:600c:350d:b0:483:a8e9:201b with SMTP id 5b1f17b1804b1-483c9b81265mr285027245e9.0.1772501930004;
        Mon, 02 Mar 2026 17:38:50 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b44207sm329912475e9.7.2026.03.02.17.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 17:38:49 -0800 (PST)
Date: Tue, 3 Mar 2026 02:38:47 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH v2 3/3] doc: gitprotocol-pack: normalize italic
 formatting
Message-ID: <6410967d65c9db333f0fc31f3d7069723a1ac7c8.1772500189.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1772467050.git.lorenzo.pegorari2002@gmail.com>
 <cover.1772500189.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772500189.git.lorenzo.pegorari2002@gmail.com>

Uniform italic style usage for command and process names.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 Documentation/gitprotocol-pack.adoc | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitprotocol-pack.adoc b/Documentation/gitprotocol-pack.adoc
index f4c9e024b0..7ed591a0bd 100644
--- a/Documentation/gitprotocol-pack.adoc
+++ b/Documentation/gitprotocol-pack.adoc
@@ -117,7 +117,7 @@ process on the server side over the Git protocol is this:
 SSH Transport
 -------------
 
-Initiating the upload-pack or receive-pack processes over SSH is
+Initiating the 'upload-pack' or 'receive-pack' processes over SSH is
 executing the binary on the server via SSH remote execution.
 It is basically equivalent to running this:
 
@@ -131,7 +131,7 @@ two commands, or even just one of them.
 
 In an ssh:// format URI, it's absolute in the URI, so the '/' after
 the host name (or port number) is sent as an argument, which is then
-read by the remote git-upload-pack exactly as is, so it's effectively
+read by the remote `git-upload-pack` exactly as is, so it's effectively
 an absolute path in the remote filesystem.
 
        git clone ssh://user@example.com/project.git
@@ -163,7 +163,7 @@ supports passing environment variables as an argument.
 
 A few things to remember here:
 
-- The "command name" is spelled with dash (e.g. git-upload-pack), but
+- The "command name" is spelled with dash (e.g. 'git-upload-pack'), but
   this can be overridden by the client;
 
 - The repository path is always quoted with single quotes.
@@ -377,10 +377,10 @@ In multi_ack_detailed mode:
 
 Without either multi_ack or multi_ack_detailed:
 
- * upload-pack sends "ACK obj-id" on the first common object it finds.
+ * 'upload-pack' sends "ACK obj-id" on the first common object it finds.
    After that it says nothing until the client gives it a "done".
 
- * upload-pack sends "NAK" on a flush-pkt if no common object
+ * 'upload-pack' sends "NAK" on a flush-pkt if no common object
    has been found yet.  If one has been found, and thus an ACK
    was already sent, it's silent on the flush-pkt.
 
-- 
2.43.0

