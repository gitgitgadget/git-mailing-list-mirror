Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643479;
	b=m7peg/tuE+Hqr79xF5urjbLWk3NeWeCTD9sjPfyycmJZAXEGXmS5e2Kx97/LP7H8JeGV
	 04jcxT7rbwD9KFJ9QkH7xpoEPxSjkOT4Ta9d7UQyn0B4AHK+fNlXjzqJlJXs3Ob8KheME
	 yw5X6Z1MmawKoky8kggV6RePgc/OYkkJ0FPmttwbTGF4IiMTjmQzC8RWDz6OH1V5kM3l0
	 LVV8O11gqiHoSQSUok1xxppe0Sf0rRIgOYri0yxrs/VH9IM5vdLVpzV80OCQDJDgUC5db
	 BAlmSSgBZsQo/7v1QMpc7o51RpZ5Q++mJiC4K4w1RfvX4lyGfjdLgN6Ufi9/rGFm/rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643479;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=uhFqi1JLYEWjUUvdQ0zvCadMBGbHKS5SU+FYs4oDzIU=;
	b=n5jRNSGGqsvfkDuBY+J5s/cs7xvwKehmrFvf5RJDL8AVOUGO/028nQH12+acnxTqOTN0
	 NdPwcZBeu3zWZ/pKmQ4Pb7lYDoWiXKxN8vfGfuwp65ZzFy/j+oegT1rOmRbsDdB3gd9wQ
	 0US5wAWAiq/spZiqg8gHSCBg31PZnkdAFQOiYSrNbJ5rIqdthDzU9oIIbk/Vy9lHFUfk/
	 BJtW24bdVOilEtK7oVR//k2pTR/u9fbxdJn7RqKWifHQ4lkGuX4/IMWQrDGXosH0COQOK
	 Vn4e0zCtdHYiG23YavgC0CRkN0CI9qCfB4de5ZoE85Fp3drOw3e+lsgOPunhuolcfwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=JXQIGhL0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UUetA1yq;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E86606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 18:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07E86606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=JXQIGhL0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UUetA1yq
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 569607A00E6
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 13:17:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 02 Nov 2026 13:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793643477; x=1793729877; bh=uhFqi1JLYE
	WjUUvdQ0zvCadMBGbHKS5SU+FYs4oDzIU=; b=JXQIGhL0E6u5SZP1AL/NYCLV9K
	nf9mmDtq/G5diFo5ifHcRH5YHpZpM4sHpjhme2WnsPMwA1+jOODoxdkz6geQn1LP
	QDUuKii9AjMR4G2+E9bkuyJVHD5Uwmn88OnWT+eplr7cG+ViARur2pAR40S4HMUu
	q7BmDvhawcXKEGTVDZVJe2Ljch28NMXVzMXk8VREV38bM0WSDQEMP28dwenwKC5p
	qJV8PTI4jw/KVXzc7Wdk9DsQHaXd4clkrp/DwPRUXta/xvGuuma4XR2Z3kBgZ+eQ
	r/iu2hR1Tl2RLv/4X2jdtX6g/SqxzhLPGQRY6XGVHXfBKMNNVxorCtJbfsAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793643477; x=1793729877; bh=uhFqi1JLYEWjUUvdQ0zvCadMBGbHKS5SU+F
	Ys4oDzIU=; b=UUetA1yqeiFEYZ/huhOtT8ie2ihZ0RvZqvELT+0cbbV+mKbVqEs
	l1nN41t8K8qRaLHTRVW0iEjVUhGEnw641vqK2R19DsCHlHutqUKEW7vzjZ+150/o
	nNHE9UH2CE0zU12uP1EPNORmTDyr0N9FSoS/36XN+iYQ7yym9FRpK8vbplY56uFt
	Tqn9ifZZKLrF9w4ReeXjlq7OsF1HuxCATz5i2ElbymQa4j0sXAbGBPnSAFZp4SVe
	ZRcQOQ4sWWR6L6/46ZYb1QhXZg+qpuNd5xYTjbI0LmrzDEPAk240FUL8TFnO5tz6
	MMavxSR20TJ6iXhSL9pVfCEPO2+YzJeuNHQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793643477; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:lFvOTogv2pwpsoK1iyyEMe/hXisuw6OQzxzDQDwLKKA3gKB
	ffRQoIaKefhu9t5nJwSMivhM9cJxO7bMgw2Veb/Xun9AzU+wlZ0hHoi6ktggSBwR
	GXkJZXWHlSHcPALW8iLusK3wVBY0kIbTydQ3ySfwjZ0hmlUNCMxViQ6n3sK8bxtX
	JfcZYzlqPjMplCkUHh+ndMeGiPqyeBBDAnN6T+12tKBK8Boz2zdTxSpMaZOMMyO9
	LxjuLuwn2WdVlz2XppCO20CrQ7I6gSvqFvet3o39nL2ewfMVzIv6L2z/9sAt7iaS
	c7bTwYIuvGDkvRfPGil7sfXC7IkYfYB97dilmRA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:S9W2ZM0K3Fslyw3dBBHVvVLkeHfFacHDDsXh3X8YeQQ=:J7zhTDPt5wLtEuUotZY7nw1PtBRM6L/5N/pY/wYpLEM=;
X-ME-Sender: <xms:1dPoagzNAzOeZpknp7vUMaBnUL3H5TdCA9AsL7r84WaY1NgiRDoUiw>
    <xme:1dPoarTWFfUmF9HH5x7flnvOIi9DXLjo-UXLmRyfTLwz8YwpGNEakya4lMFkdNnsK
    0PuGZ-cPvLRGOfpq135aFW8S_zm73bXtjB2dVt6Z6NNC4Akxh4KEoc>
X-ME-Received: <xmr:1dPoanUwDG3uJ-4zvJ3dCG0jlfnGxrBF8z1jjVh24C8ho-Ee09wZFnNRFDhN4o1X0M6YaBZGsYh_vJxPbCvJGniDrzRNz1iGdPiQ>
X-ME-Proxy-Cause: dmFkZTGjl3EJMcBmCaYziJRTet9gPG6/Vr9Id7ATsRCyUN/pjOJnsZ07zboIysYFmaZzRK
    XUgcRz83Coj3PDe9GE0bPR4WMc8IFZIEby3HIuNNG6W3RD7LRtrLCCwQNjiqnrah+ahlZU
    cdFK1yqd6vXDm2PqhlLu0R9nOoUmnlqLksn9CpaeS54Javp4/dIbPP4ZKiNUYrVRMMnIA3
    InIYYpKC9KruwFue53FvBf5rjwHQDGcIVBIjhNX71qHyZt3/voxNQidMm9HvU4AU8AOf7e
    jjQIPF1cmL/WBApiuZbeAzR88/4JhYd6EoT8Dv7dlmLneEi1QAfFEu/cxk1MulbUwufGb6
    W/f9dtlyPpscyouOqjQFim2PRMT3HKQhjcuN9NQBN6wc1GzoSllohXv+egv5PnGhavfhfo
    TYo8lzAOUZYGT8prH7dvY/6OprAbd8Pss2wERqOGLdtcfoxcP83G2KxWRbbiw/U1/V2qzm
    KMI/4ZNgFfJ4w0fqW7woHSwXONXrjPGU1abBKvbq5j681ZyQ65chdvde9dqHCmGCKPpsRE
    jT6b36e/Zr2cMo2zrCIAf4ozwpCM36enCCe1iRFKEd8bXcF2228IKOzsc7H9MFKoHsnn8E
    BrSW19H7hHm3LMLdihXo+ifb/uWMZliR60uUy8fUWa016vv/qFmj74Te4unw
X-ME-Proxy: <xmx:1dPoatbNtVwGedVuvnmmh8i3iynFugJ_3l5-bJK8ZR3KFlVA9tyJUA>
    <xmx:1dPoat0d4NKHYivRYMUnZ5azpK3QcW7qOF9SA0FLFU1VSE1-mOqs5A>
    <xmx:1dPoaviSk6B1Qo3V_s-2zxooGciItfQF3zkHJb0Pt9Sof0vp09h53w>
    <xmx:1dPoahZ3awkGCYd5CUR-2hJ5nrC6l-aC4fmQpO1IX8dxeMTtPq97qw>
    <xmx:1dPoak4px3xy8kq5yJbqiQThRgflbOpgX3c4iMqxcy0Bl2St8WXXt01h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 13:17:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Tian Yuchen <cat@malon.dev>,  git@vger.kernel.org
Subject: Re*: [PATCH v3 0/3] environment: clean up repository config handling
In-Reply-To: <anlmwaEtwcCPse1N@pks.im> (Patrick Steinhardt's message of "Mon,
	10 Aug 2026 07:50:57 +0200")
References: <20260805115342.3939931-1-cat@malon.dev>
	<20260807085932.3958759-1-cat@malon.dev> <anW7wHfUxYj9cj0P@pks.im>
	<xmqq1pc9eivn.fsf@gitster.g> <anlmwaEtwcCPse1N@pks.im>
Date: Mon, 02 Nov 2026 10:17:56 -0800
Message-ID: <xmqqh5hzjdwr.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Aug 07, 2026 at 02:11:08PM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > On Fri, Aug 07, 2026 at 04:59:29PM +0800, Tian Yuchen wrote:
>> > Somewhat unrelated to this patch series, but I was wondering whether you
>> > plan to drop the limitation in `repo_config_values()` that requires that
>> > the passed-in repository is `the_repository`. ...
>>
>> Hmph, that is an interesting point.  What is our plan to really
>> enable the use of repository instances other than 'the_repository'
>> here?  They of course need to be initialized with repo_init(),
>> but is that enough to sensibly use the embedded 'repo_settings'
>> and 'repo_config_values' structures?  (By the way, it is not
>> entirely clear to me why we need both and how we sift variables
>> between them.)
>
> Yeah, this split is adding to the confusion indeed. I think that we
> should make it a goal to unify those going forward.
> ...
> I've been wondering for a while whether we're operating at the wrong
> level here. Both `repo_settings` and `repo_config_values` indicates that
> we're operating in the context of a repository, but as you mention that
> may not even be the case.
>
> I don't think the approach is inherently flawed though. From my point
> of view, the best way forward is to merge those two and then generalize
> them into something like `git_config_values` or `git_settings`,
> depending on which of both variants we want to retain. We would then
> have two levels:
>
>   - One on the repository level as we have it today.
>
>   - One truly global variable, because that stuff in fact _is_ global.
>
> We'd then adapt `repo_config_values()` so that it knows to populate
> either of those variables depending on whether or not the user passes a
> valid repository, and returns a constant pointer to the respective
> structure. Callers MUST NOT modify that structure -- if they want to,
> they'll have to make a copy and pass it down the calling stack.
>
> The last part about not modifying that structure could be quite a bit
> painful though, as it would mean that we might have to adapt call chains
> to pass down a `struct git_config_values` instead of a `struct
> repository`. But arguably, that's the right thing to do anyway for at
> least some subsystems that are independent of repositories.
>
> As you say though, none of this is really related to this patch series
> at hand, and I don't think we need to resolve this discussion before we
> can merge it. I just want to make sure that we have a plan for how to
> get rid of `the_repository` instead of only shuffling stuff around.

Even after we punted on this and stopped the side discussion in
early August, there still are topics that want to move things into
repo_settings, or even worse, repo_config_values.  Until we have a
plan to fix repo_config_values() to take an arbitrary repository,
should we freeze this part of the code, perhaps like this?

----- >8 -----
Subject: repo_config_values: freeze the structure for now

The configuration and settings per repository is currently in an
unfortunate mess.  Especially given that repo_config_values() cannot
work on any repository instance other than the_repository, moving
more members into this structure is unwelcome.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 environment.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git c/environment.h w/environment.h
index 9e175e410e..03b1b35d6a 100644
--- c/environment.h
+++ w/environment.h
@@ -124,6 +124,13 @@ enum object_creation_mode {
 	OBJECT_CREATION_USES_RENAMES = 1
 };
 
+/*
+ * See https://lore.kernel.org/git/anlmwaEtwcCPse1N@pks.im/ and later
+ * discussions.  Until we figure out what to do with this and
+ * repo_settings, and allow them to be truly usable on a repository
+ * instance that is not the_repository, do *NOT* add any new members
+ * to this structure.
+ */
 struct repo_config_values {
 	/* section "core" config values */
 	char *attributes_file;

