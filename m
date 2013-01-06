From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 06 Jan 2013 16:34:32 -0500
Message-ID: <50E9EDE8.6090200@gmail.com>
References: <2491041.bQ51Qu8HcA@thunderbird> <1890551.8jTmplCF6O@thunderbird> <BB541ECCD3F04E479F06CA491DDB598D@black> <50E92675.4010907@web.de> <20130106093211.GB10956@elie.Belkin> <50E946EB.1000709@web.de> <20130106095757.GC10956@elie.Belkin> <50E9647F.4090209@gmail.com> <20130106120917.GC22081@elie.Belkin> <7vfw2enl2l.fsf@alter.siamese.dyndns.org> <50E9E3C5.4070104@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen & Linda Smith <ischis2@cox.net>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Eric Blake <eblake@redhat.com>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 06 22:34:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trxrq-0006hs-A9
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 22:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085Ab3AFVeg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 16:34:36 -0500
Received: from mail-qc0-f173.google.com ([209.85.216.173]:60627 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004Ab3AFVee (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 16:34:34 -0500
Received: by mail-qc0-f173.google.com with SMTP id b12so11237401qca.18
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 13:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=45EALwqJPRS/DYDCaNEItrhxZl8NWKWuNlBrLowMPDk=;
        b=w2fAlJbpkaj+3VGYdgpZ6iF9+M3xU7m2nEiolspLJ4PntlrkMZ+SCtQP7NTsIbEbjv
         apm42oo3IdoQFYhFBGQXPxoJiu5dAhkREx7wFHp8TzH/ds6pBBMPLH7VQGzHXjWT0sUV
         FsPA6N7XnjPQ+9FEmvw0WdS1hZy+qQUoZxYpjf5e1QY/5nKsEIW2pi6Fs0ySsL3Fmc6p
         ZsDhUCKhVvPI6dLyT+ayZNNJ/xxcsKzZoT7o2T+AZ3VibEVGAb7LjZit5TyMEAI3pEqz
         rUurC1bMiEjBCpFAfrJtSpva3OSR815s+h/SafE25DmEBNaVd6nYQi5fwZg2RM/S8W2m
         v8aQ==
X-Received: by 10.224.71.20 with SMTP id f20mr36617979qaj.71.1357508074046;
        Sun, 06 Jan 2013 13:34:34 -0800 (PST)
Received: from mark-laptop.lan (pool-173-79-102-236.washdc.fios.verizon.net. [173.79.102.236])
        by mx.google.com with ESMTPS id f5sm19574047qac.5.2013.01.06.13.34.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Jan 2013 13:34:33 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50E9E3C5.4070104@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212844>

On 01/06/2013 03:51 PM, Torsten B=F6gershausen wrote:
> Hm, I haven't understood the connection between the dll (cygwin1.dll=20
> ?) which is used in runtime, and the header files which are used when=
=20
> compiling. Are they updated at the same time when updating from 1.7.1=
6=20
> to 1.7.17 ? Until I updated my cygwin 1.7 (following Marks=20
> recommendation) this did the trick for me: +ifeq ($(shell grep mingw=20
> /usr/include/w32api/winsock2.h />/dev/null 2>/dev/null && echo y),y) =
+=20
> CYGWIN_V15_WIN32API=3DYesPlease +endif As an alternative, would this =
be=20
> easier to read?
>> +# Define CYGWIN_V15_WIN32API for Cygwin versions up to 1.7.16
>
>

The cygwin distribution has a very large number of packages, each with=20
its own unique version number and update rhythm, just as in any linux=20
distro. There is no "cygwin version", just a version for each individua=
l=20
package. So, "Cygwin version 1.7.16" is really nonsensical: there is=20
only cygwin.dll version 1.7.16.  What folks are noticing is a=20
coincidence in the time when the cygwin dll package updated and when th=
e=20
old w32api was obsoleted. uname -r reports the cygwin dll version, not=20
the version of any other package. Note that the cygwin api is "stable",=
=20
meaning a package compiled against the 1.7.1 dll will still run against=
=20
the current one: updating the cygwin dll does not require other package=
s=20
to update.

The only hard linkage here is that the Cygwin developers are maintainin=
g=20
a legacy cygwin version (v1.5.x) as the newer dll series (v.1.7.x)=20
dropped support for all Windows versions predating (I think) WinXP. So,=
=20
someone on an old Windows version must use the legacy cygwin version=20
which has not been updated since the first v1.7 dll was released, nor=20
are there any plans by the developers to ever update the v1.5 packages.=
=20
Cygwin 1.5 lives in a separate distribution repository, with packages=20
frozen in time as of the last updates prior to going to v1.7 (packages=20
compiled against v1.7 will not run on v.1.5).

So, encountering a v1.5.x dll is a guarantee of using the older w32api=20
shared with the mingw project, rather than the current one now=20
maintained by the mingw64 project. However, a cygwin with any v1.7.x dl=
l=20
could in theory have either w32api installed, or in theory yet another=20
newer one we don't know about yet. Unless and until the w32api=20
establishes a version number (independent of the Windows API version),=20
we have nothing reliable to use.

Therefore, if using the v1.7 series, *update*

Mark
