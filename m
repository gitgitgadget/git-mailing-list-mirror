Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4A212C484
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737733747; cv=none; b=euzSYFvfHKx75ZsHvbKIGdM1K98VE7wEG12YRwrsUIIjRcpkwCN+MGsIZN+SRO2wLrw6JD+uOIoSjtfM4txyGVLfu6uUQDOwbLLCY4Q5aCjDc2xrqLAfD2PfgleCeQK6tnDfShCKB9uO/PXQpChUVpr+QC7c6fNRUYUJ5hScUK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737733747; c=relaxed/simple;
	bh=jxfc3ym2xuYAnv1AkEc9p/FFEeciEdg5SckotDkGG34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpGH6uSUjOmK8N9KbfoQLHXzUUhfppavjHUINhnfHfDL1YpYOXuZ+xMUMA903g3gMQGX69YCYO5FDA5iK9H0Nh8GQc4CtYAOYwYPZsi1dEjGmkKwCLI9sYsrZHaHZqPkh6yij/orezM1cidsZa2DynqGdKk6Ee5G4CrDgmfJ9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6dada7c89d9so1146976d6.3
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 07:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737733744; x=1738338544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSRGxhl9uwA1ZsQTIOUbJ1KS2bNepcMJOIqoYaXIaYQ=;
        b=jQaixeSZngddSRMIlyQNJqfS8t9TFaIRndE380ufY6mvqvl1Xs/3ACKpYSLYQoOa5I
         ddE0hkAeao8IHNYpGBsqHdOxKUX0DhM4wnJkQQcHTKZKILubP6Q/Hwbn1JM+bI6OKYXZ
         +MkKzz5cpOavrymTXyXmB4yAOiFbmWe8w6ehiQOq/yhNNDtT/1IYlgS8vhEwbAZmK0rn
         wW514FVz6mQMsmYlhfM+GVum5J7R0OwuRRrgUUAoGBDcm29FuAEq0GTS8IsZgnU57oAn
         HMVHoV9YsASwmGQiZQe6OtaoXfLWtst2v0rVH+70C4/vfreXz4xSzbBXgkscKDLWujkf
         N9Tw==
X-Gm-Message-State: AOJu0YyC28dMtkOj5znwNT4XNz0IfUV0zu09v2FoxylhUg2YwPmkfY30
	HhqStNUG2y790Vg1QtXfcPSOKrQLtTe+lP5SyyMAKGK2arF7a1LB05TpEjOfcFhnDLkMF5T39kj
	w71SNNsysuNRunBg/pufx73v3xDgz29Jt
X-Gm-Gg: ASbGncv6WfkHARdlio4aKxvuOvHhGmJvMn60NxANrF6D6cmEsBZw9qazFdMI/jrHUb5
	O0mgagD7U6QQ7qYmJPgli7TRraAGyJmbbvxdd1vFbb4M1zeUH13HhphwQm6H9pWrzcid34Jpjdk
	aAVOE1HvwpYmUxont3k9NMmdynloea
X-Google-Smtp-Source: AGHT+IEDCmGEdmhjTuBUIczoqGfJ6LAdft/lkD4QoY6amB7Ed8faZNLJDu2fQsKdWcpNo9LbuUZ5nJRTqXinwXmDFeg=
X-Received: by 2002:a05:6214:1301:b0:6d4:2db5:e585 with SMTP id
 6a1803df08f44-6e1ee631c4dmr74167886d6.1.1737733744008; Fri, 24 Jan 2025
 07:49:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1871.git.git.1736429142334.gitgitgadget@gmail.com>
In-Reply-To: <pull.1871.git.git.1736429142334.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 24 Jan 2025 10:48:52 -0500
X-Gm-Features: AWEUYZmC6FzHPPP3CehUV5K7UxqWIoxNQ9FL-rlCoUnuIl-9z7Hr4N6ocyVm7kM
Message-ID: <CAPig+cTj5Rwp8=KA-r6SkZaf=VpqSieD-p2FgGFoMW2zmnr0Uw@mail.gmail.com>
Subject: Re: [PATCH] config.txt: add trailer.* variables
To: Julian Prein via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julian Prein <julian@druckdev.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 8:25=E2=80=AFAM Julian Prein via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The trailer.* configuration variables are currently only described in
> git-interpret-trailers(1) but affect git-commit and git-tag as well.
> Move that section into its own config/trailer.txt file and also include
> it in git-config(1).

Makes sense. git-commit.txt and git-tag.txt do indeed reference these
variables, and one would expect them to be mentioned by
Documentation/config.txt, as well.

> Signed-off-by: Julian Prein <julian@druckdev.xyz>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -540,6 +540,8 @@ include::config/tar.txt[]
>  include::config/trace2.txt[]
>
> +include::config/trailer.txt[]
> +
>  include::config/transfer.txt[]

Nice to see that you maintained alphabetical ordering here[*].

[*]: 5f78d52dce (docs: sort configuration variable groupings
alphabetically, 2024-02-29)
