Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96B034C130
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783975884; cv=none; b=pu+TiOf0W8GXsWQmvknqIfddZw77TI8gieg5hVr9OHRfGtPKzD1WaB0xCJcVhTqeFyvbvOut7zoyvNdA8xXnRI9X63X66DX3++KYDV+UpGyEF8wOtZHAzwlIEbeYBp6XjTDxrOvjOoD9QQNJkiSFFbxINelocnXcQ/7gY1b2KzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783975884; c=relaxed/simple;
	bh=Q2WdrJp4PZhq07XNcWjdXYdXH1zg8YqbXaQnmC9sRMQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=R7KBzmd6gJOMm9pa9EbVT9L63a8U8cOxrLexVQ0SdHUdaMTECrtE4+qD4j27pQEmw5EIgiALbIYzzBand+/EQbiJFswYM1wtMDvIb+ekq5Qw9AXWBBLsPD/telfknEDQfMhJ4xYiI5bQcnRyQTI6HQRmIDHIvSd+fw8vo7elvbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=be36tspS; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="be36tspS"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso2382313f8f.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 13:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783975881; x=1784580681; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pt4ldibqHU3NM12qEiSVQb5NdvuO3AdEs7LVALxfRxY=;
        b=be36tspSo79A+04xivUnQQQcPE2gH3ZsD74f0r4uqYkYjhbkd2C2w/j2Kjyg/wKL9L
         Fr3PHo8zhscI/2v9oENJK4k/tyZc8uERVquT5cbc6e3AZozexdh7wQgFj2ImOzWDUxSG
         qhJYo4FrIU/UEITgI8uuoxJY2pz/drtKLLCecAGNqYkSqWjX/ZCvPurrPlH1lFH4y+Hg
         hD6FJ99Plmo2VJ6E2cGjBX9ItNgPyMhbdf7/VaS2d66ZqOcj5ym/spTH1wE/BIvvOvlG
         WRMcX7smolD7D+XPfWHFAXqirU/vi6Dtzo/1lgeDeJBK1zeZoUATWV58WuXi58szXx3H
         581g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783975881; x=1784580681;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pt4ldibqHU3NM12qEiSVQb5NdvuO3AdEs7LVALxfRxY=;
        b=ncxG2l308QRyOChJJZd7U7+dHfz8LfqklfvZXtYfbmRKGfz8kBuKoWZQTOcTi3WzRu
         pVqTCMUEIPzUUhReFi2+ADwScTZGj7Gh1qk7Z6OOR2XFTiUZ4IRT5snOHwLDSL7rV8bB
         ZcgwRPKrkcOyrtP6fcU/db8kIDc8oYU92wYzu5Ngx04sLfwJiIG5o8BCF1I8I4lhT/SF
         ZxHSPEco96aqUUFVDuGD1kPjLz+DRbbuegMx5EJ9gTC78MeIyMC1fbQaP10Xt2FH18Jh
         4X3+ADZ5L6GQCCTbVpmzleUL0p8xdjhhZuUnfOtUOwntHTJ2mfJg2E+RLykhP5AExITY
         Q5Sw==
X-Gm-Message-State: AOJu0YxOOoqBpxMb7A74WUYw3eiB30fCqZgguIZP6LNeTai/Ab19/5Zs
	YpJlpoKr9bxZUw77iK6kcx0BpLlS8HIS0Qv4l2085aZzR/CBTAmMbyNfAOIwg4Ea
X-Gm-Gg: AfdE7cm5bHZhjwk6ehEM8yC+E8PE4eYekdnk682Bzbi4EiVZL4rHXm5rzeo+z/2V1OI
	ARBtCXjLBZz1BCmNXDUQAnmMpErW/6WPmD9ThmecC7kgPiJy+AAum0mNW22R97nwKiR6jG7s4s2
	egFVtFJ/VCzCgtIW6gNIl0uUscQr0cKCgQarD+RGrJcLhALjoa3LSNdRRX+6CfGCWZj+50m3KoC
	7UGyz5xF33yT/aRZmknHx11oaDVvm1qRX6KT5fzou74hkUB4Rq6VouB69Wks6J8nR8ZzxQbNq3t
	goXFidkonkWgs46zeZ/F7qBMWQbl+OjPeTdiki5dP8oob2+J5IHM+3pXI2FCl+cjRSryM9yEVcS
	Wmi/3GxYFOsOSOREnDBSn8Vs2tAlqcSWnBN9uG/iBqFM9wsAnRIK66ngQ3tD/KMCD5czUPrW82F
	EWLofc4KFv6hK/h8Na6dPiduShgJ5x6jBJ11YX/seiCDhlOVVf/MhnFl5K9kwU9aUAPlW/cR3/L
	0aSaTkdM3FdCWel/etDaSKwv6ZitufGkwlNRU9e55ZMZmU5zTnj9lloOQPqHQDigY+zMV5pnD3k
	drhrHfV0/gPdTt0IoBI4aQgHxqjtB5HaZZcGRxOWiFa1WXlJpcyCigN3ZEc8vbNjnVGqxQ==
X-Received: by 2002:a5d:5f42:0:b0:46e:47a:dcd3 with SMTP id ffacd0b85a97d-47f46340a9amr1650934f8f.19.1783975880996;
        Mon, 13 Jul 2026 13:51:20 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a9879sm2564409f8f.22.2026.07.13.13.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 13:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 22:51:19 +0200
Message-Id: <DJXQO504VCLC.10N8335V7Z1LY@gmail.com>
Cc: <git@vger.kernel.org>, <ayu.chandekar@gmail.com>,
 <chandrapratap3519@gmail.com>, <christian.couder@gmail.com>,
 <jltobler@gmail.com>, <karthik.188@gmail.com>, <krka@spotify.com>,
 <mroik@delayed.space>, <peff@peff.net>, <phillip.wood@dunelm.org.uk>,
 <siddharthasthana31@gmail.com>
Subject: Re: [PATCH v11 0/7] graph: indent visual roots in graph
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
 <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
 <xmqqy0fews69.fsf@gitster.g>
In-Reply-To: <xmqqy0fews69.fsf@gitster.g>

On Mon Jul 13, 2026 at 10:28 PM CEST, Junio C Hamano wrote:
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
>> V9 DIFF:
>>
>> - Changed boolean variables to be bit fields.
>
> v11???
>

My bad, I updated it manually and I forgot to.

>>
>> 7:  737331b68d ! 7:  c1fa81022e graph: add --[no-]graph-indent and log.g=
raphIndent
>>     @@ revision.h: struct rev_info {
>>       	/* Display history graph */
>>       	struct git_graph *graph;
>>       	int graph_max_lanes;
>>     -+	int no_graph_indent;
>>     -+	unsigned int graph_indent_set;
>>     ++	unsigned int no_graph_indent:1;
>>     ++	unsigned int graph_indent_set:1;
>
> OK.  References to these occur primarily in a boolean context, and
> all assignments to them are either 0 or 1.
>
> graph.c:442:		revs->no_graph_indent =3D !val;
> graph.c:1008:	       !graph->revs->no_graph_indent;
> graph.c:1353:			if (graph->is_visual_root && !graph->revs->no_graph_inden=
t) {
> revision.c:2630:		revs->no_graph_indent =3D 0;
> revision.c:2631:		revs->graph_indent_set =3D 1;
> revision.c:2633:		revs->no_graph_indent =3D 1;
> revision.c:2634:		revs->graph_indent_set =3D 1;
> revision.c:3209:	if (revs->graph_indent_set > 0 && !revs->graph)
>
> You may want to rewrite the last conditional check to:
>
> 	if (revs->graph_indent_set && !revs->graph)
>
> This avoids confusing readers into thinking the member can be set
> to 2 or greater.

I'll do that. Thanks.

>
> Thanks.

Regards,
Pablo.

