Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C710033D6FF
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 23:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771026927; cv=none; b=nLZJtp3KbkGg9kJ83AvrCNe1xlkw1CqNBxSfnt3VuEyiSCTnJ8k5dqgEKYtmQB9l2C3LWafZ4WALgE40qd2g0Pr4+R8cnoon1YlDey64Xt/eOax+DDCpSh15x4XnGSnHu6Vz36W3gpIVFlgVN+tfGtLYYAn6f+EtHkANtseW3e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771026927; c=relaxed/simple;
	bh=CqBvUoM8zzSuKjX2crZcdeylwoUipDpRPikEM2l+dVk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Xw58xz/mBpp6ZKpRKi60PUcwGZuY4eCBpQhsoljObzJL1GOwq+pmbREucoM4TdwYSJEBEKPRFKTsgeryVTCAsTlsrRw7dYOu8xGyWSvirRUDJrbe0TZQASl44Z7UtzscScIxATJkthz43r+Kd5Nlm3hgngBagNnAp0weMFDkxg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuuEvnQK; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuuEvnQK"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8947e6ffd30so17414836d6.0
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 15:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771026924; x=1771631724; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nIIxfVDb8fnoQ9Q5yLB8uLmtZi4JaOXiiKTTdkLSng=;
        b=UuuEvnQKnF7z4a4XQRPtE88Vtyw8j7wKzbLqIpVnoRCGPnSHMzA7Dk2EAoWdIFOKd1
         7f+9F3sZ2LOnkGwc2jca5g5ovF6FenG61QTWmflkLnVp14sMSgRmzXEQXZg5YurcLCo0
         crA0z24IXCOxpiKKDF5nz5W5CXUKDu2kgvio1m4QZ+ZLv/YN9RDs655AhcR3jyZof69s
         sEQpUq49LhcRfqCZq2TP/14XoiHodsMdgPuofbBKEdoADVk9rrPr3IfmXjM0dm4CYluI
         lt6LJE//Du8DWVBB/TGifU0pfX2fE+h5lyItZ5NUO/wDJMkoALDQqeFkflWjlqdTCKqU
         T8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771026924; x=1771631724;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7nIIxfVDb8fnoQ9Q5yLB8uLmtZi4JaOXiiKTTdkLSng=;
        b=hGyYMf1GfAXF93EzidUxFN1VRS0jaJt65cP3i+hLZuUlkzNbSi6kOwO1TRc3aEH3lZ
         GwNXmxzCejAhailGdvZxUQdjERI08eT9gCwG0zumCfgVAXwWn3WmzuWq8KalCM0cvb+m
         /HaeazefzKmj6o+JDVcP9+66T3kxjIvp9wgcxeiaDR0OKnDETSSvaRfLUKHuWtXHjtXS
         04FnKqBGxBdNw6DB+IvlVHTE9AdgiqKNMdrbVvR1E6pY8fUSLqZPBERmvvWKqNwunr5Y
         QJkq8RNRAmk1SvkSOpkt6ovOo22HAovniWajjIJy9xbFemZatC8Bs8ZDGEOUHldtFipE
         36zw==
X-Gm-Message-State: AOJu0YxSMDIhsSU2GhnbRruTmz3ZrTbNcor5wiysl1OPsujGxqt/3ROs
	Zw27JD1zC8tSPv12oAGiFa+gXlv6pxmzufxeJUAkdbZM2ARmcHpsmMcd8rlNmZEk
X-Gm-Gg: AZuq6aJubuFLBFsNU+ix6kHMMFrQL3S8VpErIZ+qrYo5WP5h6GNIbcZ1PTJQbcMuMT3
	XreO4N6Jz5IsZo3c8cC41x8IKSuj7ZReggD9Xa09Ke6ieu+ZV0GVxZwBCuhqFA/bSmP2bZThSox
	cPOtnbWYe5YkSfodUl68NmUgVkckHnONyJMXVkLsjlLNvka6bx5X5iaX9Tx/dz8tLi+Ua9DYhcJ
	WNSKxaCIBRJgMnEHK2ZrH6RlNSliwXLT1gUS/0cIah4b8c9IivCkp2pREjUgdlwzDtk4Gye18v4
	agj01jPbi2h/Ws8ly1Gxz25xyTSTbGUcdRXH/bB//Xs+vAeCNcSLIVwHSlE8fPoREJGAlIuS2eR
	v1emHUDWpzif/vmrWIW4FicRJSqIHmT/48QhkntPfUZ2qkQHy3L3lHQuNmGE4vjnPiOSuWWtG46
	GvBmhep9o+CxXmG39mISGPtgyT
X-Received: by 2002:a05:6214:d44:b0:894:7005:ed8e with SMTP id 6a1803df08f44-897404ec21dmr17856726d6.64.1771026924341;
        Fri, 13 Feb 2026 15:55:24 -0800 (PST)
Received: from [127.0.0.1] ([145.132.99.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc957c8sm79683646d6.15.2026.02.13.15.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 15:55:23 -0800 (PST)
Message-Id: <93c94a1b257d26a23942e902630c220e4a4f8eaf.1771026918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
	<pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 23:55:07 +0000
Subject: [PATCH v2 02/13] config: add 'gently' parameter to format_config()
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
Cc: gitster@pobox.com,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This parameter is set to 0 for all current callers and is UNUSED.
However, we will start using this option in future changes and in a
critical change that requires gentle parsing (not using die()) to try
parsing all values in a list.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 237f7a934d..b4c4228311 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -242,10 +242,14 @@ struct strbuf_list {
  * append it into strbuf `buf`.  Returns a negative value on failure,
  * 0 on success, 1 on a missing optional value (i.e., telling the
  * caller to pretend that <key_,value_> did not exist).
+ *
+ * Note: 'gently' is currently ignored, but will be implemented in
+ * a future change.
  */
 static int format_config(const struct config_display_options *opts,
 			 struct strbuf *buf, const char *key_,
-			 const char *value_, const struct key_value_info *kvi)
+			 const char *value_, const struct key_value_info *kvi,
+			 int gently UNUSED)
 {
 	if (opts->show_scope)
 		show_config_scope(opts, kvi, buf);
@@ -372,7 +376,7 @@ static int collect_config(const char *key_, const char *value_,
 	strbuf_init(&values->items[values->nr], 0);
 
 	status = format_config(data->display_opts, &values->items[values->nr++],
-			       key_, value_, kvi);
+			       key_, value_, kvi, 0);
 	if (status < 0)
 		return status;
 	if (status) {
@@ -463,7 +467,7 @@ static int get_value(const struct config_location_options *opts,
 		strbuf_init(item, 0);
 
 		status = format_config(display_opts, item, key_,
-				       display_opts->default_value, &kvi);
+				       display_opts->default_value, &kvi, 0);
 		if (status < 0)
 			die(_("failed to format default config value: %s"),
 			    display_opts->default_value);
@@ -743,7 +747,7 @@ static int get_urlmatch(const struct config_location_options *opts,
 
 		status = format_config(&display_opts, &buf, item->string,
 				       matched->value_is_null ? NULL : matched->value.buf,
-				       &matched->kvi);
+				       &matched->kvi, 0);
 		if (!status)
 			fwrite(buf.buf, 1, buf.len, stdout);
 		strbuf_release(&buf);
-- 
gitgitgadget

