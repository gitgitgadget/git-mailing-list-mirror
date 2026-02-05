Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4522938F935
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770287306; cv=none; b=Zzrpoj1zPM5BO/f2BkHF+xregKDjR/uFNQCxEcWG6pFSiycNTuSUyJE2OXVF3OpRG7ZVaZ79FoY2flDTrrHY+AKTWzg3LJK1H9Ef4dG8b4ctlBn9hAOnPZZtEDAl5igXJ1cIqg9K5Jll7rmlZ6I4pUJAN5QrWjpAVQG2hrNDqvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770287306; c=relaxed/simple;
	bh=2P6LQaXp4TbRFPVUYARPLVR4Id4mU8Dol/oPb7A6ZGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPB2nI5vVwlb6xiGR3sQOF7aG0GBbJV+fPA5hrmrQBawqdyAsQT0yeTkjB6D72SUgCXzXnHw6N4e98/s45HN+hv/yAYObQLRWG6ri+iuXuUXVn1FpJt4+Pg+wJ5SPA+/S8yg3qwmem4K83pwW0WmtG1GnQARkZzVLUkXSWJqpck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnizHCFx; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnizHCFx"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-354a2d107bfso225972a91.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 02:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770287305; x=1770892105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4QJUCfKamv+2dOmurFqD3WeeHzW9ujoXtmj0jfKXog=;
        b=CnizHCFxy7Q0wRkq4JkKV7i/B6h6bvRYGy7d7u60N3W75GWRCeG5zOQzwYbZkWDFvn
         k7PxGroSEPJ9Whu7MyAvTTv+QGEq1LmGxuWrs04JBhyRDayNuRQJnNB46TxMfJbGfcll
         8lgXWX4z0Ixovr8jMCT4oSegd239WHY1/m6kQxmqx65byM6P1wsFp8hHDldu5TyljOfw
         2OK8GVj8hWSb9s6+JaFhIgN1ob1lIUWKAkGIXOB7+ACueOOfIy0FgrczJnJfGqQC1bOb
         wMiHz7Y1WfEGDYu2kead2pQgBGNjwtnP2MHIhl/GdHRKYoO/FNE+ZFwSCW5nWpUs/jGi
         ra3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770287305; x=1770892105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z4QJUCfKamv+2dOmurFqD3WeeHzW9ujoXtmj0jfKXog=;
        b=f1tQh/wJtvnKFKpR20GY+XLykkmW4u75/xFE7dCHubicmzkx3yzoqDzFV+uGQ7HKFH
         DAPOgJQ9jgYnVqvOFIOM9dk9nFHlrO+Xjj4H1Fk+HRX8nyBoQvzujR+LEd5mQgQkYkNO
         Krh35S9zY4shSi9oGdWoxwFdqGkJMTcfjma7yDY1qfYDOa+l0i5KMGB5sWAA4ulM5kBr
         eudlzldEX5xfhnviLW81WLS4Bo3SIhrGnQDmPOKdlyrp3CLaAw0xNQ/siiVWVLn7iSyx
         AB8mlmNXDg9fHAvURpjZ/9amogEGm7dc3o+Xnfxjc/slTHffkn5BoRU4XsS6UtQg3vML
         DvAA==
X-Gm-Message-State: AOJu0Yy4aUSCyH70JLLqT+bSTUInt7MRfY7tW9KcExcpxTSWSaNdzmhi
	6qTDHRJcrTsdtcukhFNJA6w9fRr0DHCj8VK6BQXuLg3Chu3ZYjVOjz2/RjeEAw==
X-Gm-Gg: AZuq6aKjxRbSadvnekJbVU4R/rgBGKWyWmkM2IlyaQnExfdlbsmSJZD3+Qg2An0GDNT
	jRw9VXXHtBIaQabwIWXBgffjrwvzJYuxjXCkRUfvAGtvW/KJEEBAfxL3p6nVBlWOkQxvrh5YLqR
	hYsxZghp4KkBsWtDzzrU4Bm1s/Cl6YBwkaOCrxdszbWaBM1s5me9GBWkHIjM0puY3//7kClHqOK
	8jg0eMrhNahc27LJFP2qpGIL5OWG+Z27PlRe0fiAArt8gHC5YDsw65cuGHXjuFrj5FEEoKys/xs
	vIgLzd7gQHmE/QCVZLKxS+EomMQ+fxzbcZksrq+3ijBC0pfImJK2VnEWmSfPgIWwEXuipodky7n
	YCpVZls6c8GkbxBuCkDujGLYz+UM9X998JyVBU1d7DIWn8t52t4ixgiuXsAmvzfUcUsfAxxUg+Q
	FKQ4Dg4vjYBGyySDweawf/NJDyevVFwHU7OeNwtC5V+6Vt3w==
X-Received: by 2002:a17:90b:3dc7:b0:352:ccae:fe62 with SMTP id 98e67ed59e1d1-35487115923mr5417278a91.10.1770287305388;
        Thu, 05 Feb 2026 02:28:25 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:1078:b5ff:8b66:3ef8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6c84d67f2fsm4737182a12.17.2026.02.05.02.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 02:28:25 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH V2 0/3] wt-status: reduce reliance on global state
Date: Thu,  5 Feb 2026 15:57:23 +0530
Message-ID: <20260205102815.134373-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205101524.125452-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260205101524.125452-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I forgot to include the changes in the version.

Changes in V2,
- Explained the changes and the reason more elaborately in commit message.
- Passed struct repository instead of accessing struct worktree in
   wt_status_check_rebase() and shifted this change to patch 2/3 instead of 1/3.
- Added information about leftover globals in the cover.
