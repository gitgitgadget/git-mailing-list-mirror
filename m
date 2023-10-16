Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2922E651
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuZ+LQcR"
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76F7A2
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 12:01:49 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1ea48ef2cbfso793179fac.2
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 12:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697482909; x=1698087709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYYvkQNDuCZJLX4qIgcI6crHA+8VDK9xO77amVm/ysw=;
        b=ZuZ+LQcRnlKKAFIvsPH3MjorYb762CcVSeE1Q9DaBgTSA6mGQ4pSEqKskzE5eRg3XL
         lAKCrD//FxNLyMk/F1rsXwo3lFzt5tcPFDW7CquDqzbG6ya83E9RhRAdoCvP6JNH4+/e
         Qowjs+di8jsMmfa+DFnKeC3Bf6OFoVqtEJk4mg3SFvxBWq4BC+Nun9xiw5XkPuIYiiHw
         GEb2mMUDYhnFuR6KTxgpN/iu1ZYXotNymImzqEWXF7rKWEOPR+8f4V9kIx0tOgswgsjO
         2NvGxBXo54Gwot+X4hsSJU8z9fKmcRTWk8+jSIOQUZuZycBGbQcCWWz2SUysikpbiVJ2
         gYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697482909; x=1698087709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYYvkQNDuCZJLX4qIgcI6crHA+8VDK9xO77amVm/ysw=;
        b=G5YkIIxWwQprKBs77vRV2CAKT5KqoC/fPs4Adp6TwZn33GKu+Je2NY91jDUEcEr8Ow
         9bT+Sk0LRFhd04qsUZ19wKLa15MdGW+4pkgpua6O3a14iuubehu2Vke4bVHzoebmWols
         GLNZsIp0onnSrbd6TMAUu1XVRYw4KPXnJo1t0AhhVTUvbBzgYA7utK6w6vAONwU9RS7S
         K0PjkxbMUNYOJaynWD+fIH40Javoqyzy4CdsdB5xOdMT28p54mhNwgRK39dnr0nhL9sO
         aS3/vpJeBXE5aLwKzcoYs0dcr0UhB/hEPChmbjT8pj4MaGPJgVYwC/rDhWJJL9UQVSjK
         bonA==
X-Gm-Message-State: AOJu0Yx+Oqi9hSNf1HCAC/dfki4gZDetEe7Ab+84e9qUiyGqUWpllRz0
	z9YA0kMt013Y4FBp7jvjm28OKL6UI5lNW8stvHlWx1DWTZQ1mA==
X-Google-Smtp-Source: AGHT+IFU33h2Gyhgycy+0mNNZ2lCthgKBqzBe4FNmloC/IXRckWKNb/hj1Hk6SYi35HGeYZCbrGFNpEeblqpnzsnpjc=
X-Received: by 2002:a05:6870:e392:b0:1e9:fb1e:870f with SMTP id
 x18-20020a056870e39200b001e9fb1e870fmr9363320oad.37.1697482908995; Mon, 16
 Oct 2023 12:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009105528.17777-1-karthik.188@gmail.com> <20231016103830.56486-1-karthik.188@gmail.com>
 <xmqqbkcyo7ro.fsf@gitster.g>
In-Reply-To: <xmqqbkcyo7ro.fsf@gitster.g>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 16 Oct 2023 21:01:23 +0200
Message-ID: <CAOLa=ZT4EuoB8GHMe+a2nfq8Pfg5x7xzrEa_qV39U1HqUyS+Eg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] rev-list: add support for commits in `--missing`
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 6:24=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Good changes relative to the previous round.
>
> A bad news is that with this series (especially [PATCH 3/3]) applied
> on top of Patrick's "always make sure the commit we found from the
> commit-graph at least exists" change, t5310 and t5320 seem to
> consistently fail for me.  They pass with the first two steps
> applied without [3/3] but that is to be expected as they are both
> no-ops.
>
> The change in 3/3 to list-objects.c::do_traverse() seems to be the
> culprit.  Reverting that single hunk makes t5310 and t5320 pass
> again.

It seems that the new chunk introduced now causes collision because of
the bit field of the MISSING flag being the same as the pre-existing
NEEDS_BITMAP flag. Earlier this wasn't a concern, but now, their paths
have converged at this change.

So changing the bit field for the MISSING flag from `22` to an unused `28`
fixes the issue. I should have run the whole test suite again. Apologies.

>  What I find alarming is that two tests that are touched by
> this series, t5318 and t6022, do not seem to fail with the hunk
> reverted, which means the hunk has no meaningful test coverage for
> the purpose of this series.
>

Well, actually the newly introduced tests t6022 require this block,
but this is specific
to when commit graph is enabled. So what you did see was correct, but
the test would
also fail with `GIT_TEST_COMMIT_GRAPH=3D1` if the block was removed. That's
exactly why in this series I increased the number of commits in the
test block from 2->3.

> >     +-        if (commit->object.flags & ADDED)
> >     ++        if (commit->object.flags & ADDED || commit->object.flags =
& MISSING)
>
> This and others are syntactically correct C, but some folks may find
> it more readable to see each of the bitwise operations enclosed in a
> pair of parentheses when combined by logical operations, i.e.,
>
>         if ((commit->object.flags & ADDED) || (commit->object.flags & MIS=
SING))
>
> In this particular case, we can even say
>
>                 if (commit->object.flags & (ADDED | MISSING))
>
> meaning, "if we have either the ADDED or the MISSING bit set", which
> may make it even clearer.

I agree with this, I'll add it in the next block.

Thanks for the quick review, I'll wait a day/two and send v3 with the
changes to fix tests
and cleaner code.
