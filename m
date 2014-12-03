From: Michael Blume <blume.mike@gmail.com>
Subject: Re: Deprecation warnings under XCode
Date: Tue, 2 Dec 2014 17:12:48 -0800
Message-ID: <CAO2U3QiwJ=EZBModED6jR2YuF5NMVvrUkzj1iOGMLAqwKNbw3A@mail.gmail.com>
References: <CAO2U3Qg4DVxSk2u1eJwGqYoxVZTbWRV69J9HTo1rnjFCxSyi2g@mail.gmail.com>
 <547BFD42.3040104@web.de> <xmqqoarnp7p2.fsf@gitster.dls.corp.google.com> <CAPig+cRvGaFJQZZ8CDeMMB6u1NKtqUrfe1aWC0OUG3xF9Nu34g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	David Aguilar <davvid@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 02:13:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvyVJ-0006dL-44
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 02:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbaLCBNL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Dec 2014 20:13:11 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:37488 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbaLCBNJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2014 20:13:09 -0500
Received: by mail-ob0-f177.google.com with SMTP id va2so293451obc.22
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 17:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=wpG87EcddjkXrzOzn5gW5RKJD4fQfmcYQJnBcerZIwY=;
        b=VPzpCUkozvj01vFYqBA9Cq9/GPMnWWb4fGG06oFlCR4o4u/3fZdgIK09FClpVq4AM5
         W7R3FNh8LSWQ2uvHCj4lcy7oYewzM3XR/D3vT0EyytSnuF9dmpyLtDHcCY510+ci1jIr
         bXs5Xe0C18IZusFF0+P7PU0/oeo8J5BJ8FluDuhdAK77slW5zHDbIr7qVWyKdmuGV1h1
         u0xkMUwrIaNFHo/Ujh2TgvFxn5GwzcgL/xTUtmqEk/A0PDS+01WzQLw/LtIoZuDJZtJo
         HeXj87LpJcyRMesQPoVLbw6sHtKVZ8un9GnMoB1soldciH02Tpb91r1+xPZNNZkdzFC9
         DXlQ==
X-Received: by 10.60.81.131 with SMTP id a3mr1386223oey.81.1417569188376; Tue,
 02 Dec 2014 17:13:08 -0800 (PST)
Received: by 10.202.48.207 with HTTP; Tue, 2 Dec 2014 17:12:48 -0800 (PST)
In-Reply-To: <CAPig+cRvGaFJQZZ8CDeMMB6u1NKtqUrfe1aWC0OUG3xF9Nu34g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260610>

On Tue, Dec 2, 2014 at 4:37 PM, Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> On Mon, Dec 1, 2014 at 1:04 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>
>>> On 12/01/2014 04:02 AM, Michael Blume wrote:
>>>> I have no idea whether this should concern anyone, but my mac buil=
d of git shows
>>>>
>>>>      CC imap-send.o
>>>> imap-send.c:183:36: warning: 'ERR_error_string' is deprecated: fir=
st
>>>> deprecated in OS X 10.7 [-Wdeprecated-declarations]
>>>>          fprintf(stderr, "%s: %s\n", func,
>>>> ERR_error_string(ERR_get_error(), NULL));
>>>>                                            ^
>>> Isn't the warning a warning ;-)
>>> I don't see this warnings because my openssl comes from
>>> /opt/local/include (Mac ports)
>>> Does anybody know which new functions exist in Mac OS X versions >=3D=
 10.7  ?
>
> I have not been able to find suitable Mac OS X replacements (nor coul=
d
> I when resubmitting David's series [1] to use CommonCrypto).
>
>> I am not a Mac person, but is this about APPLE_COMMON_CRYPTO support
>> added in 4dcd7732 (Makefile: add support for Apple CommonCrypto
>> facility, 2013-05-19) and be4c828b (imap-send: eliminate HMAC
>> deprecation warnings on Mac OS X, 2013-05-19)?  Specifically, the
>> log message for 4dcd7732 begins like so:
>>
>>     Makefile: add support for Apple CommonCrypto facility
>>
>>     As of Mac OS X 10.7, Apple deprecated all OpenSSL functions due =
to
>>     OpenSSL ABI instability, thus leading to build warnings.  As a
>>     replacement, Apple encourages developers to migrate to its own (=
stable)
>>     CommonCrypto facility.
>>
>> In the Makefile we seem to have this:
>>
>>     # Define NO_APPLE_COMMON_CRYPTO if you are building on Darwin/Ma=
c OS X
>>     # and do not want to use Apple's CommonCrypto library.  This all=
ows you
>>     # to provide your own OpenSSL library, for example from MacPorts=
=2E
>>
>> which makes it sound like using APPLE_COMMON_CRYPTO is the default
>> for Mac.  Perhaps those who do want to use CommonCrypto to avoid
>> warnings should not define that macro?
>
> It's been a long time [1] since I looked at it, but I believe that
> David's CommonCrypto patch series only replaced OpenSSL calls for
> which Apple had provided CommonCrypto replacements. If my memory is
> correct, there were still plenty of OpenSSL deprecations warnings
> remaining after his patches (the warnings which started this thread)
> even without defining NO_APPLE_COMMON_CRYPTO. Thus, David's patches
> reduced the number of warnings but did not fully eliminate them.
>
> Checking again, it still seems to be the case that Apple neglects to
> provide CommonCrypto replacements for these OpenSSL functions which
> Apple itself deprecated.
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/224833

Apologies, accidentally sent this from inbox the first time.

If there's actually no way to address this, is there a simple way to
silence deprecation warnings only in this file? I only ask because
overall the git build seems to be extremely quiet, and it seems
valuable to preserve that, so that warnings we want to act on stick
out.
