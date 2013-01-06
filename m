From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 06 Jan 2013 16:09:54 -0500
Message-ID: <50E9E822.4020709@gmail.com>
References: <2491041.bQ51Qu8HcA@thunderbird> <1890551.8jTmplCF6O@thunderbird> <BB541ECCD3F04E479F06CA491DDB598D@black> <50E92675.4010907@web.de> <20130106093211.GB10956@elie.Belkin> <50E946EB.1000709@web.de> <20130106095757.GC10956@elie.Belkin> <50E9647F.4090209@gmail.com> <20130106120917.GC22081@elie.Belkin> <7vfw2enl2l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?ISO-8859-1?Q?Torsten_B=F6ge?= =?ISO-8859-1?Q?rshausen?= 
	<tboegi@web.de>, Stephen & Linda Smith <ischis2@cox.net>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Eric Blake <eblake@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 22:10:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrxU7-0006i2-7I
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 22:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989Ab3AFVJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 16:09:58 -0500
Received: from mail-vb0-f44.google.com ([209.85.212.44]:35496 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab3AFVJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 16:09:56 -0500
Received: by mail-vb0-f44.google.com with SMTP id fc26so18940228vbb.3
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 13:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=29+FlBXbQorIBItr1NDY9hXVe7dzhYjRKViPsbw0Baw=;
        b=xOvTpenBxPYevy9eZP0jFUjwFYxxxfMIktoovqzon8OlxPP6MXgMgQxj2amIMMjz9L
         Dftd1whwDlnLLgelpJESThw9oz2Z05YqfY9yoxZ/cuX8uep6JcS8QEronfx/Lvs2fOf3
         dIiCie4Znz9T/XTQ9U4aAotWt0o1PUC3bsiUsp+J1rxo5bPEjmYrhTJyR0OwEyK9Frd6
         pISLtjcthZNWCLQmg3xJPuedCznlqWm5donnr3JXLbF6jv+ixtOWZCxEbekIVtKPDFqP
         NhwSwVBeUPf95lIm+aNufSiPy9LdiaV2TU3fU55McW+YCdKK6lm16odx2+paOYIjw2lV
         gH8g==
X-Received: by 10.58.187.84 with SMTP id fq20mr83573482vec.25.1357506595979;
        Sun, 06 Jan 2013 13:09:55 -0800 (PST)
Received: from mark-laptop.lan (pool-173-79-102-236.washdc.fios.verizon.net. [173.79.102.236])
        by mx.google.com with ESMTPS id p10sm50634312vdh.4.2013.01.06.13.09.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Jan 2013 13:09:55 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vfw2enl2l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212842>

On 01/06/2013 02:54 PM, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Mark Levedahl wrote:
>>
>>>                                                           However, the newer
>>> win32api is provided only for the current cygwin release series, which can
>>> be reliably identified by having dll version 1.7.x, while the older frozen
>>> releases (dll versions 1.6.x from redhat, 1.5.x open source) still have the
>>> older api as no updates are being made for the legacy version(s).
>> Ah.  That makes sense, thanks.
>>
>> (For the future, if we wanted to diagnose an out-of-date win32api and
>> print a helpful message, I guess cygcheck would be the command to use.)
> Hmph, so we might see somebody who cares about Cygwin to come up
> with a solution based on cygcheck (not on uname) to update this
> part, perhaps on top of Peff's "split default settings based on
> uname into separate file" patch?
>
> If I understood what Mark and Torsten wrote correctly, you will have
> the new win32api if you install 1.7.17 (or newer) from scratch, but
> if you are on older 1.7.x then you can update the win32api part as a
> package update (as opposed to the whole-system upgrade).  A test
> based on "uname -r" cannot notice that an older 1.7.x (say 1.7.14)
> installation has a newer win32api because the user updated it from
> the package (hence the user should not define CYGWIN_V15_WIN32API).
>
> Am I on the same page as you guys, or am I still behind?
>
> In the meantime, perhaps we would need something like this?
>
>
> diff --git a/Makefile b/Makefile
> index 8e225ca..b45b06d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -281,6 +281,9 @@ all::
>   #
>   # Define NO_REGEX if you have no or inferior regex support in your C library.
>   #
> +# Define CYGWIN_V15_WIN32API if your Cygwin uses win32api dll older than
> +# 1.7.x (this typically is true on Cygwin older than 1.7.17)
> +#
>   # Define HAVE_DEV_TTY if your system can open /dev/tty to interact with the
>   # user.
>   #
>
Looking at a current setup.ini, the obsolete win32 api is a single 
package "w32api" with last version 3.17-2, and is now replaced by the 
new win32 api is in two packages, "w32api-headers" + "w32api-runtime", 
both at version 3.0b_svn5496-1. If setup.exe updated an older 
installation of w32api, the old package is not deleted, but replaced by 
a special "empty" package with (as of today) version 9999-1. Note that 
all of this could change at any time. Also, note that the new w32api 
packages have version numbers that are lower than the older obsoleted 
version.

Running "cygcheck -c w32api w32api-headers w32api-runtime" on one 
machine gives

Cygwin Package Information
Package              Version            Status
w32api               9999-1             OK
w32api-headers       3.0b_svn5496-1     OK
w32api-runtime       3.0b_svn5496-1     OK

So now, what do folks propose checking for?
a) w32api is installed? Nope - the package is not "removed", it was 
updated to a special empty version to delete its former contents, but a 
new fresh installation won't have this.
b) w32api-headers is installed? Nope - what happens on the next repackaging?
c) w32api version is 9999-1? Maybe, but that number could change.
etc.

There is no documented, reliable, future-proof, method of determining 
the installed w32api version on Cygwin. There are many things that can 
be done that will work frequently, except when they won't. I really 
think the only sane thing is to follow the guidance of the Cygwin 
developers: the only supported configuration is that which the current 
setup.exe produces, and in the case of problems, if the installation is 
not up to date then updating is the first required action.

So, in the makefile, you might add:

+# Define CYGWIN_V15_WIN32API if you are using Cygwin v1.7.x but are not
+# using the current w32api packages. But, the recommended approach is to
+# update your installation if compilation errors occur.
+#

Mark
