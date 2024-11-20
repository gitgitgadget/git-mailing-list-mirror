Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D79C1BDAA5
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732146713; cv=none; b=a7lQaPOKJBL4DQN4zeyuHtECLG+73Gao3COPCG50lPvSsJ8IX8TXlpJDzWRQ7+7GXyto1asLH+I0MA3uEZhWnRGbzmM6WrNeJsbv4JUuJW3LWGgHQ35rf1wkITKO3PHQxMIYl+GtDC63GtE2LHlYE1TJ10De226O4n8aYh1ntNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732146713; c=relaxed/simple;
	bh=pMvKLWPK4taE43M1862UYJCnRXOZffA2UvaY7WXx4SE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u2essZfZxzk2UrNhI9gO5ySQ5AIgUMt54kj/zRLD01u0dWWrYocxfnMtMNn8beiD3M7m66h1G/YuZ6yfbjnpvVOEsK98M2tZnBqsTKWNIDzRcCWqJ834K3o1WgFQBgbxxYptz2kFzuJN9qNJ2aUahPkQp+dxD76zX88U9wuVnPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XzkBOruW; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XzkBOruW"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 150271140120;
	Wed, 20 Nov 2024 18:51:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 20 Nov 2024 18:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732146709; x=1732233109; bh=NTj2s5Zzc0YudXyfkSPUTQQGQNLBYhkwZqO
	50MDjYq0=; b=XzkBOruWbvDYBT9hUENdXvS7BowWMjZPQwZFZmQWhQrbvhQAicN
	pF7JKHudxhksOI26tjJXcc0IhtEA0eE0x2ac5WRoUKa6IMj1ihmX4X8A2YvILj05
	JTwH0wLyPsjr7Ho+SZz4cusidl2ocB/6yon0UZnPQFaBPMGGiMFnkr2HBRa58/pS
	fgZAefP8lcXbTaHdjiTSbQA4bki12Dyd3kxjV7nYMrUhEMg++6zHneS8E2V1D6Yc
	hi2Pe9KdIDISlQMsGX+K7GQyU75Y6HwdVCUR5JD9gOf1a5QQuM3bp0EpRDCSUvxS
	n39CPW+Jion/fZ6UZOcb6seDH3MZyYgrmug==
X-ME-Sender: <xms:FXY-Z_t1WX4FohrJsJZjllnzlFH8IRClJ1H-e9VouxYcAtkI-_XYgw>
    <xme:FXY-ZwfacOExCkdLbBkxSgPMjY9xmpmDY3RvPPM2VszzQeqjEHFg8urbJ36SGLq2R
    a2PHRkoVgz3-Yur3Q>
X-ME-Received: <xmr:FXY-Zyx3w2jMzW7ovdqDSOMbLvHyB9vMkoSvLDhQDdREKm7t0H2vsaXLnYnCwj_Nr-CeyCcyMfvBe6iAlomLd19Jx4STxCwZhffT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfihhvvgdvfedutddtfe
    esghhmrghilhdrtghomhdprhgtphhtthhopegsvghntggvsehfvghrughinhgrnhguhidr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FXY-Z-OxvoHLwvZhC5MiGuIvaF5MI86UXr1UzizmK70iGsh9F-2FPw>
    <xmx:FXY-Z_9zi6WATHLnukGHSKaQXetgehx1UdKdUVC6Y54xSk8gb97RGw>
    <xmx:FXY-Z-UZklh1_tvOd9lMl-80nJfSO6ZxbiWg4i6WG1YcDL34IJIKug>
    <xmx:FXY-ZwdWMuETwxyNMsFGLFfZO0EZrb16GEF3CkSnrvoY0dcgFuOjgA>
    <xmx:FXY-Z7b-32er02nkvvPQNYundpEV47HtPXSU9IxkwXPHCg7Xmxw5gP9q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 18:51:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: Bence Ferdinandy <bence@ferdinandy.com>,  git@vger.kernel.org
Subject: Re: [PATCH] ref-filter: add "notes" atom
In-Reply-To: <Zz4Wr1YY7HxRARoc@five231003> (Kousik Sanagavarapu's message of
	"Wed, 20 Nov 2024 22:34:47 +0530")
References: <D5N39IJA0WDQ.2WH1MNIP77X2J@ferdinandy.com>
	<xmqqsersyrch.fsf@gitster.g>
	<D5NP6QUUBWBL.7OUG34RUIE2S@ferdinandy.com>
	<Zz4Wr1YY7HxRARoc@five231003>
Date: Thu, 21 Nov 2024 08:51:47 +0900
Message-ID: <xmqqserlh3ak.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kousik Sanagavarapu <five231003@gmail.com> writes:

> +static void grab_notes_values(struct atom_value *val, int deref,
> +			      struct object *obj)
> +{
> +	for (int i = 0; i < used_atom_cnt; i++) {
> +		struct used_atom *atom = &used_atom[i];
> +		const char *name = atom->name;
> +		struct atom_value *v = &val[i];
> +
> +		struct child_process cmd = CHILD_PROCESS_INIT;
> +		struct strbuf out = STRBUF_INIT;
> +		struct strbuf err = STRBUF_INIT;
> +
> +		if (atom->atom_type != ATOM_NOTES)
> +			continue;
> +
> +		if (!!deref != (*name == '*'))
> +			continue;
> +
> +		cmd.git_cmd = 1;
> +		strvec_push(&cmd.args, "notes");
> +		if (atom->u.notes_refname) {
> +			strvec_push(&cmd.args, "--ref");
> +			strvec_push(&cmd.args, atom->u.notes_refname);
> +		}
> +		strvec_push(&cmd.args, "show");
> +		strvec_push(&cmd.args, oid_to_hex(&obj->oid));
> +		if (pipe_command(&cmd, NULL, 0, &out, 0, &err, 0) < 0) {
> +			error(_("failed to run 'notes'"));
> +			v->s = xstrdup("");
> +			continue;
> +		}
> +		strbuf_rtrim(&out);
> +		v->s = strbuf_detach(&out, NULL);
> +
> +		strbuf_release(&err);
> +	}
> +}

I suspect that this was written to mimick what is done for describe.

The describe codepath has a (semi-)valid reason to fork out to a
subprocess, as computation of describe smudges the object flags of
in-core object database and it is not trivial to call into the
helper functions twice.

But showing notes for a single commit is merely an internal call to
get_note() away, so unless the note object is not a blob (which
should be absolutely rare), spawning a subprocess for each and every
ref tip feels a bit heavier than acceptable.  We'd probably need to
maintain a table of notes_trees, one per <note-ref> used as
%(notes:<note-ref>) in the format string, and init_notes() on them
while parsing the atoms, and in this codepath it would be a look-up
of notes_tree from the table based on the u.notes_refname by calling
get_note() to learn the object name, plus reading the object
contents into the v->s member when the note object is a blob (and
fallback the above code when it is not a blob, which is a rare-case,
if we really want to handle them).
