Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512363921FA
	for <git@vger.kernel.org>; Mon,  4 May 2026 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890540; cv=none; b=EJwlHHp7jemfBfumRsgxtWDJpXaovshGZhQnqdVLcCj4vUk9r0jsZb27cSlWJOogUDDQn6ysmhihQxPVVXfuA6ReywryBGs1aLrJhQtH5Plp0Rwhlh+UUU05qO7VL8dEIwHkhUaNAp3tj1L37mZUdQJ7PQu4eOjglCwsgtPbo+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890540; c=relaxed/simple;
	bh=bb2nTAIVDAwlV3lwRNpFALakE7thX4/kQkjqhr3lf6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8F7P7YX+pk9EPQ1iorP4Ny5/+eStGB1c7udbLBY5jc6DZp+K39U6RfFO+TEAbdx6wP+KsrJIwi58OMegSZ/0bx3e9w6TUwYsRe8T2y+Y/kJsKa/dPLYfg+qF74zuc0SB8Tst6s/w0P0k5iF3HHYQGr1rw/jXHPp33quPc96V8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLw6bQgm; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLw6bQgm"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a858881ad2so3570948e87.3
        for <git@vger.kernel.org>; Mon, 04 May 2026 03:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777890537; x=1778495337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3Ixhq9QHSURtkS6AwxoP8Uq2y1yF9XyV2t7u+RhNbs=;
        b=kLw6bQgmukID9mknkhU6SLOBqZ92haRMsh/vwM8+PQfY8Ewv3gP6neWvw9szntIDBq
         JH9kjIeJxSr+974xq+g03NqNgYKh31Hw384Tg6kYn0LZRco2m3YQT9jVjdJty3gu2nnM
         1+rRGRdQlGe/lyQ4qvYFYHaalNFWzP5w5lf6R4KFyxMcDh6ONg08WKCDLSbHr3TipGcY
         Esac3Ntrjc9oTU0CK1V389Oo1T7WGGy+np8SjTQpkp8zzjBRXMQGRYjgxiJu0tQVPQe0
         Afk8kdsLuktUs9w6AbJd9AkZITsS+rQeoR2rHKvylfNFTP7sCcA4k4XBz5TnA52x3yD4
         B5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777890537; x=1778495337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o3Ixhq9QHSURtkS6AwxoP8Uq2y1yF9XyV2t7u+RhNbs=;
        b=Ui7wnhC3zXcNXvp7cMAkSoLWiComNahKLf/5iTP0mBDnULEVRMEKrtR777SndNTzw6
         MlLFC2qp+Pm5OrtqE0rdDp5czST1e4yEvD0Kkzhi+e9s4wn4CeKFn+wAi0JZ0lB0lF6E
         WHiZtHzg9S3JaRTjkcIOZXHeCGXP17ohttVmxjC5FCacJSqZ8bgv+rgkhPpHe4/zNo8l
         NsQrNnFotjn0dTS5rZMvmBovI3qjOSez3J7hSMRlxZjlJJUfGXk0bp+4CnxdFppZiBgu
         MDcFpjtGLVX9JnnGLljEJK1Y4NqUpbFbOOW2s2giUo/jcRM90140R4iNm5f9++g8Jksf
         RyOg==
X-Gm-Message-State: AOJu0YxTk4Hpm+71GK74+oWxqFLJ03wLT6/05hsSMt59A+ZlbYadHfgL
	dCUoPsfNYjAUf+rVtQ/tPTlwjk56v2i+7idvCNnUMXQML9xAcAu+lsRtAuFang==
X-Gm-Gg: AeBDievyLYXmCtzSlOIy4eZ//cPmS+1l0+d+d7RPfs5wWL3X6Vs3mycgd0e2MrLMzkp
	XGtIuXfyDRF9BXMDBh+GJlLe7/UfBJi+NH+rXGx1NdQ5j0T6tm60+Rf6HGDHhUD2EjNHvnGNKBu
	NXQM14v/sF6436XwdSni6Oj/Y93xzK/el5EJ4f4a0ZmUPWGZCnUOh5m+u9t2irBiFbrm4+ZoZbw
	ifU6K6Pf/mTFXnsXzPG4IIepoq8tED02dhQXvTXkuSaEzgOqkzLXi0MFyompHtsKDsJVLU/VDf2
	9L+TAZd2lGxLKRfcUP1nmWcCrKbTqwu80rfinHQZcxpnOU8gaXzLtFQLJ7AeOaxg/P3tUUelzrr
	3HKHEE08bcKQ+Bi+z9qmeWNkFVKLNnj7m/pMkOFvrrrNS0AF8mWAkvd0ZJxpsSom9RXIECwJBqv
	WxqwnvFWxUG/q1PnH8isUyb9PNRg0CQU3E04QQUKeO8XkraiCykTdsGM2cJA23Uaqj83JIZKdGs
	L+GZMPr3slw9uaBbsXNw8O/g/t+prLl9q0ucoT3gbpjs31cOS/+IQy7zU3Jm2MlOssvX3Kwikg=
X-Received: by 2002:a05:6512:3f06:b0:5a4:496:5bac with SMTP id 2adb3069b0e04-5a8631c3114mr2842376e87.36.1777890536709;
        Mon, 04 May 2026 03:28:56 -0700 (PDT)
Received: from localhost ([2001:2043:be0a:d700:5d74:cb35:863a:a32e])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3939a58fa47sm10320111fa.37.2026.05.04.03.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:28:56 -0700 (PDT)
Sender: Erik <erik88@gmail.com>
From: erik@cervined.in
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	cat@malon.dev,
	Erik Cervin-Edin <erik@cervined.in>
Subject: [PATCH v2] Reintegrate: send "Huh?" warnings to stderr, not stdout
Date: Mon,  4 May 2026 12:28:44 +0200
Message-ID: <20260504102844.74734-2-erik@cervined.in>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ae896PlyiYeqldFN@mbp>
References: <ae896PlyiYeqldFN@mbp>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erik Cervin-Edin <erik@cervined.in>

In show_merge(), the "Huh?: $msg" warning -- emitted when a
first-parent merge subject does not match either "Merge branch '...'"
or "Merge remote branch '...'" -- is meant to go to stderr, but the
redirect

	echo 2>&1 "Huh?: $msg"

goes the wrong way and sends the message to stdout instead.

In the common Reintegrate invocation that captures stdout, e.g.

	Meta/Reintegrate next..seen >Meta/redo-seen.sh

this means the warning is silently embedded in the generated heredoc
body instead of being printed to the maintainer's terminal, with no
diagnostic that something went wrong. Worse, the resulting redo-*
script is corrupted with a "Huh?:..." line.

Switch the redirection to ">&2", matching every other diagnostic in
this script.

Signed-off-by: Erik Cervin-Edin <erik@cervined.in>
---
 Reintegrate | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Reintegrate b/Reintegrate
index a1e67a0330..6fdc7c5f41 100755
--- a/Reintegrate
+++ b/Reintegrate
@@ -327,7 +327,7 @@ show_merge () {
 		merge_hier=
 		;;
 	*)
-		echo 2>&1 "Huh?: $msg"
+		echo >&2 "Huh?: $msg"
 		return
 		;;
 	esac &&
-- 
2.53.0

