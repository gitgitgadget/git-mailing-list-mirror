From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Thu, 22 Mar 2012 13:33:33 -0700
Message-ID: <7vobrowf36.fsf@alter.siamese.dyndns.org>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
 <4F6ACB67.1080503@viscovery.net> <4F6B0C3E.8090501@in.waw.pl>
 <20120322141245.GB8803@sigill.intra.peff.net>
 <7vbonozi8c.fsf@alter.siamese.dyndns.org>
 <20120322173701.GA11928@sigill.intra.peff.net>
 <7viphwxyp1.fsf@alter.siamese.dyndns.org>
 <20120322190705.GB27037@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejew?= =?utf-8?Q?ski-Szmek?= 
	<zbyszek@in.waw.pl>, Johannes Sixt <j.sixt@viscovery.net>,
	"Peter J. Weisberg" <pj@irregularexpressions.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 21:33:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAoha-0005Cc-Cw
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 21:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759717Ab2CVUdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 16:33:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52906 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755054Ab2CVUdg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 16:33:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8C517D5C;
	Thu, 22 Mar 2012 16:33:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Sy0CiEvODELdZUY/y3/EWn4TJbU=; b=VnmWGX
	Hv1hg2w0yF3OhA4e5l5TWNEi1g8cmbvUhTJlzM6LoJrzW5YeWYnaLW491Xprw+qi
	BHdtaLZJWoxKJLEGPxyxnZNe39N0yZGChjwpBbixiFqvJXIRuH0XCEg/9PivvIv1
	TNwzoRvKOpiZl5gfcfdKKq/E1ioTD3S/uLBl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=La65yHU7jOzZYZewSxuwHgslf9lwRhg5
	w8QQvfRXJKUb8IVfHD7+vGTPBx/KHouylj6YMinjeX4zbbSOi8mCvhAAbqqXM+jj
	PPLyoEL2yNeCHRF9WDyLDH7+jahLhDMqJiDIrmEj79TGFKnsG1ywJxC31BwdtPQo
	54PW4iS0f08=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FA007D5B;
	Thu, 22 Mar 2012 16:33:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 317007D59; Thu, 22 Mar 2012
 16:33:35 -0400 (EDT)
In-Reply-To: <20120322190705.GB27037@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 22 Mar 2012 15:07:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4C35870A-745E-11E1-9FE9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193712>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 22, 2012 at 11:44:42AM -0700, Junio C Hamano wrote:
>
>> I wanted it to tell *what* happens when core.ignorecase is set.  In other
>> words, I wanted the description to say that the logic employed is to work
>> around what case-insensitive filesystems do.  Case sensitive filesystems
>> obviously do not do what case-insensitive ones do (like reporting a
>> "Makefile" exists when only "makefile" exists), so I hoped that it was
>> clear enough that the additional logic would not be suitable there.
>
> Ah. I see now why you made the change you did. But if I missed it,
> perhaps it was too subtle (of course, I found the other one perfectly
> adequate, so...).
>
>> I guess we really need to make the description foolproof then.
>> 
>>                    ... exists on them is "makefile". By setting this
>> 	variable to `true`, Git employs logic to work around them.
>>         Setting this to `true` on a case insensitive filesystem does
>> 	not make any sense, because it would not magically make your
>> 	system to treat your filesystem case insensitively.
>
> I'm OK with that (modulo s/insensitive/sensitive/ on the third line).
> It may be overly explicit, but I would rather err on that side.

Thanks for catching the typo.
