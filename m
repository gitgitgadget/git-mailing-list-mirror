Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E8EC77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 08:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjEPIEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 04:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjEPIEf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 04:04:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE2049DB
        for <git@vger.kernel.org>; Tue, 16 May 2023 01:04:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96598a7c5e0so2235917266b.3
        for <git@vger.kernel.org>; Tue, 16 May 2023 01:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684224270; x=1686816270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecdoL+m9IgBD6/9Iyr2GqAAgmvyev7JhozhfmiSYTTk=;
        b=VIjNMV5dKZy9neFCq5YmIGyzNihL2c3AWmxMHQPOzkYnUCLpB3e4HXNFNIHlQYxX2b
         GaWFiAIAJ+GzitdM4cQr6PcqvI1P0sk+UHgGqaG4kxm4gG39vPoJyuvAfts4uYjQqI4U
         y3RYnfq9LhCDxLj9sy2t4n65wq/2jNqrMf9eQJl9V9upAGm6UsxSAX4k0bEAiPtpVQRY
         xWQek8iqr80ocpzhMZwA8XWuGUiLH3X+QRBwp8jOfFZUu0eY5JX2uWKN7t4qty9fSSAs
         hcN4HaD0bENXO1toh8EQX3XSgNlk6ML7xI1Zagc3Z0sKhGYCGEuifXY49KUyGmfzs1hC
         0MGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684224270; x=1686816270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecdoL+m9IgBD6/9Iyr2GqAAgmvyev7JhozhfmiSYTTk=;
        b=ZyZE2Ja5t3Ba2+bZi7XanZz2+kKY9yz59DfVJLH2gJNaBkXPpjwCApkR21k9yYmjTo
         RyU9BBLvFRXUs/oT94sU1ryUQoqK6883kobKZP04vNeKud6Kq+OmZWkYlFrQpADPtX0j
         0fuc42kUCHLiSPRhNoggYJSByKdMzwbPGqPu+8CSGbDn0luak4NG0Tn+VCikmI2aI8rh
         nhJKpOy1jG4hidtPObHXa0HQxhtYKwQ7vQlvdSwwoNrLNqOrt4y3k43MaMZRyiXCXkQt
         G6pakMLI9Ja57sMUuK0x5cPJMgm4NOVeUT43wYByTrgfnVbyld0w5QAoltxmgDP3asTL
         qmxg==
X-Gm-Message-State: AC+VfDx6FSLQszbDDY5Wb4jT8pJM4FBdaWcHwKSE0wyiiRp8SrdIyW1t
        1RNiNIX7zK+HLPA8wlT4fZkCmWPfBu3QU1zrylKRl4PdI56Rjw==
X-Google-Smtp-Source: ACHHUZ5pHqxoLxjbf3lLteUqqGdB2xDtX8b6qtQ8Ii0xH5u095yB630Jye6Ved8BYvQFjpLb1Lx6BwkMtqDAageKzWM=
X-Received: by 2002:a17:907:7e99:b0:96a:2dd7:2ef9 with SMTP id
 qb25-20020a1709077e9900b0096a2dd72ef9mr21605626ejc.39.1684224269367; Tue, 16
 May 2023 01:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1469.v2.git.git.1679729764851.gitgitgadget@gmail.com>
 <pull.1469.v3.git.git.1683270298313.gitgitgadget@gmail.com>
 <CAGJzqskMwOJkriH6serqdwAVYi+fftEL8ohJd-suP6v+OxB_bg@mail.gmail.com> <xmqq353xa2cg.fsf@gitster.g>
In-Reply-To: <xmqq353xa2cg.fsf@gitster.g>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Tue, 16 May 2023 09:03:51 +0100
Message-ID: <CAGJzqsn_Jmr3x0tj3U7QRD3eGMzWwr3RR1-O3_YzFCMCU7u+eQ@mail.gmail.com>
Subject: Re: [PATCH v3] credential/libsecret: support password_expiry_utc
To:     Junio C Hamano <gitster@pobox.com>
Cc:     M Hickford <mirth.hickford@gmail.com>,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 15 May 2023 at 19:15, Junio C Hamano <gitster@pobox.com> wrote:
>
> M Hickford <mirth.hickford@gmail.com> writes:
>
> >> +static const SecretSchema schema =3D {
> >> +       "org.git.Password",
> >> +       /* Ignore schema name for backwards compatibility with previou=
s versions */
> >> +       SECRET_SCHEMA_DONT_MATCH_NAME,
> >> +       {
> >> +               {  "user", SECRET_SCHEMA_ATTRIBUTE_STRING },
> >> +               {  "object", SECRET_SCHEMA_ATTRIBUTE_STRING },
> >> +               {  "protocol", SECRET_SCHEMA_ATTRIBUTE_STRING },
> >> +               {  "port", SECRET_SCHEMA_ATTRIBUTE_INTEGER },
> >> +               {  "server", SECRET_SCHEMA_ATTRIBUTE_STRING },
> >> +               {  "password_expiry_utc", SECRET_SCHEMA_ATTRIBUTE_INTE=
GER },
> >
> > I've been testing this patch with credential-generating helper
> > git-credential-helper. It works, but because libsecret overwrites
> > items if and only if the attributes match exactly, you end up with
> > many items in the secret store that differ only by expiry date. This
> > is inelegant, and confusing to users. Please hold this patch, don't
> > merge to master. A solution might be to store the expiry date as the
> > secret of a separate item (even though the value is not confidential)
>
> Thanks for stopping me.  I'll mark the topic as "on hold".

Thanks Junio

>
> It does sound problematic, but if we think about what is used as
> keys and what is used as values, it does make a lot more sense to
> store the expiry as part of a value.  After all, we are not even
> asking "give me the password that will expire in the most distant
> future" or anything like that.  We consult the database with "who
> wants to access what server over which protocol at what port" as the
> key and expect we find the suitable authentication material to use.
> It would be best if we can treat the expiry date as an additional
> attribute of that authentication material.
>
> Do the methods to store and retrieve a password from the keyring
> allow us to add such an extra attribute to the password?  I have no
> idea how the Gnome keyring API works, but is there a way to mark
> each entry in the SecretSchemaAttributes as "this is used as a key"
> vs "this is used as a value---do not match"?  Would thinking along
> such a line help?

Unfortunately not. The libsecret docs warn "Attributes are meant to be
used for lookup of items; they=E2=80=99re not designed to be used as a gene=
ric
key/value database".
https://gnome.pages.gitlab.gnome.org/libsecret/migrating-libgnome-keyring.h=
tml

Interestingly, Windows' wincred API doesn't have this issue, because
it searches by a unique key, defined separately to attributes.

>
> Another possibility would be to store encoded concatenation of the
> real password and expiration timestamp and decode them into two upon
> retrieval.  If we were the only user of the keystore, that may work,
> but if we are sharing the keystore with other applications, it would
> be a non-starter.

Yes, I think that would work nicely. A format such as that below would
be backwards compatible (passwords already can't contain newlines) and
self explanatory to any curious user browsing their secret store. I
already have a draft that works much like this. I'll prepare a patch
v4.

    7d7b554
    password_expiry_utc=3D1684179877
    oauth_refresh_token=3Dbe8a9aa3

Is the secret store ever shared with other applications such as a web
browser? If so, sharing is already broken, because popular Git hosts
such as GitHub and GitLab expect different passwords for web login and
Git authentication (OAuth token or personal access token). A solution
could be to introduce our own libsecret schema (as in the current
patch) instead of continuing to use SECRET_SCHEMA_COMPAT_NETWORK
potentially shared with other apps. I'm not sure whether that's
worthwhile in this patch. I defer to you.

AFAIK major web browsers all implement their own password store rather
than use libsecret, though apparently Chromium has a build flag to use
libsecret on Linux.
https://source.chromium.org/search?q=3Dlibsecret%20-f:third_party&ss=3Dchro=
mium

>
> What do other application do, when using the keyring to store
> expirable passwords with services that do let you know the
> expiration time of the password?  If they just ask the users again
> only after finding out that the password did not work, perhaps we
> should do the same, without being proactive and notice the expiry
> ourselves?  That is, instead of failing the access to the server
> immediately upon seeing an auth failure, if the authentication
> material is know to have expiration time, can we let the application
> layer to ask the end-user to provide an refreshed password and try
> again?  For such a scheme, we do not have to store ever-changing
> "password_expiry_utc" and contaminate the keyring with crufts whose
> expiry dates are the only difference.  Instead we can just have a
> Boolean "does this site expire a valid password?" and use it to
> behave differently, if desired, from sites for which the passwords
> do not expire, perhaps?
>

In the case of HTTP error 401 Unauthorized, Git calls `credential
reject` then exits. An improvement could be to first call `credential
fill` again (this time without password prompt) and retry if a new
credential is returned. A fresh credential if generated is likely to
be valid. This would improve the experience when using a
credential-generating helper together with a storage helper that drops
password_expiry_utc.

Best remains to use a storage helper that stores password_expiry_utc.
This avoids a doomed HTTP request. Storing oauth_refresh_token is also
beneficial, because OAuth refresh is faster than cold OAuth.
