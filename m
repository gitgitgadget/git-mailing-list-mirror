Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FE51422AB
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721774685; cv=none; b=GIEiqopRZdHxnmD+ts0LX85OquHAB/qeVu6I0vJiGqwbP4ys5p7dP/v/6SnUlSd1NExg9yu3sqmtKRTCFfQCGEdX7tSYoNP/Z84Q1D+ZnofRNmgl5ZdupIemLrWqhw79Wp9PMX7nEYIOQOQeuPdNlw7n22dSG5SWRStXUHiZZsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721774685; c=relaxed/simple;
	bh=lGTVzNmVZrr/XDBtxMpohMnemQ4mQVjLUo16ve5c1IQ=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=DOA2GthE3TAfX7kB3o6DU157zCG3NflC7+dlCM33U2rXoF1gIu68myPZAJRw3HbLubYdynwL1B8IU2Hl5hAYdPGc8ErM/EyTGpQlkCdu9QR14XHWPBNGid3wZDuH+e8egesH/LbWPv/lVv5DKeYYokZfHm5/vJO1IswVAbLzO0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FU2RNQbr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU2RNQbr"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42726d6eca5so44373835e9.1
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 15:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721774682; x=1722379482; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0bkjyrRU+K1fsXAmP6cZbYWwSkSEKG4Usb9S++INBCU=;
        b=FU2RNQbrpPED0HqwXaAh07+caIGHP2+zAvWUZ0VP2yUPuiynaffHG2LEZ0L5zikEAf
         AdTWgh8XR+9HqRRweSf3XlI5gYryB9EgJK6UjWbvmbHZ7GsvrPAv362IHqRyf0hz1Fpb
         aHgKOZMNhltK0T1iQ3tHUL+s33sVfrpCmqSq8vJuAu0PMiePlU97k3RTCznPbyQy8g5Q
         wsEkFC/xDmRyOvCLb/bX4ZyRstW8i1HFAukwM4X9jBxcoprBMypCqGk+VCT2magwc4FZ
         pBCEzSWRVTA6/UBs6mh+5p5lOWy5uGBYqQrDdH/kzUJk59+zkwxYHzijyRD2uW5KlScV
         th9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721774682; x=1722379482;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0bkjyrRU+K1fsXAmP6cZbYWwSkSEKG4Usb9S++INBCU=;
        b=Jf70jVb/RILbpCJU/zjBnED91PrX5AI9FbAbehRHGnnJ24PssmXE4Pkpvrm4mENhj2
         Kjc2MH3rYZ654cMCfL16hyKSEIdRN0pROP0duhxoERSDiyb4xPLpkevy8dZBk54WUn7O
         C4Dejjd8B1WFboP3alqlqmRWUBnBvVBKMyTAvBQV12GVwILHij4ghCHMsBVm8LHhmN1D
         QGXuAaw6mg+ZGK5bwz+XQ7FSrT8uR71xZZ2RAiRi+oFNqj1DKM6o4jXRXCUm5lTj30uk
         RYbYxIjodsBfmQx63ruM2g7gfx+cv0AQah4TTroLBa9lEkBPuPYJYG97JhWKDNFQWBBD
         8iUg==
X-Gm-Message-State: AOJu0Ywf+cwJ1XGktF1OvZ1xF3TrTDXb6zIGhT2aEGwUxfmJmGyNMdv1
	RMJM81bC+b+5ClXOBLm8onX+GWVT2UtfMggOK0KysaXh7hnEj8uUCOyhig==
X-Google-Smtp-Source: AGHT+IF5JjYuTWsDyBGWLLGNF6UwH1OXEcoKDKO5tgqG62BNhfzMfswUWax6egmZQHa0gouoYlRGJA==
X-Received: by 2002:a05:600c:4591:b0:426:6edf:6597 with SMTP id 5b1f17b1804b1-427f7a32720mr5341885e9.19.1721774681611;
        Tue, 23 Jul 2024 15:44:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f9372a6asm3630255e9.12.2024.07.23.15.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 15:44:40 -0700 (PDT)
Message-Id: <pull.1766.git.1721774680.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Jul 2024 22:44:37 +0000
Subject: [PATCH 0/3] doc: introducing synopsis para
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

Following several issues with the way the formatting of synopsis is done in
the manpages that were recently reworked, this patch series introduces the
processing of a new custom paragraph attribute 'synopsis'.

This extension is added to asciidoc and asciidoctor and lets write the
synopsis of the commands without any typeset. The git-init and git-clone
manpages are converted to this new system.

Jean-Noël Avila (3):
  doc: introduce a synopsis custom paragraph attribute
  doc: update the guidelines to reflect the current formatting rules
  doc: apply synopsis simplification on git-clone and git-init

 Documentation/CodingGuidelines          | 34 ++++++++++++++-----------
 Documentation/asciidoc.conf             | 14 ++++++++++
 Documentation/asciidoctor-extensions.rb | 17 +++++++++++++
 Documentation/git-clone.txt             | 20 +++++++--------
 Documentation/git-init.txt              | 12 ++++-----
 t/t0450-txt-doc-vs-help.sh              |  7 ++---
 6 files changed, 68 insertions(+), 36 deletions(-)


base-commit: a7dae3bdc8b516d36f630b12bb01e853a667e0d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1766%2Fjnavila%2Fdoc_synopsis_para-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1766/jnavila/doc_synopsis_para-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1766
-- 
gitgitgadget
