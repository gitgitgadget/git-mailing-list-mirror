Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EF7E1F609
	for <e@80x24.org>; Wed, 28 Nov 2018 23:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbeK2KaW (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 05:30:22 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34028 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbeK2KaW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 05:30:22 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so36487lfc.1
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 15:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=59m+ISi3m8SMkDfr8z7DcOmVKC1G1P7ofzZz//vVe3w=;
        b=GO8/AIR4gR4GbwoteYgDiPKz/UR9TeZHcsTefe58DKf9R9H1EUC157TS0FgVSObFs5
         pquXOdbarex22vkFq9H2LITSbvdv0zS96S06TOZaths9/zumLBOMXON4l2HAPocw+EHT
         a95OAwXSOjsBUDhW8S2gnrBoIkgq+N96whRef5AgLJOL22HZw9QOfn2K/BhtjNOwnM8D
         c++C5QsALb+LqYHPOsgpqJ2jkJLctJawygjI4ku1mBMAAoOTm710lgAbrXqG56wu+qeO
         N6H/dXK1Mw6gsCLTxFi7JC0OBgbyMOSWEZGE9x16X+Yrp0lxinDU3/SOanKkOPdu7CfT
         MzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=59m+ISi3m8SMkDfr8z7DcOmVKC1G1P7ofzZz//vVe3w=;
        b=cxzwXstnaOdQOCad0ifZfvcVzeW1b5XIVzqTHcBup72ycz9mPIBANqES99XuFYLCcR
         PajcFAWZVm7FSPWPA01hZAMknkeuk1or1tr/rxnxXL0RIuPMzhzA6SJM5G4TmfVqgySr
         BEyxOt0+7lShhUGqpV+/zW1tSjjnyF5Fn3reN9KfpxL88Opp0MJvj7nts6aJ+DXuNRKJ
         J3hXza4eeoLpwb7L9ArhbBRJfMq0ZytNJSAuT5OdMHi3tlJuaNAPZAjrarihGSlNK/8A
         4Ne68Tj9zgnKwmX5L9Z9yQEVfa2uwLrLRkbvzNtypfNVb09GmBP6cYCHxTqYGZTsBzEP
         JjJw==
X-Gm-Message-State: AA+aEWYm/Vrv4RDftxomR3MET1IBnip81NYiT4XM1pBv5A01KC41G8X+
        hIsMVLro/I/s7S/PTcyG5CRmsx7iriFH3aZAJL9ggr8t
X-Google-Smtp-Source: AFSGD/VsfF/GsToUbyrgmMRdZ/+Tqwl6O+pgNy/WRuRMZvQ+22oYvvtCmm6i2KM5uhHVuSGHyy+Jdj3xswC6J22yFdU=
X-Received: by 2002:a19:e601:: with SMTP id d1mr16343303lfh.71.1543447621979;
 Wed, 28 Nov 2018 15:27:01 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
 <20181127165211.24763-7-pclouds@gmail.com> <xmqqftvlspqn.fsf@gitster-ct.c.googlers.com>
 <CACsJy8Bzs=FYKrR6h1cqVH32eEt2t8rUMtE2yFNvt+W55u=sDA@mail.gmail.com> <CAPL8ZiuaEW5tp8ZMOZtZcb5oi3L-pDF6ajcA7b5wnH3=7Ls7Tg@mail.gmail.com>
In-Reply-To: <CAPL8ZiuaEW5tp8ZMOZtZcb5oi3L-pDF6ajcA7b5wnH3=7Ls7Tg@mail.gmail.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Wed, 28 Nov 2018 15:26:50 -0800
Message-ID: <CAPL8ZivJ+=Y=8pxvs3sJrdxVtkn9xfTA63GeHcr=J0Y2JscOMQ@mail.gmail.com>
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

Although I have no problem with "switch-branch" as a command name,
some alternative names we might consider for switch-branch might be:

chbranch
swbranch
switch
branch change (as a subcommand for the "branch" command)

I've personally been using "chbranch" as an alias for this
functionality for some time.

  - Stefan
On Wed, Nov 28, 2018 at 3:22 PM Stefan Xenos <sxenos@google.com> wrote:
>
> > Since the other one is already "checkout-files", maybe this one could j=
ust be "checkout-branch".
>
> I rather like switch-branch and dislike the word "checkout" since it
> has been overloaded in git for so long (does it mean moving HEAD or
> copying files to my working tree?)
>
> > nobody will become "sick of" the single "checkout" command that can
>
> I have to admit I'm already sick of the checkout command. :-p I can
> see myself using these two new commands 100% of the time and never
> missing the old one.
>
> Some behaviors I'd expect to see from these commands (I haven't yet
> checked to see if you've already done this):
>
> git checkout-files <tree-ish>
> should reset all the files in the repository regardless of the current
> directory - it should produce the same effect as "git reset --hard
> <tree-ish> && git reset HEAD@{1}". It should also delete
> locally-created files that aren't present in <tree-ish>, such that the
> final working tree is exactly identical to what was committed in that
> tree-ish.
>
> git checkout-files foo -- myfile.txt
> should delete myfile.txt if it is present locally but not present in foo.
>
> git checkout-files foo -- .
> should recursively checkout all files in the current folder and all
> subfolders, and delete any locally-created files if they're not
> present in foo.
>
> git checkout-files should never move HEAD in any circumstance.
>
> Suggestion:
> If git checkout-files overwrites or deletes any locally-modified files
> from the workspace or index, those files could be auto-stashed. That
> would make it easy to restore them in the event of a mistyped command.
> Auto-stashing could be suppressed with a command-line argument (with
> alternate behaviors being fail-if-modified or always-overwrite).
>
> Idea:
> If git checkout-files modifies the submodules file, it could also
> auto-update the submodules. (For example, with something like "git
> submodule update --init --recursive --progress").
>
>   - Stefan
> On Wed, Nov 28, 2018 at 7:31 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Wed, Nov 28, 2018 at 7:03 AM Junio C Hamano <gitster@pobox.com> wrot=
e:
> > >
> > > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
> > >
> > > > The good old "git checkout" command is still here and will be until
> > > > all (or most of users) are sick of it.
> > >
> > > Two comments on the goal (the implementation looked reasonable
> > > assuming the reader agrees with the gaol).
> > >
> > > At least to me, the verb "switch" needs two things to switch
> > > between, i.e. "switch A and B", unless it is "switch to X".
> > > Either "switch-to-branch" or simply "switch-to", perhaps?
> > >
> > > As I already hinted in my response to Stefan (?) about
> > > checkout-from-tree vs checkout-from-index, a command with multiple
> > > modes of operation is not confusing to people with the right mental
> > > model, and I suspect that having two separate commands for "checking
> > > out a branch" and "checking out paths" that is done by this step
> > > would help users to form the right mental model.
> >
> > Since the other one is already "checkout-files", maybe this one could
> > just be "checkout-branch".
> >
> > > So I tend to think
> > > these two are "training wheels", and suspect that once they got it,
> > > nobody will become "sick of" the single "checkout" command that can
> > > be used to do either.  It's just the matter of being aware what can
> > > be done (which requires the right mental model) and how to tell Git
> > > what the user wants it do (two separate commands, operating mode
> > > option, or just the implied command line syntax---once the user
> > > knows what s/he is doing, these do not make that much a difference).
> >
> > I would hope this becomes better defaults and being used 90% of time.
> > Even though I know "git checkout" quite well, it still bites me from
> > time to time. Having the right mental model is one thing. Having to
> > think a bit every time to write "git checkout" with the right syntax,
> > and whether you need "--" (that ambiguation problem can still bite you
> > from time to time), is frankly something I'd rather avoid.
> > --
> > Duy
