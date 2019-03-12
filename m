Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C4F820248
	for <e@80x24.org>; Tue, 12 Mar 2019 03:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfCLD60 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 23:58:26 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:55843 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfCLD6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 23:58:25 -0400
Received: by mail-it1-f180.google.com with SMTP id z131so2201004itf.5
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 20:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=s4SkZTv4A5PbnuXBfzNDxGgp4tvyswLsz2d3UDCbGP8=;
        b=rCHjDBHtuXS0B7/Yg3NV0nEK6euLMN8d3yyBRODBacnSajiXwfbiynyFB0iWpFDl5e
         eywMyjmcvGmopx9+NNEMun6o54VwpCH2ifwMa4lRD0QIrM6hEVus3NO8nveidpLdZE9F
         ujGXXwLeAQo86rjmy3dijwpiN4xGXDiKrJiKXnI6hWZvkMRI/5ddUvbTPxRliG3RXHiY
         bYcuteBnd4kmhds0LS7gL50klXZyzDf2M94O8gToa1LcOwOnlk786Lwvhj21Aq86xVE+
         /K4PYcpTQa8+wjjE+APJKqSwPrX2Y+4T/dkBE1WP/cc9in0nuUkTmNXqgSVEMcsw0gD3
         I6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=s4SkZTv4A5PbnuXBfzNDxGgp4tvyswLsz2d3UDCbGP8=;
        b=DH24gz+7aOwfmJV3tM+RkTk+Sd/QIAoyhlFVtuUXh7mDQcNNh6zqH6d5mJJWQ58m/h
         J9aSYDjszgYBNH12HPttnz+h0cPMw+EXNeXXgSMKgxCks/LKY/mGh+ysqY7ZCh/ma9bV
         Ca7MsTzdRKm2WBTagXhzOZcr72ag+GVPppXy92MooG3Hmdcu8fVRwFRZ2oaG8pVg5rO+
         xTuDUU60SPSQ9RP9MIR6BTwNXRxwdUPjjcyUFPQM1uWUTGy002rw7UW+cZJ4sgOMNfaE
         XAR2snyYe7rVslLczZVMH83DkaIZmOGXBfP+DGTtgp5SPCRAOiHWXVv3NS9GxFqt5z/l
         DlfA==
X-Gm-Message-State: APjAAAVbcUlcqbbWgfDNAWcPic5eq0tsCZ+29PZS0wjih3xDMWAxnB8z
        yvSwK9QCN2xAbG+6FvFXG4jwQTCxR5t+gnHx320u6rRI
X-Google-Smtp-Source: APXvYqwYsgQniaFZ+bUmuW5ouAuD0imp1CLtsbKSZfxH5jGxoDOWyGhePodC0mW1a/gedfSJwxk6aIJy7IWqtMklk2w=
X-Received: by 2002:a24:7cc4:: with SMTP id a187mr937319itd.171.1552363104760;
 Mon, 11 Mar 2019 20:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8nnFYt0raL+twrG_v8XZn_FDJWyM=tH=QL13Z70_bHRiQ@mail.gmail.com>
 <CAPig+cTCOfDCv=L3EWUqgVZx1VCdqt5ZjmSQMwHLX=R4C4hgTA@mail.gmail.com>
 <CAH8yC8=jtBURyr-mFJSe_cd4zNJfJDt672jZ+izo=z75ZBheug@mail.gmail.com>
 <20190311222805.GA6215@flurp.local> <CAH8yC8kHhhWA+ONv17LdLpvy6ubH3CTvJ6=ehP5MQLi_=n1=bQ@mail.gmail.com>
 <CAH8yC8=PKro1_WW=wJQoVHC88cziJPfgkHh6jNKOUxeFn3KVsQ@mail.gmail.com>
 <CAH8yC8kD3XkYP2o6k3ioCcNB_+wwQ=H2=V03z7Han1K8t2aUsg@mail.gmail.com> <20190312024542.GA7411@flurp.local>
In-Reply-To: <20190312024542.GA7411@flurp.local>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 11 Mar 2019 23:57:53 -0400
Message-ID: <CAH8yC8=gsuknMOAYyjVDyZENDiJoRia+MnwhsMhZdcnfuO=cbw@mail.gmail.com>
Subject: Re: Solaris and sed: Too many commands, last: s/\n//
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 10:45 PM Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
>
> On Mon, Mar 11, 2019 at 10:11:41PM -0400, Jeffrey Walton wrote:
> > On Mon, Mar 11, 2019 at 9:55 PM Jeffrey Walton <noloader@gmail.com> wro=
te:
> > > Oh man, you're using GNU make. I thought Git was using that anemic
> > > Posix Make. See attached.
> > >
> > > I think Solaris provides an older gawk. Is this an easier problem:
> > >
> > >     awk: chainlint.sed:88: :squash
> > >     awk: chainlint.sed:88: ^ syntax error
> > >     awk: chainlint.sed:91:  s/\\\n//
> > >     awk: chainlint.sed:91:    ^ backslash not last character on line
> > >     Usage: awk [POSIX or GNU style options] -f progfile [--] file ...
> > >     Usage: awk [POSIX or GNU style options] [--] 'program' file ...
> >
> > My bad , there was a typo... 'awk' got assigned to SED variable.
> >
> > This patch works as expected.
> >
> > diff --git a/t/Makefile b/t/Makefile
> > @@ -11,11 +11,25 @@ SHELL_PATH ?=3D $(SHELL)
> >  TAR ?=3D $(TAR)
> > +AWK ?=3D $(AWK)
> > +SED ?=3D $(SED)
> > +GREP ?=3D $(GREP)
> >
> > +# Fix Solaris tools. These are Posix. GNU tools located at /usr/gnu/bi=
n.
> > +ifneq ($(wildcard /usr/gnu/bin/grep),)
> > +  GREP :=3D /usr/gnu/bin/grep
> > +endif
> > +ifneq ($(wildcard /usr/gnu/bin/sed),)
> > +  SED :=3D /usr/gnu/bin/sed
> > +endif
> > +ifneq ($(wildcard /usr/gnu/bin/awk),)
> > +  SED :=3D /usr/gnu/bin/awk
> > +endif
>
> I think the last assignment ought to be "AWK :=3D ...".
>
> Anyhow, this sort of platform-specific tool customization is typically do=
ne by config.mak.uname in the top-level Git directory. In fact, there's alr=
eady a section for SunOS:
>
>     ifeq ($(uname_S),SunOS)
>         ...
>         SANE_TOOL_PATH =3D /usr/xpg6/bin:/usr/xpg4/bin
>         ...
>
> Prepending /usr/gnu/bin to SANE_TOOL_PATH might be a good idea as a first=
 step toward fixing the problem you're seeing on Solaris, however, as =C4=
=86var mentioned in [1], SANE_TOOL_PATH isn't presently consulted when runn=
ing tests. But, as he suggested, fixing the tests to respect SANE_TOOL_PATH=
 might be a good solution overall.
>
> So, rather than making platform-specific customizations to t/Makefile, an=
 arguably better solution would be to update config.mak.uname to add /usr/g=
nu/bin to SANE_TOOL_PATH and then update the test system to respect that va=
lue (thus, these GREP, SED, AWK specializations can be avoided).

I may have been blowing away SANE_BUILD_PATH.

My build script calls:

   SANE_BUILD_PATH=3D"<my updated tool path> \
   PKG_CONFIG_PATH=3D"..." \
   ... \
./configure \
    --prefix=3D<my new tool location> \
    --libdir=3D"..." \
    ...

I set SANE_BUILD_PATH in the environment because I want Git to use the
new tools being built for testing.

Or, if Git is blowing away my SANE_BUILD_PATH , then that might
explain the encoding failures. The updated tools, like new iConv and
Unistring, are not on PATH. The updated tools are located at
/var/sanitize/bin, and are passed through SANE_BUILD_PATH .

This might also explain the intermittent crashes I see. Old tools from
/usr/bin are used, but new libraries from /var/sanitize/lib are used
because of LD_LIBRARY_PATH. Gotta love those fucking path problems
that have plagued Linux for the last 30 years. The idiot who figured
it was a good idea to compile and link against one library, and then
load the wrong library at runtime, should get a platinum Darwin award.

It may be better to set SANE_TOOL_PATH something like:

    SANE_TOOL_PATH =3D "$SANE_TOOL_PATH:/usr/xpg6/bin:/usr/xpg4/bin"

Jeff
