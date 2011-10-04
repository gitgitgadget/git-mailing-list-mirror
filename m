From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib: add a pair of credential helpers for Mac OS X's
 keychain
Date: Tue, 04 Oct 2011 12:10:23 -0700
Message-ID: <7vy5x0bmjk.fsf@alter.siamese.dyndns.org>
References: <1316055113-2353-1-git-send-email-jaysoffian@gmail.com>
 <20110929075627.GB14022@sigill.intra.peff.net>
 <CAG+J_DwntGc+j3duCVqsnoJGV18FqnwXJ99C1XqKope_zbGHAA@mail.gmail.com>
 <20110930221111.GB9384@sigill.intra.peff.net>
 <CAG+J_Dww1yOeq1LHQYMiObPKqrWbk4t8Hn=G9WpYWXFBbHiuhQ@mail.gmail.com>
 <20111003105908.GF16078@sigill.intra.peff.net>
 <CAG+J_DxAaw=vVENFUP5Mq9+inuDEpn_3Le_b7sO97wRUW6aFSA@mail.gmail.com>
 <20111004101610.GA11236@sigill.intra.peff.net>
 <7v39f8d6iq.fsf@alter.siamese.dyndns.org>
 <20111004174840.GA31558@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	John Szakmeister <john@szakmeister.net>,
	Kyle Neath <kneath@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 04 21:10:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBAO3-0000ia-Dg
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 21:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933469Ab1JDTK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 15:10:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63809 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932820Ab1JDTK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 15:10:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAB7D4351;
	Tue,  4 Oct 2011 15:10:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9cHJQhESxwVlgSUo9JvGCy1r8h0=; b=fXrlmR
	6yLhOZw/sqm2kkkBr2UcH+BPrDMHvQuoqU8nE+qFFHvxSjoDgVy3rWxZI0ZZoOen
	aGl1Wf8vxLUq/jE3fLNmqafR6irG2Wa+tSNo0RS8hB4BO0DAzjPsIchaa4QxAiRs
	49Mf0BlLdWP6te8lkPbrmLp1b0b1r+sdc69oI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sMuy3BTIRZbNa/pmMRFj5W9eQFdKH6nt
	QzEdPGxLZSy6y7ey7tN4mJ3byV1C4jZg82PUtC8ymZQtvqgexQf++LJ2OjBwJOzo
	z2IkejL2c6p6n6DO2JHLh3OWAduRK1/kMWZOP7IPigourLMx/qwtnw9p7YNsFtf0
	Q6Q9wBCs4NQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E16264346;
	Tue,  4 Oct 2011 15:10:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16AE84345; Tue,  4 Oct 2011
 15:10:25 -0400 (EDT)
In-Reply-To: <20111004174840.GA31558@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 4 Oct 2011 13:48:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 83AB20E6-EEBC-11E0-9896-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182788>

Jeff King <peff@peff.net> writes:

> No, sadly I don't think we're there yet.

It is much better to proceed with caution than unleashing something whose
semantics will later have to change so drastically that we end up hurting
end users, so nobody has to say "sadly". By spelling out what more needs
to be there for us to get there, we are making progress.

> The two big open questions are:
>
>   1. Should we be giving more context details to the helpers, and/or
>      should we be breaking down the information into pieces?
>
>      I think the answer is probably yes. Certainly OS X would benefit
>      from the broken-down pieces. My feeling is that we could hand
>      helpers both broken-down pieces as well as an inclusive URL. So
>      something like:
>
>        git credential-foo \
>          --type=network --protocol=https --host=example.com \
>          --username=user1 --path=repo.git \
>          --url=https://user1@example.com/repo.git
>
>      and then the helper can pick what it likes from there.

Hmm, don't we first want to enumerate contexts where we might want to get
the access information from the user? E.g.

 * "transport" aka "git fetch/push"; I think you meant this by --type=network,
   but there probably are other kinds of accesses over "network".
 * "imap-send".
 * "send-email".
 * "tag -s" and perhaps upcoming "push --signed" or "commit --gpg-sign"?

Anything else?

I am not sure where the unlocking passphrase for ssl cert fits in this
picture, though.

>      One thing I haven't figured out is how the user would tell git "no,
>      the repo path is not relevant for determining the auth domain".
>      That feature can come later, but I want to make sure that helpers
>      know they might or might not get the "--path" option. I guess that
>      is just a matter of documentation; I'm just a little nervous
>      committing to it without having figured out the details.

Well, shouldn't the caller of credential-foo be passing --authdomain as a
separate piece anyway?  In the above example, if example.com operates as a
single auth domain no matter what repository, --authdomain may just say
"". If it uses per repository auth domain, --authdomain may say "repo.git"
(I am assuming <authdomain> is not globally unique but unique within the
context of <type, host> or perhaps <type, proto, host>). 

>   2. There has been some talk that the helper interface should perhaps
>      be vastly simplified from "get the credentials and give them to
>      git" to merely being a store/retrieve system, where the invocations
>      would be something like (pretend git is the shell):
>
>        # git asks if we have a stored credential
>        git credential-foo --get --url=...,etc | read password
>
>        # we had a successful authentication; ask the helper to store it;
>        echo password | git credential-foo --put --url=...,etc
>
>      That makes the helpers much simpler, and makes interacting with the
>      user more uniform across helpers.
>
>      It disallows helpers doing specialized interactions or dialogs.

Very true.

I have this suspicion that running dialog on various desktop environments
may be orthogonal to what credential store to be used. Once we know the
repertoire of the broken-down pieces, we may want to add "dialog-foo"
family of helpers whose sole purpose is to interact with the user to get
missing information.  E.g. we may notice that we need to ask both the
username and password, and invoke

    $ dialog-foo --msg=$msg --ask=username --ask-secret=password

where $msg tells the user why we are asking these pieces (e.g. trying to
push into https://example.com/repo.git), and then read from the helper
what the user gave it.

If the URL had user1@ in it, then the $msg would say that we are trying to
push into https://example.com/repo.git as user1, and we invoke the helper
with only --ask-secret=password (without --ask=username).

The same "helper" executable _could_ implement both interfaces, but I
think they are logically separate.
