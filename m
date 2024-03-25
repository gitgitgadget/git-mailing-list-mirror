Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F785D738
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400839; cv=none; b=sNQUKMmOgO7Vsn/2iQk4VeA2o3i/GQf5UlAoIK3UosWkxlMPcumOWUCCjdmqhkVjAojpnC/AFOOg3j7jR7oOJSmkeQXGIZreOu9+pDGVEMZOeilr9CJk7tgtwmpMzSuhNonnOomCRfcyFzGD6o2pigYeSrE71WTNwrNrCOLQCqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400839; c=relaxed/simple;
	bh=KzTLtdSmRuQdDYk1VPpb1OSum8KnKD8Hpv3KoOliLl8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XxI3/tQIVawLXcV6kAHUwIUwWbnv0yufIWzC8Ckm9aqn9fhRdKRO+/2BUBnhxhe4+6mxeVjmM6tlDbyztPX+KfOP3PVTl5CmvLRYqXq3Ioxic8VX4Aufmuk7dlbKsvZ70zEhICKm5MXpyQNWeAadupvCceBzFc6Vk/zMUhFL9iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHZD4Bet; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHZD4Bet"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3417a3151c4so4349384f8f.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 14:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711400836; x=1712005636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lqJjslAhPaMF+BRSYRQGP4XFuk3RFzs7fqr7JmsSd60=;
        b=MHZD4Betwht3B4urb2gZOVN7pT1X3D7nvxY0+vQnaYzWfB3OfZ89blk1jx9nIsCoJg
         GQUutleIH59C8/e0ZhYsd0Feo4pr2PJeC9+FaXH9q+CslBeLVvICyws9+xHn1uj7gDhC
         L+YOPgJMVTyUAHkrNmwhMOiNa7wsHdhUC9aNIAMp7+xz2CCg7T59/rRHcF7P3Tz/hjs1
         sseBt1qcii0qCwoj6RgkjyDOp8Rh9CmsBBoOS3x+ogl/Ovx9EUBToFokjBg41WYDDVdU
         7A1WpeSIzLZr5ydUdjDAFSHdt+M5ZrJnmHR6wp0LN1mgxPCPIDOH3Zc2jIi/HclnhuxY
         boFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711400836; x=1712005636;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lqJjslAhPaMF+BRSYRQGP4XFuk3RFzs7fqr7JmsSd60=;
        b=rLdabR5FzkTbCo/zvrRc2RB0BOWeT7IsTy9DxY5JzHoMGrRv55D8ej/iVgy77Tkd1G
         NvGHdhXMzv+l0ABTq7zHtQkWNLf9aiX4juPFTCpRu/2tL2ekgzrQVeaPq0r+aRm4spUj
         pTQ+HTsxVXTZo8YOdCd0Wf6QRele4cpEUAQwq1fBOjlBXV9wUcmAUqCfj77AM8LVDk67
         oiDBnVSTMBfZfWvu1wcvhjGYf7bPXLKHxb9XpoAq6p5pY/eYBYluI2Guy+zlEoEW+lFl
         5qBhhOmm01QsewRYS9RTnAbb16U9d7q/It3bGJAaIj6jOZGfX+LU3sTneeRYVZ6EefXd
         vmfw==
X-Gm-Message-State: AOJu0YxQI5EpudCJAnLhxgPFLp8IDRPAM85zIS9gK/6QovNvXEBdcnkZ
	bqx/MJaAjdf7L1sUT7xcIhDTznLEJHp6hXN792SfU9WMgaVe8IvLybX6Jl32
X-Google-Smtp-Source: AGHT+IF5pBhIXtLfQaK6MGKXOitONwtGtd1daOMdd/fdrPFzesZlpIVNIKrHXaT4EzM3t+RAeiv5nQ==
X-Received: by 2002:adf:c805:0:b0:33e:7f51:c2fb with SMTP id d5-20020adfc805000000b0033e7f51c2fbmr7294339wrh.41.1711400835475;
        Mon, 25 Mar 2024 14:07:15 -0700 (PDT)
Received: from gmail.com (70.red-88-14-202.dynamicip.rima-tde.net. [88.14.202.70])
        by smtp.gmail.com with ESMTPSA id cr8-20020a05600004e800b0033e7715bafasm10407135wrb.59.2024.03.25.14.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 14:07:15 -0700 (PDT)
Message-ID: <6bc655ea-783e-477e-84ec-04503fa20799@gmail.com>
Date: Mon, 25 Mar 2024 22:07:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] add-patch: do not print hunks repeatedly
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
Content-Language: en-US
In-Reply-To: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
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
 add-patch.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 52be1ddb15..54a7d9c01f 100644
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
@@ -1448,10 +1448,14 @@ static int patch_update_file(struct add_p_state *s,
 
 		strbuf_reset(&s->buf);
 		if (file_diff->hunk_nr) {
-			render_hunk(s, hunk, 0, colored, &s->buf);
-			fputs(s->buf.buf, stdout);
+			if (prev_hunk_index != hunk_index) {
+				render_hunk(s, hunk, 0, colored, &s->buf);
+				fputs(s->buf.buf, stdout);
+				strbuf_reset(&s->buf);
+
+				prev_hunk_index = hunk_index;
+			}
 
-			strbuf_reset(&s->buf);
 			if (undecided_previous >= 0) {
 				permitted |= ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK;
 				strbuf_addstr(&s->buf, ",k");
@@ -1649,10 +1653,12 @@ static int patch_update_file(struct add_p_state *s,
 			if (!(permitted & ALLOW_SPLIT))
 				err(s, _("Sorry, cannot split this hunk"));
 			else if (!split_hunk(s, file_diff,
-					     hunk - file_diff->hunk))
+					     hunk - file_diff->hunk)) {
 				color_fprintf_ln(stdout, s->s.header_color,
 						 _("Split into %d hunks."),
 						 (int)splittable_into);
+				prev_hunk_index = -1;
+			}
 		} else if (s->answer.buf[0] == 'e') {
 			if (!(permitted & ALLOW_EDIT))
 				err(s, _("Sorry, cannot edit this hunk"));
@@ -1661,7 +1667,7 @@ static int patch_update_file(struct add_p_state *s,
 				goto soft_increment;
 			}
 		} else if (s->answer.buf[0] == 'p') {
-			/* nothing to do */
+			prev_hunk_index = -1;
 		} else {
 			const char *p = _(help_patch_remainder), *eol = p;
 
-- 
2.44.0.494.gf640f9da83
