Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE737199EAD
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370109; cv=none; b=O8JOdSKWCYxEX4gzIMLgQcdBIf2B3pFnAld+egaxJPK2sHqxaLkpGpvJdZnks2kRVrakRN3QBtIuUzfDLcb2WOASYGXk+A2t58akrRLNVGfXAbAn1N8rjPx44coPsX3YIq80p5bcbgs24PtMAFnPMRYHluJWRjkgq4qptgUkKDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370109; c=relaxed/simple;
	bh=iFHrfiYk/QRtbVnsLtv7q6e9Rt4vVFDvYvl5RdKD1wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnOU+zpnk3Zf1eJQmJY5F73iyDrlkDTr+RYt8/RY9WTsmvxMfK+zx4teei48GnG4nqPgQLb4+AU0xFpMnlEvSywIwdYc0fLd2CBwxO+xPaesGqLjDNQxvJITs0bxIsuwDoIlBZGLIWsrMKaCi8VwDexasXMkpPX5mJ4h7D/VlFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S9UaPlrJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XYcFsOdN; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S9UaPlrJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XYcFsOdN"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F00A614000F1;
	Mon, 10 Aug 2026 09:55:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 10 Aug 2026 09:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786370106; x=1786456506; bh=xXCC9j+0K/
	HP6uFjkJj60vRo22OKsiC13Z5H2B/3sMc=; b=S9UaPlrJIELgHfVlsHvs/YKAQG
	0KRN7/DOFb5i2cu5OgvHv/bF7BG2ku1Qqo7LAFzBzaeBKg4cI6VDsfSZaqrC/yUE
	IHW2xt+EZJrm9986HVvNKvLkmMn3+YVfd2wBHdxUnxsNY1Q4rM5RQT7nAbhk3cxH
	zd6wSgc6eepT00bMSHU3/j99SAhuapcv1oJQ2plV5mGZA6wNWBO0b63Onvp2naVF
	z4xI3DHM00Uds5wJ0NiNvTHh5H/G+UE4nGZaEJEoEK0Ol3jSFrsAE2utIfJm8dAK
	HwPFS8N3ts6zct2knvwAgMalB7PpetT0rzYXW13qj0nT7G6H1ujytVFUrlcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786370106; x=1786456506; bh=xXCC9j+0K/HP6uFjkJj60vRo22OKsiC13Z5
	H2B/3sMc=; b=XYcFsOdN5+hC653O7Hj0rSHryXsJx73V687cw3xAinDb2jdue/d
	O1gH1sMceF0eX2tm3q57X4MOOye5GgQYdRKAoArtLuxLRjSEO49GYKPbyadA5eJP
	xUuMI69U2PBMoHuX1NwR6nGHCttrPc0DVTU1ZGPcLYugcbyJaA9GY34nZoClGyIp
	Xgt0xKZqmzF7JMXwanbqtpGj9529ejqVDJo74vkzGjIccjGrAIewzljYtjOe16o/
	4kJ1SIVEyhN+aUqorI3wDb8H7fiyFpc7VQsWQSkZyX5z3cIjWVpl4XlsZCoRU/hT
	txPXL0I2b/vJ5kCcj3KF1H23eovJ6ksuPug==
X-ME-Sender: <xms:Oth5avAirNrDQXi_XHat3Vl4X7RxEMYoValTkOBqSgD_vV5rF17TBg>
    <xme:Oth5ashAHXs47l5VY_brzuXuW_fmCchjB75vtuPANGVXSNOnrAl9mv5xOToZ-1lsw
    PwPsGDdTRFOiqkp3bjrOke8HW7XaXBwVWvKNc3AlMH2S10anN4CZw>
X-ME-Received: <xmr:Oth5avlS8knTRRJvddo9-J746jXrZcNXuaSeOpZQ6Kt1Qpvfkhws1LX3nMjXppdKBizOtSOxjackHupX4pVa0f5m1DvJWwu_rdrVa-KXIg>
X-ME-Proxy-Cause: dmFkZTGZUVoi12d3aw3jfdrJiBGlSnbGvViWEQb5fnTXflFzxNsAusHb6vlqH9W6GDHI42
    wqQCYHO2nJMKlvOX+ZlAwuDdi3xgCiISp6twT3VzHAMWa5gnpM/24yf6q8yVjt4JUuAui6
    KoKUFjzZEjwE3xIKMsVFNJ/fmvIe0kdyntnbXxd6olYYC57yGYyJg30WIkiHm5/LD2d4Xn
    NdqjM+Qr6yO8Ow5dhOAWg4Luwlqha7579hETzh2dNWUeaDS8kDVKTApfR+G0JpdlOV2W0I
    WEaOPa5/JrsBhN50AD7xc+h5Tr+eM1Whhux7dsHItjseWOhbiU+gNogL50LRRu2DgMBAAV
    Ypz82Gt+6voVENgDLdHr5Qs9Dxyjp8ej/BTM477zgas1dF/WfZCP4OlzTZ2HsB1jLMMSLd
    iS2SU0oGTjEcJeNICImca0vwy3yEj7FXEbruVUiKdwEQt4tP2XwMXwDIYN8WB6YpvmK4xR
    S5skcNWQf4TsSKfQDnF5GjamUqtPMigyAYVhEcz48vL8hM3PVZLzqX706oc6WHSN6A3UqL
    uCWulAlSfOPvrWPFhH77wgyjyk5tvRCM/+ONgJqUrJ4sb+ABkwEtDWb84S70VYDFPBpnH5
    LCC0dpXhcv37GBShAkPQMBX6dqgeezxD9WZ2ZUycaFFBezDzy275eqwXSkZw
X-ME-Proxy: <xmx:Oth5agoYZXdO3l-J1fGZ_Xy9tWJmT1iTDFR-YeJ1uZ5ptnxvo3MMdA>
    <xmx:Oth5agFuHSxRxa0gnzsameXESMqcNiFfzR1P1gws3nv1UQbvH8Np3g>
    <xmx:Oth5akwK384Y61WKxFu8KvMAggWOpawONMFero5b00peRWKs5F_G7w>
    <xmx:Oth5atq9MmYXFEeY1Kd1TlsdVYk_bUDo7oZez1_tQm7VyOogaM85gQ>
    <xmx:Oth5ahO-UcurALea-oX0xgFSyVu_ODd0EQBqhCV0RpVUbweVQA-dgTT8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 09:55:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1dc39603 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Aug 2026 13:55:03 +0000 (UTC)
Date: Mon, 10 Aug 2026 15:55:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Stefan Haller <lists@haller-berlin.de>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/8] t: fix races caused by background maintenance
Message-ID: <annYNOWrEx1PwjQw@pks.im>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
 <20260220-b4-pks-maintenance-default-geometric-strategy-v1-1-faeb321ad13b@pks.im>
 <17d460c0-564e-45fd-830e-548f60e01e01@haller-berlin.de>
 <anlfk0P7UillhlUd@pks.im>
 <801031d7-f219-4410-a863-7410cff7952f@haller-berlin.de>
 <anmNX-WVohAyjEcc@pks.im>
 <4f6a96ac-d993-4872-b3c4-30d899f61ca9@haller-berlin.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f6a96ac-d993-4872-b3c4-30d899f61ca9@haller-berlin.de>

On Mon, Aug 10, 2026 at 12:45:57PM +0200, Stefan Haller wrote:
> On 10.08.26 10:35, Patrick Steinhardt wrote:
> > On Mon, Aug 10, 2026 at 09:37:01AM +0200, Stefan Haller wrote:
[snip]
> geometric_repack_auto_condition() (builtin/gc.c) passes its threshold to
> too_many_loose_objects(), which does not count loose objects: it counts
> the entries of .git/objects/17 and scales by 256.  In v2.54.0:
> 
>     int auto_threshold = DIV_ROUND_UP(limit, 256);
>     [...]
>             if (++num_loose > auto_threshold) {
> 
> and equivalently after the rewrite in v2.55.0:
> 
>     /*
>      * This is weird, but stems from legacy behaviour: [...]
>      */
>     int auto_threshold = DIV_ROUND_UP(limit, 256) * 256;
>     [...]
>     return loose_count > auto_threshold;
> 
> with loose_count coming from ODB_COUNT_OBJECTS_APPROXIMATE, i.e. the
> same one-directory estimate.  Either way, any limit <= 256 collapses to
> "two or more objects share the objects/17 directory".

That's by design, and is also true for git-gc(1).

> That estimator is fine for gc.auto, whose default of 6700 needs 27
> entries in that directory -- a number you only reach with thousands of
> objects, and whose documentation says "approximately".  It falls apart
> for a threshold below 256, where the smallest representable estimate
> step exceeds the threshold itself and a single fanout collision decides
> the outcome.  For a repository with n objects the condition is satisfied
> with probability ~1-(1-p)^n-np(1-p)^(n-1), p=1/256: about 5% at 90
> objects, and much higher for repositories that accumulate objects over
> time.

But I tend to agree that the default value here is too low. That's an
easy-enough change to make:

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index b578856dde..da8be9f812 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -101,7 +101,7 @@ maintenance.geometric-repack.auto::
 	there are packfiles that need to be merged together to retain the
 	geometric progression, or when there are at least this many loose
 	objects that would be written into a new packfile. The default value is
-	100.
+	6700.
 
 maintenance.geometric-repack.splitFactor::
 	This integer config option controls the factor used for the geometric
diff --git a/odb/source-files.c b/odb/source-files.c
index 5a68af7d84..555e466145 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -521,7 +521,7 @@ bool odb_source_files_optimize_required(struct odb_source *source,
 		};
 		struct existing_packs existing_packs = EXISTING_PACKS_INIT;
 		struct string_list kept_packs = STRING_LIST_INIT_DUP;
-		int auto_value = 100;
+		int auto_value = 6700;
 		bool ret;
 
 		repo_config_get_int(repo, "maintenance.geometric-repack.auto",

> 2. The resulting background repacks break concurrent commands
> -------------------------------------------------------------
> 
> `git repack -d` installs the new pack, removes the redundant ones and
> then calls prune_packed_objects(), which unlinks the loose copies of
> objects that are now packed and rmdir()s the fanout directories it
> empties.  Doing that concurrently with unrelated git processes in the
> same repository is new exposure: before v2.54.0 the same repositories
> never reached the gc.auto threshold and no such repack ever ran.

Okay, so the issue is basically preexistent, but because we now repack a
lot more aggressively it's surfacing more often. Ideally, we'd fix that,
but it's also clear that repacking too often will make us race a lot
more, so we should avoid doing that too aggressively.

Does the issue go away if you set `maintenance.geometric-repack.auto=6700`?
If yes, I'd propose to simply change that default to be in line with
what git-gc(1) uses.

Thanks!

Patrick
