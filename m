Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7B22D0620
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783094255; cv=pass; b=d/JF3JnQboIZFIYZVvuyfFdijUeu5fAGnnpLOzL1oMSaXrMXAANHpx7evnMSn3BaCV/m9qrR/3J/emETA/sjBtrYwqCBqnYLgXQZuSOfAMF+L1kqD7L5danGqvzfn+YkthDku/3qw88qjVOVFe/9qd6B7zWizJXocToTzD5yVeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783094255; c=relaxed/simple;
	bh=KofuXNIzdmJh2EWuyHYw/O1OtBio3GPyImezwCiIWXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGlfPx7niglYTWS0byyWS9cH6wtfHl1PoA6qEXSrg6NyU0/7U9e4P/R8RpKWvsuRf22UIFaVLr6uSBl7D84hDy2O41oah3Q1W+sAi1v9ktJxjEzla9AYMj1GdR6qqx/7hUZtjn6l/v6X+/m7Wsk+yA9YGg6Dpl9O4HZQJ3tpxIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmIzcfqP; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmIzcfqP"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c9e89fded0so5654745ad.2
        for <git@vger.kernel.org>; Fri, 03 Jul 2026 08:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783094253; cv=none;
        d=google.com; s=arc-20260327;
        b=Ykcz+yY6TrzqNLEp7ox3HpFR6SrVhFt1VU/slWscrIREDYCzLL6vxI7SnTz0AXt/ER
         /Va3z8usWf8iKnjHoPYDeVc3pRsAa6NJ2TAf/CbUSD5aUCQyV24m3f34QGact/u3ZwRP
         /Q+0VPFZJLEJ1Q2mIiaP21exQaZTZnmR1nbI65YPmV4X9R7ljA8EfWvoP5mgDxXKMIaA
         l5m2TiRZf0pkRf1ExfaGekHAX2Zdi1fpC2MGVAKza7hzJQ4t0ufkjIPhrCZc3LWWY7or
         MMvEZav1axpxeMi2fPQ/fQC3Q77nZlBYbF1ECEih3iLcsqqTX207Dn885RNwnIRyxuXV
         V4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YpPNvvCjaj/DDC7Vg4x5Hf78vXswZ9xtTYb+3W/nqxE=;
        fh=D5+iH+GwoK/srHnkel1ePtoR8yhDOJVA6vIwpOrSKA4=;
        b=ZIXgyqH6TMoCnVnOOwsczWiNy4l7YEiMfPvf+5w8fc0bGonqMoictLPBYpKwjARQDy
         Tl3ZcX+3LvW9UFGmOvsVdbIDmhWeJuHmYvp7UR0Lo52SZ4UImQ+DTuUt2PKYvo6W5zNJ
         +LxKtP6Bbb0NT62kLLuslOk9+az6eancUa1OeX6E0oE+2g0uEeBJZqQy16qaPai8pcpC
         U1JRpCiyxuNDBTMVwcjimrGf4pk/honmlWGJdsW7/Gi26pcFl80S7rZeLuF2MYyeTldt
         q/vagsxcf33jvk24pXXa8D55lWY2gFwq9w+YnHWIKPPQqT7xJ17gXtjX4beodXatarPr
         A6Jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783094253; x=1783699053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YpPNvvCjaj/DDC7Vg4x5Hf78vXswZ9xtTYb+3W/nqxE=;
        b=HmIzcfqP60mbSWs3RFU0XX87WrDd4c/gJiv8gjBebTkc/elGbw+/HpGqmxsA51u6dH
         HDUrF0BjbPgdu63RozPKt0DnyMipFR7CaVrEwljDASdq8wuNFzJtmcRGXjKFYagrEZfF
         AvMQsTU03fX34kHFhq+jUFaq6kP4DVIv9fyKpe6Rrox1wmrqLnfRiuwsytZSNV9P5ERc
         sZX4cGd3yVmlwrx2JyKbcDSzI+e+FbnE5BAKT9y8EWnBvxTlSdTbx9FOJhyCiLrOOLJM
         Y5C7mqlsMtHTa/ifuMKP+viETh8gjv0PS+16FxHN+1xaJVbUF5/NuaRJx0vkHJhCWF+6
         ICSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783094253; x=1783699053;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YpPNvvCjaj/DDC7Vg4x5Hf78vXswZ9xtTYb+3W/nqxE=;
        b=FrY73bm6ux+y220K0su1YvZxMeqEyyTOGV3eyLBq9zIlSiqy3cxmfoPLgwLZ0Wpkd+
         f6qumGlqZehszKcj5mnKeomlGUA6iC8In/5T6KIjvAgRaRbX6hfaMmNAbCZl2VKVq4VX
         +KZHWscwO0gyyQN5MmrQKfBEZi+Eg4SCFVyJVhrRBp/Xz/PvK6Z7tvq3cw/plv7P3ans
         KVRSI2MjdmZzJK3ynNDnr/79kwjY6ux9QYhaSAZ3N69IsInoRafUmcm2ZJwL3F/asN1j
         gZ00xLUnmIqSuKpbCLBjsss4ee/pQww5BbpX+Y2YXkvNDWAu3yHlpXNwvHAhFmQDZ+tZ
         qQMA==
X-Forwarded-Encrypted: i=1; AHgh+Rp8vK0WwE4tJgD2KPpg0ju9Q1UlondxE89tTqoFf0TJao0T9IOvZur5whZTkiQu2iSJC0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDccKVN5Vd5U25MNsUQmhgt76g+c0EdDqdnz8w2YgNUHsygmWO
	fQnPb+VPPY2R0o5pOZsXL8uDmdnS1UAF9e60zAho8yOlNUR973QXt6z3nh2rzwGXh9ZD/9OJb1W
	FqgALvvqR2Kv3+dZgkkljZT3mBznwXOQ=
X-Gm-Gg: AfdE7ckFzctj3N1WfifpXjg6bBp3qcQsrevaMAvVklvo8c4MIKLotynwfDF0fuiZzlq
	jcNB7smWxrEQeDYH08m8ccAZmM9ydwkSYkTFcoTLFBt1dzdd1PqktTDkEstNDzQHeWx5oDAUWlJ
	bAghq3Moc3g7taj+F0Ve0x+0V5S7Z5yJQ9GozRyzaan0QvH9qNEp+ngek0jS7uyko4tVqFaJXiH
	7S5gJyUcXNhCSqb2bwOhVfD7vIF6U2O43coRZya14ugSVlg6yloDce05WpL9MAaKQreghuujJbM
	u/w9uLq0HfM8hjT1GnSKXeG2v9CNeZXLpYZmuy1+vj4XD65C+lEMP6sSQmuTFgf9QwMquzaWDRG
	LGXpHB+8A1/huNalw0OMVKonPyA==
X-Received: by 2002:a17:903:1a90:b0:2ca:eea:eb5c with SMTP id
 d9443c01a7336-2ca9114efb0mr109116135ad.18.1783094252900; Fri, 03 Jul 2026
 08:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com>
 <20260609001134.GD358144@coredump.intra.peff.net> <CALnO6CD+3sE1xQUnRsCFfWrZTsq2Edw7BWseLzasgT3dgtaq_Q@mail.gmail.com>
 <20260611085526.GL2191159@coredump.intra.peff.net> <CALnO6CAx91kbJ84d6Ef655UNG0y0rhyknBRh6Y+0o7Xn-uVytQ@mail.gmail.com>
 <xmqqa4sog1e9.fsf@gitster.g> <20260621172432.GA2206349@coredump.intra.peff.net>
 <20260621174518.GB2206349@coredump.intra.peff.net>
In-Reply-To: <20260621174518.GB2206349@coredump.intra.peff.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 3 Jul 2026 11:57:21 -0400
X-Gm-Features: AVVi8CcSgoYE7DkYHdXuIrbPdFQpcKEKxAK3mU364wBTYBE61BSWQWhEk46yhWM
Message-ID: <CALnO6CBC+SK=ycHn4xgzoZAud5ZWpqSp1NSe5maKPhp9+f=LgQ@mail.gmail.com>
Subject: Re: git-diff in a worktree is an order of magnitude slower?
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 21, 2026 at 1:45=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Sun, Jun 21, 2026 at 01:24:32PM -0400, Jeff King wrote:
>
> > I think this is the core of the issue. These entries are "racy git
> > dirty" in the sense that their mtimes are the same as the index mtime,
> > and so we double-check the contents. This is the first bullet point
> > under the "Racy Git" section of Documentation/technical/racy-git.adoc.
> >
> > But diffcore_skip_stat_unmatch() doesn't count them as dirty, so we
> > don't increment the counter, and thus top-level git-diff won't write ou=
t
> > the new index. And thus every subsequent diff repeats the same
> > expensive double-check.
> >
> > But I'm not sure where the blame lies. Either:
> >
> >   1. diffcore_skip_stat_unmatch() should be counting these in its
> >      "dirty" counter; or
>
> BTW, I don't think diffcore actually has the information it would need
> to do so. The racy stuff is handled under the hood in ie_match_stat(),
> which returns only a set of "changed" flags. So the caller cannot tell
> the difference between the two cases:
>
>   1. We checked ce_match_stat_basic() which said "no change", and then
>      is_racy_timestamp() was false, so that was good enough.
>
>   2. is_racy_timestamp() is true, so we further did a content check,
>      found nothing, and returned the same "no change"
>
> Obviously we could pass back another flag, but that would disrupt the
> other callers. Hmm. It looks like we could pass in a flag to say "assume
> racy entries are modified". And then they come back to the diff code,
> diffcore_skip_stat_unmatch() sees they're not real diffs and suppresses
> them, but we _do_ count them as stat-dirty.
>
> Like this:
>
> diff --git a/builtin/diff.c b/builtin/diff.c
> index 4b46e394ce..4d36b5c1e0 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -271,6 +271,9 @@ static void builtin_diff_files(struct rev_info *revs,=
 int argc, const char **arg
>                 argv++; argc--;
>         }
>
> +       if (revs->diffopt.skip_stat_unmatch)
> +               options |=3D DIFF_RACY_IS_MODIFIED;
> +
>         /*
>          * "diff --base" should not combine merges because it was not
>          * asked to.  "diff -c" should not densify (if the user wants
>
> That seems to work, in the sense that "git diff" does refresh the index
> afterwards. But the timings are a bit funny.
>
> In my working tree of linux.git with many racy entries it was ~500ms to
> do the first diff (and the second, and so on, because we never updated
> the index). After the patch above, it is 1800ms to do the first diff,
> and then fast (~30ms) after.
>
> I could believe it takes twice as long when we refresh the index
> (because I don't think we use the stat-cleanliness we collected from the
> diff, but rather just do a from-scratch index refresh). But that would
> imply it should take ~1000ms. Where does the extra 800ms go? I guess
> that somehow the content-check done by diffcore_skip_stat_unmatch() is
> slower than the one done by ie_match_stat(). I think the individual
> functions are respectively diff_filespec_check_stat_unmatch() and
> ce_modified_check_fs().
>
> I don't know if any of this is really worth digging too far. This feels
> like a case we could do a bit better at, but I wonder how much it
> matters in practice. As soon as you do any index-refresh (including "git
> status"), the racy entries are cleared and everything is faster. It
> just seems kind of lame that we write out the initial working tree with
> so many racy entries.
>
> -Peff

I'd like to dig into this some more, personally, but I'm not sure when
I'll have the time (and we're deep in the guts of 2 systems whose
implementation are quite foreign to me---the index and the diff
machinery). The main reason is that I noticed this all when trying to
figure out why my shell prompt was slow :) I'm willing to pay a slow
first prompt for all subsequent prompts to be faster without having to
remember (and alert others) "oh, this is racy git, just run 'git
status' to fix it" or something. Obviously it's even better if that
first racy diff + index update is not so slow, though.

I think I saw 2 potential areas to dig?
1. The time spent on that refresh index diff mentioned above
2. Limiting racy entries on initial write.

The latter was, I think, dismissed down-thread if I understood? It's
not so nice to stall for a full second just to avoid raciness, and
USE_NSEC alleviates the problem, too. (If that became available to
more folks, see USE_NSEC meson thread, then I suppose I would be less
likely to dig into (1) even though it sounds like an interesting
puzzle.) So maybe instead of "dismissed" I mean "we decided to keep
the USE_NSEC gate."

The former I saw some interesting discussion about how to communicate
bits to code, but no hint as to whether that changed your initial
measurements. I suppose I could try for myself, but it will take me
some time to process Junio's suggestions there into actual code.

--=20
D. Ben Knoble
