From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix portability issues with $ in double quotes
Date: Wed, 27 Jan 2010 11:16:00 -0800
Message-ID: <7v636nqryn.fsf@alter.siamese.dyndns.org>
References: <1264547311-25251-1-git-send-email-bebarino@gmail.com>
 <4B5FF106.3070604@viscovery.net> <4B608A3C.7090106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 20:18:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaDND-0007h7-Bh
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 20:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560Ab0A0TQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 14:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107Ab0A0TQL
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 14:16:11 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab0A0TQK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 14:16:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B53A94103;
	Wed, 27 Jan 2010 14:16:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jxeGxutEYx+JG5OL5m3YFKKEC4A=; b=Y5mxyC
	6fCOHBGngQ47NgBei45sr7dRSv/2aZjzJgZpmjpDLcWPJ0RKxKVC3uSsEQvm63bD
	e2mH+8pwIFqsFIgnyOtq4ut+tCZ+9aqAs8HiBkzkYQUmRouJ4Bdt34PgEzR98igZ
	AdjSQ4RQ4shQbjrn39oHEJT+8cSsd579c4Sxc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O8qFPSncKvTCLIkcOjIkIR3X0fmHrZv1
	mA/34qK91UgGwMwTelrDLn1/2VrlEQaT2MHjjt+wiVumAKLeP5NkQUeFz7U2UWOJ
	Ex+oP2zDMyK/dJ+3qdla2jD744UG+DZa2Ejq1YtGpqzYA47Qw22jSGtJkv3BOfcV
	n74aGM6dsKI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DF2C3940F7;
	Wed, 27 Jan 2010 14:16:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 15634940EC; Wed, 27 Jan
 2010 14:16:01 -0500 (EST)
In-Reply-To: <4B608A3C.7090106@gmail.com> (Stephen Boyd's message of "Wed\,
 27 Jan 2010 10\:47\:24 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6B50E5C2-0B78-11DF-B5DB-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138188>

Stephen Boyd <bebarino@gmail.com> writes:

> On 01/26/2010 11:53 PM, Johannes Sixt wrote:
>> The instances you changed look good. I didn't check whether you missed
>> some. Was this some sort of mechanical change?
>
> Not really mechanical. I just grepped for sed and grep expressions and
> then went through the results by hand looking for unescaped dollar
> signs.

Thanks; with this (and my earlier rant on bash refusing to redirect with
'cmd <$variable' when $variable has $IFS character and is not quoted), the
result seem to make my OpenBSD build pass all the tests ;-)
