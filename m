From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: MSVC build broken (on cygwin)
Date: Fri, 02 Oct 2009 10:07:10 +0200
Message-ID: <4AC5B4AE.5070307@gmail.com>
References: <4AC4E2C2.6030509@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Oct 02 10:07:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtdAk-0002xt-SL
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 10:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbZJBIHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 04:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753131AbZJBIHP
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 04:07:15 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:49739 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbZJBIHK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 04:07:10 -0400
Received: by ewy7 with SMTP id 7so903374ewy.17
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 01:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=af5+XuGuIyynNBWiuyYywHbxDmoB2PCemIkMXlgPYxc=;
        b=cimp3ZY0/RQhsnnXXCdqnco6WHmJAdE4hP6tdK5ocx/x4VUhonqPvtSr5KY9NdcSw1
         Cjq2OQqJJtGl8YasOuX2ri2VOQeuiIiOYBvvoasTtxXXL/89rBixaqekygzZBwn2eSdR
         3dPkI0vKB+vi8n0B+Qzb8PGQ7y7R8rdkEreis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=qMnMesnmlJxDrrV3Xal1ViUJQgvqDqLw//J0X3FNDbr91QgJxtwsjf0hMILt8IOKcS
         W9p6DMmA95xqaojzbWMgGyYqYyNTPkI0aTBIu7D1pWkCqi/wO+A8EVPwNTlDSwnqZ9WW
         BSKOuzV9dy+HleblW4zhrRYlc3r2GoACvsrvI=
Received: by 10.211.128.11 with SMTP id f11mr9131802ebn.62.1254470833721;
        Fri, 02 Oct 2009 01:07:13 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 24sm1631638eyx.9.2009.10.02.01.07.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Oct 2009 01:07:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <4AC4E2C2.6030509@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129429>

Ramsay Jones said the following on 01.10.2009 19:11:
> Hi Marius,
> 
> I know that I'm somewhat late to comment on your recent MSVC
> build patches, but I was busy at the time; better late than
> never... maybe ;-)
> 
> While the patches were traversing the list, I was feeling
> somewhat nervous about the effect of the patches on the
> cygwin build; in fact I remember thinking that they had
> *probably* broken the build. But I was busy...
> 
> Well I finally found time, yesterday, to take a closer look.
> I spent 10-15 minutes squinting at the code in order to
> convince myself that you had in fact *not* broken the cygwin
> build. :)
...
> [Note: I was a little surprised that it got that far, since I didn't
> expect it to find the zlib header files. However, I have set the
> INCLUDE environment variable which msvc is respecting! yeah, a bit old
> fashioned!  Having also set the LIB environment variable, I was then
> a bit surprised that the linker didn't find the library; until I
> noticed that my library is called libz.lib *not* zlib.lib!]
...
Clone the git://repo.or.cz/msvcgit.git, and run the 
setup_32bit_env.cmd script in there, and you should have everything 
you need to both compile and link Git with MSVC.

> Note that the patch below includes some line-wrapping which you can
> ignore if you like, it just makes the Makefile easier to read.
> The only change that matters is inserting a space between -DWIN32 and
> -D_CONSOLE.
> 
> Anyway, the point is *not* to get the msvc build to work for me; rather
> it is to understand why the build *works* for you. ;-)

First of all, thanks for the thorough report! :)
Second, I just recompiled, and it magically works for me. Why is a 
good question, since I also think it shouldn't at this point. The 
_WIN32 define is added by the compiler, and the WIN32 is added by 
windows.h, so our define guards *should* be testing for the _WIN32 define.

To how the guarded code reacts, I preprocessed the run-command.c with 
both version of the command line, and the result was the same:

( 9:54:49 - D:\msvc\git)
 > cl -E ... -DWIN32-D_CONSOLE ... run-command.c | grep run_thread
run-command.c
static unsigned __stdcall run_thread(void *data)
         async->tid = (HANDLE) _beginthreadex(((void *)0), 0, 
run_thread, async, 0, ((void *)0));

( 9:55:43 - D:\msvc\git)
 > cl -E ... -DWIN32 -D_CONSOLE ... run-command.c | grep run_thread
run-command.c
static unsigned __stdcall run_thread(void *data)
         async->tid = (HANDLE) _beginthreadex(((void *)0), 0, 
run_thread, async, 0, ((void *)0));

So, obviously, some magic in there is making it work for me. I have a 
hard time locating the magic in question though. :-/
That being said, does adding the space between the defines fix the 
MSVC compilation using Cygwin's GNU Make? It's none-the-less a correct 
patch, so you get an ack from me. Thanks!

Acked-by: Marius Storm-Olsen <mstormo@gmail.com>

--
.marius
