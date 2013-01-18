From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2013, #07; Thu, 17)
Date: Fri, 18 Jan 2013 08:58:43 -0800
Message-ID: <7v4niesa0s.fsf@alter.siamese.dyndns.org>
References: <7vsj5zs5y2.fsf@alter.siamese.dyndns.org>
 <50F96589.4010408@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jan 18 17:59:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwFHX-00026f-Ue
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 17:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487Ab3ARQ6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 11:58:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56953 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209Ab3ARQ6q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 11:58:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D761FBEC1;
	Fri, 18 Jan 2013 11:58:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CkIxKtsPqBqiEHyXsC3zDpCFoak=; b=lFtpkF
	I8Rlj7RlYSRFr9mHtsu/J7H67p2oXMCEAnGru13/T+1ZMEmGf7k5/4B8uVfnRHKM
	/hlrwk6u4RkXAjZNYTzyPp30fBOIODBtju3JYDJFh7LP2t5Ad30UUw7xSoRsbfBF
	hJ6k7j/87lKuKwmeTwchRQoUCO0RfV+p3CFLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pa/vwR3xCVgJ6SqdWPhbvk0DYTmiPyxt
	wOts2phDz14V8qn1QUQ43KN0TziYe9lp0aKH6H5TWzwG53DsCL3OKBoyZUwii35i
	M615Zr+VTPD3Of8ItZeT/FkQuO7wBUjoWADGPj65nCNRobZYBM0Ub5AECQ7e6c89
	QvGLG3nlN6E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC7E6BEBF;
	Fri, 18 Jan 2013 11:58:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32972BEBB; Fri, 18 Jan 2013
 11:58:45 -0500 (EST)
In-Reply-To: <50F96589.4010408@alum.mit.edu> (Michael Haggerty's message of
 "Fri, 18 Jan 2013 16:08:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51EC00BE-6190-11E2-952E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213917>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 01/18/2013 01:14 AM, Junio C Hamano wrote:
>> [...]
>> * mh/imap-send-shrinkage (2013-01-15) 14 commits
>>  - imap-send.c: simplify logic in lf_to_crlf()
>>  - imap-send.c: fold struct store into struct imap_store
>>  - imap-send.c: remove unused field imap_store::uidvalidity
>>  - imap-send.c: use struct imap_store instead of struct store
>>  - imap-send.c: remove unused field imap_store::trashnc
>>  - imap-send.c: remove namespace fields from struct imap
>>  - imap-send.c: remove struct imap argument to parse_imap_list_l()
>>  - imap-send.c: inline parse_imap_list() in parse_list()
>>  - imap-send.c: remove some unused fields from struct store
>>  - imap-send.c: remove struct message
>>  - imap-send.c: remove struct store_conf
>>  - iamp-send.c: remove unused struct imap_store_conf
>>  - imap-send.c: remove struct msg_data
>>  - imap-send.c: remove msg_data::flags, which was always zero
>> 
>>  Remove a lot of unused code from "git imap-send".
>> 
>>  With a further comment fixup in patch #6, this seems ready for
>>  'next'.
>>  Expecting a reroll.
>
> I'm confused.  It seems like you are referring to the comment
> improvement suggested by Jonathan Nieder...

It was an indication that I just forgot our previous exchange in
which I said "the remaining issues are so minor I can squash these
in".  Sorry about that.

Will merge to 'next'.

Thanks.
