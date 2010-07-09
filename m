From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff.c: fix a graph output bug
Date: Thu, 08 Jul 2010 18:09:41 -0700
Message-ID: <7vwrt5mpey.fsf@alter.siamese.dyndns.org>
References: <4c35eb6c.21078e0a.1455.ffffe42d@mx.google.com>
 <7vhbk9o6ie.fsf@alter.siamese.dyndns.org>
 <7v1vbdo4j5.fsf@alter.siamese.dyndns.org>
 <AANLkTilSbmU5ejI5lWcN9GFQ544xd0zBtn-5s-nLzBAv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, struggleyb.nku@gmail.com,
	git@vger.kernel.org
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 03:09:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX26H-0003HE-I9
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 03:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614Ab0GIBJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 21:09:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44897 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab0GIBJw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 21:09:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C77DC2F1F;
	Thu,  8 Jul 2010 21:09:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fwfYD6iaK1TbnXglilwwz7Oqsck=; b=NRYBwi
	7HnDsQUHlWOglJw6Hrm1feDH7zadEO9YVC2OWBKTuX+a8PhAn6rgYG7HgEExOObC
	+l0Oti1DZC2Sknbmva7B4DMY+65BrnGI4fde1scrN8lc1vH08Rg9+yu5tmYbzMMC
	8N5Q9u6VwK52fKqsF/Ry/snK3pGmoDBKJFDMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VQuCDZwJLmMNt0blNON9nGqcUAUAEUUb
	+5+iNMwADt9QvImmcvYPCKEM3aM9TgFwYmkZVBeb85gJ1GQNHPC8jZxZK1wQzi3z
	JZFnMk5E2lVw13NxYu9XngYxsBiuyh58hfh6s7lcQpx7BDMbhpc6R42PsQOaofbG
	4iPDBESO+3w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C3326C2F1E;
	Thu,  8 Jul 2010 21:09:47 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E483BC2F1C; Thu,  8 Jul
 2010 21:09:42 -0400 (EDT)
In-Reply-To: <AANLkTilSbmU5ejI5lWcN9GFQ544xd0zBtn-5s-nLzBAv@mail.gmail.com>
 (Nazri Ramliy's message of "Fri\, 9 Jul 2010 09\:04\:45 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AADE08B6-8AF6-11DF-8FA2-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150628>

Nazri Ramliy <ayiehere@gmail.com> writes:

> On Fri, Jul 9, 2010 at 8:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> reset at the end of line_prefix so it won't be effect anyway.
>
> s/effect/affected/  ?

Thanks for spotting.  I meant to say "won't be in effect".
