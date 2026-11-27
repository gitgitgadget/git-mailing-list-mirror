Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795748072;
	b=feMXZ2dqY198LG8wBX87nl/SCesI7GldcPXEXBn1+IGoBV8mCiXtj5w4ilwQ8zvAFkFE
	 neAkxhrh2hE+LnJjla4qPyZjXUb93kiUUaC1cdmo76k+C8O/V37H7yTOZ1KIfUSHNWMQI
	 vlMH1t6ltsPs9Dw5mI80mMsLKPU04tne4ku5Mp8XX/tAN8tS1C1bF6sU5EvVq8nAUG3xa
	 QUoqzCI5l5VfO7gxMstUHGnOOXsbxgJq2VXZFZeWh0qGgdDVGIz+UdqphkPyIbopZu2ve
	 FcsrWNSdRHi3skpWPATwAu11sI7Gq2S8pRHj7o8LjU/yuyWu5TxIWTWe4Tn5+Lq6/Xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4owlNY2jeQQlcd99IPuP83WmCKOR7OIUV0v+6wdfRWM=;
	b=S8spFKXrgxAIncYLf3hRHOTXrYuHlHcvLARRaCb9K2RJqmOlY5PN8WRUF/ElvLng+wM4
	 GrhycnsYDbkLFoSISN849O/DlLWRPK6zKOgEPpFol3DWfJEV+IzYHMrghgGqbZhkts7cm
	 Qh2W9FevwV0EdliRO0CEJEinG/0riQEu390yxgW4VdgmoHjyAchlWmhyBytSI7zXlzLnU
	 FRF/YcPsCTQU2F5quNEQ4jh+jafBwEudMLkfwqvBjPz9+XISHFkUbxUaD7Yo0anBkG9H3
	 HEAc8NfU+io/SInjGGwSU2ujvaB19VKdvrqighZtNsAD/Ja/TOCYnLsofunatQ+zotg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LG5CFc5L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED65606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 02:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ED65606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LG5CFc5L
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5be3d5927ceso9560072e87.3
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 18:54:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795748070; cv=none;
        d=google.com; s=arc-20260327;
        b=OH6bQHcbClxURm3DrvSNADzZxtM9AWwT/9ARCfxfh+kTohJr3uZRLjCSJZULJA8MvR
         admlB+mAfz6IR7xUc/dmtQ1Rts2LmXvgBM1Udq5PqN2ORHdTao3+VI/NNrtJFkW4jknM
         PXkGpakJ0jV5dIKD9GHNCTJk5bY1+YHeZLbn/u6VCQLy1tqgWcVNDRe1OTPwi/zNJhwc
         prLtJVINMXeXn/0yTYplvzyNRa8zNA3vm/SjbVvLDR7tKS9upnhJI7M3SWe6p4FWYx7N
         J4Lhj7ef1h5Y5UAJp6rSH7LU9LiGOSa8sqQeIwj/L2h48s/ZrzQy30DDViq0AUjQ6uRi
         Vi3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4owlNY2jeQQlcd99IPuP83WmCKOR7OIUV0v+6wdfRWM=;
        fh=6EbkXYcINwJ2EdSFa4UDrVJU+oDX0YdDtokAu2NDog4=;
        b=hpMMjO2hTqrWgyBEr/XCa6X64vbOBuHUKpnAoiLgH5eBb8/hfVV0Pg+RX4qWqKibFl
         2HIwmeUubL0jIeRqvQReD6Ppuij2GfBTKkXRW59PZPOTYOXIXJJ+BrBiasCgL/cThoB4
         5j+jHQ1+nDO4vngxAi0o5b+ELSTMGzNr6DLOV9TESHb827RvYUs7xAMT8MLYcOZmdE9S
         Bx4vYYgZaEiwvb4ITQ+ikXNzdfKQosNZiAMNIjFPt8w2wjr/8BfLZ2dpwcVPuZNBfd9G
         0u7nn3/MiFjkCN36zNevyCHK7M2lWcOL4JOaecwuxeA42I7QTt+xbW778L79peTzRa+D
         0tJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795748070; x=1796352870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4owlNY2jeQQlcd99IPuP83WmCKOR7OIUV0v+6wdfRWM=;
        b=LG5CFc5Lg5YdHJCWTEiW9E8mOok2ETOAnAVvlaLt2QybtXHJHENWhwu4OZM3U5mUci
         Lhn5+QALqpEQXLex8OXccFe4Fh5Z4HtFHXJ4r0QadCdi4SDVtXkO0bgwhwzEYnqbOamu
         9qQqAGN68JzBEp/KEptRBLqNG/K/oKaWdVB5DFJgDVCDE3FzjtcxTVAHnNRGsCl/98BO
         HqNUfj7mJYwNmpjSLJx1xpOXZmIdKB5puuc1BBs6n6uc6BapMy/zbJfMgvVysV2WaHsY
         HdoQo+NCdhf5IxdqAA4RZewIqivlOSJzoUzCmr4KcM/gOTBsfsZYOyfTJDzV/320p/23
         J5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795748070; x=1796352870;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4owlNY2jeQQlcd99IPuP83WmCKOR7OIUV0v+6wdfRWM=;
        b=xdzye/K1b4AoNIy96duL/OuRePs+O5mA6tGxVC6TRtk7KfhMj/ERn4Jx4rVBuXCk1/
         MwMNON2cOpQFdOvDGPxfbUV3tKja3m+upvsG1Hg+xNEKKF553HIjvzyLhrBFXD0ygwxN
         xPCEfPpaqLNfZ3Ydrhlnuo/noQM2pS5zHh7xq5rbXa14KwllMw3OaY4uQt/eR0S82uwD
         ZBJhNdfJ5SY5cNw8RFncQINk+n79eHSx7ZLceIDZWOrCJU9NgcmdwnTaagRZjavyIVbx
         CuFadUm+a5DnChjfdYhx2aYFWKVDGmZwAb4r/oz+gt3ez2bLaGo3Pv6+ZemePuw9bK4T
         W0BQ==
X-Forwarded-Encrypted: i=1; AL+hErFlAMB89dYflrJoBThLzOKwDxZpFQbSoHN3QSWLSAA2pCnO3d6Nm9Wl+7embTdiITc2Ngw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YzBo9FysVN4zsRDtqYyB4e3yJL90Jsx3ZZsSxBPlq5w5PvH/X
	cDzl4j6m7JgSSUyYneXW9XkYBXuy+VIsvTPO2IVMn1GPr9zz/v1DkV0JcBuLrOjgL4COV8k+zU1
	Y7B6kNEKGvfWGk5penGieqTpAAh6P2zHNA09JXp8=
X-Gm-Gg: AZFdTZe2LY7CUs4Rj/XpVoR/R+79UP/4rlb/4gcmMvbzN84vwKPq31AHweU6WMj96r0
	whOn9ZbzWPrTlH2uTxZGK5HTCb56YsoQyeGZyWPPV5WOQnqo4kJkYddzGJTIdqppOf58FVi6xmh
	qDCtW3kGTf893R0QpG1iGj95pK5ZgAlUYHVOU+P7EhMOxhpQPfryMsXXFwQrR9IQ338wusfbgbo
	GhJenvLCrD3+b8LLuTGCjSiero8D3t23hXYKS6/GrFOCkomW9VwEmnc9jeESilvr4qO8vDaMuz7
	a+kUemafri+f7pdRLrm6pRzwVUX5GDBPPDrOOLhce6LPQ6T4DYxUMdE+w8plZxuu0hOyNp11DuD
	5/n5vI7aKcg6xQy72KRuR769WoXaVa8hQPFw7lQ==
X-Received: by 2002:a05:6512:31c3:b0:5bf:aee8:7b4f with SMTP id
 2adb3069b0e04-5c1bc80fefcmr6874095e87.27.1795748070213; Thu, 26 Nov 2026
 18:54:30 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2336.git.1795686173178.gitgitgadget@gmail.com> <xmqq7bhzl8i2.fsf@gitster.g>
In-Reply-To: <xmqq7bhzl8i2.fsf@gitster.g>
From: Nahid hasan Sagor <nahidhasan141400@gmail.com>
Date: Fri, 27 Nov 2026 08:54:18 +0600
X-Gm-Features: Aa3M54pqQBt5lGmFpJuGUEEBUMgejBvpUjlMhoJpwhyK8TQ6tplQnT309pMeMDI
Message-ID: <CABQNq+=YsQxGLwFQggx9bY9bWw9vOR5hFs2WaF7UfWoievt17A@mail.gmail.com>
Subject: Re: [PATCH] push: shell-quote names in suggested push commands
To: Junio C Hamano <gitster@pobox.com>
Cc: Nahid Hasan via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

Thanks for the thorough review. I have just sent v2 addressing all of
your points:

- Dropped the trailing clause from the commit.
- Quoted the entire "HEAD:<short_upstream>" refspec in die_push_simple().
- Removed the "die() does not return" notes from the comments.
- Quoted remote->name in setup_default_push_refspecs() for
message_detached_head_die[].
- Simplified the test_when_finished cleanup in t5523-push-upstream.sh
and removed the redundant single-branch test.

Thanks,
MD Nahid Hasan Sagor

On Fri, Nov 27, 2026 at 1:04=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Nahid Hasan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Format the remote, branch, and ref names in the suggested `git push`
> > commands in `builtin/push.c` with `sq_quote_buf_pretty()` so names
> > that need quoting are wrapped in single quotes while plain names stay
> > bare, and add tests for each hint.
>
> Drop ", and add tests for each hint" from the proposed log message, as
> tests are expected with a fix like this.  Reviewers will notice and
> nudge you to add the tests if you don't anyway ;-)
>
> Quoting suggested commands for copy-paste into a POSIX shell is a nice
> improvement, and sq_quote_buf_pretty() is the right helper for it so
> ordinary names stay uncluttered.
>
> > diff --git a/builtin/push.c b/builtin/push.c
> > index 2377b5af55..a28138fcba 100644
> > --- a/builtin/push.c
> > +++ b/builtin/push.c
> > ...
> > +     /*
> > +      * Quote for copy-paste into a POSIX shell. Ordinary names stay
> > +      * bare; metacharacters are wrapped in single quotes. die() does
> > +      * not return, so these buffers are intentionally not released.
> > +      */
> > +     sq_quote_buf_pretty(&quoted_remote, remote->name);
> > +     sq_quote_buf_pretty(&quoted_upstream, short_upstream);
>
> In die_push_simple(), the first suggested command formats the refspec as
> "HEAD:%s", and you are feeding short_upstream to the '%s'.
>
> When short_upstream contains metacharacters, sq_quote_buf_pretty() wraps
> it in single quotes, yielding e.g. [1], but it is just as ugly as [2].
> Wouldn't you rather want to see [3]?
>
>         [1]     HEAD:'upstream&name'
>         [2]     HEAD:upstream\&name
>         [3]     'HEAD:upstream&name'
>
> All of them would be parsed by POSIX shells as a single argument, so it
> is not wrong per se, but since you are not using the basic sq_quote()
> and instead chose to use the _pretty variant for prettiness, you may
> care.
>
> > @@ -211,14 +225,21 @@ static const char *get_upstream_ref(int flags, st=
ruct branch *branch, const char
> >                                          "upstream, see 'push.autoSetup=
Remote' "
> >                                          "in 'git help config'.\n");
> >               }
> > +             /*
> > +              * The prose keeps the raw branch name. Only the
> > +              * copy-pasteable command is shell-quoted. die() does
> > +              * not return, so these buffers are not released.
> > +              */
>
> Good reasoning.  Common to the previous hunk, I do not think "die() does
> not return, ..." should be here.  We are not writing a programming
> tutorial for Git developers here.
>
> Move the suggestion ("you can leave resources used to call die()
> unreleased, and that is not a leak.") somewhere in the Documentation/
> hierarchy, perhaps in MyFirstContribution?
>
> There is one more suggested "git push" command in builtin/push.c that
> this patch missed.  The message_detached_head_die[] template is used in
> setup_default_push_refspecs(), which reads like this:
>
>     static const char message_detached_head_die[] =3D
>             N_("You are not currently on a branch.\n"
>                ...
>                "    git push %s HEAD:<name-of-remote-branch>\n");
>             ...
>             branch =3D branch_get(NULL);
>             if (!branch)
>                     die(_(message_detached_head_die), remote->name);
>
> If a user is on a detached HEAD and pushes to a "weird&remote",
> remote->name needs quoting.  The user of course needs to be careful to
> replace <name-of-remote-branch> with an appropriate name themselves, but
> it is quite plausible that they will cut and paste up to the colon that
> appears after "HEAD" and then type the name themselves.
>
> > diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
> > index 22d3e1162c..484565d7cb 100755
> > --- a/t/t5523-push-upstream.sh
> > +++ b/t/t5523-push-upstream.sh
> > @@ -134,4 +134,12 @@ test_expect_success TTY 'quiet push -u' '
> >       test_must_be_empty output
> >  '
> >
> > +test_expect_success 'no-upstream advice quotes a branch name with meta=
characters' '
> > +     test_when_finished "git checkout main" &&
> > +     git checkout -b "branch&name" &&
>
> Two when_finished handlers running "checkout main" (above and below
> here) look somewhat strange.  You of course want the handler defined
> before running this checkout, and ...
>
> > +     test_when_finished "git checkout main && git branch -D \"branch&n=
ame\"" &&
> > +     test_must_fail git push upstream 2>stderr &&
> > +     test_grep "git push --set-upstream upstream ${SQ}branch&name${SQ}=
" stderr
> > +'
>
> ... you want to get rid of that funnily named branch before you complete
> this test, and in order to get rid of the funnily named branch, you have
> to be on a branch other than that, so it is understandable that it gets
> tempting to write "git checkout main &&" in front, but what happens if
> that checkout fails for some reason?  You'll leave the funnily named
> branch behind.
>
> > diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
> > index 5f8aa1ed19..8f4705cae6 100755
> > --- a/t/t5529-push-errors.sh
> > +++ b/t/t5529-push-errors.sh
> > @@ -67,6 +67,11 @@ test_expect_success 'suggest <remote> <branch> when =
the branch has slashes' '
> >       test_grep "hint: Did you mean to use: git push origin feature/x?"=
 stderr
> >  '
> >
> > +test_expect_success 'suggest quoted branch when the slipped name needs=
 shell quoting' '
> > +     test_must_fail git push "origin/branch&name" 2>stderr &&
> > +     test_grep "hint: Did you mean to use: git push origin ${SQ}branch=
&name${SQ}?" stderr
> > +'
> > +
>
> Isn't this fully covered later in the same file by the new 'slash-slip
> advice quotes remote and ref metacharacters' test, which checks both
> remote and ref quoting along with shell_split()?  Perhaps drop this one?
>
> > +test_expect_success 'slash-slip advice quotes remote and ref metachara=
cters' '
> > +     git remote add "weird&remote" remote.git &&
> > +     test_when_finished "git remote remove \"weird&remote\"" &&
> > + ...
> > +     test_must_fail git push "origin/feat;id" 2>stderr &&
> > +     test_grep -F "hint: Did you mean to use: git push origin ${SQ}fea=
t;id${SQ}?" stderr &&
