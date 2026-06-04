Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6069D3F5BFE
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563735; cv=none; b=rapBayotskyhr++OGCUlq7GonKAyPlRZPxu9RbC8VFN8YvUzIZwNGc7E/cAj3CBpwa7OTmMTE0LJwV3ZYKHE9tjesn52B65WB7h+LMDY0cvpBZ66A4tos4vxk6MuDQqrsl+pFWQAhpCPJBv8p5Td6eRxNziOhVw0GaIPZqo7Vu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563735; c=relaxed/simple;
	bh=Y/ZE4xb6xY8GgaNitGCI8+/q2+wTt4tFxPQTOuv2WeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPxGeb7+A0a4sQkp+lhNtBpL8nvUc4kIlMxhdu3mKNUOq4h66EkdILvcTGnxRkxEr6nSiynToC7iXScyBkPlva/9W1QpLgHBoPtjByVHRyOzijz8YxGB2kLMFno42+B0uDyPGaZTnTPKDAmyWlWm8WQBQMLY6yNd2rv4paPrI8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sMuQd9n2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NemLc9s/; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sMuQd9n2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NemLc9s/"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9C52C1400105;
	Thu,  4 Jun 2026 05:02:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 04 Jun 2026 05:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780563731;
	 x=1780650131; bh=vBpMF0m2LKubEjgdcXM86jiL64+MWv0lsq1XviUig3w=; b=
	sMuQd9n2w1jRP1avQWMm0QOAmoSWPSV6Zyxz+nDIvZXQslvMv3dxhOrXjP6/Ux6k
	dTzZu5GU+59UaqqiGh2a1VMaJA0cdTLnVtOj9O8BU6gWkoiYPssJ0uRiqx2Tcviy
	oVcO/ZH3/iT3zjMAjVcGA8x5ppysQsgiFq+xjhE9Ux1sgSQ3BEWNlwtmTUi6Y2/4
	CcV0NNmZ5Pa3kFSLNaYijHxVuJQc/PYLS6TJoOTfa5z/ETqk2kbDhpAQM67hQ94H
	nfV+TFtPfNWb8sc+ju39uWXfqD87/MBzvcNCKZ3iFVkbmRQ5wYZm7RE8mT9dx+Ci
	uacNGvFw+X39+XRyi6IZfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780563731; x=
	1780650131; bh=vBpMF0m2LKubEjgdcXM86jiL64+MWv0lsq1XviUig3w=; b=N
	emLc9s/5EagELw9zt2NNRKAxx/d47xgDlU8YSUOWBbHAZDAAGryIk25WUkZvw2me
	IJK+WEcQ+UzI6pkdILGrYQMxtGCI/FOMP4cX4bc1PP/+KiDniGWutbGt8fpBRWhV
	d6NhJ+vJmH/PfnjjeVIwPG2AMeIFjj0lZWT9LZ3UgOynmPFKcXMaxtAKV3tiAO9h
	tPTLJzloEJttYSXouaZTH0C+ghOMb59iT/VZXb7KTupm1afhZoTmFqUgHD7Za79X
	z2KRGxK0Ts4gkgD2ko7FW/bvPEsW+vyDDICD3AWSq6Fh+BRgYmXijVTLLEo6rGqK
	9HK3rh3tOZjQqMBx7U57g==
X-ME-Sender: <xms:Ez8haqzgC0rD5om5NqhMWjoYcwtIzw_rcB_tIokCoxED98I-OtV23w>
    <xme:Ez8hatTxp9wTvQ95xzCLn1TbZNZ6rr-Yziqo8woNuD7vIaeT4EmXN-jGr5i95Obvr
    4xrOo2F8lp4ARgiczvsXgYwkjCEjjnD9FqBKlfxXIZo3_bn3NlUtA>
X-ME-Received: <xmr:Ez8hahV9IAzTisxvBF3T7qLOJfQDX4vZWXo0oJeJqFyE8If0moc_BvDZxBpy1NqC5nDXg8wYRzfsD0V89sW-qu533_6cLIy8Otn1aTmBjQM>
X-ME-Proxy-Cause: dmFkZTFn9bzQHbFrnrlTFPIKvDTDYZcL/ucrX6VwXLS/Wz/LVLaO74OUXHs1AjC4M6dCwB
    r8chH92zwcUil8mybBL4DW8JszN2pi65mxvpjLQT+XZkVnvw/WH19Xa3XSb1NsIfYpeeLo
    3HPMTVI3PHPPE69HiW+NPuSDrziCe+iEbhReE3FUAnjPOcEy4erwKlIs6kRzPJmJBZu4yd
    9gnOOK7pxF2tBfca7c7CxrGahELLTEYEi26/yMpt+Oh0ZXdXgElPgGWhMcTaF8yZr8NLLc
    DKL5qSCCnkWqTbqv2ds2UYhyQCWw72EU4/3GJpwrZSgnhUM8R18EAHh6BvJK/r/8aS2qma
    BQsvMFsDqyh0jIZ7Hbeug4kevEI4AFhvwGGhHxM1pX4KKqPa65yLa1vcsdpS7jBdqZ7x7Z
    A/ENJNjs+YkCJKqstvBNupVIq6zYCjVokLPYM6VzSS5hZTTgLoW7cla5PFeuvotdR6e03N
    EievdWSjWeETbTWZ/zsfB7ZR3R+d/NoVU04x3XbdcgXiGLKd7ouqUhthz2s1aYXUlFGVHU
    xnJuS8R27+iiHw9S/40qF02NF45gfEZ8yiEohyAWcCuBdvEdtMDYbDdjkpE2T3GWCm4Q+9
    77NPmteOMbY7uphzo2chFvEpRKtmIvuoLJlyXLjoKSu2b9od38YKai0yOZ7g
X-ME-Proxy: <xmx:Ez8havYtsriYrzsw2S4Z5FsnvxjFzYT4LTzMqx3dC4UJrAbmjfiryQ>
    <xmx:Ez8han3LMRm9K34wnyTcmL3TNFlZl1MJ1rbMD-ndvWkfoE8ENnA0Og>
    <xmx:Ez8hahhA2MIAzRSYW47wGzSB4FZ5AtKgEKfzmfKO4kljXRNuF4lH2Q>
    <xmx:Ez8harbts614A63sJxKi_CI3yWkZhBwCbPFKbBJtwafDI2QhQoHDxw>
    <xmx:Ez8hao3vJfHy5fH1K5SqqEwuVYyBrh6dl2aCbR-7ZAKmjvTNjxW-mNBF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 05:02:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bacbfbb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 09:02:10 +0000 (UTC)
Date: Thu, 4 Jun 2026 11:02:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Pablo Sabater <pabloosabaterr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 9/9] builtin/history: implement "drop" subcommand
Message-ID: <aiE_D9Dzryfx8iQI@pks.im>
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
 <20260603-b4-pks-history-drop-v2-9-742cb5b5176d@pks.im>
 <4b4672de-17cc-426f-8498-6384b1ad0d06@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b4672de-17cc-426f-8498-6384b1ad0d06@app.fastmail.com>

On Wed, Jun 03, 2026 at 09:04:33PM +0200, Kristoffer Haugsbakk wrote:
> On Wed, Jun 3, 2026, at 18:14, Patrick Steinhardt wrote:
> > diff --git a/Documentation/git-history.adoc
> > b/Documentation/git-history.adoc
> > index 2ba8121795..4eac732fd2 100644
> > --- a/Documentation/git-history.adoc
> > +++ b/Documentation/git-history.adoc
> > @@ -51,13 +52,28 @@ be stateful operations. The limitation can be
> > lifted once (if) Git learns about
> >  first-class conflicts.
> >
> >  When using `fixup` with `--empty=drop`, dropping the root commit is not yet
> > -supported.
> > +supported. Likewise, `drop` cannot remove the root commit or a merge commit.
> >
> >  COMMANDS
> >  --------
> >
> >  The following commands are available to rewrite history in different ways:
> >
> > +`drop <commit>`::
> > +	Remove the specified commit from the history. All descendants of the
> > +	commit are replayed directly onto its parent.
> > ++
> > +The root commit cannot be dropped as that may lead to edge cases where refs
> > +end up with no commits anymore. Merge commits cannot be dropped either; see
> > +LIMITATIONS.
> 
> Should section names be “bare” or quoted like "LIMITATIONS"?
> I don’t know.
> 
> Maybe add “above” since it’s a previous section.

Hm. I think I'd prefer to keep this as-is, as we already have
preexisting documentation in the same manpage that does it exactly like
the above.

> > ++
> > +If `HEAD` points at a commit that is to be rewritten, the index and working
> >[snip]
> > +Drop a commit
> > +~~~~~~~~~~~~~
> > +
> > +----------
> > +$ git log --oneline
> > +abc1234 (HEAD -> main) third
> > +def5678 second
> > +ghi9012 first
> > +
> > +$ git history drop def5678
> 
> I know this is only the most simple example. And I might be dragging in
> something beyond the scope of this example. But I recall one
> demonstration on the first git-history(1) series which used a lot of
> revision expressions and someone saying that they couldn’t imagine a
> workflow where this would be more interactive than bringing up the
> git-rebase(1) todo editor.
> 
> (I couldn’t find back to this right now.)

Yeah, I remember this discussion.

> Although it is slower in terms of machine cycles, the keyboard instinct
> for dropping a nearby commit might be to do `git rebase -i @~10`
> (sufficiently high number) and navigating quickly in the configured
> editor, deleting the line or using the keybind for `drop`. This example
> which by implication brings up the log in order to paste the abbreviated
> hash isn’t as ergonomic in comparison.
> 
> But using a revision expression like searching the subject with
> `main^{/second}`, while not quicker probably, does distinguish itself
> from git-rebase(1) by being a pretty fast ad hoc invocation that can be
> done in one command without futzing with some weird sed(1) editor in
> order to navigate to the `second` line and deleting it, or
> something. And that’s a small win in isolation, but it segues much more
> naturally into letting you script, say, dropping the last commit that
> starts with the subject `TEMP`.
> 
> Or maybe revision expressions is too much in this context?

No, I think that's actually a good idea to demonstrate how this can be
used without being too unergomonic.

Eventually I still have the idea in my mind to implement a TUI around
git-history(1) that allows to drive its several subcommands without
having to laboriously select the right commits. Ideally, you'd simply
select the commits you care about and then pick specific actions you
want to do on them, with a nice visual graph that updates after the
operation. But that's a bit into the future, I guess :)

> > diff --git a/t/t3454-history-drop.sh b/t/t3454-history-drop.sh
> > new file mode 100755
> > index 0000000000..37d8413e7e
> > --- /dev/null
> > +++ b/t/t3454-history-drop.sh
> > @@ -0,0 +1,513 @@
> > +#!/bin/sh
> > +
> > +test_description='tests for git-history drop subcommand'
> > +
> > +. ./test-lib.sh
> > +. "$TEST_DIRECTORY/lib-log-graph.sh"
> > +
> > +expect_graph () {
> > +	cat >expect &&
> > +	lib_test_cmp_graph --format=%s "$@"
> > +}
> > +
> > +expect_log () {
> > +	git log --format="%s" "$@" >actual &&
> > +	cat >expect &&
> > +	test_cmp expect actual
> > +}
> > +
> > +test_expect_success 'errors on missing commit argument' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_commit initial &&
> > +		test_must_fail git history drop 2>err &&
> > +		test_grep "command expects a single revision" err
> 
> Why not `test_cmp` since it’s a fixed error?
> 
> Same for a few other tests like `errors on unknown revision`.

We tend to use test_grep for cases like this, even for static error
messages. I haven't really figured out myself when exactly we tend to
use one form over the other, to be honest.

> >[snip]
> > +test_expect_success 'errors with invalid --empty= value' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	test_commit -C repo initial &&
> > +	test_commit -C repo second &&
> > +	test_must_fail git -C repo history drop --empty=bogus HEAD 2>err &&
> > +	test_grep "unrecognized.*--empty.*bogus" err
> > +'
> 
> Style related I guess. Most tests here use a subshell but this one uses
> `git -C`? Why is that?

No good reason, will fix.

Thanks!

Patrick
