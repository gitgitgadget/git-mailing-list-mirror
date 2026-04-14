Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E998256C6D
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776192254; cv=none; b=hjmjVK3viMEUE2p/VvEUdnOmtfBEd0iiZDau/X7g9vBrL8+Hgj8a0wogkEmvkXOFJHcivmxoElbNHgCZJ6bqQ2DpHk4w+KLTaUx7PrXFQ68jz55lBwWaN4CGakXb/+QVpGjI77XcKWQeCdHKdt2wrgxC7buo7hO7mD2LrdhIvVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776192254; c=relaxed/simple;
	bh=PKU+ApozoJKCuNptoHE8ozn8NDKfs4VonFdsWMlDrBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGHUw4O4jiWckvY3eaxTGd9m8mLdc0rhkfLvh5LwVPya6u7SROlrWK/I1eMkyqsu0DnLaAHFF6aJQIDQN7HLPh3bR5Skpb1eCKdAhejrrxWwmK+ceJL6xZKE57rCnDpvY7M3iiIYmemQrYp6w1LbjE2rPqWDo7F5KtphgiIC/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVS3DLW1; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVS3DLW1"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a2c9c5ff87so6011787e87.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 11:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776192251; x=1776797051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgrdSWqLPOZ79OYU+G0hWwCV+UOktGj4WHrzgKjYG/A=;
        b=aVS3DLW1UWQaSMaH/PUQZquHNyAmrYrWXfJ26cWbXvcDogeBTL+4f+StD+SQzfAMrt
         zW1juGB5tprIdX0wVpaMXQjT8JXTeTUb9jbLCmNKwIQNLauv4qo4UbdPPSEWTlPJO7+B
         fXUWMrStZoQPyx1oMd5XC2SdeBYLgHPEMpbw5SKT4QbpGinGTw8ZB8ic4KrBsmTGqL20
         rFpcsHctl7A9fRDnUhWlFzWJjtbi+Z3msYrW9W6QcB+BIZle9b7qwOZuJvbxc34qGKef
         lYeBJzRunP4wOMdiWBncizwxffOSs5UH9mG4iAAHJG/E+nDw4WYRU8+vJ88Cywl59d/l
         WRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776192251; x=1776797051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mgrdSWqLPOZ79OYU+G0hWwCV+UOktGj4WHrzgKjYG/A=;
        b=VKHCfa+9p2YKvLj9HFaXXGEXye+axH63j2FlT268rCKH5VZtZQFFO+ngQSWbsjYGsZ
         wx0BU/3WvlVKSC8dYpueTegeZDYaHMsRRhAtjuWr8VqXkQu9tLMJFDWMcP39Dr3Abwlo
         oYKQljEt4n0Iezv90PNYWty19xv0Z1v82q7oUTHaFWEo3kgIUHbNb9S2o1kwvzSZUm+0
         BqpaqqcJHwZpUDSuRh/Q3lta3OwYN+rwmRBnmGl3PBnsw2j2v980eQF7EAFIyhP363JG
         QiFoBDnAyoF66wv5U2/kQiN27gkLiz8UVqXu0pc1uGU6G8HR89D3FAhqn3xc7iuhe/X/
         T22A==
X-Forwarded-Encrypted: i=1; AFNElJ/0nc9u2fyeGSzQW9Tex+7Z3NoO+2vrjtchUYdsBCsykiriN8CYNFmSR6KODawhM5N/05E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4fOL5kA9zL8hV1idCrdOiH3BC4Su5lqONK5+2I8N9dX1J96kp
	vjcU7D6QcpX3EXZXMsXqZSiabEIJt8NsKHTPbGVIRoB8PlV6/wcI6KTP
X-Gm-Gg: AeBDietudZj1PyW0AtsrNc9fhPFeiNPrDs6wUWxrhZHfsgTFwNUd2J8GiPq3Evl3WXP
	jhMlR35qILcq8cdYNaq4Xoatio5V+4I+IURJCzge3aLaKr56nTLKj9NRCTh6RNPTQYwB9zVNMuM
	ZsBrCvcjzsJXJKDX8C+jedz04hHlDnSCQJR4kPOzHUvxnTCptzkzhbwDkBNqBqsc2ilo6bweUgO
	rFaur+eGx6b1CmtJXml/1xg4fjVjiss5w0dDBce3N++UF23SKWrYBShu21j1z8i6M/y52Eb+wt7
	GdzEI9DWRynEaW3hwbj2yjpxzeTFArwovzj3AbQse5XG1olcpVMaUADyGiweSMohWtg+z6YoGz6
	lD9OZ/sf1ciWAzQvg0IiVuCpRZSKQ+A/i5i/KhMj8z8c6Loi4ri06L4ffMSnZWOCkF7l6jAqKg2
	9ZuwCsIKwFe70Fy1ebrqzt/4FXxSHrxkrmoOs2LSiqx/XmR0RYPKUj07eaF1f9Jtzbsrueh9KGr
	agpK/USHXIv72Bd6DkoGgM8m18=
X-Received: by 2002:a05:6512:1289:b0:5a4:157:5342 with SMTP id 2adb3069b0e04-5a4015754b5mr2101513e87.39.1776192250939;
        Tue, 14 Apr 2026 11:44:10 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3fe37e253sm1453648e87.9.2026.04.14.11.44.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Apr 2026 11:44:10 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Tue, 14 Apr 2026 20:44:09 +0200
Message-ID: <20260414184409.82539-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.rc1.77.g97a5d87c81
In-Reply-To: <ebb65b1d-879f-4d9f-b25e-fe1c58a47ff7@gmail.com>
References: <ebb65b1d-879f-4d9f-b25e-fe1c58a47ff7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > diff --git a/sequencer.h b/sequencer.h
> > index 5d3bc83314..b0c891d3b6 100644
> > --- a/sequencer.h
> > +++ b/sequencer.h
> > @@ -237,6 +237,10 @@ int save_autostash_ref(struct repository *r, const char *refname);
> >   int apply_autostash(const char *path);
> >   int apply_autostash_oid(const char *stash_oid);
> >   int apply_autostash_ref(struct repository *r, const char *refname);
> > +int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
> > +                                 const char *label_ours, const char *label_theirs,
> > +                                 const char *label_base,
> > +                                 const char *stash_msg);

Fair enough, will update in the next patch!


Harald
