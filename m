Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED62154446
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713207644; cv=none; b=m4N4s3VA/kkuQOEtfJ+dcFnJex2JCwGDZAiIXv6p3H5PY4fSjOLPL12FjZ8Sk0+hbS8NxyuGdPyblk8/aj5h3He2Cm4ogdaw33kIH58Q4OK+kyqIxSf51bH4raUfcqPm0YBNWpHZFvYQrr+Np0/GsbshIwiJ8PkVCBvmG4uON18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713207644; c=relaxed/simple;
	bh=+SWqPbPNRMG6yyfiXd2TDjT0SsbsucgVMMZBYPMh+18=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=VS4We3n8QipD6w7t51UpOTtknumJ1XXc3t36yaK0nyox6h3IcyuT6kYzR9VK3LoCMc2THvVm31m5ibnAMlofUd0rvVkEtwFz80I5+/t8vUw0w9aOVWmecLfNumk0T/gSUp5t20kU0CIO6l7xczP+3MNT/2/WH/HNolHwnaG44Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQ2+Q+eO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ2+Q+eO"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-418672b4714so7085625e9.3
        for <git@vger.kernel.org>; Mon, 15 Apr 2024 12:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713207630; x=1713812430; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ng/r4bNqdlscOI7vt72PnFEgnKMOLlNRsvo7+bpEkVM=;
        b=PQ2+Q+eO/fEShvkxqIlP3IStVUieTdNWPW5PMncl78I1EmMLx8zRm9zdrNy862+VaU
         r9U4JCc7GvJD3ErA3wwYGfN5MUX30XPOMeJ8C/tP+SzJsTs1sfWQHVKWFii3o5Kp2uBO
         xRhPvIBMjWmm8Su0UYtn9XkNKWZoPkBffV/wNyZkKu6izr3N55viwwo2lqVmR42T9Sk6
         F3oXJqvpXV0juZ66qwTnYsj9UxlSRFVZ+GTauVmVdoaPN1odNOibmIzMlK8zEH7gA6aU
         g7lNfzF3o7qEd09xQeG+Lf/l8EJJN73XgwVNtCpw+G8hNjJQ21Iiqgo/haVypTaV9yMF
         H6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713207630; x=1713812430;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ng/r4bNqdlscOI7vt72PnFEgnKMOLlNRsvo7+bpEkVM=;
        b=hrcAb2PcwUI6hblpegQcMmV7R29esZ8baNZmzut+EcYqf70oBvnEyLdFhaUjyfQZdE
         OIL5L6AQNKQGsNgbAl/EUJ6YNisMKBe9AHwJWwqu8e7NudyUawMk4dnfTCV39a2jseE+
         Q6pzGGfvyA/Q93FXR7bOwsc+jMXNd7qUHGs5bXQmuSUdIdCbvo3Y5UQf7p9GfiFoRdAg
         YUxILJ1VQECC1+ScaJ+3cQ7lEU5HJILRCbyRZSdm1iI5GgjTnCczYYbzBGedQimDcSPz
         GbFAJGAPZts/BNxMGzCNfbau86cgl/OwDH9CsNlD372EKeFwXSW1XdHKIf4VFtEVfUTj
         yvFA==
X-Gm-Message-State: AOJu0YxWcsCxvLfeI/5myuo7/z6zZuzz8VaqjQmQOfOIdvYwB3m+kyrH
	sCK9UrgMwlG3Fo1/wPkCq5/N9dXe8NlVLT+6munsGWU93g5350osa7aKkg==
X-Google-Smtp-Source: AGHT+IExtG/bvL/3VzCDa4mxDCm4LumEWAHnaxYS77AK8/b3vLuquk+1ilXReomgnU8z9iCtHJBcUQ==
X-Received: by 2002:a05:600c:4e8a:b0:418:427e:21f0 with SMTP id f10-20020a05600c4e8a00b00418427e21f0mr3222021wmq.8.1713207629594;
        Mon, 15 Apr 2024 12:00:29 -0700 (PDT)
Received: from gmail.com (91.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.91])
        by smtp.gmail.com with ESMTPSA id l9-20020a1c7909000000b004167b0819aasm8611wme.0.2024.04.15.12.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 12:00:29 -0700 (PDT)
Message-ID: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
Date: Mon, 15 Apr 2024 21:00:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
To: Git List <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] add-patch: response to invalid option
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the user introduces an invalid option, we respond with the whole
help text.

Instead of displaying the long help description, display a short error
message indicating the incorrectly introduced option with a note on how
to get the help text.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 add-patch.c                |  5 ++++-
 t/t3701-add-interactive.sh | 10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index a06dd18985..c77902fec5 100644
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
+			err(s, _("Unknown option '%s' (use '?' for help)"),
+			    s->answer.buf);
 		}
 	}
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index bc55255b0a..b38fd5388a 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -61,6 +61,16 @@ test_expect_success 'setup (initial)' '
 	echo more >>file &&
 	echo lines >>file
 '
+
+test_expect_success 'invalid option' '
+	cat >expect <<-EOF &&
+	Unknown option ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
+	EOF
+	test_write_lines W |
+	git -c core.filemode=true add -p 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'status works (initial)' '
 	git add -i </dev/null >output &&
 	grep "+1/-0 *+2/-0 file" output
-- 
2.44.0.782.g480309b2c8


