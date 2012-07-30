From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Enhancements to git-protocoll
Date: Sun, 29 Jul 2012 23:28:00 -0700
Message-ID: <7vy5m1sqz3.fsf@alter.siamese.dyndns.org>
References: <20120728214116.GA3591@paksenarrion.iveqy.com>
 <7vehnvvyta.fsf@alter.siamese.dyndns.org>
 <20120729142458.GB16223@paksenarrion.iveqy.com>
 <CAMK1S_iTv3BOV3LEoj83feuO2iQnPqTrOq0wyFC-GrvvJQqWTA@mail.gmail.com>
 <7vvch6uw89.fsf@alter.siamese.dyndns.org>
 <7vr4ruuu2e.fsf@alter.siamese.dyndns.org>
 <CAMK1S_geKq5DkNAy2wxGt5EmoOesxaSKKuQjVaQVcbRVdR+9gA@mail.gmail.com>
 <CAJo=hJsgMz-=pdG=HB3KtTE7g6Gvu9mr56dg2+V3WUST+rpAQg@mail.gmail.com>
 <7vehnut1kt.fsf@alter.siamese.dyndns.org>
 <CAJo=hJvjFP0m96YPNBCwvnkRGWhMZQdbL7C3Shsa6HQ62a9FuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 08:28:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvjSl-00027c-PF
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 08:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091Ab2G3G2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 02:28:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60208 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753694Ab2G3G2D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 02:28:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0ED673F3;
	Mon, 30 Jul 2012 02:28:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W8C6CewnLrZO0oqcIqOrExWrPTg=; b=yjiVXb
	BDurA26pIBaDWiF+A+4J5FUBgIs0QYcaryQy+2Soq3qtl2Zs8aMaTX81gmBNlBu4
	n0rWmoU/3zleYUSo5LljkDOkKWNmvYrjhalqnE1O7WRSkdLh4oAl+uoZscp5UAKb
	/9ohpIpH2KMFOZ+hMKxue/qOblO4y4iq6Ue14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CkBSWJ2SI8ORZacKZKDxrGmUugoxQWIs
	mxHomjD045cq0nveaxkcsyd2fWsRjgTu9AfSIgQ/LuPpmEinYiOhU9LraagGTS6v
	UbwfzbR90lOdw+hX/OOGt1KMyXoNi2V0leJFmSmB0TavWza6BO4LOmgHyebLHfgJ
	OHIUcGxTweo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81BFF73F1;
	Mon, 30 Jul 2012 02:28:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A915A73F0; Mon, 30 Jul 2012
 02:28:01 -0400 (EDT)
In-Reply-To: <CAJo=hJvjFP0m96YPNBCwvnkRGWhMZQdbL7C3Shsa6HQ62a9FuA@mail.gmail.com> (Shawn
 Pearce's message of "Sun, 29 Jul 2012 22:20:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B661280C-DA0F-11E1-9102-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202524>

Shawn Pearce <spearce@spearce.org> writes:

>> The way to expose the extra information parsed by Git to the server
>> side could be made into calling out to hooks, and at that point,
>> gitolite would not even have to know about the pack protocol.
>
> Good point. The case that spawned this thread however still has a
> problem with this approach. gitolite would need to create a repository
> to invoke the receive-pack process within, and install that new hook
> script into... when the hook was trying to prevent the creation of
> that repository in the first place.

Heh.  While I do not particularly consider auto-creation-upon-push a
useful thing to begin with (after all, once you created a
repository, you would want ways to manage it, setting up ACL for it
and stuff like that, so adding a "create" command to the management
interface suite would be a more natural direction to go), as long as
we are discussing a hack that involves hooks, I do not think your
observation is a show-stopper downside.

The hook can interact with the end user over the back channel and
decide to abort the transaction, while leaving some clue in the
repository that is pre-agreed between the gitlite server and the
hook.  When gitolite culls the process with wait4(2), it could
notice that "clue", read the wish of the hook that the repository
needs to be removed from it, and remove the repository. Up to that
point, there is no real data transferred, so there isn't much wasted
time or network resource anyway.

> An ancient Git would abort hard if passed this flag. An updated Git
> could set environment variables before calling hooks, making the
> arguments visible that way. And gitolite can still scrape what it
> needs from the command line without having to muck about inside of the
> protocol, but only if it needs to observe this new data from pusher to
> pushee?

I do not think the details of how the extra information is passed
via the Git at the receiving end to its surrounding matters that
much.  It would even work fine if we let the hook to talk with the
end user sitting at the "git push" end, by using two extra sidebands
to throw bits between them, while the Git process that spawned the
hook acts as a relay, to establish a custom bi-di conversation (but
again, I do not think it is useful, because such an out of band
conversation cannot affect the outcome of the main protocol exchange
in a meaningful way other than aborting).

Or you could export environment variables, which would be far more
limiting with respect to the nature of the data (i.e. needs to be
free of NUL) and the size of data you can pass.  The limitation may
actually be a feature to discourage people from doing wacky things,
though.

> `git push -Rfoo=baz host:dest.git master` on the client would turn
> into `git-receive-pack -Rfoo=baz dest.git` in the SSH and git://
> command line, and cause GIT_PUSH_ARG_FOO=baz to appear in the
> environment of hooks. Over smart HTTP requests would get an additional
> query parameter of foo=baz.

I think using the same "extra args on the command line" would be a
good way to upgrade the protocol version in a way the current
"capability" system does not allow us to (namely, stop the party
that accepts the connection from immediately advertising its refs).

> The other hacky idea I had was to use a fake reference and have the
> client push a structured blob to that ref. The server would decode the
> blob, and deny the creation of the fake reference, but be able to get
> additional data from that blob. Its hacky, and I don't like making a
> new blob on the server just to transport a few small bits of data from
> the client.

That way lies madness, and at that point, you are better off doing a
proper protocol extension by registering a new capability and defining
the semantics for it.
