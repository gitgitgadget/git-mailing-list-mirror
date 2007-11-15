From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 11/11] Allow ETC_GITCONFIG to be a relative path.
Date: Thu, 15 Nov 2007 23:24:52 +0100
Message-ID: <1046B46D-585D-47B6-91B3-38F760E68DD4@zib.de>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at> <200711151931.29029.johannes.sixt@telecom.at> <E652EC54-9F94-444F-AF94-2FA990355A78@zib.de> <200711152243.10229.johannes.sixt@telecom.at>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Nov 15 23:26:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsnAC-0001jn-Mf
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 23:26:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760408AbXKOW0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 17:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757164AbXKOW0D
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 17:26:03 -0500
Received: from mailer.zib.de ([130.73.108.11]:37491 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756625AbXKOW0A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 17:26:00 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAFMNbSQ001279;
	Thu, 15 Nov 2007 23:23:37 +0100 (CET)
Received: from [192.168.178.21] (brln-4db82eaf.pool.einsundeins.de [77.184.46.175])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAFMNaGT000031
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 15 Nov 2007 23:23:36 +0100 (MET)
In-Reply-To: <200711152243.10229.johannes.sixt@telecom.at>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65176>


On Nov 15, 2007, at 10:43 PM, Johannes Sixt wrote:

> On Thursday 15 November 2007 21:10, Steffen Prohaska wrote:
>> On Nov 15, 2007, at 7:31 PM, Johannes Sixt wrote:
>>> On Thursday 15 November 2007 07:53, Steffen Prohaska wrote:
>>>> Now I'm wondering if we could make path relocation a bit more
>>>> explicit.  How about doing something like.
>>>>
>>>> 	system_wide = relocate_path(ETC_GITCONFIG);
>>>>
>>>> and relocate_path(const char *) would expand a format
>>>> string in path.  At this point I see only a single %s
>>>> that would be expanded with the install prefix.  If
>>>> ETC_GITCONFIG is "%s/etc/gitconfig" relocate path will return
>>>> "C:/msysgit/bin/etc/gitconfig" for my above example.  It is
>>>> basically a printf with the install prefix path.
>>>
>>> I don't see the problem that you are trying to solve.
>>
>> Path relocation would be more explicit:
>> 1) Paths that need to be relocated are filtered through
>>     relocate_path().  That's easy to understand.
>> 2) All the code prefixing the path is in relocate_path().
>>     This avoids code duplication.
>> 3) Path that should be relocated contain "%s" in the Makefile.
>>     This indicates that some string expansion may take place.
>>
>> (1) and (2) would be useful even if you do not agree with (3).
>> The code in PATCH 9/11 and PATCH 11/11 looks very similar.
>> If the prefixing code went into a separate function, we'd
>> have less code.  Also, relocate_path() could be useful at
>> other places.  For example, I'd use it to locate the HTML
>> documentation relative to the installation directory.
>
> How is %s/foo different from ../foo? There are only 2 paths that  
> need to be
> relocatable. Your proposal is over-engineering, IMHO.

fair enough. Let's take your patches.

	Steffen
