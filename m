From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] Documentation: triangular workflow
Date: Fri, 10 Jun 2016 09:47:42 -0700
Message-ID: <xmqqinxhf0sx.fsf@gitster.mtv.corp.google.com>
References: <1465288693-6295-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	<1465475708-1912-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	<E41AB752AE614E189BC5BE289A8AEB2A@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Jordan DE GEA" <jordan.de-gea@grenoble-inp.org>,
	<mhagger@alum.mit.edu>, <git@vger.kernel.org>,
	<erwan.mathoniere@grenoble-inp.org>,
	<samuel.groot@grenoble-inp.org>, <tom.russello@grenoble-inp.org>,
	<Matthieu.Moy@grenoble-inp.fr>, <peff@peff.net>,
	<artagnon@gmail.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Jun 10 18:47:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBPb4-00082w-Pr
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 18:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbcFJQrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 12:47:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52549 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932415AbcFJQrq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 12:47:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DD4FA227A6;
	Fri, 10 Jun 2016 12:47:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cubm6/rg6rZlgbboV9OM4Sb0jBY=; b=kgQ6/O
	nQhpx+/lzIv88ke/pdM1c3ylCETyDZj49g701jQoUjsCZiouMEQKhcM9KMd4rdkH
	0tn7qGN19EE8vlhqrpiugtb/B1fmr4Q20T1kcQPl32xI3cmqyqfr6vv5mP+z2LDL
	4qHPzteIDn9KWoHlIdIeGlqOTynlLZQzH/ooU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VX6SEjxi/VIngBCJXwMyMORkV/RG1kSl
	wvpNeVbzyRR0C3NQqrnzPIJlM5uLw1Bo7qPb6UiffjBA1IiYBmfbJjMFyKSC5705
	gMHjq/KO78K77yZOQYViey6eC9n1aXqltz+Bob7RWEbVZHESJ8hb5gzR+bU9oqbk
	1vIzsBxo9jg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D5DA5227A5;
	Fri, 10 Jun 2016 12:47:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5864D227A4;
	Fri, 10 Jun 2016 12:47:44 -0400 (EDT)
In-Reply-To: <E41AB752AE614E189BC5BE289A8AEB2A@PhilipOakley> (Philip Oakley's
	message of "Thu, 9 Jun 2016 19:19:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0DE22E90-2F2B-11E6-8555-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297012>

"Philip Oakley" <philipoakley@iee.org> writes:

>> +Preparation
>> +~~~~~~~~~~~
>> +
>> +Cloning from **PUBLISH**, which is a fork of **UPSTREAM** or an empty
>> +repository.
>
> I agree here. To clone the upstream, to which you have no push access (by 
> definition), would leave the config badly mis-set for the basic user. It's 
> better for the user to clone their publish fork (to which they have both 
> read and write access).

I do not think I agree.

If you apriori know that you do want to hack on a project's code, then
forking at GitHub first and then cloning the copy would be OK.

But I doubt that would be a common set-up, unless you are focusing
only on school-like setting where you are told by your instructor to
"make changes to this public project, and show the result in your
fork".  In real life you cannot tell if the project is worth your
time modifying until you see it first, can you?

I suspect that the majority of local clones start from something
like "I want to build and use from the tip", "I want to use a module
that does X, and there are three candidates, so let's clone them all
to evaluate", etc.  You do not bother "forking at GitHub" but just
clone from the upstream for these clones.

After you build it and try things out, you may start making local
changes, and you may even record your changes as local commits.  You
play with your local clone of the upstream.  After doing so, you may
find that some of the projects do not fit your needs, but for some
others, you would find that it is worth your time and effort to
upstream your changes and/or keep working further on the project.

And at that point, you would create a publishing place, push into
it, and tell others "Hey I did this interesting thing!".  That
"creat a publishing place" step could be just a one click at GitHub.

Isn't that how you work with other people's projects?  Or do you
always modify every project you fetch from the outside world?, Do
you always fork first, just in case you *might* change and you
*might* have to have a place to push your changes out?

If you tell novices "You fork first and then clone your fork", and
in the ideal (to you) case they will follow that advice to the
letter and they will end up with forks of all projects they will
ever look at, in many of which they make no local commit.

What is more likely to happen is that they will first ignore you and
start from a local clone of the upstream, and then find this
document that says "triangular workflow requires you to fork first,
clone that fork and work in it".  Because they would have to fork
first and make another clone, this time a clone of the fork, in
order to follow the instruction of this document, they oblige,
ending up with two clones.  More importantly, this makes the local
clone of the upstream they made earlier and the changes they made in
that clone appear useless.  They need to be told how to transplant
the work done in the clone to the newly created clone of the fork,
in order to publish them.

If your instruction begins with "You clone from upstream as usual
(i.e. just like when you make a "read-only" clone without any
intention to make changes or push changes out), and add a publish
place if/when it becomes necessary", the problem described in the
previous paragraph goes away, no?
