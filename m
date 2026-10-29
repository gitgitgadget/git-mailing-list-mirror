Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793315807;
	b=yuvP/dbums+eall0LySQgPevxaLYz1bFRWrsb2rJ+LouiY/dQT/sn9D9ZXZHUI/WCM1W
	 QVUshoTsI5tgb6kW1Cy1RY+TRynn3OVihFuseAY61kbtUbCtCg6Z8m45rrfFTp4gEjX2a
	 LaEyY/PyNdtP6DYI1D+Il/N7YrXA5qtyX6APuWO3y5Lr6pXyXyo+3dLkYuoUXQ7LX5tLz
	 VSxjJfNC/iB8paF+SvXDKzFaAiCGLCqZA3zjfQbk/y0JZ0bl5ojkGNNTGlH37+hLPpHqL
	 5jnn0p2bR0zoMFEOCSGXxIFsXsrP+dmeXCxtrVeop4gxRPsaT9fTFuubBkIHetcOSIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793315807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=U3Mk1KIA3nQYDm4eQQzRm+5jQNU9lwPSfK14X4pqIiw=;
	b=ktpoP7nf+q693KHTG0iWicJ5OS98w2SQR4r17MuYC0rEARq+d5rjtciVj0+YB8mWjUWs
	 7xLe0sP8wwUBzFNdBWTBAz2MWeT9UD4/kol/GYBgfGy/PBGZhKlyI4/gr8vxVMhQHFOlC
	 2X9Ctn3jh5Xdh27WEljqDQEuipyb7BJkeFzM1YrdIFfjRVsSRthGLRMNpi53C25LPGekd
	 YBt48yHeNyUQBbT9R+5ZZyC8lMs6LeA8U6y5L+DK2thmpx5dYlAjPJQLEgmuxpwQl7GuP
	 +OjhK5mrbvox9jPW6zkzc+rUF6KZ3IMz4p+z1aQSPN/JrihI4kHoOVhxm1eeGAHJwTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DUVT1MEh;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA488606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 23:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA488606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DUVT1MEh
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48c45111bebso56068f8f.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 16:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793315805; x=1793920605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U3Mk1KIA3nQYDm4eQQzRm+5jQNU9lwPSfK14X4pqIiw=;
        b=DUVT1MEhLA0fpCkzYnu8jgaIVqb7h0yEIh4nIMvjZowpPWTcObUq2x0HpLMVWxfW4B
         q7xo5/TF4FwOaz3pgMji3Yru6q+kVJzqyNtKu871WF2aiYakpMdovVWKuyq1g6IERZZP
         Va0NM92a2t5HYHfwtjOCuKHI+d0msqehKpaHFUHCNhrCRM6C2ViPfcSGX5A/DNqREoeu
         m1HujH4sUU5zO5GWuHVQ0JCVZtQCXgDZul7gbbdPgRneHYDpxXlicSQDJ4/c0HYCY3G4
         LzMmpFiIFW1mryauefLC3o5KAoZYpYBM2q+MiaQPmKcTjkCBPv3G9o3/q7XLO8J7ETOx
         HHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793315805; x=1793920605;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U3Mk1KIA3nQYDm4eQQzRm+5jQNU9lwPSfK14X4pqIiw=;
        b=k5rUlfBGLsSe++HGkQz26bs7z5sACZeZ5ALdMvlPxwnmXwNvYqe9cdtHlxce7BoHUE
         yzsfPaKpqHndcJsdLE8+jPJp8dc1+HR3Cna5NXVAtN01+Gmn/iaJ3y4SZQyrjjp4tBsQ
         EbpTthc+1TQJvQNZSq4IygL+0/0ueLCYTH+qcaA6h3SAk4jrG5wNT4n2FqWtM0z9wNru
         6hmPZC+xw7sIyyw/uZhQcQnikwN/vMs3OepnGOH44lpZGg39O4zOSpnJdkFoGvZW5h1b
         bcqQFLmyEmOnE3DqkTBRp7DghRZ19DcAVyuJum0/oRzJzpG6vWOu5hw5ftWxkplgaaEF
         o9yQ==
X-Gm-Message-State: AFq9FYK8iq55qGUN6C3LfizpmqbFApR3/HxoWFAIZFowBYpxM/M9qKPF
	efX8C9lZfBFwC7/B7rUieJEfJfFOITIVyfjbolAniLU2pPKxckosEuqGU31nWtiE
X-Gm-Gg: AYBFou2z2HoNSkJT59zRL+kMjrpJ9QO4ZJ4tcR5XzTwDZ45mZhyQlo6WxgzPaArcUIL
	/3M0MpAmYfXUeHbVMdZjaqefBzzgOBk1d979JxwYnMZE/VvkbTTo5Ih8tLEGSEeDg+HF/bCAQkO
	+VuyoNINte7VKwH6BqqIfuL8TcWFkgz25t/QLpiPx+o3CyHe4kXDi7CGIKuWgo3+ExGq+aNGvXI
	79ggxDCMSobfqP9k3skP0FCp7IvnnJP/Sea5B3H/cuOUhU2HfraKh8QHE5hU0B2MS4AKlbvJ4XM
	gHnDKHsMb8fkqTLQZv8RbfEXEmg3Rjfa4sd+P+Ds5Ew09o8bNH9dhvF3nNH1URIvnSjgR1YHtgW
	9roCNHmalG68WZKV4dvDDBvqmi9Y8MBvlBov78BbzcE/Her6w7m26ml5Z+UYjJ5wrrZKmOEElkm
	QytB71j1563IROl6ibxgN+LTTpZX/ueTquiwYUfpTyfJiJOszO516Sb8F0zs2xgikHKhpoCbCOk
	VVQJ1OEVmkP2dc8mtnphAYdxg/UdB1jP/kU+7Ko8lbDa2kuggu/WGYmw9a0eTZGyvwlT3QmhScZ
	ftJRZ/ZY8q4a7RCslhO4/mCEw1biPZuIQhBHLOUmxTgTHmhCSkd0cfB+MdbjJQt3jDqLkKyE9v7
	ahNoS6FzHINixxMWiXjbhnhMAWRXeVpetBJ4=
X-Received: by 2002:a05:6000:ec2:b0:48e:159f:e33a with SMTP id ffacd0b85a97d-48e6e50567emr1257314f8f.34.1793315804977;
        Thu, 29 Oct 2026 16:16:44 -0700 (PDT)
Received: from HP ([105.163.1.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e712c2692sm234861f8f.22.2026.10.29.16.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:16:43 -0700 (PDT)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: l.s.r@web.de,
	gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH v3 1/2] parse-options: answer --git-completion-helper before command runs
Date: Fri, 30 Oct 2026 02:16:20 +0300
Message-ID: <20261029231621.48958-1-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.298.g27111c8f60
In-Reply-To: <20261029012616.139783-1-tangajoris@gmail.com>
References: <20261029012616.139783-1-tangajoris@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fast-import parses its options only after reading the "feature"
lines from its input, and it creates a temporary pack file before
that. So "git fast-import --git-completion-helper" waits for input,
and each run leaves a tmp_pack_* file behind.

bash completion runs the helper with the terminal as input, so
"git fast-import --<TAB>" would freeze once fast-import is no
longer marked with the NO_PARSEOPT flag.

Since show_usage_with_options_if_asked() already answers -h and
--help-all before a command does any work, it now also answers
the completion helper, so fast-import and other commands that
call it reply without reading input.

Reported-by: René Scharfe <l.s.r@web.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Tanga Joris <tangajoris@gmail.com>
---
Changes since v2:
 - Moved the check from fast-import into
   show_usage_with_options_if_asked() in parse-options,
   as Junio suggested.
 - 2/2 is unchanged

 parse-options.c        | 6 ++++++
 t/t9300-fast-import.sh | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index 283a0f1dc2..f2a23b79a4 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1536,6 +1536,12 @@ void show_usage_with_options_if_asked(int ac, const char **av,
 			usage_with_options_internal(NULL, usagestr, opts,
 						    USAGE_FULL, USAGE_TO_STDOUT);
 			exit(0);
+		} else if (!strcmp(av[1], "--git-completion-helper")) {
+			show_gitcomp(opts, 0);
+			exit(0);
+		} else if (!strcmp(av[1], "--git-completion-helper-all")) {
+			show_gitcomp(opts, 1);
+			exit(0);
 		}
 	}
 }
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 73c6e3d448..99d7843217 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2914,6 +2914,14 @@ test_expect_success 'R: blob appears only once' '
 	test 1 = $n
 '
 
+test_expect_success 'R: --git-completion-helper does not read from stdin' '
+	find .git/objects/pack -name "tmp_pack_*" >before &&
+	echo garbage | git fast-import --git-completion-helper >out &&
+	test_grep -e "--date-format=" out &&
+	find .git/objects/pack -name "tmp_pack_*" >after &&
+	test_cmp before after
+'
+
 ###
 ### series S (mark and path parsing)
 ###
-- 
2.43.0

