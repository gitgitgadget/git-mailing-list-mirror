Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779EFEB64D9
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 21:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjFNVgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 17:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjFNVf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 17:35:59 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5006180
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 14:35:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-98276e2a4bbso143997766b.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 14:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686778556; x=1689370556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lAtjxwNrb1YZ8k2Qg6GkKpPVVDU22A3k/vsxVr+wCKg=;
        b=FJJSjYV+4Ww0bEwcO3CsrTADZx1TO7b4hKaRgcyzfhkYo6vrrrKAPwK9s8MIWGMsDr
         IuXZbsahxd6aJYit63BK8iZa5qvdvvYmdUB5TePUP/lIpGHmIXx0bmvcj7CAFl1FoIDc
         j6+noE8lnQ+O18a5J3Cuhqxb1Ztd3+ctFYalJiJ1EGW40aqDraSe8xdELgMXeUe3N99Y
         fLPLEZVzjUaZ/7CByzBo4cKAwt9fxaSYZDoEDJs74CxPMVR8iKNTPpS5eKgZAoHI4B5U
         v/iAonjmaRdoYDaCfOc0Dl+EQOLv/SFGplfKaG0ySzE/sv+iJy5/VZRl6DcvhO+f20Jc
         TDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686778556; x=1689370556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAtjxwNrb1YZ8k2Qg6GkKpPVVDU22A3k/vsxVr+wCKg=;
        b=K8UgCeuSX25oaEzSX8qNjbGprI+mfGIkH7aN6xR3RJGy25EGT1OuY33dHZHmdxCds5
         MYv/R9FIKjO1sXYMfTEJ+0YzW2Y9uBeznXB6eP7uDhlgKUfd09g/R8I8/l31E8b4y1sk
         EvKebFxKDP9XgTqFtZ9yPdi9Y92AD9p9/DfC/1jTuemRUHKHNS+NJBrUaeGw7b6rbER8
         DbxnRQhLKbQgspY70+LkWnpIeaRKj7928W2GsTvwnF4UYD7GFlGH2MTVGMJe/m1CtTxU
         wV2wH9+VZzL+vfjVcZneII/rH48c2womHisIXw7hGT+8ENUBKulyhC/2lXVjpOsvzF4n
         JBpQ==
X-Gm-Message-State: AC+VfDxnlleTia+OWW9h6EkAXmEE5pSWCdBRuj69q+PrMjkkLwmayVWr
        YLaT7BuMIkG3rPS4UvkNSyxUNPoNn6fnRxTgy6w=
X-Google-Smtp-Source: ACHHUZ651dDX7mDvKH0z3pRVVnQcnwMfkhUANcO15OlHoluR6fhQcFHU6cEikhSWIN+i8ISJtiAkkqBt8aQ50jRJ8MQ=
X-Received: by 2002:a17:907:6e10:b0:974:5ce6:f9ff with SMTP id
 sd16-20020a1709076e1000b009745ce6f9ffmr18133011ejc.32.1686778555936; Wed, 14
 Jun 2023 14:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1525.git.git.1686741785.gitgitgadget@gmail.com>
 <fcdb579263f87dd089c50fc5799cf30b21f4d12c.1686741785.git.gitgitgadget@gmail.com>
 <xmqqv8fqxcdj.fsf@gitster.g>
In-Reply-To: <xmqqv8fqxcdj.fsf@gitster.g>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Wed, 14 Jun 2023 22:35:20 +0100
Message-ID: <CAGJzqsmmBYep-iRYushkEztnNMTr52APKmC_nMRQBDbGujt3rg@mail.gmail.com>
Subject: Re: [PATCH 2/2] credential: erase all matching credentials
To:     Junio C Hamano <gitster@pobox.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>,
        Jeff King <peff@peff.net>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 14 Jun 2023 at 17:00, Junio C Hamano <gitster@pobox.com> wrote:
>
> "M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: M Hickford <mirth.hickford@gmail.com>
> >
> > Users expect that
> > `echo "url=https://example.com" | git credential reject` or
> > `echo "url=https://example.com\nusername=tim" | git credential reject`
> > erase all matching credentials.
>
> Perhaps that is a sensible expectation.  It is unclear from the
> above description what happens instead without the "fix", though.

`credential reject` sends the erase action to each helper, but the
exact behaviour of erase isn't specified in documentation or tests.
Some helpers (such as credential-libsecret) delete all matching
credentials, others (such as credential-cache and credential-store)
delete at most one matching credential.

Test that helpers erase all matching credentials. This behaviour is
easiest to reason about. Users expect that `echo
"url=https://example.com" | git credential reject` or `echo
"url=https://example.com\nusername=tim" | git credential reject` erase
all matching credentials.

I'll update the commit message in patch v2.

>
> By the way, I do not think your
>
>     cc. Jeff King peff@peff.net cc: Matthew John Cheetham mjcheetham@outlook.com
>
> in 0/2 is doing anything; I've manually added them to Cc: of this
> message and left everything in the patch below, even though I am not
> commenting on anything there myself, to give them easier reference.

Thanks Junio. I'll check the GitGitGadget documentation.

>
> Thanks.
>
> > Fixes for credential-cache and credential-store.
> >
> > Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> > ---
> >  Documentation/git-credential.txt   |  4 ++--
> >  Documentation/gitcredentials.txt   |  2 +-
> >  builtin/credential-cache--daemon.c | 15 ++++++++------
> >  builtin/credential-store.c         |  3 ++-
> >  t/lib-credential.sh                | 33 ++++++++++++++++++++++++++++++
> >  5 files changed, 47 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
> > index 0e6d9e85ec7..04bfb918de6 100644
> > --- a/Documentation/git-credential.txt
> > +++ b/Documentation/git-credential.txt
> > @@ -38,8 +38,8 @@ to any configured credential helpers, which may store the credential
> >  for later use.
> >
> >  If the action is `reject`, git-credential will send the description to
> > -any configured credential helpers, which may erase any stored
> > -credential matching the description.
> > +any configured credential helpers, which may erase stored credentials
> > +matching the description.
> >
> >  If the action is `approve` or `reject`, no output should be emitted.
> >
> > diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
> > index 100f045bb1a..65d652dc40e 100644
> > --- a/Documentation/gitcredentials.txt
> > +++ b/Documentation/gitcredentials.txt
> > @@ -260,7 +260,7 @@ appended to its command line, which is one of:
> >
> >  `erase`::
> >
> > -     Remove a matching credential, if any, from the helper's storage.
> > +     Remove matching credentials, if any, from the helper's storage.
> >
> >  The details of the credential will be provided on the helper's stdin
> >  stream. The exact format is the same as the input/output format of the
> > diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
> > index 82f376d3351..5e3a766e42d 100644
> > --- a/builtin/credential-cache--daemon.c
> > +++ b/builtin/credential-cache--daemon.c
> > @@ -33,12 +33,12 @@ static void cache_credential(struct credential *c, int timeout)
> >       e->expiration = time(NULL) + timeout;
> >  }
> >
> > -static struct credential_cache_entry *lookup_credential(const struct credential *c, int match_password)
> > +static struct credential_cache_entry *lookup_credential(const struct credential *c)
> >  {
> >       int i;
> >       for (i = 0; i < entries_nr; i++) {
> >               struct credential *e = &entries[i].item;
> > -             if (credential_match(c, e, match_password))
> > +             if (credential_match(c, e, 0))
> >                       return &entries[i];
> >       }
> >       return NULL;
> > @@ -48,9 +48,12 @@ static void remove_credential(const struct credential *c)
> >  {
> >       struct credential_cache_entry *e;
> >
> > -     e = lookup_credential(c, c->password != NULL);
> > -     if (e)
> > -             e->expiration = 0;
> > +     int i;
> > +     for (i = 0; i < entries_nr; i++) {
> > +             e = &entries[i];
> > +             if (credential_match(c, &e->item, c->password != NULL))
> > +                     e->expiration = 0;
> > +     }
> >  }
> >
> >  static timestamp_t check_expirations(void)
> > @@ -127,7 +130,7 @@ static void serve_one_client(FILE *in, FILE *out)
> >       if (read_request(in, &c, &action, &timeout) < 0)
> >               /* ignore error */ ;
> >       else if (!strcmp(action.buf, "get")) {
> > -             struct credential_cache_entry *e = lookup_credential(&c, 0);
> > +             struct credential_cache_entry *e = lookup_credential(&c);
> >               if (e) {
> >                       fprintf(out, "username=%s\n", e->item.username);
> >                       fprintf(out, "password=%s\n", e->item.password);
> > diff --git a/builtin/credential-store.c b/builtin/credential-store.c
> > index e0ae028b1c3..85b147e460f 100644
> > --- a/builtin/credential-store.c
> > +++ b/builtin/credential-store.c
> > @@ -36,7 +36,8 @@ static int parse_credential_file(const char *fn,
> >                       found_credential = 1;
> >                       if (match_cb) {
> >                               match_cb(&entry);
> > -                             break;
> > +                             if (strcmp(op, "erase"))
> > +                                     break;
> >                       }
> >               }
> >               else if (other_cb)
> > diff --git a/t/lib-credential.sh b/t/lib-credential.sh
> > index f7e4e29c5e1..3f4100b6ce2 100644
> > --- a/t/lib-credential.sh
> > +++ b/t/lib-credential.sh
> > @@ -45,6 +45,8 @@ helper_test_clean() {
> >       reject $1 https example.com user2
> >       reject $1 https example.com user4
> >       reject $1 https example.com user5
> > +     reject $1 https example.com user6
> > +     reject $1 https example.com user7
> >       reject $1 http path.tld user
> >       reject $1 https timeout.tld user
> >       reject $1 https sso.tld
> > @@ -298,6 +300,37 @@ helper_test() {
> >               EOF
> >       '
> >
> > +     test_expect_success "helper ($HELPER) erases all matching credentials" '
> > +             check approve $HELPER <<-\EOF &&
> > +             protocol=https
> > +             host=example.com
> > +             username=user6
> > +             password=pass1
> > +             EOF
> > +             check approve $HELPER <<-\EOF &&
> > +             protocol=https
> > +             host=example.com
> > +             username=user7
> > +             password=pass1
> > +             EOF
> > +             check reject $HELPER <<-\EOF &&
> > +             protocol=https
> > +             host=example.com
> > +             EOF
> > +             check fill $HELPER <<-\EOF
> > +             protocol=https
> > +             host=example.com
> > +             --
> > +             protocol=https
> > +             host=example.com
> > +             username=askpass-username
> > +             password=askpass-password
> > +             --
> > +             askpass: Username for '\''https://example.com'\'':
> > +             askpass: Password for '\''https://askpass-username@example.com'\'':
> > +             EOF
> > +     '
> > +
> >       : ${GIT_TEST_LONG_CRED_BUFFER:=1024}
> >       # 23 bytes accounts for "wwwauth[]=basic realm=" plus NUL
> >       LONG_VALUE_LEN=$((GIT_TEST_LONG_CRED_BUFFER - 23))
