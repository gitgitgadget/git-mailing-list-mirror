From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Fri, 25 Jan 2013 18:58:59 -0500
Message-ID: <51031C43.5030307@gmail.com>
References: <20130106120917.GC22081@elie.Belkin> <7vfw2enl2l.fsf@alter.siamese.dyndns.org> <50E9F7C2.1000603@gmail.com> <FBDECCA565D94DF9838DD81FE2E2543A@black> <7v1udxladc.fsf@alter.siamese.dyndns.org> <50EB8EB5.6080204@gmail.com> <CALxABCYHRp17rcoOca1xWG9S19fq2rotz8FEKo09jNdrgMLiyQ@mail.gmail.com> <CALxABCavvW77djKQnbQsjCBcahmMfrP24SDz609NG-94_ifZ9Q@mail.gmail.com> <50F303D8.20709@gmail.com> <50F5A435.5090408@ramsay1.demon.co.uk> <20130120101007.GD16339@elie.Belkin> <50FEDB08.6030901@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Stephen & Linda Smith <ischis2@cox.net>,
	Eric Blake <eblake@redhat.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Jan 26 00:59:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TytBP-00028K-N6
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 00:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab3AYX7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 18:59:22 -0500
Received: from mail-qa0-f47.google.com ([209.85.216.47]:51568 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab3AYX7V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 18:59:21 -0500
Received: by mail-qa0-f47.google.com with SMTP id j8so41023qah.13
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 15:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=+9NlpCVxY6yhopeaJzQqOE/RCk6Bo6gJ0TkVn1XNrqI=;
        b=a4mGXqCStk+0Yp3Qt9WqIk2yg6rgcNo4seGW7oyyh7xYust9PwfoAzc7icTbn2rL8H
         teWFAKxoOg/U2WlOEPVR/7mR+JyQIfJMp0zBxEE2JrjJV07syBc8sV9RovlIx36vr1yP
         HXsW90DzZWNc9y/N79co5+5q/8Yv66yIJJ6xhwdpI674LPKC6MAmiYIpg5d8/URu08Sz
         IkwQeA02uP1+A4BjNUSipiwZpK+fRnIwd+KkwxxD66bUeDXv18NvOktiXEiREvX1VUlC
         1pgUkb3DTn6tNad5M/OMEj/uo1JHD/6i4nmJ+txPbRBFElZTcaJkOB3nBJuTNrRQDPm/
         4GnA==
X-Received: by 10.49.48.43 with SMTP id i11mr9194459qen.3.1359158360329;
        Fri, 25 Jan 2013 15:59:20 -0800 (PST)
Received: from mark-laptop.lan (pool-173-79-109-151.washdc.fios.verizon.net. [173.79.109.151])
        by mx.google.com with ESMTPS id i9sm1387495qei.10.2013.01.25.15.59.03
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 15:59:04 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <50FEDB08.6030901@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214596>

On 01/22/2013 01:31 PM, Ramsay Jones wrote:
> include order. ;-) As I have mentioned here before, the claim that 
> "WIN32 is not defined on cygwin" is simply nonsense - it depends on 
> if/when certain header files are included. For example, *as soon as* 
> you include <windows.h> (and, I suspect, many other win32 headers) 
> then "defined(WIN32)" is true. Note that commit 380a4d92 ("Update 
> cygwin.c for new mingw-64 win32 api headers", 11-11-2012) swaps the 
> include order for the win32.h and git-compat-util.h header files. [I 
> don't know the details, Mark didn't elaborate, but it is clearly an 
> include order problem on cygwin 1.7.x :-D ] This causes compilation 
> errors on cygwin 1.5.x, exactly because win32.h includes <windows.h>, 
> which defines WIN32, which then leads to git-compat-util.h including 
> <winsock2.h>.
>>   #if defined(WIN32) && defined(__CYGWIN__)
>>   # undef WIN32
>>   #endif
>
Cygwin and Windows should be treated as completely separate platforms: 
if __CYGWIN__ is defined, do one thing, if not, go ahead and check 
WIN32, but the WIN32 macro should never be tested once we know the 
platform is CYGWIN - these really are different platforms (if you are 
unsure of this, consider that Cygwin includes a cross-compiler to target 
native Win32 as the Cygwin maintainers recognized the platforms are 
different).

Mark
