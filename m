Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D793D97D
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 00:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjzhbe/b"
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1873210A
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 16:00:37 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507962561adso3861742e87.0
        for <git@vger.kernel.org>; Fri, 10 Nov 2023 16:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699660835; x=1700265635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UMuOSOE4n4sWVPguV13eA4QnPcUomUOSr4w+AqE3cQ=;
        b=hjzhbe/byJQ9R+6YXXLUKhZ5/F2upd+Kv4lf8go+UJLhVX6hN1b1RGWzEHbnwOcr7j
         72wM98ShadTsrStlMQXJWMTXTspQW+UJCrBteM5PPWEn3AMuSPrrY753mQ10n5xABbeV
         gWu8qwHFwUM7YteidHzf1qxarjixOpI8oKqovXlpT6fZnAzaQBGkYa/Af1z/odjKthA5
         bZkPYplSRtTH9eOyeiX4j1WU4QCCI5Mnfa9op8SU/YQimMlFiuBEvGSE3IgpmKB0cDc+
         8g+suuozmPeT9chQV5WyUYvoG2SCIj94oKGgzKYBQvjoAx1dM52zkuLSbalKq1PXJeX1
         jmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699660835; x=1700265635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UMuOSOE4n4sWVPguV13eA4QnPcUomUOSr4w+AqE3cQ=;
        b=SzyR1ZCfqW449JjsffJ/A06Rj6DY1woy8FmaeWHSrTfRkUTRewDa88uShUIid9AxkX
         3PfQaZ6+l3tjcwD8P+3ibo26pKNfp0VhMpAYUeLz8/DgUYUq15kORjBL2WeSbiqSJraG
         wf+Y9HWHoL5Q6MBN1IB30sLjDKyDWbQPb/t4KMazVcpU6uguoZV3jx6JxNDdQcyTiM+/
         zK4hSImL3/RmTcVKUoEppasfin7wRzUVhVdUsmAoLjkBD/ue6QrUX3h4ryOWjvfGn/BJ
         zXJM7pi+oImA51JC9ToAcddq5C0v5vAP+FEqq3MLvd5YwnuU90qV+dqdMMaxdsi7yhzq
         CNfw==
X-Gm-Message-State: AOJu0YyOLXRJA+PpvAZo6z9xLLpfeeINvM4sy1CyLPpptEQfetmmlAG+
	h40vlXdMeSc4a2+v8A+LIm/1m3ET/cIOagwlgak=
X-Google-Smtp-Source: AGHT+IEwm0W0FxLcjplK30hG9Hns2JyzFebE3l7poJHfTke+oucoc1o1z1jkeluSd3trJnRO0/vdMPRqQ34SOt2BNO0=
X-Received: by 2002:a19:6702:0:b0:507:a1b3:2d47 with SMTP id
 b2-20020a196702000000b00507a1b32d47mr317114lfc.17.1699660834476; Fri, 10 Nov
 2023 16:00:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq34xg5ek3.fsf@gitster.g> <ZUzcmsfJe6jk4fTk@nand.local>
In-Reply-To: <ZUzcmsfJe6jk4fTk@nand.local>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 10 Nov 2023 16:00:21 -0800
Message-ID: <CABPp-BHWxbwyMU-8YXFUy+A3S7b5K-BsRAh95QaEQG-1ECdwJA@mail.gmail.com>
Subject: tb/merge-tree-write-pack [Was: Re: What's cooking in git.git (Nov
 2023, #04; Thu, 9)]
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 9, 2023 at 5:21=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Thu, Nov 09, 2023 at 02:40:28AM +0900, Junio C Hamano wrote:
> > * tb/merge-tree-write-pack (2023-10-23) 5 commits
> >  - builtin/merge-tree.c: implement support for `--write-pack`
> >  - bulk-checkin: introduce `index_tree_bulk_checkin_incore()`
> >  - bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
> >  - bulk-checkin: generify `stream_blob_to_pack()` for arbitrary types
> >  - bulk-checkin: extract abstract `bulk_checkin_source`
> >
> >  "git merge-tree" learned "--write-pack" to record its result
> >  without creating loose objects.
> >
> >  Comments?
> >  source: <cover.1698101088.git.me@ttaylorr.com>
>
[...]
> I am fairly confident that tb/merge-tree-write-pack is ready to go. I'll
> spin off a separate thread based on that branch and cc/git-replay as a
> non-RFC series that extends this approach to 'git replay', so we'll be
> ready to go there once Christian's series progresses.

Sorry for being so late to review.  I posted some comments on patch 5
in relation to repeated file merges within a single (non-recursive)
merge, and in relation to recursive merges.  Both are cases that'd be
really easy to miss if you're not familiar with the merge code, but I
think will cause the code to die with fatal errors.  I provided my
guesses at some potential fixes for both issues.
