From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [cosmetic bug?] needlessly(?) executable files
Date: Mon, 23 Feb 2015 10:55:57 -0800
Message-ID: <xmqqoaoktq2q.fsf@gitster.dls.corp.google.com>
References: <1424540917.15539.24.camel@scientia.net>
	<xmqqr3thwzur.fsf@gitster.dls.corp.google.com>
	<1424679663.30155.30.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christoph Anton Mitterer <calestyo@scientia.net>,
	git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 19:56:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPyBb-0005f8-KF
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 19:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbbBWS4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 13:56:51 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752424AbbBWS4u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 13:56:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BC443AEFE;
	Mon, 23 Feb 2015 13:56:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eiqAqP99MQaagowWtI7kW96XT5g=; b=Evqqqt
	a8w5Fjl6kuwaxUYN5X7hGuhAjal4f3WRrkFGKRcdHqYkt9YjExeJLA19P9OoMUTT
	JenymQL7bNaAUYOiQPF1HVveZ8FGMBF+wVcyTYz4sdojVClzbWVZ2hlC6PI76YPS
	xyxiMI9/FUAeDzY/Qxm3IpXg/ZVSSBWrlQD38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yp+bkMISnq196x9DYOOeh1daZppOklRe
	1kpLMQqJehIPX0DMP7pP3KmFMnqu6bTWxDvPzEyIll0M1/zaNPEC/tVrk+a2m2NY
	1+/SP7hxEqAijcVuByUZtyUmxQlCYcSJDiBpeO2nVkcGC4ZN7lOF/Ii85GyrBgfr
	uxfC2UzbuCk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 81A093AEFD;
	Mon, 23 Feb 2015 13:56:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 391533AED4;
	Mon, 23 Feb 2015 13:55:59 -0500 (EST)
In-Reply-To: <1424679663.30155.30.camel@kaarsemaker.net> (Dennis Kaarsemaker's
	message of "Mon, 23 Feb 2015 09:21:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9AF44C5E-BB8D-11E4-A6BA-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264284>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> On zo, 2015-02-22 at 10:44 -0800, Junio C Hamano wrote:
>> Christoph Anton Mitterer <calestyo@scientia.net> writes:
>> 
>> > Just a question about files like:
>> > .git/config
>> > .git/hooks/*.sample
>> >
>> > Is there any reason that these are created executable? Especially
>> the
>> > config file?
>> 
>> In a new repository I just did "git init", I see this:
>> 
>>     $ rm -fr stupid
>>     $ umask 0027
>>     $ git init stupid
>>     $ ls -l stupid/.git/config | sed -e 's/ .*//'
>>     -rw-r-----
>> 
>> So no, config is not created executable.
>
> It used to be for a brief period in history, between daa22c6f8d (2.1.0)
> and 1f32ecf (2.2.2).

Ahh, yes, I think we fixed that bug not too long ago.

Thanks for reminding me.
