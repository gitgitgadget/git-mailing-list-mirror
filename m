Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBBA1E7C02
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 05:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139852; cv=pass; b=V0OPLbXd9SCW5G/poteYHRsPAVKufq5SCq7/8QdBVPT1QqN2ZoXDYVdg+5Pyt9m7K1k91HpOT5Yj9wUCZRVg80BDVTKo1sl1EU9Bz+GAtx0N6uGzT9m7mrsr3v8sLcUbl2FtVDpipU4B1QabdqobS5nUfDdKNNNo+D+l8XZ3dBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139852; c=relaxed/simple;
	bh=enYY2gI02XtRCXcstUojS/T/OVk25Z3fawAc1aTEn4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLKnya0WlXoLfb9UrHV0P9Ovm4UcwJL9TX7A/RnydoI5y0MU4l0+4T3v8jZ4bhSSg/V/xo1MpBz3ZgYtU902nKrJsUS1I87wI9f4z39iy+xhQqPTKi7KPnI5evzhm7/jCfsT94DMxswCgRrsv6Z51ESrjLBTNZCtbRcACI0oJNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/vMGF90; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/vMGF90"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso6070005e9.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 22:04:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790139849; cv=none;
        d=google.com; s=arc-20260327;
        b=nxdN9fkdKS8fHW4kJZNRit7Pl3iqnJpqSjw1y9MqPfE29nU76A7WMQvd22LJDNCWfM
         A9VBCYNN3MTRX86lnwrI/bO48LHzZHhUIPsQFw6ry9+UClUejP3dweybY6NlzrmK7anK
         xAnNsy+LBv7EOadXCInS6qOtfaPh/lyIDL+Z/0A0f+UHQlKCiT9mIqMfz7UzpmHyc9P3
         3dXos24sWnihlLGQ3qAKzUPqZ8ofdy8xkeh6G2nLxXo/a8TNaUK4lT6ZZ67svOd+ur3s
         Oc/2ATCNzAjEUJKqLiZCN+Q4SB+n58poWDuF/5U6ZQj7OGDHW54kuoEXB5QtT8/fTCyX
         imXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SDodRMVVhVv07olaU2CNUww7GnpocRRglggOHKv48wg=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=n/usxnpJigJau4510UfdLJTOC5kYdpfsf0or/faYyt2qGvjE6svyJTw7YSVOP9E3mf
         Lqj/mzeOMnhL4C8HcRqJzfND54WeoGCf/cjXlKB4vYHaADViugYOjYF2V+ta559ooI8V
         rMTDil55aAvsK0LiOIhnSJmg5wj4cQ0UYm1F46QqvBLcYMwzWtj375ADl5a/xU/xeJol
         jgg4n+u3wf8CvCtOgeiF6uebR8nDlD5sxnMF9zTtWF1DjpLYHbhIEe8MaFvYcf8uuA9a
         4LSboT0SWH3czW1evhwQPJfolaqsHn6rLYf6gjNlpIu6dKlQGKj+VE0j7JZYpJGYeHmy
         likQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790139849; x=1790744649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SDodRMVVhVv07olaU2CNUww7GnpocRRglggOHKv48wg=;
        b=k/vMGF90kKI6uPsPqynExHTJLRMs+nJVN4vDMLm385hIf1A/yXR1Acv0Gf2g2nVm0R
         2rjniN4sATZi36EB1vs7jxO/I313FV5a8seKrKGuBHKPcilxov4iTcHcAtfhlcYDeqA2
         EAtuNwUif3jBZofVF95QlGadgW4LR0fzP2vt5QoYFdGBH6hBXUSkFu9ipQsOT4qzhrgW
         nAyNer4oWcBrAv8UR82Mc3D/D7ddqtSXlVMkZAdOLuRM5frYfWQYNUc0VdGK61IeTMmA
         O5q9OR6b3ZnzxaaVixZGAI6drih8z+7RMwTMd28hx1Iy+BTaZYO4GYJnOeqsm+VztTH3
         YQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790139849; x=1790744649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SDodRMVVhVv07olaU2CNUww7GnpocRRglggOHKv48wg=;
        b=h/+Sjz49KJMLaAV9mkjWPwWDYTQgaDryPT0W3TEjyzIrR45/1KJMMOaS7gYAogKkPD
         6lnOdNpenDtje40BlTBCA6+8UrD91mYEfZRvF3RyvWFcYCI1HM/Vm9mVBxk6t8PViMx1
         BzGcnn/HLlJgY4cVo3RD/U3yL2fpglmZG+ADhEiZqeSOa3XO+PmR/iVOVQsgaqTi76A3
         CgDMc0L5D62U4/U1xMfFwMwT+SjTGtyG0xoDz7tHkEQtIxgySVj9Z20fKhYgSlViiW+U
         Uw81lZU9qEWUb8WeJcYcba84JLsNdcxe+sTJj3yKXiCqHfS8eZfRJoAMsL+9Sf90Fm0o
         uuew==
X-Gm-Message-State: AFuF++nNZhU3M1Lqg8FzT3t08+zNZ7v7tuaxyz8ViY3C7AnG495qU5jY
	S2DZM9M1sws7oo7hzhkzirOc797QAEhWNReD/5LhvAUUBYwAyy5a5XZ6V4PWd5m7SyEecC9Va5P
	XYDTuWcnAsU2crnZB+UXMk4Yb0wy8nG0+lf/y
X-Gm-Gg: AYBFou144/f2Ax8yFLvz+Kdpm6OiYC7BjuS8+33l1/iZ3l36rV4Z/IMdSAPNXkn30lo
	fPQwusRF4J1ErxJN93PqUTgRTIf1Hud8DndaLNHeHc8fAgq/AdAieSpaCwa81Q8SmoECOTGLaTG
	ldxyBpwj1yMEoy2kSeIzMPhp63+uIjwXsSxAZGW55QACcDoSq0Jo9T16KY5ln1aat3TxiT062V1
	auN3FF7IEpVLW+malJx5oi2793qnwXAAPaPr7CoCTkGzyD9MG1PC3Wrs9H9jsHbdKWDC1yrNn6K
	dVJEJDlvpUB4RQai327YQ9TtAaPVLmzzS/EPD4cUCnpiM5mb+0sytpY1Uvg5MdlK+uwYUNSP50A
	12w==
X-Received: by 2002:a05:600c:6097:b0:49f:bd3c:bc24 with SMTP id
 5b1f17b1804b1-49fdf2537c0mr13299075e9.31.1790139848525; Tue, 22 Sep 2026
 22:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922040047.2567-1-colinlewishinton@gmail.com> <xmqqwlsdhmvk.fsf@gitster.g>
In-Reply-To: <xmqqwlsdhmvk.fsf@gitster.g>
From: Colin Hinton <colinlewishinton@gmail.com>
Date: Tue, 22 Sep 2026 22:03:57 -0700
X-Gm-Features: AclHuK9VKAds96Eajszb6_SMi2NW1l4zW1M24wPASB0OYi7JDoddU5k6_i4u-uU
Message-ID: <CAHeTm9OMLba_h0B2jRh_-GhogQXuwROBpX2jE__BPJ0GHq9P1A@mail.gmail.com>
Subject: Re: [PATCH] fetch.c: defer fetch.followRemoteHEAD validation
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:32=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Colin Hinton <colinlewishinton@gmail.com> writes:
>
> > Previously, fetch.followRemoteHEAD was validated and any invalid
> > value was warned about unconditionally during config parsing.
>
> Early paragraphs that make observation on how the current system
> works should be written in present tense.  It is the status quo, so
> we shouldn't say "previously" and we do not need to say "currently".
>
>     The value of configuration variable "fetch.followRemoteHEAD is
>     validated while the configuration file is being parsed, which
>     lead to a warning, even when we do not need to know the value.
>
> > Now store the raw config string instead, and resolve/validate it lazily
> > at the one call in do_fetch(), so an irrelevant fetch no longer warns a=
bout an unrelated
> > config value it never needed.
>
> Well written, except that "an irrelevant fetch" is a bit awkward.
> "Irrelevant how, for whom, and why?" is a set of natural questions
> that come to readers' minds.  I am guessing that you wanted to say
> that "git fetch" does not always need to know the value of the
> fetch.followRemoteHEAD configuration variable, perhaps because a
> particular invocation of "git fetch" receives specific refspec.
> You'd need to find a concise way to say that and replace the
> "irrelevant" there.

Okay, for my next patch I will clear this up, and will change my
tenses to all be in present tense.

>
> In any case, it is a very good discipline to avoid dying or making
> noises while reading the configuration file and instead complain
> only when we know we will use the bad value.
>
> >  struct fetch_config {
> >       enum display_format display_format;
> > -     enum follow_remote_head_settings follow_remote_head;
> > +     char *follow_remote_head_raw;
>
> OK.  So this is the read the value and keep it as-is.
>
> >       int all;
> >       int prune;
> >       int prune_tags;
> > @@ -178,22 +178,29 @@ static int git_fetch_config(const char *k, const =
char *v,
> >       if (!strcmp(k, "fetch.followremotehead")) {
> >               if (!v)
> >                       return config_error_nonbool(k);
>
> This error still triggers even when the configuration variable is
> irrelevant (e.g, "git fetch origin master", i.e., rs->nr !=3D 0).
> Dealing with it is well within the scope of the topic, isn't it?
> You may be ignoring
>
>         [fetch]
>                 followremotehead =3D bogus
>
> when the user runs "git fetch https://over.there/repo master" with
> this patch, which may be an improvement, but if the user has a
> valueless truth
>
>         [fetch]
>                 followremotehead
>
> then the same command would die while parsing the configuration
> variable, which is not what you wanted to see, right?

I Agree on this, I will defer this check to the same point of use that
I have abstracted in get_follow_remote_head. It would make sense to
only report a valueless fetch.followRemoteHEAD when the value is
needed. I also assume that if followRemoteHEAD is valueless, that we
should call die(...) rather than config_error_nonbool() to match
current behavior, so I will implement this in my next patch unless
there is something additional I should consider.
>
> > -             else if (!strcmp(v, "never"))
> > -                     fetch_config->follow_remote_head =3D FOLLOW_REMOT=
E_NEVER;
> > -             else if (!strcmp(v, "create"))
> > -                     fetch_config->follow_remote_head =3D FOLLOW_REMOT=
E_CREATE;
> > -             else if (!strcmp(v, "warn"))
> > -                     fetch_config->follow_remote_head =3D FOLLOW_REMOT=
E_WARN;
> > -             else if (!strcmp(v, "always"))
> > -                     fetch_config->follow_remote_head =3D FOLLOW_REMOT=
E_ALWAYS;
> > -             else
> > -                     warning(_("unrecognized fetch.followRemoteHEAD va=
lue '%s' ignored"), v);
> > +             free(fetch_config->follow_remote_head_raw);
> > +             fetch_config->follow_remote_head_raw =3D xstrdup(v);
>
> Good to see that the code is prepared to see the same variable
> defined multiple times in the configuration stream without leaking
> earlier values.
>
> > +static enum follow_remote_head_settings get_follow_remote_head(const c=
har *setting)
> > +{
> > +     if (!strcmp(setting, "never"))
> > +             return FOLLOW_REMOTE_NEVER;
> > +     else if (!strcmp(setting, "create"))
> > +             return FOLLOW_REMOTE_CREATE;
> > +     else if (!strcmp(setting, "warn"))
> > +             return FOLLOW_REMOTE_WARN;
> > +     else if (!strcmp(setting, "always"))
> > +             return FOLLOW_REMOTE_ALWAYS;
> > +     warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored=
"), setting);
> > +     return FOLLOW_REMOTE_UNCONFIGURED;
> > +}
>
> OK.  So unrecognised are treated as unconfigured, just like before.
>
> >  static int parse_refmap_arg(const struct option *opt, const char *arg,=
 int unset)
> >  {
> >       BUG_ON_OPT_NEG(unset);
> > @@ -1922,7 +1929,7 @@ static int do_fetch(struct transport *transport,
> >       struct ref_update_display_info_array display_array =3D { 0 };
> >       struct strmap rejected_refs =3D STRMAP_INIT;
> >       int summary_width =3D 0;
> > -     int follow_remote_head;
> > +     int follow_remote_head =3D 0;
> >
> >       if (tags =3D=3D TAGS_DEFAULT) {
> >               if (transport->remote->fetch_tags =3D=3D 2)
> > @@ -1938,22 +1945,6 @@ static int do_fetch(struct transport *transport,
> >                       goto cleanup;
> >       }
> >
> > -     /*
> > -      * NEEDSWORK: By the time this function executes, we have already=
 parsed
> > -      * all such followRemoteHEAD values from the external configurati=
on,
> > -      * potentially emitting warning messages for bogus values.  Ideal=
ly, if
> > -      * this fetch ends up not needing to consult these values, then g=
it would
> > -      * not ever output a value warning. (eg: when pulling from a URL =
directly -
> > -      * rather than a configured remote, or when a remote's followRemo=
teHEAD
> > -      * overrides the fallback fetch setting)
> > -      */
>
> Good write-up.  We should be able to steal some in our own description.
>
> > @@ -1962,6 +1953,14 @@ static int do_fetch(struct transport *transport,
> >               if (transport->remote->fetch.nr) {
> >                       refspec_ref_prefixes(&transport->remote->fetch,
> >                                            &transport_ls_refs_options.r=
ef_prefixes);
> > +
> > +                     if (transport->remote->follow_remote_head)
> > +                             follow_remote_head =3D transport->remote-=
>follow_remote_head;
>
> The code assumes that remote.*.followRemoteHEAD has been pre-parsed.
> Doesn't the code to do so in remote.c::handle_config() share exactly
> the same problem as you are fixing here?
>
I agree that the same problem that is being addressed here is present
in remote.c as well. The only difference being, that there is no
return call in the followremotehead block in remote.c, and it at most
only throws a warning if no valid value is present. I think this
should be addressed, but I am uncertain if this is within the scope of
this issue and should be resolved now, or if this requires its own
investigation and should be resolved in a future patch. Regardless I
am eager to work on it, but would like some guidance as to what is
most appropriate for a change in remote.c.

> > +                     else if (config->follow_remote_head_raw)
> > +                             follow_remote_head =3D get_follow_remote_=
head(config->follow_remote_head_raw);
> > +                     else
> > +                             follow_remote_head =3D BUILTIN_FOLLOW_REM=
OTE_HEAD_DFLT;
>
> Make a mental note that do_set_head is flipped on ONLY here in this
> function.
>
> >                       if (follow_remote_head !=3D FOLLOW_REMOTE_NEVER)
> >                               do_set_head =3D 1;
> >               }
>
> And later, do_set_head is referenced twice.  Once when preparing the
> transport options to first discover what refs they have (ls-refs)
>
>         if (do_set_head)
>                 strvec_push(&transport_ls_refs_options.ref_prefixes,
>                             "HEAD");
>
> and then once more to make a set-head call using follow_remote_head.
>
>         if (do_set_head) {
>                 /*
>                  * Way too many cases where this can go wrong so let's ju=
st
>                  * ignore errors and fail silently for now.
>                  */
>                 set_head(remote_refs, transport->remote, follow_remote_he=
ad);
>         }
>
> Incidentally, after that "lazily turn configuration string into
> follow_remote_head variable" block is left, this is the only place
> that follow_remote_head variable is referenced.
>
> Which suggests to me that we can get rid of do_set_head variable, we
> can initialize follow_remote_head variable to FOLLOW_REMOTE_NEVER,
> and replace these two
>
>         if (do_set_head)
>
> with
>
>         if (follow_remote_head !=3D FOLLOW_REMOTE_NEVER)
>
> and the resulting code may become a tad easier to follow.
>
> Hmmm?

Certainly would be an improvement, and one I will be implementing in
my next patch.
