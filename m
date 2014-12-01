From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: OpenSSL deprecation warnings under Xcode
Date: Mon, 1 Dec 2014 09:51:00 -0800
Message-ID: <5DF49984-B22E-4BC2-A4B6-8DC9EECEC8B4@gmail.com>
References: <CAO2U3Qg4DVxSk2u1eJwGqYoxVZTbWRV69J9HTo1rnjFCxSyi2g@mail.gmail.com> <547BFD42.3040104@web.de>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 01 18:51:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvV7s-00019f-Q5
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 18:51:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbaLARvF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Dec 2014 12:51:05 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:55804 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbaLARvE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Dec 2014 12:51:04 -0500
Received: by mail-pd0-f179.google.com with SMTP id w10so11387274pde.10
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 09:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=9KMw9vNxJogJafCpcWqmxY+/T9nWZkijE8ovzQxhNqc=;
        b=wv+H2HvD3hepZp0dfsMqQRP8K5zxs7KMVQt2txZ1vmWL3Maj6NPsJKRy2j4VqlBZIk
         /eivSr5RyWOGl/d6K24vnt4WpqvHc+aazhB7XsjN5ryMkS3BZi2ThTVKTKw9cfC4tLQr
         y8l7OmsgJS4KnQTZT5a1j2S0m0Ak0IRRUQFwPM13qS4qHb2WsvkLO9Os5QLfwuB8UEM2
         T+6ZbQDbflxOn0qsQBVaaKxoeyHzs/71Wer18+hIqZUxebzJpI3pAxit9XT2lzFEJD42
         tlpmgGPzeCFdrH9pZiLOg3fhYJoo/vHM3JU80DN+13gtF3/R0aSrAapQRd4n5geTt4H/
         Gqqw==
X-Received: by 10.68.57.144 with SMTP id i16mr101898104pbq.86.1417456263749;
        Mon, 01 Dec 2014 09:51:03 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id zw1sm18034501pbb.82.2014.12.01.09.51.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 01 Dec 2014 09:51:03 -0800 (PST)
In-Reply-To: <547BFD42.3040104@web.de>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260500>

On Nov 30, 2014, at 21:31, Torsten B=F6gershausen wrote:

> On 12/01/2014 04:02 AM, Michael Blume wrote:
>> I have no idea whether this should concern anyone, but my mac build =
=20
>> of git shows
>>
>>     CC imap-send.o
>> imap-send.c:183:36: warning: 'ERR_error_string' is deprecated: first
>> deprecated in OS X 10.7 [-Wdeprecated-declarations]
>>         fprintf(stderr, "%s: %s\n", func,
>> ERR_error_string(ERR_get_error(), NULL));
>>                                           ^
> []
> Isn't the warning a warning ;-)
> I don't see this warnings because my openssl comes from /opt/local/=20
> include (Mac ports)
> Does anybody know which new functions exist in Mac OS X versions >=3D=
 =20
> 10.7  ?

 From [1]:

> In addition to these APIs, a number of open source tools use OpenSSL =
=20
> for secure networking. If you use OpenSSL in your publicly shipping =20
> apps, you must provide your own copy of the OpenSSL libraries, =20
> preferably as part of your app bundle; the OpenSSL libraries that OS =
=20
> X provides are deprecated.

So using the version from Mac Ports is the right idea to avoid the =20
problem.  You can always define NO_OPENSSL.  imap-send.c has a --curl =20
option now. (Which presumably automatically becomes the default if you =
=20
define NO_OPENSSL and not NO_CURL?)

--Kyle

[1] <https://developer.apple.com/library/mac/documentation/security/Con=
ceptual/cryptoservices/SecureNetworkCommunicationAPIs/SecureNetworkComm=
unicationAPIs.html=20
 >