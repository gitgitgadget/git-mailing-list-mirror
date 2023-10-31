Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82596FA0
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 04:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=merly.org header.i=@merly.org header.b="GLkv+c8Q"
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C7EE8
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 21:42:58 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9c66e70ebdso4565680276.2
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 21:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=merly.org; s=google; t=1698727377; x=1699332177; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnkZAkCyCengqIugCxDABZfUpWJ7oScBazaMw+1b0FU=;
        b=GLkv+c8Qtl/5V/MMm9TjudsspDubNsV+MS2B8LRocGE4bbUvGMMR1i0wlgWqFJpVAZ
         Do7oxKKDDTT27Ocopbhl+frBlkOYyu4riBxMFnDZdAIJyAIDNQHKClXI4E8JuioKlWGF
         /71DVL9p5Bnzj3l+V6T0KmQ1dHxoXqgJlksabbwLZH3QEFbu0JEKVM050iAhsvL23p1V
         AOrruGh6JvHA/zMUaQBCcZb1jizb9PY4vQCLZu+tilge/nG3ZKYH6I4PuD2xxoglJGZM
         IBLjGV9hOvpAy2CUWbvfM928KM2TGzBDQDj+XLsGcJGh5c81SaCfEN19hhMuLQ4o2Ou3
         Te8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698727377; x=1699332177;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnkZAkCyCengqIugCxDABZfUpWJ7oScBazaMw+1b0FU=;
        b=sbhdOnTAi0hhRJXY43BfMqUvE1lBmh0f18w+PGfIDY08o3xHdjWbyPaljkSMWCmplK
         FTSQvJGRf7GhZj0Lj9JCm35P2WpXwZcgERfsEKDJ70sJbhljVwh9RM4oXjrdtAqXMd4t
         OF9sIoBSxrkcgHyXvN5snMsVfJ3D0c3XS4aMaNw+DS9DrETGcIgKi/hlR6MxKZwBOkvt
         Qj45PQgWT8wFD0czdE96AG49bHJjNXsC53CcDvRSVaeIl6N8fUmiJUDRt1EBxa9nSanI
         B8e2wQWpYfgUmNPwBOYryBh3isJZ7E+NxSPdM5IhjIqRj2hswGJ1jiyCglvPkmDZr+VL
         gOLw==
X-Gm-Message-State: AOJu0YzOEFbU0wz+3lThLEL1F2TdkeiwI5JlnBhWddJyP1wk7LuvKpIA
	ag7DNidfmw4X5mpdpO8pSuS1cRuPLzH4f1R6200=
X-Google-Smtp-Source: AGHT+IHwW96S5kt49EexVt22nB2m8wXnj+HJXeZ7s/4FPyPsZgamgLI/+0mP4N92toQiy4SyO0sCTQ==
X-Received: by 2002:a25:244f:0:b0:d9a:f948:aae1 with SMTP id k76-20020a25244f000000b00d9af948aae1mr10826609ybk.29.1698727377034;
        Mon, 30 Oct 2023 21:42:57 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:9d0:3987:6054:b0de:82c1])
        by smtp.gmail.com with ESMTPSA id b19-20020a25ae93000000b00da086d6921fsm374811ybj.50.2023.10.30.21.42.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Oct 2023 21:42:56 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] sequencer: remove use of comment character
From: Tony Tung <tonytung@merly.org>
In-Reply-To: <xmqqa5rzadlh.fsf@gitster.g>
Date: Mon, 30 Oct 2023 21:42:45 -0700
Cc: Elijah Newren <newren@gmail.com>,
 Tony Tung via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5C268049-561B-4E1A-AD6A-493BCD4F2351@merly.org>
References: <pull.1603.git.1698635292629.gitgitgadget@gmail.com>
 <xmqq7cn4g3nx.fsf@gitster.g>
 <CABPp-BE6_nuMeiqOAMGwP8SH=d1+i57-STgTNKU8-Gnkv2jW=Q@mail.gmail.com>
 <xmqqa5rzadlh.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)


> On Oct 30, 2023, at 4:35=E2=80=AFPM, Junio C Hamano =
<gitster@pobox.com> wrote:
>=20
> Elijah Newren <newren@gmail.com> writes:
>=20
>> I thought the point of the comment_line_char was so that commit
>> messages could have lines starting with '#'.  That rationale doesn't
>> apply to the TODO list generation or parsing, and I'm not sure if we
>> want to add the same complexity there.
>=20
> Thanks for a healthy dose of sanity.  I noticed existing use of
> comment_line_char everywhere in sequencer.c and assumed we would
> want to be consistent, but you are right to point out that they are
> all about the COMMIT_EDITMSG kind of thing, and not about what
> appears in "sequencer/todo=E2=80=9D.

I believe comment_line_char is being applied when the sequencer reads =
back the instructions, which is why I ran into this problem to begin =
with.

If the intent is not to apply it to the sequencer, then the bugfix is in =
the wrong place.

Thanks

