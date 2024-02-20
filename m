Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33009152E0F
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 22:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468379; cv=none; b=HyJ5NS9YeGiqUNPBw7nDo4LhtTEYP05+iHx0HYx0H5PxLnNgbMyF4RcY6PvZjgjQ/51ZyxNE5q7MOl9oGsdoCHz888kp/lcVAo2Rwdbxas+f/nzKNCBTcI4D2dyegoFc9cVkH6+KwxRFRdaybGYIs9s5GMOaostJte8fGvqV9DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468379; c=relaxed/simple;
	bh=CO+n2tYokYQFY7jFAsjc+EuIRyQ65TgRcZxm1G4DqWA=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=gND+KBi9MQIvKWazDUTWhmP2aHAh518MsYVs0OYTy33S4rl0ium8G7AH8o3I25F6psWDq1vqK3HNSDZCtK89rI6fCHqZMlVSCamIWMqS7nK+b1iMu5hXQAhDpanNSnGtOptJpRGp9RaFEtIweMnLuKyH2bVa6IRyz5Yn/5zU/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Umf4us8N; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Umf4us8N"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d44d78e5fso1258420f8f.1
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 14:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708468376; x=1709073176; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PGRxoX5ofIpQtM4j3kfv0ZpSxfHRgg5rFXeaonxHhq8=;
        b=Umf4us8NJHaSjAJH5Lb8X2t3YvEuo40rxHX26vaJOvJ90QhOBVz/UT8AgfJIS61EBB
         obk1HzFL4ymZZnlb8rGhpa0rC5RugNkJg4XWl0pUp2Qq/meurBbS2UCSmfxZEGNKni7K
         nKHvuRXNtAcFwceJrhHDA+imv7A2sIpCysnV5lHF5/HUCbfIXdrmAck+nRD6V4jshIkf
         i9abh9saVuJMd0DaQ68qTpamgKoUqVXftGiHU634dovLQSKSSi7FNKa7iImHyIB4ruMq
         pdWdlL+eL009yJ+lih270adei139oqlaMQTRF4UZKMO7724lJOxQ3ryWZNRL8KFfXjL5
         R5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708468376; x=1709073176;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGRxoX5ofIpQtM4j3kfv0ZpSxfHRgg5rFXeaonxHhq8=;
        b=ly18qge7gQcrUjrBUoaKJrVKnKJrMfOx7LGHSK1WyZzErieFqVk0wc3fBpAPsPzb94
         a7RLRp2j5qSru1PcOzaYynDze8Phjge655NOIeMTL4MjOq3U3zaflf9slciXETGHMFJX
         vX21BKJ4cb0RLiKCHzawhRZLMNAs4VoECQgfE8Y4qWVjBSrXsqrGQTE0xvBwyAUuYge9
         TALIukPXK20oJcq5V0PNRZasNona66RnUarHZcsUGA8VM+PG/anDabB9PCX9Y/4uuVtL
         4RnAtohGE2Tn8+1cIPHjTmYG42O0+ofiIDO7qUDIbJloslXpqhNsBnuCaYnLIzQDGCUU
         0ZYw==
X-Gm-Message-State: AOJu0YxUzyl8xTBs8i15gbSQ7bf19TsLihf1yOU0i/rrwiwAdOPWjlAe
	/XmF3zYtZCU+SB+3osQ/LSB9yuuBslwV1z1BNDQwXp5TD5kNTOF760SjFo+E
X-Google-Smtp-Source: AGHT+IGNg4cjtof7zaEF413kvv51HNmNYUMKlzR3O1HE512L3+KJxnqhF9wwS/Mm5cQ2d4F7tXs9IQ==
X-Received: by 2002:a5d:5645:0:b0:33d:3b83:c0a with SMTP id j5-20020a5d5645000000b0033d3b830c0amr5595709wrw.34.1708468375598;
        Tue, 20 Feb 2024 14:32:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bo10-20020a056000068a00b0033d64941167sm4151473wrb.88.2024.02.20.14.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:32:55 -0800 (PST)
Message-ID: <pull.1670.git.1708468374.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Feb 2024 22:32:51 +0000
Subject: [PATCH 0/3] Doc placeholders
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

Here a few commits of some typos/mistakes found while translating the
manpages.

Jean-Noël Avila (3):
  doc: git-rev-parse: enforce command-line description syntax
  doc: git-clone fix missing placeholder end carret
  doc: add some missing sentence dots.

 Documentation/config/diff.txt     |  4 ++--
 Documentation/git-clone.txt       |  2 +-
 Documentation/git-fast-export.txt |  2 +-
 Documentation/git-rev-parse.txt   | 24 ++++++++++++------------
 4 files changed, 16 insertions(+), 16 deletions(-)


base-commit: 5fdd5b989cbe5096d44e89861a92b2dd47c279d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1670%2Fjnavila%2Fdoc_placeholders-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1670/jnavila/doc_placeholders-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1670
-- 
gitgitgadget
