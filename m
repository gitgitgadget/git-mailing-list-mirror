Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517571A7AD0
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151295; cv=none; b=Rd+oq8GoSdG+UPmx4US2LakFD8tCt8eQTV7yMMcBt1uKu5OdYMCkMQSUG7xXUijgEfxjORZPlhh+Ul/zzaH9oEo2MKlHhbTM2MnJiyvgOxVL2WyxzwbBykLHz7HEdLmYfMq8S3RmVFt8CujCMeMnl3Ja7iwlw+boXQb3g4b7oBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151295; c=relaxed/simple;
	bh=2MS5z8APFE6ylSR9e9u5tJ74Cu8lAHcCyJEJo6d1ClQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+QwoNA6jCDNGhk/XZhVxrxuiGXRlvNK0asF9uvajBQgCeL3ttHqqH5TPthfGA0nCiaVKYvvDwVgk2BBWyW0TG6Ww8OO+yNFIZQGVJpU1QYL/m63tZGIw3rnc4hbptD582DVQ+XJpYFuIqFCjhuoQ5ufEeAJeZnfo/3FVA1unbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d8f4f25051so3833296d6.0
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 14:01:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737151292; x=1737756092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wQAYikYxPLt26fb7TXXEyA1IDIno+1htTm+yMV/hjM=;
        b=C+PgWIH2TYzj+6zKm8WqzOEo/9PfUVWRQ8teA+5Iizl3B9vuRRw9uNWNL4vokzOWMl
         fyz/4Ho751ISYlhXHe3igIdidy4KZab6ag8aTNEYjTClGiRvUHI2Bv/JI+nUDWGqLkLZ
         +3+AE1My4jsB9dAIaY//zCb+B8qluQDK1aK3FLyANURDzWkCscYuziYKLXJf7GfoU0Df
         YHtfo7B2HTyUa3cMEwOsrzpEeVf4dtzs7MhpqBeypL6/FK1Sf7tzBW3qC28W8FiBr+pO
         LxUdHN2EdVKNG6+fK/XYc/3nnPQw3lLSkGZRdzRKJsJqWYZA6bTO9Z7Ganx7pMGMkxNu
         A7WA==
X-Forwarded-Encrypted: i=1; AJvYcCWIJVl39TAmazsaDurevljs/ajPE5p/Vv3uPFEdlo5ADRsx9pk6UeR9R8NjSHlngG9WZQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YydBFWp6F0HRWhmw6a50UqBVVyJ4moCTbiEvlUJrLRncfWUFcd5
	C8VXQmPLKpp43Abi0layfxN2u3CgQhXzAQ1vKnqXdPLC90EFeBZ3TYaLmCtK1Tm9RF4brBGi8ti
	IWIFHp9k+JNBrF3FfXilvKMAphFM=
X-Gm-Gg: ASbGncvKzrOPoJkyINR1xBiiZe+y0Q5Y6aM1iRexW3cJEZrh7NOkE3ZI937z34GPXcA
	uVE9roz8vJDyI3PmJ9xOCKWWbGvQvKxhzTt2Mo4tTARlCCX7R4h+2MYGtxZd8bc0Odf5QV14=
X-Google-Smtp-Source: AGHT+IGObMKYKebWyi2vlH3V4ZR6m30UgEgbD+vIebO/3cTs2tz/j5VncJ6I46b5ymuyR7IcVMTvglSTLvfnBgzls4M=
X-Received: by 2002:a05:6214:490:b0:6d8:e5f4:b972 with SMTP id
 6a1803df08f44-6e1b2159553mr27315446d6.3.1737151292196; Fri, 17 Jan 2025
 14:01:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z3qNUizvHJLgMx1y@ArchLinux> <Z3qN6C2IpQTdVn_S@ArchLinux>
 <CAOLa=ZQ-cRJeWjP-_6N2v4GS5P7oYVUyb9_tbY26W7MAJfJ6ZQ@mail.gmail.com> <Z4pijwANZWAP2XKH@ArchLinux>
In-Reply-To: <Z4pijwANZWAP2XKH@ArchLinux>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 17 Jan 2025 17:01:21 -0500
X-Gm-Features: AbW1kvbVSeWTLo79JKjSxZWSogXM8tPPjk5LKvNBULYE1cB6ULr3QdqL1V1upD0
Message-ID: <CAPig+cRsAPp1APNJ7W337UNtunETr+Lnn-RcGrAXEFUhN1APyA@mail.gmail.com>
Subject: Re: [PATCH 03/10] packed-backend: check whether the "packed-refs" is regular
To: shejialuo <shejialuo@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 8:59=E2=80=AFAM shejialuo <shejialuo@gmail.com> wro=
te:
> On Tue, Jan 07, 2025 at 08:33:56AM -0800, Karthik Nayak wrote:
> > shejialuo <shejialuo@gmail.com> writes:
> > > +test_expect_success SYMLINKS 'the filetype of packed-refs should be =
checked' '
> > > +   test_when_finished "rm -rf repo" &&
> > > +   git init repo &&
> > > +   cd repo &&
> >
> > This should be in a subshell, so that at the end we can actually remove
> > the repo. This seems to be applicable to most of the other tests in thi=
s
> > file too. Perhaps, we should clean it up as a precursor commit to this
> > series?
>
> I have searched the usage of "test_when_finished", and I don't know why
> we need to use subshell. Could you please explain this further here.

Karthik may have been thinking about operating systems, such as
Microsoft Windows, which won't allow a directory to be deleted if that
directory is in use. In this case, because the test cd's into "repo"
and never cd's elsewhere, the directory is still in use when
test_when_finished() tries to delete "repo".

However, there is an even more important reason to use a subshell, and
that is because a subshell ensures that the current working directory
is effectively restored to the path which was current before the cd
command. This is important since it guarantees that subsequent tests
will be run in the correct directory even if the preceding test bombed
out part way through. For example:

    test_expect_success 'foo' '
        git init repo &&
        cd repo &&
        ...some more commands... &&
        cd ..
    '

If one of the commands in "...some more commands..." fails, then the
`cd ..` will never be reached, and the current working directory will
remain "repo" rather than reverting to the path prior to the cd
command. Thus, any tests which follow this one in the script will end
up running in the wrong directory. The proper way to protect against
this is:

    test_expect_success 'foo' '
        git init repo &&
        (
            cd repo &&
            ...some more commands...
        )
    '

Exiting the subshell will correctly restore the current working
directory to the original path _regardless_ of whether the test
succeeds or fails somewhere in "...some more commands...". Using a
subshell also means that you don't have to manually restore the
working directory via `cd ..` or similar.
