Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B534F46A
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 21:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341110; cv=none; b=ePMv31DO/BpQeOpOp/PKYRIg6MF2LbeT9IrA8D8KupbvUCsBNrt0UTTw5KyoD+zSYoXFDA++nX3aO89lpwuqg4bOXVpgsy+bjc7y36s2Xa2B6sdSuc6Y80KHkIktSw7ErDRObW6pUoFenqCbJSiRYMOxIYH7LrAI4AqMobue/lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341110; c=relaxed/simple;
	bh=s/GvWXQqKVpFGh0C8KSZG+w3D2n4JovKMKtEPeNXo0w=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=N8j5CPzId0CRR/k9mUY47Sa/yUESIYIXsj9vFEG4q/TjMRnUbLwmaTJWaHBzYvvfIRPBPw1rJ9UTzJ/06TyOGIDms1XVdIE43ca41529NN5vXtP52816BNau0BYRf+nOyqX1wDjzTEnJXasHyow5vQ63jYmidsv7d694qRTACxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBbSAvxB; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBbSAvxB"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7927541abfaso33147897b3.3
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 13:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768341108; x=1768945908; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/GvWXQqKVpFGh0C8KSZG+w3D2n4JovKMKtEPeNXo0w=;
        b=OBbSAvxBrtWSf3jOnNs6lkPx4PdvkV1ku0j/R94q4fa/5woZpP5Pc90kitM0RttcxQ
         SDT0QVgM6hePLTEakS40I28jMHUR5Er1HpRrPKKn/73XS6o/F3pbrEkZ+GcHp3C8ZidG
         P7yK7YtTUbX81e4CTJDNdEVap9hMztIZemlDAah1f+pWkEz43IY3rfy9qHuMFFkZGefb
         NwY1t8WH95+RU354RvkoyC5IfhKKAZE+bAr/CHVCwJck/gZix9XFNw099tqaw/I++x/g
         KZMmWgLhHDMSZoTLogBZucq1b98064429VazU0UUaSuG7Hp0qx4OPelp43f9JQAd5JRI
         bKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768341108; x=1768945908;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s/GvWXQqKVpFGh0C8KSZG+w3D2n4JovKMKtEPeNXo0w=;
        b=kZ40Mfby0uYxrMHcbhvL2p1aLgwbsBl2PDz2hRWpUW4m326KsMGPEXV8/TK3OJxv06
         Bm30GGzINMEYylDxEoAJau0yp9tZY2nce5NG58s6FBNaL9tcLHW3pfkuSC0G0eT616V/
         oxUueIz5f5CNd9DO0/VpOHUDss203iy6M9399eZkIlYaYxA8kmNCN+cQrzg0rRYYZ/aG
         tpF8NVXBq6HNV1pLMkVunQQ+K9VJpND8InHT+ljt5og9MFTNFNJ/kyMJ97uFoKT9C3jU
         1d/+STE62It4sdQ4NjLV+RaYwPUkM+CS2FyymtA2Csc6de1coeNxJOKDVsr6q4rTE3hE
         lTUA==
X-Gm-Message-State: AOJu0YzVrHZoefeosvfKpS2SKdiY0SkirJjTPX75Wk98Ag4gTyF6T34g
	9W7VHPH4kDyywQhgt0WRyBo2unR+H4Zd3SdM2Aue56dSxka3mZ1QdfRNFntmug==
X-Gm-Gg: AY/fxX5bf4gbwnRF6nI3ypneZJ+RiCyda7bSMlTKg8oLnv4U3PVuafa+fiSQOIdyN14
	44ngwIftbs1focjN0WdLgUFuD2o6Vzz6NpZj+wEMsI1gzdhB7JdwfRl3CtxcyAcCWYOsv5TgdsX
	RMNbiXOjtIZsV5NeqYjfmPLJBo9QeHvO5v30BHTWb90P3o9qVH8V9TgOUPMaRFxA/aRUuQhVa9s
	S+OJNmPgcuzty497nEgLiPsQcylTbY/t/8tVPxsD//QPmyTEZAjnFNr7kyawwafrhJ6esKgOWFM
	+UVS/B3s9P7K1MWmf8GQk4NkPUqsKiEUkpHLtOUoRu5yWQqIFrRnEv31LiBKz4Hn6hAfE+FP+0S
	L/1A/cQxBTBkAIbWjvcliL5VNQTy+dTBjDr5AHdmh5wBtCuqYvEds2HMG8xbAOWqYfBnOHiP6EC
	3OEbp+9Lwee4EDdq+D3kl4cAl3rynpKSdgcQUr+MM7u4Xgf2yNf5LYkKyZpkaRn4O5FBQWLwsOT
	Pi4VSM78LP5LTURpErF8Sx8rHpD
X-Received: by 2002:a05:690c:e3cc:b0:780:be5b:345d with SMTP id 00721157ae682-793a1d86adbmr3956847b3.54.1768341108353;
        Tue, 13 Jan 2026 13:51:48 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:18f6:dd0a:cf21:e611])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6713e5sm83370037b3.29.2026.01.13.13.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 13:51:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Fetch missing submodule objects from default remote
Date: Tue, 13 Jan 2026 16:51:37 -0500
Message-Id: <7FB6BFD0-4C54-4924-851E-D4B5C574D7FC@gmail.com>
References: <20260112213612.2761854-1-nasser.grainawi@oss.qualcomm.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Jacob Keller <jacob.keller@gmail.com>
In-Reply-To: <20260112213612.2761854-1-nasser.grainawi@oss.qualcomm.com>
To: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
X-Mailer: iPhone Mail (21F90)



> Le 12 janv. 2026 =C3=A0 16:36, Nasser Grainawi <nasser.grainawi@oss.qualco=
mm.com> a =C3=A9crit :
>=20
> =EF=BB=BFWhen be76c2128234d94b47f7087152ee55d08bb65d88 added support for f=
etching
> a missing submodule object by id, it

Convention is to refer to published commits using the =E2=80=9Creference=E2=80=
=9D format supported by git log and git show :)=
