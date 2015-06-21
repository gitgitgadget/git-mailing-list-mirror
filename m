From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Using clean/smudge filters with difftool
Date: Sun, 21 Jun 2015 21:29:51 +0200
Message-ID: <558710AF.9040009@drmicha.warpmail.net>
References: <5582BA1F.1030409@drmicha.warpmail.net>	<CAGA3++LrVSs3rMkg=S2Og48pz1yEBxwpcRsPt7sNLENRh1ooAg@mail.gmail.com>	<20150618132622.GJ18226@serenity.lan>	<CAGA3+++_mx=O=Un0pip8Q41X5PZBLmES=Hd=U=aSowryx5r=8w@mail.gmail.com>	<20150618141116.GK18226@serenity.lan>	<CAGA3+++ibw=8Q1LtM6yJrZ7Q4eVs_MEHmPAzctSVSREXMmBiMQ@mail.gmail.com>	<20150618142852.GL18226@serenity.lan>	<CAGA3+++LqZ8Qv6tpuoqQwi37kO5LLODwcbFQtvneorjiV4KARw@mail.gmail.com>	<20150618160133.GO18226@serenity.lan>	<xmqqsi9oeqhn.fsf@gitster.dls.corp.google.com>	<20150618223927.GP18226@serenity.lan>	<xmqqr3p8bp8l.fsf@gitster.dls.corp.google.com>	<5583D993.4090305@drmicha.warpmail.net> <xmqqsi9naavw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: John Keeping <john@keeping.me.uk>,
	Florian Aspart <florian.aspart@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 21:30:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6kwL-000420-9c
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 21:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbbFUT3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 15:29:55 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57022 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751776AbbFUT3y (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jun 2015 15:29:54 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 1308A20963
	for <git@vger.kernel.org>; Sun, 21 Jun 2015 15:29:54 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Sun, 21 Jun 2015 15:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=1zzVc3AuDhp5ELy66xa69yt9Bwg=; b=h4TXzV
	1wBxn+WVn+GewCHrNvYwT6u7RFrVMGCu0uivowsHW1BhBfNQ7huEkKNlSMF0iB8C
	qfC47u9jtDrc+N211R4zYnP9GVP8Chmj1iK97xB1ETcFj4UchgkC5L3hP5L7NyNZ
	WDaoCCEFpEaWjoyJ1cEeo8/+rukMPDtO8tGkw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=1zzVc3AuDhp5ELy
	66xa69yt9Bwg=; b=JYcItKt/sjEqh/mwyqFKrsitGr/7BN1IQnxDnAKSj0EAXQP
	wHPwVBu3HZ9baeGrIJhBasZYd8yTd4ZSKya+BpDHmXRtiEgCAt4SeA+u7B966QZT
	hGH/1MgD0/50JtCPJxzJfMcFBceNPIl959+KUnEWU2s3tKKF/0YaoswFhKzI=
X-Sasl-enc: UpcUxZ+k3Rwna4KS3n/cYSqfktUxe7LwrezyYARBlSG9 1434914993
Received: from localhost.localdomain (unknown [92.76.170.248])
	by mail.messagingengine.com (Postfix) with ESMTPA id 80B646801A3;
	Sun, 21 Jun 2015 15:29:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqsi9naavw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272283>

Junio C Hamano venit, vidit, dixit 19.06.2015 19:03:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Now, since external diff runs on smudged blobs, it appears as if we
>> mixed cleaned and smudged blobs when feeding external diffs; whereas
>> really, we mix "worktree blobs" and "smudged repo blobs", which is okay
>> as per our definition of clean/smudge: the difference is irrelevant by
>> definition.
> 
> It does not appear to "mix cleaned and smudged" to me (even though
> before Dscho's commit that John pointed out, we did mix by mistake)
> to me,

... neither to me. I appears as if you missed the past subjunctive ;)

> but you arrived at the correct conclusion in the rest of your
> sentence.

> We treat "worktree files" and "smudged repo blobs" as "comparable"
> because by definition the latter is what you get if you did a
> "checkout" of the blob.  Indeed, when we know a worktree file is an
> unmodified checkout from a blob and we want to have a read-only
> temporary file for a "smudged repo blob", we allow that worktree
> file to be used as such.
> 
> So in that sense, the commit by Dscho that John pointed out earlier
> was not something that changed the semantics; it merely made things
> consistent (before that commit, we used to use clean version if we
> do not have a usable worktree file).
> 
> It is a separate question which of clean or smudged an external diff
> tool should be given to work on.
> 
>> I still think that feeding cleaned blobs to external diff would be less
>> surprising (and should be the default, but maybe can't be changed any
>> more) and feeding smudged blobs should be the special case requiring a
>> special config.
> 
> Go back six years and make a review comment before 4e218f54 (Smudge
> the files fed to external diff and textconv, 2009-03-21) was taken
> ;-).  The argument against that commit may have gone like this:
> 
>  * The current (that is, current as of 4e218f54^) code is
>    inconsistent, and your patch has a side effect of making it
>    consistent by always feeding smudged version.
> 
>  * We however could make it consistent by always feeding clean
>    version (i.e. disable borrow-from-working-tree codepath when
>    driving external diff).  And that gives us cleaner semantics; the
>    internal diff and external diff will both work on clean, not
>    smudged data.
> 
>  * Of course, going the "clean" way would not help your cause of
>    allowing external diff to work on smudged version, so you would
>    need a separate patch on top of that "consistently feed 'clean'
>    version" fix to optionally allow "consistently feed 'smudge'
>    version" mode to help msysGit issue 177.
> 
> And I would have bought such an argument with 97% chance [*1*].
> 
> I do not think 6 years have changed things very much with respect to
> the above three-bullet point argument, except that it would be too
> late to set the default to 'clean' all of a sudden.  So a plausible
> way forward would be to
> 
>  * introduce an option to feed 'clean' versions to external diff
>    drivers, perhaps with --ext-diff-clean=<driver> command line
>    option and GIT_EXTERNAL_DIFF_CLEAN environment variable, both of
>    which take precedence over existing --ext-diff/GIT_EXTERNAL_DIFF
> 
>  * optionally add a configuration variable diff.feedCleanToExternal
>    that makes --ext-diff/GIT_EXTERNAL_DIFF behave as if their
>    'clean' siblings were given.  Default it to false.
> 
> My gut feeling is that textconv should need a similar treatment for
> consistency (after all, it goes through the same prepare_temp_file()
> infrastructure).
> 
> 
> [Footnote]
> 
> *1* The 3% reservation is that I am not entirely convinced that
> "both internal and external get to work on the same 'clean'
> representation gives us cleaner semantics" is always true.

With consistency stepping back behind compatibility, I don't expect any
defaults to change.

But a knob to change defaults would be nice, yes, and in that case for
external diff as well as textconv. A config variable should suffice
given that we have "git -c" these days.

Michael
