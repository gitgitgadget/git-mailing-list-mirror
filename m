Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC733481FBF
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 19:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788549576; cv=pass; b=RmwmrD3kXwHPrVtMf3FmBOAOxnG6qzaQaudHZw5ax4bKetZXtvu/MdiL9VYV/09DqodYj4OSHxYsQ49QXeFophxXoWmeV9jBtjflujF8E4pjpHOfpQanc6yB8JsyWq46SwNDSz6v24y4fTrrBsd1z8F3UeGjzjkRFZhjJstu0vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788549576; c=relaxed/simple;
	bh=hVgoNpuwrdc5OsXjX3hwQ/tasUCxA21AcWGoVxTF/kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kv2bYnFBDTmQRXXuhVudJ4slf0ofdsvDRABx2zsq4wWIquR2ZKPO381JJndWucZzGu/pKvSN3+1bcuF1oqWquQpH5tokEBKx6rkKoYZbePAJd0CTCxdKyd5niKrRS5PwR0ThZwm6UCLaCeafnqf9Dzr0Q2izdtat/BQtgnomiPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOICA1Km; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOICA1Km"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6b1bcd9e00bso1234281eaf.2
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 12:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788549569; cv=none;
        d=google.com; s=arc-20260327;
        b=h7WFfyBjBr9lN93e+t1TVqO6tuE4jb68Qnx9jniH5HEVDMepDyf+ZJgg3fi5i41buX
         XouZlxIHkGcuP7uYXKADKGIwRMm/mjjCwDMX2XrNcnc6Wl6DM9F8OsZjPbDN0Rja8lni
         9z509yY+l4pt+xcNlAKkTyHICo9BFGK5IGk4KPlrf9TKjeWSrsj+ebXIX0PtPOgKTvxc
         R7bHOwU8g7ovF6nxFo6F2P3JStCyjOEzneokCgehfBoJNrw4d5VmIfIZtURBtb35WdME
         58g+4kYGN6f0Lgks7/zEG/cHa0qsEmQqRiZlou8LdpCF5RRBcasuqVlxQc8tiU8QR86I
         g0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WFAv6kKUhWx6R8Dtf/bc+UfaeyXiFtIAq1YPiOh/4Fw=;
        fh=Pvero7E+O86ETLGu/tA/A4A7FZcccQFsTORIoHXChqE=;
        b=B1fp8MrItTTRRL9cqTfHsb3hiVjNU+15M41H250is7fpvponvTsqu5xSF4XsMOXndZ
         rxQbHWmM802sUB9rxLDTYco+iaoNPt2TCQMlgdwC3XQCMGtsvRRvgSyYR8IxQXiP751x
         9StEc0jrqoWgkwqxYxdz4fE0jx0LjcJTw2k02CgUdy07OQ49gXHMycu/1AZV7zTl2IXb
         DKQjoJ+zHUa5VYOkqIHACem9gtN1dard5YYiXdzA8hYBex5Ep8KqxE761eCR64+otR1u
         p0Ia9Nvey9Ln2lcdfrJv/Do61LPrxLOiDQKW0jdRS9DqRNGqbvxfhT12BQx2uHNJIqil
         gc3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788549569; x=1789154369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WFAv6kKUhWx6R8Dtf/bc+UfaeyXiFtIAq1YPiOh/4Fw=;
        b=VOICA1KmgVgKdoNOVDvm96EYRJtyoOcBUTKVGpOgCFEWEOjObRecxramqZnQ3FWlsG
         IMAZYN2Rb63i8//3ZAU25sWMeEavOl6xl13C01XcLTPuZQx+SNS4kdGMI5iKLto9f2L0
         RKjuMEIFqS3sF8Ya1vHUurMzIvC95fReIgNFcIP+OtDQV2YMf3CecYYj3qqJ3snFrICi
         UpFf4jRFQw0HZA59vUmP7v/OlYKdyL+XrlAbay2LqaKPFJh0dWOMC+6u3ocMaoEGrqIv
         ozfMgkUIN9/PXnvjMqzNW/B/pDsjyMiRJHj6OEAzJuLzb1VrbgGqo+WUhrmCYo02fOSW
         nnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788549569; x=1789154369;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WFAv6kKUhWx6R8Dtf/bc+UfaeyXiFtIAq1YPiOh/4Fw=;
        b=F51Ha0B3hd6510bS4P0gB8+aZIsZffnUzaMPUaKV3pwT8JSYxRuUcQpzlFFFpRi/fu
         ufOQsG7G8LHu9fbPoX83a6xYVrRLHtUpvhp39vbGj8Bw45yllOX0DYSfhFySsuzUqnZE
         ZnOEmMVoBKduvmXCcBb1tvtmix5cEljdUBIurqQoHjU9QJmCP2PgmaXP7Zel/Cp1XxJt
         fanBBiw4LVJb75bHGfQsD952c904l5zpcCsAgrG6qbXCR1C/Nle/H6YcRnQHL4lVDvZo
         DvzZE1V071oRbj8Nx8qyVyBNILS1YLlNC9mnuX13OZ4yZFTtgfibvF8hrhLNo69Gz0Pn
         6vzg==
X-Forwarded-Encrypted: i=1; AKwUvByBmguNYnHt8HrBUYDhcQ3QE7wmITXbnsmKO4auoQ6sdYkY3jULhphAxBaUmtPAFPlK+mA=@vger.kernel.org
X-Gm-Message-State: AFuF++nmWTQNXSWg7+9wreCzPwIJ6Z1Grk6mbe8VodCiJpasqo7yioGW
	pvN1E1DUOtCLyYsQhqFplqnGLJV2xukPDnwFMOjpz4Oo8kl6lmTM551urShPFWdi3gYWSQcY52o
	yvV650kGskBgKJ26DbG++OB7x00kldJ2c9bek
X-Gm-Gg: AYBFou2QsH/WZV06ivpsjHxRc7z0+xY0bdaH3x23jBCKrrfGMGCOoA0x1to9Q+bCbyZ
	eh2vG0MkdZK2DvkPSK/0xrKBb8HSNu+LcahkceGUu281ANF5yjRE0H5rVj7nKY8mqJIvGd9scWR
	clQNntZRiYeaJdb60JbZX9qTtxHrOKVIKwdhlsk1soCGpLyIx3gEr7JfVo6yNRvWgXD1uluLqIt
	m4eQ+dqjLMhjPrDO+S7fC4N0YrcVipT3J91BVCN4e9hQiwOCDFvPiP68RjNpZDLiinb9qEtnGuS
	IlM1w62Zv3O/9yuPA3WyWtcoIDMWei7ATMxHQbmccDxK4h8i8ALZPW+V1pPvtBb3rt7ZJYDVPdS
	5piGTIGtxGMWBrQL6MHyPDsLMkewv318ldG8CVpSM0TwWaMPdT5w2SY81iTIW6dflICaiTue03b
	g=
X-Received: by 2002:a05:6820:211:b0:6b7:83c5:fdf2 with SMTP id
 006d021491bc7-6b783c60319mr3592386eaf.51.1788549569492; Fri, 04 Sep 2026
 12:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
 <xmqqecfbk2eb.fsf@gitster.g> <81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
 <886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de> <27FF785F-F5D5-44EC-93C2-5BD67BD99147@ytausch.de>
 <CABPp-BF6hps9DibSV4ghbowkOD-NfEsHYFdLoKab0hCfEi9rgw@mail.gmail.com> <xmqqy0dh3r2k.fsf@gitster.g>
In-Reply-To: <xmqqy0dh3r2k.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 4 Sep 2026 12:19:17 -0700
X-Gm-Features: AcwNN1WlVpAvgr7uuIfE4pI8A3xARgmUkDbSmWJTvQGcK2NU3WlWpXIvcpzLkVc
Message-ID: <CABPp-BHviE8uLgh6PE=6MYkz_zTDZfKU9CbHQjJOeLgA=qpUSA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dir: find common prefix among non-exclude pathspec items
To: Junio C Hamano <gitster@pobox.com>
Cc: Yannik Tausch <dev@ytausch.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 9:43=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > This to me looked more like what you are changing, and I had a hard
> > time figuring out why you were changing it.
>
> While I share this assessment,...
>
> >
> > Does the following alternative correctly capture your intent and change=
 here? :
> >
> >
> > dir: preserve pathspec prefix optimization with leading excludes
> >
> > Directory walks use the common directory prefix of non-exclude
> > pathspec items to avoid scanning unrelated portions of the working
> > tree or index.  Exclude items only remove paths from that candidate
> > set, so they do not need to widen the traversal.
> >
> > When an exclude item is the first pathspec item,
> > common_prefix_len() fails to establish a comparison base and returns
> > a zero-length prefix.  The result is correct, but git unnecessarily
> > traverses from a broader starting point even when all non-exclude
> > items share a directory.
>
> ... I do not think this is true.
>
> What happens inside dir.c::fill_directory() is driven only with the
> return value of common_prefix_len(), which already ignores and has
> always ignored the negative pathspec elements.
>
> What this [2/2] changes is what string common_prefix() returns.  If
> you have "!x/b" "a/b" "a/c", common_prefix_len() goes over the two
> positive ones "a/b" and "a/c" and correctly notices that "a/" is
> common among the positive ones and its length is 2.
>
> The problem this patch fixes is that common_prefix() used to always
> grab the first two bytes of the element that happens to be at the
> beginning of pathspec, so a pathspec ("!x/b" "a/b" "a/c") would have
> given you "!x" as the common prefix string, which obviously is
> bogus.  The common_prefix() is only used in two code paths that are
> quite distant from here.  It is clear there is a bug (i.e., the code
> that wants to be passed "a/" in such a case cannot be happy to see
> "!x" instead), but it is totally unclear what the end-user visible
> effect of that bug (i.e. what happens when overlay_tree_on_index()
> passes an incorrectly computed common_prefix() when "git ls-files"
> is run with "--with-tree=3D<treeish>" option?).

Maybe I'm misreading the code.  Did it always grab the first two bytes
of the element at the beginning of pathspec, or did it get an empty
string?  By my reading of the code (copied here for convenience), it
got an empty string:

>-static size_t common_prefix_len(const struct pathspec *pathspec)
>+static size_t common_prefix_len(const struct pathspec *pathspec,
>+                               const char **matched_prefix)
> {
>-       int n;
>+       int n, first =3D -1;
>        size_t max =3D 0;
[...]
>        for (n =3D 0; n < pathspec->nr; n++) {
>                size_t i =3D 0, len =3D 0, item_len;
>                if (pathspec->items[n].magic & PATHSPEC_EXCLUDE)
>                        continue;
>+               if (first < 0)
>+                       first =3D n;
>                if (pathspec->items[n].magic & PATHSPEC_ICASE)
>                        item_len =3D pathspec->items[n].prefix;
>                else
>                        item_len =3D pathspec->items[n].nowildcard_len;
>-               while (i < item_len && (n =3D=3D 0 || i < max)) {
>+               while (i < item_len && (n =3D=3D first || i < max)) {
>                        char c =3D pathspec->items[n].match[i];
>-                       if (c !=3D pathspec->items[0].match[i])
>+                       if (c !=3D pathspec->items[first].match[i])
>                                break;
>                        if (c =3D=3D '/')
>                                len =3D i + 1;
>                        i++;
>                }
>-               if (n =3D=3D 0 || len < max) {
>+               if (n =3D=3D first || len < max) {
>                        max =3D len;
>                        if (!max)
>                                break;
>                }
>        }
>+       *matched_prefix =3D first < 0 ? NULL : pathspec->items[first].matc=
h;
>        return max;
> }

Following the preimage, and using your pathspec of ("!x/b", "a/b", "a/c"):
  - when n=3D0, we hit the PATHSPEC_EXCLUDE case at the top, so max remains=
 0
  - for each n>0, we fail both sides of the (n=3D=3D0 || i < max checks),
so len remains 0.  We then fail (n=3D=3D0 || len < max) checks, so max is
not adjusted (though it'd only be adjusted to 0 anyway)
So, at the end, max is 0 and we return 0.

>> > Use the first non-exclude item as the comparison base and return its
> > string together with the prefix length, allowing callers to start
> > from the recovered directory prefix.  Exclude matching continues to
> > use full paths, so this restores the optimization without changing
> > which paths are selected.  Add a unit test covering an exclude item
> > before two non-exclude items with a common directory.
>
> I do not think this is what this patch does.  What you are
> describing is this bit:
>
> >> -static size_t common_prefix_len(const struct pathspec *pathspec)
> >> ...
> >>                 size_t i =3D 0, len =3D 0, item_len;
> >>                 if (pathspec->items[n].magic & PATHSPEC_EXCLUDE)
> >>                         continue;
>
> which dates back to the very beginning of negative pathspec elements
> support introduced at ef79b1f870 (Support pathspec magic :(exclude)
> and its short form :!, 2013-12-06), I think.

I was trying to describe "n =3D=3D first" vs. "n =3D=3D 0" in the last
if-check, which allows us to set max to something greater than 0 when
an excluded pathspec appears first.

Happy to hear if I'm mis-reading or if my previous explanation
mis-describes this.
