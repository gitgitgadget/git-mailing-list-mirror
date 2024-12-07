Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C45A101E6
	for <git@vger.kernel.org>; Sat,  7 Dec 2024 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733579569; cv=none; b=VZk9XXLboEnBQX4geJLD9R7UpamQH+5t44+DbRBT3ijU/zou2bE8KSA+5AKEqm1aEaef1b9j0bwIMyjrbxnlDkB6tktyaeJIemr/8yWgsnP70akACsibrbCOC7H6vmRzuIOeuAKcuptOFeiW6k0yUAb3OjfJ4lvpHrDza7UAmd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733579569; c=relaxed/simple;
	bh=FCZnfj/nLr8P2jtHz7ssB3dl08qmF+eEK2gHttgrSKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dfg4EMxPRQ3WolBvprvRJsauGa2Ik63GtpW8NZzohR/XGEoJ21UUHKYrTz45oa/pCXtBC+gkETr3RgzEqkfH1b5ln64hJQZ/thE820IwlWChRsgjH/mGAIAkOGf26Wstt5M+J7dt0YdF5pXw+oDOjDJFTRDdntway5ENoaqF3i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9v0AkBg; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9v0AkBg"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa63584e157so37504866b.1
        for <git@vger.kernel.org>; Sat, 07 Dec 2024 05:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733579566; x=1734184366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZPv0tQCN5S42cWgh787iuRJgqoizdaUDAdbGkq2dpY=;
        b=P9v0AkBg6+fm/jNsb9LM3qmmRGrb4cVvEuCW34A8xdEopblrLhNWOs2VXzHDLos8/k
         rzuKP4CoPSMhM/+U1aDGePV8RSFrEr0p9BBO73dqthrPJbeVgnAeDHuPis2pPWY5dcCU
         czG5eNBt791WPpNTO8VFiGe+qOs2x2oCIBOGyiaQbs2TBBJzf0yanmk0s1iSL5z+PC2y
         WChYOU0DcOArfxrrSb7u9wUuDV6BFncOwarlfFBA9TlL6QoqOChrSuFQmaCK/58eWCPF
         MeR9naWmjjBJQDJQpJ7on23QYzSJZ2YblHu2yADrN+XDituZOvslGWfdv7YhkHvkeU64
         KBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733579566; x=1734184366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ZPv0tQCN5S42cWgh787iuRJgqoizdaUDAdbGkq2dpY=;
        b=FGjePHQwafS7K6y32bapgDo3H3kdBoORrFwq17RP4mnkEkZBOgY1jc1fDeghpEoczD
         0kOocAYMOp5k7YXoyN3V5OPY1JO970qOubaQUVUSfznSnsO2awI5UiREJvsVgb0Tj7vC
         H4moMTfrd5AJD41d+zNHU0gskA2+ohwTXoYfMpskJGq34+q90kGoOeaOx4W3M/eOn6i6
         JfYNw0msWLALRnEzaWD9+XNgMd5D2d6vp2P1XaQAVzll6ZJ6yNKRTrwZtrHy7U1sMkQH
         tP1RmPsxTGO8D7xEc+JT5dM2Pt20HZehQz6hm8Ku2Kqrlw9uSxsbzCaSdAMWATQhJpDE
         Onrg==
X-Gm-Message-State: AOJu0YwDuUrR1nHohOAOw4WRwBb4KCBm/nxZzSAg2RzCIWVQrajh4j0T
	gdpYcinLKn7WrZaAnc5CK6oWPsBUyxNhGYD108t2DIwPN/jX2Ww+8Rcdtn3yuW0=
X-Gm-Gg: ASbGncufoCYACh5BWE/od7m64A9qxNEpnm13YT86gjP9g5VXR+xqOVUh7I/y3Wxkph7
	5KEStsqAkttLpX3JvB5UvBaH+DQeW0bt1+A4BFjaDRl2wY6MXu64+iyiFY7k6xPhO+RpVeCaRfO
	OHpDQzjYnNFakQwfbBn1zlYewawowsjjqC90KdgUbrJ7AG+4iBzPo2qkYmnJaZBS6JfCV0YJTKW
	xhLLu64aAenHP0HsWfvb296140fvGzkFaaD62aVuOsU1YyubakjhUSZSQg=
X-Google-Smtp-Source: AGHT+IG7m6fqHlilHMR2N89CgGO5jcmmT7b0kKuzJkFIosLSdn1v22J3BVBBFMo7BUS7UCjlQrOZ7A==
X-Received: by 2002:a17:907:d212:b0:aa5:3969:671a with SMTP id a640c23a62f3a-aa63a287df0mr236191366b.9.1733579565314;
        Sat, 07 Dec 2024 05:52:45 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601f4e0sm385811966b.119.2024.12.07.05.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 05:52:44 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH 0/3] git-submodule.sh: improve parsing of options
Date: Sat,  7 Dec 2024 15:51:58 +0200
Message-Id: <20241207135201.2536-1-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we run "git submodule", the script parses the various options and
then invokes "git-submodule--helper". Unlike most builtin git commands
which parse short/long options using parse-options.c, the parsing of
arguments is completely done within git-submodule.sh; therefore, there
are some inconsistencies with the rest of the commands, in particular
the parsing of option arguments given to various options.

Improve the handling of option arguments for both long & short options;
for example, passing flags such as "--branch=master" or "-j8" now works.

Roy Eldar (3):
  git-submodule.sh: make some variables boolean
  git-submodule.sh: improve parsing of some long options
  git-submodule.sh: improve parsing of short options

 git-submodule.sh | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

-- 
2.30.2

