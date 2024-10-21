Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FDE1E5705
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517654; cv=none; b=UcR1md1vLPzZ1a83b1d4hZGE/9g9D4As+o5Tw2Bk56smStOAmP1ulYq+buUG0Rac5mY0BAw4Cvx6+VtgH8aGz44FpRjXtJHR+zE9PP3r/uwVUfB9mBlZHjsWQ3gSocbEG+tdCx1DDIJS55pQ+LuucmC0qLdLB5zDBQT3Ze5Vnwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517654; c=relaxed/simple;
	bh=Iq240slf6F8USCuNlFVvJmIT6fjkny4AKF4dW34UQj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aETogHumILefYh2UggeDzX10bolwBnNtBtlgKO0OKVAWBnXaiSOfqfIGUrSNBNnArtRgmE0d2EJz0Y3VBLWKC5JK5+CQznpLxoLuS7WwBAc3+Jmd0s5hsPTA2WgbnwS6g232cqWQJRgWo/s2qNEAfUu3ih18AEPfhzsIEixldGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2bU/jqF; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2bU/jqF"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2e88cb0bbso3251622a91.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 06:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729517651; x=1730122451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc/fmkvpcUY3It7x/Wyto6u14vgd1/H96CWyWXBd6jA=;
        b=b2bU/jqFf2iymXfWvqw7XDiDtEjazzMPovAsB2A0mFnxL6LoCQQTfVakvO9QT1CNLi
         bIMuuNhEJiRYgvpU31GHzfiT3fkTHdAD8R5A0M27mY+ShjkyyfnDvMUvN7f2FjZpmkMs
         n4hDFeRck+Cd7Vqp9TFR/f6uyoHme1xgvmeyfrDrhIsuZV0IJLyhMsKnQfKClZf66sP+
         P+LJ+6vQqQHBKIi0kHRQJHPAYpp4dm53XR8vLs1JuEHu0LmzhuE2oTCN3jePmilPMOfV
         2fP+sVLQwYVrvyRlgZqitoIxm+NrR/+krQL0733qCnnbreUhEUu6m/JLdtx4LLbop0ZW
         h0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517651; x=1730122451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vc/fmkvpcUY3It7x/Wyto6u14vgd1/H96CWyWXBd6jA=;
        b=YDGWZKjIbSNhEMwlAJoiGJwgnjoNIOOJQy0zKAe1TVv+EevNDLSU1W2zltBtmx8EhN
         CM9HUg2+fwobE9/SQAbMvIbc0ptTrNEi7AHqxZmElYye/rKITbZsu5lJ9fUmzRgzOTST
         oDYgkmXnNR7qhhQVQeeRyqJOpznH8NZ1+6UT6bVnS+MApZD9NE9Sh3uj1AJf5rzVZgBI
         OebY4xCPwAoC6gfw+sT/JWeIWAeruy37tWJ7aIgTAGPa0kezk0NqraD8WfjuteKl6LZ4
         5/llW43d7mNqOyrrhyooZkh+lrbaTAajekhgFbogT7ZL7OiWcMceMAGt1jFgXopjxXaF
         hhTw==
X-Gm-Message-State: AOJu0Yz0YfzpkS9v2UA3GilZ3w83kJ9t79AG760MWVauBoOOGxMecM7s
	Zku3ZRVIWJHiw8YxY18qsceMyzwNX8tdOfM89RfFTvyzw5OOe/jlroaKHkWq
X-Google-Smtp-Source: AGHT+IGdyW2bZBzUnCAwH5R+nFf9gEsSIIY1eHwCPi1YIb+kmmWTAhx5y/eNLE9tkb3OF7NM3wnUKA==
X-Received: by 2002:a17:90b:4b0c:b0:2db:89f0:99a3 with SMTP id 98e67ed59e1d1-2e5616e6f9cmr12408301a91.26.1729517650861;
        Mon, 21 Oct 2024 06:34:10 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad4ed127sm3727306a91.42.2024.10.21.06.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:34:10 -0700 (PDT)
Date: Mon, 21 Oct 2024 21:34:13 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 1/9] ref: initialize "fsck_ref_report" with zero
Message-ID: <ZxZYVfgJlk8JxC94@ArchLinux>
References: <ZxZX5HDdq_R0C77b@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZX5HDdq_R0C77b@ArchLinux>

In "fsck.c::fsck_refs_error_function", we need to tell whether "oid" and
"referent" is NULL. So, we need to always initialize these parameters to
NULL instead of letting them point to anywhere when creating a new
"fsck_ref_report" structure.

The original code explicitly initializes the "path" member in the
"struct fsck_ref_report" to NULL (which implicitly 0-initializes other
members in the struct). It is more customary to use "{ 0 }" to express
that we are 0-initializing everything. In order to align with the
codebase, initialize "fsck_ref_report" with zero.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0824c0b8a9..03d2503276 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3520,7 +3520,7 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 		goto cleanup;
 
 	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
-		struct fsck_ref_report report = { .path = NULL };
+		struct fsck_ref_report report = { 0 };
 
 		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
 		report.path = sb.buf;
-- 
2.47.0

