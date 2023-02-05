Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9F7C636CC
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 06:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjBEGqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 01:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBEGqj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 01:46:39 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DB81F5F8
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 22:46:37 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id pj3so8863535pjb.1
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 22:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Wi13NpKXB98lcLEO94yMralweJZhsdG7yvOYh2Mcm8=;
        b=C7Gpn8QYH8KZccqOkn0xCZ3jx+HDiv67kkTpn4qSGU0X9zzY7ZX3mEgBYCdI1oZPJH
         2zc+IHg4L2FEKrd0iwteQtVMVh1A19PIhPwxn+0HW+o1Z64rXwuv85oL93K87ur0/mKB
         AUy+R1qObX67nJ6TWvjGI77nF9L7hQXM664haZFhpFYYa5fJzVwokYGj3TZjxzS8Uw7s
         waXS+7IRIqJZarr9ARs4dmtr3z4yrEYUrkII4+Ybz1FtDgyLdtM58dF56PRswbLC+deq
         JDhClR+GyJvBigK1KSHft/hKXt7VxGN2K2AMTQaUT4lyNcIjRaoqRbjRnZdFFQhCxrJE
         XOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Wi13NpKXB98lcLEO94yMralweJZhsdG7yvOYh2Mcm8=;
        b=NqvWHqHFylBFAzwHiBWz4UiOdOleSGWHgYzDa3zPgg4Wq7ogV2k+AvQcG9YnHK+Q+N
         QoD6krWtgNO7Teb6kJsXgXMOzoJzGOr0Ibi9FtA7tXcoBECLLxgEPNd8udxk9vmLQbaX
         Q6nRkl0Tr7fhTN9ujmfM2hiwi4xSm33hlLRGWnLPeSSZ0Jp5obhVkD8SxR6Gb04+Viir
         rLZ0a2bwnXw45BcYhlxhyaAv3AbaPX/2l1juh/JW3NR29Lz3vzZa0Eb32DQBrn6mN4aB
         6Ydjee58IuK+AJKOSN4oGzmSWk/WAQOUwdGWoe4dYVkSDaqeQCeoyO+LM52jjpMeluXM
         KgGg==
X-Gm-Message-State: AO0yUKVtUSouHqSjtCK7iSC/fix4nNR6jYkESLlcPGlrxUkj2R1HQv0L
        uOMQe3BaKPTOrwQOH66T5SPv3pRRBMoNDv4BDMQUbEPWoDM=
X-Google-Smtp-Source: AK7set9v9AaWDpDIOd0MRopQhXMq2vLCEtVFr9Ik926Km9XNsnLwN+H19vw6zX+2QqggPvGr2611gGam1N1rFPDz1WU=
X-Received: by 2002:a17:90a:3183:b0:22c:3ec2:a6f3 with SMTP id
 j3-20020a17090a318300b0022c3ec2a6f3mr2197622pjb.59.1675579597097; Sat, 04 Feb
 2023 22:46:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.1443.git.git.1674914650588.gitgitgadget@gmail.com>
 <pull.1443.v2.git.git.1675244392025.gitgitgadget@gmail.com>
 <Y9pWxHfgPtgCKO+B@coredump.intra.peff.net> <AS2PR03MB9815DDCB7B107E7FD37EC972C0D19@AS2PR03MB9815.eurprd03.prod.outlook.com>
In-Reply-To: <AS2PR03MB9815DDCB7B107E7FD37EC972C0D19@AS2PR03MB9815.eurprd03.prod.outlook.com>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Sun, 5 Feb 2023 06:45:57 +0000
Message-ID: <CAGJzqsnKBHPwHf-RMCxSDB6ZB5UPLH+XUbY8YiJOBxOicaG4bA@mail.gmail.com>
Subject: Re: [PATCH v2] credential: new attribute password_expiry_utc
To:     Matthew John Cheetham <mjcheetham@outlook.com>
Cc:     Jeff King <peff@peff.net>,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 1 Feb 2023 at 20:02, Matthew John Cheetham
<mjcheetham@outlook.com> wrote:
>
> On 2023-02-01 04:10, Jeff King wrote:
>
> > On Wed, Feb 01, 2023 at 09:39:51AM +0000, M Hickford via GitGitGadget wrote:
> >
> >> +`password_expiry_utc`::
> >> +
> >> +    If password is a personal access token or OAuth access token, it may have an
> >> +    expiry date. When getting credentials from a helper, `git credential fill`
> >> +    ignores the password attribute if the expiry date has passed. Storage
> >> +    helpers should store this attribute if possible. Helpers should not
> >> +    implement expiry logic themselves. Represented as Unix time UTC, seconds
> >> +    since 1970.
> >
> > This "should not" seems weird to me. The logic you have here throws out
> > entries that have expired when they pass through Git. But wouldn't
> > helpers which store things want to know about and act on the expiration,
> > too?
> >
> > For example, if Git learns about a credential that expires in 60
> > seconds and passes it to credential-cache which is configured
> > --timeout=300, wouldn't it want to set its internal ttl on the
> > credential to 60, rather than 300?
> >
> > I think your plan here is that Git would then reject the credential if a
> > request is made at time now+65. But the cache is holding onto it much
> > longer than necessary.
> >
> > Likewise, wouldn't anything that stores credentials at least want to be
> > able to store and regurgitate the expiration? For instance, even
> > credential-store would want to do this. I'm OK if it doesn't, and we can
> > consider it a quality-of-implementation issue and see if anybody cares
> > enough to implement it. But I'd think most "real" helpers would want to
> > do so.
> >
> > So it seems like helpers really do need to support this "expiration"
> > notion. And it's actually Git itself which doesn't need to care about
> > it, assuming the helpers are doing something sensible (though it is OK
> > if Git _also_ throws away expired credentials to support helpers which
> > don't).
>
> I have often wondered about how, and if, Git should handle expiring credentials
> where the expiration is known. In my opinion I think Git should be doing
> *less* decision making with credentials and authentication in general, and leave
> that up to credential helpers.
>
> The original design of credential helpers from what I can see (and Peff can
> correct me here of course!) is that they were really only thought about as
> storage-style helpers. Helpers are consulted for a known credential, and told
> about bad (erase) or good (store) credentials, all without any context about
> the request or remote responses.
>
> If no credential helper can respond then Git itself prompts for a user/pass; so
> Git, or rather the user, is the 'generator'.
>
> Of course that's not to say that credential generating helpers don't exist or
> are wrong - Git Credential Manager being of course one example rather close to
> home for me! However the current model, even with generating helpers, is still
> that Git will try and make the request given the details included in the helper
> response.

GCM would benefit from being able to store expiry too. Whenever GCM
retrieves an OAuth credential from storage, it queries the server to
check whether the access token has expired [1]. This would become
unnecessary. I've added more about this in patch v3 commit message.

Further, it solves a problem if GCM is configured after another storage helper:

```
[credential]
    helper = storage  # eg. osx-keychain or exotic
    helper = manager
```

Currently this may return an expired credential from storage.

Background for others: GCM is typically configured as the *only*
helper, with its own internal storage configuration [2]. These
reimplement or wrap popular Git storage helpers [3][4][5].

```
[credential]
    helper = manager
    credentialStore = keychain
```

[1] https://github.com/GitCredentialManager/git-credential-manager/blob/main/src/shared/GitLab/GitLabHostProvider.cs
[2] https://github.com/GitCredentialManager/git-credential-manager/blob/main/docs/credstores.md
[3] https://github.com/GitCredentialManager/git-credential-manager/blob/main/src/shared/Core/Interop/MacOS/MacOSKeychain.cs
[4] https://github.com/GitCredentialManager/git-credential-manager/blob/main/src/shared/Core/Interop/Linux/SecretServiceCollection.cs
[5] https://github.com/GitCredentialManager/git-credential-manager/blob/main/src/shared/Core/CredentialCacheStore.cs

>
> It doesn't make sense that a generating helper that knows about expiration would
> instead choose to respond with an expired credential rather than just try and
> generate a new credential.
>
> Now in the case of a simple storage helper without such logic, after returning
> an expired credential should Git not be calling 'erase' back to the same helper
> to inform it that it has a stale credential and should be deleted?
> This would also require some affinity between calls to get/erase/store.
>
>
> >> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
> >> index f3c89831d4a..338058be7f9 100644
> >> --- a/builtin/credential-cache--daemon.c
> >> +++ b/builtin/credential-cache--daemon.c
> >> @@ -127,6 +127,9 @@ static void serve_one_client(FILE *in, FILE *out)
> >>              if (e) {
> >>                      fprintf(out, "username=%s\n", e->item.username);
> >>                      fprintf(out, "password=%s\n", e->item.password);
> >> +                    if (e->item.password_expiry_utc != TIME_MAX)
> >> +                            fprintf(out, "password_expiry_utc=%"PRItime"\n",
> >> +                                    e->item.password_expiry_utc);
> >>              }
> >
> > Is there a particular reason to use TIME_MAX as the sentinel value here,
> > and not just "0"? It's not that big a deal either way, but it's more
> > usual in our code base to use "0" if there's no reason not to (and it
> > seems like nothing should be expiring in 1970 these days).
> >
> >> @@ -195,15 +196,20 @@ static void credential_getpass(struct credential *c)
> >>      if (!c->username)
> >>              c->username = credential_ask_one("Username", c,
> >>                                               PROMPT_ASKPASS|PROMPT_ECHO);
> >> -    if (!c->password)
> >> +    if (!c->password || c->password_expiry_utc < time(NULL)) {
> >
> > This is comparing a timestamp_t to a time_t, which may mix
> > signed/unsigned. I can't offhand think of anything that would go too
> > wrong there before 2038, so it's probably OK, but I wanted to call it
> > out.
> >
> >> @@ -225,6 +231,7 @@ int credential_read(struct credential *c, FILE *fp)
> >>              } else if (!strcmp(key, "password")) {
> >>                      free(c->password);
> >>                      c->password = xstrdup(value);
> >> +                    password_updated = 1;
> >>              } else if (!strcmp(key, "protocol")) {
> >>                      free(c->protocol);
> >>                      c->protocol = xstrdup(value);
> >> @@ -234,6 +241,11 @@ int credential_read(struct credential *c, FILE *fp)
> >>              } else if (!strcmp(key, "path")) {
> >>                      free(c->path);
> >>                      c->path = xstrdup(value);
> >> +            } else if (!strcmp(key, "password_expiry_utc")) {
> >> +                    this_password_expiry = parse_timestamp(value, NULL, 10);
> >> +                    if (this_password_expiry == 0 || errno) {
> >> +                            this_password_expiry = TIME_MAX;
> >> +                    }
> >>              } else if (!strcmp(key, "url")) {
> >>                      credential_from_url(c, value);
> >>              } else if (!strcmp(key, "quit")) {
> >> @@ -246,6 +258,9 @@ int credential_read(struct credential *c, FILE *fp)
> >>               */
> >>      }
> >>
> >> +    if (password_updated)
> >> +            c->password_expiry_utc = this_password_expiry;
> >
> > Do we need this logic? It seems weird that a helper would output an
> > expiration but not a password in the first place. I guess ignoring the
> > expiration is probably a reasonable outcome, but I wonder if a helper
> > would ever want to just add an expiration to the data coming from
> > another helper.
> >
> > I.e., could we just read the value directly into c->password_expiry_utc
> > as we do with other fields?
> >
> > -Peff
