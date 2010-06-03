From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: About [PATCH] gitweb: Create a perl module to store gitweb  configuration
Date: Thu, 3 Jun 2010 12:23:31 +0200
Message-ID: <201006031223.31675.jnareb@gmail.com>
References: <201006022229.31593.jnareb@gmail.com> <AANLkTin9ZHij7ldIlSHyCqOd8NmU9DQA5q-tyvIImtdD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 12:23:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK7aa-0000ay-70
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 12:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758977Ab0FCKXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 06:23:44 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50382 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758680Ab0FCKXm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 06:23:42 -0400
Received: by bwz11 with SMTP id 11so611300bwz.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 03:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=b9QjqNhJf5ywdhNpsb+UZ/YF4X6HEtdBXVeiMcjnGKo=;
        b=XQmZFpklZTwkUatabzcvKu9D4wj8ODzOavYLDyeGWuFZ3xEnOTcoTaQRBeKwRJX/bQ
         R+AE/6H8d47VuTFNvQK35lDQocVJkuvjAeRSfpHcdlpUE5oUQK8LPDIjfj8FSHmbylGp
         /Bjz853uxGwVYzm2/w4FLUNd0HiGG6rzMxe5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BhvlfTONhih/INCB5zc3F8z0+BxphEuI32lfAZWVeLuE88Ijf9DGfiq5SxDqW4d2qX
         vHRDmF1umMlKrpY7qPEpeJFhLHff28tQ4Xm4kX7PJ3slLZicHkjBiWyZGTXZ016DY8TK
         HgV2Y+HD/XqfjW72s4B0Z2Qw4vICG/WWX8xUQ=
Received: by 10.204.150.84 with SMTP id x20mr2726419bkv.176.1275560619946;
        Thu, 03 Jun 2010 03:23:39 -0700 (PDT)
Received: from [192.168.1.15] (abvx149.neoplus.adsl.tpnet.pl [83.8.221.149])
        by mx.google.com with ESMTPS id z17sm12529052bkx.0.2010.06.03.03.23.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 03:23:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTin9ZHij7ldIlSHyCqOd8NmU9DQA5q-tyvIImtdD@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148305>

On Thu, 3 Jun 2010, Pavan Kumar Sunkarawrote:
> 2010/6/3 Jakub Narebski <jnareb@gmail.com>:
>>
>> This comment is about commit 9526ab8 (gitweb: Create a perl module to
>> store gitweb configuration, 2010-06-01) on 'master' branch of
>> repository shown at http://repo.or.cz/w/git/gsoc2010-gitweb.git

>>> diff --git a/gitweb/Makefile b/gitweb/Makefile
>>> index d2584fe..45e176e 100644
>>> --- a/gitweb/Makefile
>>> +++ b/gitweb/Makefile
>>> @@ -55,6 +55,7 @@ PERL_PATH  ?= /usr/bin/perl
>>>  bindir_SQ = $(subst ','\'',$(bindir))#'
>>>  gitwebdir_SQ = $(subst ','\'',$(gitwebdir))#'
>>>  gitwebstaticdir_SQ = $(subst ','\'',$(gitwebdir)/static)#'
>>> +gitweblibdir_SQ = $(subst ','\'',$(gitwebdir)/lib)#'
>>
>> I think it would be good idea to have 'gitweblibdir' as a separate
>> variable, alongside 'gitwebdir', and which would default to
>>
>>   gitweblibdir = $(gitwebdir)/lib
>>
>> to make it possible to install gitweb modules not alongside gitweb,
>> but somewhere else, for example together with other Perl modules.
>>
>> Then you would have:
>>
>>  +gitweblibdir_SQ = $(subst ','\'',$(gitweblibdir))#'
> 
> It's great.
> 
>> But I think this change can be left for a separate commit.  It is not
>> something terribly important, something blocking accepting the patch.

Actually to really be able to put gitweb packages somewhere else,
gitweb.perl should *probably* contain

  use lib '++GITWEBLIBDIR++';

Otherwise 'gitweblibdir' would have to be either left default to
install packages alingside gitweb.cgi script, or be directory that is
in PERL5LIB for web server.

So let's leave it for a later commit.

-- 
Jakub Narebski
Poland
