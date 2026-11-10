Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311418;
	b=0kfqTlIoEfOWJjCvvSWT1VVGxBwkIHZhXHtZBO41H5HZo6hkZgiVs3nS0NsF984y2tfG
	 uV1ZssvNUcc0mtH0zq5UNCRM1JR+T5AUiEPq3iHo4bqXx4S0AvqX4R2RXwQfhDaO107o+
	 w16eBNR4N501UV9c7zQNtCWRhOTHZjUlN7galXnI3YQlwd5q1OfxzmRuLlh1MADdR+6vJ
	 x4+NEmT/EP+T2GrLVVR07WdtGp6Q/NS3HlIDMQrEv33aB/JnIytLBy8/TAwGU657XvKKQ
	 fkyrjORYPy2F3sDtEE+ckf4ELpNlIMJS4XL5JjfvFt5KK7soHK5Ii1QtjwAZnhaPP/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ordKmtN0gOogzzB9anxx3MRs31+fcvlHK5tO/VNJw9w=;
	b=vBcuGvGGtnM1PXIf+Y2GZC5FlMftt4ttO02yA+OjJuxhIqoXKnjwdOJd2o2d5LEi48Ps
	 7A6i5/GD15oW5qULSaN+Lu6N9itsFlVzBWm1e3V+P2m/YYLMjLjjftBTzmCnggDRy4xAA
	 M1VX2bGP40PiYeCLu06sDqO1x+2+lzzulI3Y0LRQcL46bP3aeDADuUWy7BRqwpADFAKsV
	 aBAR75SzDDN1k+DCt7a4fZbiF2o2P1ybxmHiUaQk5WZcl8V3L/saRVL0hJ1FZEBkYzZJJ
	 8vOYPPaxVx27TU3FdzAzfSpuLOpVy+m1qPJSuIEPBpmVIVZUaZ93/r5yaC8ZEM/iZwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NyT3KGH8;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFE8606B5B4
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DFE8606B5B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NyT3KGH8
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so14441805e9.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311417; x=1794916217; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ordKmtN0gOogzzB9anxx3MRs31+fcvlHK5tO/VNJw9w=;
        b=NyT3KGH8ZT75rHR1/AccLRxOKi5bnL+AnncqmjfAK6/zL5HVqWny6TAFafQyi+6kx4
         9b6w3hn4h2CewuyqLyFeGKQSLzIsFuEiwWv9wfsnPT4ks7YtLwUVUiD+miF+dKGTxjbo
         i/XgJaclJzbhKrRe5HX5w6VblJnog8x4MlU+ZZHmvHlGcySeJqcKo4xBNAVHgig9ne04
         GGI0bbdeJlBaBh0o5YJAIp1GaaS5lDbXibPusZhplkjxWGCPUSrQIjM8P1tyncdf3GPc
         1AJBLXyQOuwPtXAEAxrDadLEghtU6ax9vwm62dyjZPm14Nzf1sdvYoJ4tvZdzAlJ/0RB
         AOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311417; x=1794916217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ordKmtN0gOogzzB9anxx3MRs31+fcvlHK5tO/VNJw9w=;
        b=AfKnAoSusUNQtwhXfoDXPFoBvL8ckDBTokuHLKGu25/n9Ow/ObKBP/0p3nStpPsjcL
         SVTDOeCRKBdfC0is+1lrseziZc9hYMwyqh/AZBtdgku6IeeUAAwgL1fwKTTULICCj36n
         Zs+h2NPDWNOZe5Y/u7wqQ+M8pnWai+dFna6pPBT2ZIx+xE84236AWISGcN4eLX9y4/u/
         zZHyjODW9z2ORxXTU9Uwq4j2lr/vlRfsO7gkpfNxTnOYvzhNeGISaiU7reVzgNX36i1+
         +Q+zQileK5ZsvcUpA5SKSlFmqUs4kpbLLbD8JU+4XA26yv/pz50Dal5GmME1r6Oy2hqO
         1aSg==
X-Gm-Message-State: APuU4Z9XFmeH8/hTQmU47vYOGibk1NBTT789Y8hmum2VwPsTzX4rLae5
	OwfqDckf/uTSssvjgnLovzSbNRSIxb2xf4wlzxPqSQM3XXx76whG1XXV6/gPBQ==
X-Gm-Gg: AYBFou3oeMVxqlOt+rZGsACP8b3z+K12R2RtXdjeyzImBz1cJ1ijc+NvNowEfLSu1oA
	VecHx1dc9YWCRLnnO9emQZHYRwrWA68NbpRT1mXPAqRLHsl/4wW7SWsvkr+BN/sV4T/TA0HXpYd
	TIUqYwzOt+izBeN5XRwPCI1TDYoZp+8UYNB66mi3o+BoKGD7032Lci1B51USOz5woChaWFpt4QD
	c7rPqQZ7xQMm+nPkEIB2Mhok5dXM+uXOOyRgA+8FYOmd6n9KvvwEhfZpBsjelDMKE3qIOVthfGV
	m6euut8uTeHUhQlnkHFgSuQO8fn+6E69cC2NAVp2vOcT+5nLqh+kApP7eCEI4gTEap7ssP8O4DG
	N7qLfgr02Z47huWEv2I04jjqRtk6jtr/cIihy/MgE0JhUVa5QqyOeCp9Yr1e9O/BC+eHkpSEF0u
	Zjr0C1+867qTfsc7aU+oaridErc7Wof/llpiIDW+e8CRTM3HLN3axC7bXkaGIB78O3BvYORRM9L
	vE+A/AoE0qPVxd4dtGzgjwIayEmqxohdaY9nazMv4bbggb+FCFOABcM5YpNuypOggZTzcT1Anif
	5COLNY7iQePvzN9S1wSGmlYseLSldukn32k8neWFPhZ1z7BW7MKn3rrxFQpLnhyTCpxwSfk5jkd
	hSC0maGXzngOk
X-Received: by 2002:a05:600c:811a:b0:4b7:6b0a:a2f6 with SMTP id 5b1f17b1804b1-4ba02349500mr36991965e9.21.1794311416602;
        Tue, 10 Nov 2026 03:50:16 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1917:82b:d709:897d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm60715995e9.2.2026.11.10.03.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:50:16 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 10 Nov 2026 12:50:02 +0100
Subject: [PATCH 17/20] t9300: make the stream tests self-contained
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-kn-fast-import-tests-1-v1-17-dbd9ee502aae@gmail.com>
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
In-Reply-To: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4077; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=x/HTogX32VqDaQm5pG6kQ1bYQJUmG5Lkuta6mjvTnbg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrzBOnzEnFX335Odttzmg4GOHRqxiBull9l2
 X04uAHslYyViokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq8wTpAAoJED7VnySO
 Rox/JzgL/1yCpfA/+WzdU5jSouaVLGMhyy7f4a3joLbl+fn2FBNVF+E1ezbKWUCI31C5FciVqga
 WoV4ImGXQFIFoWzph02d4eimdVJeKtivyXE6kTVpzvv9a5VfrWmlI8CLYvPayrz2aVoDTzAas2X
 xhQQg9WzuSbZTLvyl9HlPY7WzuVNK5NbksCvQdmyG2qNM7SkWUcdmZTninCIwNDvlc6XzL7U9fh
 BSHFH3vpUoGemLcEWq7fGURmZz6MAWHk+sOc1LE3xUCLGgSj1HJLHyOw6mYVIkAoa4Mfsac1Udy
 gavpuzjCutYXs3ukLywQObYTrKi5oyaS8oqbLrF/4rjd379xoFyhkWezRLN0e2LRMNwDCe6vbh3
 u9ClFH85syYiTL10dPcZ+xTy2PA0isz/8zyq2aHSMQhLxCBSrCRsClDJ3a2cH/8h1hIt5JUoAX5
 fs6L6Gs0ue69Rly07202l9ZR9oXQi4u6xmfaW39V2MqEzNopYAt3sJ0vGBTpKNXbUFLdpGyRQW6
 Uk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the tests in 'series R' which
check empty and truncated streams, the 'quiet' option and the 'done'
feature to make them independent of state from previous tests.

'empty stream succeeds' no longer needs to configure
'fastimport.unpackLimit', as that was moved to the first test needing it
by an earlier commit.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 122 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 79 insertions(+), 43 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index cf00e4faf9..c719b2115e 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -38,11 +38,23 @@ echo "$@"'
 ###
 
 test_expect_success 'empty stream succeeds' '
-	git fast-import </dev/null
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		git fast-import </dev/null
+	)
 '
 
 test_expect_success 'truncated stream complains' '
-	echo "tag foo" | test_must_fail git fast-import
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "tag foo" | test_must_fail git fast-import
+	)
 '
 
 test_expect_success 'A: create pack from stdin' '
@@ -3333,58 +3345,82 @@ test_expect_success PIPE 'R: print staged blob within commit' '
 '
 
 test_expect_success 'R: quiet option results in no stats being output' '
-	cat >input <<-EOF &&
-	option git quiet
-	blob
-	data 3
-	hi
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	EOF
+		cat >input <<-EOF &&
+		option git quiet
+		blob
+		data 3
+		hi
 
-	git fast-import 2>output <input &&
-	test_must_be_empty output
+		EOF
+
+		git fast-import 2>output <input &&
+		test_must_be_empty output
+	)
 '
 
 test_expect_success 'R: feature done means terminating "done" is mandatory' '
-	echo feature done | test_must_fail git fast-import &&
-	test_must_fail git fast-import --done </dev/null
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo feature done | test_must_fail git fast-import &&
+		test_must_fail git fast-import --done </dev/null
+	)
 '
 
 test_expect_success 'R: terminating "done" with trailing gibberish is ok' '
-	git fast-import <<-\EOF &&
-	feature done
-	done
-	trailing gibberish
-	EOF
-	git fast-import <<-\EOF
-	done
-	more trailing gibberish
-	EOF
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		git fast-import <<-\EOF &&
+		feature done
+		done
+		trailing gibberish
+		EOF
+		git fast-import <<-\EOF
+		done
+		more trailing gibberish
+		EOF
+	)
 '
 
 test_expect_success 'R: terminating "done" within commit' '
-	cat >expect <<-\EOF &&
-	OBJID
-	:000000 100644 OBJID OBJID A	hello.c
-	:000000 100644 OBJID OBJID A	hello2.c
-	EOF
-	git fast-import <<-EOF &&
-	commit refs/heads/done-ends
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<EOT
-	Commit terminated by "done" command
-	EOT
-	M 100644 inline hello.c
-	data <<EOT
-	Hello, world.
-	EOT
-	C hello.c hello2.c
-	done
-	EOF
-	git rev-list done-ends |
-	git diff-tree -r --stdin --root --always |
-	sed -e "s/$OID_REGEX/OBJID/g" >actual &&
-	test_cmp expect actual
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		cat >expect <<-\EOF &&
+		OBJID
+		:000000 100644 OBJID OBJID A	hello.c
+		:000000 100644 OBJID OBJID A	hello2.c
+		EOF
+		git fast-import <<-EOF &&
+		commit refs/heads/done-ends
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<EOT
+		Commit terminated by "done" command
+		EOT
+		M 100644 inline hello.c
+		data <<EOT
+		Hello, world.
+		EOT
+		C hello.c hello2.c
+		done
+		EOF
+		git rev-list done-ends |
+		git diff-tree -r --stdin --root --always |
+		sed -e "s/$OID_REGEX/OBJID/g" >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'R: die on unknown option' '

-- 
2.56.GIT

