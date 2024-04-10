Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5A039B
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 00:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712708847; cv=none; b=anz8wMscjpry7AM9Z6+s4M36DJ/8jNdfAFjlslhx2rTsWSy7BZUePA1EKCBCb2ICu+8EKqAaRTqai7Y3t6Nscm5I7qn/pd/g6KHJG8mZ8fr6WQoAL1XnllRCvF5YQACbuxIqUXC1ugkp6cDedcP2L63dUhjdjDSKlJTHudk0kaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712708847; c=relaxed/simple;
	bh=OSDknPZEbpDhi+Tpm24y8pkEPu8KRPc/dquomTlf6Js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtATFBmUUccAFZECjEDlL/Nisg97t0Vdz+/yCOsH3cyLbj8ErWZak4VJ1Ln9ayZtMKcOAYMuYM8A9aSGOeknMnP+rcc5C49h03Q6PWUKGzyHy3Ysrc7HtTmlbD4LaAis+ExhzrbPmRhwl29Ki2ejnMYzJ23pJfe56sWWsxLhpic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78d57bd577dso277527685a.2
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 17:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712708844; x=1713313644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkKkgnbmYkqR8JFhIrWw+6QwKQnZOaZj1NFnzFaxiio=;
        b=IaDGrQ/TM25/YqFbR/FJhJBo+hvTfmqmgKVypkggr0E3wSZiLo2Q6wU2flBvhkZTDo
         PHf4k7DXEqtVOcddK3SVOyWTV3cGMGTGenj5FT5aJUZsXIn3ZXw8KN4yqoGSgWxkMBC7
         9/DYGfFOD4WJFQWsMaJHXSlyEuH7PHfzFy2PV00b/vAZqW8lgmtIeac0fdJaGK5L6k/g
         RxeJIhvLJPwVsbfEjukDbH1ItMJS9Khjmmb3JHRcVmLM56T8QexpeN1uZgASBL/OU7YK
         Rs6IfhT/4vMscZLdCqspawBCYVwlbhzPetLXMVShvIkuRJzuHb+K6/QLAjNHiJBw+Iqc
         M9RQ==
X-Gm-Message-State: AOJu0YzU0sVhYkNNhkiPvvvZhmuKWx+o55aFOh/CXwO4MIrJ2TwCdI5Q
	LypfoclJ18gbMturtXZMKMSetb/bak8ry1EZsSYGL1JAJzbxRuOc/QtndqDmuYn9g+cc/Ov6yio
	K4Dg9/FN36ELGufw5HtDxtuQcEfE=
X-Google-Smtp-Source: AGHT+IFkRBGaZB7PdefQr2uas6qoOLXRo799UTSPyaJKpxOw0mT0Eq8akBs+lkE/t7d7DyIiqbw/j1cKrBbWFVLfAqY=
X-Received: by 2002:a05:6214:5090:b0:69b:1d31:f670 with SMTP id
 kk16-20020a056214509000b0069b1d31f670mr1367923qvb.13.1712708844492; Tue, 09
 Apr 2024 17:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
 <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com> <6f71b1731f2aed9c2f4dc101bf4349344b575d73.1712699815.git.gitgitgadget@gmail.com>
In-Reply-To: <6f71b1731f2aed9c2f4dc101bf4349344b575d73.1712699815.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 9 Apr 2024 20:27:13 -0400
Message-ID: <CAPig+cSw5wsYpm4Szk6HzgT3u+wMVz77NfqR1rLJrmCzejxvmg@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] SubmittingPatches: discuss reviewers first
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jonathan Tan <jonathantanmy@google.com>, 
	Emily Shaffer <nasamuffin@google.com>, Patrick Steinhardt <ps@pks.im>, Matthieu Moy <git@matthieu-moy.fr>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 5:57=E2=80=AFPM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> No matter how well someone configures their email tooling, understanding
> who to send the patches to is something that must always be considered.
> So discuss it first instead of at the end.
>
> In the following commit we will clean up the (now redundant) discussion
> about sending security patches to the Git Security mailing list.
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPa=
tches
> @@ -397,6 +397,36 @@ letter.
> +After the list reached a consensus that it is a good idea to apply the
> +patch, re-send it with "To:" set to the maintainer{current-maintainer}
> +and "cc:" the list{git-ml} for inclusion.  This is especially relevant
> +when the maintainer did not heavily participate in the discussion and
> +instead left the review to trusted others.

This isn't a new problem since you're merely relocating this text
(thus, very likely may be outside the scope of this series), but is
this recommendation still accurate? Although I'm unable to locate it
in the mailing list, I have some vague recollection of Junio
relatively recently wondering why a patch series had been resent with
no changes and why he had been made the direct To: recipient. It
turned out that the author was following the above instructions.

Generally speaking, Junio is quite good at picking up a patch series
without the author having to follow these instructions to resend a
patch series with no changes other than the To: header, so such
instructions place unnecessary burden upon both submitters as well as
reviewers (who have to spend extra cycles wondering why a series was
rerolled and whether any changes were made).

It would probably be more helpful (and less wasteful of reviewer time)
to instruct the patch submitter to monitor "What's Cooking" and
Junio's "seen" branch, and to ping the list (after a week or two) if
the patch series hasn't been picked up or seen any response.

> +Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
> +`Tested-by:` lines as necessary to credit people who helped your
> +patch, and "cc:" them when sending such a final version for inclusion.

Again, not a new problem introduced by this patch, but it seems like
all of these are actively wrong. In every case, these trailers are
_given_ by reviewers _after_ a series has been submitted (thus, too
late for the author to add them), and Junio typically is the one who
latches the Reviewed-by:, Acked-by:, etc. by adding the trailer to the
patches already in his tree.

Instead of the above, much more useful trailers that a patch author
can add are Helped-by: and Reported-by:.
