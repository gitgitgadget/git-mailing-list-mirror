Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwQjoZ7m"
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405B7DB
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 09:32:23 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 41be03b00d2f7-5c701bd98f3so2084452a12.1
        for <git@vger.kernel.org>; Wed, 13 Dec 2023 09:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702488742; x=1703093542; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6xd5KK/gSCJSGEupk+hY0AoFX/KeUc0U7qpgPqNh7ZM=;
        b=kwQjoZ7mvKMM7YBVueFJ55EQ2zs0mkoFMUfw/HjHIeI9Khz4ZYK5hbvnvMps+Eu+Lz
         psQGHthVlorl/MpgEoPLwSIL8g/MO8IWpvpzIUluf6hAwfoTh6EQReMSbkohhvDbTLNS
         OVzQlQgJN91C2tqzmIM3TfzAGKIqPt4XDNZ8Oqr+X88d09ojQ+V14xZ2TUDNnorbg6np
         OHbZu3p334/Qf06NX8StkPub1SAytTU8KkyPFeW/aF+LqUst5Rb9NL8b5jdnid7jsSuy
         uq8uAMPrASW/W6CXezlDtdnta0YcC7Tzv/yXljGWBDL8G/Uj4m8YIrorDz2it2mrvqfE
         LT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702488742; x=1703093542;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xd5KK/gSCJSGEupk+hY0AoFX/KeUc0U7qpgPqNh7ZM=;
        b=fWaKevofWuJnA/eNPHVYw+0sIMLE31pLqRuwP0fYsYpU+MTl3pVb7KGy9q4uwuhKIn
         orqxguX/T+kJNLU+BsUlu5/fIvUSzTfU6drMASyX3aiSy+SYDPmL4JxkWjKhi03Tzyud
         fwM2s0en9R1xG9OxNhlYXkSJ3HyqW2F/nm2yHTzCEl2AUIYZWGtTcYzQxOhdvv/lrcLh
         LKbQlHMqawOLhEkp0V4zOhJZmWdT/5jh7uZnqpKC4UQBugdJbBzbvX2+dsufJ6T0llKb
         1yZ9xwhVK6koqDDKzRHuc151VjUFt4gHaqu4r2QoXuWZoxkc449kt+uwnpbMZ/xTnLml
         83hw==
X-Gm-Message-State: AOJu0YyEAE9aQCRU2YzSgLLTXJphfnft6v7mp/3+w737KUiGJO+QrjhU
	RxM+wyH1V+pr0w+oU6dA028+CRp6a/9Z210K0DqmuZ/FdJzLWnCfwxk=
X-Google-Smtp-Source: AGHT+IEJ8JzaLB6yIA2afwmNIn5mb6Qy4b67HF6ztmyAkE6eDrI7IDSH+jKGDGbsxorjzkQUYaiVQmG0ja8APkKGqBw=
X-Received: by 2002:a05:6a20:8f14:b0:18c:15ec:3058 with SMTP id
 b20-20020a056a208f1400b0018c15ec3058mr5247172pzk.4.1702488742398; Wed, 13 Dec
 2023 09:32:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?ROaXoOaVsA==?= <wushuripple@gmail.com>
Date: Thu, 14 Dec 2023 01:32:11 +0800
Message-ID: <CAOQ=bxz8txyOt6p5L0qfx5DFKfxUhWvHW0pJP+YTbWVfBpvYxg@mail.gmail.com>
Subject: End-of-line comments are prompted with "is not a valid attribute name"
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> macos 13.5.2
> git version 2.37.0 (Apple Git-136)

I use end-of-line comments in my .gitattributes file, and it is often
(not always present, but often) prompted with '# is not a valid
attribute name: .gitattributes:1' when performing many operations.

This is my .gitattributes:
```
res/csv/*.txt eol=3Dlf # =E4=BF=9D=E8=AF=81csv=E4=B8=BAlf=EF=BC=8C=E4=BB=A5=
=E5=8C=B9=E9=85=8D=E8=A7=A3=E6=9E=90=E6=A0=BC=E5=BC=8F

# Custom for Visual Studio
*.cs     diff=3Dcsharp
```

When performing certain operations:
=C2=B7=C2=B7=C2=B7shell
> git status
# is not a valid attribute name: .gitattributes:1
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean
=C2=B7=C2=B7=C2=B7

Other repositories that have .gitattributes files and include
end-of-line comments do the same thing. I'm sure there are no special
characters in my files.
