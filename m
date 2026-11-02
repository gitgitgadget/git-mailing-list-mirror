Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793628977;
	b=uTZB5ITV0OgrAlGAnbez6GF8MRPyI5UcAaCkUY/EEsN95Yf0lCnx6TJGvcR8NT1DyrCE
	 tTJu65/w0VX8eXIQQ5eFaF0ZN8ejXY0Te2F6UgRXUZZX0QTWGCe1e/ux/Ue9lV8kF+Iuy
	 aPNh2JKwUhxNAZQ0sZi148tATSX3KJjajtbjoPTAtpyQeoRwEOZIBJG7BPukv/Rn1OcQe
	 KO37cEgok++j7cLcc4TATvSoMlbATSE9E7KMXcr61orDIGTTAPaP2FkN656E2OD5TVq4W
	 xCg+JeEG90M8BWwi5S6wxipElQeOWLG1qxK+YZAg+MSvNkBtjCiH/gPxMu1PnePEMeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=wkBV2j78Fo/8eXWQjykaW3rF9RKT5B6Okz4Lp+YUVpQ=;
	b=ZFhtHco8dT3FeyYS61lhSZxFm3GpAJfQryoWG1R96f07rsEPrEqEFENu95vhly7CS+eI
	 UQJ/ee0Xl0H205xKMTsR/VoUAsXk4F/rxJ/esBH/Z34cGGMQ9Z++Uh9Gqsyfs2qy3rm3F
	 XmMmbMtPcIGbEwbzYrJ6spatPnR8BjcnVHXuUrAmxCTv9FL1sg36ehHD3Zd421+brlw0a
	 ez7kyW5xlxt6f6w3OHh5QqHelDFrKJfaqu2VONQdHUHbD4crc0Vc92Z0Mlrhv+UwPv9yL
	 PCTNjxoxC8KJ5nD2HaNgWCDLqBxfQx93hLEOVBBMv2rGsMS+tocSB26PvOPDyVPzoyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B4kK0EfB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123C6606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 14:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 123C6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B4kK0EfB
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5e948e56af3so968261e0c.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 06:16:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793628976; cv=none;
        d=google.com; s=arc-20260327;
        b=lMTVVIPi46KTft4FqvzTh0SScgkgotTKLEncYCA8XEWSa9aBRQWov9Lh+D5lUItH+R
         ruaJ5hKI/YjNbeTPMVPpr+ed10kSQMazJxz5JRZC47M5VXKu7dbcH4049tlkUzeeQ39o
         mvj9bwQi+4skAmGg14p2TTx+DyY+6q89V3EEUal+YKa7nnUjDSdJ32LlNsITyZE7nZwH
         aREdLroOxJR/PeqkpVWMnu/Rk0Lfe9i3JT3ziDRc7nF2KgeM86pkj/DqVhMIM89h2TGM
         zXvW0acM4u5WLgsa6D0G2kFOaMVqB7iIyvu8kpK0361hY/e0DTzAfi4OBG0wsmPUNSRj
         be2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wkBV2j78Fo/8eXWQjykaW3rF9RKT5B6Okz4Lp+YUVpQ=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=nMeEsAQK8KNfHViss2bPLLHWaxycOvQKPpdjTdUshigfTB3ck+V5HEaY43+ADJd3oS
         Dr9rM0de/0CkoqSUS1YRRyX4BIxh6R9awfXmbQl8h967BUX4lbUAIfbX46EbKMsU9KcW
         MgjoRRsMaxuinh+4gHbIztdd+Z8pOm54pyvr7RkvUBUqwJvQym113Q4ogkdRLbDmS5tw
         qUDS1uo/IktztYt+LUbV7dhVZ1VnhbGyyxOJkIwiiFU/nbXwdIKm4X7kxddoR/ScF48E
         iwlqjW06oamoOrJY7N32KF3ZOJY9Egqf2h+8L+6qH/JU4jB889fhfxNRwbqDcrZ6t+Bd
         qZNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793628976; x=1794233776; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wkBV2j78Fo/8eXWQjykaW3rF9RKT5B6Okz4Lp+YUVpQ=;
        b=B4kK0EfBplIy/3bUibLDHALaItiWT0Ns3x/bhZrL2coSBH6pM++X3mLixrXwXpb35c
         o6nl3VHFJjP2a77n8XpF+sZ1Yo3kf5ilCQVh+MYQXgphF5leQtnfl5rHVVugjk3G/rUw
         nBlnuQO12m5krcHVdLFp7sBKqQxG8NaUsf4ew4CAwNZKVAC0BEGdoO2Gu2VqA0u4kjNU
         /rJwCJOPj4eBtbVhELLXyKieaOc5MHf3XN7oTHTK/3V5bBOYVHvOJ56wuuBAfhS96V0O
         lwIloL/+GyM3N8lIebkKsdSA3jlb6dFoCWCujPitdqw1SBf2l6B9wayXXCP2CfUXDmyM
         pQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793628976; x=1794233776;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wkBV2j78Fo/8eXWQjykaW3rF9RKT5B6Okz4Lp+YUVpQ=;
        b=a96rjdxnsYCHXJ99+3wroN6jhT7lWsVtJLqyc6pXI65byJglEj8nhQ0tVrWL8j/CQg
         5yEOFX4MMAKjQ4D7XZVscNabYSXE38p+h2OtIX8w7HGsDlzbvgpl4jbKf69VFP5fQ24E
         mnKIg9iByh5iGp2qxxtHxY6jBNxgUphYpGuyH1rrhTFg5Tsr5agfsiO4CaNVsXwkBrU7
         8gJ0VGZQpIMdQQ3OAJeNU2ENkX8r7u9FeQfAmKHDit1GuYxdoG8bPUOBunFwwldtvq7G
         xjx32YGhZOzrbhv+lOsZqA4s4v1puVeRZTewTxZpVa05CoLFqtvKXVRrYPztbzV5NP1e
         vYlQ==
X-Gm-Message-State: APuU4Z8NoGahb4ZKyR8mW2pN6DA7bK1nU0wpTSa8EzzSVepZT1H80ewX
	lOiw+5etURD99rgGwCuQVxSI7iBKNlJz+dO+DOeHe9gxLJ9U45Cs58JoTr1fWFJ7Qbkzd5VKKjb
	vX318rSJiGogC8NrCNeG3dgiphboARRQ=
X-Gm-Gg: AYBFou1doB8sm1SYwKefaKxrLyKlt/ZwERtLXSYwL4Jl2lLziadVku8oLzieBDIAy83
	30Pf8QIseC8h/KqqNsNGYdLqip6xiRCHLB7DAR0ri61YGt9Pa5Zh+hBanLZ7J1r4cDahzKKL4ji
	KUPrX/0Em3Eh4EGIZqRoC2YgVabJNVRW1x46bXDZ3i79+oWzUHtvi63LtiX6ozYb25tnPbibzXC
	jcKF/mVh8q5SfIju9Hj+th2ipGo+sYS8id7zUoom00W/RC4h5LirXIT6BZ2MZcBi+vi2ohL8xt9
	n/HA5oICM7HK2vkhV+ojUxGfV6/eduwI2PntcYD0Y+rnpy4SsgFLYhUkWkPulgXQiaF3M1qGm5V
	b2o9D/qzqajf7HKQ0362c0r4vOS44/nsLQSDY9/TaeFRQsCskeRi4kdEy0a2oFU542PK2LApC3m
	CoAswQBRqle4MPZm5niZxGu30jq3D3Py5D+R+f62ickzTm7YmWCLdDhXoDbCRL/S/CYQZumA==
X-Received: by 2002:a05:6122:3a18:b0:5c9:c60a:e9b6 with SMTP id
 71dfb90a1353d-5ec689be615mr4039942e0c.22.1793628975878; Mon, 02 Nov 2026
 06:16:15 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029203904.432-1-edsonwasswa54@gmail.com> <20261101192502.1920-1-edsonwasswa54@gmail.com>
 <xmqq8q3blfh1.fsf@gitster.g>
In-Reply-To: <xmqq8q3blfh1.fsf@gitster.g>
From: Wasswa Edson <edsonwasswa54@gmail.com>
Date: Mon, 2 Nov 2026 17:16:03 +0300
X-Gm-Features: AclHuK-H1aH98OpSyRfa1wcrQ1n-EN9QiHo0Twhrf1xDcZmJp5uTjm022jcytmA
Message-ID: <CA+ew3JuD_FKhpw=pUT+p-r2750A0qyKTbTXZvxxvvNovjxLgyw@mail.gmail.com>
Subject: Re: [PATCH v6] builtin/diff-files: convert ad hoc option parsing to
 parse-options API
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

Thanks for the review. You make a good point about the value trade-off
for a plumbing command - the loss of COMMON_DIFF_OPTIONS_HELP in the
help output isn't worth the benefits parse-options would bring i had
not seen that coming ......lol.

I'll drop this patch and look for a better target to work on.

Thanks for the guidance.

Best regards,
Wasswa Edson

On Mon, 2 Nov 2026 at 13:01, Junio C Hamano <gitster@pobox.com> wrote:
>
> Edson <edsonwasswa54@gmail.com> writes:
>
> > -static const char diff_files_usage[] =
> > -"git diff-files [-q] [-0 | -1 | -2 | -3 | -c | --cc] [<common-diff-options>] [<path>...]"
> > -"\n"
> > -COMMON_DIFF_OPTIONS_HELP;
> > +static const char * const diff_files_usage[] = {
> > +     "git diff-files [-q] [-0 | -1 | -2 | -3 | -c | --cc] [<common-diff-options>] [<path>...]",
> > +     NULL
> > +};
>
> The loss of COMMON_DIFF_OPTIONS_HELP here gives us a regression in
> the help output ("git diff-files -h").  By replacing the single string
> with a string array and passing it to parse_options() or
> show_usage_with_options_if_asked(), the COMMON_DIFF_OPTIONS_HELP
> macro is omitted.
>
> Since parse_options() or show_usage_with_options_if_asked() only
> knows about the options explicitly defined in the diff_files_options[]
> array (leaving standard diff options to be parsed by
> setup_revisions()), the common diff options (like -p, --stat, and -z)
> will no longer be documented when the user runs "git diff-files -h".
>
> You probably could shove COMMON_DIFF_OPTIONS_HELP into OPT_GROUP()
> or something that produces static text in the help output to avoid
> the regression if you really wanted to, but given that "diff-files"
> is plumbing meant for use by scripts, I am not sure how much value
> we get by rewriting its command-line parsing.  Being able to say
> "git diff-files --bas" and get it understood as "--base" is
> something we may appreciate if it were a Porcelain command, but is
> it worth the hassle for a plumbing?  I have to wonder.
>
> Especially when the parsing loop the patch wants to replace ...
>
> >       argc = setup_revisions(argc, argv, &rev, NULL);
> > -     while (1 < argc && argv[1][0] == '-') {
> > -             if (!strcmp(argv[1], "--base"))
> > -                     rev.max_count = 1;
> > -             else if (!strcmp(argv[1], "--ours"))
> > -                     rev.max_count = 2;
> > -             else if (!strcmp(argv[1], "--theirs"))
> > -                     rev.max_count = 3;
> > -             else if (!strcmp(argv[1], "-q"))
> > -                     options |= DIFF_SILENT_ON_REMOVED;
> > -             else
> > -                     usage(diff_files_usage);
> > -             argv++; argc--;
> > -     }
>
> ... is not anything that is ugly or overly hard to understand.
>
> I dunno.
>
>
> > +     argc = parse_options(argc, argv, prefix, diff_files_options,
> > +                          diff_files_usage, 0);
> >       if (!rev.diffopt.output_format)
> >               rev.diffopt.output_format = DIFF_FORMAT_RAW;
> >       rev.diffopt.rotate_to_strict = 1;
> > @@ -73,7 +74,7 @@ int cmd_diff_files(int argc,
> >       if (rev.pending.nr ||
> >           rev.min_age != -1 || rev.max_age != -1 ||
> >           3 < rev.max_count)
> > -             usage(diff_files_usage);
> > +             usage_with_options(diff_files_usage, diff_files_options);
> >
> >       /*
> >        * "diff-files --base -p" should not combine merges because it
