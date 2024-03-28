Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62619368
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 01:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711588338; cv=none; b=rviBAyAfGI46Kw7crCamkrkjwU6yXxXqW7NuTHyOpQew11xKt5avVETPqQnd2ILRBnt9ROELsjJRUa9gHRR3C15Vp0gnPn7cS5bbfsZxYnxCzzb/e64kDUBreLogUFJJDSTH4NwPJC8ILXZURKjrKMExGPGvXUnlugogZCvBtds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711588338; c=relaxed/simple;
	bh=49xLVaHBT1p9RzGub3cJTTUKO7yvtI+ag8KgD5dUCKM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qwy/4Fq8o/JuHbZ8sHF29g10NuVrnv0wAwZKI1Lb3ElgSZH3PHdCkg/eCQKaXMU6b2zmDhcct6BqPmJEnULv3yqw1nvAf5Cmc32D7UQE+gD2bD0Z+xsz+2w+L6fR4Zq9XD0F4KUg5hInl5YTn1MqP17EzMVObAKmt35hh0BncU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOZZLeGn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOZZLeGn"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-415447b16aaso918585e9.1
        for <git@vger.kernel.org>; Wed, 27 Mar 2024 18:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711588335; x=1712193135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axaV+mUAmhnjy5tq5of6X932rztVvgb1+tK7T1Y/A9s=;
        b=UOZZLeGn/o6KmdoTXv3g/dRBak2VY1ylKFtmabrfWFKPhqWP6R4Td+pG5qhX5biWeE
         g6A5+/LTj+5U6vXMIRNhrtmgagZx4nMUeCW9+Jc0a39EjFU6yCBP12uostJDTxbjWQ08
         SIg7xUj4xSTkpldyX1GjymHEyE67Q19mJmSKXl0nEMT9OgXVsOavvy4OqAcRGtfllC3z
         xfVmh2oxO9s9U7McKnCYdjyudovcNZRO+nwaFW7YOXvy1RnTU42Tq2PXFGnh6g8hg3kM
         trB058H5g65mZyOtnBGlO5btad/akKdMNCEbi/ERkyshluUnydcfkFTL2BHr9Gp07RNI
         PwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711588335; x=1712193135;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axaV+mUAmhnjy5tq5of6X932rztVvgb1+tK7T1Y/A9s=;
        b=XD65w4o/w0z9QfiBAiTlkTpD17aUqG+TnD5MKjdCaFxggYBdCEPiDKa03cDMXRz52i
         c57RnsX2ejUqqGsoOvdsZ7Tf+UHhDVsN6RNBRgq0vWKpPvhvgkwRtH7fnwa4a3a4dFy9
         NiMyEtxot653VNtnsHf0w5cLRnBKn0epyP10Y+kjDpjrZrW3k6NS9MHUTmYCfcUlDCcz
         UYCD/KzmxDlw/0r8CN3rLBqfpvmARvUSGTrEUq5nw0NNsQrakSiO7/HlSTWg7TflQMvx
         KFdwP/7wIiE0vJs8ackzXnAMsSLPjF/Gkplbi1ivfhr+d2vbQHxu9100+BRNvQ0TB+Jj
         /B6A==
X-Gm-Message-State: AOJu0Yw8IG2oIEv2LdaA5/W3C0vIxSbBhFZ293JmH9noEcd7+8fyich5
	vObhDOt+UJYKUIj1W/3dY1pFS2syp2w38zOSOw8miF4iW4WYTYAYRtneVt8+
X-Google-Smtp-Source: AGHT+IGnt31Ij2DnDDNOa6pxNWWXon3Uu7I74wSsxNnegG2SwwHAUwlowV6fBSRurs0M5ZOw6mJazg==
X-Received: by 2002:a05:600c:15d2:b0:413:e81a:55c0 with SMTP id v18-20020a05600c15d200b00413e81a55c0mr1157058wmf.41.1711588334769;
        Wed, 27 Mar 2024 18:12:14 -0700 (PDT)
Received: from gmail.com (200.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.200])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b0041469869d11sm3648867wmq.47.2024.03.27.18.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 18:12:14 -0700 (PDT)
Message-ID: <60c43160-1b60-42f6-9488-4cc332201b7e@gmail.com>
Date: Thu, 28 Mar 2024 02:12:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 2/2] add-patch: do not print hunks repeatedly
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <60d978d0-f69a-4b65-b4ba-d30dac8f112a@gmail.com>
In-Reply-To: <60d978d0-f69a-4b65-b4ba-d30dac8f112a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The interactive-patch is a sequential process where, on each step, we
print one hunk from a patch and then ask the user how to proceed.

There is a possibility of repeating a step, for example if the user
enters a non-applicable option, i.e: "s"

    $ git add -p
    diff --git a/add-patch.c b/add-patch.c
    index 52be1ddb15..8fb75e82e2 100644
    --- a/add-patch.c
    +++ b/add-patch.c
    @@ -1394,7 +1394,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
     static int patch_update_file(struct add_p_state *s,
     			     struct file_diff *file_diff)
     {
    -	size_t hunk_index = 0;
    +	size_t hunk_index = 0, prev_hunk_index = -1;
     	ssize_t i, undecided_previous, undecided_next;
     	struct hunk *hunk;
     	char ch;
    (1/4) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? s
    Sorry, cannot split this hunk
    @@ -1394,7 +1394,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
     static int patch_update_file(struct add_p_state *s,
     			     struct file_diff *file_diff)
     {
    -	size_t hunk_index = 0;
    +	size_t hunk_index = 0, prev_hunk_index = -1;
     	ssize_t i, undecided_previous, undecided_next;
     	struct hunk *hunk;
     	char ch;
    (1/4) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?

... or an invalid option, i.e: "U"

    $ git add -p
    diff --git a/add-patch.c b/add-patch.c
    index 52be1ddb15..8fb75e82e2 100644
    --- a/add-patch.c
    +++ b/add-patch.c
    @@ -1394,7 +1394,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
     static int patch_update_file(struct add_p_state *s,
     			     struct file_diff *file_diff)
     {
    -	size_t hunk_index = 0;
    +	size_t hunk_index = 0, prev_hunk_index = -1;
     	ssize_t i, undecided_previous, undecided_next;
     	struct hunk *hunk;
     	char ch;
    (1/4) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? U
    y - stage this hunk
    n - do not stage this hunk
    q - quit; do not stage this hunk or any of the remaining ones
    a - stage this hunk and all later hunks in the file
    d - do not stage this hunk or any of the later hunks in the file
    j - leave this hunk undecided, see next undecided hunk
    J - leave this hunk undecided, see next hunk
    g - select a hunk to go to
    / - search for a hunk matching the given regex
    e - manually edit the current hunk
    p - print again the current hunk
    ? - print help
    @@ -1394,7 +1394,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
     static int patch_update_file(struct add_p_state *s,
     			     struct file_diff *file_diff)
     {
    -	size_t hunk_index = 0;
    +	size_t hunk_index = 0, prev_hunk_index = -1;
     	ssize_t i, undecided_previous, undecided_next;
     	struct hunk *hunk;
     	char ch;
    (1/4) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?

Printing the chunk again followed by the question can be confusing as
the user has to pay special attention to notice that the same chunk is
being reconsidered.

It can also be problematic if the chunk is longer than one screen height
because the result of the previous iteration is lost off the screen (the
help guide in the previous example).

To avoid such problems, stop printing the chunk if the iteration does
not advance to a different chunk.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 add-patch.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 922c43378e..e0f4cd9b9b 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1395,7 +1395,7 @@ static int patch_update_file(struct add_p_state *s,
 			     struct file_diff *file_diff)
 {
 	size_t hunk_index = 0;
-	ssize_t i, undecided_previous, undecided_next;
+	ssize_t i, undecided_previous, undecided_next, rendered_hunk_index = -1;
 	struct hunk *hunk;
 	char ch;
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -1448,10 +1448,15 @@ static int patch_update_file(struct add_p_state *s,
 
 		strbuf_reset(&s->buf);
 		if (file_diff->hunk_nr) {
-			render_hunk(s, hunk, 0, colored, &s->buf);
-			fputs(s->buf.buf, stdout);
+			if (rendered_hunk_index != hunk_index) {
+				render_hunk(s, hunk, 0, colored, &s->buf);
+				fputs(s->buf.buf, stdout);
+
+				rendered_hunk_index = hunk_index;
+			}
 
 			strbuf_reset(&s->buf);
+
 			if (undecided_previous >= 0) {
 				permitted |= ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK;
 				strbuf_addstr(&s->buf, ",k");
@@ -1649,10 +1654,12 @@ static int patch_update_file(struct add_p_state *s,
 			if (!(permitted & ALLOW_SPLIT))
 				err(s, _("Sorry, cannot split this hunk"));
 			else if (!split_hunk(s, file_diff,
-					     hunk - file_diff->hunk))
+					     hunk - file_diff->hunk)) {
 				color_fprintf_ln(stdout, s->s.header_color,
 						 _("Split into %d hunks."),
 						 (int)splittable_into);
+				rendered_hunk_index = -1;
+			}
 		} else if (s->answer.buf[0] == 'e') {
 			if (!(permitted & ALLOW_EDIT))
 				err(s, _("Sorry, cannot edit this hunk"));
@@ -1661,7 +1668,7 @@ static int patch_update_file(struct add_p_state *s,
 				goto soft_increment;
 			}
 		} else if (s->answer.buf[0] == 'p') {
-			/* nothing special is needed */
+			rendered_hunk_index = -1;
 		} else {
 			const char *p = _(help_patch_remainder), *eol = p;
 
-- 
2.44.0.370.gd7ad5e5424
