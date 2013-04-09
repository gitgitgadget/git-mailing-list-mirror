From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Using a bit more decoration
Date: Mon, 08 Apr 2013 21:17:42 -0700
Message-ID: <7vsj30tk0p.fsf@alter.siamese.dyndns.org>
References: <20130408210903.GC9649@sigill.intra.peff.net>
 <1365462114-8630-1-git-send-email-gitster@pobox.com>
 <20130409035126.GA17319@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 09 06:17:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPQ0M-0001Ij-9q
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 06:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694Ab3DIERq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 00:17:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64655 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300Ab3DIERp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 00:17:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B3B6F6C1;
	Tue,  9 Apr 2013 04:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LkVFvh5Z+I7XubYTpJzHmIsLs+g=; b=TGv1g8
	njCDfeMC4dvtFg8f0peFzRbPaHtnBkWM6nTqrEQM7uToAMBU4B6/s0nR7MuigfCK
	iYLrzkuZqvHAimWYQqMsPxbty8k70gz7VfmdaAS404XR9NqQs4blvm67bMMZyM74
	WUf7KJLcAFNkutd5J6uw83Rb0y0SSOUHS4Z8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Twst8YEs8Kk4FFRzmPrcpxG0VLzNJwWk
	MEBssCJxbOWBFHPWxCsHKS8Li12AnwXHD3AWFHGwPOrCniqmPidBu8OMvt7EQmP3
	7kbQyVdQo1jPtk79AZiVY5FaweTfEEfKUyfyqEuMIHdwwjU5N+1O1M7UR81lhYyX
	YLqV69LtPn8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F96CF6C0;
	Tue,  9 Apr 2013 04:17:44 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA245F6BD; Tue,  9 Apr 2013
 04:17:43 +0000 (UTC)
In-Reply-To: <20130409035126.GA17319@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 8 Apr 2013 23:51:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D1E7E7C-A0CC-11E2-AB66-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220547>

Jeff King <peff@peff.net> writes:

> [1] The thing that made me think about this was making a version of
>     paint_down_to_common that could keep a separate color for each
>     source, rather than only PARENT1 and PARENT2. That would let us do
>     the "--contains" traversal in a breadth-first way, but calculate the
>     answer simultaneously for all sources (i.e., avoid the depth-first
>     "go to roots" problem that the current "tag --contains" has if you
>     do not use timestamp cutoffs).

Yes, show-branch operates independently of rev-list machinery, hence
can use full set of bits, but the full set of bits in a word is not
always sufficient and it can be helped greatly with such an unbound
set of bits machinery.
