Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2193417BA3
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731963845; cv=none; b=VegmByNJL2BEThRZk1/N+KX6pqngkQt/4zbMibfVHedYalCRjuq4fktfPKWj1nO4HVr1RbXjh4+dzDD5+YMd8jxFa1yRMAyIfLiLaJWatLluRH0y6LyArpSvmSzU5tglg5edAng/ikAr9J7PxD4pZ8C9VLqE4hpW1N9xp9745/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731963845; c=relaxed/simple;
	bh=qAH/xrVqb4Ewd1WJVtHLLD4+eD/59EpwHa4HpCvqIKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCaF6NX+gjJpwf1Jyjb8UHgSiJxAsBJPJ7CHBunVBunUkCFf+kGrdz76HysSNPcm5wwInvuJaQGfx6P89S/HjQZHhdezqBZRcZorJUQhcjPCVTtsp+r8iAGyCluy9djCNlicyRXkrJPgIyXFilQTHIUiYuWxzM55aN/DnOuwPgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvMHEbto; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvMHEbto"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-514668ec665so3765196e0c.0
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 13:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731963843; x=1732568643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t73KyB+q0BuFmjqsb27nij+1rAICd7N1kbPQQZt77pg=;
        b=LvMHEbtoBgGafM1xSGdIeWOdsaVs55z9ShIsZr4Gv0TKLDIf3mXxCWNNeDqiKJYikJ
         haOAnR0AE99nDqbaw8qaWtSCNfWcPyrx9z+OsIhEyjct51g3K0TNgdRKRmDZsHsAO9WA
         PcjXScw3ZzOj4sC7mrRvuHv5hbKwgl7ouVOkXZSHKRHcGSuzqQ5SypCv3DaHQR7GtzSP
         sYeBbupN82C+NRq5ZDpdHV++4cT6QvbJ06ZPhpAqJFg/4FjRpUE4NkdnIewm0NG5Izp5
         St1ekWQHoJaRJz9wTkoFOFy10Snn8yUpAFeoRhLAoZY74wDaIOtWj5bGMIHm9LJQXHbF
         qPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731963843; x=1732568643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t73KyB+q0BuFmjqsb27nij+1rAICd7N1kbPQQZt77pg=;
        b=eaSpojhmHvmmzpMmr1j2AkgfDremTiiW4xcFkQtZWTrU9a2/tdXGXDyjzIIAoTHA8t
         qwVuKD5OOgQyVBXJw6E3zYfcU2cYDmE5PFbZsdlquH1FhGPWmfU6J+y+dqOAYntI+iyQ
         aVsuCqRgTaKNqRYXa5WKm/g4/WisTjUVwyUrxgj9HwPp3hf8nbovXEzsYmuWmE0piwt6
         vK4Dj/qrDT74QeWu8ldJCh7vv6LkvpvfkFBXpPM2F8oYqNdhYteqIw7bBeDO7us0WLVz
         pdXSlzeJBskPWMwQZt5IpZEIu+R4H0ZxAA0RDoKIk81KnjiT+RFHBVACrJay9M3bAHww
         eblg==
X-Forwarded-Encrypted: i=1; AJvYcCWzN7PLz8+Zn8T6RUt0FparZoYehb0aRdz2cbMX6l55gy13kLG10zzIVB8McyKciOwTYFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjRJcsLYe/4C1h8Xm+hqUYJdg0hP5fVeVvgeYQvYavR5uWM3rW
	JGsfH6fODG98QRqUurAQQhmlrAEHusOF/YBz2QDXPfwRVxn9SyVcxS8taxFSovo1t04MsgspUHs
	BAuOjwUoZ02AwgDKxiZkJy79p0Eovf0/T
X-Google-Smtp-Source: AGHT+IEH6MyLI9gZ+cXTYnfbUIfbhUv5vwZ3rR66v19zDIhSUBrYZuQpncK/KeMYsb1aofQzEfsbYms0kar/g6r1Utk=
X-Received: by 2002:a05:6122:895:b0:50d:6cfc:ac4d with SMTP id
 71dfb90a1353d-514be119af0mr1037529e0c.5.1731963842962; Mon, 18 Nov 2024
 13:04:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1828.git.git.1731347396097.gitgitgadget@gmail.com>
 <pull.1828.v2.git.git.1731524467045.gitgitgadget@gmail.com>
 <xmqq4j4a8srw.fsf@gitster.g> <29c81cbc-3678-4b70-9e0e-c500186d159f@gmail.com> <xmqqbjyh5pa5.fsf@gitster.g>
In-Reply-To: <xmqqbjyh5pa5.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 18 Nov 2024 21:03:52 +0000
Message-ID: <CAPSxiM-H378tKrnLqiTYaWbGb9fPitRzqVpBf+7+Tu03Th3UPg@mail.gmail.com>
Subject: Re: [PATCH v2] diff: update conflict handling for whitespace to issue
 a warning
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 12:11=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > Usman - when you're writing a commit message it is important to
> > explain the reason for making the changes contained in the patch so
> > others can understand why it is a good idea. In this case the idea is
> > to avoid breaking "git diff" for everyone who clones a repository
> > containing a .gitattributes file with bad whitespace attributes
> > [1].
>
> Hmph, it would certainly be a problem, but the right solution is not
> to butcher Git, but to make it easier for the participants of such a
> project to know what is broken *and* what needs to be updated, to let
> them move forward, no?
>
> > As I mentioned in [2] I think we only want to change the behavior
> > when parsing whitespace attributes - we still want the other callers
> > of parse_whitespace_rule() to die() so the user can fix their config
> > or commandline. We can do that by adding a boolean parameter called
> > "gentle" that determines whether we call warning() or die().
>
> I doubt that such a complexity is warranted.
>
> It depends on the size of diff you are showing, but if it is large,
> then giving a small warning that gets buried in the large diff is a
> conter-productive way to encourage users to correct such broken
> setting.  If it is small, then the damage may not be too bad, but
> still, we are showing what the user did not really request.
>
> If we were to fix anything, it is to make sure that we die() before
> producing a single line of output.  If you have a change to a path
> whose "type" is without such a misconfigured attribute, that sorts
> lexicographically earlier than another path with a change, with a
> conflicting whitespace attribute, I suspect that with the way the
> code is structured currently, we show the diff for the first path,
> before realizing that the second path has an issue and then die.
>
> If we fix it, and then make sure that the die() message shows
> clearly what attribute setting we did not like, that would be
> sufficient to help users to locate the problem, fix it, and quickly
> move on, no?
Hi Junio,

Thanks for the review. From what I understand from your comment,
we should leave it the way it was which was die right ?

Thanks.
Usman.
>
> Thanks.
