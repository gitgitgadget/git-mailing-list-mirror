From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] Add Tru64/OSF1 support in Makefile
Date: Thu, 01 Apr 2010 10:47:23 -0500
Message-ID: <k1zDoDCu8fS7Dsy98IBzvAeSfBRw0mOYNtxTGUiBGfWOumW0yfxTqA@cipher.nrlssc.navy.mil>
References: <d2d39d861003301122p646efc1fj9d88af1893b84b3c@mail.gmail.com> <DA8Or5TA0_betHA0BMcLIT0so7oVjDK6CYr4x1LCiX60SEmuPqVnXg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Thu Apr 01 17:49:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxMdm-0000hW-CS
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 17:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756896Ab0DAPs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 11:48:59 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46294 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756885Ab0DAPs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 11:48:58 -0400
Received: by mail.nrlssc.navy.mil id o31Fm0GS002257; Thu, 1 Apr 2010 10:48:15 -0500
In-Reply-To: <DA8Or5TA0_betHA0BMcLIT0so7oVjDK6CYr4x1LCiX60SEmuPqVnXg@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 01 Apr 2010 15:47:49.0998 (UTC) FILETIME=[AEC488E0:01CAD1B2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143733>

On 03/31/2010 11:29 AM, Brandon Casey wrote:
> On 03/30/2010 01:22 PM, Tor Arntsen wrote:

>> +	SHELL_PATH = /bin/ksh
> 
> Can you run the test suite with this ksh?  If it suffers from
> the same exit status behavior of ksh on IRIX and SunOS, then
> I have a patch which allows the test suite to run.
> 
> Also, I wonder if it suffers from the same trap handling that
> ksh has on SunOS.
> 
>> +	BASIC_CFLAGS += -D_POSIX_C_SOURCE=1 -D_OSF_SOURCE=1
>> +	BASIC_CFLAGS += -pthread
> 
> There is a PTHREAD_LIBS variable and it seems there is precedent
> for setting it to -pthread in the FreeBSD section.

heh, must have copy/pasted to the wrong place and hastily sent
this email.  This snippet of shell script below is supposed to be
up there after the sentence about trap handling of ksh on SunOS.

> Namely, the following shell snippet should exit 0, but does not
> on SunOS's ksh:
> 
>    (atrap () { exit 0; }
>     func3 () { exit 1; }
>     func2 () { func3; }
>     func1 () { trap atrap EXIT; func2; }
>     func1)

-brandon
