Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793433845;
	b=qbIRDAa989yilel8Le/NyIxBSeA8uQe5LEQBzECAe6XrZCspFJNCm/jE6XWaaLevyaYY
	 y/3mMSvCx4C1s6/7vpoT9gg9iYliiS8NZEI9E0cgyeC/48VQjpbLBDG5OYJpF4czBe/Sy
	 GUl39RaRosZVD8YKnnrYiJAuokHX9xvs29ziS1rKBIL+FdM7SEsK3OC5kSqkfFdXW+XBd
	 1c2reBGUe3gzgl1hDN5jNrp5HzvaQ3gv+up9oklmT84cTOnNlGrpeBSJmI7REZ4eJaTZ+
	 zNn9QFluB5mJmxuxGdcgSIPkQtcM8a9Py3SaBLp1rNXm3v+AtiBug+3fih5BXoQE6Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793433845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=0Aj92D5jjt6q2/xG/xLGhskFwp/B39xWwW+9x+XtScQ=;
	b=EVkZ+tJhib0jAEnP3HXCmRO17capGdmAjFDFhIIDKdZGVGdSy+Vm6KgSWzfziLfmu+yF
	 Be3d9bsWia/S8Cm9O+GaL4tYnWglUORCNgvqvhC8WIqPAGpNpPjeor9jJ/QRzcYo3B4GT
	 rQ5s9fMB3FlV1yOqeKE/qXOVom/jgLVYBHs5SYTppCRfV/qNe5MOvf2hOsRwqyrAnkdFd
	 7BmP7uffBA5GekFfEmJg0VQIjjQU/ew+l7VPDZcO84/Jhs3EbLlFgyEMUv9sPUWNlZlCB
	 sh7D2M7kbq6wq36R4KeTu3hS9mFKHUPs0DcywHwv1YCa11rPlOjZdtX9DpTK/HhpNaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ypkzs+pq;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86E2606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 08:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E86E2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ypkzs+pq
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53fdd2fb171so17667591cf.2
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 01:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793433844; x=1794038644; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0Aj92D5jjt6q2/xG/xLGhskFwp/B39xWwW+9x+XtScQ=;
        b=ypkzs+pqUYwOk/nZ6iKDXi0Fz7S9z07pLszQQ/lJKBUjjQNjgN6ZLYIgJeTfaNyBbU
         sID2fE0cAFFGad/AjWdO0MOLBtI46TaFKOeCIXgsSwkVlc2fQB15agy1C/PBu2+kt4w/
         qVT7ghApZKDn0SC3E809ruRB0IkMX92AYRyNcywZ+uLvmwboqzpdlIKd3dFsiTOzwN9G
         aAg4hvEHqB4e+Laf1rRMWQmJvkc+Y0sLlXhNwkMLXXZy5wjni6h7tOOtsgsJ93IifEpr
         wra7j6E0q767kf8ipAxY/9+Z34byOeCfF2Htwu7czuGCm1WiuM4Fr9NB6zspDzVat/XQ
         IE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793433844; x=1794038644;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Aj92D5jjt6q2/xG/xLGhskFwp/B39xWwW+9x+XtScQ=;
        b=sCGVS3JxnI448pxxllN9ZdKIjFAzBn3aCPJvohsezYDljIehVuvUXedG01CeYRbo0j
         FmQd3sBDeG715Z5V+JUgsoi9K5F3b5wR15tbEJ/ZdbbYcT+D0Hrezgdeb8HFtsPDauT5
         xAWd/NNCpHKtAmNtFTWICkXJlNsJZ3UuU5aFA81q5Geg0ArUxA4XpFcUjgkOofdq7Egc
         81Ax9SH/P9GhLGbKgXxAgkss/anWrnURbnlMygT60yzk6xiVw3gNhDPPtIFlGvL0gU+r
         Yp6ePoV+Y8JItNR5T7HfKkao8z/2sasUk6Iv4gM0esCMYp5bkzMh6ksXtxuawAFFLCtB
         G96A==
X-Gm-Message-State: AFq9FYIRaCEgk/SGlJDwFYL6idT3upnR/IddwzwZ5Lm47ubX5kXlvN4K
	riVnJp8DQ1e/7N/RrFzv47rW8/I7EAXfuIAiqMP2j6Gdzpo4WSCX/iMhtbB5Uz9Z0Ho=
X-Gm-Gg: AYBFou0czt18qLlurjmFytmRxsPBq/rI8n6/6n0oJpyCtk6pveUoTT5a2AGGcOU7t2A
	PBwJHBGD/sxfvG0j0kWdoz4/fFneZYmAcMw/gf1BS0bIcNyB7hlexaDcDJBrZWlIaku5FgBkFet
	ZqattEUyLxoWpDBHoGSEKxvelLMKFsv/xfMsy+spRYHzdL36yjAS9jBcccZAiymNf5GzaeYvv/5
	PfzzE2c8HFnaOtlEgvV0MRLN1wV7GtSmsIN/3fQxatyE6d9aNXkWsAiafmabz/s7nG3vb+ubMsx
	kf/u5IiyUtFbnrT/QJTPpAXtLtsQipeSPBsD4LvkREPTRGYbO+SP0GXH7Apn6bJAlVocXEOIUOl
	e8upOoUwFhnCyuxHNEqnYPz9av7Xk7xt18RFHOH0oUf5zPIHpWpoMxEdW6xpFP0DmedWX+ZL0Tz
	iOs07lpjMTiBXdNkF4k3PuYmKkgJGnzCbtY48C9nVaOHbiaCp8HYKWz4ExmE39uNFrrC35CWDiy
	DDEolhEgMTaf6/Bqn8Q0kwCUDz8nLCRnIhBLNePA5M8nBPDJ6m9AJdB2MqnRVwPQ9IKXwDsbZPe
	STkODhFeA5HoVmsrKmg5dt9muytM5WiEMw==
X-Received: by 2002:a05:622a:488:b0:535:dd0a:c09e with SMTP id d75a77b69052e-542b85e3f81mr71340471cf.74.1793433843831;
        Sat, 31 Oct 2026 01:04:03 -0700 (PDT)
Received: from [127.0.0.1] ([20.127.239.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54312a5943csm33346981cf.24.2026.10.31.01.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 01:04:03 -0700 (PDT)
Message-Id: <pull.2466.v2.git.git.1793433841.gitgitgadget@gmail.com>
In-Reply-To: <pull.2466.git.git.1793105039624.gitgitgadget@gmail.com>
References: <pull.2466.git.git.1793105039624.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 31 Oct 2026 08:03:59 +0000
Subject: [PATCH v2 0/2] remote: resolve "simple" @{push} when pushing to another remote
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

With push.default=simple and remote.pushDefault pointing at a fork, git push
pushes the branch to the fork, but @{push} fails with "cannot resolve
'simple' push to a single destination".

So git status cannot compare the branch with where it was pushed. Make
@{push} resolve to where git push goes.

Changes in v2:

 * Moved the "simple" @{push} code out of branch_get_push_1() into its own
   function in a new preparatory commit.

Harald Nordgren (2):
  remote: move "simple" @{push} resolution into a helper
  remote: resolve "simple" @{push} when pushing to another remote

 remote.c                  | 43 +++++++++++++++++++++++----------------
 t/for-each-ref-tests.sh   |  4 +++-
 t/t1514-rev-parse-push.sh | 13 +++++++++++-
 3 files changed, 41 insertions(+), 19 deletions(-)


base-commit: b9e5cff1803ab24582201ef059516eb16014b9d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2466%2FHaraldNordgren%2Fat-push-simple-triangular-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2466/HaraldNordgren/at-push-simple-triangular-v2
Pull-Request: https://github.com/git/git/pull/2466

Range-diff vs v1:

 -:  ---------- > 1:  151fef69b9 remote: move "simple" @{push} resolution into a helper
 1:  d2b1a00d23 ! 2:  c58afcc4b1 remote: resolve "simple" @{push} when pushing to another remote
     @@ Commit message
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## remote.c ##
     -@@ remote.c: static char *branch_get_push_1(struct repository *repo,
     - 			const char *up;
     - 			char *cur;
     +@@ remote.c: static char *branch_get_push_simple(struct repository *repo,
     + 				    struct branch *branch,
     + 				    struct strbuf *err)
     + {
     +-	const char *up;
     ++	const char *up = NULL;
     + 	char *cur;
       
     -+			if (strcmp(remote->name,
     -+				   remotes_remote_for_branch(remote_state, branch, NULL)))
     -+				return tracking_for_push_dest(repo, remote, branch->refname, err);
     -+
     - 			up = branch_get_upstream(branch, err);
     - 			if (!up)
     - 				return NULL;
     +-	up = branch_get_upstream(branch, err);
     +-	if (!up)
     +-		return NULL;
     ++	if (!strcmp(remote->name,
     ++		    remotes_remote_for_branch(repo->remote_state, branch, NULL))) {
     ++		up = branch_get_upstream(branch, err);
     ++		if (!up)
     ++			return NULL;
     ++	}
     + 	cur = tracking_for_push_dest(repo, remote, branch->refname, err);
     + 	if (!cur)
     + 		return NULL;
     +-	if (strcmp(cur, up)) {
     ++	if (up && strcmp(cur, up)) {
     + 		free(cur);
     + 		return error_buf(err,
     + 				 _("cannot resolve 'simple' push to a single destination"));
      
       ## t/for-each-ref-tests.sh ##
      @@ t/for-each-ref-tests.sh: test_expect_success ':remotename and :remoteref' '
     @@ t/for-each-ref-tests.sh: test_expect_success ':remotename and :remoteref' '
       	test_cmp expect actual
      
       ## t/t1514-rev-parse-push.sh ##
     +@@ t/t1514-rev-parse-push.sh: test_expect_success '@{push} with default=simple' '
     + 	resolve main@{pUSh} refs/remotes/origin/main
     + '
     + 
     +-test_expect_success 'triangular @{push} fails with default=simple' '
     ++test_expect_success '@{push} with default=simple fails when upstream has a different name' '
     + 	test_config push.default simple &&
     + 	test_must_fail git rev-parse topic@{push}
     + '
      @@ t/t1514-rev-parse-push.sh: test_expect_success '@{push} with pushremote defined' '
       	resolve topic@{push} refs/remotes/other/topic
       '

-- 
gitgitgadget
