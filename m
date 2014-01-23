From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t7700: do not use "touch -r"
Date: Thu, 23 Jan 2014 13:12:55 -0800
Message-ID: <xmqq61patnag.fsf@gitster.dls.corp.google.com>
References: <20140123195404.GA31314@sigill.intra.peff.net>
	<20140123195518.GB31871@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 23 22:13:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6RaD-0005kD-Gx
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 22:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990AbaAWVNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 16:13:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754896AbaAWVM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 16:12:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08A326491F;
	Thu, 23 Jan 2014 16:12:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cpEW6XiBLZxbi1tzHLPlrcfbC5k=; b=FQM5un
	arRBqgG9yhRgRfRPOFz+noKkcZwVAtI7PHkviySFOVzKoNM4wgzEzVbLzBfbvJ8k
	TGLTjvEVBIKGHl2nUNTMbg/FWEtnk7m8eRxgIm1pgkEW2OadLbL6JH3KOyRvP6lB
	GcbBoGFns4QP1MmusgmCSbSOLtCtWHJEvf1xA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DqM9XboYWIUioeyIEVCAfVrSx90FW64m
	ZjAUy64EbXJ3nmGhhy5jONJ8CbxXWJxDzQVOSqqc6uWGQJ1HfCEUXr/QyBa416D4
	XB58OTkYBJMOtVoK+Kr/N7TPLvh4gm/WfetCSK6A6316f+kwO9KAjMVc/ltvh5lr
	Qo24KF5QAsQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBAC96491D;
	Thu, 23 Jan 2014 16:12:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCF346491C;
	Thu, 23 Jan 2014 16:12:57 -0500 (EST)
In-Reply-To: <20140123195518.GB31871@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 23 Jan 2014 14:55:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2214B442-8473-11E3-96B0-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240954>

Jeff King <peff@peff.net> writes:

> ... The test does not care about the timestamp of the
> .keep file it creates at all, only that it exists.

Please refrain from using "touch" for such use cases in the first
place.  It appears that

	>pack-$packsha1.keep &&

is what the test wants.
