Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2638207EB
	for <e@80x24.org>; Thu, 27 Apr 2017 01:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934980AbdD0BVR (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 21:21:17 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34776 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752342AbdD0BVP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 21:21:15 -0400
Received: by mail-it0-f68.google.com with SMTP id c26so662502itd.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 18:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zSVXoT9lKRxb9YRGzqZru24GU5GjFVL18HcI1rCCgVE=;
        b=JgEYPYwNC9mrz7715gDSXmW8NJ3Mzc1Qe79ti5WOwt/LyILQGjJF+Afn/mi6i5SdqL
         qQCfs2CFk2AgyxNFdjxjvVjbwlFn8Iy4EP5UK1dqTlir1VonSVKNTM6fksSViFKYpgDK
         tVwr50iV7kBot0UfpfI5MflS5DgctlaS+z2kvysOtANu0B6Hzlzxk3kxgHTRcB2dSYxO
         FUELl2FuYU4AYQuQ6moNCnIGqim8epgeMTehaDcfkd6w4cUktmsXzF3rRGhPMS9Stpxz
         +dYLJHZUP9wCdIqX9Fih1TpKt2H07KmU15tNqC23sE0CBycZwmw9r2tpRZp0/p6HSZvA
         OTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSVXoT9lKRxb9YRGzqZru24GU5GjFVL18HcI1rCCgVE=;
        b=Tt+wu+7Znkz3MnkSZxnAs792H3VQDthU6kwgjsL0DZqf4NBF5j/pjvERJVzjurhko8
         zWIUwRoWL7vSRUAAcngSyHaZPVZpohwX/05kcioFxWnPDPn7plSBw1IYhAJ+YCa+7PHY
         fBVBAGnPr3pR7UFCufWPQm8LJVhpd0afvpoyXmRxodE54neeaccfPX6N3EIoKosbjSH7
         vcssLJY/ayxW/tsL2R0eXbsFcaYjYsvLiXy53CwHnRaYzzSPzgjKjrROGqW6Q0naeJoW
         YxMuERud3Uwk/J3wyy5iA5JSwLBwRuPJNFfXyf1b+0d6awEzPc2xYjpu4jS0mIk6VJm9
         IWlQ==
X-Gm-Message-State: AN3rC/4soX7HgeOUKsVYly8TLhlJCGzTKSSS6DdUFHXtV42LjDEFP1/D
        otoH7AP20XQ4nQ==
X-Received: by 10.36.121.135 with SMTP id z129mr58648itc.43.1493256074178;
        Wed, 26 Apr 2017 18:21:14 -0700 (PDT)
Received: from atris (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.googlemail.com with ESMTPSA id i184sm450541ioi.50.2017.04.26.18.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Apr 2017 18:21:13 -0700 (PDT)
Message-ID: <1493256051.29673.35.camel@gmail.com>
Subject: Re: [PATCH v2] rebase -i: add config to abbreviate command-names
From:   liam Beguin <liambeguin@gmail.com>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Date:   Wed, 26 Apr 2017 21:20:51 -0400
In-Reply-To: <CACBZZX49HZbQ32TTM8V3hSHwEJxkewV3VwfJO75u+D-9RmsOtw@mail.gmail.com>
References: <20170424032347.10878-1-liambeguin@gmail.com>
         <20170425044320.17840-1-liambeguin@gmail.com>
         <CACBZZX49HZbQ32TTM8V3hSHwEJxkewV3VwfJO75u+D-9RmsOtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.5 (3.22.5-1.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

On Wed, 2017-04-26 at 17:24 +0200, Ævar Arnfjörð Bjarmason wrote:
> On Tue, Apr 25, 2017 at 6:43 AM, Liam Beguin <liambeguin@gmail.com> wrote:
> > Add the 'rebase.abbrevCmd' boolean config option to allow `git rebase -i`
> > to abbreviate the command-names in the instruction list.
> > 
> > This means that `git rebase -i` would print:
> >     p deadbee The oneline of this commit
> >     ...
> > 
> > instead of:
> >     pick deadbee The oneline of this commit
> >     ...
> > 
> > Using a single character command-name allows the lines to remain
> > aligned, making the whole set more readable.
> 
> Aside from the existing comments about the commit message from others,
> you should be noting that we *already* have these abbreviations for
> all the todo list options, and we note this in append_todo_help.
> 
> 
> > +rebase.abbrevCmd::
> > +       If set to true, `git rebase -i` will abbreviate the command-names in the
> > +       instruction list. This means that instead of looking like this,
> > +
> > [...]
> > +rebase.abbrevCmd::
> > +       If set to true, `git rebase -i` will abbreviate the command-names in the
> > +       instruction list. This means that instead of looking like this,
> > [...]
> 
> Better to split this out into a new *.txt file and use the include::*
> facility (grep for it) rather than copy/pasting this entirely across
> two files.
> 

Thanks for pointing this out, I'll update the documentation

> >  OPTIONS
> >  -------
> >  --onto <newbase>::
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index 2c9c0165b5ab..9f3e82b79615 100644
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -1210,6 +1210,10 @@ else
> >         revisions=$onto...$orig_head
> >         shortrevisions=$shorthead
> >  fi
> > +
> > +rebasecmd=pick
> > +test "$(git config --bool --get rebase.abbrevCmd)" = true && rebasecmd=p
> 
> Rather than hardcoding "p" here maybe it would be worthhwile to make
> that into a variable used both here and in append_todo_help, maybe
> not...
> 

I'm not sure I understand, do you mean that the option should also affect the
message added by append_todo_help ?

> >  format=$(git config --get rebase.instructionFormat)
> >  # the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
> >  git rev-list $merges_option --format="%m%H ${format:-%s}" \
> > @@ -1228,7 +1232,7 @@ do
> > 
> >         if test t != "$preserve_merges"
> >         then
> > -               printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
> > +               printf '%s\n' "${comment_out}${rebasecmd} $sha1 $rest" >>"$todo"
> >         else
> >                 if test -z "$rebase_root"
> >                 then
> > @@ -1246,7 +1250,7 @@ do
> >                 if test f = "$preserve"
> >                 then
> >                         touch "$rewritten"/$sha1
> > -                       printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
> > +                       printf '%s\n' "${comment_out}${rebasecmd} $sha1 $rest" >>"$todo"
> >                 fi
> >         fi
> >  done
> 
> I haven't tried applying & running this patch, but it seems you
> definitely missed the case where --autosquash will add fixup or
> squash, that should be f or s with your patch, but you didn't change
> that code. See the rearrange_squash function.
> 
> Ditto for turning "exec" into "e" with --exec.
> 

I noticed this yesterday, I'll add both cases the next iteration.

> But if the motivation for this entire thing is to make sure the
> commands are aligned this doesn't fix that, because the sha1s can be
> of different lengths. So as others have pointed out maybe this entire
> thing should be dropped & replaced with some bool command to align the
> todo list, maybe turning that on by default.
> 
> Unless the real unstated reason is to make this easier to edit in vim
> or something, in which case this approach seems reasonable.

Keeping things aligned was the first motivation but the fact that it also
makes changing the action faster is also nice to have. I didn't think it
would help justify the patch.
The SHA1s not having the same length can easily be 'fixed' by setting a
higher value for 'core.abbrev'. 

Thanks, 
Liam 
