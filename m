From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repack.c: rename and unlink pack file if it exists
Date: Wed, 05 Feb 2014 13:08:36 -0800
Message-ID: <xmqq7g992ror.fsf@gitster.dls.corp.google.com>
References: <xmqqwqha5twg.fsf@gitster.dls.corp.google.com>
	<20140205011632.GA3923@sigill.intra.peff.net>
	<xmqq1tzh494e.fsf@gitster.dls.corp.google.com>
	<20140205201243.GA16899@sigill.intra.peff.net>
	<xmqqsirx2teh.fsf@gitster.dls.corp.google.com>
	<20140205203740.GA17077@sigill.intra.peff.net>
	<xmqqfvnx2s7p.fsf@gitster.dls.corp.google.com>
	<20140205210129.GA24314@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
	<tboegi@web.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 05 22:08:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB9iB-0002Q9-4v
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 22:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbaBEVIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 16:08:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34579 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932266AbaBEVIj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 16:08:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE5E269F9A;
	Wed,  5 Feb 2014 16:08:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9u87feXNNt9HnEOLy3BeryXqe3k=; b=NWp3cV
	jrBRftwnwN2kBnWUBqUjG8dxeASN0he+CwSRgN5KnTf7c+fO/HD4XUwfbU+BSQ1c
	JxA8ZlnkGQ5o0b4syqKZxPyTh9nXfXde4VlA4TI5+BzpiSGsAl8tIABAiXfqfFbu
	XKmFUQkkUdzMoFFKqoO4NqxtI9DQ8ujRBj3nU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aGNCYb1dtJkvDNJCbinlEftntCfXIbbv
	LDyNU0BtWbuRNSnXRWYlQZKj3okXRDdXLskI7GfZdA3ck9WJUDg9nVi+zbeKVzLs
	kgU8vYF86zs7781Yptxkhy4M1OMaCW0wiXDL3VqMbOfsAczonw9Sg7vh+fy6j/Pv
	8omrpCBxLoU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF7AB69F98;
	Wed,  5 Feb 2014 16:08:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F36DA69F93;
	Wed,  5 Feb 2014 16:08:37 -0500 (EST)
In-Reply-To: <20140205210129.GA24314@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 5 Feb 2014 16:01:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AE88D3DC-8EA9-11E3-841D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241665>

Jeff King <peff@peff.net> writes:

> ... So the fact that this
> bug exists doesn't really produce any user-visible behavior, and
> hopefully post-release we would drop the code entirely, and the test
> would have no reason to exist.

Heh, thanks, and I agree with the reasoning for the longer-term
direction.  Perhaps I can/should hold it off that minimal fix-up
patch from -rc3, then?  I am on the fence but I already started my
today's integration cycle _with_ the fix merged to 'master', so...
