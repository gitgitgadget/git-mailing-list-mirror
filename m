From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Feeding an annotated but unsigned tag to "git merge"
Date: Thu, 07 Jun 2012 09:17:03 -0700
Message-ID: <7vhaunjdvk.fsf@alter.siamese.dyndns.org>
References: <1338926312-4239-1-git-send-email-gitster@pobox.com>
 <20120606134207.GB2597@sigill.intra.peff.net>
 <7vzk8gmm5b.fsf@alter.siamese.dyndns.org>
 <20120607090933.GB6087@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 07 18:17:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScfOZ-0000Vf-35
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 18:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790Ab2FGQRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 12:17:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53652 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517Ab2FGQRF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 12:17:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB2147C2F;
	Thu,  7 Jun 2012 12:17:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q6wCrZKUR92+equh4QVHDDto70M=; b=A5rHwj
	bHncZb5y9+M6ZwlRJGkzVoeFn/pDDDOFB56c+5EEl3zfTWlwjqgrvlpy4ivWoZf/
	hSdqgDgZzToHji5bk6WOyi7z9R63v2FV4OEKUCrqfyBENi3sZBUJ8r11Xe46K/Vu
	N2VRVBdJoocG7cSLGzFX3/XK7HD64sBQgIklM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pgGFq7yzHuOMV4KJfWpXxlzYd8AT08Se
	QucsrpRA9k9w8rWlXFpAHBYb3SHAR+yMWjerP7b2LNJPCOdzk+nn9xXwxldlpBNU
	SQKQ+FsKmUnX1IuCZRFiCjG8J1ciBcSPXnn2CbeUFYOUCp466yFi7OlBbIPUVa4o
	ghMJGEnKuZo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D26A97C2E;
	Thu,  7 Jun 2012 12:17:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6393F7C2D; Thu,  7 Jun 2012
 12:17:04 -0400 (EDT)
In-Reply-To: <20120607090933.GB6087@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 7 Jun 2012 05:09:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3862F5C4-B0BC-11E1-9D45-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199414>

Jeff King <peff@peff.net> writes:

> On Wed, Jun 06, 2012 at 09:37:52AM -0700, Junio C Hamano wrote:
>
>> > This just doesn't make sense to me. Why would we treat annotated but
>> > unsigned tags differently from signed tags? In both cases, the new
>> > behavior is keeping more information about what happened, which is
>> > generally a good thing.
>> >
>> > I haven't seen any good argument against creating these merges[1].
>> 
>> It is in line with --ff-only special casing, though.
>
> Is it?  My impression from reading b5c9f1c is that --ff-only trumps both
> annotated _and_ signed tags. Which makes sense to me. What I was
> objecting to is that "some tag objects are more equal than others". It's
> OK to treat unannotated tags differently from tag objects, but treating
> annotated but unsigned objects differently from signed objects seems
> unnecessary and complex.

OK, let's drop it.
