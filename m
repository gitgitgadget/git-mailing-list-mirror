From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help.c: Pull cmd_version out of this file.
Date: Thu, 02 Sep 2010 09:31:44 -0700
Message-ID: <7vvd6o14zz.fsf@alter.siamese.dyndns.org>
References: <2ae543604216146b742253584d8393c5e3179697.1283114573.git.tfransosi@gmail.com>
 <20100830023812.GA4010@burratino> <20100830024020.GB4010@burratino>
 <AANLkTimDjRz=JmiVn+ybQ5ewaj=7N5tp48fUArD5vG_H@mail.gmail.com>
 <7v1v9e803a.fsf@alter.siamese.dyndns.org>
 <AANLkTinHJHzcoFFjv-TaQ+DYVyqn46fqA802m8Lq5anp@mail.gmail.com>
 <20100902043500.GF29713@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 02 18:32:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrChk-0006ow-JZ
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 18:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009Ab0IBQby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 12:31:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702Ab0IBQbx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 12:31:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D5E5D218B;
	Thu,  2 Sep 2010 12:31:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=soxWc+fH5nqLARhEC73zEOzVBCE=; b=GsThdP
	Jan8anT7lDyPfLPykGu03aqghxwTnIinEybas4XDDV88Z3bf4Y3H5B4Rs7Mn9kB5
	G/H/7pALW0PKA/O3CfPieGwvKWM/A/3QmIODFKSIlZtdKbDsLxNktzUSr/MfDO8x
	uLb/F9cqSzXtFefE1Py/nPh6pOCOpixZy2EZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qr2ZdBsuz0DLaH5uBkUvSbGbpB/Ub3UB
	RCdzFlcRu5r2MJR5EcWKILPxiGOAt41YffHhG9ZbOOr9rweF727gkt1aMYmCdFJ5
	EgGdA6Rd+ysmOWtYS4NZnEpKlBpi/0O8A8VLLrRElM//LGVlWdWCTOX4qKrUGk/d
	IuaJ/5mqqcg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 12073D2189;
	Thu,  2 Sep 2010 12:31:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 377A6D2188; Thu,  2 Sep
 2010 12:31:46 -0400 (EDT)
In-Reply-To: <20100902043500.GF29713@burratino> (Jonathan Nieder's message of
 "Wed\, 1 Sep 2010 23\:35\:00 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 963ABE7E-B6AF-11DF-B494-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155144>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thiago Farina wrote:
>
>> All patches should just fix real problems?
>
> Yes.

This answer while it is correct needs to be qualified ;-)

A bugfix for end-user facing part of the system is obviously a fix for a
"real problem", but clean-up without changing external behaviour to reduce
maintenance burden in the longer term also is fixing a real problem, i.e.
"the code, while it might be bug-free, is error prone and costs a lot to
maintain".
