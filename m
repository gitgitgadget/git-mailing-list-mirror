Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13698283FC3
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980823; cv=none; b=sAzG42XSuRHCrrvDQd/lxJmd5YwA6+ivoZ7RpDYEjpZE2G6A4ZarfB2Y3ewvZCiLjK2O5xL2NmXgZnEJ64rNvdIHLpr8yBmc/IZHmP7cf/MRs2qk0C4kL6Qtuu+GSDiTz/Y1RdXDMTQuyXwn/EpPz5+oQPCSV5Aun/fuvh9Wb+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980823; c=relaxed/simple;
	bh=WSs6NvFAQIU4c6FTX7Pwg7B5Vb08LuQDucsyo9Ob7lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvhXnsBgeXQahRVf777rXU5OUeeJsCB6mT0J2p3h7wcwKYp99L4qn3vLmkdijSw0g1kvIggxcItZpNQ/KE0tZvuTu9brqUzNQynb7nCNz5VyV75cIGwUCWhaDNWCvIiDkKQJKRE5Nry5rVCxmJqZeUXsVGEnUqoh/JwXZEK2ecA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcUZ0nPM; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcUZ0nPM"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b07d4d24d09so793400966b.2
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 10:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760980820; x=1761585620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7usrbrNFm+QsZW/uZLe8N9sXzG5XEv/CP93gr/pNyr0=;
        b=EcUZ0nPMVF0eFGfVI9lifPpQRY1kkZmqncLntLCKX4EUqUK/9mR3GpFOV7jMiZItOT
         DGpv8VSrx19bICgV8V1XaizM+A8ZXn/VnXHklH5lZSj6p7LaAJl3Bzd136/ntHzvL1PH
         e5OWsT96DM1JBLbM0UCBB9h7wBo1j5yVfnIrdHIOR/yVzYXlPeov8VXa6HPGBYDCcW7G
         LR89KOj/oDegiNWKHKbyxyIhPdF3kFOKc7dqMzfjyxGI60gre0oHqv8NKznhJReEg9O+
         p/luPLdQaSLCICe8yQmfdvBunOubfoas4UZvc1/Qp1f2R0yx5j1/3aBZCCjwYk2YK0uh
         hXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760980820; x=1761585620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7usrbrNFm+QsZW/uZLe8N9sXzG5XEv/CP93gr/pNyr0=;
        b=JqfwGeR0Cy9XUVGsxqU6YuGtpWCafSLVuO9ODOZClvOiswcs+N1Vuo8/qvIYf7LfhY
         GWe+8onSn0dgjYbIrR9ULoAPyNOUhYXKG5LKZe31NK5ALccZWVykeB2GFd/nxkJIcOJW
         1XNUM529NulbgcW1BprZjYq3dBYt8X3xUntIEEnv+ZOY7Za+e5shvg2BawkmXlPENPLS
         DL/WKG1fkBh7ndYVqcOmmCd9+W075SBd2PsAWNnJg+ibwC9Cl8W6/czSI8BWsC+V9ovT
         iDyYXzDn0B1UhTcwW9OPUpdaH1diPpq7wfSCSb3Kb73vJ5gAkAzAM8rI3VphC3XCLEej
         92ng==
X-Forwarded-Encrypted: i=1; AJvYcCVpEhzpiro02VmLg2uwiDQ63VPAHRIl/4yWzM/B9gbklKHJpgMGdEuASE9SjsJMU62P2lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVVLAL4yz+u4OEZaf4zyNe6JzT46Ep7yL5le0bQwW+8e5YcMj9
	283sq219VwRQ1kSby60X4EEaetmdC5v2YLQAQSDRBVpiz7E/RWgZG1l5wY6EESmR0vQYRUoociZ
	oDwgLusZTD+Mm8GvhLLfVvs4G5C17zQo=
X-Gm-Gg: ASbGnctPeSwAgGcMdFfxbVAlNrgLn2AA5XlzONv8vhHkwunXAbK7BNkw8Y8Oqul5J2e
	oTzveCunmj4tS8ejj4b8pkfz7B0R23BZEfgYCpocqj69GMpdO9cOFXKgRnE6ByxnIA0RmJNISH+
	6s4CkMwL60yc85NsEgaFbzrra5Poi77tK96TGHgHrlq5gbwvPbKB9a/mU+N+ckEEsuHBFKqVF5/
	7P6fdDp7EWYABziqqy/dJGuKCIzETXjm5NU9GnF7mZFgrJNcZWHesy3ZzE8q7PtdGOsNiT4+8b5
	4vp3uKWaZ2zm4Mxnd2OU7hjyb/oKgeBmtaNsSNwTXZbULV6n54J3BZ+gnCn6UwJPCZGH1DVOdJs
	0dljXmF44HSORhw==
X-Google-Smtp-Source: AGHT+IHVclr3I6wCcfGhQlG1DtekWXEO9xycVyBrlJOV5cjqj9fYIIWScFjJTDdiwk72Z4Z2mOLAJGqQc20e3H+O5cw=
X-Received: by 2002:a17:907:fd18:b0:b4c:137d:89bb with SMTP id
 a640c23a62f3a-b6473734268mr1502970766b.29.1760980818441; Mon, 20 Oct 2025
 10:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPapNH0C3+bU-RUO6oFHUKLjKuNdm-aXgsFTHFobYVrJXWzr=g@mail.gmail.com>
 <xmqqsefhxlmd.fsf@gitster.g> <0de410fa-22ef-4495-a6a9-dcd33a329201@virtuell-zuhause.de>
 <aPLkuPgirAVHkERr@fruit.crustytoothpaste.net> <0ef23314ca63d03467a50a93d2db1db3ad950ede.camel@virtuell-zuhause.de>
In-Reply-To: <0ef23314ca63d03467a50a93d2db1db3ad950ede.camel@virtuell-zuhause.de>
From: El_Hoy <eloyesp@gmail.com>
Date: Mon, 20 Oct 2025 14:20:06 -0300
X-Gm-Features: AS18NWB8pe_ZQoATO8hTHdbiwze4_QcTIwoRpQwiMQa0srvgrN60VT9sw29xk20
Message-ID: <CAPapNH2UeRoKF9Tm5my59MXCxUQqEp+=4wzod8kYus_FQALwjQ@mail.gmail.com>
Subject: Re: Making git grep ignore binary the default
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok, so if I understand correctly:

1. changing the default grep behaviour is not acceptable because it might
break existing scripts.
2. Adding a config option might break a shared script on specific computers
but that seems more reasonable.
3. There may be better ways to implement the setting that allow more
flexibility.

Regarding point 1, I thought about this as a possible idea for a distant fu=
ture
with proper warnings, because I think this is a better default, but if
the cost of
making such a change is too big, we can omit this. If someone wants to come
back to this, it might make sense to "grep" public code and check how much
code would be affected to have more clarity about the costs.

On point 2, as Thomas points, there are many factors that might break a scr=
ipt
that rely on 'git grep' directly for a dangerous task, this makes me
think that we
could add a `--porcelain` option to `git grep` to be used on scripts
and be reliable,
and it might ignore the config.

On point 3, the configuration could be made with more flexibility in
mind, making
it possible to ignore different files that are not binary (for example
linguist-generated
files). The downside of that approach is that it requires more
configuration, while
a single boolean for skipping binaries might be simpler. I'm ok with
any approach.

That said, it seems important to add a flag to negate that setting for
a single run, so
if I have the setting to skip from grep some files, there should be a
way to run grep on
all the files, ignoring this setting, as it is also needed from time to tim=
e.

Regards.


---  Eloy

On Mon, Oct 20, 2025 at 12:24=E2=80=AFPM Thomas Braun
<thomas.braun@virtuell-zuhause.de> wrote:
>
> Am Samstag, dem 18.10.2025 um 00:52 +0000 schrieb brian m. carlson:
> > On 2025-10-17 at 23:29:22, Thomas Braun wrote:
> > > Am 17.10.2025 um 23:29 schrieb Junio C Hamano:
> > > > Simply because we have never needed to do something similar to "-
> > > > a"
> > > > and "-I" that we added in early 2006 for the past nearly 20
> > > > years.
> > > > Also because GNU does not have any such thing to force "-a" or "-
> > > > I"
> > > > as default.  The biggest reason is that it would be surprising if
> > > > such a change does not break existing scripts that have been
> > > > written
> > > > by people over the years.
> > >
> > > And if we only would have the config option "grep.ignoreBinary"
> > > defaulting
> > > to false with no default change whatsoever? I always want to ignore
> > > binaries
> > > when grepping and find it a bit tedious that I have to spell it out
> > > all over
> > > again. And yes I do have an alias as well but usually don't
> > > remember to use
> > > it.
> >
> > As Junio said, this could break existing scripts.  If I write a
> > command which uses `git grep` and expects to find all matching files,
> > it would not work on your system with `grep.ignoreBinary` set to
> > true.
> >
> > For instance, if I am working on a project for a company and must
> > exclude source code with a certain vendor's copyright (because we
> > don't have permission to distribute their code), then it would be
> > very bad if I accidentally distributed that company's binary files
> > due to `git grep -l PATTERN | xargs rm -f` not matching them since it
> > would violate the license.
> >
> > This is just an example, but there are lots of cases where people do
> > really want to search every file.
>
> I understand your use case. But if you don't control the environment
> (git config settings among others) your task of finding things reliably
> will just very easily break.
>
> Also in your use case, I either opted in to ignoring binary files, so I
> should be wary of scripts assuming binary files are searched or I did
> not and then nothing changes.
>
> > > I'm also curious what people are looking for in binary files with
> > > git grep.
> >
> > It's common to mark PDFs or PostScript files as binary because they
> > often contain embedded binary fonts, but they are actually mostly
> > text
> > and can be usefully searched with grep.  For instance, I once created
> > some awards for a non-profit based on combining standalone text-based
> > PostScript code along with output from groff, so those independent
> > pieces could end up being source that you might store in Git and
> > search,
> > even if many configurations would use `*.ps -text` in a system
> > gitattributes file.
> >
> > Sometimes you also have images or such for a website, which contain
> > XMP metadata (a form of XML-serialized RDF).  Finding those images
> > which have certain author metadata or a certain license URL embedded
> > in them could be valuable.
>
> Thanks for the examples.
>
> The previous discussion dug up by Junio and Peff was an interesting
> read. But from my understanding adding a git attribute like grep, which
> allows to ignore "uninteresting" files for grep, does not solve your
> backward compatibility concerns. Changing that looks easier now to be
> done in 2012 comared to 2025 ;)
