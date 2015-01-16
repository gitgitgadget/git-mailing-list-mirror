From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: reword --author error message
Date: Fri, 16 Jan 2015 09:29:15 -0800
Message-ID: <xmqqwq4m3a8k.fsf@gitster.dls.corp.google.com>
References: <54B7CCCD.1070708@drmicha.warpmail.net>
	<84cf10a22858275d6e213311c93df7f6a5408f60.1421331608.git.git@drmicha.warpmail.net>
	<xmqq4mrs7x5h.fsf@gitster.dls.corp.google.com>
	<20150116093220.GA3006@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Gunnar Wagner <gunnar.wagner@irisgermanica.com>
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 18:29:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCAi2-0003w4-9A
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 18:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611AbbAPR3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 12:29:18 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53617 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752560AbbAPR3R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 12:29:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C1C7D2F322;
	Fri, 16 Jan 2015 12:29:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7D9clu2y9wnXbT9+QUPR6T9uwj4=; b=bjvo0g
	hTXgieOXIT5xLzpp2/ekVs3BX3dXx+KukHJOEx1j/Mi+92IimMBpUFD6pnNomnrS
	QWSh2aOALlngFy+c/WPjMvQvGlIily6WXVkiSGwxd8mSWUbjasABFPIQgGLeuwpX
	48iAXqexBOAchg7uLMrYKw0/gGJwdmHqLlBdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qy2OD9HRudUZxSIDRgAXXJiAaqSCuJGY
	RMYy2PIxFDsMPpodOw7KQWoi1vDE5yal+ed67dSTREN4RUbsKe3qNsls62oqqfjr
	d9cS7yreUHENRR/IY0yru4SNBUSDBX61EWvJQdJVdRUq+P8BnqxmoTZYNVBV2xWC
	ZUe9ZlnqnWg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B7F142F321;
	Fri, 16 Jan 2015 12:29:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 405CD2F31F;
	Fri, 16 Jan 2015 12:29:16 -0500 (EST)
In-Reply-To: <20150116093220.GA3006@peff.net> (Jeff King's message of "Fri, 16
	Jan 2015 04:32:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 320B5422-9DA5-11E4-99B7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262553>

Jeff King <peff@peff.net> writes:

> On Thu, Jan 15, 2015 at 09:48:26AM -0800, Junio C Hamano wrote:
>
>> > Rename the error message to make it clearer that the failure has two
>> > reasons in this case:
>> > "Bad --author parameter '%s': neither completely wellformed nor part of
>> > an existing one"
>> 
>> You are trying to help a user who thought "Who www.where.com" was a
>> valid thing to pass to --author; "it is not completely wellformed"
>> is not very helpful without making her realize what in that bogus
>> string is not "completely well-formed".
>> 
>> Perhaps
>> 
>>   "--author '%s' is not 'Name <email>' and no existing author matches that string"
>> 
>> or somesuch?
>
> Yeah, I think that is OK. It is kind of clunky to read, but it contains
> all of the necessary information to lead the user in the right
> direction.

Indeed it is clunky and not in the usual format.

This might be better, perhaps?

    die(_("--author '%s': not 'Name <email>' and matches no existing author"));
