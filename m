Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCA912B69
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124945; cv=none; b=VMar5DY6LpGLPKVvGoHIKVx5aj2nXS5rpbPC8DFjFpZpWkh1gmtwF5c76esagMqUUYjLe0Mgcup9uyDVxGl9+jCkv80MzVggSaLzhZEusuio8UwUij4BxKhxxkBg4Lnhx+58zY7GOTDWiibndKIJIJt5cmcOCMcy0NDIy0vwiGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124945; c=relaxed/simple;
	bh=vv1tV+5paBm/2+xb6GkFG2akUTzG8KjsR1D7+7M105U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYcH42/1BvXOaBbQ49qD5O3md8wPh9pP+nv6E4rYXyE0a6E5WaQbGc+V9c8V6LTw6rCjh/jJR3jXNLkKzpHHoz85X58UoJegA+NZNzcndbxIskozYNu/jz5MkCbXwHHTYyag1VBWM8D8bx+QIWWd2XT64TgB7owqcH6W2UW/vIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=koordinates.com; spf=pass smtp.mailfrom=koordinates.com; dkim=pass (2048-bit key) header.d=koordinates.com header.i=@koordinates.com header.b=zGn3evjz; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=koordinates.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=koordinates.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koordinates.com header.i=@koordinates.com header.b="zGn3evjz"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a34c5ca2537so563794466b.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 01:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google; t=1707124942; x=1707729742; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/fuhEwt7bXsN5qrK49+qGtF59LW5vMM0qjspLOQ5o8o=;
        b=zGn3evjzgYVRPTSLuLp33V77Ve0WD0hfMCl1PQfKNYnTHDq2umxHN8/Wf/9dN6YE5f
         ZUyrnzKaLItXcgyLaSjovq8D3LcyWdmTeNly9jvBamkmtPW2jugfhy7yIfRUFMRR1t7Z
         +IpUZ5rf/JQPDZt2ydPtinwP/oQkml4mmirrdXXzA8I9rfRkSN6Y9zz05UNSCDLkUFZF
         3U3oZW104VXIQE0sSZi1IZ2fEcgcsrEHK39ouIKdRgLRlD2IZ/jt79gMYA4BJoS3SSIi
         0Vdc8nTiZkerarKRdfGmEB89on6CYYMCv/50L9fRezg1SPHtvxWtn5efdfnwYn85ult5
         C1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707124942; x=1707729742;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fuhEwt7bXsN5qrK49+qGtF59LW5vMM0qjspLOQ5o8o=;
        b=hbJNjyA8BJEbQUFKTm+NP/pOAVvL6azQzaoe5CLhX3LyFlGhYAsLVscDxv0N7UbR/0
         i52cc0kzlNgkBRfinpKS3EivrkVJk3xdFlw+B1uiRhBDZa1aT+LcB3gG7iJwTN91UeHu
         x2JBkd+k5nCjMtlv11t3wi3fQmhnoTfoGIVrlZtdcGIeP/vzRpMzbJJjHzqb92f6Nnhq
         iZ1vDmJNcEoHhShuS+k8UG0HTdV0lwY8mDA0CeEJLc8qcxTEUmnQBUTnfhd2GpwJ6ETr
         HLMal91wpPsNOnEoHsfzilmCSL0uugBC7V04Pg3iCxUM5tNRYvVFQxk7BMg2B9aQsSmX
         FVhw==
X-Gm-Message-State: AOJu0YyqH5wKK1PQcl+gXtaHAs5lz6acCIqeddbOaCanft0RPG5E770m
	y23Z+k5nvrgZaYQ0LEAeD/EQqNMHyH86u/rP0fgOiD0ZIz99p5go6Ukc2GIiZS/fzOTE842Ab1D
	1wjabE9mVwwZXHTWgC+7U6A33eKqpVhGx0Zm3drjAE+ZApGy4UqyCSA==
X-Google-Smtp-Source: AGHT+IGaEuOiucA/kADGAi0aPuk7LFsqXV54B4YsZrpl/djEGluQz9fqJWgfmkadgpLEMaYIHXpkhKnszVWH/7vS+1w=
X-Received: by 2002:a17:906:2ac7:b0:a26:c376:d1dc with SMTP id
 m7-20020a1709062ac700b00a26c376d1dcmr6142322eje.70.1707124941917; Mon, 05 Feb
 2024 01:22:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204185427.39664-1-ypsah@devyard.org> <20240204185427.39664-3-ypsah@devyard.org>
 <017a01da57be$28748aa0$795d9fe0$@nexbridge.com> <CYWTFH7Z8IY4.313MNLG552V8M@devyard.org>
In-Reply-To: <CYWTFH7Z8IY4.313MNLG552V8M@devyard.org>
From: Robert Coup <robert.coup@koordinates.com>
Date: Mon, 5 Feb 2024 09:22:05 +0000
Message-ID: <CAFLLRpJn6PJndfHCR8H6uSdCSVfzHPBBQ5o5=Z1Lj_2a3XtkyA@mail.gmail.com>
Subject: Re: [PATCH 2/2] http: prevent redirect from dropping credentials
 during reauth
To: Quentin Bouget <ypsah@devyard.org>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Quentin,

>  I have suggested to switch to implementing the same behaviour as libcurl when it comes to reusing credentials: if the hostname of the redirect is the same as the original URL, reuse the credentials, otherwise drop them.

The protocol & port number also need to match, so it doesn't end up
the same as CVE-2022-27774 [1]

Rob :)

[1] https://curl.se/docs/CVE-2022-27774.html
