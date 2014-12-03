From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Deprecation warnings under XCode
Date: Tue, 2 Dec 2014 19:37:41 -0500
Message-ID: <CAPig+cRvGaFJQZZ8CDeMMB6u1NKtqUrfe1aWC0OUG3xF9Nu34g@mail.gmail.com>
References: <CAO2U3Qg4DVxSk2u1eJwGqYoxVZTbWRV69J9HTo1rnjFCxSyi2g@mail.gmail.com>
	<547BFD42.3040104@web.de>
	<xmqqoarnp7p2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>,
	David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 01:37:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvxwx-0000wl-4K
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 01:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933557AbaLCAhn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Dec 2014 19:37:43 -0500
Received: from mail-yk0-f182.google.com ([209.85.160.182]:58041 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbaLCAhm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2014 19:37:42 -0500
Received: by mail-yk0-f182.google.com with SMTP id 131so6426915ykp.27
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 16:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=yLbTBVOLzFg8KVctrNPejokrAALXLA3viElk6Ed2zV4=;
        b=XNnSihVMOS3O4F6e54MGrE7cm9WpkZTA7QSn0cRBeY4ikmERpiviHxusJcmpDROfTc
         p3QkoD9piUfclkzgQxyTpw4u7s7u+78Bg9RHytrN7mwhX9cOS+UA6613SW5BzdHHc/Zo
         6jA6/XfmCNQBBJtLithaCUGI5uzrYuFzg1tkWXfRuNYmYdLKzQVwHqk4AaYUeIVowqGV
         R3vBXWmPaQn2PtzwhG1FOwFHsVs/9XUju7qddiy91MEGI8xJk4yR94WRcw5X0zzw+vVk
         CRI26uL5QUwNowwTs/YRTT2seVtIhd8Z6Iz+BJffAsZCV60pXomw3bkcJ3FCGKmqXG7Q
         NeEg==
X-Received: by 10.236.206.74 with SMTP id k50mr2818314yho.180.1417567062004;
 Tue, 02 Dec 2014 16:37:42 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Tue, 2 Dec 2014 16:37:41 -0800 (PST)
In-Reply-To: <xmqqoarnp7p2.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: MVWtw6XWPQyeb3FuQsctttRuIAc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260608>

On Mon, Dec 1, 2014 at 1:04 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> On 12/01/2014 04:02 AM, Michael Blume wrote:
>>> I have no idea whether this should concern anyone, but my mac build=
 of git shows
>>>
>>>      CC imap-send.o
>>> imap-send.c:183:36: warning: 'ERR_error_string' is deprecated: firs=
t
>>> deprecated in OS X 10.7 [-Wdeprecated-declarations]
>>>          fprintf(stderr, "%s: %s\n", func,
>>> ERR_error_string(ERR_get_error(), NULL));
>>>                                            ^
>> Isn't the warning a warning ;-)
>> I don't see this warnings because my openssl comes from
>> /opt/local/include (Mac ports)
>> Does anybody know which new functions exist in Mac OS X versions >=3D=
 10.7  ?

I have not been able to find suitable Mac OS X replacements (nor could
I when resubmitting David's series [1] to use CommonCrypto).

> I am not a Mac person, but is this about APPLE_COMMON_CRYPTO support
> added in 4dcd7732 (Makefile: add support for Apple CommonCrypto
> facility, 2013-05-19) and be4c828b (imap-send: eliminate HMAC
> deprecation warnings on Mac OS X, 2013-05-19)?  Specifically, the
> log message for 4dcd7732 begins like so:
>
>     Makefile: add support for Apple CommonCrypto facility
>
>     As of Mac OS X 10.7, Apple deprecated all OpenSSL functions due t=
o
>     OpenSSL ABI instability, thus leading to build warnings.  As a
>     replacement, Apple encourages developers to migrate to its own (s=
table)
>     CommonCrypto facility.
>
> In the Makefile we seem to have this:
>
>     # Define NO_APPLE_COMMON_CRYPTO if you are building on Darwin/Mac=
 OS X
>     # and do not want to use Apple's CommonCrypto library.  This allo=
ws you
>     # to provide your own OpenSSL library, for example from MacPorts.
>
> which makes it sound like using APPLE_COMMON_CRYPTO is the default
> for Mac.  Perhaps those who do want to use CommonCrypto to avoid
> warnings should not define that macro?

It's been a long time [1] since I looked at it, but I believe that
David's CommonCrypto patch series only replaced OpenSSL calls for
which Apple had provided CommonCrypto replacements. If my memory is
correct, there were still plenty of OpenSSL deprecations warnings
remaining after his patches (the warnings which started this thread)
even without defining NO_APPLE_COMMON_CRYPTO. Thus, David's patches
reduced the number of warnings but did not fully eliminate them.

Checking again, it still seems to be the case that Apple neglects to
provide CommonCrypto replacements for these OpenSSL functions which
Apple itself deprecated.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/224833
