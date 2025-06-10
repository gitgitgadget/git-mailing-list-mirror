Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABB81EE7D5
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 19:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749585165; cv=none; b=j+8KVfUVtQphbMiUa3EfWbu3iFNVfsA6r97uurpCAeZ+OPqh3EX1os7EX/LHMYhkMV/4f3MJmbupSBUyDK4B9ZJ4cztF6Tz4oiKgnIrTw487Pk/vLdiksKepEse3jemm22OSi7Tv3MSdJGpYsKEhqJC3RZWDcOoZkD/d120pPMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749585165; c=relaxed/simple;
	bh=6dLezC2UYyDBee1isjnCD5o+ZyaqH/DAO+866fr5n4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chUhOQpfRNo6b2ak+Nn5DuHaTMdnvPVp5D54WmxKa/vengWMAQ0/m8uIqOsh+kyA9LGLXf17AKRDRB7jkDs1Wq7I2Xb21/buk1G+eBw0TbzDeqO9tOTl3o5EWUnIURvYavX/uTSDbPcRx7ErxGv8++9p1e9EkJH8JILaEXn/cag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaKbSja+; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaKbSja+"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60497d07279so11834832a12.3
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 12:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749585162; x=1750189962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hwZ6zKMJo2hqogBNJqbutfcs84NDZg+6qSB8ZzuVRQE=;
        b=MaKbSja+Gr0Ckta3uAuzKIpsUkaXBPD2uMIIXxcxDUpyBk73n9lY9hrdwaecHF8iTg
         E7sPG5NKzPM6VI+wQFjRbl8E/LCnsqBTmPkXTCHRCk/KTTurI2WWR0Ri+57L1uLot3Q0
         HekJVrEMOa3KuDkkiXjCxhqbigckiig/cqNkuZiO+VRPVlSEALwmhpSxSPQwT/6g5Dkk
         nsEHjSyOKHv7WZIZjZJjQLcVQuPXBzYCEXRlBzNEuY5EVAQF5q4gr6IOp/y0kNhBSm/O
         BMdRbRU66fJFTfZLyTMRCRsnpmW/8HBDleb39HKJFoXUv4hgvfaHVN4E7ubNb35gyIOP
         maMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749585162; x=1750189962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwZ6zKMJo2hqogBNJqbutfcs84NDZg+6qSB8ZzuVRQE=;
        b=AulWvZ/xo15tx8WxMfUEQ3qyS5tqvaTd9vxyeQ6V0H6jHwDHgr6SoGcCQNADL732Q4
         oIcUGKQln4zIVg9vuzEfc3I+dDvx9ZBrjHZRFKixt2sCspOHfrvD+Fq47jeMBJu6El5D
         3DQBAU0ATSOD0WA2x0LVhdJIXYeK4a07uwcg34rPacB7qtqKX4toT+nFtx+cpag9D8PF
         fvZpq3SjVlTztE7C4YfOCmdKrvb07ph541n3e6BvS+wvPT8SrOQ8/JQiIYzAH+y2WlGI
         DMuhawCWMQo/IXDubZrBlMKCzWgDSIoTWSfiP9P9KYZy0npYglFm14g5BUS/KuEBMOQB
         oqDQ==
X-Gm-Message-State: AOJu0YxDrKRi06syWRGsa4CrNpYCxy1x8gauVgwcjg3bVtxGRbfCfFAr
	ToV/2L7lpdjOULNOJlCDctlzBMa4OVvSizrtypTCSGerxibMn9HBKZVq
X-Gm-Gg: ASbGncskTR6WZyEeptZURqnT+2O/fOVw8qj82L5nzxWOBJVbnT2Bjju71cNUM45bYVB
	CYQ2hDNWtRAXB3bq5lgo6Xs3GYvLOSyFhzC4bsodnHrZnv2IO/nl3ZAQ3analmsP3QrsfnlH3nF
	w2TYOhrTX7wCUOJ8CTZ8vF+UHwhS0i2c2hhwdAESB67RC56tBkbudzwuwrTT3RwIhcEnSAKdKOQ
	oeQmH4bzxncakZpB50ZZsNPkmGY0UORuG2cKx+k42D05uioi3lW+upSC1xKpYJQpecvJ5LgW470
	twzqJr9FfLNTjo29Amq64955zVb/HwXsxAZagyfJaw8kXqa3xWwI7OVaEJMg8BxItMSnTnQEJFY
	MZxAWjTFH+KWX2739HFg9a3XK
X-Google-Smtp-Source: AGHT+IFTE66v/7RPvyzGzF8kcWy7yETgy2uuU3lRFvpxpjzK1FLAKibjCsfvA3grMi22hS+GcWh7xA==
X-Received: by 2002:a17:907:3d10:b0:ad8:ac7e:eead with SMTP id a640c23a62f3a-ade8c8eff4emr9352766b.39.1749585161436;
        Tue, 10 Jun 2025 12:52:41 -0700 (PDT)
Received: from localhost (94-21-23-138.pool.digikabel.hu. [94.21.23.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade2c49fd7fsm701494366b.166.2025.06.10.12.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 12:52:40 -0700 (PDT)
Date: Tue, 10 Jun 2025 21:52:39 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 12/20] t: refactor tests depending on Perl to print
 data
Message-ID: <aEiNBwUkjbo2QlFY@szeder.dev>
References: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
 <20250403-b4-pks-t-perlless-v4-12-be20ac3db39a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250403-b4-pks-t-perlless-v4-12-be20ac3db39a@pks.im>

On Thu, Apr 03, 2025 at 07:06:03AM +0200, Patrick Steinhardt wrote:
> A bunch of tests rely on Perl to print data in various different ways.
> These usages fall into the following categories:
> 
>   - Print data conditionally by matching patterns. These usecases can be
>     converted to use awk(1) rather easily.
> 
>   - Print data repeatedly. These usecases can typically be converted to
>     use a combination of `test-tool genzeros` and sed(1).
> 
>   - Print data in reverse. These usecases can be converted to use
>     awk(1) or `sort -r`.
> 
> Refactor the tests accordingly so that we can drop a couple of
> PERL_TEST_HELPERS prerequisites.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index 4794510d70d..2ae93d3c967 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -1073,7 +1073,7 @@ test_expect_success 'am --patch-format=mboxrd handles mboxrd' '
>  	test_cmp msg out
>  '
>  
> -test_expect_success PERL_TEST_HELPERS 'am works with multi-line in-body headers' '
> +test_expect_success 'am works with multi-line in-body headers' '
>  	FORTY="String that has a length of more than forty characters" &&
>  	LONG="$FORTY $FORTY" &&
>  	rm -fr .git/rebase-apply &&
> @@ -1084,13 +1084,13 @@ test_expect_success PERL_TEST_HELPERS 'am works with multi-line in-body headers'
>      Body test" --author="$LONG <long@example.com>" &&
>  	git format-patch --stdout -1 >patch &&
>  	# bump from, date, and subject down to in-body header
> -	perl -lpe "
> -		if (/^From:/) {
> +	awk "
> +		/^From:/{
>  			print \"From: x <x\@example.com>\";
>  			print \"Date: Sat, 1 Jan 2000 00:00:00 +0000\";
>  			print \"Subject: x\n\";
> -		}
> -	" patch >msg &&
> +		}; 1
> +	" <patch >msg &&

With the conversion to awk I get the following warning from gawk:

  awk: cmd. line:3: warning: escape sequence `\@' treated as plain `@'

>  	git checkout HEAD^ &&
>  	git am msg &&
>  	# Ensure that the author and full message are present

> diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
> index 1059ff45fe4..56674db562f 100755
> --- a/t/t5333-pseudo-merge-bitmaps.sh
> +++ b/t/t5333-pseudo-merge-bitmaps.sh
> @@ -6,12 +6,6 @@ GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
>  
>  . ./test-lib.sh
>  
> -if ! test_have_prereq PERL_TEST_HELPERS
> -then
> -	skip_all='skipping pseudo-merge bitmap tests; Perl not available'
> -	test_done
> -fi
> -
>  test_pseudo_merges () {
>  	test-tool bitmap dump-pseudo-merges
>  }
> @@ -34,9 +28,8 @@ test_pseudo_merges_reused () {
>  
>  tag_everything () {
>  	git rev-list --all --no-object-names >in &&
> -	perl -lne '
> -		print "create refs/tags/" . $. . " " . $1 if /([0-9a-f]+)/
> -	' <in | git update-ref --stdin
> +	sed 's|\(.*\)|create refs/tags/\1 \1|' in |
> +	git update-ref --stdin
>  }
>  
>  test_expect_success 'setup' '
> @@ -108,7 +101,7 @@ test_expect_success 'stale bitmap traversal with pseudo-merges' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'bitmapPseudoMerge.sampleRate adjusts commit selection rate' '
> +test_expect_success PERL_TEST_HELPERS 'bitmapPseudoMerge.sampleRate adjusts commit selection rate' '
>  	test_config bitmapPseudoMerge.test.pattern "refs/tags/" &&
>  	test_config bitmapPseudoMerge.test.maxMerges 1 &&
>  	test_config bitmapPseudoMerge.test.stableThreshold never &&
> @@ -241,8 +234,7 @@ test_expect_success 'pseudo-merge pattern with capture groups' '
>  			test_commit_bulk 16 &&
>  
>  			git rev-list HEAD~16.. >in &&
> -
> -			perl -lne "print \"create refs/remotes/$r/tags/\$. \$_\"" <in |
> +			sed "s|\(.*\)|create refs/remotes/$r/tags/\1 \1" in |

This conversion results in the error:

  sed: -e expression #1, char 41: unterminated `s' command

I find it suspicious that the test still succeeds...

>  			git update-ref --stdin || return 1
>  		done &&
>  
> @@ -258,7 +250,7 @@ test_expect_success 'pseudo-merge pattern with capture groups' '
>  		do
>  			test_pseudo_merge_commits $m >oids &&
>  			grep -f oids refs |
> -			perl -lne "print \$1 if /refs\/remotes\/([0-9]+)/" |
> +			sed -n "s|refs/remotes/\([0-9][0-9]*\)/|\1|p" &&
>  			sort -u || return 1
>  		done >remotes &&
>  
