Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C332F8EAC
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 00:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787790229; cv=pass; b=J3s/lUZcOxAw+phlC9Y6v7tU7XSstXBA6GGnAeb4BRdArnKtDVY2sNvlu3aRWg0FTSsQEP9Y3cXbIVzf77qU/V0jAz90MjqJu6d2bAddPwgnWQ7pYCz93jHBy86PKfJDuBi5OpZxAZSHAcMGmtN1leo3ZyGsoTousBp+6riPmTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787790229; c=relaxed/simple;
	bh=0VNJpAIXJLrW7ONixjeoRZmcJq1VwDGkunV8ie8JJU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGJxS+Hh/9f0a2oQS7mVAqnP9XPC2TLHi35/g0kJWNIThdH9t5NuDXViPRhb3IBe5gmzgzNaZ5OG6dxIGq0hF8sU6YjHBxL/h3xOg4rQinzh5v/jBaxz7bhIY/7IYq9PD3nNR8ksZTSNQjoqbYAoEFnLmI+bnayHDMScsFm2078=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qe7U2lGr; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe7U2lGr"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4a4cb36ae00so1431244b6e.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 17:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787790227; cv=none;
        d=google.com; s=arc-20260327;
        b=eAcI80ZovtQt2LuaI0jXUgcCZ/oy+IB202VlHMLJ/ktsIIDKg4J4U3OuZaCuddd4Ol
         NZ+1DNFh0yPSUBdxFeI3SavSQYlGXGa1SIRQFPJQD62wwHFm8CziSA2mzhWoZ1et7TA6
         MeF5bk38MVN9/0VfAvN3Bn4wiT4jUIUhgnYJh6FnX6OTL9dMwIH82CETji32V9L+lGu2
         jxUeVvVWN6ct2hsh5D6pQNV1YAnU9FzPmblo3jopqB6JC0JxNRBjuS4PJi5UXlIpj1Wp
         md6DlsADwpXe3xYf8Yh1ecA55A/f0gUR35GLGjXgZcPycuIIWPt7irM6WdV/yAJMlgU5
         jIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K8TIqteEyIaw7rPggQsf8kv3yqjCwneapy2rxU0XE4Y=;
        fh=YE92iq/8oKjxrlHLqbOxj5RWdKPEJKrTgQDxuEl5IHU=;
        b=Bj0kV1j7W9CBbskpXERkM5Kuq49e/IakRaAlJ0O+JxWVFNou4ZfAzS5dLNnnqoTrJO
         mIDomS2bbf/2bM8vkrHRabNb4RyT1fsqp10Mi16MYQWsSXCp/Z4l2ZLqlLA6eY6WNDrz
         2zL9osQ9rlSkKGUxQtilDNsNj+92KXGGiWxtDBg6uyVDJ4Nu2SPd3Jd0Iid6pjWUws9b
         Xgehhs21NWRrohFVGTpqPtXfgDIs9UAp4ytMFrfaYfk5xzdZe2d2pVGnNZ6q9sV0UHE+
         AfQb0AF7iAALrjXjWv5CvaVWGpNFjSce1a4HC1Cev8ia35LnLEtGpVk05w7b65yruvln
         uICg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787790227; x=1788395027; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K8TIqteEyIaw7rPggQsf8kv3yqjCwneapy2rxU0XE4Y=;
        b=Qe7U2lGroUwJ9SDIZKBaIvjrp4ntmrD5LhM10CEgye4hY7iKJCI6ndswCF00Z8tjie
         h2X1Hymo3uFFtGMYNUBUwuOARALJTovFBbr6HRUvbNk8vUayQOuStjUENsGnXmGvtGzF
         +lnzEqhhdp3GD+zPxUOFg7R1WYXYLfEFG8yAxtyBzLLbJE1bw8xBdyEOaYMXOmOzAIlv
         Oy9AqiRprL/afHkwl8eTO2um7Ak11rbecxb7cXoimBMjzSHCaN9UZbs3rT4sjMHPH0Af
         Mk/ClcYWcIE9DKwizKT1a/C8D6eTvCD5fcaOre8K5Gyr9vm228QIz1j/sW15zX8lvIYn
         c4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787790227; x=1788395027;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K8TIqteEyIaw7rPggQsf8kv3yqjCwneapy2rxU0XE4Y=;
        b=g7iWHtUteoVFXQ7/1JLrWZ8P0jE0gi7mG0m03U5ke+P7Xz+pM4dwBEgp6tP3A6DUfH
         MC/piUj5l54ahV9GUg3F1N9cSurXVHcEzFy89HKt+07Q9GnIS+XYesdv8MSAQdl+izQ2
         C9d0QCfd4xXdDkPNZU52Uq6uEsuHNsJUZShZX7z6fA9DIGiWuodOcn6REaUGGC5KfFEs
         HtT2uszNC+bHiK6zu6hODd8euZGqbJK4xneBD0Xld1DmRVG0Sf8Uy+QALb0omZwkiM3u
         D8nT8sW9UobmRvRVOhltgvxfha+ka25+Kvqw+bDPk0lBlvVSW5l9yJs0o01vVPfkOgV/
         b9NA==
X-Forwarded-Encrypted: i=1; AHgh+RpFXktnhSHWU1kPbZVIbfs0nLFZMFpTz46tIdTIFIRqnnIunPpKXKIIdVeaBOEcTT+EK4k=@vger.kernel.org
X-Gm-Message-State: AFuF++mYxV5cchk80xSm0vfk164uhC0+tSOpgft2aHDPu1rpNNRCv0zK
	NYsfMmPVePBxxqfIlOD27ZJzxatwqnFaBkh5Tc6u0T0ERh59kJhrotXnWs17eJWRyGz37Mc//jU
	c0uqvTvL8X09qs6bNsWZ3Loy3SGfDSRQ=
X-Gm-Gg: AR+sD102R98l+c3CmTqlvGRru0Fl7TdfUaNGpGMyMFGVll/hHwiqwZMUKJjGmEZKRuP
	+NAveyHEs4bA5A855U7lCgukd0dAQbN+bGtxnpjZIGUokUvPQf47QKXo4NDnfrjf5aDBn+RGEQX
	QgHbaX2yZoypsVwjreC37KJxneIT/+tvRHpQ76rqXoP+4KAdwa28tTe9PADkVwlJaa9vCy9Ixes
	A9bB1U2YUr6ZvWzKzuHScZlXTuwOFhhJqgZo3prpuUn0KX14qxM8iFzNMRVfchjKUDY4FtUMXiL
	yARVO5JgjnNHhg3ZLtQ5s4KcE86WZDDtvprR+Cpdz8FXmdGmF4KGixhsa0hu0Fqk+q71x/8wsbz
	V5ooTD3PAEeseJMwh9Z41YHSNHeEjFbtAvzPrnFMQg5b9AzJnM2F0bVcNuydebg==
X-Received: by 2002:a05:6808:f06:b0:495:d7ec:b6ae with SMTP id
 5614622812f47-4b366cca0f9mr11791346b6e.16.1787790227267; Wed, 26 Aug 2026
 17:23:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com> <xmqqzey8j1gt.fsf@gitster.g>
In-Reply-To: <xmqqzey8j1gt.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 26 Aug 2026 17:23:34 -0700
X-Gm-Features: AcwNN1U7N9zkn5J4ULaqbjDL_7XEA-Rl7bsRk6djGfQrQyGjIs4n4Grpq8z5ngA
Message-ID: <CABPp-BETkvaRUvn36TxgnK4DW6agVbsiHe++FnJFhnRDfkge0A@mail.gmail.com>
Subject: Re: [PATCH] commit: refuse to amend during conflict resolution
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 9:22=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > ...  However, with the merge backend of rebase we have to
> > be more careful, since it powers interactive rebases and
> >   - the interactive machinery internally uses `git commit --amend` for
> >     `squash` and `reword` directives
> >   - users are expected to `git commit --amend` after hitting an `edit`
> >     or `break` directive
> > So, we need to be careful with rebase to only reject amending when doin=
g
> > conflict resolution.
>
> True.
>
> In addition, in any and all of these scenarios that lets the user
> deal with conflicts in his or her working tree files and record the
> result of conflict resolution in a commit, we should reject not only
> "git commit --amend" but also "git commit <paths>", shouldn't we?
>
> It may probably be better done in a separate topic, as the guiding
> principle is slightly different (i.e., "recording the conflict
> resolution is about recording the state on top of the current HEAD
> and never about updating the state recorded in the current HEAD" is
> the theme of the current topic.  "recording the conflict resolution
> is always about the entire tree" is the other topic), so we may want
> to leave a #leftoverbits marker here.

Oh, good callout.  And later in commit.c we do disallow those, but
only for the same operations we previously disallowed and amend
during:

        commit_style =3D COMMIT_PARTIAL;

        if (whence !=3D FROM_COMMIT) {
                if (whence =3D=3D FROM_MERGE)
                        die(_("cannot do a partial commit during a merge.")=
);
                else if (is_from_cherry_pick(whence))
                        die(_("cannot do a partial commit during a
cherry-pick."));
                else if (is_from_rebase(whence))
                        die(_("cannot do a partial commit during a rebase."=
));
        }

The exact same additional structure could apply there, and that kind
of reinforces Phillip's suggestion to factor out a helper that we can
call.  I did that in v2.
