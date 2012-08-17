From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug: "fatal: cannot pread pack file", version 1.7.5.4
Date: Thu, 16 Aug 2012 20:02:27 -0700
Message-ID: <7vfw7mxlto.fsf@alter.siamese.dyndns.org>
References: <5638dec6e156f83385a3baa01cf9ac4d@localhost>
 <20120702215736.GA5790@sigill.intra.peff.net> <m2vci5n5r5.fsf@igel.home>
 <20120703032345.GA7143@sigill.intra.peff.net>
 <CACsJy8AmCo82YxHA_6+rkbuJOjOG-HqCgjoP2tz753SXH5w8_Q@mail.gmail.com>
 <20120703051426.GA12965@sigill.intra.peff.net>
 <7vvcgizesm.fsf@alter.siamese.dyndns.org>
 <fd74d7233b4b29fe06afad23fb87552a@localhost>
 <7v4no2zbd9.fsf@alter.siamese.dyndns.org>
 <20120817014526.GA447@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Winterfeld <lars.winterfeld@tu-ilmenau.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 17 05:02:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2Cpa-0000z2-8n
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 05:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030540Ab2HQDCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 23:02:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49578 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964812Ab2HQDCa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 23:02:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 743729C5D;
	Thu, 16 Aug 2012 23:02:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e61IkOBIwgA2ambaa5ETu8YfRk8=; b=YGr/22
	c8zuO9FKQlOzM16NcsDe5oksUs6GxKpVMd1gkwWwMZ6s5qW//lOcKNZfUjtoL9qV
	+fIrwfE5W535TWhbMhWNHHSEAJvRljLXwkxiSNIevf91GUQBWcL2Zjs8tN9RN+6s
	n32XGOlP+Pipcqemxd/FoQkl8Ddab16kunnZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YAfT8XgDH6tPScXiFiLrGK9r7v/4ReGF
	I8hvQMEAUyL3ZjyegatF86Hb5jXoZuxIWOwHOrojWNdGlsbzgpwJQoF5Csq5Gu+6
	yEeOkUrTN5vpiLhXJLEsrAHsJnk7HKX6f4ZP4yBbnDJqiVnRSn0uEyumBsn1sfDS
	vN2iplrS8sI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61AB69C5C;
	Thu, 16 Aug 2012 23:02:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C14C39C5B; Thu, 16 Aug 2012
 23:02:28 -0400 (EDT)
In-Reply-To: <20120817014526.GA447@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 16 Aug 2012 18:45:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FAD56D8E-E817-11E1-B883-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Aug 16, 2012 at 04:05:22PM -0700, Junio C Hamano wrote:
>
>> Lars Winterfeld <lars.winterfeld@tu-ilmenau.de> writes:
>> 
>> >> Hrm, has this ever been resolved?
>> >
>> > Thank you for asking.
>> > My local git version is 1.7.5.4, the server version that I actually
>> > ended up pushing the files to was however still some 1.6.x.
>> > So it was a false alarm. Sorry about that.
>> 
>> Not really.  Pushing or fetching by a new version of Git against old
>> version of Git *should* work; otherwise it is a bug.
>
> Yes, but there may be old bugs in the server version that have since
> been fixed. For example, the bug fixed by 838cd346 might be the cause of
> this (that fix went into 1.6.0.3).

Yeah, Lars said 1.6.x above, but in the response it turns out the
version used is 1.6.0.2, so lack of that commit is a very likely
reason.

Thanks.
