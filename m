Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297403EFD06
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773084617; cv=pass; b=QMndH2K2YumobmvghlRS5O5MJzJqejF6/MoBUXrh7yPBYtGuJZI8PgvJrtR6fy8NciqSG1AxrmX+dTlquZb9pYxzE4BY+NsgWHIJvvHDRsMy462lPPaK1IADFwT7gxl+OjnoOteY6lVexQjs9CSluHu/AWJUwiwYWi1BAffMwfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773084617; c=relaxed/simple;
	bh=mucqVipEhVdGzpE9i60/bmuLDziYhbiw0YmvIkiiLfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aP3HmnCimy68ztVBtBA2FpHnW6O+6QyxMwAVQWqCPLXtzRk8T7cL6B1ahECe/CHHvmx8WPW92JEA+G1spY+qNBWXMW5rE6U1PFZaeCZ8enci5KK4YfUaRQBWexSLgQcrBb+Pw+2/AcSNS2GLTCVjl5axbTnrl7QKNc9UrEuRXIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12736a0147cso578005c88.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 12:30:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773084615; cv=none;
        d=google.com; s=arc-20240605;
        b=WflPYDvXA21N6Az7rgi7mlO86BUG3ZUiI81oQV1tTcs0V3cPW1VQPAz6db0eIEqy9U
         5EBh2rDZCn6Cbx4mRhj0apNnoGUKTm24fHBssAoJPcXc1QcU9cO7/hy1jmFo+vc525x6
         5LMvXbiCcV8KFDzi/2QKth+JYncrmWnCN8LD8n1HlnZP3igXqkz+snMm90V8outYiFaf
         KBTyZukSANxK3aanC6X3OJcwfsKSrjWKbcq0YPl9ESHW9FCkxvl6yyNQNciW2T8QQXQ2
         rs0e8Sh31mpg/pAt6Ib9s862WfIwKrp+IlbfxOxow7faqgvep3m9v9PFqn954rOe6S6r
         z41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=zzhP9QkMqXw6YqTwcLGH91rZCLqSlq/d3nKf/YjTwz0=;
        fh=OqwB+JZBsSQT8s7W/1mPwK4nDn2/iMThoEkIEj0pAeo=;
        b=SBMH/X8h4UFN5X7ini1d9hvTW8NFUTROcEIYpG5A7qUXNX9pS8SRJZcwiokXVFVWLF
         rEbeS88ZqpeI8CZsvX3Qq2J+D8BxOz5aNLz60G6ytznMEVmPwoCNrolGtKrM5PnkAbaV
         s3+Sg82p98uZfzp4PJPQpTiDE/kRKpMemQEF4GFaTRDrlUNfDjqB4wKYatSWkRv0tKa6
         4Q6kg87cQPDrX4TfPeIqoVE65aSQAHNC0+6W22Hwot+DvY8xS1ua//hmy8hI9Qkulc9J
         +J470ct+6197ePSMtxNKli0VdyJXM3pteDj+zLGXTLVlhyA0ERM2jDekuvKx6cRWE0Ag
         YYQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773084615; x=1773689415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zzhP9QkMqXw6YqTwcLGH91rZCLqSlq/d3nKf/YjTwz0=;
        b=cFuuocuM0LVc30pxHFeEciEIWOG37v+64fGO8IirAzCh9bGC0USLHramQ4tNBeU4+9
         6JvLz5foNpHnLg+LfGmiFJKbMt5dsMNcrMs/OC14S3U2Zc40wTM6P5Cnddf6LVWHA/AY
         S9XgLHwWS7XjtVFllU+7XNN+8h3ftXbeokeHH1BqrWrpcjfHCXriN9ZKRhhTJGi2DMuH
         k9Q3/vHAJ4UVszYtEfeZK6mRxRLrMoL4hM0/asE3ndpJSASctgMnwvibsvnqmSwxXCIv
         dygBI6O9EN0ddOQHQF4kqSJpPi0vbn66r1ab/vlhadh4vz4Qr5YzuDzpMYe0eYC6kfFy
         mUfw==
X-Gm-Message-State: AOJu0Ywxr8gbXNEHhkrP5n2GhYXu7KVBI2ga2YFBzlyhgAcOhnIEA3Vx
	+mtH/dlVUYJrrWcmzEpGh8dzd+P4NbriyMMtfGid2u/JpJuBNW7bm8qipxZoI4yeRxgrO4lkOGu
	iP4Yk/2oH2TD8zY0T02odImAlia9ohWk=
X-Gm-Gg: ATEYQzwA8a0Xo89GHzV/d6sr00xv2ogO0WzVEAnWAq3PjvgyKjIxmmluX66jiAy3+tu
	3A9oLWnbUXrvkBcW2/C4V4tsNsqyfPeuI5hRaknY8qD75pYvltetx9GG2z7Vq2yl8g1EM3bZQdX
	0gjiPcWbw80y5DW+bCN5o1m9wCOkhV707hqpBCBEaNC3J1+WJtYyvtCwY172MkWgPtjv58qTxEw
	3k8Ik0QYhVgGV5nhvfN09rE3tDWgodLaZfitkHpON4ttv+YOFhBJQ+8N1y2VdGKBzyl/Bl5dr5W
	rTUduUKvTx6bsqI3lF6jlqt5ulsyNQi0xrQpwZwxdQ==
X-Received: by 2002:a05:7300:dc93:b0:2be:681:91b2 with SMTP id
 5a478bee46e88-2be4e04a8f7mr2848753eec.6.1773084615095; Mon, 09 Mar 2026
 12:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309175621.32211-1-prashantjee2025@gmail.com>
In-Reply-To: <20260309175621.32211-1-prashantjee2025@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 9 Mar 2026 15:30:03 -0400
X-Gm-Features: AaiRm5260O3ttmsGlLVnHrNeVAXvNgYN1vxl8_gOhRvlbTb-z_rQPnUqbZFS16Y
Message-ID: <CAPig+cSp1634HVrj6qVfRodR=J3UubYa_aa32JJSTCe1u2NwDA@mail.gmail.com>
Subject: Re: [PATCH] t0004: replace test -e with test_path_exists
To: PRASHANT S BISHT <prashantjee2025@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 2:02=E2=80=AFPM PRASHANT S BISHT
<prashantjee2025@gmail.com> wrote:
> Replace old-style path existence checks with the modern test_path_exists
> helper function that provides clearer diagnostic messages on failure.
> When test -e fails, the output gives no indication of what went wrong.
>
> These instances were found using:
>
>   git grep "test -[efd]" t/ | grep -v "if test"
>
> as suggested in the microproject ideas.
>
> Signed-off-by: PRASHANT S BISHT <prashantjee2025@gmail.com>
> ---
> diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
> @@ -21,7 +21,7 @@ test_expect_success POSIXPERM,SANITY 'write-tree should=
 notice unwritable reposi
> -test_lazy_prereq WRITE_TREE_OUT 'test -e "$TRASH_DIRECTORY"/out.write-tr=
ee'
> +test_lazy_prereq WRITE_TREE_OUT 'test_path_exists "$TRASH_DIRECTORY/out.=
write-tree"'
> @@ -36,7 +36,7 @@ test_expect_success POSIXPERM,SANITY 'commit should not=
ice unwritable repository
> -test_lazy_prereq COMMIT_OUT 'test -e "$TRASH_DIRECTORY"/out.commit'
> +test_lazy_prereq COMMIT_OUT 'test_path_exists "$TRASH_DIRECTORY/out.comm=
it"'
> @@ -52,7 +52,7 @@ test_expect_success POSIXPERM,SANITY 'update-index shou=
ld notice unwritable repo
> -test_lazy_prereq UPDATE_INDEX_OUT 'test -e "$TRASH_DIRECTORY"/out.update=
-index'
> +test_lazy_prereq UPDATE_INDEX_OUT 'test_path_exists "$TRASH_DIRECTORY/ou=
t.update-index"'
> @@ -69,7 +69,7 @@ test_expect_success POSIXPERM,SANITY 'add should notice=
 unwritable repository' '
> -test_lazy_prereq ADD_OUT 'test -e "$TRASH_DIRECTORY"/out.add'
> +test_lazy_prereq ADD_OUT 'test_path_exists "$TRASH_DIRECTORY/out.add"'

I'm afraid you chose instances of `test -e` which should not be
converted to `test_path_exists`.

If you're not familiar with Git's test "prereq" facility, then it is
not obvious, but each of these uses of `test -e` is, in fact, used for
control-flow rather than being used to assert some truth. Hence, these
changes run afoul of point #3 under the "Modernize Test Path Checking
in Git=E2=80=99s Test Suite" item on the SoC microproject ideas page[*].

Please try converting some other cases in some other test script.

[*]: https://git.github.io/SoC-2026-Microprojects/
