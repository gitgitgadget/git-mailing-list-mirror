Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561161;
	b=1bhbaqQ4aLmkDQaAtDZx6YjWLV8l4e9084J7/2aTKmRQA4ssyQUmBDt/+WXPdjwMncsn
	 wlVo6TLdMv3O0SOkGvHLU8pfwEFwC+9dHPpuH0fyvLpOtahqE0Wd8gkHMFpUZtR14MZe2
	 y4gL+8fclC3qKznum4gSzFE63f1dCY3azf88JjHWyjgOLinU5cRue45PzueVeIXSFb4gs
	 0oDTwoirghgxcGoBnYgON+izlObLKGf3HsrIWHNvBwGL9lss1mYVzdT3rkw1CRBkidLHb
	 i7u1NyynpygmMivzK5W87MbIPz52UYtkBgPXYVExPhMdpihy0VsRA7Hlj+qDwnt755Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561161;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer;
	bh=cXrUJyyMeiGx2cxOj/kEra1cpybZMBIAVOsuD4bKmhk=;
	b=M63Vsh+mh88ssebNiCHnZW8Fi3aOjE3pv3UrTGEVEz+eFIa4Ncu2MZ5LVa/1ur+BCon3
	 fzxIYYGTWOuFY9Y7TCjNqria7fKVohRVJvTcgIknA86qR93CUr1p9sO6dRi616S6P6t6C
	 okE+Nr80OYgSZk4oc3iLDi2PpBZjeIL5JTJIOmLwXJ9Z0fY1WQNRCkN0xdRFik7+UJ0tO
	 t+fjnBp5fnt08QIxKDA0MjX8YYP1VXMTYjDqTUj4/d066UGI5yvnn4AJJQJl9XxuVZ54X
	 YWRHxp2Z1QUZnt7PhidIFxWBNbdWH76bXC3rF7/tmvcxsidff7bD8URPmQmOvgrmWUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ZghO0ovi;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FUPux1TA;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04D8606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 05:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D04D8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ZghO0ovi;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FUPux1TA
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 43E971D00036
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 01:39:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 21 Oct 2026 01:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792561160;
	 x=1792647560; bh=cXrUJyyMeiGx2cxOj/kEra1cpybZMBIAVOsuD4bKmhk=; b=
	ZghO0ovirtw/iwLK0zZPwpp3/rmLktRwbv9IeOriNM7FJrTSlFXxU+r4TE5+8GJG
	Nr4WilP9WSqUPC9il1OJ9gamZQr73IatZ8gU2l7NwJdw+RY+Ygcwuhq6gCWYQlQ9
	kYVHE6GclQto/OrWZZBPVNoW+V0PxGKWQTHy0E4DCltCOxvZeciq2JPnVTiTqtBn
	eTNUu/pbr4GpTimOxJF69BLmCsWxYug3K2pezTQ0k7df215vgA9GWh+uCGyhE4+v
	T0CrnnuGCugMJSTPwXFT8/fZ9LzQhTFd0ZdWsqYLfoAHSjCr4u960FQ7MmDmT/PK
	XR2Oo2+CkFvHf7g3kR1mCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792561160; x=
	1792647560; bh=cXrUJyyMeiGx2cxOj/kEra1cpybZMBIAVOsuD4bKmhk=; b=F
	UPux1TA4KZYC4K/mEdhUAKA+DhE3/wYmtfqXHL1W954nc8Rawe99MK/JL10fdnmO
	eJlFbYKUaQzdzo5EdlCT44CYT1AAyNZEetf8inTDQWeco1y10Hpyy2UWf1k1EnX/
	3SHu7fa7tGTTbHLFwnihHRd/gfb90CfIdvYNqZPig+VcGG8xLtUk13TCJPYwfhJ/
	Lwwi7HCGUDg3tMpUniOKnoCL2hs3lU+6mOM2mMKm08JoAHWrYKGm7pPPeX15ZM+X
	FMwWKgmk5GWxcFT4n94AjLmdxfumniYogQVUFBv79tvYLzkKFEUQ3q/rAQyODNI2
	sZx8S0t++r0lN8UF0la0g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792561160; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:crJ6WYL9Wrn8x5h0Y+5e8AymJW+1wX+g3zPJyYfdQROvU/A
	jRTBPpCcM7Xm0zP6q1+uCqsL2JAPwzsy59YUIqbvaH3rW5YHRiEuwX13McDLWIvr
	sKWMTSATmlE5iuppj2zlQjqqQ7llr7VF2vBmf2IvAK38A1gcRTfxB6PTi3qmKs1l
	vV4+maElUJIeKEDFJJ3iBlBlFCM9zpTcBTBZMqEzXcfKY1r23L2Cq7JZTPe8jAAG
	WQtDi/C9IoLdjsDxuvXd7SxUv5zy5yYNlpyO1SZZ7ZckbnwEbsDWhyhICspOsOWb
	CmVXyXC5K+4lVdyaGnJdLl4DADGJToy4Zyc6ZEQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:S59J4hUnMpUHnOPzEwMV77TdiId2KWCR568irNx1rHA=:SnHE3cq1kEmL/XALzEmQ2hR0OJQND/OqjFr3/li8RFQ=;
X-ME-Sender: <xms:CFDYar6Jpb3crnA81d7APSoDdi17pX2cxFDOigwlCyMjGGH-vkcCbA>
    <xme:CFDYam759xD3e3fEujt1ChAQy3PxxQLdDjqBdSCsBlji5c4BDnqX8V3pHwAiX6dN7
    F8J4DV7KYtfEZdxwLAX9pVfCiu9IzzpJ4U1HW9gTMa0zv8Cl6xK_Co>
X-ME-Received: <xmr:CFDYagH-Xo0ClVNMsaCU6i7tsmdQIdIE_MPgwGU1p5Koh7OXrbUVnQ>
X-ME-Proxy-Cause: dmFkZTFj/XBE/FrTBvLFoaiYYpY9OAbW3MY0kigKiHz/xv/Kc7JzjUvmoiR+38MjFMUrB4
    Cra/rvNuQJmJgCpeuQGnKmyUIBrniBQiSJB23dT0aeMMpsK9OtWbCd6sQUw3gSxlLVMVvp
    K0sNXCole6TIRlUcJ6KtkzViprWJ+RldBgsLJivUXkaxQKl0aHtbo3UHXDXRIaLE9niM3e
    eUoFT8wLyThJ/qfa47+FKqrYnfLULpHQYSOqUTifKksaj4JiX0ioZ16WB+SXzqq7gSLFEw
    oVr1UsREGTa2Wm9M+Cn4wCIa1DdbD4TsGaC8ea15om2cpYi1VIiYiNm9QX3N7QQt6kIuPK
    y2y3VG8+u9wnfc3xL+plqAJWiTBGbHoqDUNyWUund0jo1E7VJNMKbxSIo1jOPAy1e2lSwS
    fOvhrHpXFdY6bwL+f97ri8eUELC5RBWZd7R4EUooE0XGFLBnkF6pYoCoJ3di3HOv0CR6AU
    LMa/knHrxEs+m4G7Kr1bcfj/MlFg7ouAo969eX3t5M8jtjb9lrAqWYKouQjcB+yZU1qUVu
    mMb5PPMlObxDk7v2cmlgdGyR43hJBEZhR2CWQqUMA/19BO4npIS4kC4FeZ9MZkNa/l9kF6
    bfT5zTsC/kNdpMSf/j3Csv3sm9syc8Fv93NwLKWh07IztaQekVr1dzJPPKdQ
X-ME-Proxy: <xmx:CFDYanRVbbhCCxxIxC6OgocOo78CZhVXFwSIPECt_Yx70sPLiN5jpw>
    <xmx:CFDYahsYCgqM2N7GLTfCX3WBNXKlu5mkoTPyHCaqFAF6dzCo597gig>
    <xmx:CFDYauxwcJjmUdel4YWFRa-cxeAkoS0IVq2C3yiFmvB5Le0a0uP14w>
    <xmx:CFDYaj7PeIrEuljDzckhPW8FJUpfhk5JhOqnN5qgJWlF1131tNNiBg>
    <xmx:CFDYappwXjcPYyevF4jmykmHgdoYdzfA4Lfv5K7qRB9PkWHyHiaLSOw9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 01:39:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 69972754 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 05:39:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/7] odb: introduce object storage extension
Date: Wed, 21 Oct 2026 07:39:13 +0200
Message-Id: <20261021-b4-pks-odb-extension-v2-0-8cf11b65eda8@pks.im>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0Jm7ZiW1pK68h6GBYVBRiOQFgmGc
 HdbdOnyJe//t0IgzxTgnK3gaebAQx8hP2RQd1V/I+QmMuQiN1IIg07j+Ag4NA5pmahPA1SmIWO
 Vc1YriNPRU8vLfnstvxxe7k71lL6S0XGYBv/eu7NM3i8h7f/ELFGg1Ko6WaNcUbSX6Bz5CeW2b
 R9B1A5bxwAAAA==
X-Change-ID: 20261006-b4-pks-odb-extension-36de693bb943
In-Reply-To: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
 builtin/clone.c                            |  58 +++++++-
 builtin/init-db.c                          |   7 +-
 builtin/repo.c                             |   8 ++
 builtin/rev-parse.c                        |   5 +
 builtin/submodule--helper.c                |  28 ++++
 environment.h                              |   1 +
 git-submodule.sh                           |  18 +++
 loose.c                                    |  46 ------
 loose.h                                    |   1 -
 odb.c                                      |   2 +-
 odb/source-files.c                         |   7 +
 odb/source-files.h                         |   1 +
 odb/source.c                               |  45 +++++-
 odb/source.h                               |  12 +-
 repository.c                               |  11 ++
 repository.h                               |   8 ++
 setup.c                                    | 116 ++++++++++++++-
 setup.h                                    |   2 +
 t/meson.build                              |   1 +
 t/t0001-init.sh                            | 221 +++++++++++++++++++++++++++++
 t/t1900-repo-info.sh                       |   3 +
 t/t5601-clone.sh                           |  68 +++++++++
 t/t7427-submodule-object-storage-format.sh |  91 ++++++++++++
 t/unit-tests/u-odb-inmemory.c              |   1 +
 33 files changed, 785 insertions(+), 62 deletions(-)

Range-diff versus v1:

1:  c9d303a0a4 = 1:  49f964eeec loose: drop unused `repo_write_loose_object_map()`
2:  1090634b33 ! 2:  82849d866a setup: introduce object storage extension
    @@ odb/source.c: const char *odb_source_type_to_name(enum odb_source_type type)
     +	struct odb_source *source;
     +	char *payload = NULL;
     +
    -+	if (!object_storage_format)
    -+		return &odb_source_files_new(odb, NULL, flags)->base;
    -+
     +	switch (odb_source_type_by_uri(object_storage_format, &payload)) {
     +	case ODB_SOURCE_FILES:
     +		source = &odb_source_files_new(odb, payload, flags)->base;
    @@ repository.c: void repo_set_ref_storage_format(struct repository *repo,
     +				    const char *uri)
     +{
     +	free(repo->object_storage_format);
    -+	repo->object_storage_format = xstrdup_or_null(uri);
    ++	if (uri)
    ++		repo->object_storage_format = xstrdup(uri);
    ++	else
    ++		repo->object_storage_format = xstrdup("files");
     +}
     +
      /*
    @@ t/t0001-init.sh: test_expect_success 'init with --ref-storage-format=garbage' '
      test_expect_success MINGW 'core.hidedotfiles = false' '
      	git config --global core.hidedotfiles false &&
      	rm -rf newdir &&
    +
    + ## t/unit-tests/u-odb-inmemory.c ##
    +@@
    + 
    + static struct repository repo = {
    + 	.hash_algo = &hash_algos[GIT_HASH_SHA1],
    ++	.object_storage_format = (char *) "files",
    + };
    + static struct object_database *odb;
    + 
3:  afbd06d834 = 3:  5d5728f5a3 setup: allow overriding object storage format via environment
4:  aba2dd3339 ! 4:  9b408ae68e builtin: expose the object storage format
    @@ builtin/repo.c: static int get_references_format(struct repository *repo, struct
      
     +static int get_object_storage_format(struct repository *repo, struct strbuf *buf)
     +{
    -+	strbuf_addstr(buf, repo->object_storage_format ?
    -+		      repo->object_storage_format :
    -+		      odb_source_type_to_name(ODB_SOURCE_FILES));
    ++	strbuf_addstr(buf, repo->object_storage_format);
     +	return 0;
     +}
     +
    @@ builtin/rev-parse.c: int cmd_rev_parse(int argc,
      				continue;
      			}
     +			if (!strcmp(arg, "--show-object-storage-format")) {
    -+				puts(the_repository->object_storage_format ?
    -+				     the_repository->object_storage_format :
    -+				     odb_source_type_to_name(ODB_SOURCE_FILES));
    ++				puts(the_repository->object_storage_format);
     +				continue;
     +			}
      			if (!strcmp(arg, "--end-of-options")) {
5:  a61a7f674d ! 5:  ca8be36980 builtin/init: introduce handling of object storage format
    @@ setup.c: void initialize_repository_version(struct repository *repo,
      	    ref_storage_format != REF_STORAGE_FORMAT_FILES ||
     -	    repo->ref_storage_payload)
     +	    repo->ref_storage_payload ||
    -+	    repo->object_storage_format)
    ++	    strcmp(repo->object_storage_format, "files"))
      		target_version = GIT_REPO_VERSION_READ;
      
      	if (hash_algo != GIT_HASH_SHA1_LEGACY && hash_algo != GIT_HASH_UNKNOWN)
    @@ setup.c: void initialize_repository_version(struct repository *repo,
      		repo_config_set_gently(repo, "extensions.refstorage", NULL);
      	}
      
    -+	if (repo->object_storage_format)
    ++	if (strcmp(repo->object_storage_format, "files"))
     +		repo_config_set(repo, "extensions.objectstorage",
     +				repo->object_storage_format);
     +	else if (reinit)
6:  a61c708bc9 = 6:  34c9345892 builtin/clone: introduce "--object-storage-format="
7:  1d2c6a3cd0 = 7:  95c9be6418 builtin/submodule: propagate "--object-storage-format="

---
base-commit: 0d31382da9336683214372ba328fe9ecbc8bcb9a
change-id: 20261006-b4-pks-odb-extension-36de693bb943

