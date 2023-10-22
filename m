Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD812B68
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 21:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0615EDD
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 14:32:57 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-66d87554434so20812586d6.2
        for <git@vger.kernel.org>; Sun, 22 Oct 2023 14:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698010376; x=1698615176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kA1UTnF4k7jSi9O8YA76TototnZ+cvIcf7B4s2+sRlU=;
        b=WajnRjMXCUC9UagXTqNtoBgw4Cka4GzH16uxrOXMqW+SL+wrjozMI97D7ELVKKWw+o
         zf4SdvepU7iPpw1ZKGv8SHEJIMQilSIvpqMmba8yt5LKzqKYcgmFegZlko50PKLvr8zT
         o1fPMQ2XaCUxF4ZBVG4BT9PwK5kCW6P5kdU9avKh+nto4ZsSqz8FgLaf/UrHWpJUAjRb
         2yZmVMHsEvamKT4MR2KviQrLIy5ZZis27TneZkYi7t46NBhtnNAxO+HbFJXZ5WwNEbJN
         783SaVYFSqFMKRIe/m/yL/uKybwx7blOgfn6TqxXxFF0znPWCUp5qaiwjeF5dtz662jk
         RaPQ==
X-Gm-Message-State: AOJu0YxxFQa1jTbLefZhgYFxwH7pxB4q44cns4u0ub2kW6gQZwkC81+a
	VHEYNfVqzInF/pX7P8MPAa61sMmicxzkj22IRgg=
X-Google-Smtp-Source: AGHT+IGcd4fHoerMXcC1Oh9h8DuRwhnpFHm8SGHfaAVb5WO0WRseeg1264Qz53khrKbgXvLs4KXlt+tT7rqJ4/fAgTc=
X-Received: by 2002:ad4:5de2:0:b0:66d:3723:294b with SMTP id
 jn2-20020ad45de2000000b0066d3723294bmr8392304qvb.64.1698010376133; Sun, 22
 Oct 2023 14:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1602.git.1698004968582.gitgitgadget@gmail.com>
In-Reply-To: <pull.1602.git.1698004968582.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 22 Oct 2023 17:32:45 -0400
Message-ID: <CAPig+cS4J-L44a-fjQ=2bXxRj6e1qdQK8705K3NPqmTsWXBQsw@mail.gmail.com>
Subject: Re: [PATCH] doc/git-bisect: clarify `git bisect run` syntax
To: cousteau via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Javier Mora <cousteaulecommandant@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 4:03=E2=80=AFPM cousteau via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The description of the `git bisect run` command syntax at the beginning
> of the manpage is `git bisect run <cmd>...`, which isn't quite clear
> about what `<cmd>` is or what the `...` mean; one could think that it is
> the whole (quoted) command line with all arguments in a single string,
> or that it supports multiple commands, or that it doesn't accept
> commands with arguments at all.
>
> Change to `git bisect run <cmd> [<arg>...]` to clarify the syntax.

Okay, makes sense.

> Signed-off-by: Javier Mora <cousteaulecommandant@gmail.com>
> ---
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> @@ -26,7 +26,7 @@ on the subcommand:
> - git bisect run <cmd>...
> + git bisect run <cmd> [<arg>...]

The output of `git bisect -h` suffers the same problem. Perhaps this
patch can fix that, as well?
