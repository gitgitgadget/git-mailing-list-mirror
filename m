Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAFDF1F790
	for <e@80x24.org>; Tue,  2 May 2017 14:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751121AbdEBO3r (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 10:29:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:50263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750740AbdEBO3q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 10:29:46 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Likl3-1ddnZ92qz7-00cxdA; Tue, 02
 May 2017 16:29:38 +0200
Date:   Tue, 2 May 2017 16:29:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Nikita Orlov <fatemail@mail.ru>, Kevin Daudt <me@ikke.info>,
        git@vger.kernel.org
Subject: Re: git loses a commit after reordering.
In-Reply-To: <xmqqwpa0f8zm.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1705021608580.3480@virtualbox>
References: <1493278996.239768474@f402.i.mail.ru>        <20170429225642.GA25902@alpha.vpn.ikke.info>        <1493643894.701604094@f346.i.mail.ru> <xmqqwpa0f8zm.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:r2UbaBUubW6QxqWGtwukls965NPaJAHqYpCWhz8ZTvSTWIbp+1z
 gc3irE8I0m28xgPM2A7b/IpFzcB35vsHFimgPDZDm5pPbFi0ZGB48KXT8AF7EYk6MM/8Jz5
 WZbZxJONbU036L3h3vD/tpZmNiy8m0v8kfrnGhzBp88Z8mG4p1qQzI0dXxFbuZpgjuQE0Or
 SOpsk5zc5JvRjbbE/T6kw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RslfC+9fGBo=:noRHbeu/0Zmcjlc3SN9NIP
 mXQF8la06U09UOrb57plSkkTe8kLf1LBe4zB6ePe5c8/OX+UXWQRBl1TGoO7DaZBL/npcyVQc
 jVxb9rcFjsSNaLKmtzxhIo92cX4g+Sr36IYLB187odF7UOIL4olHIeg1nVjnABQOWizza4Pmc
 F2cg3FBop+LNkkBhodwL/lrGTI6P5uZYGVQPBu/4poCib1TJeMuCPfA9JDIAMrXVGNwwqCua6
 v5Jown2FcyPYAiPl0U2Nw2f2lm9j6nnprXDar+FQSpxDp9/3SMxbfUTCFMIKnfLsxwce4/QAc
 +yZpmg3Od8czBr+owIvlGBGbc4iDKgIKb6mZg78a/+gK5r1w2zSKmtaG35ae38RuRnJsJs1mP
 l8hgdJmUq23XaPbyVKnSBtlvfJTN9Km4G4UfUHOmhL1tbFJysMLv+ObDxnv+HXlz33C0NiM5b
 EGrP2vMPOhXXjJQvs2EpjSb91c4Y1q/RbqllLUbQyAe226fCEoahvJJh/lt2FB05xeYs7VFpA
 VRmm7NtjaRCZM1wPuHcrxOUWpOt+W1nHkEhjhd2fFFNMUDlICHQRwHX4VGfmKEIaykfzZQ9A5
 IMxAOgGUKbjuGb1V7AbLdkVnqZo19GNAlfN5TW2PYKERQOg0UXwpiF9/LTTG6GO9DkSJAfX62
 Djd+U5o56dFMtHyuUye5yXEfuq4Y3iFVM8PWHQy4WkCBeaoOE8UfIWctRcj+aE+z27vdHsL+U
 Jyi44KggeNNY6fhiM1s/gk0k1Xz68kVVJRZQt28fY+lA2bq5Lr4it/YDwQgzmu5Qlqi+3/TqE
 1UFdZFz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio, Kevin & Nikita,

On Mon, 1 May 2017, Junio C Hamano wrote:

> Nikita Orlov <fatemail@mail.ru> writes:
> 
> >>On Sun, 30 Apr 2017, 1:56 +03:00 from Kevin Daudt <me@ikke.info>:
> >>Not sure if this is the case here, but it at least confirms that rebase
> >>--preserve-merges was not meant to reorder commits.
> >>
> >>See [this][1] thread for more background on this limitation.
> >>
> >>[0]: https://git-scm.com/docs/git-rebase#_bugs
> >>[1]: https://public-inbox.org/git/1mtveu4.19lvgi1c0hmhaM%25lists@haller-berlin.de/
> >
> > This is it. As I understand git-rebase--helper is an attempt to fix the bug.
> > But it's still in development, isn't it?
> 
> The impression I have been getting is that "rebase -p" was abandoned
> by its author, and the recent rebase--helper work is solely for
> re-implementing the performance sensitive part of "-i" (interactive).

Indeed. The design of `-p` does not really allow for it to be fixed, as it
overloads the meaning of `pick` to also "pick a merge commit". This
further limits the usefulness of the `-p` feature by not allowing to
adjust merge commits to merge anything else than the rebased commit^2 into
anything else than the rebased commit^, which is kind of a realy big
design bug.

But then, I never meant for -p to be interactive, either, and others made
it so. Therefore I refuse to take the blame for that.

After my rebase-i-extra patch series (which Junio currently calls
rebase-i-final) will be accepted, I plan to do a bit more work on the
rebase -i front.

One thing I have in mind is to implement a new --recreate-merges option.
It will be closely modeled after the functionality of my Git garden shears
[*1*] that I used to maintain Git for Windows' dozens of patch series on
top of git.git's `maint` branch.

Essentially, I want to introduce new commands (that are implemented as
`exec` calls in the Git garden shears, with the noticeable performance
implications on Windows) that

- allow to mark the current commit with a label,

- reset HEAD to a given label

- merge a branch by a given label

These commands would be new commands, and therefore backwards-compatible
with the current command set. No need for special-casing `pick` in the
case of the new mode.

And then I would patch in the new --recreate-merges option simply by
generating a todo list using those new commands.

The todo list may look somewhat like this:

	mark onto

	# branch <my-cool-feature>
	pick deadbee5 lay some groundwork
	pick beeb0bab implement the cool feature
	pick deebadee document the cool feature
	mark my-cool-feature

	reset onto
	pick cabbadab fix a tyop
	remerge d00beedo my-cool-feature

where `remerge <original-commit> <label>` would merge the commit with the
given label using the commit message of the original merge commit.

This would result in a history like this:

------------------------------------------ fix a tyop - Merge my-cool-feature
 \                                                    /
  lay some groundwork - implement ... - document ... -

If you have an idea for a better name than `remerge` (I do want to leave
`merge` as command to create new merge commits that have not been there
before), I'd like to hear your suggestion.

Ciao,
Johannes

Footnote *1*:
https://github.com/git-for-windows/build-extra/blob/master/shears.sh
