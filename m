Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAF29443
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307512; cv=pass; b=coTgsgd8fODlAjAD/s5icR57JfFQ/NPNdBVLRfJOIjNrUruSVEv6k4fzuQEvdph1WuzeDWlCfeVFtyUwNEvgmlhDzRlOQRJE4JHukFNRcOXGhnWI3tfJhN+s8s8nK6JPkEo7AwGs0UDad/nncLjEmIpAn6jXL4Atk8HIMFqyx5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307512; c=relaxed/simple;
	bh=zwGNVSIm20kd0E0YIDugkmYf9/dufo4k5J+knuoJdRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kCt9qiBWOkpysY69zqsYCBFKK3AIIJaEyusU5AEY7LDZjW8gaby8PZ/43my7PWszs3CCLv3RSIhIQJaBQanyayUyVGkHpbYZ5ddnN//GD8/t9ZhDefi7BpOWnNpatvneN+k8ZzwprydXxvsqIfS1KuhjPSuPyJMo0MGlJdy9scU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=HJ39eqQY; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="HJ39eqQY"
ARC-Seal: i=1; a=rsa-sha256; t=1768307500; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OJHQzX2z7xo1kGeOO4DU03lZyKd+isMTjE6vIgV9SByBGACxlZBu7lAgR5/rUX2wOkIpuiyQZsNwNhbJGxv5tyjyr7++Y8Z+UyITqDfE7nwYrByZJmwrnl8fPjbZHliN+QkwnOWi12KRWPv/XaoqZyNamM7F9zn/Fs5M8wsxt2U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768307500; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YQhf680Na5+XxgS6k6QRA5biD0F6L0Xc4uT4spApD5s=; 
	b=YXih65p7fLHh0ZiiaP9EB3Tk+3w1ihj5y+3UgfexIac/v3SbO3ki5Q12IkknhwL4sKV+iFcA43x3yejEmbexaL3s6p78Gxr6ynCml7XOWwr3fQar6A/qw4VGaMbWjfX5hMgylbVPnWJX/RLe2jVlLkFphTpPE9ipKIu5lnssQbA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768307500;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=YQhf680Na5+XxgS6k6QRA5biD0F6L0Xc4uT4spApD5s=;
	b=HJ39eqQYYj6KoOI0QF5OohV64fw4mlyE6gNBd1UNH4yh6mMNfZ0kIm5j3nOQvh19
	wvygt/4cwy9Wym3NA8lnYClncUmIVfn8Mla9//DE31rWD2ODaqCxHcJNkfyQ5UkpeHv
	QHJdVD1WfHKCaxx2gA6nDBT96872MKNiYrmAiqBo=
Received: by mx.zohomail.com with SMTPS id 1768307498994858.3393982770984;
	Tue, 13 Jan 2026 04:31:38 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Chris Darroch <chrisd@apache.org>, "brian m. carlson"
 <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Chris Darroch <chrisd8088@github.com>
Subject: Re: pre-push hooks and stdout regression
In-Reply-To: <87y0m1onad.fsf@gentoo.mail-host-address-is-not-set>
References: <ab578804-891e-edcc-12a6-8b1030d1bacb@apache.org>
 <87y0m1onad.fsf@gentoo.mail-host-address-is-not-set>
Date: Tue, 13 Jan 2026 14:31:35 +0200
Message-ID: <87pl7diti0.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 13 Jan 2026, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> On Mon, 12 Jan 2026, Chris Darroch <chrisd@apache.org> wrote:
>> Hello --
>>
>>    I'm one of the current maintainers of the Git LFS project, and we
>> happened to notice that a recent change in Git's "master" branch has
>> introduced a regression in our test suite.
>>
>>    Specifically, with commit 3e2836a742d8b2b2da25ca06e9d0ac3a539bd966
>> ("transport: convert pre-push to hook API") from the "ar/run-command-hook"
>> merged last week, it appears that when a pre-push hook such as our
>> git-lfs-pre-push program runs, messages it writes to its standard output
>> are now delivered to the user's standard error stream instead of
>> their standard output stream.
>>
>>    I suspect this is because the pick_next_hook() function in hook.c
>> sets the stdout_to_stderr flag for its "cb" child_process argument,
>> and that function is now used to run the pre-push hook.
>>
>>    Arguably, the Git LFS pre-push hook program should write its
>> progress meter messages to stderr, but since at least 2017 it appears
>> we have used stdout for this purpose:
>>
>> https://github.com/git-lfs/git-lfs/commit/d665f7d725150761fe3b196da2c2d4448f7d2c61
>> https://github.com/git-lfs/git-lfs/pull/2732
>>
>>    We can certainly work around this change in the Git LFS test suite,
>> since our progress messages are still output by Git, just to stderr
>> instead of stdout.
>>
>>    However, I think there remains the larger concern that users who
>> depend on the existing Git pre-push behaviour in some way may also
>> encounter regressions, perhaps because they expect (as our test suite
>> does) to see certain messages either output or not output to stderr
>> during a Git push operation.
>>
>>    Please do let me know your thoughts on this subject!  If the
>> consensus is that the new behaviour is correct, we'll adjust our test
>> suite to match it, but I'll wait to hear the outcome of any discussion
>> before making that change.
>>
>>    Thank you again and all the best,
>
> Thank you for reporting this, it's exactly the kind of regressions I'm
> looking for and the reason I did the "Extending git without breaking it"
> presentation during the mini-summit a few months ago (video should be
> online).
>
> I tend to agree with Brian that going back to the previous behavior is
> best for now, maybe schedule a breaking change or extension to make
> hooks to print to stderr instead of stdout.
>
> I will test this on my parallel config based hooks topic towards which
> this conversion is building up to and send a patch or report back ASAP.
>
> Of course I will also run the git LFS test suite to confirm the
> regression and the fix.

I couldn't reproduce the git-lfs test failure using the public tests
from the git-lfs repo (they always pass), however this patch should fix
it:

https://lore.kernel.org/git/20260113115633.230479-1-adrian.ratiu@collabora.com/T/#u

Chris or Brian, can you please confirm if it works? Much appreciated.
