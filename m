Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7334722A80D
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 01:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771895391; cv=none; b=FaFwOrPhEevMvmOKUiumHig3CDX8DhQdH1CjSetmAldfBrbLNd7CogpyYA3mVo/ojKPfdY4WfqeivjiNNf3tcARXLN6wv8MkHPnGTPVDfhOfm85UYCR6CCnUUHS5lnq/55bTWxGCSYrQpzSX4HSNk9ZtK0r0MGngKrBaLHwJVCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771895391; c=relaxed/simple;
	bh=hBVHPWyMFeOVX4Ke6n46MgXM+sMFaudDZBIVNlTm3Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VQ8hvrfbS3JfeRz+lzbeKndvmG2NECUIb2P0461CDjcuJ50+ETOrC/YgRaUId68gRoLyMKVPuAwNSt1FGhStC9BJxBB1f6lcfCcF618/X6IxXsXlRU5Cb/ZIAfCiIl7ZlyTBiXNaEChCrB3V8ul+fgGO9u53ijs/fYMZcgyTiMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMlAzy52; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMlAzy52"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43622089851so4872276f8f.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 17:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771895388; x=1772500188; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=soXUqTaVK5VNkh2DElTIOrf4n+I8zS5BiEsvWqjyxEY=;
        b=lMlAzy52sbSeAuC+w08UwJ1/phRm8U3SgqDGto2s3dAbpQ28tNwHDcc8dPUaj2lxIb
         1v50Rbo/eDkdaQ0qbYk4ZTPVqsZDIdcXapQGro1lzpzR6Uu9gRgPGaNksZu4+V+EvKvj
         ZS/VbPfpnllMdc/y3aSJABpKgdqx2FCWqEm8LtJmkbXmnkFRWsPNLIJzatOEeFu6vCEt
         cbqXvUaIaYaNRO19lMwN46f5KbEHAh5B/Tn+WmkINvNtdk7ApU3w4CqDqtRYNhdEm5dG
         yrmgth6CDWCXVEtyU8OXvjq4ARrB1EWE3XxOsvH65AJmtCzFXA+PQimqOm9iGmNoob/0
         gXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771895388; x=1772500188;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=soXUqTaVK5VNkh2DElTIOrf4n+I8zS5BiEsvWqjyxEY=;
        b=tu7HxnSiB++h35JAJmeYyh2V8q00I3lU2VcZcGLTZ/1EUZdskPXmTuOszS8/VceJXc
         EpdUaRCQ87FZuko7vSBTBT7i+vFqKeDZKKva5Shn5HityniKymEUkUwJsQwnigdxM+ZQ
         n+a4nf4GdEeHpBnAm/DX+mYMB2yLhozHiWLCr6r17abKJFdtFbEJrr9EmXL8CDR/nUU9
         HjUe2wfXrp2+92tQhZkaZXaqw8mhXfi64c0VTFlHeD7lH4Qmk2LMfiAREfkp0iv0CPxW
         Stuq2sWjjMyhR+fPa7FoVpiYVJfGB/pxuC0nbv4N9wOuTi7+drB8pWBJZ9Dt263QPuKp
         D3Nw==
X-Gm-Message-State: AOJu0YyI+Xpv8V7u2InbGIQkAR06C7mPMz021yrIisyjq3h694+m3fdd
	osmx+TT7CLXitNC/DVpt+KmIW/csxfMunMM4FWLITq/DxoWYxEFNSwwMik5qtw==
X-Gm-Gg: ATEYQzwQGzFAkvqJLYhLfgApeo2vcQwOTnnMcdHgp7c7rlsEdf2KPiiEzjBnDvLFZSE
	FBBkxBB56j7md64BIAGZ/5gkaB3L6qtlipI7IkcSvrxuHJY8OVz+FiX2aU8/SOFoB3o6knCUMcn
	Mw2t419EswZjrNv5ckAHEfrsbrtwaSilUryigpo+Zls349RdaaLdgcTujXc7o+tEgOvicQdL5G1
	tBU17AmpPHZSXE6o0pKulwy5eEiWLf6AwEJN3f8OWmEPnZehNRWAg12cYqwQPapR6nMzsbK5rtF
	h818hl+4qDB8rTkQbIAvZRz4Lcn1MmijKkyLPfIcshHH3VsCSVMwudOaq3uV61SZO+kb9l23Ply
	88M4nmiEPzky/vpI+D3B1tmlt/35jm4kaj63KLv/dTVB+JZHhSwD582SWcQ8Um+EMX4N59J8n3V
	cdfqUsHxjp8HhHGgp6PV6aYHEAH39tc8QfG3IO4MmiuIckRg==
X-Received: by 2002:a05:6000:611:b0:432:5b81:483 with SMTP id ffacd0b85a97d-4396f15c44bmr18750716f8f.24.1771895388270;
        Mon, 23 Feb 2026 17:09:48 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43986aa2f84sm448039f8f.7.2026.02.23.17.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 17:09:47 -0800 (PST)
Date: Tue, 24 Feb 2026 02:09:46 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH 0/2] diff: handle ANSI chars in prefix when calculating
 diffstat width
Message-ID: <cover.1771894207.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch aims to fix a bug where the calculation of the diffstat width
incorrectly uses the strlen() of line_prefix instead of its actual
display width.

This patch addresses the NEEDSWORK item added by ce8529b2 (diff: leave
NEEDWORK notes in show_stats() function, 2022-10-21).

Also, this bug was reported and suggested to me by Junio C Hamano here:
https://lore.kernel.org/git/xmqqikd3ermt.fsf@gitster.g/

Junio, do you wish to be included in this patch by a Reported-by and/or
Suggested-by tag?

LorenzoPegorari (2):
  diff: handle ANSI chars in prefix when calculating diffstat width
  t4074: add test for diffstat width when prefix contains ANSI chars

 diff.c                                      | 12 ++----
 t/t4074-diff-stat-width-with-line-prefix.sh | 42 +++++++++++++++++++++
 2 files changed, 46 insertions(+), 8 deletions(-)
 create mode 100755 t/t4074-diff-stat-width-with-line-prefix.sh

-- 
2.43.0

