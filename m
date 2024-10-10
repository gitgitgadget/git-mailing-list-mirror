Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE428F6A
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 21:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728595822; cv=none; b=O4bGeB0RSb3ictfCBOSlzNA2VxpWaLnv6KOyuAUHpz0iwXPgkIW67n7y4/9kzIdXaIxIWlpbETD5atxDPz61Jm+O4PXuanTjCoE53jjlrySU2yMQGlI9AEs6zmMEQnlbPQ8gSMWJmqusW/Ex6x2Tk48cbYLgL35WNfj3aZ4v3J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728595822; c=relaxed/simple;
	bh=JlsQB2mxv+82kXeFoHuvzMHZyVlQpivP34Gq/9haIsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWJWW4B5LEi++EQ90RiN9oFkWrjpqcsFZ8Sm6zd2waoGti3iW1Eiz4prC58EkufaebUqCIKcSoZKd0jmQ1sCEu7iqhy5uaHXD+2YFp4bjbZNa/mwDIfa8y3NjqGEcks4wFjRWOYxWIG1wrLxEtjBkHvwbYKucL2PMtCjvLjwcgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e291831f421so211312276.0
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 14:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728595820; x=1729200620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64DYH7itZwA5JxTiQM5pyn2ULBgwYnT0pHTxabzMu3I=;
        b=odWjdnrF9vLM2LkcEGOXkFMTSEcZU2G1myNkSRws1uTaFwNbXEUaD0xBnMObG8NenI
         9EsxJgjPgVLQGROstHYuFt5khIYTe0GmFdacN0XrstVzUaQaoFO6v7Xr5O19LOkGFeWR
         Heat7Lf7bLI3tHSK07/PRM4nS5+uqDk//eLLchDvw+zm3YmivMc/K9o9wAPjOlkV/iE5
         dkAIgfRtr+ZKArpQLQErglCEOUf2pNkrvxVM0nyWpEW2fYYNq2P9d7tU103qPLAc68tR
         lCibdYanGubDfanu6g/95zjTNzoZtfjBpheVNINqVS239DtZMAclfY7Gc7Fqd7vh9aZL
         0ZAQ==
X-Gm-Message-State: AOJu0YwVUP2VVecGJcwbuDFMpAc693YAt25PlED62ZgATSEdIEf65Vue
	YE+FBYBiRCHN6dK5grfOkaDXpSW3vRrAgiQHJIDaBsJxidnuVoPBDlhptXYNlRRTqc9zjyGsz/X
	2tD7wHegBdqOIdnDkBMkzt50obk0=
X-Google-Smtp-Source: AGHT+IGnaaj1mkxZTYOZj1K+jC6mk6lBzBKUYl5iOMCL+VL8GoBqTSCGADUqF2Fs6l1iOgpSOMq0OdM+Ub+XXrcPmII=
X-Received: by 2002:a05:6902:2b89:b0:e29:2a3:72d0 with SMTP id
 3f1490d57ef6-e2919d5ee49mr397921276.2.1728595820295; Thu, 10 Oct 2024
 14:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOO-Oz0NUA-YeyFT1MJ=XKyLWJvQoFH1b-F0EFOzvy8iWka3KA@mail.gmail.com>
 <ZwhF0OZ2gpLWUfHD@tapette.crustytoothpaste.net>
In-Reply-To: <ZwhF0OZ2gpLWUfHD@tapette.crustytoothpaste.net>
From: =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Date: Thu, 10 Oct 2024 17:30:04 -0400
Message-ID: <CAOO-Oz1KhFcyErVx1Qb142PtPJS=UpgSD-FacckqNS4_okAtFQ@mail.gmail.com>
Subject: Re: minimum curl version effectively changed
To: "brian m. carlson" <sandals@crustytoothpaste.net>, =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have a patch I plan to send in tomorrow that will properly
conditionalize using the symbol on versions of curl that have it, and
emitting a warning otherwise. It will also follow up with some
corrections to errors in git-curl-compat.h.

I don't think a new feature should unilaterally change the minimum
requirements of git without some announcement and forethought.

-Alejandro

On Thu, Oct 10, 2024 at 5:23=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2024-10-10 at 18:24:52, Alejandro R. Sede=C3=B1o wrote:
> > As of ad9bb6dfe6e598d87ffe6e2285b4b86dac3bc726, http.c depends on
> > symbols introduced curl 7.37.0, which is newer than the documented
> > minimum version of 7.21.3 in INSTALL.
> >
> > ```
> > In file included from /usr/include/curl/curl.h:2238:0,
> >                  from git-curl-compat.h:3,
> >                  from http.c:4:
> > http.c: In function =E2=80=98set_proxyauth_name_password=E2=80=99:
> > http.c:655:28: error: =E2=80=98CURLOPT_PROXYHEADER=E2=80=99 undeclared =
(first use in
> > this function)
> >    curl_easy_setopt(result, CURLOPT_PROXYHEADER,
> >                             ^
> > http.c:655:28: note: each undeclared identifier is reported only once
> > for each function it appears in
> > make: *** [http.o] Error 1
> > ```
>
> From the curl changelog, I do agree that that feature was added in
> 7.37.0.  I think that's okay, since that was released in May 2014, over
> a decade ago, so we probably need to update INSTALL appropriately.  I
> don't think any major Linux distros are still offering complementary
> security support for such an old version of libcurl, so I don't see us
> restoring support for older libcurl.
>
> It will probably also involve ripping out appropriate parts of
> `git-curl-compat.h` and the option flags. If nobody else gets to it over
> the next couple of days, I'll try to, but of course anyone is free to
> send in a patch.
> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA
