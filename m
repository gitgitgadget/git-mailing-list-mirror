From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Deprecation warnings under XCode
Date: Mon, 01 Dec 2014 10:04:57 -0800
Message-ID: <xmqqoarnp7p2.fsf@gitster.dls.corp.google.com>
References: <CAO2U3Qg4DVxSk2u1eJwGqYoxVZTbWRV69J9HTo1rnjFCxSyi2g@mail.gmail.com>
	<547BFD42.3040104@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>,
	David Aguilar <davvid@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 01 19:05:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvVLP-0000Q5-C5
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 19:05:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbaLASFC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Dec 2014 13:05:02 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753103AbaLASFA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Dec 2014 13:05:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A0772213B2;
	Mon,  1 Dec 2014 13:04:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7DIoQpGnmMIw
	p58+1uDHub9r1n4=; b=tG2zyC+Jj4h6m+P0e/TbZYqrU9kt/D/s5JsoTQlU/y2o
	jePhJcY3HC7uzr2kybuwPfzKRJv/LaK46sKRbOi9KVmuxzgAUNIasr1VAA3nlEdU
	D0Eg7Kz14W8rrwEqGt4Ni+s6f32/TPEXtqDQOQmi//nN2Q2vbdGxXutcvV7KDAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kBEylw
	FTXCIhyEm7LAwOLSzHkJtu+sTd1sZPHauK4fVGd5juUnahLqkY3C1hRt51dnDXoR
	hqsPhtbrbLYYRL3+OyUUHsk50KfY+ytsIuZ1AcAf63jdRGb/bUHMMFINZf+I3Mw5
	NusRavnCOxIYoT3sWGYOfTS6KWH4gGM/U+sGU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F46A213B1;
	Mon,  1 Dec 2014 13:04:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 19CB9213B0;
	Mon,  1 Dec 2014 13:04:59 -0500 (EST)
In-Reply-To: <547BFD42.3040104@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Mon, 01 Dec 2014 06:31:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9046FE14-7984-11E4-81E7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260502>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 12/01/2014 04:02 AM, Michael Blume wrote:
>> I have no idea whether this should concern anyone, but my mac build =
of git shows
>>
>>      CC imap-send.o
>> imap-send.c:183:36: warning: 'ERR_error_string' is deprecated: first
>> deprecated in OS X 10.7 [-Wdeprecated-declarations]
>>          fprintf(stderr, "%s: %s\n", func,
>> ERR_error_string(ERR_get_error(), NULL));
>>                                            ^
> []
> Isn't the warning a warning ;-)
> I don't see this warnings because my openssl comes from
> /opt/local/include (Mac ports)
> Does anybody know which new functions exist in Mac OS X versions >=3D=
 10.7  ?

I am not a Mac person, but is this about APPLE_COMMON_CRYPTO support
added in 4dcd7732 (Makefile: add support for Apple CommonCrypto
facility, 2013-05-19) and be4c828b (imap-send: eliminate HMAC
deprecation warnings on Mac OS X, 2013-05-19)?  Specifically, the
log message for 4dcd7732 begins like so:

    Makefile: add support for Apple CommonCrypto facility
   =20
    As of Mac OS X 10.7, Apple deprecated all OpenSSL functions due to
    OpenSSL ABI instability, thus leading to build warnings.  As a
    replacement, Apple encourages developers to migrate to its own (sta=
ble)
    CommonCrypto facility.

In the Makefile we seem to have this:

    # Define NO_APPLE_COMMON_CRYPTO if you are building on Darwin/Mac O=
S X
    # and do not want to use Apple's CommonCrypto library.  This allows=
 you
    # to provide your own OpenSSL library, for example from MacPorts.

which makes it sound like using APPLE_COMMON_CRYPTO is the default
for Mac.  Perhaps those who do want to use CommonCrypto to avoid
warnings should not define that macro?
