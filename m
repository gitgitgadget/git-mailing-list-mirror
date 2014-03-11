From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Tue, 11 Mar 2014 13:25:23 -0700
Message-ID: <xmqq4n34pjnw.fsf@gitster.dls.corp.google.com>
References: <5110BD18.3080608@alum.mit.edu>
	<20130205083327.GA4931@elie.Belkin> <5110DF1D.8010505@alum.mit.edu>
	<CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
	<7v4nhpckwd.fsf@alter.siamese.dyndns.org>
	<CACBZZX6xLvuMEhPnfYLj8W9pMLwdoS7Zb+mTtn+3DanJPiWfXw@mail.gmail.com>
	<7vmwvh9e3p.fsf@alter.siamese.dyndns.org>
	<CACsJy8Aas3tRoDp9LQw7Nwf6+S3QnvwA7h7s-sHVY+1yFKhTYg@mail.gmail.com>
	<20140311014945.GB12033@sigill.intra.peff.net>
	<xmqqtxb4pm3u.fsf@gitster.dls.corp.google.com>
	<20140311200513.GB29102@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 11 21:25:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNTF0-0000JW-1K
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 21:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565AbaCKUZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 16:25:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63607 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755475AbaCKUZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 16:25:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F36F74DED;
	Tue, 11 Mar 2014 16:25:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iHH9s2Ri6cmZArFkltHGx+YpVrM=; b=yUQPy3
	Pi80wcms3GYb8hn6iTaZFUKt3suQTOcu7A7IANNgzUNIlEeT9qZZYCPGw2ensTjZ
	6JjtBu6kcePVAoLDuYR2WMt7LbGXd6pNTNMt3TMyFEZY6/ujReLwMC5E+S2sjD0r
	TGbv9npBpk7svX4ff9cG8xkeTzzzlY91eyqQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AMmWU+vRbwpfXGtRof7EAAjoBHnnqJn6
	DhBAa7B/9LAWQrB4FFStoNgOfJhV/oaDh/MSL4WjXZEfKqSK+XGgkgmZCFM/+ScO
	UFnuziz/DqK/Fx9JNF6KjXhWDDoA7hPH/erlbMnRB6L9HCOO+Xt+sqcZobALvfnv
	GXYPhOxv/Cc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 293E574DEC;
	Tue, 11 Mar 2014 16:25:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4201174DEB;
	Tue, 11 Mar 2014 16:25:25 -0400 (EDT)
In-Reply-To: <20140311200513.GB29102@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 11 Mar 2014 16:05:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 473CD29C-A95B-11E3-B105-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243892>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 11, 2014 at 12:32:37PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > I think the main flag of interest is giving an fnmatch pattern to limit
>> > the advertised refs. There could potentially be others, but I do not
>> > know of any offhand.
>> 
>> One thing that comes to mind is where symrefs point at, which we
>> failed to add the last time around because we ran out of the
>> hidden-space behind NUL.
>
> Yeah, good idea. I might be misremembering some complications, but we
> can probably do it with:
>
>   1. Teach the client to send an "advertise-symrefs" flag before the ref
>      advertisement.
>
>   2. Teach the server to include symrefs in the ref advertisement; we
>      can invent a new syntax because we know the client has asked for
>      it.

I was thinking more about the underlying protocol, not advertisement
in particular, and I think we came to the same conclusion.

The capability advertisement deserves to have its own separate
packet message type, when both sides say that they understand it, so
that we do not have to be limited by the pkt-line length limit.  We
could do one message per capability, and at the same time can lift
the traditional "capability hidden after the NUL is purged every
time, so we need to repeat them if we want to later change it,
because that is how older clients and servers use that information"
insanity, for example.
