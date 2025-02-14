Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A686328
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554584; cv=none; b=aIlzPgqoEKN4IkSk7eYTih8Cpm1MsMTjnELJwCJwBb9ZPHE1gorgM+uiXFWa2Z6kmzvyS56t43O3ODKnPacRJPwm8I+5BnslmHa0hSoFYZKONor8Z/1wPODytSj+vAmOGOnKrfqvtpfG1nXDhOxFIxvFl9Ozrd50LkNGprMCh8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554584; c=relaxed/simple;
	bh=tQM3gd8L3aoV+tlzR7ssNEFrfigpBlD2Zw2NFJmMvn4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=f0u6YSKXTN8H8SsZTjeCxZJeuLMmpLWKRj/OYgTCGgdIDSRPkoVOQKH5bTwxxoLrG42DabSlcg/m769+9Md8oSAl4opchnJHueAynNr4roD3xrd73L5VC3uOIsfNiacZs5GYHlUm3PPkihD3LdPruMNMW0M4LcijC+1bX2sqmNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqeS+q8s; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqeS+q8s"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f22fe8762so1204950f8f.2
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 09:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739554580; x=1740159380; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rBLYm5DIeaP5f38C0729fSzRB4VmF7RMDX53E2Q5YWo=;
        b=WqeS+q8sChpxM3R4YU/N+2C2jf3dIvveDGHAq/QgcmOuzfPbQ1jbqQW3tcEj2/vRhk
         giziwhHcJmAU3MUX2KMSReaGkvnFU3lQkhYlVTDvin5zT8lZ0MTc8eOK+s7EM5njRI5J
         CljVzmSdP0Qvk8quwWp6Ix/NdodfhEIhQDeRtFw+u8qH1vBrOcZdPY5xxQORrspVELIB
         OcsqVsEO6oO5pyBVEFaKievhXASpvp4SJneG23gN216ugUWlWrhzV5TdF8CcT29HFpjE
         tfwwrSA53iVVJCDMg6hHn1ZUlbyzWYKUqn+s1DT9CgXGQ+BUodRMJssLvv3gY0wggQ8d
         g7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554580; x=1740159380;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBLYm5DIeaP5f38C0729fSzRB4VmF7RMDX53E2Q5YWo=;
        b=lMskrri3tyhRZFGIieLfuz53PdYDwyTeH77ZumUtQSnaZK+ekY9pgUgcegVLbVCRp5
         N+TB3xyTtEzsaQLuBXFQz0ntD9xf4ihEhfUGF50HtodAnUHaM+kgl/zPdpXzSp5eszw3
         nCKnxtdsCmEQeH8vIgGdh2IStI1EG6JxTmB+Z6EVlB9OKAwPopG2yAxP7hs8zJcCXFvU
         6AjNz3UA29aw6ClxXxgV31lqVhtryXbIfneipWBpmwj26TwGodcu8f6mxbR2jGGFYArd
         suBJQpn1lTK6AfHWqbuMt35qHz20uQ8Q1bAlz4NuP3R2pasxyHd44tbaKU1DjFSyL1UA
         eRiA==
X-Gm-Message-State: AOJu0YzVtIwS0k5kj+2aFDT/RbeRJsY6XoYOMhKqJsMPcIi5gt1nr2HC
	+FqyQDA8fqIxJaLrGSlUJV+JTNPVwT3x5EDEeOs7/80YnY6ufybrWDIing==
X-Gm-Gg: ASbGncv3HkcBmYJzV5t7kOQpEkN6Kulb4CCsN5YZBg0OPOOy6huB+G69WQfDFsNe/tf
	ve1KLNPfYqpACzSRWDGCvVLDbh7TSRWQaZDiPb7PB7iCzQ6hV7bg2Y8+e1bpj5BeLqQiE9EppOM
	YxOlvOuJqkrw9aVZFfLYNCMKH9DuOCA/jWLv2DAOcvav8td7Lw4hOW9tAeBasTcM+qckzMHP2ky
	Q/pFE5/M+NgMIZ034rARwKian8c/cC4XFgyPL6stVevTCRaJLlZs1TKhOMJTxHTpwbVCA/h0IQx
	0JmwpkCcSYvGD7sS
X-Google-Smtp-Source: AGHT+IG3zNLIktomXQEnq0C8L/n+/AKZSG+wzw4MWKmQq9PiGth7rjAlbrw3vm2DVSuT8MGL3Aa+mw==
X-Received: by 2002:a5d:6c67:0:b0:38f:2758:2bb3 with SMTP id ffacd0b85a97d-38f27582d69mr10942755f8f.14.1739554580295;
        Fri, 14 Feb 2025 09:36:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43960e937c7sm30666505e9.3.2025.02.14.09.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:36:19 -0800 (PST)
Message-Id: <pull.1894.git.git.1739554578.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 14 Feb 2025 17:36:16 +0000
Subject: [PATCH 0/2] Documentation: fixups following followRemoteHEAD
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Bence Ferdinandy <bence@ferdinandy.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

A small fixup and a wording improvement for the documentation of
remote.<name>.followRemoteHEAD.

Bence, thanks a lot for this new option, it is something I've been wanting
for a long time!

Philippe Blain (2):
  config/remote.txt: reunite 'severOption' description paragraphs
  config/remote.txt: improve wording for
    'remote.<name>.followRemoteHEAD'

 Documentation/config/remote.txt | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)


base-commit: e2067b49ecaef9b7f51a17ce251f9207f72ef52d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1894%2Fphil-blain%2Ffollow-remote-head-doc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1894/phil-blain/follow-remote-head-doc-v1
Pull-Request: https://github.com/git/git/pull/1894
-- 
gitgitgadget
