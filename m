From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] builtin/push.c: make push_default a static variable
Date: Wed, 18 Feb 2015 11:50:20 -0800
Message-ID: <xmqq4mqj2e4j.fsf@gitster.dls.corp.google.com>
References: <20150216054550.GA24611@peff.net>
	<20150216054754.GB25088@peff.net> <20150217104628.GA25978@peff.net>
	<xmqqsie4300s.fsf@gitster.dls.corp.google.com>
	<20150217182324.GA12816@peff.net>
	<xmqqzj8cyyip.fsf@gitster.dls.corp.google.com>
	<20150218185007.GA7257@peff.net>
	<xmqqh9uj2g25.fsf@gitster.dls.corp.google.com>
	<20150218192518.GA7891@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dave Olszewski <cxreg@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 18 20:50:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOAdh-0000kF-5p
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 20:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443AbbBRTuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 14:50:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752524AbbBRTuY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 14:50:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F72638FF2;
	Wed, 18 Feb 2015 14:50:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qdoOXmzMcrP44QAaamJgZ2UOkgo=; b=jiq1we
	7lUceinl3c+1JW0Uz31pjFxndYqOroe1DQD2EGv/GLObTkhoRJWJ3eAtDk8E74OA
	9rUAmB13yewye2NFi/+9a/XDtPpPfGdA2Othy4obPOa0L6pNX3M5LBJaw4SZjZXY
	zlK2/N9bztRJ5z6oRaKd9QPqiyA4jNx68vvIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MrlhIMISllTiZIJA/wbF1VUNiab13doc
	OUSftU8d422JsoFVwzCy1sQeUSXJArXBswwMPwRH/3ILVawVoBcVik7PaBBl13BU
	v80LbQO2pbPkhyiM7Lp9s3LdPhG/x40ZSslYxpz2H0OZn2iu3GqL+GSO59z4b4JY
	POA6iIn/V2I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0649E38FF1;
	Wed, 18 Feb 2015 14:50:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D64C038FEB;
	Wed, 18 Feb 2015 14:50:22 -0500 (EST)
In-Reply-To: <20150218192518.GA7891@peff.net> (Jeff King's message of "Wed, 18
	Feb 2015 14:25:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 602BE120-B7A7-11E4-B032-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264060>

Jeff King <peff@peff.net> writes:

> On Wed, Feb 18, 2015 at 11:08:34AM -0800, Junio C Hamano wrote:
> ...
>> Not very strongly either way.  Seeing the above does not bother me
>> too much, but I do not know how I would feel when I start seeing
>> 
>> 	val = git_config_book(k, v);
>> 	flip_bool(val, &flags, TRANSPORT_PUSH_FOLLOW_TAGS);
>> 
>> often.  Not having to make sure that the bit constant whose name
>> tends to get long is not misspelled is certainly a plus.
>
> I think it would be even nicer as:
>
>   git_config_bits(k, v, &flags, TRANSPORT_PUSH_FOLLOW_TAGS);

Maybe.  I do not feel very strongly either way.
