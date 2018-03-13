Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07B731F404
	for <e@80x24.org>; Tue, 13 Mar 2018 02:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932282AbeCMCxN (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 22:53:13 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:39295 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932246AbeCMCxM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 22:53:12 -0400
Received: by mail-vk0-f42.google.com with SMTP id f6so7606007vkh.6
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 19:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jP+pwQGlt025wDdvMBkJkkvsmH05RC9MaRh2CekSibk=;
        b=vhWDL4OcBySW65AtCWRN8qVbXnAEtB7yScrrPL5gWGDYRaX3chHERRSFsWcX/00rCy
         oAE2p7MzG10VDB5RQE5QWyg98deUsz6rsPbQuHYzxZCdhpV94lzCNdormHrbNN0opCN4
         CqbAMWpTxKd5nfW0ndUsuu5P+AM/4rRadYZXXOK3gcE6AzfdAsHZSGVEbkOe1/87Oewh
         GR/75uFgTsAMhE8krHAsVcE6ANkJPMUzR4Mrp/rTAyhMtjqTbG9TQaz9N25YossDGqCY
         HTiFgieHFSlQzLhppVPfXDjDv9Mzy6sze4h1DK8aaBxa22kCoN29P3aZ7Zsr27nJAAOW
         KwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jP+pwQGlt025wDdvMBkJkkvsmH05RC9MaRh2CekSibk=;
        b=U9YJDGkzp8RsxvehWzL7jw8jBJNmm7a2xOVA+fIlmzmr3vj1FH3FW7TFfIhphd7NCV
         ysn7U6CfpgdtLDgqW+DCTckEQ/5+Ox/NYr7u6FZEMIKo80vchW7zAlcmu3XyS/LtbVJO
         BR5/EK2TsPgIpGtwc5j/HThzaK/9CgJmUZ4yToySUaVvN3HYtlbcTHuXo8pJ1h3KHjLf
         N3wwjiTZethf8DGHsCvqSpQKvDAjnfm1lq8eC5EV2VMjsH90BUbZJgLzE7xzWxpwb7UN
         oV/IPu9GsP4jtVcqW7R7edWWyJVy13aP+Ba8KinZYntCdpDOrq350yzhoEB2NaFMuT8k
         q0Kg==
X-Gm-Message-State: AElRT7EqQOkDV7o6npkswo+pvmnfDSNtn11iyx/hRV7RZpBQkYNZv8/z
        liSOB1eEKUIJE0N37K3jbhwZZTQUmZhu8P2M5h8=
X-Google-Smtp-Source: AG47ELuwRiNCFbE0WfPbjuOqiV4gzb1RsFshSpsaYrjiOosKzYmQs23RKRdTmuqQRnqYko7jZMpzBra8qrQ5pBqM9Sc=
X-Received: by 10.31.194.78 with SMTP id s75mr4769004vkf.118.1520909591193;
 Mon, 12 Mar 2018 19:53:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.1.49 with HTTP; Mon, 12 Mar 2018 19:53:10 -0700 (PDT)
In-Reply-To: <CABPp-BHDOimDoLxWxS=BDOBkm6CUTrXTzD16=TSkWGN-HOiU2g@mail.gmail.com>
References: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
 <876061q6m6.fsf@evledraar.gmail.com> <CABPp-BHDOimDoLxWxS=BDOBkm6CUTrXTzD16=TSkWGN-HOiU2g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Mar 2018 19:53:10 -0700
Message-ID: <CABPp-BFsiWBiDYYvz=cOofECUHUMJs8x8RuMXqeCF1qP5HzGoQ@mail.gmail.com>
Subject: Fwd: Opinions on changing add/add conflict resolution?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Re-sending because this computer happened to have plain-text mode
turned off for some weird reason, and thus the email bounced]

Hi,

On Mon, Mar 12, 2018 at 3:19 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Does this mean that e.g. in this case of merging two files, one
> containing "foo" and one containing "bar":
>
>     (
>         rm -rf /tmp/test.git &&
>         git init /tmp/test.git &&
>         cd /tmp/test.git &&
>         echo foo >README &&
>         git add README &&
>         git commit -mfoo &&
>         git checkout --orphan trunk &&
>         git reset --hard &&
>         echo bar >README &&
>         git add README &&
>         git commit -mbar &&
>         git merge --allow-unrelated-histories master;
>         cat README
>     )
>
> That instead of getting:
>
>     <<<<<<< HEAD
>     bar
>     =3D=3D=3D=3D=3D=3D=3D
>     foo
>     >>>>>>> master
>
> I'd now get these split into different files?

As currently implemented, yes.  However, I was more concerned the idea
of handling files differently based on whether or not they were
similar, rather than on what the precise definition of "similar" is
for this context.

As far as the definition of similarity goes, estimate_similarity() is
currently used by rename detection to compare files recorded at
different pathnames.  By contrast, in this context, we are comparing
two files which were recorded with the same pathname.  That suggests
the heuristic could be a bit different and use more than just
estimate_similarity().  (e.g. "We consider these files similar IF more
than 50% of the lines match OR both files are less than 2K.")


> I don't mind this being a configurable option if you want it, but I
> don't think it should be on by default, reasons:

I don't think a configurable option makes sense, at least not for my
purposes.  Having rename/rename conflicts be "safely" mis-detected as
rename/add or add/add, and having rename/add conflicts be "safely"
mis-detected as add/add is my overriding concern.  Thus, making these
three conflict types behave consistently is what I need.  Options
would make that more difficult for me, and would thus feel like a step
backwards.

git am/rebase has been doing such mis-detections for years (almost
since the "dawn" of git time), but it feels really broken to me
because the conflict types aren't handled consistently.  (The facts
that (a) I'm the only one that has added rename/add testcases to
git.git, (b) that I've added all but one of the rename/rename(2to1)
testcases to the git.git testsuite, and (c) that rename/add has had
multiple bugs for many years, all combine to suggest to me that folks
just don't hit those conflict types in practice and thus that they
just aren't noticing this breakage -- yet.)

I also want to allow such mis-detections for cherry-picks and merges
because of the significant (nearly order-of-magnitude in some cases)
performance improvements I can get in rename detection if it's
allowed.


>  1) There's lots of cases where we totally screw up the "is this
>     similar?" check, in particular with small files.
>
>     E.g. let's say you have a config file like 'fs-path "/tmp/git"' and
>     in two branches you change that to 'fs-path "/opt/git"' and 'fs-path
>     "/var/git"'. The rename detection will think this these have nothing
>     to do with each other since they share no common lines, but to a
>     human reader they're really similar, and would make sense in the
>     context of resolving a bigger merge where /{opt,var}/git changes are
>     conflicting.
>
>     This is not some theoretical concern, there's lots of things that
>     e.g. use small 5-10 line config files to configure some app that
>     because of some combo of indentation changes and changing a couple
>     of lines will make git's rename detection totally give up, but to a
>     human reader they're 95% the same.

Fair enough.  The small files case could potentially be handled by
just changing the similarity metric for these conflict types, as noted
above.  If it's a small file, that might be the easiest way for a user
to deal with it too.

I'm not sure I see the problem with the bigger files, though.  If you
have bigger files with less than 50% of the lines matching, then
you'll essentially end up with a great big conflict block with one
file on one side and the other file on the other side, which doesn't
seem that different to me than having them be in two separate files.
In fact, separate files seems easier to deal with because then the
user can run e.g. 'git diff --no-index --color-words FILE1 FILE2',
something that they can't do when it's in one file.  That has bothered
me more than once, and made me wish they were just in separate files.


>  2) This will play havoc with already established merge tools on top of
>     git which a lot of users use instead of manually resolving these in
>     vi or whatever.
>
>     If we made this the default they'd need to to deal with this new
>     state, and even if it's not the default we'll have some confused
>     users wondering why Emacs Ediff or whatever isn't showing the right
>     thing because it isn't supporting this yet.
>
> So actually, given that last point in #2 I'm slightly negative on the
> whole thing, but maybe splitting it into some new format existing tools
> don't understand is compelling enough to justify the downstream breakage.

To me, this is a bigger concern.  We have changed conflict resolutions
in various ways at various times over the years, so I don't think the
output should be considered fixed in stone, but I am very sympathetic
to arguments that this particular change is too painful.

There is a possible way to allow for a transition period, though.
Junio has already requested that some of the changes I'm working on be
done as a new merge strategy that is a rewrite of merge-recursive
(https://public-inbox.org/git/xmqqk1ydkbx0.fsf@gitster.mtv.corp.google.com/=
).
It would be a little unfortunate to not be able to use the new merge
strategy as an exact drop-in replacement of the current recursive
merge strategy, but it would provide a way for people to get some time
to migrate other tools.

However, I'm far more concerned with the three collision conflict
types having consistent behavior than I am with changing add/add
conflict handling.  And if your two concerns or Jonathan's concern
would prevent you from wanting to use the new merge strategy (and
possibly prevent it from becoming the default in the future), I'd much
rather just modify rename/add and rename/rename to behave like
add/add.  Would that be more to your liking?


Elijah
