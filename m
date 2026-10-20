Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506408;
	b=N/xoLhds/syki32cDRsJqU4NTN0vRhWlcpD08eMYIOHcsd/YZEaSzqeIhILx7UhrZmtp
	 /DPABgdsaPwl0WpuNu3+hoWxE5cDlL3gjRSJq8FNPuHxUwl/GM4FlBhVNXePOymKMe6bi
	 O2VPR41DyBe/Ff1CYKd6htx2UPrExA0rQHmLrYNbStoCnFfexe+MMtKHLNwRItQvAu3R7
	 yztiDPAQiqh1OF5fDDsHVWJCzOTgyPMGGXlfPsc2Xpf2w9rGTgvRSMBW87rYCHkNMO2my
	 r9JQnnqyyzK0fxx+MwmlInh6hovG3WS0nDPSDcJ8DxujCl9d+wxG0jPEZsmovCtJuJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506408;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mqXxNa6IB6It2QyUYOUxR2FajpuAb8W689ukWJuZtrM=;
	b=ayVK/G1Sne9YQVPBtJK2FB2G7d/sfFwW63nlN1wHoiRffx1SnJ30BK9XplKV2J0SZeqs
	 87/HKUQcEwW5YueiPuk9ybWjD69j8O0CY3GBBmGLdgY3LDRriSu3dUWqdnghOhFRlZh/8
	 7Q8vROvGyNv7IT573e42F5kyIAJm0fvKg//Petd4ZmXxTt/i228Y/NEwARfS+oLcx+Lq1
	 xVEcYL9JwbYkVK7NapV+p0s9wazKV7wp9t+RR0H+l3maTPpLTuBVMulM6Nmx6x310f8rD
	 ymTobR09GEkjhGZYYBpUty2AhKC1Ra4mZJ2IVKjiHTRv21bpHCvmPyW3qQJYw4F7PIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=OqHjDzBM;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hBYzCihf;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BDD60A2606
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 14:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1BDD60A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=OqHjDzBM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hBYzCihf
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id ECABF1D000D3
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 10:26:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 20 Oct 2026 10:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792506406; x=1792592806; bh=mqXxNa6IB6
	It2QyUYOUxR2FajpuAb8W689ukWJuZtrM=; b=OqHjDzBM2I5AsYkbF75G/3ARK7
	5ccFZJzsFFUFknq+U9pjXUmXXUDekNLoAYBXWNoHKwY1NH1jDiK6QOMl/HxkqLfl
	kMmRdAJfmiGJwvRkI1w1UboKoOKWeAKcutagRn5JgrQkY1lgLAvkSgKx3qhHctMH
	igGFu9LdfRMayR4kzseF53hsDfybRZYM7xGxdE7dzuqeLDVRKSA+17wjI7TByCNk
	ASfXmcOeTMsA8T85/BfRzCPb77xo8UUVVtCxUmVKZSUDc3DLK0WtldbkvXHtAIMZ
	vPziW35gTZ1ibl+YqsOl2iFvLzmlzE/0UgU2b/M+842ZO3UTVwZDnjaZ70YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792506406; x=1792592806; bh=mqXxNa6IB6It2QyUYOUxR2FajpuAb8W689u
	kWJuZtrM=; b=hBYzCihfjl9kIFGPHWcBvuaArTixEdXKLs07qKGtKNeV38xTbnU
	JFZSL3nRyychhzaIGA5uVqJkb8nftsL+q+JH0+vlnc28bL+fvAImInbCaE382gIQ
	61i1xDr9/RjfiKFGpKCDmgwOxVqUN8/HV1/6pqVjdZw9XCzhvfsPz4FWglcFk5HL
	z2jEGWg6vPigyOLsCuEYLN7GpfXjOeZGF8mUtIcJTvkBPGQ0Zxt9WLwp03J9JYL5
	qXhQhZxr9vaLUyO5k07ReIt0S1TBV6PkT/udcahNCZFi3OpUPfCo29wui9oOyNRl
	0QrN852ykCJU/aruvPOaXFlVJCk092PQWZA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792506406; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:AKt6nhGLQVCw/IlwL540UpgRcHFF2lAOsd0+gEHzKsQToTi
	aQ8kS/XHoqLUFSrUszJeNBW13qPYFw7RSYLXmhdxQMtW2Q5qeUrgo7zsvbg2kPbe
	5c6GdTkqmOpqtNVCClcLuaNtbc08P0HNQ/4tvsGEXu1mmAF1JZlsqpnNmhG3rDD3
	EKHF2fkeY+FZhcwCx2R5WZEBcWA2XTrpQd1ofUwsls3a/dfBHB1E2c6H/Gp8ipFw
	nw/Djze/3BWq8B1NC0AhhtIWr2Vp61H7xrKUohkvaNGFpsX03xf5IONtSjznBiOi
	xvor4roPXwmTA/cp5btScLkoFbUG9nr5ubdANiA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Ih6GVUkDsnDhlkCMjR+aLp7SLBPWJS0GjH7xsAzscb0=:bv97x63SpwbT8kHeKfqcIgoTl9Weo4d6VGLvHHcoWtg=;
X-ME-Sender: <xms:JnrXanquRZRKoiIux2DTnVIvucD_MHuXn5xcnWLzuO3JeaxGk110PA>
    <xme:JnrXanqFeDmVgNWnhjqQX8DcBAzQP0rljY-TSkt8pMPlQrUQQ1fuzOxAeMQPvBajt
    -IvM8cNveFGSwefcHZDk13vkVDjOS57U9wll0On-jTrEGeHKuUtGm1r>
X-ME-Received: <xmr:JnrXah1n_cxtBPhxg5MOHBGMs_WYcypMGOYtPAjh9NMMajsKDyZxZxl1AyNJcR_7c0lGNg>
X-ME-Proxy-Cause: dmFkZTEv4RU0cSoEFIxSVl7IK3yVd5nUQoIPJygRKr57MMMyD/7jIU121t3S6xLWv+ejrR
    MkccqlkyzaHp7QEi5Y+vF/pfR60axASf/2Y/4ELgu/8ZcpjGDPWlcfYvPb61dA3LzeYm0b
    q5E2Hvsmc3q1mLgqbOt+/kC7Zy1h8jQ2nh9dD9jzLYZDBLOdhW+UTnAKVKnJSTZd4ot7kU
    1ufsxW/VLOw9vGJN7l94952q2sDq9Q52BD1nYTnOfNuaXjfzJptpiLqEyjd56UfedeX6I/
    OfxhA2GsrqXFOT6LJPRrz6orckCuHwGeiG+f3C/GQHCpusp2sTfRedU4Ha3hiKFZVrJin2
    AFT/g/cqr6UR5TiFhUF/t6TVj4FlXqQJOBXTb0MejzVCNmylc1VGtl4yZ5X9mpcH23iJv3
    tHU2/FP8IFg/rdyDEqyuWJNUPAzEWT6Nnamqad1gYqy9RbTAUpJeUfWK6FJ+NUtW/n60X7
    oXw0iisbBf3MAKtYvCZfoerhe/AHxAvaa0fEuhWdk7PCMrthVxZDjGrCRz5BIoDleBAcnH
    dQNNm5AuoNqhQCYAIiWzXR5VRuliebwMy4XyqRNi/GJoDlEA5cJTS94LGZs/9Y8hvtdmpV
    RyC/1dbbMcvJRlBzGuqmbczb1i4+3dTz9zczw7NhUEifGrIjCRPbeP1e/OlQ
X-ME-Proxy: <xmx:JnrXamA-H0_uqqDcL6S9JyF65HKQWCDBI8kx-LgV3OUaD82LKKauaw>
    <xmx:JnrXapdMnmx538FfxEpUrGDOf5H3JcLsOjBpBE1F6wmlII097MDHcg>
    <xmx:JnrXargxAqPvKLlWb7fOwVtno9hemhpG38oUzKupzIdltKtHM9-uSQ>
    <xmx:JnrXahouz6HvFMxN06ZwpmTxGiCLCY8eJ9bNMrlv4OlUY-awLCxh5w>
    <xmx:JnrXahaBgQjeuGlS8KxFt9QPOqWq0OXKnR4WdOthU499ROvLJ7gpxKx0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 10:26:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 54c0d5e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Oct 2026 14:26:44 +0000 (UTC)
Date: Tue, 20 Oct 2026 16:26:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 3/4] object-file: explicitly write ".keep" lockfile
Message-ID: <atd6IjqH8F_O44gP@pks.im>
References: <20261016213716.593278-1-jltobler@gmail.com>
 <20261020132900.1208343-1-jltobler@gmail.com>
 <20261020132900.1208343-4-jltobler@gmail.com>
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
In-Reply-To: <20261020132900.1208343-4-jltobler@gmail.com>

On Tue, Oct 20, 2026 at 08:28:59AM -0500, Justin Tobler wrote:
> diff --git a/object-file.c b/object-file.c
> index 210984f825..ad55c01198 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1256,6 +1256,45 @@ int read_loose_object(struct repository *repo,
>  	return ret;
>  }
>  
> +static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
> +			       const char *keep_msg)
> +{
> +	struct strbuf lock_path = STRBUF_INIT;
> +	struct strbuf contents = STRBUF_INIT;
> +	int ret = 0;
> +	int fd;

Hum, not quite what I meant :P I'd leave the variable explicitly
uninitialized and then set it on all exit paths. Like that, the compiler
(or at least most common compilers) would warn for all code paths where
we don't set the error code. So:

        int ret;

> +	strbuf_addf(&lock_path, "%s/pack/pack-%s.keep",
> +		    source->path, pack_name);
> +	strbuf_addf(&contents, "%s\n", keep_msg);
> +
> +	fd = safe_create_file_with_leading_directories(source->odb->repo,
> +						       lock_path.buf);
> +	if (fd < 0) {
> +		ret = error_errno(_("unable to create '%s'"), lock_path.buf);
> +		goto out;
> +	}
> +
> +	if (write_in_full(fd, contents.buf, contents.len) < 0) {
> +		ret = error_errno(_("unable to write '%s'"), lock_path.buf);
> +		close(fd);
> +		unlink(lock_path.buf);
> +		goto out;
> +	}
> +
> +	if (close(fd) < 0) {
> +		ret = error_errno(_("unable to close '%s'"), lock_path.buf);
> +		unlink(lock_path.buf);
> +		goto out;
> +	}
> +

and then:

        ret = 0;

> +out:
> +	strbuf_release(&lock_path);
> +	strbuf_release(&contents);
> +
> +	return ret;
> +}
> +
>  static int odb_transaction_files_commit(struct odb_transaction *base)
>  {
>  	struct odb_transaction_files *transaction =

Thanks!

Patrick
