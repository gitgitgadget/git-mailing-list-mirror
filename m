From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] jk/version-string and google code
Date: Fri, 10 Aug 2012 08:37:27 -0700
Message-ID: <7vboiilpvs.fsf@alter.siamese.dyndns.org>
References: <20120810075342.GA30072@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 10 17:37:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzrHL-0006vV-8t
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 17:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225Ab2HJPha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 11:37:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51250 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547Ab2HJPh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 11:37:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AADE87BB;
	Fri, 10 Aug 2012 11:37:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lz9Q15kxg3CVIEwjU52PRDipYHk=; b=aMJmPJ
	5G6UzHyl1XdHWD6MwdMFvEaWGpUYXf3DbxZnVm2wFafQaH2ciDQFzEZO+27d/u55
	LRbqvfTaJ5zA1IenfrAL10KSpZjU+kNl6gWN9qf0aBsFJSaHKiXxw6n087XJB8DA
	Pzztt3NYAVPYZCfDQQkjj7MTtk2PEvXz7Ylz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x/i8cTB3IFtaONWHjzLHV7g83R0lEu+F
	5V5EdeemDfV4WCSC2Ml7srO6ET7lSGks1rkmglAJhnFefzOEep1WqYetKVKlxdjE
	Rm+Bog3JBQ4TJgwiAtqhPx4hoZNIjysHuCDPzfGJ4E4IlkHr+TLugjVyP6sy6p3y
	Pu0EVZo5y8w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 781BA87BA;
	Fri, 10 Aug 2012 11:37:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED79087B7; Fri, 10 Aug 2012
 11:37:28 -0400 (EDT)
In-Reply-To: <20120810075342.GA30072@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 10 Aug 2012 03:53:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4AF404EA-E301-11E1-8FFF-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203227>

Jeff King <peff@peff.net> writes:

> Ugh, the jk/version-string topic breaks fetching from Google Code. With
> my patch, the client unconditionally sends an "agent=foo" capability,
> but the server does not like seeing the unknown capability and ends the
> connection (I'm guessing with some kind of internal exception, since it
> spews "Internal server error" over the protocol channel).

I asked the folks who run code.google.com and they are indeed seeing
something like these in their logs:

 >> Client asked for capability agent=git/1.7.12.rc2.79.g86c1702 that was not advertised.

So please consider your conjecture confirmed, and thanks for a
prompt fix.
