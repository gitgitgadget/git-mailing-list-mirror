From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Deprecation warnings under XCode
Date: Tue, 2 Dec 2014 22:09:35 -0500
Message-ID: <CAPig+cRj5bLrkperGiDHG78KghiGgkMAT=Qihia2FR8psEQxvQ@mail.gmail.com>
References: <CAO2U3Qg4DVxSk2u1eJwGqYoxVZTbWRV69J9HTo1rnjFCxSyi2g@mail.gmail.com>
	<547BFD42.3040104@web.de>
	<xmqqoarnp7p2.fsf@gitster.dls.corp.google.com>
	<CAPig+cRvGaFJQZZ8CDeMMB6u1NKtqUrfe1aWC0OUG3xF9Nu34g@mail.gmail.com>
	<CAO2U3QiwJ=EZBModED6jR2YuF5NMVvrUkzj1iOGMLAqwKNbw3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	David Aguilar <davvid@gmail.com>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 04:09:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw0Jx-0001TV-AD
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 04:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbaLCDJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 22:09:37 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:60262 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbaLCDJg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 22:09:36 -0500
Received: by mail-yh0-f49.google.com with SMTP id f10so6630303yha.8
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 19:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=d5FZBdTkFmP9ND+5ci1dCTCBLluRDGudGp1k/aD4WpQ=;
        b=ZlbvLlkXV31tg3A1G7h/oieXKpC6m3rptt9ZXUsEjHWLaKA6cOrhCi+KXvcr87zL9v
         seJ5myXwiP+IMV4lVMXaqFSh1AB1S+y0IkN58bxZUSJjGMUUfIulLFGoPCdZa79qq5GH
         xpmIVWmzbTcjOO/RmWK905E/IrCdzrkSQzIBNtaDWR0tQqXSaTjqSMVm3VA9BRge2cX2
         zl+u/XDViLzV2msO6ZmnL1ERYWotzA1phzHDOM8xpObp+wOFF66tJsNjkvPuN8f0Bh0t
         iMK78rMGa2gPPSzwOVzDowKVv3rqngOYuE9FoxcNJCwOW+5L7OnSC8jWYsu7ZxcBC+wF
         bMRw==
X-Received: by 10.236.53.69 with SMTP id f45mr3100910yhc.65.1417576175925;
 Tue, 02 Dec 2014 19:09:35 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Tue, 2 Dec 2014 19:09:35 -0800 (PST)
In-Reply-To: <CAO2U3QiwJ=EZBModED6jR2YuF5NMVvrUkzj1iOGMLAqwKNbw3A@mail.gmail.com>
X-Google-Sender-Auth: bFbZMX4AX3ml_824HB5DYdK9SpU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260618>

On Tue, Dec 2, 2014 at 8:12 PM, Michael Blume <blume.mike@gmail.com> wrote:
> On Tue, Dec 2, 2014 at 4:37 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Mon, Dec 1, 2014 at 1:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> I am not a Mac person, but is this about APPLE_COMMON_CRYPTO support
>>> added in 4dcd7732 (Makefile: add support for Apple CommonCrypto
>>> facility, 2013-05-19) and be4c828b (imap-send: eliminate HMAC
>>> deprecation warnings on Mac OS X, 2013-05-19)? [...]
>>> In the Makefile we seem to have this:
>>>
>>>     # Define NO_APPLE_COMMON_CRYPTO if you are building on Darwin/Mac OS X
>>>     # and do not want to use Apple's CommonCrypto library.  This allows you
>>>     # to provide your own OpenSSL library, for example from MacPorts.
>>>
>>> which makes it sound like using APPLE_COMMON_CRYPTO is the default
>>> for Mac.  Perhaps those who do want to use CommonCrypto to avoid
>>> warnings should not define that macro?
>>
>> It's been a long time [1] since I looked at it, but I believe that
>> David's CommonCrypto patch series only replaced OpenSSL calls for
>> which Apple had provided CommonCrypto replacements. If my memory is
>> correct, there were still plenty of OpenSSL deprecations warnings
>> remaining after his patches (the warnings which started this thread)
>> even without defining NO_APPLE_COMMON_CRYPTO. Thus, David's patches
>> reduced the number of warnings but did not fully eliminate them.
>>
>> Checking again, it still seems to be the case that Apple neglects to
>> provide CommonCrypto replacements for these OpenSSL functions which
>> Apple itself deprecated.
>>
>> [1]: http://thread.gmane.org/gmane.comp.version-control.git/224833
>
> If there's actually no way to address this, is there a simple way to
> silence deprecation warnings only in this file? I only ask because
> overall the git build seems to be extremely quiet, and it seems
> valuable to preserve that, so that warnings we want to act on stick
> out.

An individual developer can add '-Wno-deprecated-declarations' to
CFLAGS to suppress these warnings, however, that's pretty much a
sledge hammer which would impact deprecations from all included
headers, not just Apple's. For this reason, we probably wouldn't want
to make this the default.

The potentially lesser evil would be this small patch (minus Gmail
whitespace damage) which disables the deprecation warnings only for
Apple's headers:

----- >8 -----
diff --git a/git-compat-util.h b/git-compat-util.h
index 400e921..709e84f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -211,6 +211,8 @@ extern char *gitbasename(char *);
 #endif

 #ifndef NO_OPENSSL
+#define __AVAILABILITY_MACROS_USES_AVAILABILITY 0
+#define MAC_OS_X_VERSION_MIN_REQUIRED MAC_OS_X_VERSION_10_6
 #include <openssl/ssl.h>
 #include <openssl/err.h>
 #endif
----- >8 -----

It's still mildly heavy-handed, in that it could silence legitimate
Apple deprecations, but it does give us a clean build with little
fuss. An alternative would be to relegate these #defines to the Darwin
section of the Makefile if placing them in git-compat-util.h seems too
invasive.

Considering that Mac OS X is now at 10.10 and these deprecations
commenced with Mac OS X 10.7 in July 2011 (3.5 years ago), and Apple
still has not provided drop-in CommonCrypto equivalents, it seems
unlikely that they will do so any time soon. Consequently, suppressing
these otherwise unavoidable warnings may be the best we can do.

I'm willing to formalize and submit this as a proper patch if it's not
considered too disgusting by the powers-that-be.
