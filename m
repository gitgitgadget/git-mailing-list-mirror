Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AC528C00C
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 23:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763421840; cv=none; b=SbTZuVID2PVrlc0jc8FPavHirEsURFsaukzkhq4wpee+XR7j3E/G8+Phf0KlMqVPx5XEzUnP9uzYwbEKsQGYegAEmIRiCvP97aOqDwflTnlu32KtVOkTVTfJPQLClHagOXblXevWuOnJM1d0K27mfuzlX6E69nJiDL7VaNvnYO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763421840; c=relaxed/simple;
	bh=5ou2tv0uhF52lke79iBtfwEnflsmek9fxoTHQweqhik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjXOWe0RrAmK7SiMZYjZ7oNTk/nC4YxNjd1iuLpaZXpYrBg6q6IdMCWYdepiQmNiHMQHDj4YU2+jUYt7+qFWz37mpeTUO2Ex75VicqPcXjwBUMPdaHhF2+4gTX49wCDA22FX5TRBTwsgd61IfP05pHAAT+eRmiSibLO7IxS7/60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sympoiesis.com; spf=pass smtp.mailfrom=zeta-soft.com; dkim=pass (2048-bit key) header.d=zeta-soft-com.20230601.gappssmtp.com header.i=@zeta-soft-com.20230601.gappssmtp.com header.b=tKVwvDxI; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sympoiesis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zeta-soft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zeta-soft-com.20230601.gappssmtp.com header.i=@zeta-soft-com.20230601.gappssmtp.com header.b="tKVwvDxI"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b739ef3f739so256388866b.1
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 15:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zeta-soft-com.20230601.gappssmtp.com; s=20230601; t=1763421836; x=1764026636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJYiEE4vVmQcbiOy+uYzHYweIIFZ+DYVrhp44IBj1xM=;
        b=tKVwvDxISMwKrWU3Lr5p1AgBIf3/xTl0rAo6v6mddMMe7tndF+dhRwvpDENKeb0wkj
         0loKkQmqO7nlqlo3dccgnGNpHUtaohljzOq23ZyaMnX+8E3iSHpG/ZbIfi/c/8m+gDuK
         fQTyp1zgWeSYxjjsG82knRHHVFCGS9hPqWpsSXuUXHyPNbJwI4hCeq6J153E52Hp7GUS
         IXfZyoFFBKN+KDv+az04OF1X+C7LJVdfLUbKDXZUiZ9JOZZgVH/byCwYjVnf/t6x4aGU
         sQRCsYuCF+5Aiyo/jtJoxahrao8wN8ZP4CPRKTVKRQ4NLh/uh9JiPtTFIKA48R69jS5a
         WuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763421836; x=1764026636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bJYiEE4vVmQcbiOy+uYzHYweIIFZ+DYVrhp44IBj1xM=;
        b=vDwYctJ8tVLMKYoft6/opc4QHCwHXWwlPObCTmvrChe0h07tdR+8PSyVKOXmfGFHoR
         HcBFAHtsNFsKi4uV/WwQWak/x7IDWu6+8DH6CimjmtJUfnlQvzRAUDBqX+hTNEPL+IrT
         lOdK6vG2jE3vGm+5OlpzPgnDAoYb6RhREzmS4lNoNIM6zJK4MOx5fc9zW6nDGo49jYoG
         MW3qGhaV1cTbXyeRzuxxdo2ukNl9XiMeoFos8gIzb+1ypWd9Dr4v3k/yUHYW5DSURIm5
         glV6SKMAc0Y6PtrOED5Y7WTt/K4BfX9BTorrti4aNM+z8ljPS9lWZw583he7aNlM4wg4
         jYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+V4eNymfD0YNhkrrRvLWgIl04bdOwj6BHRJUowgJkmDY8EjHPV2FGl0WvyyZ096Naxcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNxM74I68bt2aszyYzZ25tNXTtixDbEPyG/pm/Bk/W6VQnpz68
	OvqS9ba9wveXX05rphB6jQE+rTJDCM7PWOVPoARtDJVQ/QP54v08mZ/p0BEwm7WdwFhjL7juo3F
	obZn2Msa82nZolyNm9RAOKiqhw0UnDRxa+jqMQw3uzQ==
X-Gm-Gg: ASbGncv8fQWIaMVmggDqGyKAxd0HfgrLFSxNlQJjMuFR9TmfV0arfL+VetMELoSlv5B
	/98BIzKkEq/Zz1isaRPnLDvju1istxnWR/2g49MFfaTm83m0MhbVJ9UdvtiWLiQyCmYdAt5Cp6T
	xmT5OC6Bw2HE1uR8gZne7101QhApJCksfkOM+OeTznZcnJ/tFfcfXSNLl/zXBoAmyPYSqv8f3Yv
	jeARNZc7iaFPjYFjf36lBtsDOe+WMOS2RFnTmaoJhOWFg7HEJxv0jqy
X-Google-Smtp-Source: AGHT+IFnOK+E2wwDEH+okrY7eiLVrivQSyaHD+SCzUm8d1Qq2YLOECWCS57283aZtk4ufBlgdV0l0r1Wu3NSOoDXlfE=
X-Received: by 2002:a17:906:4fc9:b0:b73:8669:37bd with SMTP id
 a640c23a62f3a-b7386693873mr956734166b.23.1763421836104; Mon, 17 Nov 2025
 15:23:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2000.git.1763201865025.gitgitgadget@gmail.com>
 <773d3233-c890-4df9-8f7e-32ff8a48651e@kdbg.org> <xmqqbjl2ee8t.fsf@gitster.g>
In-Reply-To: <xmqqbjl2ee8t.fsf@gitster.g>
From: "Scott L. Burson" <Scott@sympoiesis.com>
Date: Mon, 17 Nov 2025 15:23:19 -0800
X-Gm-Features: AWmQ_bnPphVWyqBMKpCweWjkbhPAhu6r34X9XIDs3kXPBkvnIece97p4PLQu-_E
Message-ID: <CAF5LJ4CMtEaJgDYRHXvCTUm9Pjpv2GAsMQN9D-DL-Ric3ADMXQ@mail.gmail.com>
Subject: Re: [PATCH] diff: "lisp" userdiff_driver
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Jaydeep P Das <jaydeepjd.8914@gmail.com>, Atharva Raykar <raykar.ath@gmail.com>, git@vger.kernel.org, 
	"Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 9:30=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Johannes Sixt <j6t@kdbg.org> writes:
>
> >> +     /* Either an unindented left paren, or a slightly indented line
> >> +      * starting with "(def" */
> >> +     "^((\\(|:space:{1,2}\\(def).*)$",
> >
> > Compared to the Scheme driver, this regular expression is
> >
> > - more restrictive because it does not permit arbitrary indentation;
> >
> > - less restrictive because it permits everything that begins with "(def=
".
> >
> > What would happen if this regular expression were added to the Scheme
> > driver? Would it pick up additional and unwanted hunk headers is typica=
l
> > Scheme code?

Hmm, we haven't heard from Atharva.  I'll try asking around in the
Scheme community.

The regex I proposed has a bug.  The use of the Posix character class
is incorrect, because that class includes tabs.  I will replace it
with a literal space.  Also, many Lisps, including Common Lisp in its
default configuration, are case-insensitive, and at least in the
1970s, it wasn't completely unheard-of to write Lisp code in
uppercase; I'll change the entry to use 'IPATTERN'.

> As we generally assume that the file being edited is syntactically
> sound, even if one lisp variant understands "(deffoo" and others do
> not, it should be generally fine for the pattern to say something
> like "at the beginning of the line, optionally following a few
> spaces, four-letter sequence '(def' is likely to be the beginning of
> a function definition", as long as there is some convention that
> user defined functions and macros, unless they are to behave
> similarly to "(defun", would not be named so confusingly to start
> with d-e-f.

Agreed, but this is not the most important point.  The greater
potential for false positives comes from the rule (in my proposal)
that a left parenthesis in column 0 is taken as indicating a top-level
definition, without even looking at the following characters.
Although Lisp dialects certainly vary, I have not seen one in which
standard indentation practice does not indent internal expressions;
certainly, Lisp mode in Emacs indents them.  And, I think the rule
really does need to be that broad, because top-level forms don't
always begin with "def"; indeed, one can put any executable expression
at top level in a source file to perform load-time initializations.

It's only when there is some indentation that I think the regex needs
to require a word beginning with "def".

> It would be nice if a single set of rules can cover what existing
> scheme patterns cover, Emacs lisp, and Common lisp.

Agreed.  I do think it would be a little better for non-Scheme users
if the single driver were named "lisp" instead of "scheme".  Renaming
the driver out from under the Scheme community, though, seems like it
would be unfriendly, even after a deprecation period.

One solution would be to add an aliasing mechanism to the
driver table.  Perhaps there would be other use cases for it.  If you
would consider a patch along these lines, I can code it up.
