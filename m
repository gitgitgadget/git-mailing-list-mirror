Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FB518054
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723886767; cv=none; b=ov/mjk9vTC3eGgv6P/0fGy7hhEGhV4JMN1TWECtomNOgHHPoQ5d7mgbLIghOfwL/SDBNhuL0mpaeCFTl+TIi0jg1c6YI6/uCbnWCZCO2I5J1Y3xPs339PGMHIjN6SY8jRAbAWVrfB2PJBqRkfQ86zqObQPdGduns/xh1fkD5tcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723886767; c=relaxed/simple;
	bh=DvrovK2RhCxHLFqm+KbW7QMeNbJF9j4oWJMrKWXEDBg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JkopUmtECwOEuRu3xK9dXi6dqljUcqcbRoEE+FyH5MT707nu94crr8WQb33ynbd9Uq2l0qPcbRj4VW26KF7DaJ+LS8qV7qFr8YXWMUMAi+QpJOI9EdwFn5bybBvZtMQTLxrSX/i9/6m6tI4U1m0L3uFcPancJxS8uWKZFZYvG9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRxmeh7/; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRxmeh7/"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f04c29588so3754025e87.3
        for <git@vger.kernel.org>; Sat, 17 Aug 2024 02:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723886763; x=1724491563; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoyzDjnmVviXdgVK/vuaJ36Sizbft0I5Tyd8ORGxNEI=;
        b=fRxmeh7/ZQ0mSrJV3ayF7Tb9G1UQsIHPrVDuBqFdXgQP6EDo6/ReEccWohDKlB+zaD
         +zilpuros6Zt+nwvra1BckWUsFakks5Rg0z1oJJOIu3NSg5w6EqZ+mdiJm7Y6fK+My/O
         2JIBIbCddo4NcVl0uzWEWnKgSclh13Sv1JCF+2TDO6dhuhUtC9oATNG2I8dh9q9FXywP
         cSWa9HOJFIBjv3YwMNMDkxuVcoLeB6sFxZvHT4POwaMDlmfhlngHAb0ywMQVRK3z3XwM
         wwGKr3YOjbkPyAGUKNUmarl5T6HF57fdm0biqVsl2KpzDCqZC/3V3/o+tOD6cf+4Ok/z
         8rQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723886763; x=1724491563;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoyzDjnmVviXdgVK/vuaJ36Sizbft0I5Tyd8ORGxNEI=;
        b=BTdrjlEPM4oLdMx/v48TVchcwHG1uqUVCRD+5UGHaJyNh1YmsDbzHKZslkV8xHT89C
         5Twib4TZ0p8OghlyXTOF1IRFajcCYjeFEomIQF+dI1CZ5jBAsij2TmF4w8Xwf5yPqKoH
         LjzM6iBoXDLYh6B4IaiYLWiZ3fD1o7A3lmEWMZRFSZcfq3ce1dEDAmF/nYIJKsPN2Xw5
         8H3YsHtWAwiVOozCGwY+GWq3Wx8C6yyX10NSZQd0pGdukqpBzMyFXCLX1RHQx/mecpV1
         dSerf2DCbopiJHLEKFB9T61zvj8y7NuKWJ7JC5hWjJwHrIiP2gzvkoQnDiA34kitTiVQ
         aoBg==
X-Gm-Message-State: AOJu0YzHj8vsQ1tPoy/whuQSDOiZSMOWbM0557RbNGLUfWaF3jm3tQ3q
	FQ3oDwIoMVEQFgo0cbOzgZ32zMQxf4cnkXEVzMEWZPndl12MpzILmtAHPw==
X-Google-Smtp-Source: AGHT+IHvjkvb4b8MeXI7xAh3jMB8UxOMpJROcR4RkDJPc2gzgB//mazeMVsjHfCA1QEgE2+SYLXW/Q==
X-Received: by 2002:a05:6512:2391:b0:52c:df51:20bc with SMTP id 2adb3069b0e04-5331c696975mr3267516e87.16.1723886762285;
        Sat, 17 Aug 2024 02:26:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded18630sm98561805e9.1.2024.08.17.02.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 02:26:01 -0700 (PDT)
Message-Id: <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
References: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
From: "Avi Halachmi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 Aug 2024 09:25:52 +0000
Subject: [PATCH v3 0/8] git-prompt: support more shells v3
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
Cc: "Junio C. Hamano" <gitster@pobox.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Patrick Steinhardt <ps@pks.im>,
    Avi Halachmi <avihpit@yahoo.com>

This addresses review comments on part 5/8 v2 (git-prompt: add some missing
quotes) to fix typo in the commit message "aguments" into "arguments", but
which was used to reword it a bit so that it's more accurate.

Also addresses review comment on part 7/8 v2 (git-prompt: ta-da! document
usage in other shells) and fix typo "Conpatibility".

Avi Halachmi (:avih) (8):
  git-prompt: use here-doc instead of here-string
  git-prompt: fix uninitialized variable
  git-prompt: don't use shell arrays
  git-prompt: replace [[...]] with standard code
  git-prompt: add some missing quotes
  git-prompt: don't use shell $'...'
  git-prompt: ta-da! document usage in other shells
  git-prompt: support custom 0-width PS1 markers

 contrib/completion/git-prompt.sh | 191 ++++++++++++++++++++-----------
 1 file changed, 126 insertions(+), 65 deletions(-)


base-commit: d19b6cd2dd72dc811f19df4b32c7ed223256c3ee
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1750%2Favih%2Fprompt-compat-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1750/avih/prompt-compat-v3
Pull-Request: https://github.com/git/git/pull/1750

Range-diff vs v2:

 1:  9ce5ddadf0b = 1:  9ce5ddadf0b git-prompt: use here-doc instead of here-string
 2:  680ecb52404 = 2:  680ecb52404 git-prompt: fix uninitialized variable
 3:  7e994eae7bc = 3:  7e994eae7bc git-prompt: don't use shell arrays
 4:  232340902a1 = 4:  232340902a1 git-prompt: replace [[...]] with standard code
 5:  4f77b7eb7f1 ! 5:  3a41ad889cc git-prompt: add some missing quotes
     @@ Commit message
            not expanded:   t="~"; a=${t}user  b=\~foo~;  echo "~user" $t/dir
      
          But the main reason for quoting is to prevent IFS field splitting
     -    (which also coalesces IFS chars) and glob expansion after parameter
     -    expansion or command substitution.
     +    (which also coalesces IFS chars) and glob expansion in parts which
     +    contain parameter/arithmetic expansion or command substitution.
      
     -    In _command-arguments_, expanded/substituted values must be quoted:
     +    "Simple command" (POSIX term) is assignment[s] and/or command [args].
     +    Examples:
     +      foo=bar         # one assignment
     +      foo=$bar x=y    # two assignments
     +      foo bar         # command, no assignments
     +      x=123 foo bar   # one assignment and a command
     +
     +    The assignments part is not IFS-split or glob-expanded.
     +
     +    The command+args part does get IFS field split and glob expanded,
     +    but only at unquoted expanded/substituted parts.
     +
     +    In the command+args part, expanded/substituted values must be quoted.
     +    (the commands here are "[" and "local"):
            Good: [ "$mode" = yes ]; local s="*" x="$y" e="$?" z="$(cmd ...)"
            Bad:  [ $mode = yes ];   local s=*   x=$y   e=$?   z=$(cmd...)
      
     -    Still in _agumemts_, no need to quote non-expandable values:
     +    The arguments to "local" do look like assignments, but they're not
     +    the assignment part of a simple command. they're at the command part.
     +
     +    Still at the command part, no need to quote non-expandable values:
            Good:                 local x=   y=yes;   echo OK
            OK, but not required: local x="" y="yes"; echo "OK"
          But completely empty (NULL) arguments must be quoted:
     @@ Commit message
          "local" does not behave with assignment context in some shells,
          hence we require quotes when using "local" - for compatibility.
      
     -    First value in 'case...' doesn't IFS-split/glob, doesn't need quotes:
     +    The value between 'case' and 'in' doesn't IFS-split/glob-expand:
            Good:       case  * $foo $(cmd...)  in ... ; esac
            identical:  case "* $foo $(cmd...)" in ... ; esac
      
 6:  363b7015763 = 6:  e735a1696a0 git-prompt: don't use shell $'...'
 7:  4aa75cdb5dd ! 7:  e70440e669a git-prompt: ta-da! document usage in other shells
     @@ contrib/completion/git-prompt.sh
       # GIT_PS1_HIDE_IF_PWD_IGNORED to a nonempty value. Override this on the
       # repository level by setting bash.hideIfPwdIgnored to "false".
      +#
     -+# Conpatibility with other shells (beyond bash/zsh):
     ++# Compatibility with other shells (beyond bash/zsh):
      +#
      +#    We require posix-ish shell plus "local" support, which is most
      +#    shells (even pdksh), but excluding ksh93 (because no "local").
 8:  e71ddcd2232 = 8:  633e71a01d3 git-prompt: support custom 0-width PS1 markers

-- 
gitgitgadget
