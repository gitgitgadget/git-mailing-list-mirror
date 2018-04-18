Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D5C61F404
	for <e@80x24.org>; Wed, 18 Apr 2018 20:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeDRUQf (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 16:16:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63513 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeDRUQc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 16:16:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4A64EB280;
        Wed, 18 Apr 2018 16:16:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=qhnVTsDR9kJnr
        ANEuOUffinRwLw=; b=svVzmARY86kPNwxeInFjt88kgKU3C7AdCwbrvmT8M6jbx
        g3tEZfHoP4BQkk9BdHMRyfCCNsbDLiojuNo5Kp4/Il74LpEuuwrhU6ojOV0dMynl
        rj1e7uxRv6o7wEPp26dSQK1wCsxLcr7UpleuHTJv2sRGtBTXnc0F0r6f+SBGPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=F8NjidC
        OJr8Hu8P07rCdpIh34HA71UhYmYu+xX5OBpiL61dM59W1vVrfVKvhvj+RGY9FrMM
        EriBShWDOhvDYb7TiBSu4sBQS1+7kq1U1/9MbUQz1i5Vt1fDxdrC88pOY8NbleQr
        MF1pFzBvmd2oHVuP1biIEdh+jQXy/wh10Krg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BABA0EB27F;
        Wed, 18 Apr 2018 16:16:31 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 30751EB27E;
        Wed, 18 Apr 2018 16:16:31 -0400 (EDT)
Date:   Wed, 18 Apr 2018 16:16:29 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>,
        Dorab Patel <dorabpatel@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
        Kyle Meyer <kyle@kyleam.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Ami Fischman <fischman@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4] git{,-blame}.el: remove old bitrotting Emacs code
Message-ID: <20180418201629.GT29831@zaya.teonanacatl.net>
References: <20180327165751.GA4343@aiede.svl.corp.google.com>
 <20180411204206.28498-1-avarab@gmail.com>
 <xmqqk1td2ml2.fsf@gitster-ct.c.googlers.com>
 <87fu40c3xe.fsf@evledraar.gmail.com>
 <xmqqa7u83hjd.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <xmqqa7u83hjd.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: 6223506C-4345-11E8-846F-44CE1968708C-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for working on this cruft cleanup =C6var and to
Jonathan & Junio for asking questions about how to improve
this transition for packagers & users.

Junio C Hamano wrote:
> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>=20
>>> On the other hand, the 6-lines of e-lisp you wrote for git.el
>>> replacement is something the packagers could have written for their
>>> users, so (1) if we really want to go extra mile without trusting
>>> that distro packagers are less competent than us in helping their
>>> users, we'd be better off to leave Makefile in, or (2) if we trust
>>> packagers and leave possible end-user confusion as their problem
>>> (not ours), then we can just remove as your previous round did.
>>>
>>> And from that point of view, I find this round slightly odd.
>>
>> I think the way it is makes sense. In Debian debian/git-el.install jus=
t
>> does:
>> ...
>> RedHat does use contrib/emacs/Makefile:
>> ...
>> But they can either just do their own byte compilation as they surely =
do
>> for other elisp packages,...
>
> In short, Debian happens to be OK, but RedHat folks need to do work
> and cannot use what we ship out of the box, *IF* they care about end
> user experience.

I don't think it's a big deal for the Fedora/Red Hat
packages to adjust and manually install the stub git-el.

Anyone doing automated rebuilds from the current Fedora
git.spec will notice the make failure and can then check the
relese notes to find out about the change, I imagine.

> That was exactly why I felt it was "odd" (iow, "uneven").  We bother
> to give a stub git.el; we do not bother to make sure it would keep
> being installed if the packagers do not bother to update their
> procedure.

I wonder if leaving the Makefile in place would prevent
packages from even noticing the change?  It might still be a
good plan to help ease the transition.  I don't know if
that's as important for something in contrib/ or not.

> If we do not change anything other than making *.el into stubs, then
> it is a lot more likely that end user experience on *any* distro
> that have been shipping contrib/emacs/ stuff will by default
> (i.e. if the packagers do not do anything to adjust) be what we
> design here---upon loading they'd see (error) triggering that nudge
> them towards modern and maintained alternatives.  If we do more than
> that, e.g. remove Makefile, then some distros need to adjust, or
> their build would be broken.
>=20
> I suspect that the set of people Cc'ed on the thread are a lot more
> familiar than I am with how distro packagers prefer us to deliber,
> so I'll stop speculating at this point.

I should note that I'm not an emacs user, so I likely lack a
good understanding of how people use the current
git{,-blame}.el files.  I could simply be doing it wrong in
the steps I took to test this.

With the fedora packaging, we've shipped a git-init.el that
adds autoload entries for git-status and git-blame-mode
(since adding the emacs files in 2007).  That allows users
to make use of those features without adding anything to
their local emacs configuration.

If I open emacs with a current fedora packaging, I can issue
M-x git-status or M-x git-blame-mode.  After applying this
patch and removing the git-init.el, that no longer works
but rather than the detailed warning message, I just get a
transient "no matches" in the emacs status line.

However, if I add "(require 'git)" to ~/.emacs, then I get
the "error: git.el no longer ships with git" message in the
warnings buffer.

Does this mean that only users who have manually loaded
git.el will see the warning?  If so, is there a preferred
method to have the warning appear when calling the commands
previously provided, to give a better user experience?

--=20
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Faith, n. Belief without evidence in what is told by one who speaks
without knowledge, of things without parallel.
    -- Ambrose Bierce, "The Devil's Dictionary"

