Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxDIzrK3"
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0B510FF
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 12:24:22 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-285d1101868so1246128a91.0
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 12:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701375861; x=1701980661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4WDGlBvPEJ3IF4cabaS+EJEfS4s9onm7zTlGu/jk1N8=;
        b=dxDIzrK3Op+IQVTXBf0Xs+baLgPsrhBSipdr3bh+41rw2M1aSDuEortmdpDQ9z/ESv
         gWXorn0th0lGsi6DkUeHXwzCSJnrTblRk8lAIhE32oLC8F7iFJws95dw7GKlzx/urviw
         by1FG7NW7BXlYBnrxM3GpFdkgsc1jITNy8nmAoJxIUCQnIo8Gfc7OW/0A+z0+0QXxPXw
         kdCkmlNIPvLzr8+RuC6Xogm6iiopmqBHbcOPQ3fuzdoJUNQcbk2sFlIcAwTj5KgaeTP8
         x+Ly+KINsMO1XCrtOOTaJqCK5nHDGVBNt4pEBWuJFR0GWhQ0ap5qpynvNxoI+jbInyax
         OVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701375861; x=1701980661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WDGlBvPEJ3IF4cabaS+EJEfS4s9onm7zTlGu/jk1N8=;
        b=fa/dv8iiD4GiL2zqaOUiVWFZMDBkJ57w0+XMmNMaARNBlBxk/uYxxamY0XLDdnsovP
         Xy6wmVo8zFChbJ/0voepUOSN7azrQD/LPR/XL00YB4Z7hphFG/QoVqhKT97Q3jrVtldv
         z92P/u5jwDwMjeYZZcXeXRkqIeZov6L2j//OSF/S3CD98uvMXij2L8pdauZ12QXXDEOT
         NO2ZtM4qiDzAbVUDBmoHFQ/pQAe+8o3HBig6FiLIt5/rSNpRclHS3hUJADBvMaz8PXye
         I4HvV5LnjMTnv+ZroOuEERQed/bWwxvRX37s4joShXVHnWQddGKJ7O/atV2k42rDtFe1
         OC2w==
X-Gm-Message-State: AOJu0YzqYE/oTkmZLJUs5G398NVbSevGyEqk22DgnIW6ayFpvQCCvMZ+
	0PvSFZ9QIL54MsHFaQ/D60boOW10scA=
X-Google-Smtp-Source: AGHT+IGeKjFx+4KQ702n8luov/PrZedWWQjM7+7YXGYrimtGLPrZ4O/aAKRER3ZxUv92VaPyLsVWjQ==
X-Received: by 2002:a17:90b:3807:b0:285:e16c:fb0a with SMTP id mq7-20020a17090b380700b00285e16cfb0amr12707155pjb.4.1701375861331;
        Thu, 30 Nov 2023 12:24:21 -0800 (PST)
Received: from localhost.localdomain (192-184-144-144.fiber.dynamic.sonic.net. [192.184.144.144])
        by smtp.gmail.com with ESMTPSA id a20-20020a170902b59400b001cc2ebd2c2csm1805509pls.256.2023.11.30.12.24.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Nov 2023 12:24:20 -0800 (PST)
From: Stan Hu <stanhu@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>,
	Stan Hu <stanhu@gmail.com>
Subject: [PATCH 0/2] completion: refactor and support reftables backend
Date: Thu, 30 Nov 2023 12:24:02 -0800
Message-ID: <20231130202404.89791-1-stanhu@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch series refactors and updates git-completion.bash to become
compatible with the upcoming reftables backend.

Stan Hu (2):
  completion: refactor existence checks for special refs
  completion: stop checking for reference existence via `test -f`

 contrib/completion/git-completion.bash | 43 +++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 5 deletions(-)

-- 
2.42.0

