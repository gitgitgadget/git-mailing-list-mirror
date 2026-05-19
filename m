Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A961408006
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204307; cv=pass; b=uPZ10J4pSbpEN+pZjwIMM8tgBvItFg2aKpUmH4onrGRE+315uV2s06otKR1Yn7lwPwaYE37ikkXtBqM1Kp3Za2V487CamfYcuABUAr86Pc6G8GbZy8MauUozNPVsLiIDzSldCSaD0vDFuFxamMNzfHCkCYr4d7Cji0YRAdIjEVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204307; c=relaxed/simple;
	bh=N9E2gonCUfw5MsqwuxgPW/SaWxlFL05tGQMubleIGgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMQiEEk254R+xpb8HRmji2NduJjy/ocfI/LR1DcqBlZhP8cZunSV2Y2PpTnM/DQEYfebNfeUskiwnoC8oVFJOSjKAFCSkULcq5URxv56+dQMA4XizA3owZ9KvQTyEYrADkqiXJ8/GF2sLTReyBhhVmlKMrqG/uTlGLWNqwkLLQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+ra3jNs; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+ra3jNs"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c1a170a50so4555742c88.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:25:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779204305; cv=none;
        d=google.com; s=arc-20240605;
        b=dsZyVJBCbC43mRp7SHxA+ADw7R1GmZIIBumVnw1lF87LJx/doS71lp0cCA9UFXpqGm
         7WkGK9y4oJ8AhhAocyW2WPfJJUHM1JFxlJiA7FFr0Y5N0Mq0nJf6/A5wAEShYki2kZKA
         hIMXYshCoAdNY26U4boQLKz4mQnMTtV63dYpVNmAHtBJNqddLenCsL0VsDphBQmgkZ++
         uqBn2RlBeCmtnogKfrhCo0KHP9FQHaYhGsqV/13zIJtFvlcrqxHPrG9A2ypJg4VPqEvE
         Z1lY5acoY2sCteJH7msukH9Ttd5IYXtiqN+aUjq9UjrMm2cBy7YTuWtVg8n8YvViyw49
         1o1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iOsA0VWRYU6aIOd5RymTsOOHl3s1tuFsOicL1llg2kA=;
        fh=rnkYOd0g6i/l7E/y+/vhBWHmQUXTX4flLDwaef/8U0U=;
        b=Ua9vKqgR2hZq0mhD7rf6YSaV1ToTWmQUboCN+o8lLXkOU1xcumFO9bJMmpzkdhhv8P
         qNiUwtzoXpJgGSSreflMD/FGBaSggaBFhVyepTncPjJuY1QYfYvf9qduDlM584RfuYff
         A/G2Nwa56Uh1e5OBzUEm5V9YxCvsIzBO6gexr9hwtCe+9AKTX15ZRhpUJ3BjNc8LQPxT
         h70uzjmpeWBLlDz69ztqf6to+lkkkg35vnZNNIbSmsLA/bro+2ZkSejH/GRWpcX/I9KW
         Vd2K4LGt3Rl37iTpeWcRMKRJDFcxX8MSSEcK1dAIhUC+eZXKz4bmJdbSRdwK9z8ot81h
         KaVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779204305; x=1779809105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOsA0VWRYU6aIOd5RymTsOOHl3s1tuFsOicL1llg2kA=;
        b=D+ra3jNsr0vOzKWr/U3Xbk6AXxb7WlQ0mBZnMTay9ezglMgdF8Sk0MsKIsT25z/M76
         eLIlPZEAIrB7p3hR5NeBv9f0Rv0rLYCzZaC8+F+0rgvYeXCjxe+R+iv9aW6XgDaKWAKG
         K0cKxmWJRq5X78xJnOfw8wref/NdR/1E4FjbwUe0XUy4ThRP+oYO+QPHHireMWbXvRDQ
         O/Tb/yb5rNl81IlRFMNvFaHOnf/ynkiKOCVlxyHqLv8/KZXJ10P9soRmB7NruHD7PRWT
         HaII8HSvrf/DpDqOZ3XVcqDM6y0YAyto7lp825XWiiDVXdSPBVna2+l0guLJdY9TlTuz
         0m+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779204305; x=1779809105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iOsA0VWRYU6aIOd5RymTsOOHl3s1tuFsOicL1llg2kA=;
        b=O+i0/x+5BZpIaVRsm1XHfQeW8znZIUwHx0B9yjs0CgjiXbgwf0uMc0wbaGFshQREz0
         Kkdz/FJeWt+hb9FW0gWEBDcPQiW3u7r3yRXoCCEdTGuyMnpv4qEF0yrQ501DW0YhE+F1
         9UfPX86hr2weUekuoVXP18dRlcmo8RaODk27vvjHc+GfU+caJQpaCcDMhZGj6HO2eRGI
         XTPYF2O2qkUePacb5v4V+ismd9RCwdeI97UuQaXcaKtx81E5BevdvhEuxoyKcW4zUE4c
         iMhGlivIzSUfxjWXY/GOtmQzmzS8lTcAeETzw8RmA/nIplGhwcKiJa48SM18p68bRqdT
         o3zA==
X-Gm-Message-State: AOJu0Yw7wAUhROBj/LFkgpxue7u+QgPDwDk2Y/bsE4N1V4MoXXGm/go0
	ThxtX5jmNU2PhddyWStydd4qB+0CYg6rNXanZHycKnuOszlkh4UHqmqkr16PfzZpWo0G/XwAH1z
	Cc5qAvCVHqAgQCerDHamWftbYApNzEMo=
X-Gm-Gg: Acq92OEKdLw0zCes/1Ale+yMAYmwvTNk22PNXoj+L5A5y7gmYnlqPI5LirGPMqGHxkq
	j6Ym59AVUbDFWajP/lGqFCouPsKqL3qx/L1WlfUnNHHiZqWy2/rpiRs/1C7WU+6EPMpl6bOFsqX
	AVf61ZdIwb2NDuUrfN3QHngEbD71EW8e/rEPSOMVSf9HJ+dsj1E2V5zWI81kTuBNXlCP8yuPffi
	bXoS8Jd4H3JofgO21hqbNAEHqCEG8FSbDF1bIFmrtLcjdjwFmbNXMpxnvFpIhoMPBQH8VHRZdO1
	bjKs3KP7PuWprd206M7dvmUrcQe4xNfHvy3KToFUIGgne+KXSJlHa9D0rDaG1T2qCcGlXW/hVVQ
	DHxw=
X-Received: by 2002:a05:7022:311:b0:12d:b396:eaed with SMTP id
 a92af1059eb24-1350440ae04mr8844365c88.9.1779204304975; Tue, 19 May 2026
 08:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260427124108.3524129-1-christian.couder@gmail.com> <20260427124108.3524129-7-christian.couder@gmail.com>
 <875x4yoys5.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
In-Reply-To: <875x4yoys5.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 19 May 2026 17:24:52 +0200
X-Gm-Features: AVHnY4K0XOqvW-BPLcHIHbd9df9qrYxh4mZnJLa3WCRJ55cZIn0T5qAe_rhUo74
Message-ID: <CAP8UFD0Mbt8JtGW4fyyf4mzZB5t4Bk2LE2y45OJ08mUw-O6EYA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] promisor-remote: trust known remotes matching acceptFromServerUrl
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Elijah Newren <newren@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 3:45=E2=80=AFPM Toon Claes <toon@iotcl.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > +static bool match_one_url(const struct url_info *pi, const struct url_=
info *ui)
> > +{
> > +     const char *pat =3D pi->url;
> > +     const char *url =3D ui->url;
> > +     char *p_str, *u_str;
> > +     bool res;
> > +
> > +     /*
> > +      * Schemes must match exactly. They are case-folded by
> > +      * url_normalize(), so strncmp() suffices.
> > +      */
> > +     if (pi->scheme_len !=3D ui->scheme_len || strncmp(pat, url, pi->s=
cheme_len))
> > +             return false;
> > +
> > +     /*
> > +      * Ports must match exactly. url_normalize() strips default
> > +      * ports (like 443 for https), so length and content
> > +      * comparisons are sufficient.
> > +      */
> > +     if (pi->port_len !=3D ui->port_len ||
> > +         strncmp(pat + pi->port_off, url + ui->port_off, pi->port_len)=
)
> > +             return false;
> > +
> > +     /*
> > +      * Match host and path separately to prevent a '*' in the host
> > +      * portion of the pattern from matching across the '/'
> > +      * boundary into the path. Use WM_PATHNAME for the host so '*'
> > +      * cannot cross '/' there, and 0 for the path so '*' can still
> > +      * match multi-level paths.
> > +      */
>
> Do we actually need WM_PATHNAME, because we only xstrndup() the host
> part anyway?

Yeah, it's not really needed.

On one hand it doesn't hurt either, and it conveys the intent, which
is that no / boundary should be crossed.

But on the other hand I agree it could be confusing and it's simpler
to just remove it, so I have removed it in the v3 I will send very
soon.

> > +
> > +     p_str =3D xstrndup(pat + pi->host_off, pi->host_len);
> > +     u_str =3D xstrndup(url + ui->host_off, ui->host_len);
> > +     res =3D !wildmatch(p_str, u_str, WM_PATHNAME);
> > +     free(p_str);
> > +     free(u_str);
> > +
> > +     if (!res)
> > +             return false;
> > +
> > +     p_str =3D xstrndup(pat + pi->path_off, pi->path_len);
> > +     u_str =3D xstrndup(url + ui->path_off, ui->path_len);
> > +     res =3D !wildmatch(p_str, u_str, 0);
> > +     free(p_str);
> > +     free(u_str);
>
> Is it correct we intentionally do not compare the user and pass (at
> `user_off` and `passwd_off`)? I assume so, because this allows the
> server to update those?

Yes, we ignore them intentionally. Using the existing `token` field
should be prefered, but maybe some need a user and password part of
the URL.

Anyway I have documented that in v3.

> >  static int should_accept_remote(enum accept_promisor accept,
> >                               struct promisor_info *advertised,
> > +                             struct string_list *accept_urls,
> >                               struct string_list *config_info)
> >  {
> >       struct promisor_info *p;
> > @@ -771,9 +846,6 @@ static int should_accept_remote(enum accept_promiso=
r accept,
> >       if (accept =3D=3D ACCEPT_KNOWN_NAME)
> >               return all_fields_match(advertised, config_info, p);
> >
> > -     if (accept !=3D ACCEPT_KNOWN_URL)
> > -             BUG("Unhandled 'enum accept_promisor' value '%d'", accept=
);
> > -
> >       if (strcmp(p->url, remote_url)) {
> >               warning(_("known remote named '%s' but with URL '%s' inst=
ead of '%s', "
> >                         "ignoring this remote"),
> > @@ -781,7 +853,21 @@ static int should_accept_remote(enum accept_promis=
or accept,
> >               return 0;
> >       }
> >
> > -     return all_fields_match(advertised, config_info, p);
> > +     if (accept =3D=3D ACCEPT_KNOWN_URL)
> > +             return all_fields_match(advertised, config_info, p);
> > +
> > +     if (accept !=3D ACCEPT_NONE)
> > +             BUG("Unhandled 'enum accept_promisor' value '%d'", accept=
);
> > +
> > +     /*
> > +      * Even if accept =3D=3D ACCEPT_NONE, we MUST trust this known
> > +      * remote to update its token or other such fields if its URL
> > +      * matches the acceptFromServerUrl allowlist!
> > +      */
> > +     if (url_matches_accept_list(accept_urls, remote_url))
> > +             return all_fields_match(advertised, config_info, p);
>
> I should verify in the following patches, but it seems to me only when
> promisor.AcceptFromServer is set to None it will store the advertised
> servers to the local .git/config, or not?

Right, it's better to check if the URL is in the allowlist as soon as
we can. So in the v3 I have moved as much as possible the
`promisor.acceptFromServerUrl` related checks before the other checks.

The idea is that `promisor.acceptFromServerUrl` takes precedence over
`promisor.acceptFromServer`, so having the
`promisor.acceptFromServerUrl` checks first makes sense.

Note that we should still not accept an advertised remote with an URL
that matches a pattern in `promisor.acceptFromServerUrl` if a remote
with the same name but a different URL exist on the client, unless the
user has explicitly set `promisor.AcceptFromServer` to either 'All' or
'knownName'.

In the v3 I have also added some documentation to be explicit about this.

> > +test_expect_success "clone with 'None' but URL allowlisted" '
> > +     git -C server config promisor.advertise true &&
> > +     test_when_finished "rm -rf client" &&
> > +
> > +     GIT_NO_LAZY_FETCH=3D0 git clone -c remote.lop.promisor=3Dtrue \
> > +             -c remote.lop.fetch=3D"+refs/heads/*:refs/remotes/lop/*" =
\
> > +             -c remote.lop.url=3D"$TRASH_DIRECTORY_URL/lop" \
> > +             -c promisor.acceptfromserver=3DNone \
> > +             -c promisor.acceptFromServerUrl=3D"$ENCODED_TRASH_DIRECTO=
RY_URL/*" \
> > +             --no-local --filter=3D"blob:limit=3D5k" server client &&
> > +
> > +     # Check that the largest object is still missing on the server
> > +     check_missing_objects server 1 "$oid"
> > +'
>
> Why do some tests end with `initialize_server 1 "$oid"` and this one
> not? Isn't it weird tests prepare for the next test?

It's more cleaning up after themselves than preparing for the next test.

Initializing the server with `initialize_server 1 "$oid"` is only
needed when some large objects end up on the server where they should
not be.

If we wanted to be sure that the state of the server is always clean
for the next test, then we should initialize the server at the end of
every test, using something like:

  test_when_finished "initialize_server 1 \"$oid\""

just in case something went wrong and a large file was transferred to
the server. But I think that's quite expensive for not much gain.

It's also clearer for readers to have `initialize_server 1 "$oid"`
only where we think it's really needed.

So in the end I prefer to leave this as-is for now. We can still
address this later in a separate series for all the tests in
"t5710-promisor-remote-capability.sh" if we really think it's worth
addressing.

Thanks.
