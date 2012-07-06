From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Document rev^! and rev^@ as revision specifiers
Date: Fri, 06 Jul 2012 12:18:13 -0700
Message-ID: <7vliiwog0a.fsf@alter.siamese.dyndns.org>
References: <7vpq8aqdzb.fsf@alter.siamese.dyndns.org>
 <1341532890-13829-1-git-send-email-max@quendi.de>
 <1341532890-13829-2-git-send-email-max@quendi.de>
 <7vtxxlnyn1.fsf@alter.siamese.dyndns.org>
 <D8DF0AED-91D3-45C0-B49E-97E07D21350C@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Fri Jul 06 21:18:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnE2p-0007LA-Ud
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 21:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757924Ab2GFTSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 15:18:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59023 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755814Ab2GFTSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 15:18:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB2E98A04;
	Fri,  6 Jul 2012 15:18:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4rAIu/HdH+Jv/PuZWcp02NrisFc=; b=VPbrXc
	57gD32fUoBzdS6oO1Y5cj60mBjWvaxPjHsDHOQLXssXChXMnpZ98tvvyJgfV1rVN
	7lGMyPTdZBGvKuxhmrR3pkgc0+wiuqOPEAG/wo7C4v5AGTK3Od62N5oOTvz4JsiP
	Rt2EWxjiCBVs7XGZEEuwr90rHo3cTZliraKCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DsKJaKxktufzNOnxqmKUe1Wt+eoEU6j8
	MhgVINGBkHT6AB0Y5u8Y/6N+dBepEoxt5IHs8EFXDs47pxdH42jkZp07CgHHIHNU
	iM+eSWP672XOGMIDYIO0gwXzYvzDoe9iF47PoyfFiiFOuOrvbXDgLT1qN0z1TGnA
	RdVx3BMt010=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D07AA8A03;
	Fri,  6 Jul 2012 15:18:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 610498A01; Fri,  6 Jul 2012
 15:18:15 -0400 (EDT)
In-Reply-To: <D8DF0AED-91D3-45C0-B49E-97E07D21350C@quendi.de> (Max Horn's
 message of "Fri, 6 Jul 2012 11:00:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 55FB18B0-C79F-11E1-8649-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201138>

Max Horn <max@quendi.de> writes:

>>> +'<rev>{caret}!', e.g. 'HEAD{caret}!'::
>>> +  A suffix '{caret}' followed by an exclamation mark
>>> +  means commit '<rev>' but forces all of its parents to be excluded. For
>>> +  commands that deal with a single revision, this is the same as '<rev>".
>> 
>> Is this sentence correct?  "git commit -C 'HEAD^!'" might be a
>> command that expects a single revision, but I do not think it is the
>> same as "git commit -C HEAD".
>
> Ignoring the exact words I used for the moment, what I meant is that these two commands should be functionally equivalent. Aren't they?

No.  When a single commit is wanted HEAD^! shouldn't be used, and
they cannot be functionally equivalent.  I haven't tried but I think
"commit -C HEAD^!"  would give you a syntax error.
