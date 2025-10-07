Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C9610A1E
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840876; cv=none; b=GXTy9MNjF75MlimxTyZ6oGiKabGnGp4urji2sN8wTF5SaSv/KcudLm1GDDcaYxEwX9G1d/QldH0Kpop7s60pjHXUONO8swxEYtfnuz4CP3l6lxGezrrAjopCfIaxMHlH1jubNbzXRb8Nrklf4dukX/2khyp+CatYi7GTwt/rujE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840876; c=relaxed/simple;
	bh=ofc6X+SMkB4+Y09N8emobteH9iX9qo84nm2smjA+MLc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ilkR2Oknx234djqVNshLHEDK3yAkniS7ONOzcna1KhOeI4y3qEKQzu1a+FkUUwpBwFDFMMt0COSCiSNjgDVt3gxmkSnAxDpJF7s+51FqkC7r7pQH3gODXsXpERo++szES27QOJysLE2OdKYnzUyOWdu6pn13IEWQWfUR9V4kIc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cCETSwED; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U9DCHDKv; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cCETSwED";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U9DCHDKv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C33751400027;
	Tue,  7 Oct 2025 08:41:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 07 Oct 2025 08:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1759840872; x=1759927272; bh=ad3qEcTNoB
	NCbRsU88j0FqBADwH1VNjjVe/ZgFFKNuI=; b=cCETSwED2881Uo4QuuLXof8zA0
	VlDxkVs1YB6jmyHL1/VWMmdz+Xr+7R0X2kEcB3zIQ7WCuZ/cjrDckA915+GJ0vjl
	YGh8pr8+4Gryfw/wibVIkwhaIwsswjV49x/dnIB2CMv8kpqErH04VS11g0gKtYIM
	sVUz/GqbMsBTd6S8PbqsFpzMTmYi86AUvjrKctiuurF613wIEG3vs9r5tKJCW1pc
	FYuyULwL1f7S+ZyiFfQyA//33p3jqxWPrj7eAoVJaOn3VhGNPXCQgZi+kuxE28gj
	qm5MX+y6tah6FS2G3MbvdQoYLX9CwlawDYMmEj2o9tr/Y8fY39AVDl8vz6tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1759840872; x=1759927272; bh=ad3qEcTNoBNCbRsU88j0FqBADwH1
	VNjjVe/ZgFFKNuI=; b=U9DCHDKvRgEe+DOgzhVaxRMw9eBTc3DZqpQjTRBEzFYR
	y4axk7dchMIyHWEZmtuJmJH2Y0bubCllKAYOs36DKuaY370Vas3K02oBJf0ZiYkw
	mIxiwiNcuE/dkaYxa1PwDsHDDioalnH7MhtvWbeCBRM6B/5VAGbzNswPcxwYtDB6
	uaDVAmTvko9MVxyqSovmx03IX1JdUs+1qftRb2Z7YUm61dBMfK7vAitegTeknbdc
	6IUI9mF8JE+tyEdksOAYjL7++TLXnNDcwYg4KMylddf8OKi06q+Omy2u2oBYctGQ
	ttzIr0fUStYywUIW/8fIEyLiEroHxVPH5RGRa056qA==
X-ME-Sender: <xms:aArlaM6fOmbmu2yW_K42h2SUZy0HUe2T0wJ-lWuTHEzDnKSwyED7Gw>
    <xme:aArlaD6-BAG32sK7BXOv_88IUjyx1qN0RM3C2RQ4UAi-pGa8zgOyUz0rTUar08IcT
    -PM8Vgx1XF2nP7caQdQqf_UVIufe2cDccrFLdxVDwqUZUzRZPTS>
X-ME-Received: <xmr:aArlaJGqYQt1pNmXj243wlM3lnRyvraQXdXKXuX9mwAtqTgL2IRIj1zX4c7ZaVX0c_MsU9iZklIXOnu4_K_w8PLrlGXEVBDrgRQDVWLkyr0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevhe
    euhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:aArlaMQuWrvfZBTH-qZFSBEWN6TElD8MkPim-iJ2Jiqx2IFHVjyDFw>
    <xmx:aArlaCt_4MnYJgemVOO9or34bG37YIbbm6XqacHz-2VR9kl4cN0gCg>
    <xmx:aArlaLyyEsr0lJVv6k9vjltJBepVf_VtLNV_10OWUizIXWgOob-68A>
    <xmx:aArlaM60b3-yJ2_EZgrX8gli_FHDS3MDISu6Vi5OkjMVaEdPGLqayw>
    <xmx:aArlaCD0LWTdd6Z_acLxCsoNyWmvIgqWhs_iXExOK9EQvdxtosGpQILZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 08:41:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 405c8a52 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 12:41:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/6] packfile: remove `packfile_store_get_packs()`
Date: Tue, 07 Oct 2025 14:41:06 +0200
Message-Id: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGIK5WgC/x3MQQqDMBAF0KvIrDtgp23AXqV0kcYfOxhiyIgI4
 t0bunybd5ChKoye3UEVm5ouueF66Sh8fZ7AOjaT9PLoB3FcZuPiwxw1wTgseUNdecLKPiW+y81
 FB8E4fKgdpSLq/v9f7/P8AXR3HeNvAAAA
X-Change-ID: 20250926-pks-packfiles-convert-get-all-4236f6e2ed9b
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

Hi,

this patch series follows up on the discussion at [1]. Originally, these
patches were part of the series that introduced the packfile store, but
we decided to split them out into a separate series.

In any case, the goal of this series is to remove the confusing
difference between `packfiles_store_get_{,all_}packs()`. It's not really
obvious to the caller what the difference is. But even worse, the result
of these functions depends on whether or not `get_all_packs()` was ever
executed before `get_packs()`.

The series is built on top of 821f583da6 (The thirteenth batcn,
2025-09-29) with tb/incremental-midx-part-3.1 at c886af90f8 (SQUASH???
play well with other topics by preemptively including "repository.h",
2025-09-29) merged into it. This is done to fix some minor conflicts
with that patch series.

Thanks!

Patrick

[1]: <aK5hpwcCgjkgQB1N@nand.local>

---
Patrick Steinhardt (6):
      object-name: convert to use `packfile_store_get_all_packs()`
      builtin/gc: convert to use `packfile_store_get_all_packs()`
      builtin/grep: simplify how we preload packs
      packfile: drop `packfile_store_get_packs()`
      packfile: introduce macro to iterate through packs
      packfile: rename `packfile_store_get_all_packs()`

 builtin/cat-file.c          |  2 +-
 builtin/count-objects.c     |  2 +-
 builtin/fast-import.c       |  4 ++--
 builtin/fsck.c              | 12 ++++++------
 builtin/gc.c                | 14 +++++++-------
 builtin/grep.c              |  2 +-
 builtin/pack-objects.c      | 18 +++++++++---------
 builtin/pack-redundant.c    | 12 ++++--------
 connected.c                 |  2 +-
 http-backend.c              |  4 ++--
 http.c                      |  2 +-
 object-name.c               |  8 +++++---
 pack-bitmap.c               |  6 +++---
 pack-objects.c              |  4 ++--
 packfile.c                  | 10 ++--------
 packfile.h                  |  8 ++++----
 repack-cruft.c              |  2 +-
 repack-geometry.c           |  2 +-
 repack.c                    |  2 +-
 server-info.c               |  2 +-
 t/helper/test-find-pack.c   |  3 ++-
 t/helper/test-pack-mtimes.c |  2 +-
 22 files changed, 58 insertions(+), 65 deletions(-)


---
base-commit: a0cb7ee3bf6c8398ab18e7b0dfabec106312b2f8
change-id: 20250926-pks-packfiles-convert-get-all-4236f6e2ed9b

