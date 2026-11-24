Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532646;
	b=DbpGJTAjzSt+49QH+C6dhWuFJ3iSuWoGeR+5tkbTFBfdJR1/2jKeQRXsVZx6+9mdJEbB
	 yFuVnv6WnjSIegmDItROALoFr8OvsPSE2b5Fl2MGlhBTIo5uNvYZ7EWAw+GT4yW5hw9z/
	 gUJJV3CnzH2Rv+jPajvpiW6Q1pYexVpZ9lIYQvgojwBqDbe9YeX9PoMztq7QyurdvI1+h
	 M02zVDwVU11B+1RwJSvD7BaN+Gi7GKBNgkzp37GNueAp1FPL5MT5yKprorwCC5W808+q+
	 Bl26vU83viMRD1Gf4/IjZBMzXkBu58tACh7Wd4RgAouwBMQY6Mpjq0hxn6ko1IctENg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532646;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=fqgK3/WCnkW3V9BAM0hio6dNqpLSLwqt8BR15oMpeOQ=;
	b=bg5fyuVEfvBcIjTs048TRTto9f3BVVyvj3t+42z3SQe/cH7Pu9ZziDnOqO+HPcwDPusw
	 sPacsVTb/6r1Cqs6OLY4ax7qXmptgXAyIX9FKRehOWXL/5yYeCEtReL0tousrMOy98DYm
	 f6gP3gaCIJk0HgmkPMZJ6mXIQphuUMd+/4UZEeSNPc6IfH4LrPLou/YY4PT6L6t4oMhou
	 t0c5zcAfh2ilZF4lulbc2Vd4N/qqaLa/1VfGp7Q25VCovBv9yLbmwEpueaBTEZgcLDS7z
	 vDnfuUbwXQ+oUg+8vcA3uDcCwuQ3ShRLRpdm0TC/dWHZN/RvmEE3BC2PQU7GkscA3tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="cCf/YIa6";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ax69VWz2;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC984606A323
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 15:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC984606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=cCf/YIa6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ax69VWz2
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 12CC6EC0940
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 10:04:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 24 Nov 2026 10:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795532645; x=1795619045; bh=fqgK3/WCnk
	W3V9BAM0hio6dNqpLSLwqt8BR15oMpeOQ=; b=cCf/YIa6uzhHX0o0rbsogZVdFo
	7WSJ5HCPI1HfwzPl5Op5qfLe1m2NWl15MIopiY5qcwvmxf9lRr4sXrq1NyGc626e
	GLgKYGvNzC5Kn1m6rXshAnXVll2P54uq3JDK5cIYHp+csOyE5r3YH61hXQYxatKs
	6VKAZ6fvpdS/lKefXEWsrms4mVBKXkNlZO4zUugr2yU60T0Z/FVCC3Mbr0kjdR5b
	4dG2ox9KU/ioqytbcoqedJnO7c3Nfj2LRY+RDlKt2mfxddvguYcHI8G7Zsyn+G62
	fZiBKkwYcf5fKgq8S8GQJZUgvcIM0U9BjD56SOZmlSXiOsccQKNH2xsoE37A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795532645; x=1795619045; bh=fqgK3/WCnkW3V9BAM0hio6dNqpLSLwqt8BR
	15oMpeOQ=; b=ax69VWz2qZLfUfMrB6MaCWOIwgWB3y21JWIs45Yr7uny5MZ9Vub
	y8Hd7CjJpIgX00l8BDDaX+DqLRLECT2rAXlBY7G94HwjgLLxDfGWsb7AsK/kklXj
	KvzMNN+29hEi8j+CT7U4HEhAmnmoJoJPDi3ILYQcp/DmPoqWyZGpcivzK2H3QoSu
	K4kl/2oYUat9mdPBFktJuoFlZsTqTA8IOfYnPHwfBChBqRN2NHm/t0qNt2uDf2B7
	HAFBgg/OgULrYAi1SghRK/TZDzW+z+rCcZzHFmvVoeD5r/rGS5aVt+mMkAbpbihY
	yQeWsSyKsOZ1KXf5k3wR8ZSNG16vmO+rHtQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795532645; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SFORxNe78MTStpNnzJfE7j1dMpA6C/uIru++K6zG08lTBuZ
	pm7cbs8SJ1xNJZcIuunkc/T2tq+T+zU/e+YQvgvys5ai615RP31AyQslOYyklRRG
	JeA1FU9K3lCdQzAq5XyiUTToHRyc4LkdY8jVNtmDvUCpQUeTPaVE64JuodtVTJUj
	fq1V5DgFVcuGzeTxdV0csA1Cmd5tXRXUKynpaXEXY+9oQiS8r7RMob2hZcmJT/z1
	dkQrtRAbNgqOIHfVhilFCdA5uyiv6bEQ2IyzchhzqOAJhbwscJpbuLAFcpLcnl/X
	fLeTc3ep/7rYb06Te0hST56d9M2GQyQfqz9azlw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:iSmv43WOluKkmtKta69oL1N2AojyiuAK3cNhjzwTsZk=:m5wBlNqP9j1G7gShrcXjv4MlN3NMQ47gLhPo+VI8PDQ=;
X-ME-Sender: <xms:ZKcFa8pNzzgHh_HIE2rKb0A6wNWubRFix-mXCZiXXufBVeBtKssXDw>
    <xme:ZKcFaxuWyOARPygC3fV4HS7GfDoxU5Qw2Uib7CW_oK3QKl35czquOIaQe_7U-4iXS
    KMin3zLNNUeJPRdlf_4CHtNCpOp5iAxrIKJI9qmMx5WiU5QKkehysPv>
X-ME-Received: <xmr:ZKcFa3bptEpqtacMfwZ91bVe3qpFGfDNsZb_3U60foyJjiGXpaLc1YCrEzhD4b1T8jZIlLOxasMemyq8Dfvn9dpn11cEUAFyYm6nUn0>
X-ME-Proxy-Cause: dmFkZTFYdcACREaNmoLy+E4DQAuY1lYMfKDJQ1oi93fzv2r5M14I5rZW8fcOsIYvdXX7m/
    0SACgBH6G+XDqThSia8C5ztnxY8DpMjeSas6u7cPBubsA/JF9xdyO83AWGqEQ6XKhw22/n
    KrkMsAev9rQq3xVHLDTU49uqnpVXuL5l/88mRdFoak2MY0RxHjQHZ8DWun+m9yad3ZOyyD
    hdJQxZmRNuIb/DVagDgjVX7FON7SiYyipuFefnBIY+fIuUaHWWtOnp2nb8rJNznnVt7VSZ
    cJFTcQPE7pRNkxLPS6lcfvBOEY1v0Xx5hDmEyn6ualkYi8UKmZzAksIjb3HNKqsFCGeEh0
    qpFLuuQz2nyIA9dEaqxprtP5YZbS1ND+Rl3iMlr8QBeeudbpsmYr8AGjyxJ9AvvD6enjm/
    GPXlCtLyIC+Zv+XUxMDru4773GJzTI+EcZtUO4CGP1e+KDJFy4BgnDT+j0ufuB6Bn6ZaXD
    RK+M0RCGAl0AtCsGvHi7TCvxjrLEOYM2h9KFAW8pbEnvZed19/4/r8nSXYzn86cYzzdzOX
    bgBeFjOp0jrljxMhQK7ro+EJJXn7FdWRJSzcVXsAoys5hhDmSjAh5+ewdfhZRDh0wWCq3D
    Rse1zgbRrGOym4p4q/bnxN200vtPJ1bzpHnGlrlCAUtDIIamVi7a/ld0z+hw
X-ME-Proxy: <xmx:ZKcFawaJeFp6Mj4cqVHvnvWuFsojf5cjILiwoMAPs5J1SUZh6DLqDg>
    <xmx:ZKcFawlKNH5D2R4xQgPrbQfJhhMB7VvUeQ2jCW_ZY4BcKZczSYN0LQ>
    <xmx:ZKcFa72Zy6Us5HKDP8xMPMYi-W9JMxl3WIpa3-jWzACXzY0U-pZmiA>
    <xmx:ZKcFaw2Uz6YINSBBTxc_SSBMwKhjUg0uAqK2rw02brdroQaqP8eP3w>
    <xmx:ZacFawVOUW-Y4-amgEoF72HCMzHDIqA8kL1BjEcTfX4xKKkeOC8U6Sin>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 10:04:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Matt Hunter <m@lfurio.us>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v15 2/7] fetch: let --refmap apply to configured refspecs
In-Reply-To: <f848c9b0a889f32f2bbe54fca4b45d2cad5d7ccd.1795348644.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Sun, 22 Nov 2026
	11:57:19 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v15.git.git.1795348644.gitgitgadget@gmail.com>
	<f848c9b0a889f32f2bbe54fca4b45d2cad5d7ccd.1795348644.git.gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 07:04:02 -0800
Message-ID: <xmqqcxruw9st.fsf@gitster.g>
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

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -585,8 +593,6 @@ static struct ref *get_ref_map(struct remote *remote,
>  			for (i = 0; i < remote->fetch.nr; i++)
>  				get_fetch_map(ref_map, &remote->fetch.items[i],
>  					      &oref_tail, 1);
> -	} else if (refmap.nr) {
> -		die("--refmap option is only meaningful with command-line refspec(s)");
>  	} else {
>  		/* Use the defaults */
>  		struct branch *branch = branch_get(NULL);

With no configured remote.<name>.fetch,

  $ git fetch --refmap=... <URL>

would no longer error out due to this removal.  Instead, it would fetch
HEAD into FETCH_HEAD while silently ignoring the given refmap.

I am not sure if we still want to reject --refmap when neither rs->nr
nor remote->fetch.nr (nor fetchUpstreams later) gives it anything to
map, or if allowing it is harmless.

> @@ -621,6 +627,11 @@ static struct ref *get_ref_map(struct remote *remote,
>  			ref_map->fetch_head_status = FETCH_HEAD_MERGE;
>  			tail = &ref_map->next;
>  		}
> +
> +		if (refmap.nr) {
> +			drop_destinations(ref_map);
> +			map_refs_without_dst(ref_map, &refmap, &oref_tail);
> +		}
>  	}

This is a bit hard to read without context, but doesn't this break
automatic tag following?  Earlier in the loop over remote->fetch,
*autotags is set to 1 whenever remote->fetch.items[i].dst is non-empty.

If a user passes --refmap="" from the command line to decline storage of
remote-tracking branches, drop_destinations() clears all '.peer_ref'
pointers here, yet *autotags has already been computed and stays 1, so
tag auto-following still runs.

Conversely, if '.fetch' has destinationless "just store in FETCH_HEAD"
entries and --refmap supplies destinations, *autotags stays 0.

In addition, in do_fetch(), when rs->nr is 0, prune_refs() is given
&transport->remote->fetch and not &refmap.  So

  $ git fetch --prune --refmap="refs/heads/*:refs/remotes/none/*" origin

would still prune based on remote.origin.fetch, which would most likely
be set to store in refs/remotes/origin/, and the refs/remotes/none/
hierarchy would not be pruned.  I am not sure if this is actually a good
thing.

Thanks.
