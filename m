Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C8B13DB9F
	for <git@vger.kernel.org>; Wed,  7 May 2025 03:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746590134; cv=none; b=PWYRr5bvijcG+LLWCKiHPG/Y4sDMP2YPpgVqJjV9aORxdsniTxR5bwM7zEl1iKJzC14SuN3uuNnuRIA4TnxCKgymtYQ3K6dxCWlhaXf/0IOyA9t0/D36LnSo9xaRn/6JHPQuDf4BSM18LuBGwzq66kt0UbEgcqwxYnoaAGwWHfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746590134; c=relaxed/simple;
	bh=E838HbSYikX5Ky+PMMKQphU5QcekJ8NzGOSpAu+F8Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkds+ce4ifc6NJuaGGQpMlwpQfGiUuoWed6mjN94uR5Ab9DsCg5n/3hzK3mwp8yh8ne2/Xs+CDmn72QSATlxYD4wiH5hroRAsBrjBzDQ/+Tnw61W3w+No29V/YaofgQgJOLXpE9ijQ633oIWpIbTWeWGZm9hOe1lvvQiFztqnnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c921ec37e5so31793385a.2
        for <git@vger.kernel.org>; Tue, 06 May 2025 20:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746590131; x=1747194931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgYgxHV3Lw/D7OAnICToAaIfykUDcBz8LKEM7ivgI7s=;
        b=eV4EKQshPxFZ5bdiyKxjXnBVouZvKIos2D3L77i5dKxk5nbdny5+CuYGX1lQH73p7G
         vbG6O0tPYXejk7hSjMOqz9AiOmJDID9+qYApaY0FHQ3oYK0+HIApIS8znwmWEsLZvz/q
         853ikIHbZ0uLOqT+xHsE05Wzpf++ddQR13nyqhdt7Rd72D5CnuuoGyEzQToLywJg/eWJ
         9cXQ8LZw37CIV+8j4vQ++0dsnTtJnB8GmxD6xPEvqeFW34n+uTLBdTDM8l6m6ly8un+W
         pLk6aja5+JilYaJa5fpTuWIgQOlKwOq36PXwLZVZsC+9iAX9iTP+yJtqpFOD8dZfKyFU
         IlGw==
X-Forwarded-Encrypted: i=1; AJvYcCX/JANqWkvU0mz9Yp/ubAawC8REllaI2YRNLIXCjHmk7PIQBJ4mjeuv2n3JuBCa+4aPsb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZuSuj5ABdNNfB6qRStT8Dh+gL8U/a0dhtrz7spT2++TME4Mqr
	775nRL6qX+dVqo3lNtRVbET2xJ1nIN8ZmGXpVxOwRrwG5Ui4YBvHsbH+zYYbt23vC8E1rHWDoiD
	wq2xHfAjhIKy/Lg+hlu6cITElrXacza+Y
X-Gm-Gg: ASbGncsr/xCNtL0xprTDQPMeQUQFWVUiT5SaZKo6EraHyrUEKXwu/efixxqfq7S7UWi
	shQK1ars8wgtSSNU4zDrYSbp/CohkWCsxKv7VFkVh7uW50AMyMbRePEtzj9PflHAg6tEHyIOAqa
	CuwArxBKXi6r9Jlf/CoB4v1+0CS91/DrojPrtItErt0tZAi0oninc+JNlJpVXET6aF1A==
X-Google-Smtp-Source: AGHT+IHPdjFLUVbRJMN+eIiasr2dgRi7eIH/vA0XHyTTfWya+38VyxSM9+Ke+W3BrRaBzjm25hrzDt/a0JCxbpOaNQI=
X-Received: by 2002:a05:6214:e8c:b0:6f2:c10b:db11 with SMTP id
 6a1803df08f44-6f542aeb30bmr10613156d6.6.1746590130959; Tue, 06 May 2025
 20:55:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
 <xmqqmsbph3lw.fsf@gitster.g> <CAPig+cT6XbdzeOFoeZUmX+ozPa2XNOv=H85xQhY4y8NYmJZ6-g@mail.gmail.com>
 <aBq4J6UTZVPF8rb4@teonanacatl.net>
In-Reply-To: <aBq4J6UTZVPF8rb4@teonanacatl.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 6 May 2025 23:55:20 -0400
X-Gm-Features: ATxdqUEFCbldc-C8TyqaU7N7sLBc-CHuZAp_d3fZKX4pyS3TEv-HmFmxvF-23yI
Message-ID: <CAPig+cRxDQBmPu_-ci5vEuwtsAHadfCiFOccdYseBSj2F52JGw@mail.gmail.com>
Subject: Re: [PATCH 00/10] Spring cleanup of "contrib/"
To: Todd Zullinger <tmz@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 9:32=E2=80=AFPM Todd Zullinger <tmz@pobox.com> wrote=
:
> Eric Sunshine wrote:
> > Although we periodically hear that someone uses it, git-contacts
> > probably falls into the "tool has a clear alternative" category. In
> > this case, git-related[*] is a separately-maintained more functional
> > drop-in replacement which people could be using instead of
> > git-contacts.
> >
> > [*]: https://github.com/felipec/git-related/blob/master/git-related
>
> It may be worth noting that git-contacts is suggested in
> both MyFirstContribution.adoc and SubmittingPatches.

I think I knew but forgot about those mentions. Certainly useful
information if Patrick decides to pursue retirement of git-contacts.

> It probably helps that since 824503ce88 (SubmittingPatches:
> clarify 'git-contacts' location, 2024-04-18) there has been
> a note stating this isn't "part of the core `git` binary and
> must be called directly." That is relatively recent, though.

Out of curiosity, I Googled git-contacts but didn't find any
meaningful hits. Pretty much the only pages found were renderings of
Git's documentation (including SubmittingPatches and the man page for
git-contacts itself), as well as the few patches to the Git mailing
list which introduced or touched git-contacts over the years. I did
not find any general discussion or recommendations to use
git-contacts, so perhaps it indeed is not very much used.

> I added git-contacts to the Fedora git packaging shortly
> after 92a5dbbc22 (SubmittingPatches: mention the git
> contacts command, 2018-04-11), presuming some readers would
> want to use it.  (I never want to penalize users who are
> diligent enough to read SubmittingPatches. :)
>
> All that said, I don't have any strong opinion on whether it
> is kept or removed, let alone when that might happen.  I
> don't know that I've ever used it, other than for testing
> that it worked while packaging it.

I've never used git-contacts either, despite the fact that I'm the one
who ported Felipe's git-related from Ruby[1] to Perl[2] for inclusion
in Git's "contrib" since the Ruby version had been rejected due to
being written in a language not already employed elsewhere in the
project. The Perl rewrite also included a number of useful
enhancements which Felipe later incorporated into git-related after he
published it as a standalone project. He has since extended it to
include even more features, so it's functionally a superset of
git-contacts.

By the way, Felipe also sent a patch series[3] eleven years ago with
the same intention of Patrick's series under discussion. Felipe's
series was never picked up but did undertake the retirement of
git-contacts.

[1]: https://lore.kernel.org/git/1369986380-412-1-git-send-email-felipe.con=
treras@gmail.com/
[2]: https://lore.kernel.org/git/1374403962-48361-1-git-send-email-sunshine=
@sunshineco.com/
[3]: https://lore.kernel.org/git/1399662703-355-1-git-send-email-felipe.con=
treras@gmail.com/T/
