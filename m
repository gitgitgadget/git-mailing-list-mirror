Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263653;
	b=ORRcWot8YEHpWMbB7AylFGGKQO40zy9rZOk6QIouclL0kvEz52QsdyfRx7hvhN/7g22Z
	 2dShRjQaPSh98ypDc1VxR1c5rkYYJgAzdt5QPDBtxag+uyEo1T1hPVhysBeVAzUVW0BCm
	 GRdaeMh0ga98ZtM9rhOlsg0qnouAB7FFLpNuIGz/X7Cx3dv2AT2YaWgoI3ETiaK+oAsm0
	 ZKx5RelknLy9x8BcC30Sfl2bUmNvmBkUIYUS1iDwaZtT5qtlHSGxbL01PcjUoG/1PPAqq
	 5N614pIbjs6npdq33OxsNcaJ4ksk/OKA0iWoNK63nPFRMnxRlz1JKg1VywUZH++F4gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UvVIj/GEso0iryFfXYFozMmzig3zR4VR+dAnmELJhfI=;
	b=IQH0oe1xGAdMPbmEOP36qHu1bPLF8rGFgnvCVhj5uIF2OEfGzIWL9lV8uQWxsyiCTe0C
	 CAqS3QwEih5Wn/599VReFMUD+xuxCmGUJo58zdQUXyK6/jR4QPgdekPAcuoVmzliC9Si2
	 +nlpA6vDf208zqru9GRkhlUkfVM5po+T/z9wAK0pmzxzGyYGImW2MThghCIY0tb8suu+R
	 /doWzwhLBC+KegMnb7H1ZzAQiU2wtfCsoTVNY8t35S1B1d/24MUWTnL0iyrK10Pekex4m
	 92Nk95H5E/+jZil9g2J7DI+4szapNuvGqN2wO8KGhviDNKpalOZwS4pf85UvB3QmESQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=03NvegJi;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1840C606A32D
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 08:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1840C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=03NvegJi
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so13667295e9.3
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 01:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793263651; x=1793868451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UvVIj/GEso0iryFfXYFozMmzig3zR4VR+dAnmELJhfI=;
        b=03NvegJiGbgeogEnA1H80d3VaaMUBP1ulob1I7sbrLWj7rrCfHSbwSBd/I/5LZj6vi
         BWewuqfei/BPiSOdG/w9c6hI7oSzfH/lp+NLauXqi5Xv+cMqvnXRMDHGgNh/r6YwQHth
         YvqjjrcaGskXQWYk/cMS2hJzUEIMdubeHjQ0kfaEIN1+zcvQz/35tFgJnT1070ILphYb
         CzXhSvQQbIr5SSy6DWrhE0YUn8gU0MBko9c/H7Lwm7qYySm8yE1Ll1Di7J81xk/oiml3
         ChilscHXOYkt/xOfeghItdora51lEBHiE3VmGPUR5pNePVrwHB7AiQ1M84MaAD8+ESS1
         /vMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263651; x=1793868451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UvVIj/GEso0iryFfXYFozMmzig3zR4VR+dAnmELJhfI=;
        b=mtS6jaH0Aw2iDm/EHJx8SxYyp5kiQCs66s2d8quyT1O0ZQj7FSP8L6t0Y6s8Ezdubv
         wAGcOEbyoDsvIUYHl7IPq5zayh7VjjypbbgDlk+G35cZGCUxcCaOL07zeSVaX6ze/+0I
         3xTA6c3wJ3JAKe81511sCpvOwlMkKjSGfZgk5isW6Iri7OHEf1OXzu2AceGZPw12R7xL
         Ko/tiW/7ydgCscIVN+ws3PH7Lgg64DdSj+bE4iX9ESojaNzp/kOJEkwIkx9OHP3m3BZ9
         Lk8Xbek3MWSTjjMXKChkton3hO7KU5ovj1Tca/7/2QlXAyFr83qQk/K6BNhpxLxxihLx
         30sA==
X-Gm-Message-State: AFq9FYJiiYfrtZ8HtynR0NeQD83NcrM7l+Z6m8A8zk072DhjbJoXNr/o
	xW80gHouKDp4Q4W01GHvLuVWAun9YBKIyP7GBiOeBjyGccWkro5M+X21dqU4+zzj677Sog==
X-Gm-Gg: AYBFou1EEFLvhWYaUsbrivy85tMnqAILh4CdKrJqX4VC1jJHyquMzlRA76ZF3jaNc36
	pP3/s7Ap9+OUnh9GoK+BbttYNLTQ0JtCELih8Rw9+qvROntmKNCjCh7HbfkiXQKKiX2FYFlGITO
	TYEs1DK5zfS8KRQ3/rJ1zR/GzyolRuY/Ix40zHV7np2otebfFVjXAYbagsTQhFtLKKGj39og+Cs
	y71JmbjwvTZtvGury028j77WLCJL2ywMp1qdKqXw/s7jSSdJUcOX7Gwqy468gmllmvSITSYp2E4
	/wSaBuiQ1ZHDjhojoJtGkGW25eNLaNH6UGhyxvZ4nKMXFoZy6D90pSyJzGdTNOvGRwkSuybOsM7
	3p+3qcjkicBfZ4jI9sz7wtL71RUghTj6kBDc17uEKYSkn5g4iy+fgihOGIyRMyGksZmLzgh55ze
	9NOHrylyZ4shpiKmtkc5iTYm3dE1Bh2Q1XP6W8p2ws8V/dVR2KR7AQHe2LLU9Pg4PHe6O/Bc+uo
	UBIRbF+gpBB4Byl0BVCfha+K8hPb7QqgoFapztedtbg6xSFsI2ZtUH3KwKlwRXEoB0VnfWxkajt
	QBKDShWWEu4glFM3iKFN3cly1j1cAXptKNg5DB5iemzga6g7XKyhae3ekQolnZTtgh38sDSZ8d1
	zXawcwJMMOdEhrtVFwMoee+jy9dgTYks/SxNGjrXjCspcPYrAfnqcTryjfXJcHIoPPuJ46H+0Rv
	v9fREOF4MqPsHx4/cEC9PT2Z3/bv4z68pJ723i8+sJzv9yhEKQupQ=
X-Received: by 2002:a05:600c:524c:b0:4a4:7a8d:c736 with SMTP id 5b1f17b1804b1-4a9661ab662mr111401355e9.9.1793263651284;
        Thu, 29 Oct 2026 01:47:31 -0700 (PDT)
Received: from localhost.localdomain ([102.88.166.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f41895fsm44007955e9.5.2026.10.29.01.47.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 01:47:30 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH v2] range-diff: use diffopt->repo instead of the_repository
Date: Thu, 29 Oct 2026 09:47:20 +0100
Message-ID: <20261029084720.93221-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <DMGX0XEZIMHC.2P0KB28XC83HV@gmail.com>
References: <DMGX0XEZIMHC.2P0KB28XC83HV@gmail.com>
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

output_pair_header() and patch_diff() receive a diffopt whose repo
field names the repository to work on, yet they abbreviate object
names and look up commits in the_repository. get_filespec(), called
from patch_diff(), also uses the_hash_algo, which is the hash
algorithm of the_repository. If a caller set up diffopt for another
repository, these functions would still read from the global one.

Use diffopt->repo in output_pair_header(), and add a hash algorithm
parameter to get_filespec() so that patch_diff() can pass
diffopt->repo->hash_algo.

Keep USE_THE_REPOSITORY_VARIABLE because read_patches(), output() and
is_range_diff_range() still use the_repository.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
Changes since v1:
- Reworded the commit message as suggested by Pablo. No code was
  changed.

Thanks, Pablo, for the review.

 range-diff.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 8e2dd2eb19..3f56a4f71a 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -418,7 +418,7 @@ static void output_pair_header(struct diff_options *diffopt,
 
 	if (!dashes->len)
 		strbuf_addchars(dashes, '-',
-				strlen(repo_find_unique_abbrev(the_repository, oid, abbrev)));
+				strlen(repo_find_unique_abbrev(diffopt->repo, oid, abbrev)));
 
 	if (!b_util) {
 		color = color_old;
@@ -440,7 +440,7 @@ static void output_pair_header(struct diff_options *diffopt,
 		strbuf_addf(buf, "%*s:  %s ", patch_no_width, "-", dashes->buf);
 	else
 		strbuf_addf(buf, "%*d:  %s ", patch_no_width, a_util->i + 1,
-			    repo_find_unique_abbrev(the_repository, &a_util->oid, abbrev));
+			    repo_find_unique_abbrev(diffopt->repo, &a_util->oid, abbrev));
 
 	if (status == '!')
 		strbuf_addf(buf, "%s%s", color_reset, color);
@@ -452,9 +452,9 @@ static void output_pair_header(struct diff_options *diffopt,
 		strbuf_addf(buf, " %*s:  %s", patch_no_width, "-", dashes->buf);
 	else
 		strbuf_addf(buf, " %*d:  %s", patch_no_width, b_util->i + 1,
-			    repo_find_unique_abbrev(the_repository, &b_util->oid, abbrev));
+			    repo_find_unique_abbrev(diffopt->repo, &b_util->oid, abbrev));
 
-	commit = lookup_commit_reference(the_repository, oid);
+	commit = lookup_commit_reference(diffopt->repo, oid);
 	if (commit) {
 		if (status == '!')
 			strbuf_addf(buf, "%s%s", color_reset, color);
@@ -474,11 +474,12 @@ static struct userdiff_driver section_headers = {
 	},
 };
 
-static struct diff_filespec *get_filespec(const char *name, const char *p)
+static struct diff_filespec *get_filespec(const struct git_hash_algo *algop,
+					  const char *name, const char *p)
 {
 	struct diff_filespec *spec = alloc_filespec(name);
 
-	fill_filespec(spec, null_oid(the_hash_algo), 0, 0100644);
+	fill_filespec(spec, null_oid(algop), 0, 0100644);
 	spec->data = (char *)p;
 	spec->size = strlen(p);
 	spec->should_munmap = 0;
@@ -492,7 +493,8 @@ static void patch_diff(const char *a, const char *b,
 		       struct diff_options *diffopt)
 {
 	diff_queue(&diff_queued_diff,
-		   get_filespec("a", a), get_filespec("b", b));
+		   get_filespec(diffopt->repo->hash_algo, "a", a),
+		   get_filespec(diffopt->repo->hash_algo, "b", b));
 
 	diffcore_std(diffopt);
 	diff_flush(diffopt);

base-commit: 8d1b215c01512b9658d4525c54ff9b9245f9a7e8
-- 
2.56.0

