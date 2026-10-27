Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084377;
	b=pTxxyt6wFIFDtpl/IdmRpYOowfK+9pf4ZXHAX5YsR++f1KeTKOgn+tInK9aToeMFkcy3
	 NOg3I6D5pKCPaCp5DtZZc9e+y4fnm+INw1KWAt4BSyII9Kwce3oaMhZm39QJodFhOHHc2
	 e3XTKFkcxuG1Gwzl/TSog/OEBDjTGPqs30RgobyMh//dUhZhdzUdsbGtU0u78UBAUOdtZ
	 2jE2tNCwRl6DPwIrotlHAu6Qlc/6ejMrFyRPzHWSbwRK7PlGkhWC0Zjbflp/8Dp8+f1YP
	 PZ9kCSrv8rJSW5ngpP3HZA+A03kiF90GyjCkkSRLs8WKuY6m6YV0NB2LFmMB1PszsYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084377;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer;
	bh=f5p811+2vpr5kiC6uMVGhyS3EhjCxw4iQyNa1iZqe94=;
	b=lOaOm6qB1V7pQCRZMKe3nTy7cFIxhA3tRAW4PeW4Cu4eZ72+mbv22Ef1NtwgPSLG4Jdw
	 PhiGrLsa83uDYcN1iisTsaX+fYAiwthVSWFaWJd2o1XEaDTi4sFGLwArrqxk4US1zI+tb
	 IjwMZQ32hXk3ta9WJ0Pyf5hl9yFm89dl+j9jMuL+hl66uk178wwjA5YVUQ7Nq8O9hoP1p
	 fbG4T0EI3u+P/IS4eDbXnKNoLtf1n/TMi89b+eOnB7Vv/KFACNEdYG/4Axd1VqQMwcD6w
	 FVc2yQMtk230KbcLp3T5ZpRYTQsYqT2WUHoSbzTsVwoHJp/8benieAAUknCr7kChj0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=vHvmeHE0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wyYt4czD;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3FC606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E3FC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=vHvmeHE0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wyYt4czD
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 62FDF7A00AE
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 02:59:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 27 Oct 2026 02:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793084376;
	 x=1793170776; bh=f5p811+2vpr5kiC6uMVGhyS3EhjCxw4iQyNa1iZqe94=; b=
	vHvmeHE0lt93zUm2DRY2+tfr9DvzFktORFyjDjaPLYUOWnuyhAuZ/UI5+XjEzgoz
	Ss18rdqrtWYqyt49Z/P1Q8jg5HghmkmocjMK8+04q3uZhIIy6AytKmSMJvkpAZ9z
	DhZKAuj7pMT420eMwMgYWuLj2GlMempCX0VtrEiOVKbC7m2OCCRMW1Ul7iu0pxGk
	i9ka+05tZc/LOFoFDwn1uGVM4aZnjHCN5gmC1V6/5fuutE+4kyRPZAAqeR3jxH24
	t+BxwV7cJm2gTh1pPUo/KaSH5bW5l8vhvm62qt9fu9dzIgRj+dlsoZGrNB8U4FWd
	4w0gaD6lswDuuAI9RjjGHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793084376; x=
	1793170776; bh=f5p811+2vpr5kiC6uMVGhyS3EhjCxw4iQyNa1iZqe94=; b=w
	yYt4czDNyaeKFbex/eWeW52fpML2Mp+CaFiIRpfOK5KMwVXfBMa+2P8pMe0Ld+jp
	6sQ5Lrc9KkN2GExmoSkyrY3AZzsjVdjMIYAAp0strikkn2kYopcCirqa6JrngX0q
	YQ9znQ010l6bkOL0P58InwRjK9zMo4wSm1s2rs5ZOL0PJfP3/SBrPIiA8wabbpYA
	nFJ7XljvskASXKt4jyrh1p7OaCNGWAQWpQ3TOl0MglkVu5l8W/G/36hLHObeH4mQ
	xakyIl6LjQz++CiQ4tf90khY+ZTekjI+vEamUJeTf1g+zKmIqEKVZRSmfPrqKygr
	SqfOFGm9UHEmtMZnKcdSw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793084376; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:EiKbYNT+66BJhn+GE3FiDdMrvVRLU9bTge/sXbQaYN0mI8A
	lsK9wW/EuHSZx/3pr87NxZ4mxxQVDnEod9gZxTkkJASRk4r7NBBascwNufDtLKL5
	DbYJaOpslX7bPO/n7BimPWkE7939lp1xKxKHWB4pcauzl5yof54ylhLvn6pWNRBw
	YnOrI6g6QbsFtIj3fUgS2RR1RO4trYQBWspTYrpXMVXuwisfPulp+RSHrfzq4h0r
	gpg5sZTI3YWgObzVuISi5YiM+RCkZ5iiI+a/EW39paPZttSrYu682HQ11nlEBPeH
	zfHpHxbHiIbbpnP9315RuDL8sc3vLffDYXYajzg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:WMt5K5dGQc0C8omrcRFdwS3I/Lf9ofhQ9LnO2yOd0EQ=:rYND5/yQaR0KVRWhYPJpgWD+3QrR8KOJNSZVU6ZKPmQ=;
X-ME-Sender: <xms:2EvgalPW3OZljuHcScIytXb529Q4Gsc5SHvB5YbjY3KpPjdQBw8tgA>
    <xme:2EvgavbK6_RlLF2B88UbniXexGpPQ5p9A77tGbGOZqPiZFWx5B4wZywM0-jhSiwto
    7hjmCips-BGd2cpEwZjCyx7SDNk9P5lgDVkMwBW6HuDrh5ixBFC7fY>
X-ME-Received: <xmr:2Evgahp3BMTj2tulmddupVC3fFu-MUadbIZaNVDIHksSP57YzRiC4Q>
X-ME-Proxy-Cause: dmFkZTFQq+uTjBrYyLiJqbWvFTzlWi0CPTLmLDj5Us52ZiEWQPEyd6J6Dyp+8gViKnPmpo
    6zhmHgsB2IwZSqvfBFjmxCdR+E8zw0SeeZ16WZ+UbBonp4td3EEoUW/j6OYoqpfrzyi4Ck
    r2M4rqQBqzZQ+whj3+rpfCl8X3nz8IZ9vVO0aTvHcp8PrhCAOy6/1t+hbNlLenUEKd+pBd
    h9WeZwKsVhaywvcrnReVX3FZ0J23QXkBWkLpTeqUQXmY/P+rXZ1RZFIz9C6v5gie1ML2Np
    P9nXOhpF+gCRTnkdrnFGhuPSmbuDZRzpfaVQonbgMlhNBsTN27MNcDQYjlqHt5pkg4bERn
    Vl9CJ8mi+jeaQyJgSrM6rQ9NMa4Ifbme3CreDwogN0A8GX7FR2kBN4y9NzKuBvBP0G2Ysn
    I21MSbYRkZhoD2UAFVipPpx2MHgK75fTpznfpL1kqCvHsWpB3+uM6sE0YTmq0oX1011vns
    9ZUF+DqmLxKywNCXTbJXruoS5OfKtTO/6A32HWoeygZo11WB8qR8orMW4izJIIoqv94NiH
    f3Z2922Ry5wW380gzPZBv4fDhs1Fu0W91dHIABsNHv5wLFWWigM/LDiaWkP01+6fYgy5/z
    Lq9FFOjS6zy7R+gwI7i8RCxgy40XY1T/LnU5QzbGEwo6jQVDvefmGSjPTesQ
X-ME-Proxy: <xmx:2EvgaraVqrlHSuNT2UUfiQWTeP4i5BG7b1KTjIqBGhJeFs7NYkDXRw>
    <xmx:2EvgahS-TJLsudE8XsNo4CgcGMEmiTW2S3XJMqwCC5tPlbBkwVo7zg>
    <xmx:2Evgaq5ndNoxP3FTYSF8CNVfXOR9pxpymH0c0J3sLpKaD92EvVKDOg>
    <xmx:2EvgauyC8X73m3tM1bm9OI0_5G0pwDicuZFjFb6uwwVZsOsnoT9k-w>
    <xmx:2Evgap3iLAsZtFzfPdO72E2Xwoh6hGTVdsZic0G72Kaa6UF35f56HVwF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 02:59:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f58f77e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 06:59:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/7] odb: introduce object storage extension
Date: Tue, 27 Oct 2026 07:59:24 +0100
Message-Id: <20261027-b4-pks-odb-extension-v4-0-5d28ca0ea1dc@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XQQQrCMBAF0KuUrI1kMjW2rryHuOg0UxvFtjS1K
 NK7m6iIgl1++PM+zF147h17sUnuoufRedc2IaSLRJR10RxYOhuy0EobUMpISmV38rK1JPk6cBM
 PJBrLJkeiPEURTrueK3d9srv9K/sLHbkcohUbtfND29+euyPE3nsC8v8TI0glIcVilRuk9brah
 s7SnUX0R/0laJgRdBCysgIgs2JbZD8Cfgs4I2AQCIhQFeEXlj7CNE0P6IGED0sBAAA=
X-Change-ID: 20261006-b4-pks-odb-extension-36de693bb943
In-Reply-To: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this patch series introduces the object storage extension. The extension
is of course similar in spirit and design to the ref storage extension:
it can be configured via "extensions.objectStorage", has the same syntax
with "<schema>[://<payload>]", and we have the same mechanisms to
configure it ("--object-storage-format=", GIT_OBJECT_STORAGE_FORMAT,
GIT_DEFAULT_OBJECT_STORAGE_FORMAT, "init.defaultObjetcStorageFormat").

For now, we only support the "files" object storage format, so not a lot
of stuff really changes. That being said, its optional payload allows
you to configure a different location for the ".git/objects" directory.
So if you specify "extensions.objectStorage=files://objs", objects would
be stored in ".git/objs" instead.

The series is built on top of c51408889c (The 6th batch, 2026-10-16)
with the following dependencies merged into it:

  - ps/odb-files-alternates at 0ba59c8453 (odb/source: drop
    `read_alternates` callback, 2026-10-08) merged into it.

  - ps/setup-enforce-repo-passed-to-create-repository-has-no-state
    (phew, what a mouthful) at 0ba59c8453 (odb/source: drop
    `read_alternates` callback, 2026-10-08).

Note that these two series conflict with one another. The conflict can
easily be resolved by just deleting the whole conflicting sections.

Changes in v4:
  - Provide some justification for the payload of the "files" backend.
  - Remove stray added newline.
  - Some comment smithing.
  - Link to v3: https://patch.msgid.link/20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im

Changes in v3:
  - Split up object storage format URI into object storage format and
    payload. This matches how we do it for the ref storage format and
    thus brings us much closer to it, where we mostly use the exact same
    logic. For now though this restricts a couple cases, like for
    example submodule clones do not pass down payloads to the submodules
    anymore. This is intentional so that object and ref storage format
    have the same behaviour.
  - There's an en explicit `enum object_storage_format` now, matching
    how we handle this for the ref storage format.
  - Link to v2: https://patch.msgid.link/20261021-b4-pks-odb-extension-v2-0-8cf11b65eda8@pks.im

Changes in v2:
  - Ensure that `repo->object_storage_format` is always populated.
  - Link to v1: https://patch.msgid.link/20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (7):
      loose: drop unused `repo_write_loose_object_map()`
      setup: introduce object storage extension
      setup: allow overriding object storage format via environment
      builtin: expose the object storage format
      builtin/init: introduce handling of object storage format
      builtin/clone: introduce "--object-storage-format="
      builtin/submodule: propagate "--object-storage-format="

 Documentation/config/extensions.adoc       |  23 +++
 Documentation/config/init.adoc             |   5 +
 Documentation/git-clone.adoc               |  11 ++
 Documentation/git-init.adoc                |  10 +-
 Documentation/git-repo.adoc                |   6 +
 Documentation/git-rev-parse.adoc           |   5 +
 Documentation/git-submodule.adoc           |  10 +-
 Documentation/git.adoc                     |  10 ++
 Documentation/object-storage-format.adoc   |   6 +
 builtin/clone.c                            |  63 +++++++-
 builtin/init-db.c                          |   7 +-
 builtin/repo.c                             |  10 ++
 builtin/rev-parse.c                        |   9 ++
 builtin/submodule--helper.c                |  40 +++++
 environment.h                              |   1 +
 git-submodule.sh                           |  18 +++
 loose.c                                    |  46 ------
 loose.h                                    |   1 -
 odb.c                                      |  46 +++++-
 odb.h                                      |  13 ++
 odb/source-files.c                         |   7 +
 odb/source-files.h                         |   1 +
 odb/source.c                               |  14 +-
 odb/source.h                               |   5 +-
 refs.c                                     |   3 +-
 repository.c                               |  10 ++
 repository.h                               |  18 +++
 setup.c                                    | 132 ++++++++++++++++-
 setup.h                                    |   5 +
 t/meson.build                              |   1 +
 t/t0001-init.sh                            | 225 +++++++++++++++++++++++++++++
 t/t1900-repo-info.sh                       |   3 +
 t/t5601-clone.sh                           |  68 +++++++++
 t/t7427-submodule-object-storage-format.sh | 104 +++++++++++++
 t/unit-tests/u-odb-inmemory.c              |   1 +
 35 files changed, 871 insertions(+), 66 deletions(-)

Range-diff versus v3:

1:  906c3d3e3c3 = 1:  f09fc3200f9 loose: drop unused `repo_write_loose_object_map()`
2:  3d3bcf0f825 ! 2:  655e1de3b9d setup: introduce object storage extension
    @@ Commit message
             allows you to configure a different location for the ".git/objects"
             directory.
     
    +    Making the location of the "files" backend configurable is not he most
    +    thrilling feature of this new extension. But it gives us a couple of
    +    advantages:
    +
    +      - It allows us to start exercising the payload logic in our tests so
    +        that we know it's working properly for backends that will need it.
    +
    +      - It allows us to easily detect tests that are broken with the new
    +        extension because they for example assume that an object is a file
    +        in ".git/objects/". Testing is not part of this series yet, but will
    +        be done in subsequent patch series.
    +
    +      - It aligns with how we handle the ref storage extension, where we can
    +        also change its location to an arbitrary path.
    +
    +      - It allows for some very esoteric and edge-case-y gimmicks. For
    +        example, you can initialize a single repository "skeleton" and then
    +        multiplex therein by setting both GIT_REF_STORAGE_FORMAT and
    +        GIT_OBJECT_STORAGE_FORMAT to point to different databases. These
    +        edge cases won't matter to many people out there, but we will use
    +        this for example as a building block for migrations.
    +
         Eventually, this mechanism will be used to support alternative backends.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    @@ setup.c: static enum extension_result handle_extension(const char *var,
      		return EXTENSION_OK;
      	} else if (!strcmp(ext, "relativeworktrees")) {
      		data->relative_worktrees = git_config_bool(var, value);
    -@@ setup.c: static enum extension_result handle_extension(const char *var,
    - 		data->submodule_path_cfg = git_config_bool(var, value);
    - 		return EXTENSION_OK;
    - 	}
    -+
    - 	return EXTENSION_UNKNOWN;
    - }
    - 
     @@ setup.c: void clear_repository_format(struct repository_format *format)
      	free(format->work_tree);
      	free(format->partial_clone);
3:  8c7fcbe8659 ! 3:  9b57baa86f4 setup: allow overriding object storage format via environment
    @@ setup.c: const char *setup_git_directory_gently(struct repository *repo, int *no
      			}
      
     +			/*
    -+			 * Likewise, the GIT_OBJECT_STORAGE_FORMAT environment
    -+			 * variable should override the repository config for
    ++			 * The GIT_OBJECT_STORAGE_FORMAT env variable
    ++			 * should override the repository config for
     +			 * 'extensions.objectStorage'.
     +			 */
     +			object_storage_uri = getenv(GIT_OBJECT_STORAGE_FORMAT_ENVIRONMENT);
4:  e09beec6d1e = 4:  69f11546357 builtin: expose the object storage format
5:  7ff9419d250 = 5:  9a3d8abd624 builtin/init: introduce handling of object storage format
6:  03e119eadbb = 6:  f37be19589a builtin/clone: introduce "--object-storage-format="
7:  02d33ab036d = 7:  aec7e0f12e8 builtin/submodule: propagate "--object-storage-format="

---
base-commit: 0d31382da9336683214372ba328fe9ecbc8bcb9a
change-id: 20261006-b4-pks-odb-extension-36de693bb943

