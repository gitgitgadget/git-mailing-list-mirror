Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE22CA6F
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 08:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708848983; cv=none; b=FwieJPae5Gbqzr5pAtK1UHz+x93USYKzvAHNfyC0thcNhKxqx+m+W4B4GA1ovvexp3h8qfqgiYqqqakMpuceke3EuQkZI1eQhGaO/6NppvT0TbjpoDzGKmB2m4L3jmpAZXhwTZAhoE02xzGLaIDxOhkEkd+KjryfUT2YpJBjFgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708848983; c=relaxed/simple;
	bh=A/peRN89BMipA3RFhGrjCfVyakEm84glq0GwHtr+RqY=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=e9jCtHbOHB7oEYYJMN+G5yf9h1X52m7UnE/ZIY7CGRUTjFMMnYCrQfrZNFuHL2lg89regdkrSxj0KgL0Ms2PB49Dh+2XrDDFyPDrh+xOYAxVNAOXlDqhJPTkxslJFSVAbJ7qnrHicTPeIA5xlneFzLdBAFZ1KupOfVJR1fLn5cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0vuZr2L; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0vuZr2L"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d118a181fso1422474f8f.1
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 00:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708848980; x=1709453780; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHYcswmxIbOwQy1ENUxvFxUS/CSlzUZd2wOAG6Vxr6A=;
        b=D0vuZr2Lz2Ro7lDrZmhRMu9KMLggWDVgT6lbImmM9IgLody6+Qsd0mG8naqbgJ5tcy
         nZnUe0qbJQN4P7fon8HMXQA89wr9hPPdqRqo/tUW8AyjuLhAc2zZK/yM3XSgJEn8B/z9
         Mh3VCxALV1fVMVdOPJcz6QU4Ry/mqLcXQAnMQ1rvonW5ZykksC7pP64P5wpIkW2q5G+B
         7OLuZ8/hdME4NJ37CuuTPyXlurkHMcv5F1/LHgd6IsiGk5QwEmltPK/kHJ4NYqfxtzqc
         IMgqR1yvKZAWzPugNMFjTiRxfml+czWVueNTkLy1nFIwMy3nOpQZFNV2dBZZhgVTqkGj
         7nDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708848980; x=1709453780;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XHYcswmxIbOwQy1ENUxvFxUS/CSlzUZd2wOAG6Vxr6A=;
        b=lbbOGEJmcPEzdthX3CCU35vhFQmLyy8MEbZaI0zBs2xPskYtoxf2lSdbjiEmYVQsUD
         2NH/STsoKEPmebIcm8hlPKC8/CtW2TMORhY5kQDF8yF9btCBIIMFUe47KbPh6tBfJJbL
         QwjvSiwOrtaGSpIS0kl3sHBr0Ue/pt/2T1ikvO9BhSW4QH4F/nuiLDYd1x8N9hEWcILt
         q/vaYz7IG7d4IXhvDAaU+xokgCCiLvkK4KDS2+jyzBUrpdElgvb3Wz146albGvw2bxRv
         ShFVWuDg1WIfq6VZ0dwTbafOTdTYgQs/xFSEheQ4X7D/ayeLXubT7ClaZ2k7kE1YljTP
         k3fg==
X-Gm-Message-State: AOJu0Ywoa8UOLubJC1kGa89JHv4IztOmGUR9MCBU4waxWGHLnUDfX/+u
	fOfg3fGCra3HOyifA2QnXL8GAvW1d9mbuR3QdD4/LgxnG5LihZuQSW4sd1TF
X-Google-Smtp-Source: AGHT+IGLN/r/qjCCOT55psQWkEusb7Dm+HCMO2uxr0Ui+XymXDhDisrjaCHwxd6ffVGvPqXTaunE4A==
X-Received: by 2002:a5d:4242:0:b0:33d:c217:e8a4 with SMTP id s2-20020a5d4242000000b0033dc217e8a4mr1829001wrr.14.1708848980250;
        Sun, 25 Feb 2024 00:16:20 -0800 (PST)
Received: from gmail.com (198.red-88-14-62.dynamicip.rima-tde.net. [88.14.62.198])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d4523000000b0033cfa00e497sm4407020wra.64.2024.02.25.00.16.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 00:16:19 -0800 (PST)
Message-ID: <a1561e02-40dc-4ac3-ae7a-666db0f810ed@gmail.com>
Date: Sun, 25 Feb 2024 09:16:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Subject: [PATCH] completion: fix __git_complete_worktree_paths
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use __git to invoke "worktree list" in __git_complete_worktree_paths, to
respect any "-C" and "--git-dir" options present on the command line.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

I stumbled upon this in a situation like:

   $ git init /tmp/foo && cd /tmp/foo
   $ git worktree add --orphan foo_wt

   $ git init /tmp/bar && cd /tmp/bar
   $ git worktree add --orphan bar_wt

   $ cd /tmp/foo
   $ git -C /tmp/bar worktree remove <TAB>
   ... expecting /tmp/bar/wt, but ...
   $ git -C /tmp/bar worktree remove /tmp/foo_wt

 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 444b3efa63..86e55dc67f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3571,7 +3571,7 @@ __git_complete_worktree_paths ()
 	# Generate completion reply from worktree list skipping the first
 	# entry: it's the path of the main worktree, which can't be moved,
 	# removed, locked, etc.
-	__gitcomp_nl "$(git worktree list --porcelain |
+	__gitcomp_nl "$(__git worktree list --porcelain |
 		sed -n -e '2,$ s/^worktree //p')"
 }
 
-- 
2.44.0
