Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BC481F462
	for <e@80x24.org>; Sat,  8 Jun 2019 16:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfFHQU4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jun 2019 12:20:56 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:34883 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfFHQUz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jun 2019 12:20:55 -0400
Received: by mail-vs1-f45.google.com with SMTP id u124so2986672vsu.2
        for <git@vger.kernel.org>; Sat, 08 Jun 2019 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tsCcMFZwJ4Z2cYpAKmk35cK1XI2RUnsTQMvuZT509zs=;
        b=nm16LesHTP06jY7UPmGUd72QPkvDiPD8WX0BmYF/gvxwonJEilx8+TYASOU+g8Ik5s
         GCpvcsouZjXO6L4LZF3mifDo8HthdDOrcQ/xQbkofOiXldm2pF/AWjooX+kKKB3xCW+/
         IiV/h50RJzmgFdQGWcroIIixuXF4ukVBb6KGpve44WSQGQ/K1+3/n+WzXwiWpH7VOhKh
         fxSdi7bY9q2QoVSrmFDU6yDSqq1AP8S4Wiuwq7EGFIbxn3HCyNtttDfw2eo7Lms8HhMk
         HGsAQwv0luUNPIcj+Dy43YpiRmEBUFXaqm0OSi8Y0tPVnTkqPEibXxf4LtpFlgMqP7iH
         qYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tsCcMFZwJ4Z2cYpAKmk35cK1XI2RUnsTQMvuZT509zs=;
        b=PkKxmFqFlJfczNXB0D/7YE38diepci8jLvoHfcqRK5N89E2vZWaTvA01bOq60qtdNN
         OOmlRo+fBFPuHSehum/JXM+GIl3K4/OOAEY8Kg/1QR7Ox5CXmFc/eldygTytvlv8Z7ib
         VeE+z51ltIbJwRCBkmczQ3GdKoviDEM4LBY/Ejc3ticEKBAoH5VXGfL0v97of4k8zkoF
         ukgZGH+ighZteIZyMOqLDI5EudpcwJlRW+CmKYuXR/ximf4Uj9dz7XhZhaWl6ZoI8lfa
         CWlXh0QSjp1lGlyUV5QviUf35U/JEA9lX7Srg7nDs4Ejf1WtLOJ2Lf38oM+aRGAwtUwA
         Y+TA==
X-Gm-Message-State: APjAAAW5r2+JziI68GEFckzxVVGeIun6gnPNB1s9TmvSyDEhGnqrIfXT
        I+dZsj9j8uEJaFe/hC+Q7RbqON5fcip2IV+Vj9E=
X-Google-Smtp-Source: APXvYqzznloZ+6NI72EtK0y8MUQh9TpjwxKbepTVL/UaAoa1Q2gQsKdvYTilqS0Hr5y/0ay6JjuLyNcXw9agxDT7ZEg=
X-Received: by 2002:a67:8081:: with SMTP id b123mr22460766vsd.117.1560010854213;
 Sat, 08 Jun 2019 09:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BFC--s+D0ijRkFCRxP5Lxfi+__YF4EdxkpO5z+GoNW7Gg@mail.gmail.com>
 <875ztukt77.fsf@evledraar.gmail.com>
In-Reply-To: <875ztukt77.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 8 Jun 2019 09:20:42 -0700
Message-ID: <CABPp-BHqdKvsUDx40Tz-A3z32TN_KWcDENWb8zsaidxxf8SNCg@mail.gmail.com>
Subject: Re: New command/tool: git filter-repo
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Now that there's a released version of git that has all necessary
flags and features[1] to run git filter-repo
(https://github.com/newren/git-filter-repo), I thought I'd send an
update...

On Fri, Feb 8, 2019 at 10:53 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Jan 31 2019, Elijah Newren wrote:
>
> > What's the future?  (Core command of git.git?  place it in contrib?  ke=
ep it
> > in a separate repo?)  I'm hoping to discuss that at the contributor sum=
mit
> > today, but feedback on the list is also welcome.
>
> Some of this I may have mentioned at the summit, but here for the list:
>
> * I think it should be a candidate for a core (not "just contrib")
>   git.git command, given that we have someone willing to maintain it &
>   deal with bugs etc. I'm not worried about that given the author.
>
> * It's unfortunate in terms of API we need to support going forward that
>   this obligates us to support a fairly intricate python API going
>   forward, so it's similar (but more detailed) to Git.pm (which I also
>   tried to get rid of as an external API a while ago).
>
>   However, as you correctly note that's the only way a command like this
>   can be really fast, we already have the "no special API" command with
>   git-filter-branch, and that's horribly slow.
>
>   But perhaps there's ways we can in advance deal with a potential
>   future breaking API change. E.g. some Pythonic way of versioning the
>   API, or just prominently documenting whatever (low?) stability
>   guarantees we're making.
>
>   I imagine if we need to make breaking changes in the future that'll
>   less big of a deal than in other cases, since we'd expect the API use
>   to be one-off migration scripts, although maybe it'll get used for
>   all-the-time exports (e.g. mirroring internal->external repos with
>   filtering).
>
> * The rest of our commands are hooked up to the i18n framework. I don't
>   think this should be a blocker, but it's worth thinking about what the
>   plan for this is.
>
>   Are we going to need the equivalent of Git::I18N for Python (which
>   presumably will be a run-time dependency on something needing the
>   Python API that links to gettext).
>
>   Or perhaps we could do the translated strings in C, by making the
>   program you're invoking be a C command, invoking the Python part as a
>   helper (which would need to re-invoke a helper if it prints its own
>   messages).
>
> Thanks for working on this!

I've implemented these, and several other things too.  Changes since last t=
ime:

* Now i18n-ized
* Several disclaimers about API backcompat (this is more of a one-shot
conversion tool) [2]
* Converted to Python3 (Python2 is EOL at EOY)
* Pruning of become-empty and become-degenerate+empty commits has been
fixed up (I mentioned this as a concern last time)
* Testsuite has been fleshed out, including not only multiple small
fixes to filter repo, but more fixes to git itself[3]
* Usage, Examples, Internals, and Limitations documentation now exists
(in README.md format and built-in -h help; no manpage yet)
* Several new filters and abilities have been added

Now that filter-repo is complete and more easily tested, what are
folks thoughts on incorporating it in git.git?  (And if we do go that
route, can we avoid losing its history so I can bisect issues if
necessary?)

Thanks,
Elijah


[1] Well, except people will get an error if they use
--preserve-commit-encoding saying they don't have a new enough git
since en/fast-export-encoding is still sitting in next and didn't make
it in to git-2.22.  But I only know of one repo that even uses special
commit encodings, so I suspect few if any will even care about that
flag.

[2] The warnings appear in several places to try to make sure people
notice them; a not quite complete list:
https://github.com/newren/git-filter-repo/blame/master/README.md#L620-L625
https://github.com/newren/git-filter-repo/blame/master/README.md#L727-L730
https://github.com/newren/git-filter-repo/blame/master/README.md#L989-L993
https://github.com/newren/git-filter-repo/blob/master/git-filter-repo#L13-L=
30
https://github.com/newren/git-filter-repo/blob/master/git-filter-repo#L1523=
,L1524
https://github.com/newren/git-filter-repo/blob/master/t/t9391/commit_info.p=
y#L4-L6
https://github.com/newren/git-filter-repo/blob/master/t/t9391/create_fast_e=
xport_output.py#L4-L6
https://github.com/newren/git-filter-repo/blob/master/t/t9391/file_filter.p=
y#L4-L6
https://github.com/newren/git-filter-repo/blob/master/t/t9391/splice_repos.=
py#L4-L6
https://github.com/newren/git-filter-repo/blob/master/t/t9391/strip-cvs-key=
words.py#L4-L6

[3] https://github.com/newren/git-filter-repo/tree/develop#upstream-improve=
ments
