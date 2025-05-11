Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79C9139D
	for <git@vger.kernel.org>; Sun, 11 May 2025 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746970726; cv=none; b=oo75ALSh+SNlIrtiHmAoqLg2OZDJW2DmimYmEaGYPRVDRYnxp/OF9lbdNxpfDuSZL2yG2xlEMUBwztgrcZzYa7v6CyJAzhf7JPGgFpFRMVoIjGPiy4hTK3F6kGcn9fSn5XdyeiMuSDaLMCe0F7rBIiJYcPvEeXmfe7n14LBI7X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746970726; c=relaxed/simple;
	bh=irGi4QySuwhHqzNaYOsxse6lBC2Gqe4oGXPvTP3nHxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyiWBr+IBiNH+/i02G7m4AH7DgjkfQsBwoKGSnu5Nw3gSLGvyxFFn1zvCuloGiyGVcDh7a1VowbeipFm0pzHhom/c3mxnhVXWivU17COqjTjZSeqxJ1OIeQLcCD8JMhO7PGhfjDHKKnG7riSC6p9s74L0zw3bp5fNhD8BuGRJnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4KOGkZc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4KOGkZc"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22fac0694aaso25853595ad.1
        for <git@vger.kernel.org>; Sun, 11 May 2025 06:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746970724; x=1747575524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMrOYLawAKnECrlVscLaQGSIhi4mdVNCj7pUrql6tZk=;
        b=V4KOGkZczTn/V3CunKzeLXE9XUWlbgh/rGsamqzvMWWtcojs5J3hFq64J+3cGJaZXZ
         4x0dXQTXs0ltOZht7ASsAx4wLvk9n8cGcdlJPnOS/VGG/oB7/q7gb1HsOmbdDUlVuJMO
         IhxNnwqqVqEqYvHCBwvEjahtAYg09/P+YeBd65bzztteQpV/mwXBNBMjGQ9UVgiVM0mD
         MRV/BpF0G6oEdlczTz5jB6Uf4hwRbdMGrWwu6xjqtkHra0OOKZXxSpW7UDmN7o2pHn7F
         4Um+gPPBpOdWzKCBe5mMd15GiwCgjjugBKSmT0Jqgx5+KGi6MAniCNDqcnaqY26I72Ts
         ogrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746970724; x=1747575524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMrOYLawAKnECrlVscLaQGSIhi4mdVNCj7pUrql6tZk=;
        b=Kp0O5PHfY9G+YJl/AYKMlGfKvplK5QONFtGC9Kkq/zmK0gfTSdPRteWei3vlos+UVt
         6CCyqZf8BZ9gTIS1uO3iE//0vPIe0QSDqufq71g+zW6yFjYCDAUf8FwedH8R8AyzvtQN
         lV2JtLcFL61c3yF3YKfJnoT2tU0tIw1HE3TsvP47C8zbcYS5nOkxwUrT7fU7Jph7t5ga
         i/H5V5vBRkXAp7AtbJ/RhsX0FLnDe6JbbnwelB7QqAkdHGJoZk2KkZOxlo0iuVfvm6rF
         m8Z7lBSnM4MQfTmRmW6iXYxSO/tqsHzne4Zsn4985g1wJ1o4Je28cG7EyfjmU3ZES83j
         1LBw==
X-Gm-Message-State: AOJu0YxcgNDa50BXItXTjvdJvdpB7t8HNyOinys23GALLkgEa4CjrM6T
	aoxWR4/MwuuBveVFlUZRVtwAyoZ1HXu26Ih7AThNjPB19KXK16SY3V30OQ==
X-Gm-Gg: ASbGnctZByTjerBQcfBryAnoF7Ywe005D/8DV7dUdJncRefhg3CmYc4bviBGaZyNjz6
	PgUm04iVmEmp18t/pIxmLt9Tzjv99UrbEIlXR1RIF0IcWNEw8iHEU46iYapxAJc5c3e683aJUlP
	i364wlqyfadVEIn41f1N0RFrKWVv93f7mhLax9A15lvnIkxjBAy3KsRpWLjydFLEan+4knYpcQN
	nsu4co/PECtIGie/ipZgV1Mja4lu9IjdFBDlvJq7e1hlY56vLuP9cGzwSWun0bpv7fCxXed/NA1
	ER0DsR75d3lKf8636GnwJti3j0PUEub0GW0JJfr1FqUQ+XoSgItxmlj7xiDBFt0c/rmjT0zfFfZ
	r
X-Google-Smtp-Source: AGHT+IHjiZJMHby60IFq+X/o46QQM0LcUDk5emy32N0/y9BtX5PQPerqgVg9QR/7U6ZdPYNeBNu8yA==
X-Received: by 2002:a17:903:2444:b0:22f:bf03:8dac with SMTP id d9443c01a7336-22fc8b5856fmr139518175ad.26.1746970723607;
        Sun, 11 May 2025 06:38:43 -0700 (PDT)
Received: from localhost.localdomain ([223.237.150.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc82c0b82sm45777935ad.245.2025.05.11.06.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 06:38:43 -0700 (PDT)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita <dhar61595@gmail.com>,
	"Johannes Sixt" <j6t@kdbg.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: 
Date: Sun, 11 May 2025 19:07:35 +0530
Message-ID: <20250511133736.16760-1-dhar61595@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250511125809.14180-1-dhar61595@gmail.com>
References: <20250511125809.14180-1-dhar61595@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: [PATCH v6 0/1] Added the newline after the test in t/4018

Sorry , I forgot to add the newline after the test in t/4018 again so I had send the patch agaain.

Moumita Dhar (1):
  userdiff: extend Bash pattern to cover more shell function forms

 t/t4018/bash-bashism-style-multiline-function |  4 ++
 .../bash-hunk-header-complete-line-capture    |  4 ++
 t/t4018/bash-posix-style-multiline-function   |  4 ++
 .../bash-posix-style-single-command-function  |  3 ++
 t/t4034-diff-words.sh                         |  1 +
 t/t4034/bash/expect                           | 38 +++++++++++++++++++
 t/t4034/bash/post                             | 33 ++++++++++++++++
 t/t4034/bash/pre                              | 33 ++++++++++++++++
 userdiff.c                                    | 28 ++++++++++----
 9 files changed, 140 insertions(+), 8 deletions(-)
 create mode 100644 t/t4018/bash-bashism-style-multiline-function
 create mode 100644 t/t4018/bash-hunk-header-complete-line-capture
 create mode 100644 t/t4018/bash-posix-style-multiline-function
 create mode 100644 t/t4018/bash-posix-style-single-command-function
 create mode 100644 t/t4034/bash/expect
 create mode 100644 t/t4034/bash/post
 create mode 100644 t/t4034/bash/pre

Range-diff against v5:
1:  40cffd3b4a ! 1:  464cb8a1eb userdiff: extend Bash pattern to cover more shell function forms
    @@ Commit message
           `x () echo hello`.
     
         Replacing the function body matching logic with `.*$`, ensures
    -    that everything on the function definition line is captured,
    -    aligning with other userdiff drivers and improving hunk headers in
    -    `git diff`.
    +    that everything on the function definition line is captured.
     
         Additionally, the word regex is refined to better recognize shell
         syntax, including additional parameter expansion operators and
    -    command-line options, improving syntax-aware diffs.
    +    command-line options.
     
         Signed-off-by: Moumita Dhar <dhar61595@gmail.com>
     
    @@ t/t4018/bash-bashism-style-multiline-function (new)
     +function RIGHT \
     +{    
     +    echo 'ChangeMe'
    ++}
    +
    + ## t/t4018/bash-hunk-header-complete-line-capture (new) ##
    +@@
    ++func() { # RIGHT
    ++
    ++    ChangeMe
     +}
     
      ## t/t4018/bash-posix-style-multiline-function (new) ##
    @@ t/t4034/bash/expect (new)
     +<BOLD>index 09ac008..60ba6a2 100644<RESET>
     +<BOLD>--- a/pre<RESET>
     +<BOLD>+++ b/post<RESET>
    -+<CYAN>@@ -1,25 +1,25 @@<RESET>
    ++<CYAN>@@ -1,33 +1,33 @@<RESET>
     +<RED>my_var<RESET><GREEN>new_var<RESET>=10
     +x=<RED>123<RESET><GREEN>456<RESET>
     +y=<RED>3.14<RESET><GREEN>2.71<RESET>
     +z=<RED>.5<RESET><GREEN>.75<RESET>
     +echo <RED>$USER<RESET><GREEN>$USERNAME<RESET>
     +${<RED>HOME<RESET><GREEN>HOMEDIR<RESET>}
    -+if [ "<RED>$a<RESET><GREEN>$x<RESET>" == "<RED>$b<RESET><GREEN>$y<RESET>" ] || [ "<RED>$c<RESET><GREEN>$x<RESET>" != "<RED>$d<RESET><GREEN>$y<RESET>" ]; then echo "OK"; fi
    -+((<RED>a<RESET><GREEN>x<RESET>+=<RED>b<RESET><GREEN>y<RESET>))
    -+((<RED>a<RESET><GREEN>x<RESET>-=<RED>b<RESET><GREEN>y<RESET>))
    -+$((<RED>a<RESET><GREEN>x<RESET><<<RED>b<RESET><GREEN>y<RESET>))
    -+$((<RED>a<RESET><GREEN>x<RESET>>><RED>b<RESET><GREEN>y<RESET>))
    -+${<RED>a<RESET><GREEN>x<RESET>:-<RED>b<RESET><GREEN>y<RESET>}
    -+${<RED>a<RESET><GREEN>x<RESET>:=<RED>b<RESET><GREEN>y<RESET>}
    -+${<RED>a<RESET><GREEN>x<RESET>##*/}
    -+${<RED>a<RESET><GREEN>x<RESET>%.*}
    -+${<RED>a<RESET><GREEN>x<RESET>%%.*}
    -+${<RED>a<RESET><GREEN>x<RESET>^^}
    -+${<RED>a<RESET><GREEN>x<RESET>,}
    -+${<RED>a<RESET><GREEN>x<RESET>,,}
    -+${!<RED>a<RESET><GREEN>x<RESET>}
    -+${<RED>a<RESET><GREEN>x<RESET>[@]}
    -+${<RED>a<RESET><GREEN>x<RESET>:?error message}
    -+${<RED>a<RESET><GREEN>x<RESET>:2:3}
    ++((a<RED>+<RESET><GREEN>+=<RESET>b))
    ++((a<RED>*<RESET><GREEN>*=<RESET>b))
    ++((a<RED>/<RESET><GREEN>/=<RESET>b))
    ++((a<RED>%<RESET><GREEN>%=<RESET>b))
    ++((a<RED>|<RESET><GREEN>|=<RESET>b))
    ++((a<RED>^<RESET><GREEN>^=<RESET>b))
    ++((a<RED>=<RESET><GREEN>==<RESET>b))
    ++((a<RED>!<RESET><GREEN>!=<RESET>b))
    ++((a<RED><<RESET><GREEN><=<RESET>b))
    ++((a<RED>><RESET><GREEN>>=<RESET>b))
    ++$((a<RED><<RESET><GREEN><<<RESET>b))
    ++$((a<RED>><RESET><GREEN>>><RESET>b))
    ++$((a<RED>&<RESET><GREEN>&&<RESET>b))
    ++$((a<RED>|<RESET><GREEN>||<RESET>b))
    ++${a<RED>:<RESET><GREEN>:-<RESET>b}
    ++${a<RED>:<RESET><GREEN>:=<RESET>b}
    ++${a<RED>:<RESET><GREEN>:+<RESET>b}
    ++${a<RED>:<RESET><GREEN>:?<RESET>b}
    ++${a<RED>#<RESET><GREEN>##<RESET>*/}
    ++${a<RED>%<RESET><GREEN>%%<RESET>.*}
    ++${a<RED>^<RESET><GREEN>^^<RESET>}
    ++${a<RED>,<RESET><GREEN>,,<RESET>}
    ++${<GREEN>!<RESET>a}
    ++${a[<RED>*<RESET><GREEN>@<RESET>]}
    ++${a<RED>:2:3<RESET><GREEN>:4:6<RESET>}
     +ls <RED>-a<RESET><GREEN>-x<RESET>
     +ls <RED>--a<RESET><GREEN>--x<RESET>
     
    @@ t/t4034/bash/post (new)
     +z=.75
     +echo $USERNAME
     +${HOMEDIR}
    -+if [ "$x" == "$y" ] || [ "$x" != "$y" ]; then echo "OK"; fi
    -+((x+=y))
    -+((x-=y))
    -+$((x<<y))
    -+$((x>>y))
    -+${x:-y}
    -+${x:=y}
    -+${x##*/}
    -+${x%.*}
    -+${x%%.*}
    -+${x^^}
    -+${x,}
    -+${x,,}
    -+${!x}
    -+${x[@]}
    -+${x:?error message}
    -+${x:2:3}
    ++((a+=b))
    ++((a*=b))
    ++((a/=b))
    ++((a%=b))
    ++((a|=b))
    ++((a^=b))
    ++((a==b))
    ++((a!=b))
    ++((a<=b))
    ++((a>=b))
    ++$((a<<b))
    ++$((a>>b))
    ++$((a&&b))
    ++$((a||b))
    ++${a:-b}
    ++${a:=b}
    ++${a:+b}
    ++${a:?b}
    ++${a##*/}
    ++${a%%.*}
    ++${a^^}
    ++${a,,}
    ++${!a}
    ++${a[@]}
    ++${a:4:6}
     +ls -x
     +ls --x
     
    @@ t/t4034/bash/pre (new)
     +z=.5
     +echo $USER
     +${HOME}
    -+if [ "$a" == "$b" ] || [ "$c" != "$d" ]; then echo "OK"; fi
    -+((a+=b))
    -+((a-=b))
    -+$((a << b))
    -+$((a >> b))
    -+${a:-b}
    -+${a:=b}
    -+${a##*/}
    ++((a+b))
    ++((a*b))
    ++((a/b))
    ++((a%b))
    ++((a|b))
    ++((a^b))
    ++((a=b))
    ++((a!b))
    ++((a<b))
    ++((a>b))
    ++$((a<b))
    ++$((a>b))
    ++$((a&b))
    ++$((a|b))
    ++${a:b}
    ++${a:b}
    ++${a:b}
    ++${a:b}
    ++${a#*/}
     +${a%.*}
    -+${a%%.*}
    -+${a^^}
    ++${a^}
     +${a,}
    -+${a,,}
    -+${!a}
    -+${a[@]}
    -+${a:?error message}
    ++${a}
    ++${a[*]}
     +${a:2:3}
     +ls -a
     +ls --a
     
      ## userdiff.c ##
     @@ userdiff.c: PATTERNS("bash",
    + 	 "("
    + 	 "("
    + 	     /* POSIX identifier with mandatory parentheses */
    +-	     "[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\))"
    ++	     "([a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\))"
    + 	 "|"
      	     /* Bashism identifier with optional parentheses */
    - 	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
    +-	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
    ++	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+)))"
      	 ")"
     -	 /* Optional whitespace */
     -	 "[ \t]*"
    @@ userdiff.c: PATTERNS("bash",
     +	 /* Assignment and arithmetic operators */
     +	 "|[-+*/%&|^!=<>]=?"
     +	 /* Additional parameter expansion operators */
    -+	 "|:?=|:-|:\\+|:\\?|:|#|##|%|%%|/[a-zA-Z0-9_-]+|\\^\\^?|,|,,?|!|@|:[0-9]+(:[0-9]+)?"
    ++	 "|:?=|:-|:\\+|:\\?|:|#|##|%|%%|\\^\\^?|,|,,?|!|@|:[0-9]+(:[0-9]+)?"
     +	 /* Command-line options (to avoid splitting -option) */
     +	 "|--?[a-zA-Z0-9_-]+"
     +	 /* Brackets and grouping symbols */
-- 
2.48.0

