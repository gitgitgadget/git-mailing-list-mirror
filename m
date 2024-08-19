Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D3AD531
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092090; cv=none; b=SbDzettbqovaXAiTGgKJDGiUzPZXJz8E9LnMzMwmTZTyg4PpsKqtHHBwrvne1icdFLyIo3NqMygvD1yRe6FGXEHdArWG+jsposVPJmQLjDHSZLlaSD/Xi/vhpYvL4NzXek8+bPs21iV14GW8IIx+Mrvm52yzo48WYAd/xO9m7KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092090; c=relaxed/simple;
	bh=zv85TxJmUjuYebI/Ep5isPFfjGLqBHS4Z+r1OwQwa3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJQjro/ffk6GrBwGkpXzfRuZra8gKdwUi0PMIVfTa54hPJTsAZiswY7hLzvAxa+DnAM9JTQL1gbaHN0iLOzsFSoaqaocJllWuYwnj15AUNDDtTCwa2z7N3VGCLGZ2FbKBs4sjfvlMGTLRnQuV/+wmLcVt9u/e2wuapiLkZzrsZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjRLIvrk; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjRLIvrk"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-451a0b04f6bso30095791cf.2
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 11:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724092088; x=1724696888; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FOXAFl2vCRMYRjWjtmA3iaZ0Jai+LehoNLQuiQzPRko=;
        b=SjRLIvrktUmFXjr0U+jVA6HWiND8q7SKFuCTWzHN+nmxpDIr34efZM1e8sBps0Xak5
         01qrzWC4Omnu1HmKHiu4+Ji2wkvVA+lu02386rldQWEzxShlPEfLhkpJbtLW0rjVEqsD
         J1WSpt0bShR+uCK6YuOp2Nv5vyqsCofV6hLXTIo/lSEyfqWbxykMWdkuJQ2TWxE4/Jy3
         hpDbqziuF7Sh0UFEqX65Zq1Qph7ZA4vicdYD+sh4/kIHrcnPOpvG5xbF0sXNVZipZL3f
         LvnStottXdgyLUJheUofy334qgLMA+ABR8jDyNvivF+ufGmpGajxdbZco6crTFWvwPEl
         B7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724092088; x=1724696888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOXAFl2vCRMYRjWjtmA3iaZ0Jai+LehoNLQuiQzPRko=;
        b=jrhg3/5g2c+7UX0jp8ouceuxKBOmS+L6EmjL1ip9ewqNp1JI58ilzLlPIMMdUSXV1g
         PUk+JKnwsGiWfT4HXHrDhtNGWECpGpy45dm17YQeIMnhb8LxN8UrYxajfgYF7c3bHBGG
         eBnWKd0cR6V/sOS67bbppt9GGAyEGxKpJm4OSBC2h3cMfm//7sbLk+WYtv0hxGitHMd7
         2cubGLEUIpO3EaqGSv/IWQXWXiQHVMrUoBdAiwhWb0og09UiY9uchEVkJ9VTfr2amELK
         CRo7K/gwjPmqxO/QkmHRskilEsOxeEFZx2phn9G2Pb7DraNmpofYtBEGyz5m2sPXDHMK
         54jQ==
X-Gm-Message-State: AOJu0YxYvH9BPNhJ51NOm5YelHF6UsIKCvvBBdEH4pRVeZFBIFlIMDyT
	UssoO7/KoNZfeGDwrXTaJ1JosYjhlXTg/WdfDmeRAGGMQebefNdsiCZgrUUhYDEdjUJzqVrXxhJ
	A6+Ir8rLO9w6dFMxr6xms/TO1Ji+Z/Jyd
X-Google-Smtp-Source: AGHT+IEa91giYbK4v1WA+2FC1HdT0dHpMSIzsL2PErWkzBhyf+PEXzU5nKuj1Trbb5Qh8pYfuEmKNMPsc+mJUsoMTjE=
X-Received: by 2002:a05:622a:2a1b:b0:453:56b5:6454 with SMTP id
 d75a77b69052e-4537435a200mr112790141cf.41.1724092088245; Mon, 19 Aug 2024
 11:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEg0tHRL9+tqY0k2GiGzhc-VgMVsHqppLRFHbc=M33R6AoLXEg@mail.gmail.com>
 <xmqqcym4fqhp.fsf@gitster.g>
In-Reply-To: <xmqqcym4fqhp.fsf@gitster.g>
From: Yukai Chou <muzimuzhi@gmail.com>
Date: Tue, 20 Aug 2024 02:27:56 +0800
Message-ID: <CAEg0tHQDT7LesB2kiQD4rXwcUs5ZhOH+YWdn990tfGdrnYdgZg@mail.gmail.com>
Subject: [PATCH v2] doc: add --show-names for git config
To: Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

4e513890 (builtin/config: introduce "get" subcommand,
2024-05-06) introduced "--show-names" option that is used to
give the name of the configuration variable to each output entry
in addition to the value.  It however forgot to document it,
even though the option is used in a few examples.

Document it.

Signed-off-by: Yukai Chou <muzimuzhi@gmail.com>
---
Thanks for your review and suggestions Junio. I must have stayed up
too late yesterday, so what the commit message was sent was not the
final version.

 Documentation/git-config.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 65c645d461..16323c4ed0 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -268,6 +268,9 @@ Valid `<type>`'s include:
  all queried config options with the scope of that value
  (worktree, local, global, system, command).

+--show-names::
+ Output also the names of config variables for `list` or `get`.
+
 --get-colorbool <name> [<stdout-is-tty>]::

  Find the color setting for `<name>` (e.g. `color.diff`) and output
-- 
2.46.0
