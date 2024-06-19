Received: from mail180-6.suw31.mandrillapp.com (mail180-6.suw31.mandrillapp.com [198.2.180.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0497D156C6A
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 19:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.180.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718825962; cv=none; b=ReVlyh8PrQxecVwDIPYxKNKbqtux/9ffL1Lm6VSELY1gr079TytVXtQEuVd8j8T0kT8k3YFkVTFYKoCWKRzM9P6pp5M7acDkV61DlVJV4a6U5yUV8hrclmO1ANxglwFQ426nTkVXs1EmIdT6QDJ1ibRX2BqIQk7jMOg5fvP4b+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718825962; c=relaxed/simple;
	bh=ksNDuExkbepvkaCBeLd1AdqwyDHBquD8RXVCJe8q0+U=;
	h=From:Subject:To:Cc:Message-Id:In-Reply-To:Date:MIME-Version:
	 Content-Type; b=Fz1cgJE/o3PzhvEO8mXoa2q9Jpgrq6VbjPOWciQZ++nPqz+WQCkh5PckVPJPhox1kOfEdtWCkBHCFxULKd5hZOa5xwEm7rrJhxTxDiuUv0wkXTgdiDQE+JcNyk7YQ+3tTwzuN7aP2pOSPvYwWjTNrQUvwF0tR+/BR8C8PxzfM0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nexedi.com; spf=pass smtp.mailfrom=mandrillapp.mail.nexedi.com; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=KggcM6vY; dkim=pass (2048-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b=UOa8+tXT; arc=none smtp.client-ip=198.2.180.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nexedi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandrillapp.mail.nexedi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="KggcM6vY";
	dkim=pass (2048-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="UOa8+tXT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1718825958; x=1719086458;
	bh=G/N8srRF6gbV6x1tyllbcNNqMhvHkbHYrvztE/ktEt8=;
	h=From:Subject:To:Cc:Message-Id:In-Reply-To:Feedback-ID:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=KggcM6vYoEF+8C7XlB8b3EO5v0UWqQMziTBYdJSLFXxEMMOS9nlEKKRqcM+3tAXbG
	 wfb395xkR3wjmdMLjSIzD+6B4oK+JnpxWmt7udDkCHnKEWf/XV8xykrcIdm7l8X1Fh
	 tUCamfJBcfV7sbnf9dPns8eaCgI1eBAYbSKj6U4AvYrXRd7kW94PVxalIyl4x6qgwW
	 8MkmNcC9coFbGVlGi0nXl6Ur6eV+eZWKiEUh0xRWwDUFf7zdDu1RFtTMnhG+VyeEAO
	 6c9bIXbG9tRnnrb2aqlLbqpwEGJzhHL66Q0pSUmMlqKO4Y5G32GFzGAIaATwpOQzsA
	 Q136GYYaJ1Aug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexedi.com; s=mte1;
	t=1718825958; x=1719086458; i=kirr@nexedi.com;
	bh=G/N8srRF6gbV6x1tyllbcNNqMhvHkbHYrvztE/ktEt8=;
	h=From:Subject:To:Cc:Message-Id:In-Reply-To:Feedback-ID:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=UOa8+tXTlbWKevev8XpMZvadSLKf8Rr7fhDebzkC7OQVpWoMnYRQ0m+gJmVlf83wM
	 jpyCD8F0lzFhEmThdi5DV4BXoSbDn3WrxP/ZLYnmlFm13JQx2w3q2g1v7RZuBWtSq/
	 U0asbCyc9rujeqZGh+2wDcOxVjw/BFgLiqBG5+KfhYMszcbUZNy++t9SIhym+1ErBa
	 zu8pQ7FlN8zBKAg6s1ltaXfQJsco264so2NQQZnaFl8K7WXFfsa+RP4duULhqv7UXP
	 ZaiBN0x5z3ijRt/XO7ZD6lBy1dceANZU0FsxBlaemCQqLl8xIiiCGdEAMI5c4959A6
	 2NOtBHluj4jrg==
Received: from pmta11.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail180-6.suw31.mandrillapp.com (Mailchimp) with ESMTP id 4W4DTL3LDdz2K1s7J
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 19:39:18 +0000 (GMT)
From: Kirill Smelkov <kirr@nexedi.com>
Subject: =?utf-8?Q?Re:=20[PATCH]=20fetch-pack:=20fix=20segfault=20when=20fscking=20without=20--lock-pack?=
Received: from [87.98.221.171] by mandrillapp.com id ab35a5ea32284fa096f8a8e82c702583; Wed, 19 Jun 2024 19:39:18 +0000
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>, Alain Takoudjou <alain.takoudjou@nexedi.com>, =?utf-8?Q?J=C3=A9rome=20Perrin?= <jerome@nexedi.com>
Message-Id: <ZnMz4A2ATa-QLAnS@deca.navytux.spb.ru>
In-Reply-To: <20240619133522.GA942902@coredump.intra.peff.net> <20240619132208.GA895873@coredump.intra.peff.net> <20240619130256.GA228005@coredump.intra.peff.net>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D31050260.ab35a5ea32284fa096f8a8e82c702583?=
X-Mandrill-User: md_31050260
Feedback-ID: 31050260:31050260.20240619:md
Date: Wed, 19 Jun 2024 19:39:18 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On Wed, Jun 19, 2024 at 09:02:56AM -0400, Jeff King wrote:
> On Wed, Jun 19, 2024 at 05:14:21AM +0000, Kirill Smelkov wrote:
> 
> > + newren, peff, calvinwan, ps, avarab
> 
> It's fine (and even encouraged) to re-post a topic which didn't get any
> attention the first time around. But please don't mass-cc unrelated
> people like this. We can all read the list and see your re-post, and if
> we don't respond it may be because we have other priorities.

Jeff, thanks for feedback and for reminding me about netiquette here.
Frankly I though that for some reason my report about segmentation fault
was classified as spam and did not get people attention due to that.

I appologize if my reposting with extended cc caused any inconvenience.


> > +test_expect_failure 'fetch with fsckObjects but without --lock-pack does not segfault' '
> > +	rm -rf server client &&
> > +	git init server &&
> > +	test_commit -C server 1 &&
> > +
> > +	git init client &&
> > +	# unpackLimit=1 forces to keep received pack as pack instead of
> > +	# unpacking it to loose objects. The code is currently segfaulting when
> > +	# trying to index that kept pack.
> > +	git -c fetch.fsckObjects=true -c fetch.unpackLimit=1 \
> > +	    -C client fetch-pack ../server \
> > +		$(git -C server rev-parse refs/heads/main)
> > +'
> 
> Thanks for providing a reproduction of the problem.
> 
> I think we don't want to stick the test right here, as it is breaking up
> two related tests (though it is confusing because one uses http and the
> other doesn't, so there's some http setup in between them). Though
> curiously, putting the "rm -rf server" here revealed a minor bug in
> those other tests. Fixed here:
> 
>   https://lore.kernel.org/git/20240619125255.GA346466@coredump.intra.peff.net
> 
> I think it's a bug that fetch.unpackLimit causes index-pack to create a
> lockfile at all, but there's a more direct way to trigger the issue,
> which I've used in the patch below. I'll follow up with more details in
> a reply to the patch.
> 
> -- >8 --
> Subject: fetch-pack: fix segfault when fscking without --lock-pack
> ...

Thanks for coming up with the fix promptly and for sure I might have
missed something when placing and doing my test. Thanks for correcting
that and coming with a more direct way to reproduce the issue.


On Wed, Jun 19, 2024 at 09:22:08AM -0400, Jeff King wrote:
> On Wed, Jun 19, 2024 at 09:02:56AM -0400, Jeff King wrote:
> 
> > I think it's a bug that fetch.unpackLimit causes index-pack to create a
> > lockfile at all, but there's a more direct way to trigger the issue,
> > which I've used in the patch below. I'll follow up with more details in
> > a reply to the patch.
> 
> Your original test used transfer.unpackLimit. By itself that should just
> cause us to avoid calling unpack-objects, keeping the pack we got, but
> _not_ creating a .keep file. Likewise, if you pass one "-k" to
> fetch-pack, it should just keep the pack but without a .keep file
> (that's what the double "-k -k" does).
> 
> But both of these do trigger a .keep file, which seems wrong to me. The
> caller has no idea that the .keep file was created, so it won't clean it
> up, and the pack will be in limbo forever.
> 
> I tried bisecting and came up with fa74052922 (Always obtain fetch-pack
> arguments from struct fetch_pack_args, 2007-09-19). Given the length of
> time it's been this way, that makes me a little afraid to touch it. ;)
> But I think in practice it is not really triggered because of what I
> wrote earlier:
> 
> > Nobody noticed the bug for so long because the transport code used by
> > "git fetch" always passes in a pack_lockfiles pointer, and remote-curl
> > (the main user of the fetch-pack plumbing command) always passes
> > --lock-pack.
> 
> That is, we're always asking for a lock-file anyway.
> 
> But it could affect external users of the fetch-pack plumbing. I.e., the
> very command that produced the segfault for you is probably leaving an
> unexpected .keep file in place.

Thanks for noticing. Yes, indeed I use `git fetch-pack` and expect only
the pack to be fetched without remaining it in pinned state via .keep file.

It would be good if that could be fixed because present behaviour
contradicts fetch-pack documentation that says that the pack is locked
against being repacked only on double --keep.


> > So it's possible to ask index-pack to create the lock-file (using "-k
> > -k") but not ask to record it (by avoiding "--lock-pack"). This worked
> > fine until 5476e1efde (fetch-pack: print and use dangling .gitmodules,
> > 2021-02-22), but now it causes a segfault.
> > 
> > Before that commit, if pack_lockfiles was NULL, we wouldn't bother
> > reading the output from index-pack at all. But since that commit,
> > index-pack may produce extra output if we asked it to fsck. So even if
> > nobody cares about the lockfile path, we still need to read it to skip
> > to the output we do care about.
> 
> There's another interesting fallout from 5476e1efde that I noticed here.
> Before that commit, if you did not pass --lock-pack to fetch-pack, then
> we would never bother reading stdout from index-pack, and it would go to
> the caller's stdout! So doing:
> 
>   git fetch-pack -k -k repo HEAD
> 
> would produce:
> 
>   keep	3282886e55735beb9a08b048394284b03bef8488
> 
> or similar on stdout. Which makes me wonder if some callers depend on
> that. Or if it is simply a bug, since it would be intermingled with
> fetch-pack's actual output. We still produce that output today, but if
> you use fetch.fsckObjects, then we eat it while looking for the other
> fsck-related output.

Thanks for noticing as well. Indeed that lines emitted with keep might
be wanted to consume by a plumbing user. I'm not consuming them myself,
but from the output it looks like to be intended. Maybe almost noone
depend on those this days though.

For the reference: on my side I switched to fetch-pack plumbing from
fetch porcelain because `git fetch` was working really slow when
initially checking whether it already locally has all the objects
advertised by remote:

https://lab.nexedi.com/kirr/git-backup/commit/899103bf
https://lab.nexedi.com/kirr/git-backup/commit/3efed898


On Wed, Jun 19, 2024 at 09:35:22AM -0400, Jeff King wrote:
> On Wed, Jun 19, 2024 at 09:22:08AM -0400, Jeff King wrote:
> 
> > On Wed, Jun 19, 2024 at 09:02:56AM -0400, Jeff King wrote:
> > 
> > > I think it's a bug that fetch.unpackLimit causes index-pack to create a
> > > lockfile at all, but there's a more direct way to trigger the issue,
> > > which I've used in the patch below. I'll follow up with more details in
> > > a reply to the patch.
> > 
> > Your original test used transfer.unpackLimit. By itself that should just
> > cause us to avoid calling unpack-objects, keeping the pack we got, but
> > _not_ creating a .keep file. Likewise, if you pass one "-k" to
> > fetch-pack, it should just keep the pack but without a .keep file
> > (that's what the double "-k -k" does).
> > 
> > But both of these do trigger a .keep file, which seems wrong to me. The
> > caller has no idea that the .keep file was created, so it won't clean it
> > up, and the pack will be in limbo forever.
> > 
> > I tried bisecting and came up with fa74052922 (Always obtain fetch-pack
> > arguments from struct fetch_pack_args, 2007-09-19). Given the length of
> > time it's been this way, that makes me a little afraid to touch it. ;)
> 
> Even before that commit, we'd trigger the lock of unpack_limit was set
> there. I find all of this code really puzzling (which makes me even more
> hesitant to touch it). But I really don't understand why it is not just
> this:
> 
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 42f48fbc31..ed57b0fdac 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -971,7 +971,7 @@ static int get_pack(struct fetch_pack_args *args,
>  			strvec_push(&cmd.args, "-v");
>  		if (args->use_thin_pack)
>  			strvec_push(&cmd.args, "--fix-thin");
> -		if ((do_keep || index_pack_args) && (args->lock_pack || unpack_limit))
> +		if ((do_keep || index_pack_args) && args->lock_pack)
>  			add_index_pack_keep_option(&cmd.args);
>  		if (!index_pack_args && args->check_self_contained_and_connected)
>  			strvec_push(&cmd.args, "--check-self-contained-and-connected");
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 585ea0ee16..d6d6ea6281 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -1003,6 +1003,28 @@ test_expect_success 'fetch-pack with fsckObjects and keep-file does not segfault
>  	    -C client fetch-pack -k -k ../server HEAD
>  '
>  
> +test_expect_success 'fetch-pack -k does not create .keep file' '
> +	rm -rf server client &&
> +	test_create_repo server &&
> +	test_commit -C server one &&
> +
> +	test_create_repo client &&
> +	git -C client fetch-pack -k ../server HEAD &&
> +	find client/.git/objects/pack -name "*.keep" >keep &&
> +	test_must_be_empty keep
> +'
> +
> +test_expect_success 'fetch-pack with unpackLimit does not create .keep file' '
> +	rm -rf server client &&
> +	test_create_repo server &&
> +	test_commit -C server one &&
> +
> +	test_create_repo client &&
> +	git -c fetch.unpackLimit=1 -C client fetch-pack ../server HEAD &&
> +	find client/.git/objects/pack -name "*.keep" >keep &&
> +	test_must_be_empty keep
> +'
> +
>  test_expect_success 'filtering by size' '
>  	rm -rf server client &&
>  	test_create_repo server &&

I once worked on Git internals in 72441af7c4e3 and around, but that was
for tree-diff and today I focus primarily on other areas. So I trust
your best judgement, and best judgement of people who are currently
active in Git development, to see whether it is ok or not.

On my side, as a user and primarily looking at the tests, it looks like
to be a good thing to do not to create an unexpected .keep file.

Thanks, once again, for your prompt reply, explanations and for the fixes.

Kirill
