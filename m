Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CFF6AB9
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 04:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=merly.org header.i=@merly.org header.b="LjGunutV"
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34A2AB
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 21:50:24 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7af52ee31so50104517b3.2
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 21:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=merly.org; s=google; t=1698727824; x=1699332624; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIGr4oMzAgAmn3nnUymqZp2PvGh+WwdR/W6CBUMjZXk=;
        b=LjGunutVhRFNN0IJ9U9huJh5Vfc5QTSKCCGlGWr6GGVINuf+uNAav0upz+ABbUDlrV
         go6XGfKGYt8tJtPCWhB6nFJ9f54RObN4alG/wtD/ZizM2lt9O6NBP+xaQIf68tYXPeVX
         fAlSamrPj5tDamJO/jNoPWH6duD3/WwN/TpZmavQvhwcurBA6a1rtvBp19iJWKxJhC3P
         r2Sl4Idj9fY4L/YsUNXJYpc7u2Xjt8Oh/iF3cMiOaqnnYh6lU2J2PWcLQKAYWoVVBzDj
         3SutA7LOjHNw1mHjAgpROg/rrcZv3q0X8f8GDmEQ7/1nheMoqbg3sZPQ1b2p3PQlzowR
         Cdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698727824; x=1699332624;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIGr4oMzAgAmn3nnUymqZp2PvGh+WwdR/W6CBUMjZXk=;
        b=poDViyR7VlnkbeeSTtlFYr5V7KqzyHPCHs3hJm2cPMIL832AsmxI45pCD+A1kVsJB6
         Q/ovTaRzaSaxNXuCa4dKKHPxnGa6QmM3nmUp2BQyh4rKPMI2tzId2vBaOEgqbDxP3VFo
         Pj3myrdUXkYc752e4zR9MhViTxj8ECPwV4uS1dIladW2KMH/5jEVb3oCtw87PWTa/7GT
         YxdwopTxkIZ7ItuJYEdD00a2Jhwv/5sGjVPiIJJQXZFAPSh6r6ACZ60zUvw4toC7Pq0l
         9ZEJ5lP4DY2k673ssLV4yPA4mIeqhsTZ4gmtURLIdl7jkUcFslFY3RCidi6OcT7xfhSn
         6BWg==
X-Gm-Message-State: AOJu0Yzwaqt2zvp2bb4DXeCGr/ss+9tJ9hgw24zJBMRWcEy90JQWf0zh
	bjpm8cWzdgXB1ERTTt28UT0XNC1Vn7shpAlOrVs=
X-Google-Smtp-Source: AGHT+IFJLoukXyhQqR2BscvCNbm1Drh4pz36t8tTdgjEEZmlLvBLgA+hyxIVFmBXM/TxlgB0A2J3Ww==
X-Received: by 2002:a81:e608:0:b0:5a7:baae:329f with SMTP id u8-20020a81e608000000b005a7baae329fmr9918966ywl.15.1698727823573;
        Mon, 30 Oct 2023 21:50:23 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:9d0:3987:6054:b0de:82c1])
        by smtp.gmail.com with ESMTPSA id s18-20020a819b12000000b005af9da2225bsm348059ywg.20.2023.10.30.21.50.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Oct 2023 21:50:23 -0700 (PDT)
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
Date: Mon, 30 Oct 2023 21:50:11 -0700
Cc: Elijah Newren <newren@gmail.com>,
 Tony Tung via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <10283034-816F-4184-A02B-100B2EADF31E@merly.org>
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

Actually, I withdraw my previous comment.  comment_line_char is all over =
sequencer.c, and there are tests that say, "rebase -i respects =
core.commentchar=E2=80=9D, which strongly implies that the *intent* is =
that rebase -i respects comment_line_char.

I would propose that we move forward with this, except perhaps removing =
more instances of comment_line_char.

Thanks.



