From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Git segmentation faults if submodule path is empty.
Date: Mon, 19 Aug 2013 13:54:35 -0700
Message-ID: <xmqq1u5p8kqc.fsf@gitster.dls.corp.google.com>
References: <277BEB82-D618-48D9-A276-4B0E76A11A38@eyesopen.com>
	<520DCB4B.6090309@web.de>
	<20130816130957.GB20138@sigill.intra.peff.net>
	<20130816131406.GC20138@sigill.intra.peff.net>
	<AFCBD71A-21CB-45CC-8386-C65173B6D173@eyesopen.com>
	<0C422E09-EE33-4C3F-91D3-F6007F743A38@eyesopen.com>
	<20130816205246.GA6487@sigill.intra.peff.net>
	<B692A7F2-C5C2-4B5A-8FFC-6CF5C9DB72D8@eyesopen.com>
	<7vzjsdldbi.fsf@alter.siamese.dyndns.org>
	<30EC6002-1044-41E0-8700-1F210A6CA882@eyesopen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jharrod LaFon <jlafon@eyesopen.com>
X-From: git-owner@vger.kernel.org Mon Aug 19 22:54:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBWTL-0006xK-KO
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 22:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201Ab3HSUyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 16:54:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42763 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167Ab3HSUyj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 16:54:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CD553A336;
	Mon, 19 Aug 2013 20:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I1hYSMEAwx4FqLGAZh7LuIbQpU8=; b=jubwIu
	t+bE3779sdgCqNG+9An9qtuQIUk2rnaIePKmtTU4ZcVldM3FBi3IMe5LoXhpuNVj
	dQoX9blcXb0xX4BsPSsMA5NhMo2wVuNbE47VJRuY6UliwE2N2l4Zu/hsNGXBSxvz
	fUXhkV5ltBcnGtznBlHnYmQcNF9nHv12/BL+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M8mYRGQzMVThWFeuZkBvIDqaaz7+YEMs
	JPeAGdhgRutx4oINlKPKvBwwJ/JoyLQNJTX4W1PY/TjU3UkTLe8PGcocoP6E1IpF
	tryBmEdpSzr8d4vY34gZOLI1y46kxFdY9I01DtU41TYyWd0GBqmH6CPlFzZHLvBR
	If99gp5A78g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A06E3A335;
	Mon, 19 Aug 2013 20:54:38 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99ED03A333;
	Mon, 19 Aug 2013 20:54:37 +0000 (UTC)
In-Reply-To: <30EC6002-1044-41E0-8700-1F210A6CA882@eyesopen.com> (Jharrod
	LaFon's message of "Mon, 19 Aug 2013 12:45:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8F698FDC-0911-11E3-AC5F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232566>

Jharrod LaFon <jlafon@eyesopen.com> writes:

> I will keep trying this until it's perfect, and I thank you for
> the help.  When I resubmit this, would you like me to include your
> sign-off line as well?

If the one I attached at the end of the message you are responding
to looks fine to you, I'd just apply it without having you to
reroll.

> Also, the end of the test script was not included in your message.  

Sorry, but I am not sure what you meant by this.

I reworked your example to make it the second test in an existing
test script.  There are many existing tests after that so it is
natural that we wouldn't see the end of the file in the patch
context.

>> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
>> index 5ee97b0..a39d074 100755
>> --- a/t/t7400-submodule-basic.sh
>> +++ b/t/t7400-submodule-basic.sh
>> @@ -18,6 +18,16 @@ test_expect_success 'setup - initial commit' '
>> 	git branch initial
>> '
>> 
>> +test_expect_success 'configuration parsing' '
>> +	test_when_finished "rm -f .gitmodules" &&
>> +	cat >.gitmodules <<-\EOF &&
>> +	[submodule "s"]
>> +		path
>> +		ignore
>> +	EOF
>> +	test_must_fail git status
>> +'
>> +
>> test_expect_success 'setup - repository in init subdirectory' '
>> 	mkdir init &&
>> 	(
