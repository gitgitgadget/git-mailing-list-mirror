Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5786E369D72
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615217; cv=pass; b=G4MymYHOeL9D/DG2iyw0TxjWWeemIUDTMt3YkSLyaIA38tJbeaRx4WhKsOLEH1Wx6JIHpNfQvrEt7M+tUyq+PxZNhYveQ1gvNYU+uci4gFM45paReK5ko+MewmxOv1/exUtUafFrrvdinXCHM9HcTxHL4WFeW4t4ReAHA4IMz08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615217; c=relaxed/simple;
	bh=DPhAAQKdF9CkjpmefzBnQF7j5RsWqa/TW4yj64/Q/t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFMMnB45p7xo32hT2rDiPzsWSsQkup1He8fh+7K+3B4iI/uuDyl9i+EmuCJ58lA0eAZ5Om6N3ceOjhENA9jK/Pdw73TzubVg30ECaB3L07gOzmSfK3G2//QMsU9AviqWJbRUvmeYw6jpEGiY8C+nnvYcpya1tXkIQL0Sk10wxgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJeLhol1; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJeLhol1"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6626cd98209so4741762d50.3
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 06:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781615215; cv=none;
        d=google.com; s=arc-20240605;
        b=eQs0vySgZP+r7bZw14RJdppwJY2u+4ofA+2jRJjwasMIWRA0ZAVwB8p2kzbnjMRp3D
         0uIS15pHlTAk+B1040XULQvcWyU17ec3xcxNNITLczcbLBEi3RZSa/1tqg+97QRXBBtJ
         XUHSpaC0+l/YIhiDdXAb6McegkMQnfXwnvwsPre7zdvpJORgIjwni+Tm7LRacTHxnkRG
         a5Aqu3EzIhD8jNYWEBxmhcZpM3wMxqBZEuIl0sKLnDfwEuCw6kZPq+UwaiHy9XDRaRH0
         dztMemeyswUJAshLW+9xljDqPkTjXyBx/tqxJpkNBAwAjEFyfnecwWH8Q85HZaQsSk5c
         /mcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U8WB25NuFyM0fHNwdnRhNL+CMBbg/5dWjXlH/j7wnFY=;
        fh=uf2io49Zi79AZy9yGvXUGxW9gffORSHAYmKov6Z9bSM=;
        b=BgvLpNJIMtUe8RyP1aq/uE8O96ppi3+5XLudLTAOv88PqIMVUB16PzJZOMECG/NXdO
         sEueUzM1sdFmYYUmsRrNjqWShEFOdv+S5aAhBHeNDBwjLZT0EK+DOKF/BodnmiX+HWPD
         NzE71Isq/78FAWH2O+TUcc6U8isLH6XoGS88ArnkuOggEHVg/NNPNXs/Y40BoYPv/x6m
         dIPEY+TDocBGXRoKuPrmpIBNvOlQlZj+eRM7r3U3ouOI0lyUSRW2I5qJd2qrlMIapfQ0
         KZeDOrgevhNiCfFy2b8761UyfQeUrWziVKkhWkTu64eZSjkyBMkoXpQwewW/SrOtw4cg
         bXzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781615215; x=1782220015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8WB25NuFyM0fHNwdnRhNL+CMBbg/5dWjXlH/j7wnFY=;
        b=TJeLhol1TRzpXvlQKMclXSm34uHtZmb3P9HFwvfVbUhkr+Y/VkDAYxGJRvrqzKgVa4
         CqZ3z8v6HB6rpxQLHZtu271QpzKJdt7O7kbNvjygCjskd1G4pnQSFpavdX6qACNkjzUG
         aJozDF/ozBt9yNYyQ0F9nsLhXGLH9u5b3lvWAspR4dwXL42pC4ENw8jTM4NttEesVaZ6
         IrVQ0Nnq/E1SzMQdxYkrcU2kZohMCFa9vmYljrhXXKb0iKGN3Y6ZUdOQXl3LadGABCI7
         57osu6wxuUxfHtPwemwQvuQGZNeBzurOfqZ2k57xo74LFXOiJZztne8GMpZVRGMr5500
         gXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781615215; x=1782220015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U8WB25NuFyM0fHNwdnRhNL+CMBbg/5dWjXlH/j7wnFY=;
        b=cau0GzDcpqSMnvxNGbq8EuQTQqVRidgyfb5Ro4b08Tv9GPB4MV4Xpo8X8IE9IuGdtH
         00nd1BtbpxEj6iqubAIRrLvxd7eNtWjt4WsaTvq0tT0ZF2hldgUK5yEO/K02zM4p1EF8
         jd2NUK+wiJZo3Gul6RoQH3pAXeNnXfvF4O/Om3LEbC5QHj7UyXZT/NcsXC+jKW6j7t/c
         PEansfmV3wPKWXelBgGSBJk9qWppJ+DWOfriivaPF0bgEL25yIMEsZ7hGffdLGdPLRlI
         j2iLJcAhJMe/sGQ+XuaPi1TNLwsNUuJ8c6fGYxjfQfGpoqQwAcTjElQxMjEEfSgIM1nl
         0PQg==
X-Forwarded-Encrypted: i=1; AFNElJ/0BSZ4NC3QTJATNjTy3H0GuJWo2j6+LR0ef1PA04N89RRx/xhivzwRBZ0cje1o5mm1ECc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz31rx9OfiMiomQr7nh7xwHMMFP23GZ1NGlVHGfpztg/hSbFCpZ
	17JU6xtutRY306+KNBRfnTFBp6QPnCjK6PZu7IJWh/LDffR7hKiD8nXuqPjj0Nuetsd+1c3pCOG
	2S1sZ/MXTk2AzYTC+vk4JJVNgadI1ugE=
X-Gm-Gg: AfdE7cnHlgMawDU7PQS8t3FaZeUwpjc63v0D8Pt30CW/IJ5556DiZeE6H5Xlv2Idpxv
	5X2vfLJPM5Lwyjx62I5GYDB5chX7wr+ZN4yRUWXXKCDtcxwc5aYYChoUjGzQnnVH/FLpcCZbYTg
	GV5RLUTlInqrCtVxLOO92G68AzRgov1GUCfWbvtfGgRhiwAa9TRrGnGnb/+bmSAFdMoTnFQLD+N
	PvKiy8U/Cbb8tfNAEnKd06Tk1fEdXoxnI83AP8z28oigHvyXALDPVqqHabkn3femxsU2PwbCBJ/
	WPfx5hj02ug4mCKgERUephbCFecYZzg/4Qkoda0OF1RMrItSJWLoBrO5wuoNOxO6CpfewiBxOFS
	+tGZX9f1mrxS22kvJ7IUeoFeK2sLpoiXn/I5kMJgx5DYD2c2OJuBB9yloUZ9pO+LVaBYmPPt4Iy
	i4NvM=
X-Received: by 2002:a05:690c:6886:b0:7dc:7ccb:33a1 with SMTP id
 00721157ae682-7fcfe96d4acmr31244807b3.23.1781615215169; Tue, 16 Jun 2026
 06:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com>
 <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
 <20260613-ps-pre-commit-indent-v5-2-8d308efea63d@gmail.com>
 <xmqqo6hdepgy.fsf@gitster.g> <CAN5EUNQ193QyOeTLdu9aXzDeBhFpg38YYBbOLhZLgcg3qfd=uA@mail.gmail.com>
 <xmqqzf0vbyj8.fsf@gitster.g>
In-Reply-To: <xmqqzf0vbyj8.fsf@gitster.g>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 16 Jun 2026 15:06:43 +0200
X-Gm-Features: AVVi8CeHMSWYfVPE1OcxRFsJxILawMPr-cj1q0drHpU6rT2gqk2aZn6I_GdRhNk
Message-ID: <CAN5EUNR-o_sLzeWuy7M9UMFHBKxSuytNd=4p2svtFuv40E8vZg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] graph: indent visual root in graph
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, ayu.chandekar@gmail.com, 
	chandrapratap3519@gmail.com, christian.couder@gmail.com, jltobler@gmail.com, 
	karthik.188@gmail.com, peff@peff.net, phillip.wood@dunelm.org.uk, 
	siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 15 jun 2026 a las 17:42, Junio C Hamano (<gitster@pobox.com>) escri=
bi=C3=B3:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> > It does not make it unpredictable but it makes it not output what I
> > wanted to test, what I wanted to test is having an active column at
> > the same time that visual roots in different cases were being rendered
> > on another column.
>
> Oh, use of commit-graph changes the traversal order, which would
> affect how the graph is drawn, and there is no way to ensure that we
> traverse in the same way with or without commit-graph?  That's
> inconvenient.  But even without commit-graph, do we guarantee the
> same traversal order forever?  I doubt it.  So I suspect that it is
> a brittle workaround to disable commit-graph in the longer term.

Hi!

About the traversal order, aren't all the graph tests dependent on the
traversal order?  If it changed they would all need to be updated
because the tests are hardcoded expects of the graph.
I guess it might be more brittle than other graph tests specially
because it also depends on removing files, I tried using "git config
core.commitGraph false" or "--date-order" but I still get different
results and removing the files fixed it. If someone knows a better way
of doing it I'm happy to change it.

>
> As long as the graph engine shows correct graph no matter what order
> the commits come out of the revision traversal engine, we won't hurt
> end-users, but we need our tests to be reproducible, so that is a
> bit unfortunate.
>
> Anyway, stepping back a bit,
>
> > However having GIT_TEST_COMMIT_GRAPH in the last
> > text for example changes from:
> >
> > * 41_octopus
> > | * 43_B
> > |  \
> > |   * 43_A
> > | * 42_B
> > | * 42_A
> > * 41_B
> > * 41_A
>
> Does the "vertically aligned * on 2nd and later columns do not mean
> any parent-child relationship" rule no longer apply in this version?
> IOW, does the above graph show that
>
>  - 41_A is a parent of 41_B, which is a parent of 41_octopus
>  - 42_A is a parent of 42_B, and
>  - 43_A is a parent of 43_B but is not related to 42_B

Yes, this means that all commits vertically adjacent are related,
those who are not related and can cause that ambiguity get indented
(43_A).

>
> ?  Who are the parents of 41_octopus?  It has no relationship with
> 42_B and 43_B, and unlike what its name suggests, it has only 41_b
> as its parent (probably with history simplification that makes only
> these commits shown)?

On this test we are using "--first-parent" which excludes all the
parents but the first one, but later we force its excluded parents to
be shown.
We exclude 42_* and 43_* branches and then force them to appear as
unrelated branches.

>
> > to:
> >
> > * 41_octopus
> > * 41_B
> >  \
> >   * 41_A
> > * 43_B
> >  \
> >   * 43_A
> > * 42_B
> > * 42_A
>
> And this graph shows the same inter-commit relationship.  So both
> are correctly showing what we want to express, but they show the
> same information differently, making test_cmp unhappy?

Yes they show the same information.  On the second graph every commit
is on the first column (or second if they get indented) but on the
first graph we have:

*
| * <- visual root on second column
^
`----- first column remains active

If you tested v3 with this case you would see that it assumes that
visual roots only happen to be rendered on the first column, therefore
failing to correctly indent those visual roots on the second column,
which this test proves that they can appear on other columns.

Back to the test:

  * 41_octopus
  | * 43_B
  |  \
  |   * 43_A
  | * 42_B
  | * 42_A
  * 41_B
  * 41_A

43_A is rendered on the second column (first column is active by the
41_* branch) and gets indented to the third one. With commit-graph it
would be on the first and get indented to the second, making it the
same as more general tests above in "t4218", it is an edge case but
shows that indentation works correctly independently where the visual
root is.

>
> Thanks.

Thanks,

Pablo
