Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587ED623
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 00:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133309; cv=none; b=I1DHd/iNLPNaaITooR862Hrc2XfPBye780bi8h4OJ4osGTgVQQh2ekH5QCzBn3892WJF749HUMzceGd71PNDfWBLi6kDUmWQIdn4c2UjO482K7OdC2eHa6Z+st+WY00wKPZTwOruhO8SUucIV44oxp9+YMc06Q9WL/ClTpjemR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133309; c=relaxed/simple;
	bh=zzC/0NtNXO/xJEdLNnUD7GrcFDmSQfH0mWHyPjCbryQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ezh3nQW1p5xBFuJIuOXNabgDiLKcC621BFpDfKZP/Cy9vcBodPcT+PNCyUne/Ua6V71aFaD8N42QoC9F3ZvuazBHOtmdd75ds24AHNwaezyssyiISQlct89O2UzJvVdBQOOdemqs4DigQnv6NHHisf7nyvbnuwWZLrDlEqcuUak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org; spf=pass smtp.mailfrom=mandelberg.org; dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=cDcS3MO6; dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=kyXTO48W; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="cDcS3MO6";
	dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="kyXTO48W"
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-6e895f3365aso47377896d6.0
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 16:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741133307; x=1741738107;
        h=content-transfer-encoding:message-id:references:in-reply-to:subject
         :cc:to:from:date:mime-version:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YF3p4JpKe0GgTVk6uxY4SFKTckJfEeugqPF2Cxo0Ccg=;
        b=ng3e2Up5Hor2IxWimXxOa38XeoZ12MSHMg4PQtemUxGsjV0YArUp6C7cpm3eh7Pja2
         hdTPqYdHsOwedf7HaESF1a6ABL4ssj9/cjVl/4H4KzN5tOaDr6ZeSe2DAUGf8askvOnL
         6BFWdJIsDMLCoJ6DXewbW81dWCEKNmSSj9m0a0CufRqhd+zW/PT8DQXffQ7eO1ZysfDQ
         N+y8QCClXev0SmSXluglLOONeDug2BIlSTFH0f8MTr8IWU4HM7krXz552xQiz+JjeoEb
         Q9n0m4LzQr383IrZn9RfNhBboaCemoknyMMHzpb1lEauI3ju9uN2IfpKFGZdVYhr+5rL
         ImHQ==
X-Gm-Message-State: AOJu0YxEJStZmc7uHwE3QJmGUliKXisoB6uB5u6SG81wAtB+MwgQqQEe
	VeGu36aseFGRyWFMPi6NENMNB8k++0QJpyYauDFFbFR8ZKMEW1uh1eQ3bYWsjFBHbARxLDwEJQu
	O0rIH+fOzrZk4AhANjirPDojRPdPm0Hc+yVuVeKX5ABGcShFA
X-Gm-Gg: ASbGnctQY39QBGQydcQqo+jZPpJNBLeHbl3gmNFt2a7eo98zjGgFfnyH24nwuxrAjwE
	Q6gn3k1gvp0N7//vKH+d0NMrQhPOuCb4/lJxE1TGWZimiziY/1T0EozSZKT5z4BXbdGniY83WM7
	/n1/HACz5wwx2HRmyVibMOn+VECyuocD5T15Cm6Je2uh0hRpt7vb4hGR9HZCYYjnyKgbI0HthCo
	DXQ+trkMLIgo8YfgbeEmGEjvIu4qZQ33gBimqmR8rrlD07XQ8AywHgJKoO3PNaEz3UyVF9jHhTe
	9oIdDPMUwr+Nqxn0wFJsXt1rsPqM2xL/n9T/Krwe
X-Google-Smtp-Source: AGHT+IF7kcg3Ggf99AFNY0aYYEJj2cy8LCJ2lt+Xo7XIlDDBl3b/PpD0XyCcfGyZYqh/OaGsWPBkGLWlacqR
X-Received: by 2002:a05:6214:20e3:b0:6e6:6713:3ea8 with SMTP id 6a1803df08f44-6e8e6d3bad9mr18322966d6.23.1741133306397;
        Tue, 04 Mar 2025 16:08:26 -0800 (PST)
Received: from mail-outbound-e14cf917.virgo.mandelberg.org ([2600:4040:52f1:f606::8])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6e897604364sm5575886d6.27.2025.03.04.16.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 16:08:26 -0800 (PST)
X-Relaying-Domain: mandelberg.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=mandelberg.org; i=@mandelberg.org; q=dns/txt;
 s=mail-outbound-e14cf917-597d7abb; t=1741133305; h=mime-version : date
 : from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding : from;
 bh=zzC/0NtNXO/xJEdLNnUD7GrcFDmSQfH0mWHyPjCbryQ=;
 b=cDcS3MO6Ulxn5GAIVsz7IGIp0bxuk4CBEmYoCTxx5HDaz7OWXPiDomieG2fE4z0miP+VI
 ZTpysPuVapwJkxSDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
 i=@mandelberg.org; q=dns/txt; s=mail-outbound-e14cf917-e56dad1c;
 t=1741133305; h=mime-version : date : from : to : cc : subject :
 in-reply-to : references : message-id : content-type :
 content-transfer-encoding : from;
 bh=zzC/0NtNXO/xJEdLNnUD7GrcFDmSQfH0mWHyPjCbryQ=;
 b=kyXTO48WHFAA7Hs1TRStNW5cMaccHMIv6Ak24hxyZcCEJ3AdHZJLcP23tuLQwxABxhGOi
 HyAAujCluyw04QHGRuuJ0YDutCPIErLCWAfRpmHHxlUMKGkaAy9p9GHAaY8tgORcv6ssIBc
 YSqQ8k68aEBNfRQ4HIiox9Tg4zbqZ8bAgsk4dEGp/bRdwlRnzh2O0YvTfwPEu2G3nDETmJW
 y2LKTpHuTvlP923kLFucjO0aym/o+TUscC2zdofmSE2hGfBeqknbopkIV4mIXiSE2peBygC
 aUvUoKhYCxNbr9kQPHizoV+4whnxTHKUL/WIE6avvZxgjsAKx5kTqZptkjoQ==
Received: from webmail.mandelberg.org (mail-web-d031b246.virgo.mandelberg.org [10.0.6.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X448 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail-outbound-e14cf917.virgo.mandelberg.org (Postfix) with ESMTPSA id 4Z6tDn61Z4zySw;
	Wed,  5 Mar 2025 00:08:25 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 04 Mar 2025 19:08:25 -0500
From: David Mandelberg <david@mandelberg.org>
To: David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>, Junio C
 Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] completion: add helper to count path components
In-Reply-To: <d5860dbe1e6a149d72739af3271369b3@mandelberg.org>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <d5860dbe1e6a149d72739af3271369b3@mandelberg.org>
Message-ID: <416a3f1afbacb75ea2e24de29fab8f3a@mandelberg.org>
X-Sender: david@mandelberg.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

A follow-up commit will use this with for-each-ref to strip the right
number of path components from refnames.

Signed-off-by: David Mandelberg <david@mandelberg.org>
---
 contrib/completion/git-completion.bash | 11 +++++++++++
 t/t9902-completion.sh                  | 26 ++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 413911be3b..5fdc71208e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -234,6 +234,17 @@ __git_dequote ()
 	done
 }
 
+# Prints the number of slash-separated components in a path.
+# 1: Path to count components of.
+__git_count_path_components ()
+{
+	local path="$1"
+	local relative="${path#/}"
+	relative="${relative%/}"
+	local slashes="/${relative//[^\/]}"
+	echo "${#slashes}"
+}
+
 # The following function is based on code from:
 #
 #   bash_completion - programmable completion functions for bash 3.2+
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 51bd750837..015289c776 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -455,6 +455,32 @@ test_expect_success '__git_dequote - open double quote' '
 '
 
 
+test_expect_success '__git_count_path_components - no slashes' '
+	echo 1 >expected &&
+	__git_count_path_components a >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_count_path_components - relative' '
+	echo 3 >expected &&
+	__git_count_path_components a/b/c >"$actual" &&
+	test_cmp expected "$actual"
+
+'
+
+test_expect_success '__git_count_path_components - absolute' '
+	echo 3 >expected &&
+	__git_count_path_components /a/b/c >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_count_path_components - trailing slash' '
+	echo 3 >expected &&
+	__git_count_path_components a/b/c/ >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+
 test_expect_success '__gitcomp_direct - puts everything into COMPREPLY as-is' '
 	sed -e "s/Z$//g" >expected <<-EOF &&
 	with-trailing-space Z
-- 
2.47.2
