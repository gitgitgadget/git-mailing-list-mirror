Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E72C8CE
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 02:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720838116; cv=none; b=FB2NlIjq2IUxdvtdaadq9TW0QCbwYbqnZ2xnP3FsmhkMgjKWmunm5aJkowvAdskcGbbRl5IjxGdEiASo7JEMYjOPEFFQrr+qPq4HCymSovbEKHRCfencMZPnRJmsHadV0eXjCVTp77Dvj+zevrndOvUU7kT6VBJqewXALG8DRDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720838116; c=relaxed/simple;
	bh=MiBDxhLjjmXGgC6kRcHQuhUbAceXIXKZmXH9PWtckMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+PGjkrw8Q/7c9C7reap7NeHAa2qF0xS/mrRrrbPkSQQ3eIEHD1OCItcpvPYv68AchYxVdHmtKBj9CxZS233RdHmIBG+h7uSLIr7nTVfR19aunWNcTzvyKuPHvpNSYwoVuBreQ7S6WZ0tP8FfmNunzeeiTYHvJgKy/DozlU0qHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NumVLf5U; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NumVLf5U"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6561850a7bcso25247077b3.3
        for <git@vger.kernel.org>; Fri, 12 Jul 2024 19:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720838114; x=1721442914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGXufq3M/NGBWzj3FVgulnxLblBgq/VcCoEfVnW5w8U=;
        b=NumVLf5UqqmVw1QhAnO3KlHwrqWqBRu/QEF0rHxNzrhqeur9kgvlSDgeQM6EbNGiz+
         WFKaHoJpJSb/2y3B1qMY39bex04HU1Y9A8cjKjwmBDsXtASEWqAAfUg9DuMOMmkzFaWv
         h9GlFHzXMOeKx63TRdZVC8Of6dWGMdlL21mBY1zQj4WkrRGi8VyWOyySf6x6g0SC80x8
         kv+r09j2lH9TDmf+QH6Z4s3kPyEJ19731JyYYC+3qgZXm4nXTaNozrISdAzVk3l3lZ+w
         b8K/YEspM87gREAfPc5mmbKSZinx7q+7UNQt+Cy0AMNYFiM84Qs7XhlaIoA4quJi2S3a
         Wp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720838114; x=1721442914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGXufq3M/NGBWzj3FVgulnxLblBgq/VcCoEfVnW5w8U=;
        b=ChWLuLbFzm4NPtfd30q+tnsMf/JmWguc9Vxb//Bcz5kh3Jch5TbbohNYOoOY5HVqlv
         Dx23QMnfKfxUfJZmb9Vrn2jX+dyc3FYEFShXXD3rj9TDcHtGDuDV0u6pUUfee46DfA6p
         NaDPERI15bgq8B0g8TnAcs7fgc38hwARkMZChGBIhY2k8e579iKlMVPhZWSARhNCS642
         9pS/iw7NsTm55NhTcSTn9/kLkwa+gCugC4Yvd2y+e3JFwPJRwpJPkph4mV1eRB39JCR6
         JzBh/HzJZ2Mo/0EbX5dhpF0yaPS8tdM+iz+SIEgF6v/YnQpnwRIeyLIS6VrLH2w5yoIh
         m31A==
X-Forwarded-Encrypted: i=1; AJvYcCWKkdi+owJVb3OHcaV8BjAKFZsxBSoi9c4Y17bdjc4BdRT3UJZFDESw9E3eNcHcW3k+YOMU1Q18MakyjN2mdzdy7lfk
X-Gm-Message-State: AOJu0Yw30xrmXoNqNwIE/+nAzEN+Ne0WGyVW0aFt376zgsyrtY1yd+8h
	QvPERxaGXQS7XzXx7DfP49fINUQekfEERRcUL1Hq/XoprKiovWRm3IC9ZN+ipuBGkebt7KR7Phv
	2wuuVUBTMwJVoIpMW42oJZmzXgVY=
X-Google-Smtp-Source: AGHT+IGCAE/gATw/FDSHBbep1X/LFmGvDap8OaS/j0vRlrQEvtxAdJzec24FqQH25gry2h0UoZWjxlKZ1g0ygSlD+rY=
X-Received: by 2002:a81:5cc3:0:b0:653:ffe7:d62f with SMTP id
 00721157ae682-658eed60aa0mr133252997b3.20.1720838113867; Fri, 12 Jul 2024
 19:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240628190503.67389-7-eric.peijian@gmail.com> <87h6czqblk.fsf@iotcl.com>
In-Reply-To: <87h6czqblk.fsf@iotcl.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Fri, 12 Jul 2024 22:35:03 -0400
Message-ID: <CAN2LT1CEy34qNT4RUcQvBNskcdY_wVjBNqCVP70UpWShK+oOpA@mail.gmail.com>
Subject: Re: [PATCH 6/6] cat-file: add remote-object-info to batch-command
To: Toon claes <toon@iotcl.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, Calvin Wan <calvinwan@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 3:16=E2=80=AFAM Toon claes <toon@iotcl.com> wrote:
>
> Eric Ju <eric.peijian@gmail.com> writes:
>
> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index 72a78cdc8c..34958a1747 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > ...
> > +static int get_remote_info(struct batch_options *opt, int argc, const =
char **argv)
> > +{
> > +     int retval =3D 0;
> > +     struct remote *remote =3D NULL;
> > +     struct object_id oid;
> > +     struct string_list object_info_options =3D STRING_LIST_INIT_NODUP=
;
> > +     static struct transport *gtransport;
> > +
> > +     /*
> > +      * Change the format to "%(objectname) %(objectsize)" when
> > +      * remote-object-info command is used. Once we start supporting o=
bjecttype
> > +      * the default format should change to DEFAULT_FORMAT
> > +     */
>
> I believe this comment has become outdated, or got moved around
> incorrectly.
>

Thank you Toon. Sorry, I didn't get it. This comment is not outdated.
It is before this code
    if (!opt->format) {
        opt->format =3D "%(objectname) %(objectsize)";
    }

And this is related to my 2nd open question in the cover letter

    2. Right now, only the size is supported. If the batch command format
        contains objectsize:disk or deltabase, it will die. The question
        is about objecttype. In the current implementation, it will die too=
.
        But dying on objecttype breaks the default format. We have changed =
the
        default format to %(objectname) %(objectsize) when
remote-object-info is used.
        Any suggestions on this approach?

> > diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-=
remote-object-info.sh
> > new file mode 100755
> > index 0000000000..7a7bdfeb91
> > --- /dev/null
> > +++ b/t/t1017-cat-file-remote-object-info.sh
> > ...
> > +stop_git_daemon
> > +
> > +# Test --batch-command remote-object-info with 'http://' transport
> > +
> > +. "$TEST_DIRECTORY"/lib-httpd.sh
> > +start_httpd
>
> start_httpd skips the remainder of the tests if it fails to start the
> httpd server. That's why I see various other tests which have this at
> the end:
>
>   # DO NOT add non-httpd-specific tests here, because the last part of th=
is
>   # test script is only executed when httpd is available and enabled.
>
> So I would suggest to add this comment as well, and move the file://
> tests above start_httpd.
>

Thank you. Fixing it in V2


> --
> Toon
