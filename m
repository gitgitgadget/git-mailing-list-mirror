Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2723A12E75
	for <git@vger.kernel.org>; Thu, 23 May 2024 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486064; cv=none; b=ryppUWNoqgxOLYf0mcbf407IylR/p651xn89JM0x6ceMR5YftENM3AKwqNtdirmChOWBSZzY2XKNuelpkazL9BZI8cFSfJ6fp3G0v3STfgRzgEmtWvfbwJ2Ee6F8rxFoyekR3BAO0Xpe4kcldzjkMYAyfEJ+TINpeAXN+tGykj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486064; c=relaxed/simple;
	bh=Jbn0UDPcsvbsMu/fyIqJO0EXRy3G/s3PEO7b/M41OqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+Fx4rgithHq4xtErPU2r4DOTTU9ZI7a42XDZpHHETJSxmI6ErS8yfkk51Y0KXeBn6R3XltIF6uuIycO+r6NL/8nOblqvHtwzGeim6Epyo0ZoPnKOAQX4QWAvQ5UnK4fwUVLCfuxBE2likNoOFx8BiH/xHZdyFioOxt2SgBS2yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6ab9d9c34faso86156d6.3
        for <git@vger.kernel.org>; Thu, 23 May 2024 10:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486061; x=1717090861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrX+QoMCPKOhnMzeLreH1qIIPHGxaOfq29mzbFF05uA=;
        b=u4v1FD6mB8MiGTi5DqvPQGwrzP/K6iRVtQA6B8xgGE8fXACbuxgg9rxGLaKYSEIA1U
         +4hYL6A8ueap2nXTUHE18/GVTBZxfORfRQyamT0oRIwGkz6+o8Ilc/qsjxTOhuT6DabH
         S3koaacMRH9zwl/a35cN74geb0X8OtPwL8a4JO5DY5zW3V9U6STxTQ09hMp4VAeJXlYh
         Sx5YakkIQQMWaMVbHaLinlvqR8Q8VUcpmYExrO8KE4diNN46LAYKV9uha//2itUc/ICN
         szLTAoS5dKtFJrY/W4miDhW+aouFmVvPPS+UapDefzgyIAEUfffPlsSViY91OPtjk1lE
         m7xw==
X-Gm-Message-State: AOJu0YyRcBn8uFr4C3pDpC/DiiTfLw9Us5VuqYURUH+u83lsmIyTSk9j
	pCNlYQNMQDomqZLpIraTjX7lvrW+k98IUFfaoMEh19chJ+kigCerZtxK/Jmjise5NHzywG5e66A
	s4PT5MY8QU6JGKUl8MiZPRv7w1wU=
X-Google-Smtp-Source: AGHT+IEax9OmNQ9lm0jvmA2NHV2rwKjvVm3BR6/4U07gYwBPD1HAPNrA5dxDhYFXI0wq/89JyeeDUQEEgTuLXgUZJsA=
X-Received: by 2002:ad4:4588:0:b0:6ab:8ec8:12e2 with SMTP id
 6a1803df08f44-6ab8ec81476mr28225006d6.50.1716486061022; Thu, 23 May 2024
 10:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716451672.git.ps@pks.im> <2ebcc0db657905ed2a164b302da4d02da58ca2c7.1716451672.git.ps@pks.im>
In-Reply-To: <2ebcc0db657905ed2a164b302da4d02da58ca2c7.1716451672.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 23 May 2024 13:40:50 -0400
Message-ID: <CAPig+cScGc2p2=FiqscY3eHfW9LHRiyk8DtycQ8H_=Ko=oVoXA@mail.gmail.com>
Subject: Re: [PATCH 9/9] builtin/refs: new command to migrate ref storage formats
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 4:26=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> Introduce a new command that allows the user to migrate a repository
> between ref storage formats. This new command is implemented as part of
> a new git-refs(1) executable. This is due to two reasons:
>
>   - There is no good place to put the migration logic in existing
>     commands. git-maintenance(1) felt unwieldy, and git-pack-refs(1) is
>     not the correct place to put it, either.
>
>   - I had it in my mind to create a new low-level command for accessing
>     refs for quite a while already. git-refs(1) is that command and can
>     over time grow more functionality relating to refs. This should help
>     discoverability by consolidating low-level access to refs into a
>     single executable.
>
> As mentioned in the preceding commit that introduces the ref storage
> format migration logic, the new `git refs migrate` command still has a
> bunch of restrictions. These restrictions are documented accordingly.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/Documentation/git-refs.txt b/Documentation/git-refs.txt
> @@ -0,0 +1,59 @@
> +--dry-run::
> +       Perform the migration, but do not modify the repository. The migr=
ated
> +       refs will be written into a separate directory that can be inspec=
ted
> +       separately. This can be used to double check that the migration w=
orks
> +       as expected before doing performing the actual migration.

s/doing performing/performing/

The mysterious "into a separate directory" is never made concrete. Can
this provide more information so the reader can know where this
directory is and how to double-check that it worked "as expected"?
