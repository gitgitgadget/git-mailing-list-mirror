Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504855;
	b=M/iuAsOAy9AnKYDSMaxeBq3LtbZ2l+HZGYa56UpCaJ+I+MjjLD7nSwQkf+/fZmNPluu9
	 DE96xCxBhekP+s6sqUMr9nTRkRlWbDTdwHMS+W2T8QzCYStJ0iL1H+Zq/d098ivw7hCri
	 B3Td8fFKE7OYEe88+iSt6tD6tBaaCKF2NWzyS5O6lp23l46SviqNyHllkGbZdmTLSMXJq
	 CqtuGFIZvLyR1sQh7OiKSSXs4Pub0Eh747EmhsZ/5wLwDo1F3gyKNXiNh9LbWu/5lExG3
	 GZB4wjc4/IEvbaL1ytVKm7kdtHV7Cy7N5EJDfi6zUJ+g3obfkYa6D0hZHKG9vMxVasw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ro7L9rKcMEURt8sO3yu25KMc+d++gq3eYEZyCRJQkwY=;
	b=vphzmiO6RJCX+zsW70uG75v/5PiIPuGaVMzNw6gdgPCjwu9scqi/hHfCppmEkutnrO9Z
	 HbarAo/vs+p4Yw33frkdMMuKpuMSAVdDCEwOoSmGtjQQlenZwkT8kCyuCnt8frrhtArXd
	 iNuOGRX3/gdlKAu89lSJUn0ipsfOHYiC+o3uhBQ00bxJubgL+ssbCRilBIf1ElJ6GdWlB
	 7jfbAcKfXc1CktjfOGWt5Ulzbw2YzLVWWqB3v+nF3hK59KrHt5JSYblNShXTaM9fpNzr8
	 kat4Lv1B6EJLR3FOLsxu2vYnRBMtjKyV6mTn1qRMlHCttQB1cAfbYhzi7AOvzJabmhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="iTX6cy//";
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E255260A2635
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E255260A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iTX6cy//
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e10a70540so4607f8f.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504853; x=1795109653; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ro7L9rKcMEURt8sO3yu25KMc+d++gq3eYEZyCRJQkwY=;
        b=iTX6cy//k3SW57A/vgNRCuMAI76tUu7EM7C2DdjO5cdxvSpoXPgDSGQFTxB9na9cxx
         aOdCUVEu6UkkiaEqgBbASn13ndfCQYv5FTWnq3bE/+ItFJHkNmJUP7iWcIIpmAESZIzm
         SYYn9U+Q8mSwj8dD3PxzyLZdm9ZCs3P6pyeq/FCgvyZFg83hV7CCum+iTZv6Ae6CgDSj
         LuOBc86TWrAuquy+uXFAV+3SINFBJwkV2m1yhe5BT1Be0hkJwO1tYaQBxRb6eEGb1Dgr
         tcJqMc3uADFaLCH/x+64j6Lf4Hy2Kt6JxljOgkOy876MImHZ2xCpkqKG7ugDxmgaa52Z
         nJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504853; x=1795109653;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ro7L9rKcMEURt8sO3yu25KMc+d++gq3eYEZyCRJQkwY=;
        b=ZnAlEioydqHEVI/YJvoonLgLJkhKfcoez6yitERMP7B57AmP2McKISla20OHziDDQt
         dYXOQsV63JYT3NMT7WqVRvsMak0Ae7EaueI/yel3AhYEZC7UEGGYFeNo7I1x4TfRMLFG
         Ko45qDQlnCdvcTvaq+qBWeHdYfy52qKQisJxDWgZN3ptmD2QmYmMfq3rzibZvB0mQO0b
         GaPiXWG9pVtTSp/vyKKdkAYlORDQmC0W2STvbdSUYz5JfxgNEiyAnyO0Bzdf0SSwhbP1
         kVhABp4OoJgbLGH01sHR2t023LwpQBMnKonCq+FxMjUt/ZNbVLbprjMjsByYotkw6bIT
         vv7Q==
X-Gm-Message-State: APuU4Z8/iX7xmWHlLKDjQyz/pOGfL4qeQX4ImJjYAhubSiFOw1snKw2+
	qpaBLFU3K/777Ir9YPiWnNGa6uS+B7CYdv6N0NpMgM9zcwbL0yW87TnJNlreQw==
X-Gm-Gg: AYBFou3CAwSgjWx6I5+A9uzf4dPTBcE5kG6jW8tm3+4SLSwuJe16jfBhxT4h3Hd0c5p
	+pkYQ8LfhdGAWUNoZLtQMEfVUEVbmpqpg7fZDk6EBSM8ZPktroAcxjjzduyhl9acq5FCBBX/OUF
	jbTZlpbchYjjvhEo9p5QYZMZqleZiqWsuTmLRsmVjd2vI6d8u/8hUI6G2P0gDGN6ImtlqpMAuLH
	/rXWvdXtpT9YgBOPgX4depIbDud6yDxR1Cg9n2C91t/k+SzTaEkY+h0/IzOUJqx06Hi8Be1bhQr
	xBXeLlzk3gKSIKQXQu4tMl+qp1OO+5l4bz4TuvZNU80lnu+mA5V64jNfNaNpy6REqxK0/EmY5DL
	/pszQV/APEnz1SY5NvWK0cu1NbtZB/4iSjBJMfrYxbfhUZv81+X1bU3ngUfEedFP7k9p8LiULqu
	pT3nKZF8WduEuwP3kE8YwpVwsQvR916WPYcv3PduJNg/hOpPX2OWiILw163aXeQdp6jkOMPEtX+
	904GOTWYj3j4Qu3kxNRIW4/SPOBcKCEuIjaKmdD9bLbaR6lRI4EY3AROMhd3lG++WIxs1udl+2+
	1LthFTEJv4hMpTLyUuaikmOEaDA2TiC7/EUEREjg/jYk+i8HKaPRxMR2fRX5WNtxKAb3QnxsPNf
	SYVM2beMU/ohtag==
X-Received: by 2002:a05:6000:25e7:b0:48f:bb68:4e83 with SMTP id ffacd0b85a97d-49c73164334mr103679f8f.9.1794504852775;
        Thu, 12 Nov 2026 09:34:12 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:cb2b:22fd:d791:9595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm345988f8f.38.2026.11.12.09.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:34:12 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 00/20] t9300: group and move tests to other files
Date: Thu, 12 Nov 2026 18:34:00 +0100
Message-Id: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0K6dkxbgkZX3sOwKO0Ao0JJpxIN6
 d0t6NblS/5/bxGMgZDFuVhEwJmY/JhB7wphezN2COQyCy31QSmp4T5CazgCDZMPESJyZFAgS4f
 VUUlly0bk8xSwpdcmvtZf5mdzQxtX27roiaMP7608q3X3iyj5LzLnDrjGnRArqY3BSzcYeuytH
 0SdUvoALwcKJM4AAAA=
X-Change-ID: 20261102-kn-fast-import-tests-1-03de57101c3b
In-Reply-To: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=42732;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=3dk+iHa/C12rd5xMTNIhQIvd3dSOa145U/K6rvqayuc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGr1+JCQxiotihwY7pG4qPpM8vey3R1vgML/n
 J7nIRVI/Wi7B4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq9fiQAAoJED7VnySO
 Rox/2EIL/jpNVOXM19zRvU6JCak6CmE93omgEkdST3+ecpRd8AvbJXk8tgB1MT/Kry0IrvCa3kY
 VdIwGQUjGsGYvWQGHra7INcZexyZ1CVwjggTRUd3mjGsgI6iVud9tPb17BR/nym0RL6JHIiJ9hO
 h/lymhExptqF9M6K58FmqcWaQc4wrMmaz5vvNzlCpfiPmBWp2O9xBEpkmnrMTZn5PZOuQl9bsd3
 AMtlYIqjYzP9lm1FlujRms9vueZl3ex2C2g9GCfchXqcy6PbqHl/94wG0I+iV+FAdXRxhkNgCS+
 L5DB2WiPvlLaUp0/TsIN4kJaGgqhax5WNJBWhRpBgMpfjQCPMlDFsx0Sphmp1E4E0CdtVR7kggY
 wmEkwqK3eIUQl18NpoEEJ0acl850EHmvQXbJjiW29OSEVwhix2W1E8/YXf/CpaxBuhbDmMROLNp
 Yw5pfNTILfeeoRTLL/1i9i1ozLtqEbyEqvw394Hqru8HJRRxnIF09fRpGAx3hPf8aQifkXk0sz5
 cY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

While reading the git-fast-import(1) code, I stumbled upon t9300. The
test file is around 4000 LoC and each test has some dependency on the
state setup by previous tests.

This long series unwinds some of these tests and moves them into
new/existing tests based on what they exercise. This leaves t9300 in a
better state. I think we can do more here, but I decided to stop before
this series got even longer. Based on the reception of this series, I
will follow up with more cleanups.

Also, we could squash some of the commits together. But I found them
easier to read through this way.

---
Changes in v2:
- Rebased on top master: 1891de46f7 (Sync with Git 2.56.1, 2026-11-09)
- Merged in and resolved conflicts from the topics in next:
  - cc/early-scan-options
  - tj/drop-no-parseopt
- Did some small cleanups
- Link to v1: https://patch.msgid.link/20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com

---
Karthik Nayak (20):
      t9300: move 'fastimport.unpackLimit' to the required test
      t9300: make the series B tests self-contained
      t9300: make the series T tests self-contained
      t9300: make the series S tests self-contained
      t9300: make the series V tests self-contained
      t9300: make the series Q tests self-contained
      t9300: make the series P tests self-contained
      t9300: make the series O tests self-contained
      t9300: make the big blob tests self-contained
      t9300: make the ref update tests self-contained
      t9300: make the date format tests self-contained
      t9300: make the pack edges test self-contained
      t9300: make the marks tests self-contained
      t9300: make the series Y tests self-contained
      t9300: make the cat-blob tests self-contained
      t9300: make the feature and option tests self-contained
      t9300: make the stream tests self-contained
      t9300: make the get-mark and encoding tests self-contained
      t9300: move self-contained tests into dedicated files
      t93xx: drop the series letter from the moved test names

 t/meson.build                     |    5 +
 t/t9300-fast-import.sh            | 2884 +------------------------------------
 t/t9301-fast-import-notes.sh      |  400 +++++
 t/t9304-fast-import-marks.sh      |  393 +++++
 t/t9307-fast-import-validation.sh | 1262 ++++++++++++++++
 t/t9308-fast-import-stream.sh     |  890 ++++++++++++
 t/t9309-fast-import-checkpoint.sh |  188 +++
 t/t9310-fast-import-submodule.sh  |  385 +++++
 t/t9311-fast-import-refs.sh       |  194 +++
 9 files changed, 3718 insertions(+), 2883 deletions(-)

Range-diff versus v1:

 1:  45b5b440f4 =  1:  e3f2bfcc69 t9300: move 'fastimport.unpackLimit' to the required test
 2:  130034d57d =  2:  649260b54d t9300: make the series B tests self-contained
 3:  9fe75bdaf2 =  3:  7b134f184d t9300: make the series T tests self-contained
 4:  a9c1bd2483 !  4:  b401701e1e t9300: make the series S tests self-contained
    @@ Commit message
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## t/t9300-fast-import.sh ##
    -@@ t/t9300-fast-import.sh: test_expect_success 'R: blob appears only once' '
    +@@ t/t9300-fast-import.sh: test_expect_success 'R: --git-completion-helper-all does not read from stdin' '
      #
      #   invalid dataref ..
      #
 5:  a8b7bf3aa4 =  5:  18ffcfcfd9 t9300: make the series V tests self-contained
 6:  73f94d5790 !  6:  b81ec42557 t9300: make the series Q tests self-contained
    @@ Commit message
         commit notes', and use shell variables set by the preceding tests.
         Replace 'Q: commit notes' with a 'setup_notes_repo()' function, which
         creates a new repository, runs the import and sets those variables, so
    -    each test can invoke it. Run the import with 'fastimport.unpackLimit'
    -    set to 0, so that a pack is written for 'Q: verify pack' to check.
    +    each test can invoke it.
     
    -    Also stop using the 'verify_packs()' function, to make it easier to move
    -    these tests to another file.
    +    Drop 'Q: verify pack', as other tests already verify the packs written
    +    by fast-import.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ t/t9300-fast-import.sh: test_expect_success 'Q: commit notes' '
     -	git fast-import <input &&
     -	git log --raw notes-test
     -'
    -+	git -C repo -c fastimport.unpackLimit=0 fast-import <repo/input &&
    +-
    +-test_expect_success 'Q: verify pack' '
    +-	verify_packs
    +-'
    ++	git -C repo fast-import <repo/input &&
     +	commit1=$(git -C repo rev-parse notes-test~2) &&
     +	commit2=$(git -C repo rev-parse notes-test^) &&
     +	commit3=$(git -C repo rev-parse notes-test)
     +}
      
    - test_expect_success 'Q: verify pack' '
    --	verify_packs
    -+	setup_notes_repo &&
    -+	(
    -+		cd repo &&
    -+		for p in .git/objects/pack/*.pack
    -+		do
    -+			git verify-pack "$p" || return 1
    -+		done
    -+	)
    - '
    - 
      test_expect_success 'Q: verify first commit' '
     -	commit1=$(git rev-parse notes-test~2) &&
     -	commit2=$(git rev-parse notes-test^) &&
 7:  65951bf97e =  7:  4265ae48a9 t9300: make the series P tests self-contained
 8:  8c277ecdfe =  8:  19b4d8b559 t9300: make the series O tests self-contained
 9:  2e1f122a03 !  9:  3af6c83f5c t9300: make the big blob tests self-contained
    @@ t/t9300-fast-import.sh: test_expect_success 'R: corrupt lines do not mess marks
     -	test 1 = $n
     -'
     -
    - ###
    - ### series S (mark and path parsing)
    - ###
    + test_expect_success 'R: --git-completion-helper does not read from stdin' '
    + 	find .git/objects/pack -name "tmp_pack_*" >before &&
    + 	echo garbage | git fast-import --git-completion-helper >out &&
10:  178e01d022 ! 10:  6104474191 t9300: make the ref update tests self-contained
    @@ Commit message
         series 'F', 'G', 'J' and 'K' to make them independent of state from
         previous tests. Add a 'setup_two_commit_repo()' function which creates
         a repository with two commits on 'main', so each test can invoke it.
    -    The tests used to build on the 'branch' branch of earlier tests.
     
         Fold the tests which only check the result of an import into the tests
         performing it, as they can't run on their own. As
    @@ t/t9300-fast-import.sh: test_expect_success 'F: verify other commit' '
      '
      
      ###
    -@@ t/t9300-fast-import.sh: test_expect_success 'I: verify edge list' '
    +@@ t/t9300-fast-import.sh: test_expect_success 'I: export-pack-edges via stdin' '
      ###
      
      test_expect_success 'J: reset existing branch creates empty commit' '
11:  d94431d13c = 11:  6c1b12057c t9300: make the date format tests self-contained
12:  44d3602cbc ! 12:  5d1e8cada1 t9300: make the pack edges test self-contained
    @@ Commit message
         Similar to the previous commits, modify the pack-edges tests to make
         them independent of state from previous tests.
     
    -    Fold 'I: verify edge list' into the test creating the edge list, as it
    -    can't run on its own. Pack edges are only recorded for packs which are
    -    kept, so set 'fastimport.unpackLimit' to 0 for the import.
    +    Pack edges are only recorded for packs which are kept, so set
    +    'fastimport.unpackLimit' to 0 for the import.
     
         Create the repository with 'git init -b main', as the import builds on
         'main' and t9302, where this test ends up, doesn't set
    @@ t/t9300-fast-import.sh
     @@ t/t9300-fast-import.sh: test_expect_success 'H: verify file' '
      ###
      
    + test_expect_success 'I: export-pack-edges option forbidden by default' '
    +-	echo "option git export-pack-edges=edges.list" >input &&
    +-	test_must_fail git fast-import <input 2>err &&
    +-	test_grep "option ${SQ}export-pack-edges${SQ} forbidden in input without --allow-unsafe-features" err
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		echo "option git export-pack-edges=edges.list" >input &&
    ++		test_must_fail git fast-import <input 2>err &&
    ++		test_grep "option ${SQ}export-pack-edges${SQ} forbidden in input without --allow-unsafe-features" err
    ++	)
    + '
    + 
      test_expect_success 'I: export-pack-edges' '
    +-	test_when_finished "rm edges.list" &&
     -	cat >input <<-INPUT_END &&
     -	commit refs/heads/export-boundary
     -	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
    @@ t/t9300-fast-import.sh: test_expect_success 'H: verify file' '
     +		COMMIT
      
     -	INPUT_END
    --	git fast-import --export-pack-edges=edges.list <input
    --'
    -+		from refs/heads/main
    - 
    --test_expect_success 'I: verify edge list' '
    +-	git fast-import --export-pack-edges=edges.list <input &&
     -	cat >expect <<-EOF &&
     -	.git/objects/pack/pack-.pack: $(git rev-parse --verify export-boundary)
     -	EOF
     -	sed -e s/pack-.*pack/pack-.pack/ edges.list >actual &&
     -	test_cmp expect actual
    ++		from refs/heads/main
    ++
     +		INPUT_END
     +		git -c fastimport.unpackLimit=0 fast-import \
     +			--export-pack-edges=edges.list <input &&
    @@ t/t9300-fast-import.sh: test_expect_success 'H: verify file' '
     +	)
      '
      
    + test_expect_success 'I: export-pack-edges via stdin' '
    +-	test_when_finished "rm edges.list" &&
    +-	cat >input <<-INPUT_END &&
    +-	option git export-pack-edges=edges.list
    +-	commit refs/heads/export-boundary-2
    +-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
    +-	data <<COMMIT
    +-	one more similar commit
    +-	COMMIT
    ++	test_when_finished "rm -rf repo" &&
    ++	git init -b main repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit one &&
    + 
    +-	from refs/heads/branch
    ++		cat >input <<-INPUT_END &&
    ++		option git export-pack-edges=edges.list
    ++		commit refs/heads/export-boundary
    ++		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
    ++		data <<COMMIT
    ++		one more similar commit
    ++		COMMIT
    + 
    +-	INPUT_END
    +-	git fast-import --allow-unsafe-features <input &&
    +-	cat >expect <<-EOF &&
    +-	.git/objects/pack/pack-.pack: $(git rev-parse --verify export-boundary-2)
    +-	EOF
    +-	sed -e s/pack-.*pack/pack-.pack/ edges.list >actual &&
    +-	test_cmp expect actual
    ++		from refs/heads/main
    ++
    ++		INPUT_END
    ++
    ++		git -c fastimport.unpackLimit=0 fast-import \
    ++			--allow-unsafe-features <input &&
    ++		cat >expect <<-EOF &&
    ++		.git/objects/pack/pack-.pack: $(git rev-parse --verify export-boundary)
    ++		EOF
    ++		sed -e s/pack-.*pack/pack-.pack/ edges.list >actual &&
    ++		test_cmp expect actual
    ++	)
    + '
    + 
      ###
13:  54f456a8b3 ! 13:  80552f9997 t9300: make the marks tests self-contained
    @@ t/t9300-fast-import.sh: test_expect_success 'R: export-marks feature forbidden b
     +	)
      '
      
    + test_expect_success 'R: --allow-unsafe-features found after a value' '
    +@@ t/t9300-fast-import.sh: test_expect_success 'R: --allow-unsafe-features after a non-option' '
    + '
    + 
      test_expect_success 'R: catch typo in marks file name' '
     -	test_must_fail git fast-import --import-marks=nonexistent.marks </dev/null &&
     -	echo "feature import-marks=nonexistent.marks" |
14:  19b51b871b <  -:  ---------- t9300: make the series Y tests self-contained
 -:  ---------- > 14:  7d3e0b60f1 t9300: make the series Y tests self-contained
15:  dd62943ca0 ! 15:  935ae34fbf t9300: make the cat-blob tests self-contained
    @@ Metadata
      ## Commit message ##
         t9300: make the cat-blob tests self-contained
     
    -    The 'R: print' tests and 'R: copy using cat-file' write blobs into the
    -    repository of the trash directory, which all other tests share. 'R:
    -    print two blobs to stdout' and 'R: copy using cat-file' also read the
    -    'big' file written by the preceding 'setup: big file' test, so they
    -    can't run on their own.
    -
    -    Run each of these tests in a new repository. Convert the setup test to a
    -    'setup_big_file()' function, which writes the file in the repository of
    -    the calling test, and invoke it from both tests.
    +    Similar to the previous commits, modify the cat-blog tests to make
    +    them independent of state from previous tests.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
16:  25609c8979 ! 16:  405057430f t9300: make the feature and option tests self-contained
    @@ t/t9300-fast-import.sh: test_expect_success 'Q: deny note on empty branch' '
      '
      
      test_expect_success 'R: export-marks feature results in a marks file being created' '
    +@@ t/t9300-fast-import.sh: test_expect_success 'R: export-marks options can be overridden by commandline op
    + '
    + 
    + test_expect_success 'R: --allow-unsafe-features found after a value' '
    +-	echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    +-	git fast-import --allow-unsafe-features <input &&
    +-	git fast-import --depth=5 --allow-unsafe-features <input &&
    +-	git fast-import --depth 5 --allow-unsafe-features <input &&
    +-	git fast-import --date-format raw --allow-unsafe-features <input
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    ++		git fast-import --allow-unsafe-features <input &&
    ++		git fast-import --depth=5 --allow-unsafe-features <input &&
    ++		git fast-import --depth 5 --allow-unsafe-features <input &&
    ++		git fast-import --date-format raw --allow-unsafe-features <input
    ++	)
    + '
    + 
    + test_expect_success 'R: --allow-unsafe-features can be abbreviated' '
    +-	echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    +-	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
    +-	git fast-import --allow-unsafe <input
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    ++		GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
    ++		git fast-import --allow-unsafe <input
    ++	)
    + '
    + 
    + test_expect_success 'R: disallowed abbreviation of --allow-unsafe-features' '
    +-	echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    +-	test_must_fail env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true \
    +-		git fast-import --allow-unsafe <input 2>err &&
    +-	test_grep "forbidden in input without --allow-unsafe-features" err
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    ++		test_must_fail env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true \
    ++			git fast-import --allow-unsafe <input 2>err &&
    ++		test_grep "forbidden in input without --allow-unsafe-features" err
    ++	)
    + '
    + 
    + test_expect_success 'R: --allow-unsafe-features as the value of an abbreviation' '
    +-	echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    +-	test_must_fail env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
    +-		git fast-import --quiet --export-pack \
    +-		--allow-unsafe-features <input 2>err &&
    +-	test_grep "forbidden in input without --allow-unsafe-features" err
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    ++		test_must_fail env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
    ++			git fast-import --quiet --export-pack \
    ++			--allow-unsafe-features <input 2>err &&
    ++		test_grep "forbidden in input without --allow-unsafe-features" err
    ++	)
    + '
    + 
    + test_expect_success 'R: --allow-unsafe-features after a non-option' '
    +-	echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    +-	test_must_fail git fast-import --depth 5 extra \
    +-		--allow-unsafe-features <input 2>err &&
    +-	test_grep "forbidden in input without --allow-unsafe-features" err
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    ++		test_must_fail git fast-import --depth 5 extra \
    ++			--allow-unsafe-features <input 2>err &&
    ++		test_grep "forbidden in input without --allow-unsafe-features" err
    ++	)
    + '
    + 
    + test_expect_success 'R: catch typo in marks file name' '
     @@ t/t9300-fast-import.sh: test_expect_success 'R: feature no-relative-marks should be honoured' '
      
      
17:  7573e1381d ! 17:  bafacc9dd4 t9300: make the stream tests self-contained
    @@ t/t9300-fast-import.sh: test_expect_success PIPE 'R: print staged blob within co
      '
      
      test_expect_success 'R: die on unknown option' '
    +@@ t/t9300-fast-import.sh: test_expect_success 'R: blob bigger than threshold' '
    + '
    + 
    + test_expect_success 'R: --git-completion-helper does not read from stdin' '
    +-	find .git/objects/pack -name "tmp_pack_*" >before &&
    +-	echo garbage | git fast-import --git-completion-helper >out &&
    +-	test_grep -e "--date-format=" out &&
    +-	find .git/objects/pack -name "tmp_pack_*" >after &&
    +-	test_cmp before after
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		find .git/objects/pack -name "tmp_pack_*" >before &&
    ++		echo garbage | git fast-import --git-completion-helper >out &&
    ++		test_grep -e "--date-format=" out &&
    ++		find .git/objects/pack -name "tmp_pack_*" >after &&
    ++		test_cmp before after
    ++	)
    + '
    + 
    + test_expect_success 'R: --git-completion-helper-all does not read from stdin' '
    +-	find .git/objects/pack -name "tmp_pack_*" >before &&
    +-	echo garbage | git fast-import --git-completion-helper-all >all &&
    +-	test_grep -e "--allow-unsafe-features" all &&
    +-	find .git/objects/pack -name "tmp_pack_*" >after &&
    +-	test_cmp before after
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		find .git/objects/pack -name "tmp_pack_*" >before &&
    ++		echo garbage | git fast-import --git-completion-helper-all >all &&
    ++		test_grep -e "--allow-unsafe-features" all &&
    ++		find .git/objects/pack -name "tmp_pack_*" >after &&
    ++		test_cmp before after
    ++	)
    + '
    + 
    + ###
18:  fb94ca9bc4 = 18:  100ad72f13 t9300: make the get-mark and encoding tests self-contained
19:  29df1daba9 ! 19:  f3c7d85bd9 t9300: move self-contained tests into dedicated files
    @@ t/t9300-fast-import.sh: test_expect_success 'H: verify file' '
     -### series I
     -###
     -
    +-test_expect_success 'I: export-pack-edges option forbidden by default' '
    +-	test_when_finished "rm -rf repo" &&
    +-	git init repo &&
    +-	(
    +-		cd repo &&
    +-		echo "option git export-pack-edges=edges.list" >input &&
    +-		test_must_fail git fast-import <input 2>err &&
    +-		test_grep "option ${SQ}export-pack-edges${SQ} forbidden in input without --allow-unsafe-features" err
    +-	)
    +-'
    +-
     -test_expect_success 'I: export-pack-edges' '
     -	test_when_finished "rm -rf repo" &&
     -	git init -b main repo &&
    @@ t/t9300-fast-import.sh: test_expect_success 'H: verify file' '
     -	)
     -'
     -
    +-test_expect_success 'I: export-pack-edges via stdin' '
    +-	test_when_finished "rm -rf repo" &&
    +-	git init -b main repo &&
    +-	(
    +-		cd repo &&
    +-		test_commit one &&
    +-
    +-		cat >input <<-INPUT_END &&
    +-		option git export-pack-edges=edges.list
    +-		commit refs/heads/export-boundary
    +-		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
    +-		data <<COMMIT
    +-		one more similar commit
    +-		COMMIT
    +-
    +-		from refs/heads/main
    +-
    +-		INPUT_END
    +-
    +-		git -c fastimport.unpackLimit=0 fast-import \
    +-			--allow-unsafe-features <input &&
    +-		cat >expect <<-EOF &&
    +-		.git/objects/pack/pack-.pack: $(git rev-parse --verify export-boundary)
    +-		EOF
    +-		sed -e s/pack-.*pack/pack-.pack/ edges.list >actual &&
    +-		test_cmp expect actual
    +-	)
    +-'
    +-
     -###
     -### series J
     -###
    @@ t/t9300-fast-import.sh: do
     -###
     -### series O
     -###
    --
    + 
     -setup_import_repo () {
     -	test_when_finished "rm -rf repo" &&
     -	git init repo &&
    @@ t/t9300-fast-import.sh: do
     -
     -	INPUT_END
     -
    --	git -C repo -c fastimport.unpackLimit=0 fast-import <repo/input &&
    +-	git -C repo fast-import <repo/input &&
     -	commit1=$(git -C repo rev-parse notes-test~2) &&
     -	commit2=$(git -C repo rev-parse notes-test^) &&
     -	commit3=$(git -C repo rev-parse notes-test)
     -}
     -
    --test_expect_success 'Q: verify pack' '
    --	setup_notes_repo &&
    --	(
    --		cd repo &&
    --		for p in .git/objects/pack/*.pack
    --		do
    --			git verify-pack "$p" || return 1
    --		done
    --	)
    --'
    --
     -test_expect_success 'Q: verify first commit' '
     -	setup_notes_repo &&
     -	(
    @@ t/t9300-fast-import.sh: do
     -	)
     -'
     -
    +-test_expect_success 'R: --allow-unsafe-features found after a value' '
    +-	test_when_finished "rm -rf repo" &&
    +-	git init repo &&
    +-	(
    +-		cd repo &&
    +-
    +-		echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    +-		git fast-import --allow-unsafe-features <input &&
    +-		git fast-import --depth=5 --allow-unsafe-features <input &&
    +-		git fast-import --depth 5 --allow-unsafe-features <input &&
    +-		git fast-import --date-format raw --allow-unsafe-features <input
    +-	)
    +-'
    +-
    +-test_expect_success 'R: --allow-unsafe-features can be abbreviated' '
    +-	test_when_finished "rm -rf repo" &&
    +-	git init repo &&
    +-	(
    +-		cd repo &&
    +-
    +-		echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    +-		GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
    +-		git fast-import --allow-unsafe <input
    +-	)
    +-'
    +-
    +-test_expect_success 'R: disallowed abbreviation of --allow-unsafe-features' '
    +-	test_when_finished "rm -rf repo" &&
    +-	git init repo &&
    +-	(
    +-		cd repo &&
    +-
    +-		echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    +-		test_must_fail env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true \
    +-			git fast-import --allow-unsafe <input 2>err &&
    +-		test_grep "forbidden in input without --allow-unsafe-features" err
    +-	)
    +-'
    +-
    +-test_expect_success 'R: --allow-unsafe-features as the value of an abbreviation' '
    +-	test_when_finished "rm -rf repo" &&
    +-	git init repo &&
    +-	(
    +-		cd repo &&
    +-
    +-		echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    +-		test_must_fail env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
    +-			git fast-import --quiet --export-pack \
    +-			--allow-unsafe-features <input 2>err &&
    +-		test_grep "forbidden in input without --allow-unsafe-features" err
    +-	)
    +-'
    +-
    +-test_expect_success 'R: --allow-unsafe-features after a non-option' '
    +-	test_when_finished "rm -rf repo" &&
    +-	git init repo &&
    +-	(
    +-		cd repo &&
    +-
    +-		echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    +-		test_must_fail git fast-import --depth 5 extra \
    +-			--allow-unsafe-features <input 2>err &&
    +-		test_grep "forbidden in input without --allow-unsafe-features" err
    +-	)
    +-'
    +-
     -test_expect_success 'R: catch typo in marks file name' '
     -	test_when_finished "rm -rf repo" &&
     -	git init repo &&
    @@ t/t9300-fast-import.sh: do
     -	)
     -'
     -
    +-test_expect_success 'R: --git-completion-helper does not read from stdin' '
    +-	test_when_finished "rm -rf repo" &&
    +-	git init repo &&
    +-	(
    +-		cd repo &&
    +-
    +-		find .git/objects/pack -name "tmp_pack_*" >before &&
    +-		echo garbage | git fast-import --git-completion-helper >out &&
    +-		test_grep -e "--date-format=" out &&
    +-		find .git/objects/pack -name "tmp_pack_*" >after &&
    +-		test_cmp before after
    +-	)
    +-'
    +-
    +-test_expect_success 'R: --git-completion-helper-all does not read from stdin' '
    +-	test_when_finished "rm -rf repo" &&
    +-	git init repo &&
    +-	(
    +-		cd repo &&
    +-
    +-		find .git/objects/pack -name "tmp_pack_*" >before &&
    +-		echo garbage | git fast-import --git-completion-helper-all >all &&
    +-		test_grep -e "--allow-unsafe-features" all &&
    +-		find .git/objects/pack -name "tmp_pack_*" >after &&
    +-		test_cmp before after
    +-	)
    +-'
    +-
     -###
     -### series S (mark and path parsing)
     -###
    @@ t/t9300-fast-import.sh: do
     -		git rev-parse --verify refs/heads/not-to-delete
     -	)
     -'
    --
    + 
      ###
      ### series U (filedelete)
    - ###
     @@ t/t9300-fast-import.sh: do
      	'
      done
    @@ t/t9300-fast-import.sh: do
     -:4 ff729f5e62f72c0c3978207d9a80e5f3a65f14d7
     -Y_INPUT_END
     -
    +-test_expect_success 'Y: rewrite-submodules-to feature forbidden by default' '
    +-	test_when_finished "rm -rf repo" &&
    +-	git init repo &&
    +-	(
    +-		cd repo &&
    +-		echo "feature rewrite-submodules-to=sub:sub2-marks" >input &&
    +-		test_must_fail git fast-import <input 2>err &&
    +-		test_grep "feature ${SQ}rewrite-submodules-to${SQ} forbidden in input without --allow-unsafe-features" err
    +-	)
    +-'
    +-
    +-test_expect_success 'Y: rewrite-submodules-from feature forbidden by default' '
    +-	test_when_finished "rm -rf repo" &&
    +-	git init repo &&
    +-	(
    +-		cd repo &&
    +-		echo "feature rewrite-submodules-from=sub:../Y-marks" >input &&
    +-		test_must_fail git fast-import <input 2>err &&
    +-		test_grep "feature ${SQ}rewrite-submodules-from${SQ} forbidden in input without --allow-unsafe-features" err
    +-	)
    +-'
    +-
     -test_expect_success 'Y: rewrite submodules' '
     -	test_when_finished "rm -rf main1" &&
     -	test_oid_cache <<-EOF &&
     -	Ymain sha1:9afed2f9161ddf416c0a1863b8b0725b00070504
     -	Ymain sha256:c0a1010da1df187b2e287654793df01b464bd6f8e3f17fc1481a7dadf84caee3
     -	EOF
    +-
     -	git init main1 &&
     -	(
     -		cd main1 &&
    @@ t/t9300-fast-import.sh: do
     -		EOF
     -	)
     -'
    +-
    +-test_expect_success 'Y: rewrite submodules via stdin' '
    +-	test_when_finished "rm -rf main1" &&
    +-	test_oid_cache <<-EOF &&
    +-	Ymain sha1:9afed2f9161ddf416c0a1863b8b0725b00070504
    +-	Ymain sha256:c0a1010da1df187b2e287654793df01b464bd6f8e3f17fc1481a7dadf84caee3
    +-	EOF
    +-
    +-	git init main1 &&
    +-	(
    +-		cd main1 &&
    +-		git init sub2 &&
    +-		git -C sub2 fast-import --export-marks=../sub2-marks <../Y-sub-input &&
    +-		{
    +-			echo "feature rewrite-submodules-to=sub:sub2-marks" &&
    +-			echo "feature rewrite-submodules-from=sub:../Y-marks" &&
    +-			cat ../Y-main-input
    +-		} | git fast-import --allow-unsafe-features &&
    +-		test "$(git rev-parse main)" = "$(test_oid Ymain)"
    +-	)
    +-'
     -
      test_done
     
    @@ t/t9301-fast-import-notes.sh: test_expect_success "add notes to $num_commits com
     +
     +	INPUT_END
     +
    -+	git -C repo -c fastimport.unpackLimit=0 fast-import <repo/input &&
    ++	git -C repo fast-import <repo/input &&
     +	commit1=$(git -C repo rev-parse notes-test~2) &&
     +	commit2=$(git -C repo rev-parse notes-test^) &&
     +	commit3=$(git -C repo rev-parse notes-test)
     +}
     +
    -+test_expect_success 'Q: verify pack' '
    -+	setup_notes_repo &&
    -+	(
    -+		cd repo &&
    -+		for p in .git/objects/pack/*.pack
    -+		do
    -+			git verify-pack "$p" || return 1
    -+		done
    -+	)
    -+'
    -+
     +test_expect_success 'Q: verify first commit' '
     +	setup_notes_repo &&
     +	(
    @@ t/t9307-fast-import-validation.sh (new)
     +	)
     +'
     +
    ++###
    ++### series S (mark and path parsing)
    ++###
     +#
     +# Make sure missing spaces and EOLs after mark references
     +# cause errors.
    @@ t/t9307-fast-import-validation.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'R: --allow-unsafe-features found after a value' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    ++		git fast-import --allow-unsafe-features <input &&
    ++		git fast-import --depth=5 --allow-unsafe-features <input &&
    ++		git fast-import --depth 5 --allow-unsafe-features <input &&
    ++		git fast-import --date-format raw --allow-unsafe-features <input
    ++	)
    ++'
    ++
    ++test_expect_success 'R: --allow-unsafe-features can be abbreviated' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    ++		GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
    ++		git fast-import --allow-unsafe <input
    ++	)
    ++'
    ++
    ++test_expect_success 'R: disallowed abbreviation of --allow-unsafe-features' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    ++		test_must_fail env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true \
    ++			git fast-import --allow-unsafe <input 2>err &&
    ++		test_grep "forbidden in input without --allow-unsafe-features" err
    ++	)
    ++'
    ++
    ++test_expect_success 'R: --allow-unsafe-features as the value of an abbreviation' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    ++		test_must_fail env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
    ++			git fast-import --quiet --export-pack \
    ++			--allow-unsafe-features <input 2>err &&
    ++		test_grep "forbidden in input without --allow-unsafe-features" err
    ++	)
    ++'
    ++
    ++test_expect_success 'R: --allow-unsafe-features after a non-option' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    ++		test_must_fail git fast-import --depth 5 extra \
    ++			--allow-unsafe-features <input 2>err &&
    ++		test_grep "forbidden in input without --allow-unsafe-features" err
    ++	)
    ++'
    ++
     +test_done
     
      ## t/t9308-fast-import-stream.sh (new) ##
    @@ t/t9308-fast-import-stream.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'I: export-pack-edges option forbidden by default' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		echo "option git export-pack-edges=edges.list" >input &&
    ++		test_must_fail git fast-import <input 2>err &&
    ++		test_grep "option ${SQ}export-pack-edges${SQ} forbidden in input without --allow-unsafe-features" err
    ++	)
    ++'
    ++
    ++test_expect_success 'I: export-pack-edges via stdin' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init -b main repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit one &&
    ++
    ++		cat >input <<-INPUT_END &&
    ++		option git export-pack-edges=edges.list
    ++		commit refs/heads/export-boundary
    ++		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
    ++		data <<COMMIT
    ++		one more similar commit
    ++		COMMIT
    ++
    ++		from refs/heads/main
    ++
    ++		INPUT_END
    ++
    ++		git -c fastimport.unpackLimit=0 fast-import \
    ++			--allow-unsafe-features <input &&
    ++		cat >expect <<-EOF &&
    ++		.git/objects/pack/pack-.pack: $(git rev-parse --verify export-boundary)
    ++		EOF
    ++		sed -e s/pack-.*pack/pack-.pack/ edges.list >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
    ++test_expect_success 'R: --git-completion-helper does not read from stdin' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		find .git/objects/pack -name "tmp_pack_*" >before &&
    ++		echo garbage | git fast-import --git-completion-helper >out &&
    ++		test_grep -e "--date-format=" out &&
    ++		find .git/objects/pack -name "tmp_pack_*" >after &&
    ++		test_cmp before after
    ++	)
    ++'
    ++
    ++test_expect_success 'R: --git-completion-helper-all does not read from stdin' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		find .git/objects/pack -name "tmp_pack_*" >before &&
    ++		echo garbage | git fast-import --git-completion-helper-all >all &&
    ++		test_grep -e "--allow-unsafe-features" all &&
    ++		find .git/objects/pack -name "tmp_pack_*" >after &&
    ++		test_cmp before after
    ++	)
    ++'
    ++
     +test_done
     
      ## t/t9309-fast-import-checkpoint.sh (new) ##
    @@ t/t9310-fast-import-submodule.sh (new)
     +	Ymain sha1:9afed2f9161ddf416c0a1863b8b0725b00070504
     +	Ymain sha256:c0a1010da1df187b2e287654793df01b464bd6f8e3f17fc1481a7dadf84caee3
     +	EOF
    ++
     +	git init main1 &&
     +	(
     +		cd main1 &&
    @@ t/t9310-fast-import-submodule.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'Y: rewrite-submodules-to feature forbidden by default' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		echo "feature rewrite-submodules-to=sub:sub2-marks" >input &&
    ++		test_must_fail git fast-import <input 2>err &&
    ++		test_grep "feature ${SQ}rewrite-submodules-to${SQ} forbidden in input without --allow-unsafe-features" err
    ++	)
    ++'
    ++
    ++test_expect_success 'Y: rewrite-submodules-from feature forbidden by default' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		echo "feature rewrite-submodules-from=sub:../Y-marks" >input &&
    ++		test_must_fail git fast-import <input 2>err &&
    ++		test_grep "feature ${SQ}rewrite-submodules-from${SQ} forbidden in input without --allow-unsafe-features" err
    ++	)
    ++'
    ++
    ++test_expect_success 'Y: rewrite submodules via stdin' '
    ++	test_when_finished "rm -rf main1" &&
    ++	test_oid_cache <<-EOF &&
    ++	Ymain sha1:9afed2f9161ddf416c0a1863b8b0725b00070504
    ++	Ymain sha256:c0a1010da1df187b2e287654793df01b464bd6f8e3f17fc1481a7dadf84caee3
    ++	EOF
    ++
    ++	git init main1 &&
    ++	(
    ++		cd main1 &&
    ++		git init sub2 &&
    ++		git -C sub2 fast-import --export-marks=../sub2-marks <../Y-sub-input &&
    ++		{
    ++			echo "feature rewrite-submodules-to=sub:sub2-marks" &&
    ++			echo "feature rewrite-submodules-from=sub:../Y-marks" &&
    ++			cat ../Y-main-input
    ++		} | git fast-import --allow-unsafe-features &&
    ++		test "$(git rev-parse main)" = "$(test_oid Ymain)"
    ++	)
    ++'
    ++
     +test_done
     
      ## t/t9311-fast-import-refs.sh (new) ##
20:  80524815fd ! 20:  26f81a22b7 t93xx: drop the series letter from the moved test names
    @@ t/t9301-fast-import-notes.sh: echo \"\$@\"" &&
      	commit3=$(git -C repo rev-parse notes-test)
      }
      
    --test_expect_success 'Q: verify pack' '
    -+test_expect_success 'verify pack' '
    - 	setup_notes_repo &&
    - 	(
    - 		cd repo &&
    -@@ t/t9301-fast-import-notes.sh: test_expect_success 'Q: verify pack' '
    - 	)
    - '
    - 
     -test_expect_success 'Q: verify first commit' '
     +test_expect_success 'verify first commit' '
      	setup_notes_repo &&
    @@ t/t9307-fast-import-validation.sh: test_expect_success 'E: rfc2822 date, --date-
      	test_when_finished "rm -rf repo" &&
      	git init repo &&
      	(
    +@@ t/t9307-fast-import-validation.sh: test_expect_success 'E: rfc2822 date, --date-format=rfc2822' '
    + 	)
    + '
    + 
    +-test_expect_success 'R: --allow-unsafe-features found after a value' '
    ++test_expect_success '--allow-unsafe-features found after a value' '
    + 	test_when_finished "rm -rf repo" &&
    + 	git init repo &&
    + 	(
    +@@ t/t9307-fast-import-validation.sh: test_expect_success 'R: --allow-unsafe-features found after a value' '
    + 	)
    + '
    + 
    +-test_expect_success 'R: --allow-unsafe-features can be abbreviated' '
    ++test_expect_success '--allow-unsafe-features can be abbreviated' '
    + 	test_when_finished "rm -rf repo" &&
    + 	git init repo &&
    + 	(
    +@@ t/t9307-fast-import-validation.sh: test_expect_success 'R: --allow-unsafe-features can be abbreviated' '
    + 	)
    + '
    + 
    +-test_expect_success 'R: disallowed abbreviation of --allow-unsafe-features' '
    ++test_expect_success 'disallowed abbreviation of --allow-unsafe-features' '
    + 	test_when_finished "rm -rf repo" &&
    + 	git init repo &&
    + 	(
    +@@ t/t9307-fast-import-validation.sh: test_expect_success 'R: disallowed abbreviation of --allow-unsafe-features' '
    + 	)
    + '
    + 
    +-test_expect_success 'R: --allow-unsafe-features as the value of an abbreviation' '
    ++test_expect_success '--allow-unsafe-features as the value of an abbreviation' '
    + 	test_when_finished "rm -rf repo" &&
    + 	git init repo &&
    + 	(
    +@@ t/t9307-fast-import-validation.sh: test_expect_success 'R: --allow-unsafe-features as the value of an abbreviation'
    + 	)
    + '
    + 
    +-test_expect_success 'R: --allow-unsafe-features after a non-option' '
    ++test_expect_success '--allow-unsafe-features after a non-option' '
    + 	test_when_finished "rm -rf repo" &&
    + 	git init repo &&
    + 	(
     
      ## t/t9308-fast-import-stream.sh ##
     @@ t/t9308-fast-import-stream.sh: test_expect_success 'truncated stream complains' '
    @@ t/t9308-fast-import-stream.sh: do
      	test_when_finished "rm -rf repo" &&
      	git init -b main repo &&
      	(
    +@@ t/t9308-fast-import-stream.sh: test_expect_success 'I: export-pack-edges' '
    + 	)
    + '
    + 
    +-test_expect_success 'I: export-pack-edges option forbidden by default' '
    ++test_expect_success 'export-pack-edges option forbidden by default' '
    + 	test_when_finished "rm -rf repo" &&
    + 	git init repo &&
    + 	(
    +@@ t/t9308-fast-import-stream.sh: test_expect_success 'I: export-pack-edges option forbidden by default' '
    + 	)
    + '
    + 
    +-test_expect_success 'I: export-pack-edges via stdin' '
    ++test_expect_success 'export-pack-edges via stdin' '
    + 	test_when_finished "rm -rf repo" &&
    + 	git init -b main repo &&
    + 	(
    +@@ t/t9308-fast-import-stream.sh: test_expect_success 'I: export-pack-edges via stdin' '
    + 	)
    + '
    + 
    +-test_expect_success 'R: --git-completion-helper does not read from stdin' '
    ++test_expect_success '--git-completion-helper does not read from stdin' '
    + 	test_when_finished "rm -rf repo" &&
    + 	git init repo &&
    + 	(
    +@@ t/t9308-fast-import-stream.sh: test_expect_success 'R: --git-completion-helper does not read from stdin' '
    + 	)
    + '
    + 
    +-test_expect_success 'R: --git-completion-helper-all does not read from stdin' '
    ++test_expect_success '--git-completion-helper-all does not read from stdin' '
    + 	test_when_finished "rm -rf repo" &&
    + 	git init repo &&
    + 	(
     
      ## t/t9309-fast-import-checkpoint.sh ##
     @@ t/t9309-fast-import-checkpoint.sh: setup_checkpoint_repo () {
    @@ t/t9310-fast-import-submodule.sh: test_expect_success 'Y: rewrite submodules' '
      	test_oid_cache <<-EOF &&
      	pending_commit sha1:85b46dd918355ff17b4109ec738723d42f235a04
      	pending_commit sha256:17e650f097a4db6fe069c96935360d3ccc9b35c4018728c5f311a4217c2ced3d
    +@@ t/t9310-fast-import-submodule.sh: test_expect_success 'Y: reference pending tag or commit' '
    + 	)
    + '
    + 
    +-test_expect_success 'Y: rewrite-submodules-to feature forbidden by default' '
    ++test_expect_success 'rewrite-submodules-to feature forbidden by default' '
    + 	test_when_finished "rm -rf repo" &&
    + 	git init repo &&
    + 	(
    +@@ t/t9310-fast-import-submodule.sh: test_expect_success 'Y: rewrite-submodules-to feature forbidden by default' '
    + 	)
    + '
    + 
    +-test_expect_success 'Y: rewrite-submodules-from feature forbidden by default' '
    ++test_expect_success 'rewrite-submodules-from feature forbidden by default' '
    + 	test_when_finished "rm -rf repo" &&
    + 	git init repo &&
    + 	(
    +@@ t/t9310-fast-import-submodule.sh: test_expect_success 'Y: rewrite-submodules-from feature forbidden by default' '
    + 	)
    + '
    + 
    +-test_expect_success 'Y: rewrite submodules via stdin' '
    ++test_expect_success 'rewrite submodules via stdin' '
    + 	test_when_finished "rm -rf main1" &&
    + 	test_oid_cache <<-EOF &&
    + 	Ymain sha1:9afed2f9161ddf416c0a1863b8b0725b00070504
     
      ## t/t9311-fast-import-refs.sh ##
     @@ t/t9311-fast-import-refs.sh: setup_two_commit_repo () {

---
base-commit: faeb455a72c105b44c92ebedae5e771bad5bc853
change-id: 20261102-kn-fast-import-tests-1-03de57101c3b


Thanks
- Karthik

