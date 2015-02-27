From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Fri, 27 Feb 2015 15:05:58 -0800
Message-ID: <xmqqioenhs4p.fsf@gitster.dls.corp.google.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
	<CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
	<CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
	<CAGZ79kbZHtZuPrb6rEP41vbdnZqJmsMwq+8pNer-_D4U5B1xZw@mail.gmail.com>
	<CACsJy8BN2imGCW0cueh-jGKfN_nRg3=J-GTX2P5h2z0Tu=id6A@mail.gmail.com>
	<xmqqsidtoojh.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
	<CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
	<xmqqzj80l9c7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 00:06:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRTz4-0004S0-FX
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 00:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbbB0XGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 18:06:06 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932342AbbB0XGB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 18:06:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 65F873CFB7;
	Fri, 27 Feb 2015 18:06:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7wUW/ND0COWqMdbb1VaTrQCm5z0=; b=cuSe+X
	mWtmPjMyHJR20fNBbLrtWUHw1gJgIIe+6jUvf2K+QWICOVrLJt24XCUFcIYxAasy
	8bY6IUKMFHlCndbRZgG8zgjz2g7NBYB+aXgmudHzlN/FoDBIF2fFUhXCc43o5qsx
	Yo5s8qgRWmtgYqk5lOtZw3X+tA/PCoW9qylcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SK8y48fiPJcIj/+AboM4Ps4lSoz28D/X
	kkPJG/B4aTpNGhB5ggUlihbg+nIpx7KbRBSV/5ylCe+BYF/CEGgXuzRp+XQrYVlN
	wDPVfjllwQ8P7SnCb/w98QeSm1/NB8G01VL2EXBZg8C+gQ+uNP6WrMEwSoVX/mX5
	1GVisNFuRpY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C3093CFB4;
	Fri, 27 Feb 2015 18:06:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA1383CFB3;
	Fri, 27 Feb 2015 18:05:59 -0500 (EST)
In-Reply-To: <xmqqzj80l9c7.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 26 Feb 2015 12:13:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 319EDDDC-BED5-11E4-A44B-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264512>

Junio C Hamano <gitster@pobox.com> writes:

> I do not think v1 can be fixed by "send one ref with capability,
> newer client may respond immediately so we can stop enumerating
> remaining refs and older one will get stuck so we can have a timeout
> to see if the connection is from the newer one, and send the rest
> for the older client", because anything that involves such a timeout
> would not reliably work over WAN.

Just for fun, I was trying to see if there is a hole in the current
protocol that allows a new client to talk a valid v1 protocol
exchange with existing, deployed servers without breaking, while
letting it to know a new server that it is a new client and it does
not want to get blasted by megabytes of ref advertisement.

The idea is to find a request that can be sent as the first
utterance by the client to an old server that is interpreted as a
no-op and can be recognised by a new server as such a "no-op probe".
If there is such a request, then the exchange can go like this with
(new client, old server) pair:

    - new client connects and sends that no-op.

    - old server starts blasting the ref advertisement

    - new client monitors and notices that the other side
      started speaking, and the ref advertisement lacks the
      capability bit for new protocol.

    - new client accepts the ref advertisement and does the v1
      protocol thing as a follow-up to what it already sent.

As long as the first one turns out to be no-op for old server, we
would be OK.  On the other hand, (new client, new server) pair
would go like this:

    - new client connects and sends that no-op.

    - new server notices that there is already a data from the
      client, and recognises the "no-op probe".

    - new server gives the first v2 protocol message with
      capability.

    - new client notices thqat the other side started speaking, and
      it is the first v2 protocol message.

    - both sides happily speak v2.

and (old client, new server) pair would go like this:

    - old client connects and waits.

    - new server notices that there is *no* data sent from the
      client and decides that the other side is a v1 client.  It
      starts blasting the ref advertisement.

    - both sides happily speak v1 from here on.

A misdetected case between (new client, new server) pair might go
like this:

    - new client connects and sends that no-op.

    - new server accepts the connection, but that no-op probe has
      not arrived yet.".  It misdetects the other side as a v1
      client and it starts blasting the ref advertisement.

    - new client notices that the ref advertisement has the
      capability bit and the server is capable of v2 protocol.  it
      waits until the server sends "sorry, I misdetected" message.

    - new server eventually notices the "no-op probe" while blasting
      the ref advertisement and it can stop in the middle.
      hopefully this can happen after only sending a few kilobytes
      among megabytes of ref advertisement data ;-).  The server
      sends "sorry, I misdetected" message to synchronise.

    - both sides happily speak v2 from here on.

So the topic of this exercise ("just for fun") is to see if there is
such a no-op request the client side can send as the first thing for
probing.

On the fetch side, the first response upload-pack expects are one
of:

  - "want " followed by an object name.
  - "shallow " followed by an object name.
  - "deepen " followed by a positive integer.

And there _is_ a hole ;-).  The parsing of "shallow " object name is
done in such a way that an object name that passes get_sha1_hex()
that results in a NULL return from parse_object() is _ignored_.  So
a new client can use "shallow 0{40}" as a no-op probe.

It appears that on the push side, there is a similar hole that can
be used. receive-pack expects either "shallow ", "push-cert" or the
refname updates (i.e. two "[0-9a-f]{40}" followed by a refname); the
parsing of "shallow " is not as loose as the fetch side in that
using a "shallow 0{40}" as a no-op probe will end up causing
prepare_shallow_info() sift the "0{40}" object name into "theirs",
but I think it will be ignored at the end as "unreachable cruft"
without causing harm.

I am _not_ proposing that we should go this route, at least not yet.
I am merely pointing out that an in-place sidegrade from v1 to a
protocol that avoids the megabyte-advertisement-at-the-beginning
seems to be possible, as a food for thought.
