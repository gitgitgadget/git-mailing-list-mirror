From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-objects: name pack files after trailer hash
Date: Mon, 16 Dec 2013 11:33:11 -0800
Message-ID: <xmqqzjo0oako.fsf@gitster.dls.corp.google.com>
References: <CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com>
	<211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com>
	<CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
	<20131128092935.GC11444@sigill.intra.peff.net>
	<CAJo=hJuBTjGfF2PvaCn_v4hy4qDfFyB=FXbY0=Oz3hcE0L=L4Q@mail.gmail.com>
	<20131204200850.GB16603@sigill.intra.peff.net>
	<CAJo=hJuRz9Qc8ztQATkEs8huDfiANMA6gZEOapoofVdoY82k4g@mail.gmail.com>
	<20131205160418.GA27869@sigill.intra.peff.net>
	<20131205202807.GA19042@sigill.intra.peff.net>
	<52AEAEB2.6060203@alum.mit.edu>
	<20131216190445.GB29324@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 16 20:33:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vsduq-0001no-Ki
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 20:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755365Ab3LPTdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 14:33:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37108 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755107Ab3LPTdP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 14:33:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F7F65BABF;
	Mon, 16 Dec 2013 14:33:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CPNOIi2kF5DqiYWjkIgZnoiIh4o=; b=STSzWX
	yHhczcRqY5vJ2T0BZJJRK17GeCXAYikW2zjf3qyTC1upHzQrV9esWGUxknB3reYg
	ne997DWqER9WZOm6oSmuzDfAPYPyg9KP/B2CZmQsYhfbAtpc0/zuTzfrUtPLYjLZ
	CHqI6KWtMRhKyDwf/TSjr3DpBBVZxa4GssTtc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WywjVduU3+nnaWfAVY4Z5w4fwsvGpyM7
	nU2Hj+cB48D1lYNMZ71j6i5G9AyhkiqaURxsOnLyhFXfaAxWcZIXnY7/GKMVkdV6
	xn1CRNwWtCId/OZZChfUxeaMryxWeNuQ1IQjiY9v8nOx3HgsQrYvlY6CihX6tEP9
	LVDHqQ0UiHA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 188A85BABD;
	Mon, 16 Dec 2013 14:33:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 286485BABA;
	Mon, 16 Dec 2013 14:33:13 -0500 (EST)
In-Reply-To: <20131216190445.GB29324@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 16 Dec 2013 14:04:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E733B10A-6688-11E3-BD78-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239354>

Jeff King <peff@peff.net> writes:

> I was tempted to explicitly say something like "this is
> opaque and meaningless to you, don't rely on it", but I don't know that
> there is any need.

Thanks.

When we did the original naming, it was envisioned that we may use
the name for fsck to make sure that the pack contains what it
contains in the name, but it never materialized.  The most prominent
and useful characteristic of the new naming scheme is that two
packfiles with the same name must be identical, and we may want to
start using it some time later once everybody repacked their packs
with the updated pack-objects.

But until that time comes, some packs in existing repositories will
hash to their names while others do not, so spelling out how the new
names are derived without saying older pack-objects used to name
their output differently may add more confusion than it is worth.

>  	<base-name> to determine the name of the created file.
>  	When this option is used, the two files are written in
>  	<base-name>-<SHA-1>.{pack,idx} files.  <SHA-1> is a hash
> +	of the bytes of the packfile, and is written to the standard

"hash of the bytes of the packfile" tempts one to do

    $ sha1sum .git/objects/pack/pack-*.pack

but that is not what we expect. I wonder if there are better ways to
phrase it (or alternatively perhaps we want to make that expectation
hold by updating our code to hash)?
