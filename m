Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAC46D6EF
	for <git@vger.kernel.org>; Fri, 22 Dec 2023 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTkuSsie"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-35fc1a1b52bso7864425ab.2
        for <git@vger.kernel.org>; Fri, 22 Dec 2023 10:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703269657; x=1703874457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8WCtHlaeWnpoZpYnlI5VUa++/SUm2rbjhVRH7qV3WI=;
        b=GTkuSsiedvq//Omj4rM7gtOu03N9PgPNNKx+GkSI+IxWo2hfV/CbAHgGpi7IolTykH
         TwRGEPGkr1dSz0vBFbPRE5boYl6O/q1RlWBoh7wOMCMK03HftI1hgJ+PFuxMHQkTKCTn
         KWK+bySumckcuiSi3t3CfqirU5Op6T1I733C9x6rptBJsdhyqjSs3ilSd+1CRB+XYQyv
         i5tkEmOcSw8BBSKcxqFHJIUcgPowkcBd2pXmP5u8XQibHqgzGEaiFZVz7CKbJZKzNTe0
         w8FCFxyqTJM0q9YyAqWCuaCw7dAT8S7qknEhu+enktKVU+ppt94PrYNo5Eg9b0MiUf7X
         bA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703269657; x=1703874457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8WCtHlaeWnpoZpYnlI5VUa++/SUm2rbjhVRH7qV3WI=;
        b=DVG/WNUhj7gmV1dpJJIzoiGbOfHjB8SCE7hsSNH+mvk8XNvebYy5dW87ocvC/Egp+1
         kyrf+pJSKPgidhHvRDelel/gmlT/Rvy8NOgFGELPhpI/8gXFmkNP/07wgF8y1BcftdJO
         oXR7SR/xXXQmv0clhyMAKCPbZy7tivptsuo73bJiOTRYfAHlcNNrKMH961oq1heonL3l
         UUc9oLxrQgUrQ6MMAHOfFCFRcUCTr4+VFSosTPEpIdcmIjTHthJ5qy5Nrp26XgrVXOvT
         yC9vZdSX/Ow8KYgGQ6VcNV7Jn8fPlLZvZxz2Su2eNSapJEG5T9f8ijKuzmj75zYgJl7I
         3Fcw==
X-Gm-Message-State: AOJu0YwzhhzjFQsTDuDFDNjwCAhC+ZJH2X10b4D/poAwa8tV5kO770sM
	VAtZOzBeSMN8vHzo1hQr/3+ESICrC12T0A/g8f8=
X-Google-Smtp-Source: AGHT+IG2NmzeEPnQwa6TW9fS1jyt+PApySaFOmIvDxffwPgosm464P6W9QvK8gYWwOvxO9PNe0EdcxGzzXB8/IHSK2w=
X-Received: by 2002:a05:6e02:1aa6:b0:35f:ca3f:fa67 with SMTP id
 l6-20020a056e021aa600b0035fca3ffa67mr1786558ilv.43.1703269656666; Fri, 22 Dec
 2023 10:27:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1625.git.1703264469238.gitgitgadget@gmail.com> <20231222175747.GA2880@tb-raspi4>
In-Reply-To: <20231222175747.GA2880@tb-raspi4>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Fri, 22 Dec 2023 23:57:25 +0530
Message-ID: <CA+J6zkQ=+bCsi7URtpTfgawTrmVVALvMi3kdnMi=mUjB_Yxxwg@mail.gmail.com>
Subject: Re: [PATCH] sideband.c: replace int with size_t for clarity
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Chandra Pratap <chandrapratap376@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback, Torsten. I was working on improving the rest of
sideband.c as you suggested when I encountered this snippet on line 82:

while (0 < n && isspace(*src)) {
strbuf_addch(dest, *src);
src++;
n--;
}

Here, we are decreasing the value of an unsigned type to potentially below
0 which may lead to overflow and result in some nasty bug. In this case,
is it wise to continue with replacing 'int n' with 'size_t n' as the
NEEDSWORK tag suggests or should we improve upon the rest of the file
and revert 'size_t n' to 'int n' ?

On Fri, 22 Dec 2023 at 23:27, Torsten B=C3=B6gershausen <tboegi@web.de> wro=
te:
>
> On Fri, Dec 22, 2023 at 05:01:09PM +0000, Chandra Pratap via GitGitGadget=
 wrote:
> > From: Chandra Pratap <chandrapratap3519@gmail.com>
> >
> > Replace int with size_t for clarity and remove the
> > 'NEEDSWORK' tag associated with it.
> >
> > Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> > ---
> >     sideband.c: replace int with size_t for clarity
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1625%=
2FChand-ra%2Fdusra-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1625/Cha=
nd-ra/dusra-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1625
> >
> >  sideband.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/sideband.c b/sideband.c
> > index 6cbfd391c47..1599e408d1b 100644
> > --- a/sideband.c
> > +++ b/sideband.c
> > @@ -69,9 +69,8 @@ void list_config_color_sideband_slots(struct string_l=
ist *list, const char *pref
> >   * of the line. This should be called for a single line only, which is
> >   * passed as the first N characters of the SRC array.
> >   *
> > - * NEEDSWORK: use "size_t n" instead for clarity.
> >   */
> > -static void maybe_colorize_sideband(struct strbuf *dest, const char *s=
rc, int n)
> > +static void maybe_colorize_sideband(struct strbuf *dest, const char *s=
rc, size_t n)
> >  {
> >       int i;
> >
>
> Thanks for working on this.
> There is, however, more potential for improvements.
> First of all: the "int i" from above.
> Further down, we read
>         for (i =3D 0; i < ARRAY_SIZE(keywords); i++) {
>
> However, a size of an array can never be negative, so that
> an unsigned data type is a better choice than a signed.
> And, arrays can have more elements than an int can address,
> at least in theory.
> For a reader it makes more sense, to replace
> int i;
> with
> size_t i;
>
>
> And further down, there is another place for improvments:
>
>                 int len =3D strlen(p->keyword);
>                 if (n < len)
>                         continue;
>
> Even here, a strlen is never negative. And a size_t is the choice for len=
,
> since all "modern" implementations declare strlen() to return size_t
>
> Do you think that you can have a look at these changes ?
>
> I will be happy to do a review, and possibly other people as well.
