Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0BF01F609
	for <e@80x24.org>; Wed, 28 Nov 2018 23:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeK2Kla (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 05:41:30 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35811 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeK2Kla (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 05:41:30 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so59315ljb.2
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 15:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1w8Icyb48SifMlpa+WPFjprtJmowYFv+omiMVZ8fX3o=;
        b=FWST8MId9xHAIwq9VgqqaOm7CQSXvSLaIaGW5wxPUufGg6vj86wzsF5GiUbMCdA8jr
         Tmrg+zIbCfv1HViL5OK8We8hNGZVqhNn14fuYdlnjvrtZOW3b3mUDhVGciCG0fg/765f
         62/U0fVBPt5WUYOnTJUbAuSYxtwSA6tb1PWQJLcKESeD3iijzsG4RFOgTfvs6R+pyiwZ
         G5OzDAkTYDUoozXAUOTM1OtJJzrTJl1nJD3mluxgIRVCHNhom+ss9FLr2R7Zq1kewUIp
         JB7I6epkvAbwsIQrT1AVKDYbxfyhu8KrW2nHpeKq19s90x56pxZHkOhpKObxhDPC+Cvc
         pqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1w8Icyb48SifMlpa+WPFjprtJmowYFv+omiMVZ8fX3o=;
        b=uGYhCi5eZKbT4IdBZJvjMqtFsZqKLhK+BHCUTctLPr4owQUN1H+AMnX9FgBU4mV08Y
         uQnHujJhYKjaTiPRx7VBHUuGBQHawf75UR9psi1yWIlyTvy5D6HNEwteFhHewRrKeHpG
         kgRgmu44+cFBypfMF8VuBqMQXn43oyTHIgzazqqmby98Dv/1e+aLOXZOP8NXs2/bwVIx
         eh1o/+yVE24WROPem1e3Q1AO+FwtST0K6xT3vPVGii0U8tTJThzN6cSxZ7IWoLspJVKT
         gmQNY/4BqN91+rb0rKM3EvHyySDSlCDu6q9hxKuyTHmfzf1J9QW9u6gcHA0pHrvurCCN
         1O0g==
X-Gm-Message-State: AA+aEWYYd5HT39JTbCLalWZrLTLUP/KKf63bSMhX3xFquoG1ZFT3tNOR
        w8Zm8HClpndgglw8ZgfNS+knq5ZcuuzE+NsaJNaloQ==
X-Google-Smtp-Source: AFSGD/Xm2QyhaYRYBd0elrbKa7xz7y4faP+ZfMX1hCWR5+p2D+BNZGL3K3Eeu5YdO+lEJeOlgI7K8p2oT3tgKISTErA=
X-Received: by 2002:a2e:994:: with SMTP id 142-v6mr21725172ljj.120.1543448287753;
 Wed, 28 Nov 2018 15:38:07 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
 <20181127165211.24763-7-pclouds@gmail.com> <xmqqftvlspqn.fsf@gitster-ct.c.googlers.com>
 <CACsJy8Bzs=FYKrR6h1cqVH32eEt2t8rUMtE2yFNvt+W55u=sDA@mail.gmail.com>
 <CAPL8ZiuaEW5tp8ZMOZtZcb5oi3L-pDF6ajcA7b5wnH3=7Ls7Tg@mail.gmail.com> <CAPL8ZivJ+=Y=8pxvs3sJrdxVtkn9xfTA63GeHcr=J0Y2JscOMQ@mail.gmail.com>
In-Reply-To: <CAPL8ZivJ+=Y=8pxvs3sJrdxVtkn9xfTA63GeHcr=J0Y2JscOMQ@mail.gmail.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Wed, 28 Nov 2018 15:37:56 -0800
Message-ID: <CAPL8ZisWR_uzoy2wYqgpNfxNvcjD7wvB4HN90FT9aeK54DCd=Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] checkout: split into switch-branch and checkout-files
To:     pclouds@gmail.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        t.gummerer@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

More thoughts:

git switch-branch should never detach HEAD unless asked to do so
explicitly. That also means that "git switch-branch" shouldn't accept
any of the non-branch tree-ish arguments that would have caused "git
checkout" to do so.
On Wed, Nov 28, 2018 at 3:26 PM Stefan Xenos <sxenos@google.com> wrote:
>
> Although I have no problem with "switch-branch" as a command name,
> some alternative names we might consider for switch-branch might be:
>
> chbranch
> swbranch
> switch
> branch change (as a subcommand for the "branch" command)
>
> I've personally been using "chbranch" as an alias for this
> functionality for some time.
>
>   - Stefan
> On Wed, Nov 28, 2018 at 3:22 PM Stefan Xenos <sxenos@google.com> wrote:
> >
> > > Since the other one is already "checkout-files", maybe this one could=
 just be "checkout-branch".
> >
> > I rather like switch-branch and dislike the word "checkout" since it
> > has been overloaded in git for so long (does it mean moving HEAD or
> > copying files to my working tree?)
> >
> > > nobody will become "sick of" the single "checkout" command that can
> >
> > I have to admit I'm already sick of the checkout command. :-p I can
> > see myself using these two new commands 100% of the time and never
> > missing the old one.
> >
> > Some behaviors I'd expect to see from these commands (I haven't yet
> > checked to see if you've already done this):
> >
> > git checkout-files <tree-ish>
> > should reset all the files in the repository regardless of the current
> > directory - it should produce the same effect as "git reset --hard
> > <tree-ish> && git reset HEAD@{1}". It should also delete
> > locally-created files that aren't present in <tree-ish>, such that the
> > final working tree is exactly identical to what was committed in that
> > tree-ish.
> >
> > git checkout-files foo -- myfile.txt
> > should delete myfile.txt if it is present locally but not present in fo=
o.
> >
> > git checkout-files foo -- .
> > should recursively checkout all files in the current folder and all
> > subfolders, and delete any locally-created files if they're not
> > present in foo.
> >
> > git checkout-files should never move HEAD in any circumstance.
> >
> > Suggestion:
> > If git checkout-files overwrites or deletes any locally-modified files
> > from the workspace or index, those files could be auto-stashed. That
> > would make it easy to restore them in the event of a mistyped command.
> > Auto-stashing could be suppressed with a command-line argument (with
> > alternate behaviors being fail-if-modified or always-overwrite).
> >
> > Idea:
> > If git checkout-files modifies the submodules file, it could also
> > auto-update the submodules. (For example, with something like "git
> > submodule update --init --recursive --progress").
> >
> >   - Stefan
> > On Wed, Nov 28, 2018 at 7:31 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > >
> > > On Wed, Nov 28, 2018 at 7:03 AM Junio C Hamano <gitster@pobox.com> wr=
ote:
> > > >
> > > > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writ=
es:
> > > >
> > > > > The good old "git checkout" command is still here and will be unt=
il
> > > > > all (or most of users) are sick of it.
> > > >
> > > > Two comments on the goal (the implementation looked reasonable
> > > > assuming the reader agrees with the gaol).
> > > >
> > > > At least to me, the verb "switch" needs two things to switch
> > > > between, i.e. "switch A and B", unless it is "switch to X".
> > > > Either "switch-to-branch" or simply "switch-to", perhaps?
> > > >
> > > > As I already hinted in my response to Stefan (?) about
> > > > checkout-from-tree vs checkout-from-index, a command with multiple
> > > > modes of operation is not confusing to people with the right mental
> > > > model, and I suspect that having two separate commands for "checkin=
g
> > > > out a branch" and "checking out paths" that is done by this step
> > > > would help users to form the right mental model.
> > >
> > > Since the other one is already "checkout-files", maybe this one could
> > > just be "checkout-branch".
> > >
> > > > So I tend to think
> > > > these two are "training wheels", and suspect that once they got it,
> > > > nobody will become "sick of" the single "checkout" command that can
> > > > be used to do either.  It's just the matter of being aware what can
> > > > be done (which requires the right mental model) and how to tell Git
> > > > what the user wants it do (two separate commands, operating mode
> > > > option, or just the implied command line syntax---once the user
> > > > knows what s/he is doing, these do not make that much a difference)=
.
> > >
> > > I would hope this becomes better defaults and being used 90% of time.
> > > Even though I know "git checkout" quite well, it still bites me from
> > > time to time. Having the right mental model is one thing. Having to
> > > think a bit every time to write "git checkout" with the right syntax,
> > > and whether you need "--" (that ambiguation problem can still bite yo=
u
> > > from time to time), is frankly something I'd rather avoid.
> > > --
> > > Duy
