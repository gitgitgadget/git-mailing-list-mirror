Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352015;
	b=LLNrxUMjl1JmWBVCotmbR9A2S2VkRVifq7jQotVoxCslwUIj+nYA3oi6TETQQRet4QuJ
	 xyqaN8GG4wm+k7ZOXdafHxzw8riR7gVBSe5rHZbI6z6DF3gLZ0ThLa9Kf0yAhoGw7kMnq
	 z2WMUC8lxhpybZQRNGVabGOS3X7qNf5SbVmdS8bRXVMuHJyLEER+6imnpEX9I/sN3l2x6
	 Dy0p7725vhE2+2S3EddZGy76TqEh3fJ62FefCGZKkby34j3Y35nSZNXJbiqOq06QmzjFx
	 la/nktmocTCqSS3psnXXJvX8u8h8MYBHRFSXHiUQ17pq5TJvISuxu5yT8+9flsycTpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5Zcy2KnoXPteQDLPHPmYL7PtMOuei1EUQpDpk/tqVYs=;
	b=XaLz5hqWNN7vjgX/+WbXM5QgJRlPYhcYhWJJtSsHPyj61xBqeP8fZ91FKPLhJ1B2nkRT
	 rUCTpUbFtY6xfUNo9EDHAbMVxc0o+szzam1yxyTK6OQRyyDD737YdkAiK3WRevmJGu2yw
	 WRcNoRXMH5eRElGJ8LpHeegi4HppdArklb65MlrsdLSbioYD/GAtl+xsMN/yEZ+CWokOv
	 s4JLHdoxcMKwXLgw1iYcdSw3F0WW55m+SF8HL0gkaU6UiqUA7f8Ot8SeGzF3DOfiWxOqv
	 ++GYZPxQ5s7YQS+DsZoJehoZIv4r6RGFWGJxvepBDtmFtPK571vpAhO0U/c4zpcZdCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e2Q19ee5;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028BF606A320
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 23:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 028BF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e2Q19ee5
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-85ac281604dso1493533a34.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 15:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794352014; x=1794956814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Zcy2KnoXPteQDLPHPmYL7PtMOuei1EUQpDpk/tqVYs=;
        b=e2Q19ee5qnngGGFAR61y6quSS0W610kxOiqQnNsaMWTEhPRLhhnh5I9WdMmvFH/6I8
         ZDmeQvBGy7ebzgGm+Rr1eon8E/FlkFOBgr+8xFPO7irBXczRErYgm78xKNdf/UQ/oJOI
         AVnZCXkWlRbULN3RAf+5nYdckfJboZWj84vL4E8oub6w3+ajYUeRKUW71O6Y+f0ga6JW
         ZHly4H+OtWmfckG02YWR2/1E/TThxanoT0OomWN32+waxT8LwWpxcZJmBf8jl7D3z8MM
         jCbR2T/h1ZGQAT87SPI2wBSvFQFTxxighUrCHw4Szxw+0W2vjWajaEN2EVLR9OfPbcfu
         BTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794352014; x=1794956814;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Zcy2KnoXPteQDLPHPmYL7PtMOuei1EUQpDpk/tqVYs=;
        b=Fp8dN1M7OAggYz4r1DoRqW32zAo4xt0ijsc49Jg6Zy+ud0IMXmySuHz0IjdcBL0rZN
         unV3UMsTmvxHocI1q4fU+nKJftT1qKhGSoSSTHXBbP6AeOaTYN/5S9SKannA53kpI+ff
         MeSI9HXKDVeRfwF2JfJ0H8oIl9P4zhwpifxBz4Dd9Fd+tNgl/JT8TYqq4e4oF61HveEN
         cxMakMa0Ffn0aalTCoSFUU5JxOjZhyG0YePzn8cyP1pEONxyb5eN9r2ZKQuCM9L0iHd4
         2iBRIZY9zGv/6UTvyaDBWdDx7GDsFGrW0QwsF1OMoHDT80ztUrIKAjKHlNGPap+FBBF6
         9J5Q==
X-Forwarded-Encrypted: i=1; AL+hErGuyiqHNLDgehtem/WyhEgWbc8JI2b0xncW9D9p69on2q5DbqW5XMPJz9gfaeAkxp81U3g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4bNl2aKu184PTBFD8Hxu1nUaFKxSH+iqJdVUEmPuuAw+fwQTQ
	2I6LlmG+c9V7p/Tk2qLg7IuFpUvvN1Yb8Yx3cY5EQ4Dbukjzq5H8rgw3lh5G7Q==
X-Gm-Gg: AYBFou19IMde4Z28pLxBsJp66nsFE+9CUU0iY8VFCxR2yBeJzrr8439Tc8Hv66YkAne
	o6x9rvwjeP6NSnaL+iFS5GECCV3NkLxQrStqWwRUyUUZEXW+zU40cqznrD08CzpC6Xozrr3Aiz8
	6WmScufy/6oEQ1fzKKLprOK/sg1TLTkL92qN+3TfA+xg6MNWAngVWv9S/ZGH5OSgZwyA7dro6wB
	gKCWb6EGe7hKaqYqIit+DwanwAHWdfihzWrobHa9l8NT8FdF4zpgc9tjhL5vuzsZpSHscZmODgh
	6G9hWMdEGyCgwYv/cqmayALzW8/hrQ2C0Yd8yt+lZ8yO0e2h8g842VCYndOd8J99gDSEdVItyh/
	QWnDhdVO+taI014jTZJ6hL15aWVQba8FY7cFQIi3z9eLbSnCmElVv38ICc0gzH3x71Sqa8RK8FN
	0EEyFxedsBu4KBMt4lYS8pRRsVaf3WNjxCtfe+8AVH3PmZ0GBEucSxGRgpfmnwdJzgtFik1qABH
	t0OXGtJyQb9tfXrtrUSxfweveVsaP0TaX8BrHkgtbVeBJTCR8L6d7+euH5kfLsEZGD1jatQ/MwK
	PK3TjIhWJRcTe/jfB3YPE/RcWYQhab1oDihH/8JSFCmwmH/ddbicww==
X-Received: by 2002:a05:6830:441e:b0:844:5d0e:5152 with SMTP id 46e09a7af769-860f28740c0mr409614a34.18.1794352013785;
        Tue, 10 Nov 2026 15:06:53 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcc1d759sm3032845a34.23.2026.11.10.15.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:06:53 -0800 (PST)
Date: Tue, 10 Nov 2026 17:06:49 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Miklos Vajna <vmiklos@collabora.com>
Cc: gitster@pobox.com, szeder.dev@gmail.com, ps@pks.im, 
	git@vger.kernel.org
Subject: Re: [PATCH v5 1/5] t4219: test more --follow cases across merges
Message-ID: <avOWhV09WfNsAptg@jtobler--20250820-SHC54>
References: <cover.1794078554.git.vmiklos@collabora.com>
 <5512aa682f71243378c06dcb8cda2b53150d4e39.1794078554.git.vmiklos@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5512aa682f71243378c06dcb8cda2b53150d4e39.1794078554.git.vmiklos@collabora.com>

On 26/11/09 09:04AM, Miklos Vajna wrote:
>A later commit in this series will speed up 'git log --follow' for
>merge commits. Add tests for cases which already work, but have no
>test coverage, so it's easy to break them while optimizing:
>
>- a subtree merge adding the history of a file that was copied before
>- --follow through a fork with renames on both sides, with -c, --cc
>  and --remerge-diff
>- a --no-ff merge taking a rename from the second parent, in both commit
>  orders, since the result could depend on the walk order
>- a merge keeping the path, while the other side renamed it
>- --diff-merges=first-parent, which diffs merges only against their
>  first parent, but still walks all parents
>- a merge keeping the renamed path, while the other side edited the old
>  one
>- a merge keeping the copied path, while the other side edited the
>  original

This explains what tests we are adding, but it doesn't really provide
readers with much context as do why they are the expected behaviors.

>
>Helped-by: Patrick Steinhardt <ps@pks.im>
>Signed-off-by: Miklos Vajna <vmiklos@collabora.com>
>---
> t/t4219-log-follow-merge.sh | 214 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 214 insertions(+)
>
>diff --git a/t/t4219-log-follow-merge.sh b/t/t4219-log-follow-merge.sh
>index e370f82955..806ccc24bd 100755
>--- a/t/t4219-log-follow-merge.sh
>+++ b/t/t4219-log-follow-merge.sh
>@@ -31,6 +31,33 @@ test_expect_success '--follow finds the pre-merge commit through a subtree merge
> 	test_cmp expect actual
> '
>
>+test_expect_success 'setup subtree merge adding the history of a copied file' '
>+	git init graft &&
>+	echo outer >graft/outer.txt &&
>+	git -C graft add outer.txt &&
>+	test_tick &&
>+	git -C graft commit -m "outer init" &&
>+	mkdir graft/inner &&
>+	cp inner/inner.txt graft/inner/ &&
>+	git -C graft add inner &&
>+	test_tick &&
>+	git -C graft commit -m "copy inner.txt to inner/" &&
>+
>+	git -C graft fetch ../inner master &&
>+	test_tick &&
>+	git -C graft merge -s ours --allow-unrelated-histories \
>+		-m "Merge the history of inner/" FETCH_HEAD
>+'

Ok IIUC, this test is setting up a repository has manually copied and
committed from another repository, but then later merges the unrelated
history. It took me a little bit to parse what exactly was going on
here. Maybe some comments would be a bit helpful here?

>+
>+test_expect_success '--follow finds the history of a copied file through a subtree merge' '
>+	git -C graft log --follow --pretty=tformat:%s inner/inner.txt >actual &&
>+	cat >expect <<-\EOF &&
>+	copy inner.txt to inner/
>+	inner init
>+	EOF
>+	test_cmp expect actual
>+'

Ok and here we validate that we follow the file into the now merged
unrelated history. I assume that prior to 304812ed33de (log: improve
--follow following renames for non-linear history, 2026-06-22), this
would not have passed? If so, it might be helpful to more directly
mention this in the commit message?

>+
> test_expect_success 'setup merge of two branches that both renamed a file to README' '
> 	git init foo &&
> 	mkdir foo/foo &&
>@@ -126,4 +153,191 @@ test_expect_success '--follow follows renames through a fork in a single history
> 	test_cmp expect actual.sorted
> '
>
>+for opt in -c --cc --remerge-diff
>+do
>+	test_expect_success "--follow follows renames through a fork with $opt" '
>+		git -C diamond log --follow $opt --pretty=tformat:%s path >log &&
>+		grep "^[A-Z]: " log | sort >actual &&
>+		cat >expect <<-\EOF &&
>+		A: add path0
>+		B: modify path0 on upper
>+		C: modify path0 on lower
>+		M: merge with rename to path
>+		X: rename path0 to path1
>+		Y: rename path0 to path2
>+		Z: modify path
>+		EOF
>+		test_cmp expect actual
>+	'
>+done

I assume here we are validating that the merge is printed?

>+
>+# Build a merge that takes the renamed path from the second parent, while the
>+# first parent only has the old path. $2 decides which side is committed first,
>+# which decides the walk order.
>+setup_rename_on_second_parent () {
>+	git init $1 &&
>+	printf "line 1\nline 2\nline 3\nline 4\nline 5\n" >$1/old &&
>+	git -C $1 add old &&
>+	test_tick &&
>+	git -C $1 commit -m "A: add old" &&
>+	printf "line 1\nline 2\nline 3 modified\nline 4\nline 5\n" >$1/old &&
>+	test_tick &&
>+	git -C $1 commit -am "B: modify old" &&
>+	git -C $1 branch topic &&
>+
>+	if test "$2" = topic-first
>+	then
>+		git -C $1 checkout topic &&
>+		git -C $1 mv old new &&
>+		test_tick &&
>+		git -C $1 commit -m "R: rename old to new" &&
>+		git -C $1 checkout master
>+	fi &&
>+
>+	echo other >$1/other &&
>+	git -C $1 add other &&
>+	test_tick &&
>+	git -C $1 commit -m "M: unrelated change on master" &&
>+
>+	if test "$2" = master-first
>+	then
>+		git -C $1 checkout topic &&
>+		git -C $1 mv old new &&
>+		test_tick &&
>+		git -C $1 commit -m "R: rename old to new" &&
>+		git -C $1 checkout master
>+	fi &&
>+
>+	test_tick &&
>+	git -C $1 merge --no-ff -m "merge topic" topic
>+}

Ok, because the walk order is based on commiter date, we have a helper
function here that can create various test setups to validate we can
follow a file through the history.

>+
>+test_expect_success 'setup merge taking a rename from the second parent' '
>+	setup_rename_on_second_parent rename-master-first master-first &&
>+	setup_rename_on_second_parent rename-topic-first topic-first
>+'
>+
>+for order in master-first topic-first
>+do
>+	test_expect_success "--follow follows a rename from the second parent ($order)" '
>+		git -C rename-$order log --follow --pretty=tformat:%s new >actual &&
>+		cat >expect <<-\EOF &&
>+		R: rename old to new
>+		B: modify old
>+		A: add old
>+		EOF
>+		test_cmp expect actual
>+	'
>+done

Ok, so we expect the results to be same the same and the file to be
found on both sides here. I realize we are crafting very specific
repository histories to validate here, but I must say the test setup
here is rather complex IMO.

>+
>+test_expect_success 'setup merge keeping the path, other side renamed it' '
>+	git init keep &&
>+	printf "line 1\nline 2\nline 3\nline 4\nline 5\n" >keep/F &&
>+	git -C keep add F &&
>+	test_tick &&
>+	git -C keep commit -m "O: add F" &&
>+	git -C keep branch B &&
>+	printf "line 1\nline 2\nline 3 A\nline 4\nline 5\n" >keep/F &&
>+	test_tick &&
>+	git -C keep commit -am "A1: update F in place" &&
>+
>+	git -C keep checkout B &&
>+	git -C keep mv F G &&
>+	test_tick &&
>+	git -C keep commit -m "B1: rename F to G" &&
>+	printf "line 1\nline 2\nline 3\nline 4 B\nline 5\n" >keep/G &&
>+	test_tick &&
>+	git -C keep commit -am "B2: update G" &&
>+
>+	git -C keep checkout master &&
>+	test_tick &&
>+	git -C keep merge -s ours -m "M: merge B, keep F, drop G" B
>+'

Ok, here we are creating a history where a topic modifies and renames a
file, but the merge drops these changes. Some comments here might also
be helpful for readers.

>+
>+test_expect_success '--follow follows a rename on the side the merge did not take' '
>+	git -C keep log --follow --pretty=tformat:%s F >actual &&
>+	cat >expect <<-\EOF &&
>+	B2: update G
>+	B1: rename F to G
>+	A1: update F in place
>+	O: add F
>+	EOF
>+	test_cmp expect actual
>+'

We expect that the commits from branch B are still inspected even though
the merge dropped them. Makes sense.

>+
>+test_expect_success '--follow with --diff-merges=first-parent follows all parents' '
>+	git -C keep log --follow --diff-merges=first-parent --no-patch \
>+		--pretty=tformat:%s F >actual &&
>+	cat >expect <<-\EOF &&
>+	B2: update G
>+	B1: rename F to G
>+	A1: update F in place
>+	O: add F
>+	EOF
>+	test_cmp expect actual
>+'

hmmmm, is the expectation here that `--diff-merges=first-parent` doesn't
prevent us from visiting commits from the second parent?

>+
>+test_expect_success 'setup merge keeping the renamed path, other side edited the old one' '
>+	git init keep-renamed &&
>+	printf "line 1\nline 2\nline 3\nline 4\nline 5\n" >keep-renamed/F &&
>+	git -C keep-renamed add F &&
>+	test_tick &&
>+	git -C keep-renamed commit -m "O: add F" &&
>+	git -C keep-renamed branch B &&
>+	git -C keep-renamed mv F G &&
>+	test_tick &&
>+	git -C keep-renamed commit -m "A1: rename F to G on master" &&
>+
>+	git -C keep-renamed checkout B &&
>+	printf "line 1\nline 2\nline 3\nline 4 T\nline 5\n" >keep-renamed/F &&
>+	test_tick &&
>+	git -C keep-renamed commit -am "B2: update F on B" &&
>+
>+	git -C keep-renamed checkout master &&
>+	test_tick &&
>+	git -C keep-renamed merge -s ours -m "M: merge B, keep G, drop F" B
>+'

Here the merge keeps master's renamed G and discards branch B's edit to
F.

>+
>+test_expect_success '--follow follows an edit on the side the merge did not take' '
>+	git -C keep-renamed log --follow --pretty=tformat:%s G >actual &&
>+	cat >expect <<-\EOF &&
>+	B2: update F on B
>+	A1: rename F to G on master
>+	O: add F
>+	EOF
>+	test_cmp expect actual
>+'

Commits from both sides along with the original commit are expected.
Makes sense.

>+
>+test_expect_success 'setup merge keeping the copied path, other side edited the original' '
>+	git init keep-copied &&
>+	printf "line 1\nline 2\nline 3\nline 4\nline 5\n" >keep-copied/F &&
>+	git -C keep-copied add F &&
>+	test_tick &&
>+	git -C keep-copied commit -m "O: add F" &&
>+	git -C keep-copied branch B &&
>+	cp keep-copied/F keep-copied/G &&
>+	git -C keep-copied add G &&
>+	test_tick &&
>+	git -C keep-copied commit -m "A1: copy F to G on master" &&
>+
>+	git -C keep-copied checkout B &&
>+	printf "line 1\nline 2\nline 3\nline 4 T\nline 5\n" >keep-copied/F &&
>+	test_tick &&
>+	git -C keep-copied commit -am "B2: update F on B" &&
>+
>+	git -C keep-copied checkout master &&
>+	test_tick &&
>+	git -C keep-copied merge -s ours -m "M: merge B, keep F and G" B
>+'
>+
>+test_expect_success '--follow follows an edit of the copy source on the side the merge did not take' '
>+	git -C keep-copied log --follow --pretty=tformat:%s G >actual &&
>+	cat >expect <<-\EOF &&
>+	B2: update F on B
>+	A1: copy F to G on master
>+	O: add F
>+	EOF
>+	test_cmp expect actual
>+'
>+
> test_done

Ok, these tests are similar to last set, but copied instead of renamed.

-Justin
