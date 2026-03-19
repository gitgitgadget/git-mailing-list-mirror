Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0743EF668
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939435; cv=pass; b=ijxt1w8ooDw6Iy2At0pjiVEHuKzFBvwE15mDgKbJC8UlL0RiKCV64JndNJBdiIvOHrECEVeoT2BoMdWYI9CfOpISWXeTZocN3kMNX6bFC5qMJwm1vjPxdKPscBUJNwPkKPCTStSLnxdVtbGbxHxrI9G2uhb8bL18TbzjrG6o5cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939435; c=relaxed/simple;
	bh=0r/sQGpg9alLhW3F/jU7ngUanQOiN2l3/vkghG70jNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvxnXQX6uL2NxTTwMHQ4FKj2rlTBviLe79qPr9SMuSdcQw9mLavcanTu0TKM1uDAGPz6eUau6aBF4nnvZfGHS4l53NUOzXbke1oz/ody1ruzqS2RuX7aLGl9VZluvoBuztZxT+J7jHhhGJn1gWAu7n0oJJUzTc/zKPPjCzjIGEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaeQFGKr; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaeQFGKr"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so1440248d50.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 09:57:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773939432; cv=none;
        d=google.com; s=arc-20240605;
        b=JnDg+i/IlzMfP7EuS/MTb5bcLlTNT0Y2lp4Kc3aY85pBNxG0iqsg/Ehszxvo9k4PJp
         UfrVQV58K2g9UKi7Vb4K6TONKc9LHxoqIEdDhUQbJIfF+VLsEIsveqAwAfaXV56m2+ez
         t3RhsCN6c4MNtH7I68n+O5zjtTcm2727bA7+J5rHUcaKj+FYq3pKSezN1fys1QZztDKn
         agCfLgfD/1nW5UtuhU9dd5S4gac8+WgZvQHhfj8vsfupPEGTgWsDlwaHY8pDKIIVzyzg
         AYCJOC3RZMTro/5mS+GByQlNmLkRBcbKR/AnAqQZuPTpsl/zV4frFQQYAbPWgwNi9TzY
         W3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ey0ND4bwsQb2wFbP/XbXJV2nd3HWQ03lCH8uNII4IT8=;
        fh=Ep6KFvom/u+ES8V7r/L2JW1J3kUp0I9Xb5WPX6VKZds=;
        b=jK1qrzFf09q6H0mWbHBl/mwHSDPWfa12QRdHxhocH8xiryVCfWOEadGlp0HZr81Att
         8PTWL+CmT3yK5lzmfQCOUMJ/LeGyUbpmPso2m5vwYE8+z/GGD6c9CAP/6xBLsnxwsZhl
         c3V9Ept/BxXEvYsFQiumFP5lyhqkpCNxQkYSgufL78n40+2Jx20rbhX+RUgG97hsAuuT
         R8ksJkVdPKZT82GbBe7ZEU5vXklN6HnRYOM/6PnLLQkpvUZrpZDQFiLSP5duYncOAp+J
         2CxGrsk2HztvAzce7BAKgnSaS0TrrsLib7N0JqTU6rXrSBWNrrKRRUjtW0RbXld5hmgr
         8+vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773939432; x=1774544232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ey0ND4bwsQb2wFbP/XbXJV2nd3HWQ03lCH8uNII4IT8=;
        b=YaeQFGKroTO1Wd3NY8c3wQuK8tnMV455W58A536c0Dpq5wCjCn1/6gdzfBXW77LYro
         LdN6Ffw24MLqgGbH7mNWYBpilsZzrtwxc/39y65Cf5I92EOZow7K6SEZINipL3Og1h3P
         4Xj9tGnRE/dxzPsf+vGmdq2BWDVFBYN0tcPpjwtxLxSOvn0OG7jiT8gvYJv3NeypRRYy
         9nTWvL8MDOzzlnfZfl/YYQjszGVS0f/+tYk+fiBHuHQBQt2Y1YHTByxJQoioaaodLTkX
         Gx19XZIZvjaNve2kbaj0ttGZoEjHo1isAWwI4BWO9SM3OZ0CA6e6lIAItOfm/wcbHFGe
         ceHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773939432; x=1774544232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ey0ND4bwsQb2wFbP/XbXJV2nd3HWQ03lCH8uNII4IT8=;
        b=hBeJQB4v5RhsIGeE03bRj0umlTTKqzXJwqKJHrJifsLuwQWow/Z+uiszowd/WqhHri
         MJI/QUpsweM+m7BdyyKNQODhshsjEtoi86PVKPcwdbvXiHYzMpnACsX9MOZtKWDc46B6
         cPJyyXcb/KX45HiguTPB9gYy5lbP+X64nXwAQtCz6rFjN/uK2o8lhyfufEp8EVEH7qWc
         R1j6qmAjTmPN/NZ+R96eeNUUoKvG54/vgLGj6pt0jeQSJq58oeiSdvlB8VEj9oTjr7Kj
         tb1p93Z/6WkK7pWm53btoBVC/FmFWe5Dm/8TZVysMy+kW8KHoL9oRRKHfVFtPpq/zMI4
         Ojgg==
X-Forwarded-Encrypted: i=1; AJvYcCWsMber67si5KyYzjkxtyzbGbtQaYqeVAQRaQDiWxpfbmVs7u3q1fhCktNf3rptrh8dm14=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY941ZwLKDVNSLp7hCTjQ2EgpV/OfST8CaptZ4hQNAA1S/zf+e
	Z+tFmHrUsA2bGTrlbT9I7IvVR9Ke//R/AWaedkChDJw+wzHN2wZZrqce/EIw1wzuJPYyJWkRPE7
	rQ9aHKmbWxGS9wTbpgVehcjeQl9hNshpRGJKS
X-Gm-Gg: ATEYQzypo9/BuRj5XC0jgl709DjBOWe6p9CqsKIOQeOl2P3XCuhh7vhAYuzLVUqQrBS
	bEiJ23MKAyBGMUPAkn7XaQF7ts5hr8yj744sXtCUgDKrLIYWiYlpdMFlM+hBgKQcc5aulcyzCaj
	Bhf/G+GXeNFXs+0cG9G1+rbYY6XVuEzF/gBohsFUNwl+Aps4F4IP0aYJBXKHQpYFlUWDoUAfJgf
	VrdD6xAwo3NhjeGYUrKuD8rWIHQLDoUwO9IdjDNOAqBaVY7OWPVnNep+xx11Hb6lIiNND4R7IYS
	E3rP
X-Received: by 2002:a05:690e:1189:b0:64e:8cd1:3b8d with SMTP id
 956f58d0204a3-64eaa88eb36mr143093d50.80.1773939431676; Thu, 19 Mar 2026
 09:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319160633.1149562-1-jim.cromie@gmail.com> <b69406326eceb27f5973bc0ba55366438845a003.camel@perches.com>
In-Reply-To: <b69406326eceb27f5973bc0ba55366438845a003.camel@perches.com>
From: jim.cromie@gmail.com
Date: Thu, 19 Mar 2026 10:56:45 -0600
X-Gm-Features: AaiRm526DqlrRLANVytnrpDLaNTsm5oXV2ksWabIyzAxswfNxs0XDVe9g7FHfj4
Message-ID: <CAJfuBxxbV1X3X0GdvBEEHB8gS9wQ8hHcKDGC7GrSkOPECgGV3A@mail.gmail.com>
Subject: Re: [PATCH 1/1] get_maintainer.pl: add --cc option to produce comma
 separated list of emails
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 10:14=E2=80=AFAM Joe Perches <joe@perches.com> wrot=
e:
>
> On Thu, 2026-03-19 at 10:06 -0600, Jim Cromie wrote:
> > ```
> > This new option works as follows:
> >
> >   git send-email --cc=3D$(scripts/get_maintainer.pl -cc 0*.patch) 0*.pa=
tch
> >
> > A complementary patch has been sent to [git@vger.kernel.org](mailto:git=
@vger.kernel.org), allowing:
> >
> >   git send-email --cc=3Dscripts/get_maintainer.pl 0*.patch
>
> I think this is not particularly useful.
> Just use a script.

   1. Efficiency (One-Shot vs. Per-Patch): Unlike --cc-cmd, which runs
once per patch file, this runs once for the entire series. For a large
series or
      a slow script (like get_maintainer.pl), this is a  performance
win and avoids redundant processing.
   2. Dry-Run Integrity: By integrating it into send-email, the script
execution is part of the command's own logic. This ensures that
--dry-run
      accurately reflects exactly what the script produced within the
context of the mailing operation.
   3. Argument Deduplication: It eliminates the "Double-entry" problem
where you have to pass the patch list twice (once to the subshell and
once to git
      send-email). This reduces the chance of a typo causing you to
send patches to the wrong set of maintainers if the lists get out of
sync.
   4. Configuration Synergy: You can now set sendemail.cc =3D
./scripts/get_maintainer.pl in your .git/config. A shell wrapper can't
easily override or
      augment the built-in recipient logic as cleanly as this does.

That last point seems a clear win.
Far less maintainer annoyance at not receiving the entire patchset.
