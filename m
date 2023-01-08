Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C16FC53210
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 15:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjAHPVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 10:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjAHPVk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 10:21:40 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F3DDF8F
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 07:21:39 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4c131bede4bso83554277b3.5
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 07:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+RiGEX+4idPmorgtl0/Yr3Yxguw+/wFlyIbWde6CT2c=;
        b=hw7zCrKdkY2zAUFw4HPFfJW1zSAT947r+Or3zPaUG/ZEhLthoF3QlPRVGkW3PYmem5
         THXbxTsRIFaEHJbGDK7Rum6wj4EtVbQp+aB3wMmXMF2R+Z7mx2Lk0O+nO4guEDt57haz
         PlWmJs5cahpgt93+EYmYyFTKWSk5gjBrww9q6AlB5uMQfBn0fqJOfpl0bEo4pLwTKpvP
         pc9n0PVyeNrw37NKvofbY8KIr0jbnDj/aLgVJcTn1oBFSHf9okkngd8YYVaEvC5MV0WA
         hiZHUiBabvEpDtMs7QUjJH00fdhTo1S/iHy4ExBv8sTKollv2VcKyVaI7jHF9QrEXPBZ
         Oc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RiGEX+4idPmorgtl0/Yr3Yxguw+/wFlyIbWde6CT2c=;
        b=tLqyOvcS9XDikflXqyS4jboAxwVenCbs3Zz7P4wY6E/jg4NqTiYY2vi9cAQ8222Nm5
         GVAFNhpLqSoGa7N/mrQEOy0pNzYbP/hPNKWZ7FGuQdwp9pf3maBBgmZAvPyyRBxNjBdk
         vwGjXIszykTS7iCbS0dTEKUXDhT+tVh7H4GXt+U1wn9eTQvHxa2czZzK68nZJViCsWS5
         oplmJcaOv4YnbB5eRTkaE4m/CyoM2x+GMmcCOfCxMbBPd0tES/Iby/08WviL0j9UTvKP
         itu2rM8idpvwgkbQvwfOjF9L1hLzGQI2kbQ4WpgHgcA+brKCCuBd0CC0YXAMZqSsUD4V
         /9hg==
X-Gm-Message-State: AFqh2kqYQcndcuLVVhNik9lS7dApFSgvq6+z7tsDQW/46vUPCi+BwSBk
        YOarI5ZmMOyDJO/QrlibkrXd/0NaySnu6UN5wRdOlDgr
X-Google-Smtp-Source: AMrXdXsMwx2TPFYSGMZGy9ha2JG1sWIuvSJHO0XazGMsbveaqryOZRm67KaxJxhh516yFkO1/ebUD6O7ONgb8E2B1Pg=
X-Received: by 2002:a81:ee01:0:b0:3d9:b834:fb5a with SMTP id
 l1-20020a81ee01000000b003d9b834fb5amr941275ywm.406.1673191298149; Sun, 08 Jan
 2023 07:21:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.1452.git.1672102523902.gitgitgadget@gmail.com>
 <xmqqo7rpvb83.fsf@gitster.g> <CA+PPyiGd0-AiwhPa5e+fDdA9RybS+c5XeOYm5yycCZco3VHAxg@mail.gmail.com>
In-Reply-To: <CA+PPyiGd0-AiwhPa5e+fDdA9RybS+c5XeOYm5yycCZco3VHAxg@mail.gmail.com>
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Sun, 8 Jan 2023 18:21:27 +0300
Message-ID: <CA+PPyiH5ANyHw-RSzMK+RXxio8gYk2DybY=XnDBvfD1M9s6Mmw@mail.gmail.com>
Subject: Re: [PATCH] ref-filter: add new atom "signature" atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     nsengaw4c via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> >> I am not sure I have understood this, which helper?
> >
> > I think Junio is talking about the following function:
> >
> > static enum signature_option parse_signature_option(const char *arg)
> >
> > he suggested above.
>
> Correct.
>
> > With this function the above code could be just something like:
> >
> > if (parse_signature_option(name) < 0)
> >                     continue;
>
> More or less so, but the first "if" in the helper I wrote in the
> message above is broken.  It should be
>
>          static enum signature_option parse_signature_option(const char *arg)
>          {
>                  if (!*arg)
>                          return S_BARE;
>                  else if (!strcmp(arg, "signer"))
>                          return S_SIGNER;
>                  ...
>                  else
>                          return -1;
>          }

This way, running git for-each-ref refs/heads/signature8
--format="%(signature)" raises a seg fault, I looked for the bug using
gdb when I check the contents of *arg like this:p *arg, I get this:
Cannot access memory at 0x0.

However, others like signature:key, signature:signer, etc are ok.
Leaving it as arg makes everything fine. So I decided to leave it as
you had suggested first.


I had actually forgotten to add the test for "%(signature)", so this
scenario reminded me to do so.


On Mon, Jan 2, 2023 at 7:47 AM NSENGIYUMVA WILBERFORCE
<nsengiyumvawilberforce@gmail.com> wrote:
>
> Hi
>>
>> > From: Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
>> >
>> > This only works for commits. Add "signature" atom with `grade`,
>> > `signer`, `key`, `fingerprint`, `primarykeyfingerprint`, `trustlevel`
>> > as arguments. This code and it's documentation are inspired by
>> > how the %GG, %G?, %GS, %GK, %GF, %GP, and %GT pretty formats were
>> > implemented.
>>
>> Lacking motivation.  Without explaining why somebody may want to
>> have the feature and what it would be used for, "only works for
>> commits" would invite a "so what?  does it even have to work?"  as a
>> response, so start with a brief descrioption "with the current set
>> of atoms, $this_useful_thing cannot easily be achieved" before
>> describing its limitation.
>
> Ok, I will edit the commit message. Thanks
>>
>> > diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>> > index 6da899c6296..9a0be85368b 100644
>> > --- a/Documentation/git-for-each-ref.txt
>> > +++ b/Documentation/git-for-each-ref.txt
>> > @@ -212,6 +212,33 @@ symref::
>> >       `:lstrip` and `:rstrip` options in the same way as `refname`
>> >       above.
>> >
>> > +signature::
>> > +...
>> > +signature:trustlevel::
>> > +     The Trust level of the GPG signature of a commit. Possible
>> > +     outputs are `ultimate`, `fully`, `marginal`, `never` and `undefined`.
>>
>> A good list.  How do these work for signature made with a tool other
>> than GPG (in other words, when "gpg.format" is set to something
>> other than "openpgp")?
>
> You mean ssh and X509, right? honestly, I did not check the behavior. I am going to check
>
>> Having said that, wouldn't it be natural to expect that the same
>> code can deal with signed tags?  After all we use the same signature
>> verification machinery at the lowest level in the callchain.
>
> Very right, it works for signed tags too.
>
>>
>> Handing the !arg case first will make the if/else if/... cascade
>> easier to follow, no?  Also the body of the function may want to
>> become a separate function that returns one of these S_FOO constants.
>>
>>         static enum signatore_option signature_atom_parser(...)
>>         {
>>                 enum signature_option opt = parse_signature_option(arg);
>>                 if (opt < 0)
>>                         return strbuf_addf_ret(err, opt, _("unknown ..."), arg);
>>                 return opt;
>>         }
>>
>> where parse_signature_option() would look like
>>
>>         static enum signature_option parse_signature_option(const char *arg)
>>         {
>>                 if (!arg)
>>                         return S_BARE;
>>                 else if (!strcmp(arg, "signer"))
>>                         return S_SIGNER;
>>                 ...
>>                 else
>>                         return -1;
>>         }
>>
>> or something like that?
>
>  It makes more sense
>>
>> > +{
>> > +     int i;
>> > +     struct commit *commit = (struct commit *) obj;
>>
>> Style?  No SP between cast and value?
>
> ok, noted
>>
>> > +
>> > +     for (i = 0; i < used_atom_cnt; i++) {
>> > +             struct used_atom *atom = &used_atom[i];
>> > +             const char *name = atom->name;
>> > +             struct atom_value *v = &val[i];
>> > +             struct signature_check sigc = { 0 };
>> > +
>> > +             if (!!deref != (*name == '*'))
>> > +                     continue;
>> > +             if (deref)
>> > +                     name++;
>> > +             if (strcmp(name, "signature") &&
>> > +                     strcmp(name, "signature:signer") &&
>> > +                     strcmp(name, "signature:grade") &&
>> > +                     strcmp(name, "signature:key") &&
>> > +                     strcmp(name, "signature:fingerprint") &&
>> > +                     strcmp(name, "signature:primarykeyfingerprint") &&
>> > +                     strcmp(name, "signature:trustlevel"))
>> > +                     continue;
>>
>> And with the helper above, we can avoid the repetition here that can
>> go out of sync with the parser function.
>
> I am not sure I have understood this, which helper?
>
>> > +             check_commit_signature(commit, &sigc);
>>
>> If a format asks for signature:signer and signature:key, we
>> shouldn't be running GPG twice.  First check used_atom[] to see if
>> we even need to do _any_ signature processing (and leave if there is
>> not), populate the sigc just once and then enter the loop, perhaps?
>
> Yeah, I think it was not right calling check_commit_signature() in the loop. Populating sigc at once looks more good to me
>
>
>>
>>  In adddition, a call to check_commit_signature() should have a
>>
>> matching call to signature_check_clear(); otherwise all the
>>
>> resources held by sigc would leak, wouldn't it?
>
> Yeah, it would.
>
> On Mon, Dec 26, 2022 at 9:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "nsengaw4c via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > From: Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
>> >
>> > This only works for commits. Add "signature" atom with `grade`,
>> > `signer`, `key`, `fingerprint`, `primarykeyfingerprint`, `trustlevel`
>> > as arguments. This code and it's documentation are inspired by
>> > how the %GG, %G?, %GS, %GK, %GF, %GP, and %GT pretty formats were
>> > implemented.
>>
>> Lacking motivation.  Without explaining why somebody may want to
>> have the feature and what it would be used for, "only works for
>> commits" would invite a "so what?  does it even have to work?"  as a
>> response, so start with a brief descrioption "with the current set
>> of atoms, $this_useful_thing cannot easily be achieved" before
>> describing its limitation.
>>
>> Having said that, wouldn't it be natural to expect that the same
>> code can deal with signed tags?  After all we use the same signature
>> verification machinery at the lowest level in the callchain.
>>
>> > diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>> > index 6da899c6296..9a0be85368b 100644
>> > --- a/Documentation/git-for-each-ref.txt
>> > +++ b/Documentation/git-for-each-ref.txt
>> > @@ -212,6 +212,33 @@ symref::
>> >       `:lstrip` and `:rstrip` options in the same way as `refname`
>> >       above.
>> >
>> > +signature::
>> > +...
>> > +signature:trustlevel::
>> > +     The Trust level of the GPG signature of a commit. Possible
>> > +     outputs are `ultimate`, `fully`, `marginal`, `never` and `undefined`.
>>
>> A good list.  How do these work for signature made with a tool other
>> than GPG (in other words, when "gpg.format" is set to something
>> other than "openpgp")?
>>
>> > @@ -378,6 +383,30 @@ static int subject_atom_parser(struct ref_format *format, struct used_atom *atom
>> >       return 0;
>> >  }
>> >
>> > +static int signature_atom_parser(struct ref_format *format, struct used_atom *atom,
>> > +                            const char *arg, struct strbuf *err)
>> > +{
>> > +     if (arg) {
>> > +             if (!strcmp(arg, "signer"))
>> > +                     atom->u.signature.option = S_SIGNER;
>> > +             else if (!strcmp(arg, "grade"))
>> > +                     atom->u.signature.option = S_GRADE;
>> > +             else if (!strcmp(arg, "key"))
>> > +                     atom->u.signature.option = S_KEY;
>> > +             else if (!strcmp(arg, "fingerprint"))
>> > +                     atom->u.signature.option = S_FINGERPRINT;
>> > +             else if (!strcmp(arg, "primarykeyfingerprint"))
>> > +                     atom->u.signature.option = S_PRI_KEY_FP;
>> > +             else if (!strcmp(arg, "trustlevel"))
>> > +                     atom->u.signature.option = S_TRUST_LEVEL;
>> > +             else
>> > +                     return strbuf_addf_ret(err, -1, _("unknown %%(signature) argument: %s"), arg);
>> > +     }
>> > +     else
>> > +             atom->u.signature.option = S_BARE;
>> > +     return 0;
>> > +}
>>
>> Handing the !arg case first will make the if/else if/... cascade
>> easier to follow, no?  Also the body of the function may want to
>> become a separate function that returns one of these S_FOO constants.
>>
>>         static enum signatore_option signature_atom_parser(...)
>>         {
>>                 enum signature_option opt = parse_signature_option(arg);
>>                 if (opt < 0)
>>                         return strbuf_addf_ret(err, opt, _("unknown ..."), arg);
>>                 return opt;
>>         }
>>
>> where parse_signature_option() would look like
>>
>>         static enum signature_option parse_signature_option(const char *arg)
>>         {
>>                 if (!arg)
>>                         return S_BARE;
>>                 else if (!strcmp(arg, "signer"))
>>                         return S_SIGNER;
>>                 ...
>>                 else
>>                         return -1;
>>         }
>>
>> or something like that?
>>
>> > @@ -1344,6 +1374,69 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
>> >       }
>> >  }
>> >
>> > +static void grab_signature(struct atom_value *val, int deref, struct object *obj)
>>
>> To be considerate for future developers, perhaps rename this to
>> grab_commit_signature(), so that they can add grab_tag_signature()
>> when they lift the limitation of this implementaiton?
>>
>> > +{
>> > +     int i;
>> > +     struct commit *commit = (struct commit *) obj;
>>
>> Style?  No SP between cast and value?
>>
>> > +
>> > +     for (i = 0; i < used_atom_cnt; i++) {
>> > +             struct used_atom *atom = &used_atom[i];
>> > +             const char *name = atom->name;
>> > +             struct atom_value *v = &val[i];
>> > +             struct signature_check sigc = { 0 };
>> > +
>> > +             if (!!deref != (*name == '*'))
>> > +                     continue;
>> > +             if (deref)
>> > +                     name++;
>> > +             if (strcmp(name, "signature") &&
>> > +                     strcmp(name, "signature:signer") &&
>> > +                     strcmp(name, "signature:grade") &&
>> > +                     strcmp(name, "signature:key") &&
>> > +                     strcmp(name, "signature:fingerprint") &&
>> > +                     strcmp(name, "signature:primarykeyfingerprint") &&
>> > +                     strcmp(name, "signature:trustlevel"))
>> > +                     continue;
>>
>> And with the helper above, we can avoid the repetition here that can
>> go out of sync with the parser function.
>>
>> > +             check_commit_signature(commit, &sigc);
>>
>> If a format asks for signature:signer and signature:key, we
>> shouldn't be running GPG twice.  First check used_atom[] to see if
>> we even need to do _any_ signature processing (and leave if there is
>> not), populate the sigc just once and then enter the loop, perhaps?
>>
>> In adddition, a call to check_commit_signature() should have a
>> matching call to signature_check_clear(); otherwise all the
>> resources held by sigc would leak, wouldn't it?
