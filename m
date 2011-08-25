From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] branch: allow pattern arguments
Date: Thu, 25 Aug 2011 11:32:11 -0700
Message-ID: <7vliuhl4us.fsf@alter.siamese.dyndns.org>
References: <cover.1314259226.git.git@drmicha.warpmail.net>
 <00847b8ee77129433a5d908ad25c9ebaf7fa7130.1314259226.git.git@drmicha.warpmail.net> <20110825175405.GD519@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Michael Schubert <mschub@elegosoft.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 25 20:32:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qweix-0004tq-Vo
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 20:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213Ab1HYScO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 14:32:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42370 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755128Ab1HYScN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 14:32:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9173F4BB9;
	Thu, 25 Aug 2011 14:32:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZYwww+vUwY69S3m66SLpA9lJLM4=; b=apVUkK
	KKw9YSqczplhluTBmayXNWsmOhGlinbf6mMZER3hm1FRsiVwkyDqN8mTfIXOIJrh
	a5ALlGYaSBOwVUCEuwZDydprFfCVkf2DBgwNRHnxfHWRY4CBQnQrPjyv0Lz8f8j0
	q28XBq42O0xr2CwwzSYzvky5y0JguY4fmua34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DooN5qwjVOgc89AyLEkNOA5sgDhQZk//
	+rlci9z9cG/wi7QlaTwUHFl8MNsTas3YSGMgQbzNgKL2kpPeODkBoPQ2kMHQBfiW
	FRY5eZSWkftDIBZK7rIixcRxLNXnCdebY1sUN0KKq2nCDwHKxAFto7D7uLaeBGKT
	BiRibBLsd2M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88B874BB8;
	Thu, 25 Aug 2011 14:32:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 070A04BB7; Thu, 25 Aug 2011
 14:32:12 -0400 (EDT)
In-Reply-To: <20110825175405.GD519@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 25 Aug 2011 13:54:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8CF23254-CF48-11E0-A2B0-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180097>

Jeff King <peff@peff.net> writes:

> On Thu, Aug 25, 2011 at 10:30:17AM +0200, Michael J Gruber wrote:
>
>> -	else if (argc == 0)
>> -		return print_ref_list(kinds, detached, verbose, abbrev, with_commit);
>> +	else if (argc == 0 || (verbose && argc == 1))
>> +		return print_ref_list(kinds, detached, verbose, abbrev, with_commit, argc ? argv[0] : NULL);
>
> Note that "git tag -l" takes multiple patterns these days (it used to
> silently ignore everything after the first one!). "git branch" should
> probably do the same.

Agreed.
