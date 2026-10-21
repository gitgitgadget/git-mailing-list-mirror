Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792562824;
	b=qx2qq14eP9rMrjsZhyg3dKAoxOH+yqNbFMRhCWRIP3f80rxu/gmM1llUyz84KpE9S4QS
	 9IjwRwjEIxluT8efqkO0A8OhBZ0tqnT76Bb0fmruhLlTTbLpgezMiUcCHq2IbHKtzn0Cp
	 JrjRl3l1ZUb3vZdcTuFmuNqcgn85Bx7Imz4Xy2YHoIu6oChw7LBtwZ2Tm8DffdsP6k11z
	 MVdrR4adyC817tWfjTdtG3Zbnma7ZTT7BWg/VtOfXtb4UUAME5AdnBN3EBF4nCuwr18ar
	 FG7+9MLyNpNahGmZl85Dzms/Ed9+JchHxVuyxiSuA384ykkXEjYk4WMljFmdOuPSGbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792562824;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=cTxkidzFTSzQ1Nyzt6k3RLFpda5Zrg3uWg6x4dv5PtI=;
	b=RxmDo/XMIuVKscTamgGJEYLgqTgrM3JVxTcJ/H2g37md2nIN225YTIGxLvGfiFluwRLv
	 +RgEmCOH/+VmJrNuHMGZ/RhbXAR691JuvRELlxFt+WHPtM1qk8ik6hhnat38bn9e5l+jm
	 aZA5L9srDrhcHfuPJQZ77RMrbqAtztS1kXn6A+oUQYQGlJbrVE+F5Qy8bk8gh+CwLHSd0
	 dI7KMjPPhZAf0HfqJmOn1r4ho0bWaTfuSwMGYRcHC8NAbRhXN+t9vS06+2XbLJnlmesTf
	 TMcq9esEv8fF6NnhcySLOL0ipzAwDsy+psh3MsJTrYW5J+A+f4n9ZK8E1u/kbmyF5dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="DPQn/kWd";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Y1xoDf9k;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6FF606A32E
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 06:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A6FF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=DPQn/kWd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Y1xoDf9k
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C4C53EC01F5
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 02:07:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 21 Oct 2026 02:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792562822; x=1792649222; bh=cTxkidzFTS
	zQ1Nyzt6k3RLFpda5Zrg3uWg6x4dv5PtI=; b=DPQn/kWd2A/HXLYMPHGw08wDoQ
	sKFPUhOThEWACRUVX30YROb4hE70eWkFOT3HnfHP4bhcgL4RpilPGG+6AHY0sn1u
	nw6SbkpBH4CQmpsp+WFwVdGBDfd4+kd40ztvvT39LMLrsoLyWOR8WFWBYL9AXcKr
	FcIfrwxIYsNRc454l+9BCC/dog7djIVR2e8qPp+yCqon89wrgwWDAGMQFs/fR9/x
	WZhFDpZq0bu8KxI+5qpfofpKqm6RssF9KTBPZfDlXGjsIUiCcMuTCN197EUdUeDi
	WHr/80PX8UYBD69k9u4QqJUfiQz/A0zwWRXxN0DbJNEIBR78yNbbLbeAxQwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792562822; x=1792649222; bh=cTxkidzFTSzQ1Nyzt6k3RLFpda5Zrg3uWg6
	x4dv5PtI=; b=Y1xoDf9kgx/hE7YF6/kpvqU12f3zs8m2FejzevrOEyz19gw6+Ae
	+GS6NNjE9yI3CPiF6856UBQAlyPxmZ8KSRLWjfBVxqztYIeXzD+BEc3vQdvIU5Pk
	wIGFr8dvDofhEpe472kNEaQxnaMZMiCXHY0dsSDHfM+M2HEHvtEO+zALVRqJPoez
	JNcmpc3wotkgPeFaXlmwphR3DAdLyBwmBiV3lwcMGskg16WiNiz+zMH9PtCaWZH9
	W6v2I+jqh9qNIsY/GJTQbsg60tSt9ZwTWCGBFa1p9LnnbPCdasfESYk7curOLo+H
	A/qcs4i62d0n2UdxVdWPkFyyjlSYyuT8ddQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792562822; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:CwWRgz1YlptNsu99UOiafMSrdD/A3Sdj1mX7of0T4ghNMxZ
	8z6uycfdqUfayV+igNhaDbEqDgKHta5b3b2/YLCFe6G3+Dk/2uUJurbLZDgKHV1E
	JlJVRXtfEKHUy6LwsnuldeJ9SGrpjooJu7RINEi5A2otCXNVFOuBLOKf4zESa561
	BG7bDDVgw8iEo5riXvjYe7so44eRMEQLzZef40C75m+rb+AAboeF5Sz1FCfpq1mz
	PxI/zRpzmSjpgh2lklLA4/zq9p0uiNSvmRdeP12J/Mf5R3BAXbNT6USIrgCNysBO
	oeaPJ6z/kJk/tU+iYTfaCeJnwGjCQwRuuGZ21SQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:U3pDaMX+/SLGM/IqwKD4ZmDwg+ZQjRkCOLC+h1FQlSI=:xVqEJ1kfXUwjpgqS4x6eh9dTKG2DBVn6uyP6zX463hc=;
X-ME-Sender: <xms:hlbYatwXJ6DKEYChcj-Mr9tU5zdNPimlc9xI1CZ08YlK1T5PLw-Zrw>
    <xme:hlbYakSRE3qRDSL66iOVFaG8bsrNDj9I5vMljhXyMnNe7ugTQFHeyinGeSRJ1Cc8A
    TqPV0MbSkW7I7U01ZmtZeDEOxwKZs1yTe6Yko26a9UYg2Erzxwy-g>
X-ME-Received: <xmr:hlbYasX_cd9I7GdvV_l3AxDYBthq0uiGtiM_bIW9NGcZ9UJkQezz65zfkAlTxw7r-hatAxwsrBvZpCKFBNjK2FEPdhIZVqf8JZQI>
X-ME-Proxy-Cause: dmFkZTGh0knN8UzaiuV9cQjPr+gdyYaUDN+rPBr1PP0+wfwfFqJDxVrE9uThlaUJt1TCw7
    uLLZ70wqMCGiWxykmC2Xnhf/hApwWSGrfS84KLXFGaIdzzhV3vwJrApddNBzzQDKMaacS4
    i8Qer6OI2VN0J3k/puNurop7K+FaIkClk2oEwJe8WG+zU35SZD8dNiWx54yzNfxvyxxHQK
    bmVxJ1aqG1PTvX3j/w+t5Txvhmui9jIPJNgCavzxfcly+vS+pxzs5zCrC9/hv4WN+vhZyq
    NV9GWlSN3qKzD6F+5NiLEy3Z3cX+wMSW5o5+DJhsDJ6nXpPXYo2t4o2n3vK7iSptpjcxTQ
    corlbpkH4h+6j9I9I2LP4G7JMMMSUr1/VRnwzLeO/Pl96TaKhGvCpKnCore9OLGpdOXh+u
    MyoTsR3apt+FzH0jAMx+YOCntdUdTeh5cZWZelyllOfioLiZZdwc/7ZJLHsR+f1AqnHyvX
    ks1DLaIq/dd1EpniVV6t8lKAoDAufSZAp8RUCcl8gwEFewJrK7cARPmqMbjJARHOzCqLlT
    o8s/dOvBtK6wYNXImpo7GcoqRO6KleuIfFemIYjKHsBvMxBkxlK5Dv9EE/Lx55Hn6H7FiY
    6+QLATWa+tTA7Ve6wr2fq1PlNuw5DUaG4coUhGyRzbpUzuwADm45UiVlx0Fg
X-ME-Proxy: <xmx:hlbYaubyEAjLhoUQ81-NTbxj1JhhZOpfJulJOooeEFESXV5QZf6N9w>
    <xmx:hlbYaq1Fu7a7FzE7ZpnZZhdQQuLGfYykWzHKPzJyWAsdQ4wzz0hmOA>
    <xmx:hlbYaohmaJ4-aUC49g0Lq0PHFaZCRFDkHmDBfc0B6KWffJNuSZocDg>
    <xmx:hlbYambr3Dtb4WvcZgTwe1mSe-SjQAMxHjHZXZk8HAgn2v3qLDOb4Q>
    <xmx:hlbYam2cXCC9l4PGjv-CDRi_j7B6yfwJbF_9G64a0DlAD1P51a0GDTp8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 02:07:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?6YeN55Sw5LiA6IGW?=
 <kazumasa.shigeta@kanamei.com>
Subject: Re: [PATCH v3 1/7] stash: use an enum for create status
In-Reply-To: <9e27bcd676ee763ed499fb337b1497f3fe2405b2.1792509606.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Tue, 20 Oct 2026 16:20:36 +0100")
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
	<cover.1792509606.git.phillip.wood@dunelm.org.uk>
	<9e27bcd676ee763ed499fb337b1497f3fe2405b2.1792509606.git.phillip.wood@dunelm.org.uk>
Date: Tue, 20 Oct 2026 23:07:00 -0700
Message-ID: <xmqq5wyvsi2j.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Change the return type of do_create_stash() to an enum in preparation
> for adding a separate value for "there are no changes to stash" in a
> future commit. There is a small change to behavior here which fixes
> an anomaly with the exit status of create_stash(). That function calls
> check_changes() without refreshing the index and exits 0 if there are
> no changes. However, because it does not refresh the index, that check
> is unreliable which means do_create_stash() can return 1 when there
> aren't any changes, and then create_stash() exits 1 rather than 0.
> This commit fixes that anomaly.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/stash.c | 83 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 47 insertions(+), 36 deletions(-)

The patch makes it look more scary larger than it actually is.

> +enum create_result {
> +	CREATE_ERROR = -1,
> +	CREATE_SUCCESS,
> +	/* No changes were stashed */
> +	CREATE_EMPTY,
> +};

SUCCESS immediatly following ERROR that is explicitly defined to be
(-1) may qualify as explicitly defined to be 0, but personally I
probably prefer to be extra explicit here, like

	CREATE_ERROR = -1,
	CREATE_SUCCESS = 0,

even though this is not worth rerolling the series for.

> +static enum create_result stash_staged(struct stash_info *info,
> +				  struct strbuf *out_patch, int quiet)
>  {
> -	int ret = 0;
> +	enum create_result ret = 0;

Not CREATE_SUCCESS?  This can be returned if various checks in the
function assigns different values to this variable, right?

> +static enum create_result stash_patch(struct stash_info *info,
> +		const struct pathspec *ps, struct strbuf *out_patch, int quiet,
> +		struct interactive_options *interactive_opts)
>  {
> -	int ret = 0;
> +	enum create_result ret = 0;

CREATE_SUCCESS?

> +static enum create_result do_create_stash(const struct pathspec *ps,
> +		struct strbuf *stash_msg_buf, int include_untracked,
> +		int patch_mode, struct interactive_options *interactive_opts,
> +		int only_staged, struct stash_info *info, struct strbuf *patch,
> +		int quiet)
>  {
> -	int ret = 0;
> +	enum create_result ret = 0;

CREATE_SUCCESS?

>  	if (patch_mode) {
>  		ret = stash_patch(info, ps, patch, quiet, interactive_opts);
> -		if (ret < 0) {
> +		if (ret == CREATE_ERROR) {
>  			if (!quiet)
>  				fprintf_ln(stderr, _("Cannot save the current "
>  						     "worktree state"));
>  			goto done;
> -		} else if (ret > 0) {
> +		} else if (ret != CREATE_SUCCESS) {
>  			goto done;
>  		}

I wonder if switch/case is easier to read for these users of these
enum return values.  Some check explicitly against CREATE_ERROR
(like the one above), some treat anything other than CREATE_SUCCESS
as undesirable, etc.

>  	} else if (only_staged) {
>  		ret = stash_staged(info, patch, quiet);
> -		if (ret < 0) {
> +		if (ret == CREATE_ERROR) {
>  			if (!quiet)
>  				fprintf_ln(stderr, _("Cannot save the current "
>  						     "staged state"));
>  			goto done;
> -		} else if (ret > 0) {
> +		} else if (ret != CREATE_SUCCESS) {
>  			goto done;
>  		}
>  	} else {

Ditto.

> @@ -1660,12 +1667,13 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
>  
>  	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
>  			      NULL, 0);
> -	if (!ret)
> +	if (ret == CREATE_SUCCESS)
>  		printf_ln("%s", oid_to_hex(&info.w_commit));
>  
>  	free_stash_info(&info);
>  	strbuf_release(&stash_msg_buf);
> -	return ret;
> +	/* Do not return an error if there are no changes */
> +	return ret == CREATE_ERROR ? -1 : 0;
>  }

Ditto.
