Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5741311A1
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235612; cv=none; b=ESnkaIH7BKi074OedaelaCDUQ+62ok7uLVtVqUZ7GHBUkB9YYp6t02twbm9TCha/FAH6ALNzYbl53RUca+pIkvppYVSen+KY1oo6oikh9unazPHe35UKRQQwUhVAM7XmFlbC6oSdTuRpoR9xkvajB5BVY2K+U5GsxjSn9BAJt6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235612; c=relaxed/simple;
	bh=xhFBAhncWm5TROliwNfKc8n5sO5e5145X/KYswpk7+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MEP8X8xaoUThFNi4u2WJt58wwRH1O3q9uH/P/6bkv1IqQVEnqirdnkRZKA6rZTuq9kDJS0PgGEHGmk6oCoIs8nmLIkwyBaUX58Xw13M8EFCHdhYPZyTMRuCy91w1IHzY+g5p4J4n18YvXr+NTwndR8DoohtOm4l2JsjfO3MujP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5cIjQx6; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5cIjQx6"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4ef63c6be17so58081e0c.0
        for <git@vger.kernel.org>; Mon, 24 Jun 2024 06:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719235610; x=1719840410; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/qeqKLWN+EXV2cZmEAa6fSnfpacBdLeWlq+aQ0g2bY=;
        b=b5cIjQx69n4WMU/bwzLAiQvl0bxOhqNwIjPGhQmMQbSWCIqvMjr0KnBEX45/8jX/Z9
         lkyOt7HVHVShlbFg4mjKPFf2auZhIQ4B2Oetvew9Ix5PHXygNjXoGo7GpWqL6wj3uKTe
         uw/xwqbpxWiKIHvTbHyH/SrCIZP3/KzJnxlBLUiAQ/ZZWZf3NVAdCwJ0P3DeY3ROsXii
         z5X78oR85DOtgTrzNAhPTJ3odX+v0ei599hNNR3m8exUQFk5Ry/laJL8NolIjRPGuukh
         8z5yMDqQm79BQXyeUX/CuF09OuNPprbFo5ua5brFxV/V1UoAY3KRi5/P9tQcND9ZfRHh
         Id4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719235610; x=1719840410;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N/qeqKLWN+EXV2cZmEAa6fSnfpacBdLeWlq+aQ0g2bY=;
        b=Gt0x8jMWY5bkuelA7wj9jErHhIJazIWrV3cDzxSC8xMenLLFlZMZ58LkUCVuDC5nKS
         I54tURcgX3TorhgE7WajVXyra/DXdYTNyhp/YfryuIsajGX093D8bqsXLzsFXh0OQ7Bb
         97V4gTwA381ox/TRfT6pmPqiPjERxKW4OhirYeF40T0gjkzHuSl8Gfljgv5OXpqu+fS4
         Cx0TKIUe7Ubm51HU+rsPngA0LkaGD69ad+v1/MCcgMA4LbppzCMvod5Jl62xBEMT5U3C
         V8Q7RTCaecw2aoJusd/84ZdqmiqFKIdfYOcPl8h9yJISaIsHF7BqtTmKNTSOSJ4ncZ97
         AtpA==
X-Gm-Message-State: AOJu0Yw+CKCMc/1ZHsjtj8IHpdh/3B51mMzgcvJqbK0Cmc7VByPVUm8p
	SJFQTdh93qBSq3kxzPfe021uvuU9VtOB+QOWECBafgfm/qEKl8On
X-Google-Smtp-Source: AGHT+IE/25HTTB1l8a7iapUZtZq4mcPl++Y94Gw+klSAXN3Uf5+hIss/f+bMPmSe8kRMfAJQ5zxwFA==
X-Received: by 2002:a05:6122:1e07:b0:4ec:f2b9:65c9 with SMTP id 71dfb90a1353d-4ef60c519d4mr4803393e0c.0.1719235609838;
        Mon, 24 Jun 2024 06:26:49 -0700 (PDT)
Received: from epic96565.epic.com (pat-verona-k.epic.com. [199.204.56.216])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce9318f6sm311872885a.101.2024.06.24.06.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:26:49 -0700 (PDT)
From: Sean Allred <allred.sean@gmail.com>
To: "dark0dave via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Revi Ewer <revi.ewer@example.com>,  Ill Takalook
 <ill.takalook@example.net>,  dark0dave <dark0dave@mykolab.com>
Subject: Re: [PATCH] submodule: allow gitsubmodules to be pointed at tags
In-Reply-To: <pull.1703.git.git.1718625706679.gitgitgadget@gmail.com>
	(dark0dave via GitGitGadget's message of "Mon, 17 Jun 2024 12:01:46
	+0000")
References: <pull.1703.git.git.1718625706679.gitgitgadget@gmail.com>
Date: Mon, 24 Jun 2024 08:26:48 -0500
Message-ID: <m0wmmepj3b.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

@dark0dave: sorry for the duplicate message; mu4e changed its default
keybindings recently and I neglected to reply to the list as well...

"dark0dave via GitGitGadget" <gitgitgadget@gmail.com> writes:
> Intent: Enable git submodules to point at tags,
> effectively freezing them
>
> Context: There is a large repo with 50+ submodules, the goal is
> to have some submodules update to HEAD but others to remain fixed.
> The update command does this by recursing through
> directories. This is very useful, however if an update is run,
> all the submodules are updated to HEAD.
>
> The goals:
> - Be able to create a submodule from a fixed tag (complete)
> - Be able to run git submodule update, with a flag to either update
> or keep the submodule pointed at the supplied tag (complete)

This is an interesting idea, so far as I understand it. I certainly
appreciate the desire to freeze your dependencies. I don't use
submodules often, but I do want to point out an inherent assumption in
your design: that tags don't move.

Tags can move. It's usually impolite, but there can be reasonable
use-cases for doing so.

With this in mind, what can go wrong if you have a submodule with a
configuration that doesn't necessarily match the tree?

-- 
Sean Allred
