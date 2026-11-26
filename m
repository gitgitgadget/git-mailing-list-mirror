Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795694295;
	b=EgdZH/3Hfe9DXqfuQXrojfdbafRCYypXhT035myrLGlgN+WsLQjn1/oG6+ItLI8TWuuV
	 dKpRQPt/w4xNIfYNHohtorsoWZf9J7yPW6jq+ZZOveQUYePyp4aMl1ucH3S7dJLN0LCbt
	 aRT0FcKzeMfJ4gK69oonBSpxYNxuJqnwzDv4VKcE0tfIJPQZYV8+XLQnApIMoBwwkeF15
	 zL/iIPQO1npg7Q9y7uHgEChz9Gk9b1H25NVaU3f4n2gDOVBsvLqt/DCJWqUVyc+/3zTce
	 Bsfv7OgxTtrhvSGIMdX4BL61yt1Ex35+fmISlrgCRmVTOOrYTh/DteGFDP42Vg75x7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795694295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uL3hkZoND+sXWMMe1nbA2pvpSGU/ObvvjhiBJdMJoXs=;
	b=APxq46cjVXfZ8sXmv6hciXazofVqhOWFcJubQcNf6uGVXXB9URFbCvwZIaZNarovCyVQ
	 oVbV7ZYZjq8ur4vpfg1QRkF8Sx70Pzvw3goAfUnLBktax1IPgXvljhFJjW4VU0evbZQ2q
	 2uZ2IHPw0WhcGsHjs+qbEb1ltTedl2NspkHxNVDv+2gnW2X1YE0ovkLvM+kl/dLunDJHd
	 Th3iZ0E2vHygo0/gKoEg6HyQasvgr4k+prF//QYfsbaLCKLUf3dFn+XNC/9YAp85CNtlq
	 Jl+OAdWU76g6NCkiJ+xTlpL2R6MdnXIfqnLJ69nUf/8RnpfTgCELUybJfWAqlyV87Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VkNU2hCj;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785E1606A32A
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 11:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 785E1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VkNU2hCj
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-38190551625so13476177eec.1
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 03:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795694295; x=1796299095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uL3hkZoND+sXWMMe1nbA2pvpSGU/ObvvjhiBJdMJoXs=;
        b=VkNU2hCjlIFuSGlovmKqZrognugxLDIbD/cjckFIBY9O3piKa+6OYpQUjA/MspRuyS
         2Qu+T2tH6D1V5h+9XEe2RDzPM1HNP1uh7ttSwym646XDnv4l5UvOa9D1v5Xxh/EeY13n
         xvwdsoZ7NR6V63JoMJ7UlMA0cqjzX5+JExeC6csgydsMEuySGdQlLN2outujtOCO56hG
         KO3jP3eqvbiVa5EyYE1+5pgi4e4arvqHInjDzb56udv6XUpXzNv50UiP78/zlv86/MHz
         IvOGaCCMfN2mOkGfOzefBpIBNuujMmQ7taYyOwQDcrpEAyrz72jy9MoZCm7P2tSnFLo0
         qzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795694295; x=1796299095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uL3hkZoND+sXWMMe1nbA2pvpSGU/ObvvjhiBJdMJoXs=;
        b=uSKPtctfxZSDfj53aXjEGiBTkcgJQuT8qgD4PKblEgAJa6nrWBYaigVe1Qeq8ZNwbb
         YgpS1qvRp+YncOAI4uYLkECq3Bx8IbsSgtKdn8AfQ05J/8YcQ+dgwXHOxMj1eWMZwiCK
         ry4lZc30bo7Rlm2UQTvn5cir5mrKHA8c/jyFi/8GhbS6lh2jIETSH5buy/eTPPFb59y4
         fGfCtSVcP0R0GjUfhgjDMzWbusZyZW6l2xQ4DGGoJjQNbxrDPRt2Aq1oq4e2y0Z15S4H
         W8uIbVKfkKy4sM4labNW6VKc6Hs6boXxIprZ4ZElrieyeo3ILW1g95CipYErrZ4uNSZ3
         NdSw==
X-Gm-Message-State: APuU4Z87WSrwn1jqCRL9Qkt17UiOt3QU3RcaGYnb6RpMs3HjWx4Kgtue
	gAgAW0PVwpNVrdfw8ddgpsDj3nD06G5Qclauz0sL9yC9Rk/SNmKOcBW3/UCatEF4
X-Gm-Gg: AZFdTZchFZzhS1DJxg11PcAOvH2FFry04RNA+wrIEu/kOlaGFOrPi/ljzn81or77kia
	7Vmzk60NxVBK0mYlUBTECjCFN5VdRwfp5WJdJy4fQ7EQPtVgfnei5tQPHYGYlKBl/rMn6sVjcqg
	auGdG/S6xHT9yN541IIgq95SwDxy5g9I9HXqMuljdoYway0WeA6CYDGgm9fKG93RM5QdvlA691A
	E9K4RiP0My1P4FEj+7CE0cCyT2n8NbfeZa+l639HipoPP4nSlOtFQeL4df8MW5SFowCdlifGKp8
	sLbKjZTbXs9Hd62PTAbuJ5n6Ti8UxhmfikdNkFqUf/djaenq56E0d8JJJPf7cp/TxKqz3PGzhw7
	wTROpMQINRJ66duIRp3OIomFNTu5mzmK+Yd2ClhafV0XEyFvxVdF00lM7Q03ZI4B1iUMSQS72Is
	BEqvRGM5+pPujvkFcYpBPfKY5VS1le8HWXbQ8pjHjwULMrDA+tG2HbuXly9AuN45LFoLQGtOHDW
	u5E1vbtB87EVIe3Tj2J9HmS3YYLBYkQY5uQMKB+p0vKkpdXJhtaNZSI5I8KSpbUfOB7wwY18yYm
	GjOUZWtoQJ0UzFe2N+Tk945NqOmJy/Xb6YaLSgWPK8+3pRlyA+ELxHfPIXyZt2hzM6vXkXw5qGm
	q7nZtkponId9HAskRo3BJDVYWE1+MKP9RFlNR2JgroG0=
X-Received: by 2002:a05:7301:6192:10b0:386:a7f2:88e2 with SMTP id 5a478bee46e88-386a7f28967mr14149056eec.23.1795694294482;
        Thu, 26 Nov 2026 03:58:14 -0800 (PST)
Received: from localhost.localdomain ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aa203267sm33614470eec.0.2026.11.26.03.58.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 03:58:14 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 2/3] remote: name the original URL when relative_url() fails
Date: Thu, 26 Nov 2026 17:28:02 +0530
Message-ID: <20261126115803.30015-3-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126115803.30015-1-aniketgupta3001@gmail.com>
References: <20261105152842.566318-1-aniketgupta3001@gmail.com>
 <20261126115803.30015-1-aniketgupta3001@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When relative_url() cannot resolve a URL, its error message does not
name the URL it was given but what is left of it after some "../"
components have already been stripped off. With a base URL of "./a/b"
and too many "../", it says:

    cannot strip one component off url '.'

which does not help a user to tell what is wrong with the URL.

Name the URL that was passed in instead.

Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
 remote.c              | 2 +-
 t/t0060-path-utils.sh | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 3bca10364e..25e607abf2 100644
--- a/remote.c
+++ b/remote.c
@@ -3183,7 +3183,7 @@ char *relative_url_gently(const char *remote_url, const char *url,
 			if (chopped < 0) {
 				strbuf_addf(err,
 					    _("cannot strip one component off url '%s'"),
-					    remoteurl);
+					    remote_url);
 				free(remoteurl);
 				strbuf_release(&sb);
 				return NULL;
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 56faf5fe73..0d16b2c884 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -394,6 +394,15 @@ test_submodule_relative_url "../" "$(pwd)/addtest" "../repo" "$(pwd)/repo"
 test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/submodule"
 test_submodule_relative_url "../" "foo" "../submodule" "../submodule"
 
+test_expect_success 'relative_url() names the URL it was given when it fails' '
+	cat >expect <<-\EOF &&
+	fatal: cannot strip one component off url '\''https://host.example/a'\''
+	EOF
+	test_must_fail test-tool submodule resolve-relative-url "" \
+		"https://host.example/a" ../../../../../../x 2>actual &&
+	test_cmp expect actual
+'
+
 test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c" "../foo/sub/a/b/c"
 test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c/" "../foo/sub/a/b/c"
 test_submodule_relative_url "(null)" "../foo/bar/" "../sub/a/b/c" "../foo/sub/a/b/c"
-- 
2.54.0 (Apple Git-157)

