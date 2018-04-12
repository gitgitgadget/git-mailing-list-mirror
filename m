Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D5171F424
	for <e@80x24.org>; Thu, 12 Apr 2018 06:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbeDLGwT (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 02:52:19 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:39193 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeDLGwS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 02:52:18 -0400
Received: by mail-wr0-f169.google.com with SMTP id c24so3945298wrc.6
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 23:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=F/wH46vod72ULTBFAoE2Am7US3aa4H1wtN5AZs0HWVY=;
        b=gCcCBYL5lsddrKyR7P9iVj3YG89eXJ9CSMh8do3R5O4wRx6uZPDG6lX1U/Y1+HUA6g
         S/w7mK0dB2J/RmSDyj4a6cm75Hgj/z3m1BzV3lcC4QCYMY7lU3ttDv8GsquPzuFDegJX
         SYtrfIlgv45ZxM/DIEVX9Q1/FxUgUvypuWT034O5e91bddgQpVWmdh8AJT7qnhmUvz6l
         3ketPfFkVeigWz35+CXJk1bXNz44/J7CWop5p88OZhzudhErY2utYb99tnpwMaITVbOK
         UpTaM+R/Oi//teX0TOEG8vGBLuM7fDyydwVe6Rwmak88Wrq3vJH+7WgYfT+cKj8757Ok
         wDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=F/wH46vod72ULTBFAoE2Am7US3aa4H1wtN5AZs0HWVY=;
        b=EHcEIc3/fQq5tE6R10+UG6v0zs1ezW2Ct+u5Z3IjD7nj9/rYJSfSTIc8XsZv3nb/7y
         RFHT7UT7UaW4hVyIJPiHmYlPb9ZC4SEBwshUaHxqHklSwwASEuzO+38+jbCzS6X6cRxK
         LQATt3TU2aQxb50XCoM2/w2VFNVVWcHCOhLgY018tPGF1jEJMmyeplq0RZWp+IfbczLN
         XPXQwGbp4NPa/MjrkvjoNWRZXMn+Lxm67P11zWbFlKylsErd2hLvwIZiwtrQwD4x+Fg0
         /zXLfkTPOk6Yj4TTFDP8j/wDvfOX7ex21+CgGF2ec3eMCEV4ErBhy9qBWkjmKTqGgl8t
         wgAg==
X-Gm-Message-State: ALQs6tALx6EWSpSwLdVRhVTV8LDElsX7zoU0/ZH7K4uJzm8yIUaWhPOL
        TsZ5csIQ3oglTbNMR31H305kCZN9
X-Google-Smtp-Source: AIpwx49/vLlwMyMxblBQ/wRAKuxSaKxnaRDkve9ejD4Lg7OwiE7CFqk+HdIu7iGMRxPBXJ1ngSfNwg==
X-Received: by 10.223.136.24 with SMTP id d24mr5603853wrd.127.1523515936558;
        Wed, 11 Apr 2018 23:52:16 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id o23sm4390461wrf.93.2018.04.11.23.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 23:52:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>,
        Dorab Patel <dorabpatel@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
        Kyle Meyer <kyle@kyleam.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ami Fischman <fischman@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v4] git{,-blame}.el: remove old bitrotting Emacs code
References: <20180327165751.GA4343@aiede.svl.corp.google.com>
        <20180411204206.28498-1-avarab@gmail.com>
        <xmqqk1td2ml2.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqk1td2ml2.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 12 Apr 2018 08:52:13 +0200
Message-ID: <87fu40c3xe.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 12 2018, Junio C. Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> However, since downstream packagers such as Debian are packaging this
>> as git-el it's less disruptive to still carry these files as Elisp
>> code that'll error out with a message suggesting alternatives, rather
>> than drop the files entirely[2].
>>
>> Then rather than receive a cryptic load error when they upgrade
>> existing users will get an error directing them to the README file, or
>> to just stop requiring these modes. I think it makes sense to link to
>> GitHub's hosting of contrib/emacs/README (which'll be updated by the
>> time users see this) so they don't have to hunt down the packaged
>> README on their local system.
>> ...
>>
>>  contrib/emacs/.gitignore   |    1 -
>>  contrib/emacs/Makefile     |   21 -
>>  contrib/emacs/README       |   32 +-
>>  contrib/emacs/git-blame.el |  489 +----------
>>  contrib/emacs/git.el       | 1710 +-----------------------------------
>>  5 files changed, 25 insertions(+), 2228 deletions(-)
>>  delete mode 100644 contrib/emacs/.gitignore
>>  delete mode 100644 contrib/emacs/Makefile
>
> I know I am to blame for prodding you to reopen this topic, but I am
> wondering if removal of Makefile is sensible.  Is the assumption
> that the distro packagers won't be using this Makefile at all and
> have their own (e.g. debian/rules for Debian) build procedure, hence
> *.el files are all they need to have?
>
> The reason why I am wondering is because I do not know what distro
> folks would do when they find that their build procedure does not
> work---I suspect the would punt, and end users of the distro would
> find that git-el package is no longer with them.  These end users
> are whom this discussion is trying to help, but then to these
> packagers, the reason why their build procedure no longer works does
> not really matter, whether git.el is not shipped, or Makefile that
> their debian/rules-equivalent depends on is not there, for them to
> decide dropping the git-el package.
>
> On the other hand, the 6-lines of e-lisp you wrote for git.el
> replacement is something the packagers could have written for their
> users, so (1) if we really want to go extra mile without trusting
> that distro packagers are less competent than us in helping their
> users, we'd be better off to leave Makefile in, or (2) if we trust
> packagers and leave possible end-user confusion as their problem
> (not ours), then we can just remove as your previous round did.
>
> And from that point of view, I find this round slightly odd.

I think the way it is makes sense. In Debian debian/git-el.install just
does:

    contrib/emacs/git-blame.el usr/share/git-core/emacs
    contrib/emacs/git.el usr/share/git-core/emacs

Which means on installation they don't even use our
contrib/emacs/Makefile, but instead on installation do:

    Setting up git-el (1:2.16.3-1) ...
    Install git for emacs
    Install git for emacs24
    install/git: Handling install of emacsen flavor emacs24
    install/git: Byte-compiling for emacs24
    + emacs24 -batch -q -no-site-file -f batch-byte-compile git.el git-blame.el
    Wrote /usr/share/emacs24/site-lisp/git/git.elc
    Wrote /usr/share/emacs24/site-lisp/git/git-blame.elc
    Install git for emacs25
    install/git: Handling install of emacsen flavor emacs25
    install/git: Byte-compiling for emacs25
    + emacs25 -batch -q -no-site-file -f batch-byte-compile git.el git-blame.el

RedHat does use contrib/emacs/Makefile:

    https://src.fedoraproject.org/cgit/rpms/git.git/tree/git.spec#n493

But they can either just do their own byte compilation as they surely do
for other elisp packages, or just do this:

     git-init.el | 5 -----
     git.spec    | 9 ++-------
     2 files changed, 2 insertions(+), 12 deletions(-)

    diff --git a/git-init.el b/git-init.el
    deleted file mode 100644
    index d2a96a7..0000000
    --- a/git-init.el
    +++ /dev/null
    @@ -1,5 +0,0 @@
    -;; Git VC backend
    -(add-to-list 'vc-handled-backends 'GIT t)
    -(autoload 'git-status "git" "GIT mode." t)
    -(autoload 'git-blame-mode "git-blame"
    -       "Minor mode for incremental blame for Git." t)
    diff --git a/git.spec b/git.spec
    index ee60d3e..a82c1aa 100644
    --- a/git.spec
    +++ b/git.spec
    @@ -87,7 +87,6 @@ Source1:        https://www.kernel.org/pub/software/scm/git/%{?rcrev:testing/}%{
     Source9:        gpgkey-junio.asc

     # Local sources begin at 10 to allow for additional future upstream sources
    -Source10:       git-init.el
     Source11:       git.xinetd.in
     Source12:       git-gui.desktop
     Source13:       gitweb-httpd.conf
    @@ -491,14 +490,10 @@ for i in git git-shell git-upload-pack; do
     done

     %global elispdir %{_emacs_sitelispdir}/git
    -make -C contrib/emacs install \
    -    emacsdir=%{buildroot}%{elispdir}
    -for elc in %{buildroot}%{elispdir}/*.elc ; do
    -    install -pm 644 contrib/emacs/$(basename $elc .elc).el \
    +for el in %{buildroot}%{elispdir}/*.el ; do
    +    install -pm 644 contrib/emacs/$elc \
         %{buildroot}%{elispdir}
     done
    -install -Dpm 644 %{SOURCE10} \
    -    %{buildroot}%{_emacs_sitestartdir}/git-init.el

     %if %{libsecret}
     install -pm 755 contrib/credential/libsecret/git-credential-libsecret \

I.e. there's no rule that there *must* be an *.elc file, it's just a
generally good idea, but if your file is purely a one-line (error)
there's no point in pre-compiling it.
