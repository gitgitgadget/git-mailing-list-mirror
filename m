Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78FA1804C
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165938; cv=none; b=fldCOs34H+7LXdDma9ogHiJc0tj9elNHDauWayWsHE+NJSqbJ0DjLX0iz78i824iIvCgzlFoZW4x2Zqn3DEYcOwGJISnxMnJqvMNwAWUsBT/ZcTgGPxtB+MEAxtR4KvBuxGCdc7fBxTYwx+Ju73l+95xTMzqhCVGNP2OoHSTi4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165938; c=relaxed/simple;
	bh=T92LFSCsC4+lhisddzlNNHNzeFcUyMwIHV4Is+CZ71g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=h3oNxcH7OoU3RJIwmTG5UQZ7EqGf1BkclLeFy6KtNd16u0Z1nefvvNUGBsikfTq5B+NyKymDKcgYzOD9nxuTdLUVrRotDU+K/mh9pgJMjlbG1DCWGpm9h4U/RJIpwKxrc3lWi90JgbjjfppUTFB4bJCpArPwYjukROMRiMg9wT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzzcZY3F; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzzcZY3F"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c1ec2d05feso2070605b6e.0
        for <git@vger.kernel.org>; Mon, 11 Mar 2024 07:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710165935; x=1710770735; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDedSQVQhh1YBnJmKSeTk+8PxrWVO9to6nsfNmA5Fxg=;
        b=lzzcZY3FU+/p9QYywx+7tYwqX2EMs60Hwk/02bs1IZoJqm/JIrPnfLBlQ6JiuK/KJe
         B156ahfMz8kW0IYo3LN15bRI6/voU0q7j4vWciPHOGQLHi8AluZNUN9eB5QkJHYa3WKm
         0dGcMWC8ZmVkMP9tMEubglV1NMl0e6rsDGCH1JawqfN9XfpxLk9Vg1s+qxauX4LnCUFV
         YayajCDDTJ/GOjA2xgV2F/NX7On+KuyflnpUbaO8PLurFVzvfFxpakYf0xCsykW97Tah
         3umPl8lP0Evd3ChozD0sMRXJGSJ0wdGZN+V2NWYQsLIkaoTsgo9IUF8U4SMJ4TiwFvSU
         L/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710165935; x=1710770735;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tDedSQVQhh1YBnJmKSeTk+8PxrWVO9to6nsfNmA5Fxg=;
        b=ZDQTdl87sm/oXBc6afFRV9k9uqb5sO91tLj98vDy7OUmsfX4VRr6e3Az/M6wDbQlF2
         96p/d44aWEH8YGrU6jsdYwzD2lMeOBPvxacxL0Mlb2RYHuBxJNtE0PDMA2VqCBmv5OcI
         LeZmwcvw6QAX1Pkm9ChpIkTGw6uAHkuEHgPttsf6QBZzUwMCObEq9pOdqOWztyu21rKO
         Ijdu2o3MPd+rdTMfa6lD2TdgaIi7Q0KRwcQmES2/JQ2LnDJPj/fjLflFdsloEClvDcXy
         /pXZNsTIpuDVu26WJ2p/n6EsdxpnvscZSIXmz+AC0gVJoSBz0VXM/cJBIYnLcfyXJL3f
         uUEA==
X-Gm-Message-State: AOJu0YyVos469Of7LdmThBYjcKSqwIjBsx/MCsm44eg1FB/3Fp3g5uTi
	d0rrgn1p9jixTHSbKeHecLDWBQ8U8l/x81dcEjUD9syhL1JKho9R45nkjIrtKiazSWNG0cZ10kn
	IxGy+OGqCZNGQxXAOQ7uRV7Onun7LivNJn+1b6w==
X-Google-Smtp-Source: AGHT+IE2XXojGA06U9h/wMK1vZFPskbGCNlL10vpBpZ/PTkLcF6qrEMBUxmYBAlL+cCtD2CIUop2uQ3XmQZjOV47ROg=
X-Received: by 2002:aca:2119:0:b0:3c1:eef0:88d9 with SMTP id
 25-20020aca2119000000b003c1eef088d9mr504445oiz.57.1710165935575; Mon, 11 Mar
 2024 07:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: RQuadling@gmail.com
From: Richard Quadling <rquadling@gmail.com>
Date: Mon, 11 Mar 2024 14:05:23 +0000
Message-ID: <CAKUjMCXik2565fok+z9=43DUcigbfqpWAEM-rfnO0rN=gS-Okw@mail.gmail.com>
Subject: Fix early wrapping when using bash with git-prompt.sh
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 71f179cba3..6585164efe 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -259,10 +259,10 @@ __git_ps1_colorize_gitstring ()
  else
  # Using \001 and \002 around colors is necessary to prevent
  # issues with command line editing/browsing/completion!
- local c_red=$'\001\e[31m\002'
- local c_green=$'\001\e[32m\002'
- local c_lblue=$'\001\e[1;34m\002'
- local c_clear=$'\001\e[0m\002'
+ local c_red=$'\\001\e[31m\\002'
+ local c_green=$'\\001\e[32m\\002'
+ local c_lblue=$'\\001\e[1;34m\\002'
+ local c_clear=$'\\001\e[0m\\002'
  fi
  local bad_color=$c_red
  local ok_color=$c_green
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index d667dda654..fc6fdd36c6 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -13,10 +13,10 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"

 actual="$TRASH_DIRECTORY/actual"
-c_red='\001\e[31m\002'
-c_green='\001\e[32m\002'
-c_lblue='\001\e[1;34m\002'
-c_clear='\001\e[0m\002'
+c_red='\\001\e[31m\\002'
+c_green='\\001\e[32m\\002'
+c_lblue='\\001\e[1;34m\\002'
+c_clear='\\001\e[0m\\002'

 test_expect_success 'setup for prompt tests' '
  git init otherrepo &&
