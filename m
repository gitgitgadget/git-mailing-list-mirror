Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA575372DD
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172152; cv=none; b=q0XpLfQ/7v8bd3nE0yuBDzX80+M7a3Z8Qr9mpZ3Ut/snI2VY+CLzR6C27+5KYkoEjZ5FZE/EmxFmqZl0NpQGwOqTe8VDIQRMKoZq4c+QGVog2bV+kP6TRTnkH8qjyv3xXPzQJnYFQrtOP+7bXKkpTg1+sXs4pVRKRkvo8LCvFXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172152; c=relaxed/simple;
	bh=UWyIaGOmScLWsCCnSz5m3nGDpLbLIfYiOMKizPMUMuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2JlWFBocGVDB9rHOY4O+3eAKk6napImHLBkECiSe61ZwozqAhA0fKcR5QwrYK/qYg8gsx8sWF+5zaT1M9kD256LllN2RE7zkjkepG3PoihgYhAo3JvAFI7Qb3akaXB+MWQllI0KxAgxhU8EEby+Ie37nJrdrWBbIjYXhr4nHoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnqPIoLv; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnqPIoLv"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a996c8adf3so1611611a12.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 07:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790172144; x=1790776944; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vS2Lsn1Up5ZQgIzGBAWm/Ikw3HP/G4Oh5Oc+h4FchyM=;
        b=lnqPIoLv+tJiYapbHzL6Ad24RYQMDpD3cIzcIwgPM7wbsPIbx6bModf6S7envmZS86
         2fi74w6jkbMSTk/8gMKHYbIH/MLEejshHDeD34Pd69GjuKHR0XtAiJefAssU3NyWiJUu
         VTT6+jCIXGq7QaPwgNcgAyNz4T22n0xoA6SueSeATTx+cWHgBFM0ZujOTukA54CTbYqE
         Cu77GpDKvjbCpHTTtZsKE6u7TLqpoo7RVh2BpjbYQGP77GgK9vtjZmQqQd1SYjx6iTFQ
         dSTlx2jQa0/a/FUZy1A3lClKYGytcCYEheNXvpup8i+EbAxrBVW/MeIu8CokLr3gaq2Y
         +wMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172144; x=1790776944;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vS2Lsn1Up5ZQgIzGBAWm/Ikw3HP/G4Oh5Oc+h4FchyM=;
        b=0DWlAywQ4Fd2n8ipJ48XI7WzFR+hkrFVA+VP7kejGixLPmMF+ae76YC44SRcMjKFzA
         cBxds30Nw8PfyZOelnPP7lZfFTWxgaBl+S6ODZJZvL4P6uJRSW1e0TV6z1DKWkLJogMk
         VTtbL2W7l5zkSotmrQVU0wXizipOSReH6g5O5tjgqlp8PVJpVMGZeKFlMrJX+kpao9Ac
         JaG+TxzdfeKb2FaUpZ/7paLhAezrv9jt9WFN7vfnLoQSqtIrA2Q08FzHeHdVdEi6fds2
         Uz3QIXrDr7PM6rXlN5QKIBKt1Xz3criVKAPs10T9S6GuCeJPjJy+GLuLyla+EozxBZ6j
         y3pg==
X-Forwarded-Encrypted: i=1; AKwUvBxvlHrDa8N3+kU/TVjj97SHgGx03zr5oqQRCaVF8+J4cpRDTKm2gz+1Yywn2ws4xX7i3K0=@vger.kernel.org
X-Gm-Message-State: AFuF++ng2k0Xc0NOIIugku1q5Sl+6dnHqYGY5uS6Rcu4PLwc279kdtyo
	XNQe1HTBI7oHpZyTPFNfjtPznq7EGTeb/SGpLSz3AfgrGDc97LkZhxzx
X-Gm-Gg: AYBFou0i0z6kFMdfxGaNo0liEP2nRJO7XtlKq1exDjQKiP/gbDjlNHSG3mHGvZL3GLw
	1iZM9tkF7Z8CKzCi+fqBkqv9zAo822wSq0TQJ11T1p6K8DyK7qz7VCZXpnADL9vuAjk8TIQVT9m
	yRR876stD5aaTEsXBwhIto5cBUbaS6/FOiZTztim0tROTgqL7bSJkdEcD/YkWdKXkSUUdpv2ePt
	sUO+wYzANnM6Ng/FS5wySBATdJVQnILzAM5p6yB6jjPxMmGBtqQGw15LsOTk5vX2NcsLoupAMiY
	SgwZgl+CSL0gV8YTOinFIZ7g+2KfgYFDfncngnAo8sKRB8PUUbAtoOn4ACL/MQuRyYUxtN1aFcD
	goScuCVNjZDP2vN2EmFcqTbMnMddCwHJHnFG/sD5r99X9ZoCROrfUNi4MnOWKEfUMSpvxzNY+1X
	GK4hXloDoIGt61D4EGX/ZjvqkDJ9bdc8Jr2o+3C9Wt4/nyg2LqwW1MNjaRZJC/r/tnP588MDFkH
	WR0TrL51E+v+Qii7NbC6GsTUC/i8yU3NtFB9l0VqRZh3kDe0aysag==
X-Received: by 2002:a05:6402:4516:b0:6aa:734a:a080 with SMTP id 4fb4d7f45d1cf-6aab3b98508mr2469422a12.23.1790172143758;
        Wed, 23 Sep 2026 07:02:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab38a8d16sm1772628a12.23.2026.09.23.07.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 07:02:22 -0700 (PDT)
Message-ID: <c12d2ac3-5263-4301-aa64-a311a343dd40@gmail.com>
Date: Wed, 23 Sep 2026 15:02:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH REGRESSION] builtin/rebase: allow user to amend committed
 conflicts again
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
References: <20260923-pks-rebase-conflict-bug-v1-1-3d3ccf5022bc@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260923-pks-rebase-conflict-bug-v1-1-3d3ccf5022bc@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 23/09/2026 14:16, Patrick Steinhardt wrote:
> In 6257588252 (commit: refuse to amend during conflict resolution,
> 2026-09-01), we have introduced logic to git-commit(1) that makes it
> refuse creating a commit in some cases. This was done to remove a set of
> common foot guns.
> 
> One of these foot guns is when the user is performing an interactive
> rebase that stops at a conflict. Most of the time when we stop at a
> specific commit we want the user to amend the HEAD commit, so they have
> been trained to use `git commit --amend`. But when there's a conflict,
> they are instead supposed to commit it directly without amending the
> HEAD commit. So to remove that common pit fall, git-commit(1) now
> refuses amending in that situation.
> 
> The logic that detects this scenario checks whether the file
> "rebase-merge/stopped-sha" exists, while "rebase-merge/amend" doesn't.
> And this is exactly the case when git-rebase(1) has stopped at such a
> conflicting commit.
> 
> But there's one problem here: this state persists even after the user
> has already committed the resolved conflict, and consequently they still
> cannot amend after they have done so. This is overly restrictive though,
> as it's quite likely that a user may want to change the resolved commit
> once again.
> 
> Ideally, we'd be able to easily check whether HEAD has already been
> updated to have the resolved conflict. But it seems like we do not have
> sufficient information to determine the original state of HEAD when the
> interactive rebase has stopped, so this is not a workable solution.

Yes, that's unfortunate - I think there is an argument that rebase 
should be writing ".git/rebase-merge/stopped-head" when it stops. That 
would make it easy to detect if the user has committed since the rebase 
stopped. At the moment "git rebase --continue" will happily commit any 
staged changes with the message from the commit that was being picked 
when the rebase stopped, even if the user has already committed a 
conflict resolution. Fixing that is definitely not -rc2 material.

In general we should be discouraging users from committing conflict 
resolutions themselves as it is a hang-over from the way "git merge" 
originally worked that is error prone and loses the original authorship 
when applied to "git rebase"

> Instead, use the existence of "MERGE_MSG" to figure out whether the user
> has already resolved and committed the conflict. It feels somewhat fishy
> to base our decisions on the existence of that particular file, as it
> really is only a proxy for what we are actually after. 

I think that's probably the best we can do. If, after committing a 
conflict resolution from "git rebase", the user runs a 
merge/cherry-pick/revert that has conflicts, then "MERGE_MSG" will also 
exist, but we don't want them to amend that case either so it should be 
fine.

The code changes look good, but I'm not convinced by the test

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 8c63682b7f..d55afaa113 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -2486,6 +2486,40 @@ test_expect_success 'non-merge commands reject merge commits' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'can amend after committing a conflict' '
> +	test_when_finished rm -rf repo &&
> +	git init repo &&

This test file is one of the slowest already, surely we don't need a 
whole new repository and commit setup - can't we just add

	git commit -F .git/MERGE_MSG &&
	git commit --amend -m amended

to the end of 'commit --amend is refused at a rebase conflict stop' 
which was added by 6257588252. That would also check that committing a 
conflict resolution works as well.

Thanks

Phillip
> +	(
> +		cd repo &&
> +
> +		test_commit original file &&
> +		test_commit modified file &&
> +		cat >todo <<-EOF &&
> +		break
> +		edit $(git rev-parse HEAD)
> +		EOF
> +		set_replace_editor todo &&
> +		git rebase -i HEAD~ &&
> +
> +		# Modify "file" to cause a conflict.
> +		echo conflict >file &&
> +		git commit -a --message conflict &&
> +		test_must_fail git rebase --continue 2>err &&
> +		test_grep "Resolve all conflicts manually" err &&
> +
> +		# Resolve the conflict.
> +		echo resolved >file &&
> +		git add file &&
> +		git commit --message resolve &&
> +
> +		# And now try to amend to the conflict. This operation should
> +		# succeed.
> +		echo change >file &&
> +		git commit --amend -a --no-edit &&
> +		git rebase --continue
> +	)
> +'
> +
>   # This must be the last test in this file
>   test_expect_success '$EDITOR and friends are unchanged' '
>   	test_editor_unchanged
> 
> ---
> base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
> change-id: 20260923-pks-rebase-conflict-bug-176e325ad079

