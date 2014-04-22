From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What is missing from Git v2.0
Date: Tue, 22 Apr 2014 15:03:14 -0700
Message-ID: <xmqqmwfd2fa5.fsf@gitster.dls.corp.google.com>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
	<53557071.5040500@gmail.com>
	<xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
	<xmqqk3ah5i55.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 00:03:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcimr-0000yO-Uk
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 00:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756944AbaDVWDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 18:03:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63044 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754245AbaDVWDT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 18:03:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F5647F2E9;
	Tue, 22 Apr 2014 18:03:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M31ufwTOjcfcvPxjUQPk6+NYaaU=; b=ZpTpvh
	rjD9EaicSH/EbXc2uL5zeLAeBVeTLnKmwGTXk74gTQ2PcIMYkINLzQ5NN7PDgd6e
	jFuYi92valXJy3gDAFvVU9NXgU+xLLg3nvN9To6AfnbM0SH92M8HUnARzx7crgTO
	nR+8Xme/b3M8C3gjaovcXbF6AkLaNOr8au/k8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dV8V0wqE2cgK0crQvAXL0JuxnfrWybW3
	U8h/7u1Qs/PtZ7yKKLoghUhjkdlNgxL6J36x5agNzXmkHT6CbvfoUoUkb6JCn6z1
	5EDNkg3pQkjY5RVC0kx93uI/KxOKjKUUxK4XWEBrEvsGdXgQLbJConvtzoiyKV4k
	tNzlCzjJbdU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 379EF7F2E8;
	Tue, 22 Apr 2014 18:03:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 813937F2E4;
	Tue, 22 Apr 2014 18:03:15 -0400 (EDT)
In-Reply-To: <xmqqk3ah5i55.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 22 Apr 2014 11:33:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E78404BC-CA69-11E3-97A0-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246791>

Junio C Hamano <gitster@pobox.com> writes:

> I am not fundamentally opposed.  I just do not think it would add
> much value to new people at this point, and it will actively hurt
> if we shoved barely cooked one in 2.0.
>
> A few thinking points that are necessary to be worked out, even
> before we start imagining a plan to introduce them, off the top of
> my head, are these:
>
>  * Should we add many random aliases, or should we limit ourselves
>    only to a narrow set that everybody can agree on?
>
>  * What is the additional cognitive load do we feel comfortable
>    burdening with the new users?
>
>  * What is the exact mechanism to give these built-in aliases?
>
> Imagine that somebody says "[alias] ci = commit" and a handful of
> vocal people on this list agree that it is a good idea.  Many random
> websites start mentioning "git ci -a" in their beginner examples.
>
> Users are led to think "ci" is a command just like "commit" and does
> the same thing.... and need to learn that only the
> first kind and not the second kind cannot be used to define their
> own alias (and the users need to learn "commit" at that time as
> well).

A bit further on this point, looking into the future.

It might help if we added some "introduction" phase to the first
invocation of "git init", "git clone", etc. that is interactively
run on a machine where there is no $HOME/.gitconfig detected, and
help the user populate it with a few selected and uncontroversial
ones.  Such a session might go like this:

	$ git init
        ... We do not see $HOME/.gitconfig; using Git for the first time?
        ... Let us ask a few questions to make your Git life more pleasant.
        >> What name do you want to appear on your commits?
        Sebastian Schuberth
        >> What email address do you want to appear on your commits?
	sschuberth@gmail.com
        >> You record your commits as
        ... "Sebastian Schuberth   <sschuberth@gmail.com>".
        >> OK?
        Y
        >> Do you want us to add a few sample aliases to your configuration file?
        Y
        ... Done.  You can further tweak $HOME/.gitconfig to suit
        ... Git to your taste.

And it would end up with something like this:

	$ cat $HOME/.gitconfig
        [user]
		name = <<interactively ask and record the result>>
                email = <<ditto>>
	[alias]
        	co = checkout
		lg = log --oneline

which can serve as an example the user can then tweak, without
giving any false impression that "co" is any more special than
whatever the user adds as a custom alias.

But the need to make the set minimum and the need to carefully think
things through are still there (Ted made a very good point about "rb",
which I agree with).
