From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <andreas.faerber@web.de>
Subject: Re: patch for fix build git on Haiku
Date: Sun, 24 Feb 2013 10:36:35 +0100
Message-ID: <5129DF23.7050206@web.de>
References: <254e4f8fb172cec1e547413e2828b642@freenet59.ru> <20130223204208.GB3222@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: diger <admin@freenet59.ru>, git@vger.kernel.org,
	HaikuPorts developers discussion list 
	<haikuports-devs@lists.ports.haiku-files.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 10:37:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9Y1F-00037V-5a
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 10:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088Ab3BXJgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 04:36:42 -0500
Received: from mout.web.de ([212.227.15.4]:59240 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752048Ab3BXJgj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 04:36:39 -0500
Received: from envy.site ([84.148.30.238]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MTh2S-1UIJS000QK-00R0Pg; Sun, 24 Feb 2013 10:36:36
 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <20130223204208.GB3222@elie.Belkin>
X-Provags-ID: V02:K0:ZBXbfVnI2fiAqTFp9TIYoZxKIJ+oOqoihTHGCcYDYqb
 nXr8G71RToGTUJuyDxut09CW/3Z1qD5o2D4oxMoU2We7qgEMmk
 n0kdLHZy4dma6+rToL/c/MdF7iaMsNiu934YusDWkmc/XUQtqh
 AIUSYVsIINPKypZmws9nBXhMSa9IqxFW/1FodJyA8eOl1fGElF
 he8FkzWY6U0wWxLqPOH9w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216986>

Hi,

Am 23.02.2013 21:42, schrieb Jonathan Nieder:
> diger wrote:
> 
>> This patch fixes build git on Haiku
> 
> Lovely.  May we have your sign-off?  (See
> Documentation/SubmittingPatches for what this means.)  Does "make
> test" pass?  (Just curious --- it's fine if it doesn't, though in that
> case a list of test failures would be helpful.)
> 
> Thanks,
> Jonathan
> 
> (patch left unsnipped for reference)
> 
>> --- Makefile.orig	2012-10-21 21:32:15.000000000 +0000
>> +++ Makefile
>> @@ -1211,6 +1204,16 @@ ifeq ($(uname_S),HP-UX)
>>  	endif
>>  	GIT_TEST_CMP = cmp
>>  endif
>> +ifeq ($(uname_S),Haiku)
>> +    NO_R_TO_GCC_LINKER = YesPlease
>> +    NO_LIBGEN_H = YesPlease
>> +    NO_MEMMEM = YesPlease
>> +    NO_MKSTEMPS = YesPlease
>> +    NEEDS_LIBICONV = YesPlease
>> +    DEFAULT_EDITOR = nano

Patch looks okay from what I have from my earlier ones in mind, but I
believe nano is an Optional Package on Haiku and thus not guaranteed to
be installed. CC'ing HaikuPorts.

Regards,
Andreas

>> +    PTHREAD_LIBS =    -lroot
>> +    NO_CROSS_DIRECTORY_HARDLINKS = YesPlease
>> +endif
>>  ifeq ($(uname_S),Windows)
>>  	GIT_VERSION := $(GIT_VERSION).MSVC
>>  	pathsep = ;
