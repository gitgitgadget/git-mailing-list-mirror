From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Thu, 16 Feb 2012 12:15:24 -0800
Message-ID: <7vwr7my1pf.fsf@alter.siamese.dyndns.org>
References: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
 <CAA01Csp6_9fP2rg4104UWUXwOxZmUVdQNDAaBe6fRou6agBz6g@mail.gmail.com>
 <8762f9k5sg.fsf@thomas.inf.ethz.ch>
 <CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
 <20120215190318.GA5992@sigill.intra.peff.net>
 <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
 <87d39eswkx.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 16 21:15:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ry7jn-00084e-HC
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 21:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572Ab2BPUP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 15:15:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51206 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753384Ab2BPUP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 15:15:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC2C26050;
	Thu, 16 Feb 2012 15:15:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GbcsNskE2F6Z+EXG6r2Wslz81CY=; b=rrCiYF
	VTqfcQeyuz7kLPCfiuTqazimT9P9LsCMjDUAjYUvDFhQseKOumu0fv6cL02Bxxow
	SMWiVlfO7sNPBc/YbykMhvW9leoivbhC83fKWbsLb9DBPX3rT8vX6AszLs0WUnr0
	uxk672DWkWiKJPqVtjSjwIOzhBHEODEPuUinM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HvEpoDGvLSovp8xaPS4mYsrGBuKG7s2B
	vA/oaB0ERr8wCDAD312K9Zz4opGhj3eZFpnJYL9l5c02s2PMATyBkTafbmrh5+QE
	uiY28rG3R8qOMLQ9yH/oUZyhbjIvmSlyWj0t9UcjSI4VaiC4kjnSKP/muIhKlE5n
	wpO4zyvZ4Xg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D29E8604F;
	Thu, 16 Feb 2012 15:15:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62EB3604E; Thu, 16 Feb 2012
 15:15:25 -0500 (EST)
In-Reply-To: <87d39eswkx.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Thu, 16 Feb 2012 15:05:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F6323D88-58DA-11E1-A851-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190906>

Thomas Rast <trast@inf.ethz.ch> writes:

> ...  If my memory of pack organization serves
> right, the commit objects involved would essentially be spread across
> the whole pack

No they are crumped together in a contiguous section in a packfile, so
that "git log" without any pathspec can go faster without consulting tree
objects.
