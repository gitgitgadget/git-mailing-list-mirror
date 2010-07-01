From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarify text filter merge conflict reduction docs
Date: Wed, 30 Jun 2010 20:33:08 -0700
Message-ID: <7vd3v7511n.fsf@alter.siamese.dyndns.org>
References: <20100628080234.GA7134@pvv.org>
 <0cd82ad22a6f240ebcde0c2f3a437a805dae5668.1277753114.git.eyvind.bernhardsen@gmail.com> <7vk4phbyl5.fsf@alter.siamese.dyndns.org> <BE5ECD39-0A80-410B-87C9-5C86F082773C@gmail.com> <7v4ogk76sb.fsf@alter.siamese.dyndns.org> <0CF2361E-D010-4042-B481-6918BE2A9341@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 05:33:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUAWs-0002Vl-I4
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 05:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245Ab0GADd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 23:33:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59355 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192Ab0GADd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 23:33:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 061E7C0DD9;
	Wed, 30 Jun 2010 23:33:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lEfhEizvDUNB6ZXVZmDIiDptAiw=; b=VnwJqL
	6jApmYFGOW3PWtecV1DMt4ARuwEP7mxiKUR0ro8ryKPQF9FGkZVzM0MQ3THvymEc
	FQUhQAraejhjhrD6p4vmOXJokEY5HLjgpV/hsV6cMAH6jqPXt/nXYx2qaIeBR27O
	52ruQW30eJAasYqI9FK9jeAFSbFbwm/JcPN0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wSNi29O25bQTrbS2c8mMju4wNxRsoxIn
	QjnBqlL4OzA1F5CqDKODRNnP4jvy8cViDCF7n5Cdn6mopX2tm6+n9Fy/sbrWs9JW
	sa5vVn4x5BuaDHRJEcU3vWPVf6ogOshVTtTPojfcIbf09psMMcXHSlKKgWXAmL4U
	r3+xVEXP9y8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 51EAAC0DD6;
	Wed, 30 Jun 2010 23:33:20 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CC96C0DD3; Wed, 30 Jun
 2010 23:33:15 -0400 (EDT)
In-Reply-To: <0CF2361E-D010-4042-B481-6918BE2A9341@gmail.com> (Eyvind
 Bernhardsen's message of "Wed\, 30 Jun 2010 23\:32\:49 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6509588A-84C1-11DF-88C1-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150006>

Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:

>> +	if (!core_ll_merge_double_convert)
>> +		return sha_eq(o_sha, a_sha);
>
> I would rather do this:
>
> 	if (sha_eq(o_sha, a_sha))
> 		return 1;
> 	if (!core_ll_merge_double_convert)
> 		return 0;

You are absolutely right.  This part of my patch was an unnecessary
pessimization.

Will fix.
