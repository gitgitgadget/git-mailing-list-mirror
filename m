Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D7247761
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-591341db3a1so768259eaf.3
        for <git@vger.kernel.org>; Fri, 15 Dec 2023 12:49:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702673354; x=1703278154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQkgMYPT8lswMBKkcOLJIGw5t87RDyiIstqIqIabxzk=;
        b=PL5YoURLlS669CW7++h44MhdXN+6godV2YYdHnz2qYJPauAv91Bjj4fKXlvQQMge2D
         I/F3/4MnRW1kFhK/pCvG6pmvxCipr8r3mvGyK2zPyW5Oa4yzOiu07R1KQypGhauaMBiS
         hnPLWUS746zSDh2GS78br9idCVlGvNLqTxuBK3eIPNa/kiG8n7AUu5JHQl1Bb6QpRzZh
         yofB5SS6qv3L6aWZ4tKYGHdOBIDDX8gQB56YuSKLZS5AjkNC7iTilE4kBRyb2kQgVm1T
         wDG2q8hGNxfC+oQDNFJA0Eln16VM7ZqmS0Oyw3DgPuuDcqlhuWqqycPVLv1xstIvnOoR
         EFwg==
X-Gm-Message-State: AOJu0YzGONxgRNIP1IYaoEZF7hVOpSglytimrKzPo4kdLvg5HRqhhUwn
	ZxrH1rAVWe4cN8Y0zJqLowXAtzZUwS3bT9JvwJg=
X-Google-Smtp-Source: AGHT+IEzVpuUDT6mTZ1HGPnrJXzrfqmt88Pgy1+5CMtQd3xuXsOLEDyZ873uClTKD0S+S1eAz/1pccpACTG2Jgv06RQ=
X-Received: by 2002:a05:6358:c8b:b0:170:17eb:b3b with SMTP id
 o11-20020a0563580c8b00b0017017eb0b3bmr14881649rwj.37.1702673353415; Fri, 15
 Dec 2023 12:49:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM=w4Pn46nTcWA1e=n4Rms76gCx7iqbRmOWf3=vRmKgtbhqQmA@mail.gmail.com>
In-Reply-To: <CAM=w4Pn46nTcWA1e=n4Rms76gCx7iqbRmOWf3=vRmKgtbhqQmA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 15 Dec 2023 15:49:02 -0500
Message-ID: <CAPig+cSkzJpufEG_XhFdSho89itLOuvCwMaTkXXAjryNnWteQQ@mail.gmail.com>
Subject: Re: Bug | Documentation | git add -all | Synopsis has minor mistake
To: Benjamin Lehmann <ben.lehmann@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 7:38=E2=80=AFAM Benjamin Lehmann <ben.lehmann@gmail=
.com> wrote:
> The mistake can be found in the synopsis here:
> https://git-scm.com/docs/git-add#Documentation/git-add.txt--A
>
> In the synopsys, the options -all currently reads:
>
> [--[no-]all | --[no-]ignore-removal |
>
> You can see that there is no mention of -A, which is the main way that
> people would use -all perhaps, so it really ought to be included
> correctly in the synopsis.

This seems to be a simple oversight when the --all option was added by
da98053aa6 (git-add --all: documentation, 2008-07-19).

> In addition, the closing square-bracket is missing.

I think this is inaccurate. If you look closely, you will find the
closing bracket after the -u option:

    [--[no-]all | --[no-]ignore-removal | [--update | -u]]

meaning that --all, --ignore-removal, and --update are mutually exclusive.

> Hope this was the right place to report this - seemed to be the only opti=
on.

This is the correct place. I posted a patch[1] addressing the issue.

[1]: https://lore.kernel.org/git/20231215204333.1253-1-ericsunshine@charter=
.net/
