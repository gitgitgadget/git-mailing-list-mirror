From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix expected values of setup tests on Windows
Date: Sat, 01 Jan 2011 17:31:58 -0800
Message-ID: <7v62u8hz01.fsf@alter.siamese.dyndns.org>
References: <201012302205.13728.j6t@kdbg.org>
 <201012311711.06989.j6t@kdbg.org> <20101231203019.GC5898@burratino>
 <201012312321.31294.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jan 02 02:32:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZCoc-0005wz-GS
	for gcvg-git-2@lo.gmane.org; Sun, 02 Jan 2011 02:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408Ab1ABBcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jan 2011 20:32:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64236 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753Ab1ABBcM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jan 2011 20:32:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6E14125BA;
	Sat,  1 Jan 2011 20:32:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dsr7OX1O5CGzJrfzrYTa2y8aWKI=; b=IrCawk
	n+nq1z2ut0P1yvEimKsDgMk7M8dcCMh/J2rXmt8gDg1RkudcWKUjaU5df1DOKNgh
	f2lduFbd4dXoMtfSfbE9/S6Laub9eFLdZapryUiaeh0ofXjGtzC+1Ee8ExQoqkzA
	dj+jl9zQdNaBX2l+PjFcndlv6DtE2UB0rU8hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M77aLRcugR1jerVMipcC5fa4XIVdFezy
	eDkcewV0X7nCkMvE5nmCnVU3S0Or8G8ZpPWXlM3kyR09rCsQX8YOESHexAbo2tRp
	WrW8U4hU2OfHRTijsLWNPKu//IMuFd2s1pN4rHUTswim5QmVFsPufeh7jmawDS+9
	RTzaw8/UCuQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2F11325B7;
	Sat,  1 Jan 2011 20:32:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E351725B6; Sat,  1 Jan 2011
 20:32:35 -0500 (EST)
In-Reply-To: <201012312321.31294.j6t@kdbg.org> (Johannes Sixt's message of
 "Fri\, 31 Dec 2010 23\:21\:31 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3095F3A2-1610-11E0-BE54-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164406>

Johannes Sixt <j6t@kdbg.org> writes:

> On Freitag, 31. Dezember 2010, Jonathan Nieder wrote:
>> Johannes Sixt wrote:
>> > On Freitag, 31. Dezember 2010, Nguyen Thai Ngoc Duy wrote:
>> >> in your patch does not. Does bash auto convert value in
>> >> TRASH_DIRECTORY="$TE..." line?
>> >
>> > No. When this line is executed:
>> >
>> > TEST_DIRECTORY=$(pwd)
>> >
>> > $(pwd) still has its default behavior to return the POSIX style path. pwd
>> > is redefined to pwd -W only later.
>>
>> Would it make sense to change it to
>>
>>  TEST_DIRECTORY=$PWD
>>
>> for clarity and robustness against code movement, then?
>
> Yes, that would make sense.

It will be very much appreciated to add a few sentences to clarify this to
"Do's and don'ts" section of t/README if you are re-rolling this.  Thanks.
