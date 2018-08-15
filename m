Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78AC61F404
	for <e@80x24.org>; Wed, 15 Aug 2018 15:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbeHOSTB (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 14:19:01 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46114 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbeHOSTB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 14:19:01 -0400
Received: by mail-ua1-f68.google.com with SMTP id u11-v6so1611837uan.13
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 08:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6gK9IaPXJgL/p9RtPI2cUi3SgS6CFTJ748sU+G8HQYo=;
        b=jx3EjSjKiPes+irbYJ0qFm9KJv036ppAYgmGEjXTCXlayibN7aajVMwZ67j+x3CRdx
         ND1CFEPz+5dHU+QXZI5cvTVU2SfMKDvk8I3Mn8chxvyU4UFThu4ijzpkjysWjN+NtJKH
         kaX/Wvl8EWVvawgXUEGLJ1nJ2d9Y6xSE8C6q/jFdMEMQN1RDnTro+E6XNSlVPb43EgQO
         RtPIJqZLjGthlewM9ozd/GFs31C4tAyBlfqXLApR1AlRLEi3ofb+NrpNwS8xXr9ARwD4
         Cwop9AN4WVZ2efXwPc2dYkNIo1pdXKNTwqO4K4NmZJ2147w56GxDWLDkBv7LyGVdTa6c
         TkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6gK9IaPXJgL/p9RtPI2cUi3SgS6CFTJ748sU+G8HQYo=;
        b=PVdJprY3uQW9HBAO+B4z/Cl46iQLWnSTgk2750T3WoYw2q0R6fYJlbKDOlZXi8FUCb
         xlckV2E+cN0GxN9u1nvRR7K6TyCONk8z5kMZ8mztro7Y8HGN3RpFi2w/u5AlsxIPZJBz
         r9ZPNwOTzjKBumzu3T+PWx3erxUYi0LQDW0JVtamTVvBjzf/bAiDNBivqp7yZnalvRmE
         I16VG2DTXROa7yeuPBjMxScPR4prHUj20SxDm2BJQhwjWZceod/lbt/rt3J19BPLUndG
         dNr23hGKr/wYxdqmqDgntRBcTFWK9fIp2Moha6aRtXTwhYyI4CKqgHDUMsQD+AFXsZUh
         0zhg==
X-Gm-Message-State: AOUpUlGqUTwWllfR6MfIRM3DOcvDnw+mLSOlV8ZDHAty0/oJNBPuAyn/
        Ps7oYYKfZqrRUPD7PG0KLOKrf2dOPvpd0frTSAY=
X-Google-Smtp-Source: AA+uWPzD4+hEGikQItvTdWey0R9bUJzQuw+dH+VF9heoJRUahSnV4b8YcVeMG2oLeNe9f7AuNLJBsvElxy9aC/nzJes=
X-Received: by 2002:a9f:3d1a:: with SMTP id l26-v6mr17215951uai.29.1534346784499;
 Wed, 15 Aug 2018 08:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180811205024.11291-1-newren@gmail.com> <20180813171749.10481-1-newren@gmail.com>
 <20180813171749.10481-2-newren@gmail.com> <20180815051011.GC32543@aiede.svl.corp.google.com>
 <CABPp-BFk2X5TApYzs3QtdokBs3Hqz9uX737M6RGMtaU+wYUikw@mail.gmail.com>
 <20180815061346.GJ32543@aiede.svl.corp.google.com> <CABPp-BGVVXcbZX44er6TO-PUsfEN_6GNYJ1U5cuoN9deaA48OQ@mail.gmail.com>
In-Reply-To: <CABPp-BGVVXcbZX44er6TO-PUsfEN_6GNYJ1U5cuoN9deaA48OQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 15 Aug 2018 08:26:12 -0700
Message-ID: <CABPp-BGp_uEWF=+ENcd2SkL=PDu_NtzObFAz1Gz33OemgZbogA@mail.gmail.com>
Subject: Re: [PATCHv3 1/6] Add missing includes and forward declares
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 11:51 PM Elijah Newren <newren@gmail.com> wrote:
> > [...]
> > >> enums are of unknown size, so forward declarations don't work for
> > >> them.  See bb/pedantic for some examples.
> > >
> > > structs are also of unknown size; the size is irrelevant when the
> > > function signature merely uses a pointer to the struct or enum.  The
> > > enum forward declaration fixes a compilation bug.
> >
> > My rationale may miss the point but the standard and some real compilers
> > don't like this, unfortunately.
> >
> > For structs, having an incomplete type is fine, but for enums we need
> > the full definition.  E.g. C99 sayeth (in section 6.7.2.3 "tags")
> >
> >         A type specifier of the form
> >
> >                 enum identifier
> >
> >         without an enumerator list shall only appear after the type it
> >         specifies is complete.
>
> What about a type specifier of the form
>   enum identifier *
> ?  Can that kind of type specifier appear before the full definition
> of the enum?  (Or, alternatively, if the standard doesn't say, are
> there any compilers that have a problem with that?)
>
> If so, we can include cache.h instead.  We'll probably also have to
> fix up packfile.h for the exact same issue (even the same enum name)
> if that's the case.

Digging a little further this morning, apparently C++ has defined a
forward declaration of an enum to either be useless (because it was
already defined), require an explicit size specifier, or be a
compilation error.

That seemed stupid to me, but a little more digging turned up
http://c-faq.com/null/machexamp.html , which states that sizeof(char*)
!= sizeof(int*) on some platforms.  That was a big surprise to me.
Since an enum could be a char or int (or long or...), knowing the size
of the enum thus is important to knowing the size of a pointer to an
enum, so we actually do need the full enum definition (or a C++ style
explicit size specifier).

What a crazy world.

So, I'll go with the inclusion of cache.h and also fix up packfile.h
the same way.  Thanks for pointing this out, Jonathan.
