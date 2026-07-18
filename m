Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E0363C7C
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784401683; cv=none; b=RBYmXl4jl1cmy99JqhtGS0zEP+BpDrNKFNH/QKSJJqGGoS4i2WInwfs4tt4JhIL/V/erejkQq5WVawwRGl0z/UnSssje3Cx8fj+koCyrqNTWLPlu30r5Dj2grtlyYiFxPm1ogy6NWIlnb6HvCPROq+iJrblubj294KJQkqDBbgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784401683; c=relaxed/simple;
	bh=Bk0qsLqPbekVORW+3txa4WrH+PVutWKmNGPk3er3vPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZTkP0VU82vMAP5TkiQiNq2GnLZVgao+6i7BTRgb2DXXyupjw5OfssY3Q29oLAplquBwKZAdcfprKEo3LIH1r7DTNA8cuojr2KkW4UcnoxFDbOlevNKZ53SHt7m9ZX8DqaNHBr6QRixukqlDNBKIr5tfqcBy+CIeBD3Uxjzi4sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=sq3kjSRB; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="sq3kjSRB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784401665; x=1785006465; i=l.s.r@web.de;
	bh=tr85tyHyZteW9oyTbmaF1Mzh1jbQCGMKj3bOdayvyM0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sq3kjSRBxVZ9qmfM+Xdffs94AP1lc9zYNWya5bSr5DbfQXcJOOCj4BzMrBHWAvm6
	 u/svSX6945NMPf+be8FjQFlwLSz8O0PyhtakEt7q5NDE2VERW5nmnh4uhe+o0Ad4M
	 rvt/lkVDLfCsyBuAKSRrorO9bAb4GfvfSIrEueN+CoGDTGcmJA24l+WVh6C9ccLBc
	 tHJvHdb6mM1tPPjGvND6NsOSCb1F9mPjtuBjxBxSGy72GtHxo2638rUvSfh0/zC5O
	 oBESaqUsglo1CmQF5IWE0dlHdLcCcJ8F86T1m8fGueQZdpN1aaj7P8oOtfLooTVHZ
	 GqHUVLsT0GuH1Shwsw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYLig-1wXOlv1Ojq-00YkOE; Sat, 18
 Jul 2026 21:07:45 +0200
Message-ID: <c7357faf-3d2b-46c6-99e7-88d3e2c72a77@web.de>
Date: Sat, 18 Jul 2026 21:07:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] branch: report kind of checkout when rejecting delete
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Toon Claes <toon@iotcl.com>,
 Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>, stsp <stsp2@yandex.ru>
References: <9865fc6b-e3fe-4614-9ffe-71af776e1796@web.de>
 <xmqqjyqsqk1a.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqjyqsqk1a.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i8LsFxQJnOMJaOUOsvfhVApZWu3F2juBz/14ZSwih+ZLVwa5zKd
 uN2F8bKgA6E+U7bGPaF3AmO4smsSSFGn1b2Q4ZYON1DxdUQFn/NqKQK2sIt3czzu5EDenHq
 D0Tux3ZcX7wadjZHO3XiIg42Y3OYIAkXqsBQMT94yNJJPNBbphHLgWABmRWeE0xdyQDCceW
 DdVtcnQZb+Ay7hgAKm3LA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QmU0wAs3PW8=;nXCL4VeJHJIOdRl24PpMH+BupBc
 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

On 7/18/26 7:34 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> git branch refuses to delete branches that are currently checked out
>> with a message like this: "error: cannot delete branch 'foo' used by
>> worktree at '/path/of/worktree'".  This can be confusing with internal
>> checkouts, e.g. if one tries to delete a branch associated with an
>> active bisect run.
>>
>> Mention the kind of internal checkout, if any, to spare the user from
>> remembering that they might have forgotten a bisect or rebase.  To do
>> that, register the checkout reason in a strintmap alongside the existin=
g
>> strmap that stores the worktree path.
>>
>> Suggested-by: stsp <stsp2@yandex.ru>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>> Original message:
>> https://lore.kernel.org/git/cae34516-5437-49d3-8d39-16f4059a81a8@yandex=
.ru/
>=20
> This reminds me of another recent discussion on rewriting a branch
> that is checked out elsewhere, where the "git history" command
> forgot to apply the same safety check:
>=20
> https://lore.kernel.org/git/e7dbcede-4486-459c-aa64-e44690e01fe0@gmail.c=
om/
>=20
> We definitely need an easy-to-use API to determine consistently
> which branches are in use, and to teach all commands that repoint
> branch tips to use it to offer the same safety to users.  The
> framework that this patch introduces might be a good starting point
> for that effort.

branch_checked_out() already allows to check whether a branch is in use,
but I guess git history needs to respond differently depending on the
kind of use, e.g. leave active bisects and rebases untouched and update
checked out branches.  branch_checkout_kind() would allow that, but I
now wonder if it suffices for cases where branches appear in multiple
worktrees.  So perhaps the query we need to enable are "is this branch
used by a rebase/bisect" and not the more limited "tell me one use of
this branch"?

>> diff --git a/branch.h b/branch.h
>> index 3dc6e2a0ff..d1073fe1cd 100644
>> --- a/branch.h
>> +++ b/branch.h
>> @@ -15,6 +15,14 @@ enum branch_track {
>>  	BRANCH_TRACK_SIMPLE,
>>  };
>> =20
>> +enum branch_checkout_kind {
>> +	BRANCH_CHECKOUT_KIND_UNSPECIFIED =3D 0,
>> +	BRANCH_CHECKOUT_KIND_CHECKOUT,
>> +	BRANCH_CHECKOUT_KIND_REBASE,
>> +	BRANCH_CHECKOUT_KIND_BISECT,
>> +	BRANCH_CHECKOUT_KIND_UPDATE_REF,
>> +};
>> +
>> ...
>> +/*
>> + * If the branch at 'refname' is currently checked out in a worktree,
>> + * then return the kind of checkout, i.e. whether it was done by an
>> + * actual checkout or a rebase etc.
>> + */
>> +enum branch_checkout_kind branch_checkout_kind(const char *refname);
>=20
> OK.
>=20
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index dede60d27b..3223347129 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -266,9 +266,34 @@ static int delete_branches(int argc, const char **=
argv, int force, int kinds,
>>  		if (kinds =3D=3D FILTER_REFS_BRANCHES) {
>>  			const char *path;
>>  			if ((path =3D branch_checked_out(name))) {
>> -				error(_("cannot delete branch '%s' "
>> -					"used by worktree at '%s'"),
>> -				      bname.buf, path);
>> +				int kind =3D branch_checkout_kind(name);
>=20
> Not "enum branch_checkout_kind" but "int"?

Yes, it doesn't matter for the switch and is easier to print.

>=20
>> +				switch (kind) {
>> +				case BRANCH_CHECKOUT_KIND_CHECKOUT:
>> +					error(_("cannot delete branch '%s' "
>> +						"used by worktree at '%s'"),
>> +					      bname.buf, path);
>> +					break;
>=20
> We may want to be more explicit and say "cannot delete
> branch 'frotz' checked out in worktree at '/tmp/nitfol'"
> instead.  Unless this is a catch-all entry for states that
> are neither 'rebase', 'bisect', nor 'rebase-merges' but are
> somehow otherwise in use, that is.
>=20
>> +				case BRANCH_CHECKOUT_KIND_UPDATE_REF:
>> +					error(_("cannot delete branch '%s' "
>> +						"used by worktree at '%s' "
>> +						"for update-ref"),
>> +					      bname.buf, path);
>> +					break;
>=20
> I was quite lost when searching for cases where this 'update-ref'
> state might be encountered, and I still lack confidence.  Can
> we make the diagnostic message a bit friendlier to our users?
>=20
> For instance, something like: 'You are rebasing a history with
> merges in that other worktree, and the tip of this branch will
> be updated when that process completes, so you cannot delete
> it from here.'  (Naturally, I may have misidentified the exact
> nature of the error, but this illustrates the level of detail and
> user-facing clarity I hope to see.)

That's quite long.  Would it make sense to throw that update-ref
case into the rebase bin, i.e. only distinguish between checkout,
bisect and rebase?

>=20
>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>> index e2682a83a0..e5df493b66 100755
>> --- a/t/t3200-branch.sh
>> +++ b/t/t3200-branch.sh
>> @@ -930,7 +930,7 @@ test_expect_success 'deleting currently checked out=
 branch fails' '
>>  	git worktree add -b my7 my7 &&
>>  	test_must_fail git -C my7 branch -d my7 &&
>>  	test_must_fail git branch -d my7 2>actual &&
>> -	grep "^error: cannot delete branch .my7. used by worktree at " actual=
 &&
>> +	test_grep "^error: cannot delete branch '"'"'my7'"'"' used by worktre=
e at '"'.*'\$"'" actual &&
>>  	rm -r my7 &&
>>  	git worktree prune
>>  '
>> @@ -941,7 +941,7 @@ test_expect_success 'deleting in-use branch fails' =
'
>>  	git -C my7 bisect start HEAD HEAD~2 &&
>>  	test_must_fail git -C my7 branch -d my7 &&
>>  	test_must_fail git branch -d my7 2>actual &&
>> -	grep "^error: cannot delete branch .my7. used by worktree at " actual=
 &&
>> +	test_grep "^error: cannot delete branch '"'"'my7'"'"' used by worktre=
e at '"'.*' for bisect\$"'" actual &&
>>  	rm -r my7 &&
>>  	git worktree prune
>>  '
>=20
> We distinguish four kinds in the code but we test only two of them?
Laziness, and it was enough for the user requirement..

Ren=C3=A9

