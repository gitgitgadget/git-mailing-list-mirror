Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437561;
	b=lXz5BRyyFVd3OqBOOmPq4CqeMW6V6iaroHcGvF1sxXd1msrUfeydmZjlrSDEWNmMnHOz
	 AzwvIuW8JpKCLM1femwv78axFX99cWxXxhgP4HKK5/q7husoPXZrP6Dk/GeBFropnNMMW
	 ggg8bP9nt4jdbZzJ3bsFJvvlWIpRUlUc0DuS15tfVZ/tpqy7hbhLh80u5aDU0X4ko5pM+
	 xibxADvb1BmtL5lwLLrh6Uz/W1W6RM+hj53i83zR3X18eXUgbB55zXZuwE/DN54aQt21y
	 L654Lu9ejF9uQtdxHJuTTxEBRRlTxdN8YQn0OHfcvBGLMFnkSssj+G8NyR0haCgrCRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=LnDeYWT2d1UDQmOalg4rZSaZixMn2OZcoShiCYtXKtc=;
	b=EEOyz6tVq3mH+8aVOAozBVga2ukDbtgXf7AgxcBSNce2NJ5Fj1JlxstF3VUykUmyamgi
	 P0mIjY0NkFkwFrM74+algnmELH9B9F5aWBGR0rPoyq+Z+xigZn+mk9hkaTlf2kIVnKR7u
	 XJVZ0Uo8OLpT5urrtyynldZn8TylNQ+vfWfsmTYarTWl8dCA15vZc4So9bTksd/oRt0PV
	 8fFHkl0q52ak3EnsDhfemlRee/sMgu3Bskz8QPwC/sFo8Zs2kr5NrvMsdMFcYbL66Yu9h
	 fM8JrREPMA5A9tSXCtHqlMGR0YPkrM+mt+4/bfrO+xBH+QAjd8wn7a5+yGulUr2Cu2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WiNOBXtn;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030260A260B
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 19:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E030260A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WiNOBXtn
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f2493c28bso198817185a.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 12:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792437560; x=1793042360; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LnDeYWT2d1UDQmOalg4rZSaZixMn2OZcoShiCYtXKtc=;
        b=WiNOBXtnlQMFAwMOyVJm5GZi6DlCOzpw9XiKIyppJrfAZyCx+EuuIHTbgHVx74Se+T
         lbk03uGb08iPfnqKl45bZR0OBvFhUeNPiQLbfxI7kxPnrXjCTA8+1Hb1uVvgQrzFFFgn
         WgAbGj7ETQt/jmxuE4Q+UPA67Od+r2OW+2xUtAMi/66L4TxniAa7WJl/azXLNJsDDkkN
         oIABW3Ir7Crn/hfKb6JkLt5cET0WKMlgU2/d9srduJ/UMWa9bxElV4q8BESteryXvimv
         VyuJqA0Kmx7wXLRorxZtb+Cfr7QlOSyZ+8mgexlzLnT+M3uUZ8T/FGR0sstAOHh1VWje
         gk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792437560; x=1793042360;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LnDeYWT2d1UDQmOalg4rZSaZixMn2OZcoShiCYtXKtc=;
        b=nUHzbZiKnaBTBCCM0GeaX98NZgJtXdZl/LDDejaGpQZ3qVevH7w1QjZbkw5ceMnbBb
         /A/fiYfFIAJ5sr1hJCtqaCHE5WE0osXy8V2wNUXCvCPAsEOsgNchOKBn13UZF6Im/15r
         sFsGrbSVKW5DouYDU2vaxrDVtm/Cwrt8Jr4z68H2Pdf7ppYxomeRgX0+qE1NqXodhx8u
         g2Y9u2ZaNTc8065/2cgYODzZXE1djOe9NbestIkmnrPkd5nemPp11dcPWkfxwOHZkjVo
         ztZjzvKVfjF/KWwc+oqdZ2N6x7pT4R7kQfOGDLNJKzA7EcAOqrE0Zam0DF56ZN95QLOZ
         Skig==
X-Gm-Message-State: AFq9FYIxhg9+qrFuAgvyjML3vJB9icPwLXdN4pLVpnfsIQ4aT31Lzsco
	KpGz+DwdIvihJcXETGbJn4+KsrZwyrXdBYiXgphr/LnEMb4cbs1jlvhvAe6M8Q==
X-Gm-Gg: AYBFou2qfOJlF9ien8EeCh0EXqOMxzB7ElGEynE33KHRX4tVDneknXR3aZD+zwp8lJT
	FdRfeXMr+BncV3F3qQVK8sgI04gUqMdiT8BkeAq5MXGnUcmhxdN+KFolBoRmfVFXXpzE2reFjHr
	c7d7OHEnp+JZ7BbKcQCXwjwtHipett0srjm3JSOzQv9qsEHmW2UI9cyBQNSt3UXAOX3kZyzu8nY
	s+4x5fyBf6Pl3lFR0O9pS+4wUTziaQMkMWcXGEMuYF4EhJmoDGSW+eWhQAP2jQAV4uqOZtqpsyq
	dAitesWa1LCgoQm+ze2EkDSFU5PbbumYJx9E3e9al53lQ64Aa75Ac1nNgiH439DbStE/iAs1vG8
	oyNMNYK3OGbrX4+qMQeu/wV0Osej3Goz2BIgC53THlkt8+jlOHUx+F4aXVW3x+e7apMiT9zSEVJ
	mAVcfzlRoq0qCRZya6UcJh4bQQuG4llnxEz6Uv0U1JwJ7AFjMV3+XmUC7zVHQTc6Xc8vmG5T1nd
	jCb082cvfqq
X-Received: by 2002:a05:620a:31a9:b0:93f:33a8:8e84 with SMTP id af79cd13be357-93f33a88fedmr1097271385a.56.1792437559779;
        Mon, 19 Oct 2026 12:19:19 -0700 (PDT)
Received: from [127.0.0.1] ([20.115.103.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f4b082dd4sm34841885a.24.2026.10.19.12.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:19:19 -0700 (PDT)
Message-Id: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 19 Oct 2026 19:19:16 +0000
Subject: [PATCH 0/2] Fix imap-send with reordered message headers
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>

git imap-send rejected patches sent with git send-email, such as ones
fetched from lore with b4, because it expected Date before Subject.

Harald Nordgren (2):
  imap-send: avoid leaking the tunnel command
  imap-send: accept messages with Subject before Date

 imap-send.c           | 38 ++++++++++++++++++--------------------
 t/t9001-send-email.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 20 deletions(-)


base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2456%2FHaraldNordgren%2Ffix%2Fimap-send-header-order-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2456/HaraldNordgren/fix/imap-send-header-order-v1
Pull-Request: https://github.com/git/git/pull/2456
-- 
gitgitgadget
