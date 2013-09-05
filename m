From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: Modify push dialog to support Gerrit review
Date: Thu, 05 Sep 2013 10:34:51 -0700
Message-ID: <xmqqioyfjhok.fsf@gitster.dls.corp.google.com>
References: <20130904150853.52EC4121B7E@jed-dev-01.labnet>
	<522827CE.5040303@viscovery.net>
	<F8C23E99F5C6884EB99E2A1966D743637F3619A6@cph-gen-exch01.napatech.com>
	<5228476A.2070505@viscovery.net>
	<F8C23E99F5C6884EB99E2A1966D743637F3619CB@cph-gen-exch01.napatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	"spearce\@spearce.org" <spearce@spearce.org>,
	"hvoigt\@hvoigt.net" <hvoigt@hvoigt.net>,
	Pat Thoyts <patthoyts@gmail.com>
To: =?utf-8?Q?J=C3=B8rgen?= Edelbo <jed@napatech.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 19:35:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHdSU-0000U5-GD
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 19:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904Ab3IERfA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Sep 2013 13:35:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256Ab3IERe6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Sep 2013 13:34:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A0B53FF75;
	Thu,  5 Sep 2013 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kUQxjRk73ciN
	6QtVh/mfaKx6Zm0=; b=GHdRhH37+mMC5cLSX/1uW6cbb70ONbmP2D0Wc3+ja0Z3
	GpF3/JnRiH3hVXjl5AOnIg5iTPeP1KZQaKzoTQAERHrvDyKNX/QESuBtLOVzMbtN
	Uuf0e2h0OiF8ML55SfJj/W/3EZhCE+VqSft2MuQvYjL6dJnno0XUJ832iUccW8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JbVYlK
	jLa7VzOomGX8SLpgTnS/Ry4a4UtxgrNOTSsgkjCHrbYy3RHBIRtBRo0VnWWFZUB3
	QgEe9vFZrQFzUCEasRZXJDajL5xlJEte6PUPStwd1iX/wAzmuUCYlYwEQLfxCOzO
	Iw00jLaKl2OpaVE02iRWH6GJgiWmW+CGhu4FI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D22EA3FF6C;
	Thu,  5 Sep 2013 17:34:55 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 187933FF63;
	Thu,  5 Sep 2013 17:34:54 +0000 (UTC)
In-Reply-To: <F8C23E99F5C6884EB99E2A1966D743637F3619CB@cph-gen-exch01.napatech.com>
	(=?utf-8?Q?=22J=C3=B8rgen?= Edelbo"'s message of "Thu, 5 Sep 2013 09:18:25
 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7A17028E-1651-11E3-9467-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233974>

J=C3=B8rgen Edelbo <jed@napatech.com> writes:

>> You say I can only push HEAD. I understand this that I have to stop =
work on C
>> (perhaps commit or stash any unfinished work), then checkout A, push=
 it,
>> checkout B, push it, checkout C and unstash the unfinished work. If =
my
>> understanding is correct, the new restriction is a no-go.
>
> Ok, this way of working is not supported. It just never occurred to m=
e that
> you would work this way. Forgetting to push something that you have j=
ust=20
> completed is very far from what I am used to. I think it comes most n=
atural
> to push what you have done before changing topic. The reason I make a=
 commit
> is to get it out of the door.

People work in very different ways, and mine and yours are extreme
opposites.  I almost never push out a commit that is just off the
press, I use topic branches heavily and work on multiple topics
(either related or unrelated) in parallel all the time, so it is
very usual for me to push out more than one branches with a single
push---by definition, if we support pushing only the current branch
out, "working on more than one topics and after perfecting these,
push them together" cannot be done.

If one sets push.default to something other than the matching, and
does not have any remote.*.push refspec in the configuration, J6t's
"I forgot to push while I was on that branch" and my "I deliberately
did not push those branches out while I was on them, but now I know
I am ready to push them out" cannot be done without explicit
refspecs on the command line.

But stepping back a bit, I think this "I commit because I want to
get it out the door" is coming from the same desire that led to a
possible design mistake that made various push.default settings push
only the current branch out.

The possible design mistake that has been disturbing me is the
following.

The "push.default" setting controls two unrelated things, and that
is one too many.  Between the matching modes and the rest, it tells
what branch(es) are pushed out (either "all the branches with the
same name" or "the current branch").  That is one thing, and I tend
to agree that "push only the current branch" would be a sane default
many people would prefer (and that is the reason we made it the
default for Git 2.0).

Among the various non matching modes, it also determines where a
branch that is pushed out would go ("current" pushes to the same
name, "upstream" pushes to @{upstream}, etc.).  But this "once I
choose what branch to push out, the branch being pushed out knows
where it wants to go", does not take effect if one explicitly names
what to push, e.g. in this sequence where one forgets to push
'frotz' out:

    j6t$ git checkout frotz
    ... work work work ...
    j6t$ git checkout xyzzy
    ... work work work ...
    ... realize 'frotz' is done
    j6t$ git push origin frotz

The last push may work differently from the push in this sequence:

    j6t$ git checkout frotz
    ... work work work ...
    j6t$ git push ;# or "git push origin"

In the latter sequence, the niceties of push.upstream to push
'frotz' out to the frotz@{upstream} (and your "git push origin
refs/heads/frotz:refs/for/frotz" mapping done in git-gui) will take
effect, but in the former, the refspec "frotz" on the command line
is taken as a short-hand for "frotz:frotz".

We may want to teach "git push" that the command line refspec that
names a local branch may not be pushing to the same name but wants
to go through the same "mapping" used when "git push" is done while
the branch is checked out, with some mechanism.

It is a separate but very related topic, I think.
