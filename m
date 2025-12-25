Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A914C6D
	for <git@vger.kernel.org>; Thu, 25 Dec 2025 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766678919; cv=none; b=F9qF8mNLJ6+bn1/EJHOtjbFfjpx4YXxMEcXWSxJiIBPihz9eSQ57WDofnvgRIfVGMXSs/aGM5kYrNQQici/gAKRHOrn/sM1/txtygU1R/5eOE8tDUxg7Yyvb16Szw96/FgYpmP/pZ3SROULTZk7uR/N7JRkDPn6fEgG+eUf/zsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766678919; c=relaxed/simple;
	bh=Qe06VSMoRvZdC6DlZn73x4V32KrHK0zsbJiICXUtpZA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pIrn9yDAsyo75dbqxQpk5SM2iUVRvH7u8mCz/H7AxltFw8ORiOcSTRWtgP5ZuHCgpwkC4Fvc13EDRG/nQoqLOYv3HlfaMbEVVggX7VkpfV4vQpBIpb/bXrCoBrKs08UeprqVBNOAJZHMBQUoRA3KGqOM7+/bANOhnHKBUa7q8mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C86O+iHQ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C86O+iHQ"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-598efcf3a89so6655608e87.1
        for <git@vger.kernel.org>; Thu, 25 Dec 2025 08:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766678916; x=1767283716; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:subject:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qe06VSMoRvZdC6DlZn73x4V32KrHK0zsbJiICXUtpZA=;
        b=C86O+iHQ99YNee/IEQIJn5zcxsxfpC88qlOD/c6aVqn0PYEvMM5NckXopbTO0pOxdA
         dHrWMZ9vgm3DgfGxCUTMF6jiLTxKAmEJb6UtilOxCAi77aMQLlgenytQTEcslNXEQF5u
         VxKimYrkGEgZwDh3c1NAoe9+J1iqVSU3ooKG8/pcPLxIV7KCwYtsBMWRTVV13WBN00Om
         mSvL7TNR/Gn06SXP54oHpj9VhIBQ0dheHl/SSkopg7DIWts+hq1jl8eihlyVyxVwxHKP
         mNrEYh79azYq8OS9FHimsnHabUN7DbpbQNC0VIZlpvLYx8rKsBYwnBrov+TXQx+W5omI
         QXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766678916; x=1767283716;
        h=mime-version:user-agent:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qe06VSMoRvZdC6DlZn73x4V32KrHK0zsbJiICXUtpZA=;
        b=D1SZxFKwgkm5VEWQNz1TQIur5rO20hRQMUg4JA8VjzZU7ddJycuJcMCX0t68zty7JI
         5vxGAMJhc4v7vba8sJnUvAgjIEmN6RZayOwykoTK/dU8Hh0sYsfTnCTTtGIfrFCidIA1
         3YMhE7twkrEoRJF4jQQ+824YGFJeMqxNHefjQGQAkBwRef8+ddzOrFPoQrdMydodjtrm
         bzrNiHZXy5RmZOBXFJbvy77huAFP99JjF6dSeHYzcf8ZvydlsoD34kh5t5QRT/9tn/1e
         MAAdhomDc/sqFQ7gs5F3fE9ds4vaHCiiJQCSvGAg0zLbMSo/Bju8Fibi+ku//ZBhJGz0
         uo8g==
X-Gm-Message-State: AOJu0YzEXZM5IvBrlEl+CxPZw89WL2gvXvfoDbLCm2iFVlZkRWKwiCHx
	/6pob3qf+9O5ztBcrQXq5LHQBy5ipBH9g/++NDWG8J7dhO4Ix1ALGXHYMHmkP/Lq
X-Gm-Gg: AY/fxX5BXkiWvBxLXQLYlxtkPmL/04s8eHSZsK58g9ovXC4m4d89UebHNLT+VW7wxL4
	OpV1mftASvAPVxdY/Pf7lSfxEKIUWbRmzasUJVt32RELoOr+kdbrn8vvmbB+6K4nqMkmh1/E/aQ
	FSpQoKONLlOj5qi3TrJt7mLdeqA7Qd4A9Haq7JM5x2mOCCz91rU96L6/JTi8ixJn1UgUzppZ0CE
	AlST4gmLIRfXkXjwFoVcFw6Ji72LWAu4hAiejQWIQ85WY83GxRX3Gl6JBHjEDmcWNkDLOFdfkml
	itnqLao+z/KRFlbNn6dOTsBOGv1haEJleEbVwSB87gzSOEW7W1syMPFf5sedf2a82WEedmCvh7D
	Wv4zjLOEHhk43O/Kg9sJk0MM4iUa8W5F4R1ujZ0N7m9iQHCetmaIIHOX4wVD2o4RuM3nYFM2rJB
	q8hP9dMYsvRkZYVQ==
X-Google-Smtp-Source: AGHT+IHTelxsAtrCo0Mlm9teNFS7ODUsreD4Zqcmk2m7gmOobsa3OzawlDHLMash84nCkku9CHkizA==
X-Received: by 2002:a05:6512:1387:b0:598:ee6c:e6f with SMTP id 2adb3069b0e04-59a17d74bcdmr9289254e87.3.1766678915868;
        Thu, 25 Dec 2025 08:08:35 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d5e5csm5973631e87.15.2025.12.25.08.08.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 08:08:35 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: git@vger.kernel.org
Subject: Why git branch --show-current ignores -v?
Date: Thu, 25 Dec 2025 19:08:35 +0300
Message-ID: <87h5tev918.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hello,

It looks useful and natural for "git branch --show-current -v[v]" to
verbosely describe current branch, similar to what --list does. Is there
sound reason why -v is not supported by --show-current?

Thanks,
-- Sergey Organov

