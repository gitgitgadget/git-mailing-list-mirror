From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add MYMETA.json to perl/.gitignore
Date: Wed, 28 Dec 2011 22:58:57 -0800
Message-ID: <7vmxabyiby.fsf@alter.siamese.dyndns.org>
References: <1325133725-20671-1-git-send-email-jacknagel@gmail.com>
 <7vty4kx7ol.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jack Nagel <jacknagel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 29 07:59:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rg9xC-0004jB-CW
	for gcvg-git-2@lo.gmane.org; Thu, 29 Dec 2011 07:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442Ab1L2G7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Dec 2011 01:59:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40730 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857Ab1L2G7A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Dec 2011 01:59:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D4A42CFA;
	Thu, 29 Dec 2011 01:58:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lGfi2BVz6z96uUF2ui47r9XBixk=; b=omQbJv
	aKTY/kfnVeOlHSyTrij/49GxcMCHmjMrDW/e4rm22Gf2Jb3PmyRyEl2t2N/2u4dX
	HVRCR/Q93tA0BQtJrrmnYOK9G3XiTdk61tcrXxXPfAQvl3C5lyJ3SQE1EoUVPEBT
	AlbKWV1c1Ct7fpvs05NwmPbR/3lUVN798JLE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZVqLIiHYHdmOLlFRcXqyun3NrxtuS8oe
	qnqAu0v0BqfzDgA5nW+XWQi2n3N1pM4obMwskCDsMdqXGtoYfBl+P3wjugwMZtTL
	iygDjt4vUJdgLeJrrQMek8X1sr2A206GrHPxZXTJp2xqfKgkrj80OLE5Uoie++T2
	P7m9sNtoLdI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F3802CF9;
	Thu, 29 Dec 2011 01:58:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1F562CF4; Thu, 29 Dec 2011
 01:58:58 -0500 (EST)
In-Reply-To: <7vty4kx7ol.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 28 Dec 2011 21:34:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94F1CE2E-31EA-11E1-9AE3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187775>

Junio C Hamano <gitster@pobox.com> writes:

> Jack Nagel <jacknagel@gmail.com> writes:
>
>> ExtUtils::MakeMaker generates MYMETA.json in addition to MYMETA.yml
>> since version 6.57_07. As it suggests, it is just meta information about
>
> Are we better off ignoring MYMETA.* instead, so that we won't get affected
> when they start dropping new cruft with the same information in yet more
> different formats?

Just to make sure there is no misunderstanding. The above is _not_ a
rhetorical question that implies that I _think_ the patch should instead
change the existing "MYMETA.yml" to "MYMETA.*" without adding a new entry
to ignore "MYMETA.json". It is a pure question, and a valid answer could
be "I checked with Perl people and they promise they won't be adding any
more MYMETA.foo left and right with new MakeMaker releases", in which case
the original patch is absolutely the right thing to do.

I am simply asking because I do not know.

>
>> the build and is cleaned up with 'make clean', so it should be ignored.
>>
>> Signed-off-by: Jack Nagel <jacknagel@gmail.com>
>> ---
>>  perl/.gitignore |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/perl/.gitignore b/perl/.gitignore
>> index 9235e73..d5c6e22 100644
>> --- a/perl/.gitignore
>> +++ b/perl/.gitignore
>> @@ -1,5 +1,6 @@
>>  perl.mak
>>  perl.mak.old
>> +MYMETA.json
>>  MYMETA.yml
>>  blib
>>  blibdirs
