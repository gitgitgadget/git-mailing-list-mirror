Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1365E418346
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529371; cv=none; b=Kr1XZ2kCkAnpr+BkfFlWuQ3MaT+WR2vDDz/Z0PkML/roWgr5ssKZf89lrFJdH3AtJzqcvz2rAc1MgNHcZ+v1A1pw8zSrjkpE+wSYQd+yt2jOdjj0RFH82mqtl1KVCMiqc1h1zmN94NJZNG3e4yqNjFjOfaLy1h+TokvcZkcscgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529371; c=relaxed/simple;
	bh=wVh+6JjoJqL2s/ivvSlLB4X+abGFR3I6tPinrZgRc88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joplLiMK1P/rYATARam+lMJ5IzJgCijOAK02DFhMldCeJiMNZuiKN9JqTtINSztlv+KnTAC297dtoH0x0Mx3N9xzjyE97a8D+4B2En0nrohMy21d9RJD/s+Kj1o5E/HJ8OpWYTid/WnnI+WtfLRh6jSthdr4+LNrw2W3CQvLjEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M5dzLm9K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X/ClbcrV; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M5dzLm9K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X/ClbcrV"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D32961400179;
	Wed, 12 Aug 2026 06:09:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 12 Aug 2026 06:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786529366; x=1786615766; bh=VuX3h9mbF5
	xeBkZPQSeZSNhoEJeFILf+PEQgfxbxoC4=; b=M5dzLm9KC+xOhrYtuYM3XCcLGZ
	bwZflo8T4VXakJ6/+49m3ryEHVC4ImaJiyd/ePi5o+c5UyH0sEheKNkbG9XnmaCt
	8/x/EY4VwjNe9NKi7rCKksTN6vU0ZLfek1qdriFmaGhrAk9Xf2aq4FpFQsW0Z+TA
	vcxbSqDlzvRQc1jw/su6ltFfUBlpnWPqye8gKdtL7CKFvpv47eztObVdMqJN49ZS
	4Y5Vv79j4VpSW8H6ND1I6N51X7wHh+aOqLY09x8n8XpbKdtWLRumLjULYnOI3RN8
	q3M6SFR1NcQvDPj8g7BE2Ixfh40o9cARaBG/n4ympN8FF57RzNX9QQkK3jZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786529366; x=1786615766; bh=VuX3h9mbF5xeBkZPQSeZSNhoEJeFILf+PEQ
	gfxbxoC4=; b=X/ClbcrVZQryoD4ZmV/o5DYE9zPRS8B8KAjsxhzvo+Cc8yvcHp/
	ryq2J2jp0nwRCxZUrjmazJ55PwH5NGUVYDNybDMnR88sm1i4uR9gv3euz5E49tCi
	SoRtm9BzOH7sxjxW6GFg6Jvma9X9wFUBSXVCXsWejHhdBu0ZUi9c4tc19k+BCIwI
	xjZOwcVARAjvYkJZuhox1LTQ5EA65Mkg8y7zWfQ7OCt6Ka8GZypuqCL9/w0g7vrF
	eTVdMThp7eaciUmDd0WPZiHs9tn8gt8+jDF0EVgwEUZeTCn1p7qf1+SfTOyMBi/R
	K8JZNmjtt6dOYj5iKj8SCbcp2XAYzEWCO8w==
X-ME-Sender: <xms:VkZ8ajXd3cXt1h6DZ5zoht-l21bTiMys4nzWwawnxcqBWR-HQ4k9SA>
    <xme:VkZ8ahltpE-aQsfiE8k3YqVQ3v6NE0Gf335kkWwKc-YRbUH_T7Sc6qPQo8HoQx63j
    whl7X0zQL3jQw53HKFqZVSvZtMyKs2OLQHYA_Daacy15smGLhZWfeU>
X-ME-Received: <xmr:VkZ8atDfWxgz53PP0ycgzdzUXh_UQkUmSkXmM6nggj3cXkt4gkP4EMOOld7qRNHg5s-zQ83kEQQ8rny94Hda7_-6Zuzpp5RB6FtxX69rYw>
X-ME-Proxy-Cause: dmFkZTFo8iOSC9JvoMxBjO4Ie99vaEb5WPJX5R6Hm9DNh9nOA8Op6PpVn1b42NP9wIc/CT
    T6HIZpCdt8cLaO6028A0KdRCZ+zsmPZuN43BCIOMVnHcArh/jFluYmSaF/jMHt7tLBJp3w
    oF9Q1fOuvqT5VHxPTlbfsu6TD1yd0QRMgK2LMOsnIIwicllrHuz6SvPWvm9EKafX6atSNc
    0WUxzMYTJJiv5T92sQc/qkW+HS8waIly85RXXpqj9IfQlUDwQl7Ly1U4yHwlbTDMsPIWtz
    VNZUZgGYg2iVesN1CNyCnKZgkTNbqtUxyRDCB1tHmn0o6Gh51b8gTvT2hDociD4MJ8RHES
    2kvfF2pHFkHok/kujQGwxnoyVP6Moz0EqiMM/3+YRbUYPX2k4I6erRUx1hRpHjymW36tkS
    jkS7z/xTTBZxrTHiEw+yJgGS5Vdkfi+lvZHtWm/IfFw+cffcMtnCv6ew/we48hfajYLCO8
    SjXAiyS0xTYRXi70bE4BI4e7ZQE/YaZGRuI7tlDtXRpgYXVswqiQPpoI500JTB3GM3CLuZ
    A6nzdgFTF6VLUduudvzuc+V8eK7sCg1GWEeiyi/c8SQefb0i+TDlaWtscRWSXXiKt6gDsE
    InXElY+NWpizAVaEEniCXfzeBxHMYVlpjaMfPtTzTMhf1aM0QsY4XNdzzrUA
X-ME-Proxy: <xmx:VkZ8apd0zcVFhuvyPx13vZwCZ852T3h6xoce-LJoTmpt3Kq-m2kovg>
    <xmx:VkZ8agLMNCbtLzH9hD3w5vkygaNEXtC_vzTBbEGnVtbW9My5kdJ__w>
    <xmx:VkZ8akeUNB-gSNtNo-t63sohssNBQwRzWBu5bB7Gs3QQJMe7stGYtg>
    <xmx:VkZ8av2eo6WEltjeyiAKSEz13QojLHyolLZbpdjjfAe4BfpgwGxNgw>
    <xmx:VkZ8aoHjBLcWrXMB5rrGMZOrwSh8RZANcGv8O4zFNMlKbaa4yfibEUaR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 06:09:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1b2eb790 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Aug 2026 10:09:24 +0000 (UTC)
Date: Wed, 12 Aug 2026 12:09:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] t7900: fix flaky "maintenance.strategy" test
Message-ID: <anxGUVck4I30Jw2M@pks.im>
References: <20260807-pks-t7900-fix-flaky-test-v1-0-08d0ea0fbbc5@pks.im>
 <20260807-pks-t7900-fix-flaky-test-v1-2-08d0ea0fbbc5@pks.im>
 <CAOLa=ZSW+Ta5ktauamTUvp+fmjC4HHDpKOQ0sri+pBfLGq6mOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSW+Ta5ktauamTUvp+fmjC4HHDpKOQ0sri+pBfLGq6mOg@mail.gmail.com>

On Wed, Aug 12, 2026 at 01:46:14AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > One of our tests for whether "maintenance.strategy" is being respected
> > in t7900 is flaky in our CI systems:
> >
> >     + GIT_TRACE2_EVENT=/tmp/test-output/trash directory.t7900-maintenance/repo/trace2.txt git -c maintenance.strategy=incremental maintenance run --quiet
> >     + test_maintenance_tasks trace2.txt
> >     + cat
> >     + sed -ne s/.*"region_enter".*"category":"maintenance\([^"]*\)".*"label":"\([^"][^"]*\)".*/\2\1/p trace2.txt
> >     + test_cmp expect actual
> >     + test 2 -ne 2
> >     + eval /usr/bin/diff -u "$@"
> >     + /usr/bin/diff -u expect actual
> >     --- expect	2026-08-07 06:20:51.388322602 +0000
> >     +++ actual	2026-08-07 06:20:51.388322602 +0000
> >     @@ -1,2 +0,0 @@
> >     -gc foreground
> >     -gc
> >
> > When running with the "incremental" strategy, we expect two git-gc(1)
> > tasks to have been executed, but sometimes the test simply doesn't
> > execute any of those tasks.
> >
> > A first hunch may be that maybe the disk-state is sometimes different
> > and thus we decide not to run maintenance. But git-maintenance(1)
> > doesn't run with the "--auto" switch, so we should execute those tasks
> > regardless of the on-disk state.
> >
> > But there's a second condition that may cause us to not execute tasks,
> > namely when the "maintenance.lock" file exists due to a concurrently
> 
> Nit: s/a//
> 
> > running tasks. We usually disable auto-maintenance from detaching in our
> > test suite to avoid exactly these kinds of race conditions, but in t7900
> > we unset "GIT_TEST_MAINT_AUTO_DETACH" and thus enable the auto-detach
> > logic. The intent of this is to exercise git-maintenance(1) closer to
> > how it would run in a real-world scenario, but it does cause us to race
> > when the detached maintenance job that was triggered by `test_commit()`
> > lives long enough.
> 
> GIT_TEST_MAINT_AUTO_DETACH when set to true enables auto-detach, but
> also the default value when unset is true. That's why unsetting it
> enables auto-detach. That's a bit confusing.

I'll reword this paragraph a bit. Thanks!

Patrick
