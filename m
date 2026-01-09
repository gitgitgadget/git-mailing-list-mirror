Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C84369215
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989141; cv=none; b=XMKO24eX+QoD2rnSUucF0OM0LsnQIGaiMNfzqSDpiJZfosHyOeFaXixj/B1iDn+HRl6JDgrCT57DLBI2rWoC15vLs6hPk+v+QtOnsFtr4u3TY93JXcqOy8S7l+vY8Ntsir5RR0MkBAgkPxxd7HaIASB9fZAFx5NNttyrvIG9/4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989141; c=relaxed/simple;
	bh=cKTXp0SrXJQ9WOjYDcEh67jAjQsIOV6T27iLaoQ/Ck8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WBk2V7QwWEXSv6TzwMZpf4vD871XU+eLI1OQDJdESXtE+ESvu9Be5waZbY/ZD4v60nXAzJd1RNOxt0rsvVkuzqhNlzyYCrVRZAFPGajCVCZwo6EbadjzbGu3rHss6dJ/ijIFCJydP/1aaOznGgl17EOFuaNg2RyiJag8/l+VjeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPm+ySqw; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPm+ySqw"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ed7024c8c5so37513921cf.3
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989139; x=1768593939; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adrefF8P70lTBaRyE8kZyEeY0BGf9IE9oBZsX9KoAeg=;
        b=HPm+ySqwdDzLNY6lv2GX4+NozvNTJA4O3dfYFH9xS1oGGF5Z13bFGT9LOm9sYycY57
         RT+lh4cUnviMubIrOZozJQWSdxhNrpifWPzXOfHEf/X0+rr0TxDN8HPQJCMmCxR2zzj2
         mkkcE28u/V3LxqbDpQBsLUInt6R7xPuMCcM0q9FxG207elOVdzinMp1nAGHqpK9zBuio
         GZv0LnqyO6iRyb4nk0Y2ucNkK26WdrRallJzggwX27Tl43Q7OKz0t2c2BGRcnkuqtUtO
         HQzMhADO+b+3FbI9+z1/TwFMQ5HcBA5Y42J5qd7cs7OLc21SWdb4VqHVDNfrRmWElCSa
         asdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989139; x=1768593939;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=adrefF8P70lTBaRyE8kZyEeY0BGf9IE9oBZsX9KoAeg=;
        b=Q6gwJLC5BwAMpcj5GxXF1ycwsTvDeA8fw4qc2cfoKhk+As0cLcRYaR77Xe09rfWEHo
         NO48eMyhOiI5GALmytmvcrcNwESjWLL1+Y1RHxxj35HzpR2ZowVFfYnjivJsosEEgjZt
         yZYwd5HTtOBetVdVE2KTn8E4nW8yiwreJ9jRVkABXWMzPgrCRkQUB539bcWf3kZg2tMt
         PE/nlb9j8hh+NuwXed2CSMgTKXIOHmYgUeFyg6HioRsJjsqtJ+OQ00r4LoZO5O9KZ1xO
         dlh2xT3kWAXEPpywROtRboJigrWiXEL2icd53wsBfB8TShGpu87T7HnGMMHuVrGQnsaC
         rW9Q==
X-Gm-Message-State: AOJu0Yw5jWaoCQ/L4S5gQPYkDIhW6BuUgfuulKZkbONEOdiBcLaLXzaP
	HdsXKABk97tRsmK50pgK+hdSskRYfy/YlBF7cP1fiFf3AO1Mnh/hCSXyjRsCRV7X
X-Gm-Gg: AY/fxX403o5sa+BWc4i3l94lkmaTy7P+NMD1T7BomU1Mqu0u609+W8MttjXT/xbSjmw
	FcWUHoU30cy6cbqILVhxIjcYJbR1vRLZggYLmBP3LLBuxDCnYn0TmdXVk2KF30sKuYbOMnqeYqd
	lC90dZSp75OsbBCa9uAGpINBwL5Zv32AL9c14SONH3/VpDTdMl+EAdbOMc5WQeRBRZLfXFPsES0
	52D4DBRJWMn3gl3tl8goHLtSnztKkRjfoE6Dv6fcud8mSrDuV9wZ3JLgnK/vqMdzTq9IB4idgOK
	4kx4aZCG1wapzZrhf4gO+oW92tDu/+EMrXnwRe7aelnST/mZDNiw8g3uAxxoG6qGNjsPwMcZ42o
	4TEt8Ld93Frct1vRK4R4kIPG/nWJE1TSegrie0laXYgyLxe6jxzIItWSoGR4yGfDyaZ4P6Ddu73
	NwC4vD1/8i2GcR
X-Google-Smtp-Source: AGHT+IFIBxCamWyC0lxhowQAo/SBYrUyTxKi74VHpJyo1bimtbta0e5EfqJqMyhG+PF6dJzp9KHelQ==
X-Received: by 2002:ac8:5f0a:0:b0:4e8:af8a:f951 with SMTP id d75a77b69052e-4ffb4aed9ffmr150638251cf.83.1767989138617;
        Fri, 09 Jan 2026 12:05:38 -0800 (PST)
Received: from [127.0.0.1] ([20.161.67.219])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e4bf3dsm79249981cf.23.2026.01.09.12.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:38 -0800 (PST)
Message-Id: <afcf2bbfcb83c542ff8e6d6d2ceef15d16e25be7.1767989115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
	<pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:15 +0000
Subject: [PATCH v2 18/18] mingw: special-case index entries for symlinks with
 buggy size
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Karsten Blees <karsten.blees@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In https://github.com/git-for-windows/git/pull/2637, we fixed a bug
where symbolic links' target path sizes were recorded incorrectly in the
index. The downside of this fix was that every user with tracked
symbolic links in their checkouts would see them as modified in `git
status`, but not in `git diff`, and only a `git add <path>` (or `git add
-u`) would "fix" this.

Let's do better than that: we can detect that situation and simply
pretend that a symbolic link with a known bad size (or a size that just
happens to be that bad size, a _very_ unlikely scenario because it would
overflow our buffers due to the trailing NUL byte) means that it needs
to be re-checked as if we had just checked it out.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 read-cache.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 990d4ead0d..260f4b3b2f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -470,6 +470,17 @@ int ie_modified(struct index_state *istate,
 	 * then we know it is.
 	 */
 	if ((changed & DATA_CHANGED) &&
+#ifdef GIT_WINDOWS_NATIVE
+	    /*
+	     * Work around Git for Windows v2.27.0 fixing a bug where symlinks'
+	     * target path lengths were not read at all, and instead recorded
+	     * as 4096: now, all symlinks would appear as modified.
+	     *
+	     * So let's just special-case symlinks with a target path length
+	     * (i.e. `sd_size`) of 4096 and force them to be re-checked.
+	     */
+	    (!S_ISLNK(st->st_mode) || ce->ce_stat_data.sd_size != MAX_PATH) &&
+#endif
 	    (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size != 0))
 		return changed;
 
-- 
gitgitgadget
