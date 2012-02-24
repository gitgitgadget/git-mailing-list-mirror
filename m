From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Announcing nntpgit
Date: Fri, 24 Feb 2012 13:38:33 -0800
Message-ID: <7v62evykrq.fsf@alter.siamese.dyndns.org>
References: <20120224133942.49a7a420@dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
X-From: git-owner@vger.kernel.org Fri Feb 24 22:38:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S12qg-0002Y0-87
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 22:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756595Ab2BXVih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 16:38:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33737 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754844Ab2BXVih (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 16:38:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29CA373DF;
	Fri, 24 Feb 2012 16:38:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d6wlLhugT/bOhIYo0AgKGozEQuI=; b=PDFB68
	Lhcknr0H/tHndDLpXNelTz782C9q+4tgoNqH8ZxfV+/24q8DJh/wYwkG7MfdmTGX
	96k2DDGQ9enprwuw9YUuT4LlKrgOL7JvRuC7D6F8HEpXnQiSJg6rVYJkvWAERRGv
	tyaBpXLHyd0IlbfV5rKHBsRJmHfewmTrSdRSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K2kCHDnsyChykdCJpKdDeAQ0eLdgUvdp
	3rjR13rMVBR1INN4+dZDHrYIgrkl5bt/BnRAwEgXuAP81w+WGOcXtb/FtIuxv7sw
	arucC4mUOByisQk3ijxF4gP1Mleu0uIZ76pCUeKosJKbxp6iE9HNSyHYc/sVBneE
	1PYcIlNjDqw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20C0173DE;
	Fri, 24 Feb 2012 16:38:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A08173DC; Fri, 24 Feb 2012
 16:38:35 -0500 (EST)
In-Reply-To: <20120224133942.49a7a420@dt> (Jonathan Corbet's message of "Fri,
 24 Feb 2012 13:39:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7C628DA-5F2F-11E1-9F2F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191486>

Jonathan Corbet <corbet@lwn.net> writes:

> When kernel.org went down, it took the mainline kernel commits list with
> it. That had a fairly serious and unfortunate effect on my workflow,
> which, among other things, depends on knowing what's being merged.  I
> hacked up various workarounds, but none of them were as useful or
> efficient.
>
> Eventually it occurred to me that what I *really* wanted was the commit
> stream as an NNTP feed so I could read it in gnus along with most of the
> other lists I follow.  The result was nntpgit, a small Python3 program
> that tracks repository branches and makes new commits available as
> "articles" to all comers.  I've been working with it for a few weeks now
> and I'm quite happy; it works better for me than the old list did.
>
> Should anybody wish to experiment with it, they can do so in two ways.
> First, the code is available (GPLv2) from:
>
> 	git://git.lwn.net/nntpgit.git
>
> Alternatively, it's running on port 8119 on git.lwn.net.  There are
> currently two "newsgroups": lwn.mainline for mainline commits, and
> lwn.networking for davem's networking tree.  I expect to add others over
> time.

Neat.

This is something I wanted to write (or see somebody write so that I can
use it ;-)) even before I became the maintainer of this project, as I
practically live inside GNUS, but never got around to go beyond the design
phase.

How do you handle message threading (References: and In-Reply-To:)?

Would a commit on the "mainline" (a rough approximation of it would be
"log --first-parent" starting from the tip) form the discussion starter
article, and any side branch that fork from them would be a discussion
thread starting at the commit?
