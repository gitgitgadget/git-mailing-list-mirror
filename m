From: Junio C Hamano <gitster@pobox.com>
Subject: Everyday contents (was Re: What's cooking in git.git (Jul 2014, #04; Tue, 22))
Date: Wed, 30 Jul 2014 10:13:07 -0700
Message-ID: <xmqqvbqezs64.fsf@gitster.dls.corp.google.com>
References: <xmqq4my9f4qw.fsf@gitster.dls.corp.google.com>
	<B6FB0C239E6E4E2489FAB9EF1C902988@PhilipOakley>
	<xmqqegxcdjzl.fsf@gitster.dls.corp.google.com>
	<7ACC0F5AD23E4C839D2F819B23DA9564@PhilipOakley>
	<xmqqvbqm74v7.fsf@gitster.dls.corp.google.com>
	<xmqqegx95bxc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 19:13:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCXRP-0001bU-Mn
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 19:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184AbaG3RNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 13:13:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55369 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754662AbaG3RNX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 13:13:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 15B0E2B7DD;
	Wed, 30 Jul 2014 13:13:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=IIepsV/Eo9qlJw3aFVsftu1ttps=; b=cLOI1xYNf+eUk3mUhJws
	Yj55MZDP5bLD1j6UCv9QtfW+oGjSc3Gz5WH6dOS7iOOEeLGp8gAjJa0WFjiIDpvq
	XK58DoEafqRrmxONr96xrghzcS1KhgqbYY4S74IfXQQLL7EXHOmz8wbMlrOhrpz2
	vNCKJGB8QFhFfbDnBlle4yY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=wp74fsV3AB+iBT4GEJ7nFW0uhVupo1mK+RAcLo/r22wPu2
	YWddze8BZzWNa86ZEgwxJYhGAflVHoN+3b0YT4BdWU70V9nnSuU1fXdtk61N2Fq4
	JkcnNq0wpz1BN8GnnyVS+jHoIPvEuVzQQIs87bA6Rkb2mQtnA9g4cOYbKB7Yo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E19822B7D9;
	Wed, 30 Jul 2014 13:13:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5F5E52B7CF;
	Wed, 30 Jul 2014 13:13:09 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C784BC38-180C-11E4-9130-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254502>

Continued: this message only covers the third part (out of the four sections).

| Integrator[[Integrator]]
| ------------------------
| 
| A fairly central person acting as the integrator in a group
| project receives changes made by others, reviews and integrates
| them and publishes the result for others to use, using these
| commands in addition to the ones needed by participants.

This definition of who an "integrator" is, and it being a separate
role when we discuss various workflows, are still sound, I think.

|   * linkgit:git-pull[1] to merge from your trusted lieutenants.

Among these enumerated items, we may want to reword this a little
bit to hint that this section also applies to GitHub pull-request
workflow.  However, I am not sure how their "merge without first
locally checking" action on their website fits in the picture.

| Examples
| ~~~~~~~~
| 
| My typical Git day.::

This probably shouldn't talk about "My" in the first place, but in
any case I work somewhat differently (cf. howto/maintain-git.txt)
these days.

| +
| ------------
| $ git status <1>
| $ git show-branch <2>

This is more like "git branch --no-merged master" (and similarly for
'next' and 'pu'), and is helped by "Meta/cook -w" but this document
is a wrong place to talk about the latter.

| $ mailx <3>
| & s 2 3 4 5 ./+to-apply
| & s 7 8 ./+hold-linus
| & q
| $ git checkout -b topic/one master
| $ git am -3 -i -s -u ./+to-apply <4>

No need to give -u these days.

| $ compile/test
| $ git checkout -b hold/linus && git am -3 -i -s -u ./+hold-linus <5>

Again, no "-u" necessary.

| $ git checkout topic/one && git rebase master <6>
| $ git checkout pu && git reset --hard next <7>
| $ git merge topic/one topic/two && git merge hold/linus <8>
| $ git checkout maint
| $ git cherry-pick master~4 <9>
| $ compile/test
| $ git tag -s -m "GIT 0.99.9x" v0.99.9x <10>
| $ git fetch ko && git show-branch master maint 'tags/ko-*' <11>

This step I still use show-branch, but like this:

    for branch in master maint next pu
    do
        git show-branch ko/$branch $branch
    done

and the purpose explained in the footnote is still valid.

| $ git push ko <12>
| $ git push ko v0.99.9x <13>

I no longer have to do the last step <13>, instead the step <12>
reads more like

	git push --follow-tags ko

| ------------
| +
| <1> see what I was in the middle of doing, if any.
| <2> see what topic branches I have and think about how ready
| they are.

With "show-branch" replaced with "branch --no-merged", the purpose
of this step is still the same.

| <3> read mails, save ones that are applicable, and save others
| that are not quite ready.
| <4> apply them, interactively, with my sign-offs.
| <5> create topic branch as needed and apply, again with my
| sign-offs.
| <6> rebase internal topic branch that has not been merged to the
| master or exposed as a part of a stable branch.
| <7> restart `pu` every time from the next.
| <8> and bundle topic branches still cooking.
| <9> backport a critical fix.
| <10> create a signed tag.
| <11> make sure I did not accidentally rewind master beyond what I
| already pushed out.  `ko` shorthand points at the repository I have
| at kernel.org, and looks like this:

No longer it looks like that ;-)

| +
| ------------
| $ cat .git/remotes/ko
| URL: kernel.org:/pub/scm/git/git.git
| Pull: master:refs/tags/ko-master
| Pull: next:refs/tags/ko-next
| Pull: maint:refs/tags/ko-maint
| Push: master
| Push: next
| Push: +pu
| Push: maint
| ------------
| +

... because we encourage people to use in-config description of
remotes these days, which should look like this:

	(in .git/config)
	[remote "ko"]
        	url = kernel.org:/pub/scm/git/git.git
                fetch = refs/heads/*:refs/remotes/ko/*
                push = refs/heads/master
                push = refs/heads/next
                push = +refs/heads/pu
                push = refs/heads/maint

Also tracking is done via refs/remotes/ko/, no longer with tags/.

| In the output from `git show-branch`, `master` should have
| everything `ko-master` has, and `next` should have
| everything `ko-next` has.

With s|ko-master|ko/master| and s|ko-next|ko/next|, the above is
still valid.

| <12> push out the bleeding edge.

s/edge./edge, together with new tags that point into my history./

| <13> push the tag out, too.

Drop this.
