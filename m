From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git://github.com/some/thing.git/?
Date: Tue, 27 Mar 2012 11:25:22 -0700
Message-ID: <7vd37xj3zh.fsf@alter.siamese.dyndns.org>
References: <7vpqbyjbbx.fsf@alter.siamese.dyndns.org>
 <20120327163339.GA5941@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 20:25:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCb5H-00056b-3S
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 20:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909Ab2C0SZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 14:25:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51180 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754802Ab2C0SZY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 14:25:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 703656B0F;
	Tue, 27 Mar 2012 14:25:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yF9yVfSbxcHY8tPppJe6iZAWDS8=; b=hfQO+6
	ANaJM7iEOs0ihd94n4ByMbPrkr8xdOFZF4DHDg/WwfQCmzVNUnFZbhuzSYNBqbMF
	Hvkf85NE8WH1vyndQQs1RQbqunkDq13AgGmAQxHWepIrK3BH847Los1pmymdTgfS
	NMxFz1vzMaV0nQxE0LfjIrbxUf6wuC5esxIH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Id9rNDaktfbfGVpZWrd8GX7wzCLAJtJa
	GC9I2dIF1aIQ0u7RxYOXH95Hiv7t04waJECOb7myVkGU7sT4laj6fS1UaCsclCk1
	usdrz2n8yfarDmCeNkdpGhRoCJDeYIKWw/04QN5RsZdK+2+cg/Gz75+9k++3TLFD
	acXihYZUTEk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6729C6B0D;
	Tue, 27 Mar 2012 14:25:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EABBC6B0C; Tue, 27 Mar 2012
 14:25:23 -0400 (EDT)
In-Reply-To: <20120327163339.GA5941@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 27 Mar 2012 12:33:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37EFC14A-783A-11E1-96F4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194070>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 27, 2012 at 08:46:42AM -0700, Junio C Hamano wrote:
>
>> I just noticed that
>> 
>> 	git ls-remote git://repo.or.cz/alt-git.git/
>> 
>> works, but neither of the following does:
>> 
>> 	git ls-remote git://git://github.com/gitster/git.git/
>> 	git ls-remote git://git://github.com/gitster/git/
>> 
>> It is just a minor irritation but it would be really nice if you can fix
>> it (please don't spend too much time on it if it is too involved, though).
>
> Of course they don't work, they are malformed. :)

Ahh, drop the duplicated "git://" from the front.

> It took me a minute to figure it out, but I assume the interesting part
> is the trailing slash?

Yes.

> Even with that, though, I think it would be good for the server to be
> liberal in what it accepts.

It is not about being liberal; it is about accepting what we have always
accepted.
