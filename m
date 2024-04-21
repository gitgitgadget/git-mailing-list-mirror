Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613A22D047
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713736364; cv=none; b=BfNOc7Gyl4uGjI11NtJcyJ+2+/r/hstCyG5hXvRh/FBCBkYQEhn0r+OHgJFycRYNH0IWdOqVMjup47dURmA1zEbPhUJy1CPQxiO629XrvbYI4PJ1JXyu4C5NcONbrhJwTNcQkncVumByE0vEKJRup2XXo4KBzKpoxAvmV5CBCSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713736364; c=relaxed/simple;
	bh=K8aheKISN9rk0ExjQs+uqMAIyc7sXirNgSyAnY6Vge4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MowdahCE2aYK0E7IfI4Cl1MQCBBC1FUBIsnRLRXqN8MYxCU6BeYXrASOxQWT1JVfBceFM7AF6RPCA6gMPH9XfGNJ+48QUqib8jyZ3ZgGYHummXT9jqzYdQvIctiLab9l+Z/WIzdhRPzko1L9g0cLfOY5IIdWQdQfJPFzv1DDN+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9O4n2kZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9O4n2kZ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41a55be31dfso2158855e9.0
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 14:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713736361; x=1714341161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6tQQLHDR4w3I11faq5RAwfvRtYows12lraydcMfZW0c=;
        b=I9O4n2kZ0kV1eoCj3D/GYlDZnRUJx19jLSjPE/AIfAXtoFkhLknZ9XNrSBt6/EjxS/
         RAy+F2VSxjYa3ZWrA5S/jLN/irbhZJNDgZXGXK4Z2wNEcEcoe/8h6ZmtF8mQcTCPG4Nz
         yTZXknStIjd0U+2bcrgd2rvtrJ9toms0OKMJGhWGBjpcUJUf+w+4SsGCi+UoyZgyzEsX
         NLUtXJlgi8CkYdE2fW8sEABkIW3rtXQW5A6Yyod1hDSJS8b2cTlLvGa8pZu5/rq1qgGx
         DYkhJh1djhYa3m4tYt7ybe6heUhe5ysomBBVqozzC/JPeLJbpsQxcXk9s4rfY5nt8aMD
         PlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713736361; x=1714341161;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6tQQLHDR4w3I11faq5RAwfvRtYows12lraydcMfZW0c=;
        b=F4ydV8D88VHCniFr+RdcU2DBGgNzzn7qIQ7v/0VI9sk6JnjHO+E8Z/11ejnTGuNYFA
         gHtKw3SbmLamDCD/zFd5Py2H1pZAEz6a0Mj789tRpg0t+GtgSBpmJZY4BFZwo81QrGn8
         NsRDnhMf21Rpmghc1U12WxDXrMzgdaBhrUtmEbTVasqasogEnwVHpmy/B7B//KhNsr9m
         YYu/Ua97+Ke/9r59S7CpcJSo9dHx8wQ6IWXczYyZq4YQxOABuTwramFfHQDUTYWQGU44
         c2moE+DzvPMS4Etb89EM5VncNBfJVBxgPViAsJoPozWvr0p8szttTowObIIj4ck1saHz
         dteA==
X-Gm-Message-State: AOJu0Yz+TiJ7JVDKb1cX9ka+7sbueXy4Sh+m+rBajwuoPhc6tCm7P5fY
	NUV4Q+IjBZBL0I+IMaxrEldydSqF3cZVsUbN5ql0PWDbmjOgqQP22gPTAw==
X-Google-Smtp-Source: AGHT+IGYoNtNmVKz2FBU+gYkcWmY6FEKAHOs4cL8HRin+vQ9CL6OasJs55XS5hsAWuq+HusZ1USG1w==
X-Received: by 2002:a05:600c:1389:b0:418:9cf6:bce2 with SMTP id u9-20020a05600c138900b004189cf6bce2mr4296571wmf.19.1713736360414;
        Sun, 21 Apr 2024 14:52:40 -0700 (PDT)
Received: from gmail.com (51.red-88-14-52.dynamicip.rima-tde.net. [88.14.52.51])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c4fc300b00418f7605249sm12350549wmq.24.2024.04.21.14.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 14:52:40 -0700 (PDT)
Message-ID: <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
Date: Sun, 21 Apr 2024 23:52:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4] add-patch: response to unknown command
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt
 <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
In-Reply-To: <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the user gives an unknown command to the "add -p" prompt, the list
of accepted commands with their explanation is given.  This is the same
output they get when they say '?'.

However, the unknown command may be due to a user input error rather
than the user not knowing the valid command.

To reduce the likelihood of user confusion and error repetition, instead
of displaying the list of accepted commands, display a short error
message with the unknown command received, as feedback to the user.

Include a reminder about the current command '?' in the new message, to
guide the user if they want help.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

The test now pass with GIT_TEST_DEFAULT_HASH=sha256.

Thanks.

Range-diff against v3:
1:  0317594bce ! 1:  b418b03f15 add-patch: response to unknown command
    @@ t/t3701-add-interactive.sh: test_expect_success 'warn about add.interactive.useB
     +	test_when_finished "git reset --hard; rm -f command" &&
     +	echo W >command &&
     +	git add -N command &&
    -+	cat >expect <<-EOF &&
    -+	diff --git a/command b/command
    -+	new file mode 100644
    -+	index 0000000..a42d8ff
    -+	--- /dev/null
    -+	+++ b/command
    -+	@@ -0,0 +1 @@
    -+	+W
    ++	git diff command >expect &&
    ++	cat >>expect <<-EOF &&
     +	(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
     +	(1/1) Stage addition [y,n,q,a,d,e,p,?]?$SP
     +	EOF

 add-patch.c                |  5 ++++-
 t/t3701-add-interactive.sh | 16 +++++++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index a06dd18985..7be142d448 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1667,7 +1667,7 @@ static int patch_update_file(struct add_p_state *s,
 			}
 		} else if (s->answer.buf[0] == 'p') {
 			rendered_hunk_index = -1;
-		} else {
+		} else if (s->answer.buf[0] == '?') {
 			const char *p = _(help_patch_remainder), *eol = p;
 
 			color_fprintf(stdout, s->s.help_color, "%s",
@@ -1691,6 +1691,9 @@ static int patch_update_file(struct add_p_state *s,
 				color_fprintf_ln(stdout, s->s.help_color,
 						 "%.*s", (int)(eol - p), p);
 			}
+		} else {
+			err(s, _("Unknown command '%s' (use '?' for help)"),
+			    s->answer.buf);
 		}
 	}
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index bc55255b0a..482d5c117e 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -7,6 +7,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
+SP=" "
+
 diff_cmp () {
 	for x
 	do
@@ -55,6 +57,19 @@ test_expect_success 'warn about add.interactive.useBuiltin' '
 	done
 '
 
+test_expect_success 'unknown command' '
+	test_when_finished "git reset --hard; rm -f command" &&
+	echo W >command &&
+	git add -N command &&
+	git diff command >expect &&
+	cat >>expect <<-EOF &&
+	(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
+	(1/1) Stage addition [y,n,q,a,d,e,p,?]?$SP
+	EOF
+	git add -p -- command <command >actual 2>&1 &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup (initial)' '
 	echo content >file &&
 	git add file &&
@@ -231,7 +246,6 @@ test_expect_success 'setup file' '
 '
 
 test_expect_success 'setup patch' '
-	SP=" " &&
 	NULL="" &&
 	cat >patch <<-EOF
 	@@ -1,4 +1,4 @@
-- 
2.45.0.rc0.1.gb418b03f15
