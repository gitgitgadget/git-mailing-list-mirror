Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486209;
	b=d8ibI35EbnhX/zXSLf8D4Xr/Z+FkN+r9Vcs9L1jVyuKOqL+xGO+EizamyOg7RhrSLA9Z
	 3Wdm39zN2w3EA7GXgNR0uJAAdNjqLdQxg4HK+ffFfp0cj1vlmWAfVovNuvptasKGocxP+
	 B10Gobe0i0PyJaHL55pDbG8uVBSFXckLXf3sE62+k9RsOv8j/NpLOcJM+RS6nI2EbzKh3
	 RE47dTiWqECwpYYRwNcO3Hmo2TW+aEcNG7J+E7sLhyGARZM6PTd5kVoymDvji8k8AjvUI
	 N8E9J9ZI81Y4GyjpB4Z99NeGQARAJcIuEV9vRETyN7PxtreiMrwp2hpGA5+3KwRNjiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486209;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZsOa1hE2X7k3YBSrcdAinkNbzbeq+H7iD0sCNLfo2fc=;
	b=tmqV1cLCZXjSIKcZkyBljNusuux14fGvsAN1UeQuc7FOYKoalU0SRe7HAPuA0ni9PMvI
	 jq3EpYVBu2ViddSsZaCfKpR0QPrjXNi2HvV7w3bmSEAULsDXbab2ekX/9sOXj0hzKxbhJ
	 11uh/ahKVdbmEX1pI5SxQdznEwLKR5bj/GDdRW2DUuKFDTcdK4k1eAQageny5LlRtMlwx
	 Cbj3WfMAS6p3hlyv8PJ8tm38xnPw8+nb2ri2F0EcAKCdvRfWnwdtTo1gwcMU6zfXkwo6a
	 /9JCgFL8Ndr/S2//m/7fX2Q/H8rL432zSmhW0nK6jzKPa9oLXnKrFga6NWBgqBoi9Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=QiI6U8Ix;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=F31Za1jU;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE52D606A31D
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE52D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=QiI6U8Ix;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=F31Za1jU
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id F20C1EC00CA
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 04:50:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 20 Oct 2026 04:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792486207; x=1792572607; bh=ZsOa1hE2X7
	k3YBSrcdAinkNbzbeq+H7iD0sCNLfo2fc=; b=QiI6U8Ix0G9iQHzrCjVaTNASgW
	49EujehYtY0SD8mYGv0Y+apvv1XDe7QAlZ0pXBi1EULhfn24MlI5cNYHswVyhReo
	ePW0IZuTNCzx19ew7Isxo2/ZByTszNEF3UG3VBpBUECBu5o7mmwp60kOsDaOZCbh
	Z1ZTeonEExJ7oGIuxKL0Vui3cBaeoynxyD4+wkKZC/IpC6TiZ8xELY3kwlI8kPup
	IaQsA3nLZKYHgv3rTP+auOwjpcS7xKYhR4JfpJrgJ9BigPjsce6adsJad+1p1FCY
	mJ2f71T7y6F2uy6Z6aIjFus6kPZfDf3f8as7FqunHrhFfhsEpI7GmW2H5rNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792486207; x=1792572607; bh=ZsOa1hE2X7k3YBSrcdAinkNbzbeq+H7iD0s
	CNLfo2fc=; b=F31Za1jUkGvMILrbbXz2+LKf/UTGvb5dnFfs4u9UXWxhwthu564
	1KO54ASd7cXrNvFNvW6IQrqw7uAPxYVohB7qixRVHOnZaWg+jckNZHIw4wWxm1u9
	wToNDlHT61ez8ML18eq+X4Cg8L7rPuy7eXQZzSewuvXYUdKTpd9mUgKFmXxvCvW8
	ZDl1bOMJhMg93pWOdtElzRWWag3Xg2Tdy8d8uosvCTLlUzKkjubfZjFNmkmd1beY
	5hGjFaKkpUNQoMdyvFcSoFGGZykj2lT0I70gl9ES2mM+aqc/vuK0TpOV4jbnZ86d
	GUb//B4vr2OXOhDt7d/o+DdmDhG8slPCJFA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792486207; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:tWS3Vx+ye7x+6qCAhv2no9/3hVH6jFDNPup02B3QEcb23rS
	OEdtqrdBoBNWT7Y8lkeneBodl6Kdp9Zh7fggidUlWLjTtLw/QS+ZrQJ+9Z1kfEuL
	b8jMb6LsSa8vXAMk3S2YsyzzYMEfHE80cliCs7jtd0Dza4S+rdBLIv6XRERJ5rZg
	ruamOpq6sP4JMFA/aYLiRdrJb3P3IapdplMT+jd+B56Gtt1iYp8E0wHitImQSiBx
	5En9Op3o+1ZnLV3ZWGcTF9jfx0EG6v7iyVV9cH4OA/EA7ixJg/fh5XxpTwlAjQyQ
	K4p7gL0BZLIcv+kRMrTArkUObaahnvsC9DV9pHw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:LHW8AnjVXl0Kk062SgJ7N9IIMHU4L+jqTrnFhwNeLWk=:7Cma5487XMjeo4Z8b1GRgAgxdHzVGNoNdxLuO7lwoEg=;
X-ME-Sender: <xms:PyvXalRxN9xtkkc02NUGpbPVTp1QMzqabckx4JmMRzYn8sKP0pYesw>
    <xme:PyvXakxYcL16AC0uEXtVC25bIShHwlAKyspFniKqI7YBkcnTeFJq2MnmORLPlMKxq
    p1lGmLAcVa7GBKH78W-isjoPVMQ0DMT9QrmZYszXXQ75toCkV_RnJw>
X-ME-Received: <xmr:PyvXaofWghq6ITtiGYzhuOU_htuIK69pX2pRf8ap23QRbOxb_g4_LYmSsd4xSQrr4W7uxw>
X-ME-Proxy-Cause: dmFkZTE4XQ1v/Rr1pHUzEfSx8TspZmlwRfaMEvERo2uqOH2w8HhYI1XifvKfsmqkiJdO0A
    HaH5UbkOFX5GanYPHoPzlMi42xWN5Mp/vhP/fsT9dZurZh+dYhtXz3Ya04O2n+TULZoIEo
    7qS3l1eLOr5KxAPuvnVgs/T+rvI0L9/PrPGT6PzYX1PExazjCP91n6Gy0Phr84WsqTCT6f
    GF7u+3s9mRIoFUpOSTZrC+WsI5nKMFGRe0rJmZY0im+q0CuA4jLlO3Bxj8Fb3SPY8wtNd6
    KxMHxlOtpIiszvEpNZElU7igzLW04DJnL5AcYgcXq5bRsTc9MqW6PoIG6zfoc0tRV4Y2GF
    eGfNZlFx2FHa0/GtxIbWESzg7V/8eh1UHzpE4irLlnpyWE1CWJDMLCyrefR29mQdyfy2O7
    0WLCWZrlyKYU6gc41rpgJSOXXr0v/LtqGpCWpjqtgm2CRZBDr4gRiYgfWj+8UNLqCKZXrR
    2WWgs/gdaYyIF8tODhsdAaYpOSEbKj03V8hToqG9J/Cdnh0c83qNWh7xk3Deg5Xf6GVtfd
    vGGlbaPBffIGjU+tZ3eUNUd6Upqgi5R3pxm63bpnljBhzG4BtkKE0bZ9N8te3zm1tVp8kb
    aKoM4/RUxuyyvoguUk6OGPxBZznT/woeP3eecbOw+6EXo7rtUxS7d+OA9M+g
X-ME-Proxy: <xmx:PyvXaoLqwNS9sB3a3ooV-VezXnw_I4W_KT5LHzyNaxUl7NoB9yDiwQ>
    <xmx:PyvXahEjc74Lg-NGhaWCQg92Y6MuLT6ArneO7NxN3YX4usyPGryyag>
    <xmx:PyvXaqofyzfq1-VHOyGN38t00DxRFHjcx8Ci8OPqbUyi9F_dbwpuig>
    <xmx:PyvXaiTqO7iIJ7z4AQngC9MRx83QYrAuJfkxp4fDBgSG2EePupQgag>
    <xmx:PyvXapBhWu6kdVA1x_mXQsUAivULMHHXGgyl9ur_y2A3Urlamz25zsN->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 04:50:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e4854ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Oct 2026 08:50:06 +0000 (UTC)
Date: Tue, 20 Oct 2026 10:50:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/7] setup: introduce object storage extension
Message-ID: <atcrO3y0o-2G8Dpu@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
 <20261019-b4-pks-odb-extension-v1-2-143a5963b77f@pks.im>
 <CAOLa=ZQj0sZu7WRzmvgZx23ZeO1KBtOm6yWOLCzeVP_86zkTPQ@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQj0sZu7WRzmvgZx23ZeO1KBtOm6yWOLCzeVP_86zkTPQ@mail.gmail.com>

On Mon, Oct 19, 2026 at 02:29:20PM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb/source-files.c b/odb/source-files.c
> > index 455f409db0..4a7cbbfd9b 100644
> > --- a/odb/source-files.c
> > +++ b/odb/source-files.c
> > @@ -1245,6 +1246,12 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
> >  		object_dir = xstrdup_or_null(getenv(DB_ENVIRONMENT));
> >  		alternates = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
> >  	}
> > +	if (!object_dir && payload) {
> > +		if (is_absolute_path(payload))
> > +			object_dir = xstrdup(payload);
> > +		else
> > +			object_dir = xstrfmt("%s/%s", odb->repo->commondir, payload);
> > +	}
> 
> On the reference side, we use `strbuf_realpath()` to convert the
> relative paths to absolute paths, should we be doing that here too?

Overall I'd love for the "files" source to only ever use absolute paths,
but historically that wasn't the case. We sometimes expose those paths
to users, and changing the "files" source thus breaks a bunch of tests.

So I'm retaining that behaviour for now, also with the extension. It may
be something to explore going forward though.

> > diff --git a/odb/source.c b/odb/source.c
> > index b25ef14df8..10abe33a26 100644
> > --- a/odb/source.c
> > +++ b/odb/source.c
> > @@ -1,4 +1,5 @@
> >  #include "git-compat-util.h"
> > +#include "gettext.h"
> >  #include "object-file.h"
> >  #include "odb/source-files.h"
> >  #include "odb/source.h"
> 
> Do we need this import? This commit seems to compile without it.

Yeah, we add some translatable strings to `odb_source_new()`. The header
is also implicitly included, but as Junio pointed out we should include
headers explicitly regardless when we require their declarations.

> > diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> > index f1d227f271..c7c464d3a2 100755
> > --- a/t/t0001-init.sh
> > +++ b/t/t0001-init.sh
> > @@ -839,6 +839,36 @@ test_expect_success 'init with --ref-storage-format=garbage' '
> >  	test_cmp expect err
> >  '
> >
> > +test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage is not allowed with repo version 0' '
> > +	test_when_finished "rm -rf objstorage" &&
> > +	git init objstorage &&
> > +	git -C objstorage config set extensions.objectStorage files &&
> > +	test_must_fail git -C objstorage rev-parse 2>err &&
> > +	test_grep "repo version is 0, but v1-only extension found" err
> > +'
> > +
> > +test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage with files backend' '
> > +	test_when_finished "rm -rf objstorage" &&
> > +	git init objstorage &&
> > +	git -C objstorage config set core.repositoryformatversion 1 &&
> 
> If we're doing this, do we still need DEFAULT_REPO_FORMAT?

We could indeed get away with not having the prerequisite right now. But
once we have a second backend we'd need this, because in that case we'd
potentially initialize the repository with a different backend here. And
then just switching over to the "files" backend would probably not
result in anything good.

So this is more of a protective measure for the future.

> > +	git -C objstorage config set extensions.objectStorage garbage &&
> > +	test_must_fail git -C objstorage rev-parse 2>err &&
> > +	test_grep "invalid value for ${SQ}extensions.objectstorage${SQ}: ${SQ}garbage${SQ}" err &&
> > +
> > +	git config --file objstorage/.git/config extensions.objectStorage garbage://payload &&
> > +	test_must_fail git -C objstorage rev-parse 2>err &&
> > +	test_grep "invalid value for ${SQ}extensions.objectstorage${SQ}: ${SQ}garbage://payload${SQ}" err
> > +'
> > +
> 
> We should add  tests for the files ODB with {valid, invalid} payload. We
> should probably also test absolute and relative paths in the valid flow.

I add tests for both absolute and relative paths in a later commit. Here
I'm basically just verifying whether the object storage extension even
kicks in at all, without yet verifying its semantics properly.

Patrick
