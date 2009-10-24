From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git checkout --nodwim
Date: Fri, 23 Oct 2009 23:35:54 -0700
Message-ID: <7vzl7h8fjp.fsf@alter.siamese.dyndns.org>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
 <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
 <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org>
 <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com>
 <7v7huspjg0.fsf@alter.siamese.dyndns.org>
 <32541b130910211029x2f4295c3w40dd13b3cdc7762c@mail.gmail.com>
 <20091022062145.6117@nanako3.lavabit.com>
 <alpine.DEB.1.00.0910220226270.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Jay Soffian <jaysoffian@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 24 08:36:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1aEj-00084u-PA
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 08:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbZJXGgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 02:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbZJXGgH
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 02:36:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47241 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbZJXGgH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 02:36:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E81D65FE0;
	Sat, 24 Oct 2009 02:36:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cXkhQKiy5D1ppqyCU7LtievFGG0=; b=I6jwSm
	czpL8kU/FgB79DxVs52KUfuOvi3jWPSG2Z4ZDJ4QVAV2mvrsXvAsn/jQIgCTF4zm
	MSUPFxayNFBvDqMkBx7bIcpq5RJMGRkvC06jU9kxq5w7L+9wbXUXhBQq/B2YUL72
	yIhpXLi0CyhBFKyANMq7DPuzPtc9SK21/VP/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B8zxzQvAf0Gqh8aMASK+nS3IpNiy2E/Y
	oKSQGJjbRt6Hm0o9m/jSujlR10I+K2ZD1GhEf05p+0AZ7/yxU/1BvWp7bsdo1xcM
	xSD07IPLdPdEKfFfZCJAI0prGNrP9NkCdampOQpFZ5eVGmSfX3V2u4UG4ZF8kCV/
	y2Rp8/H+spY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 04E5C65FDB;
	Sat, 24 Oct 2009 02:36:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00E6965FDA; Sat, 24 Oct
 2009 02:35:55 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0910220226270.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Thu\, 22 Oct 2009 02\:27\:30 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 809D502A-C067-11DE-A16F-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131143>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 22 Oct 2009, Nanako Shiraishi wrote:
>
>> Quoting Avery Pennarun <apenwarr@gmail.com>
>> 
>> > On Sun, Oct 18, 2009 at 3:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> >> Helping hands in polishing it up is very welcome.
>> >
>> > I find the idea of an option for "don't do what I mean" to be pretty
>> > entertaining.  Or maybe just misleading :)
>> >
>> > Have fun,
>> >
>> > Avery
>> 
>> As Junio asked for helping hands, let's try to be helpful and constructive.
>> 
>> Maybe "don't second-guess" explains it better?
>
> My take on it:
>
> 1) --no-porcelain
>
> 2) we all are bike-shedding, not being constructive at all

You are right about (2), regarding the option name. I've queued one that
uses --no-guess.

Regarding the correct use of parse_options(), I had to figure it out
myself, and helping hand would have, eh, helped me.
