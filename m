From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [RFC 15/15] Tag GIT_VERSION when Git is built with MSVC
Date: Fri, 18 Sep 2009 08:44:03 +0200
Message-ID: <4AB32C33.2030302@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com> <aa80ad559c731ca73179956e34b2743d903fbbec.1253088099.git.mstormo@gmail.com> <894136433cc5b03a4b89a1f9c0e4f8a2704222fa.1253088099.git.mstormo@gmail.com> <200909172218.15678.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	msysgit@googlegroups.com, gitster@pobox.com, lznuaa@gmail.com,
	raa.lkml@gmail.com, snaury@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Sep 18 08:44:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoXCz-0002D2-8o
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 08:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbZIRGoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 02:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbZIRGoc
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 02:44:32 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:55435 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbZIRGob (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 02:44:31 -0400
Received: by ewy2 with SMTP id 2so1052276ewy.17
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 23:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=gov/BmmZZuqlnb+LqfyUEO402Gsc2oydXdIBbbNcVxU=;
        b=PL4BOJQ5y8VMWYgaWID1F6DSWu8WwLxGhpWNjfsU5Orj/xE42wjrcyb0d8UzE+6z9/
         fGJY/ysAHVy1NkmfKUwxgcePHKbTyQ+IB6uUmppJINSJBNU/KmV1l4D7bSEq6zUGUwQX
         F7wqidgJ90/r5VyPy8nCM/pzfESZH7MaRER+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=noztfoLV7kkx+gotIc2lgMW44W11zDtk/YTrUSL5w3pm1Djx2a2P8zxfD35YDwH3FK
         gfDbhFrqf27u/R7PYxE9MBKAgBhDInHjqUKRczZcUq6sZXWpt7ikLTY7W8RaSW3DTx20
         +ZO8S7bwhGLdo289MdWIka7u63w1W5Kq1yG1g=
Received: by 10.211.156.19 with SMTP id i19mr697991ebo.79.1253256273635;
        Thu, 17 Sep 2009 23:44:33 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 5sm966663eyf.33.2009.09.17.23.44.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Sep 2009 23:44:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <200909172218.15678.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128787>

Johannes Sixt said the following on 17.09.2009 22:18:
> On Mittwoch, 16. September 2009, Marius Storm-Olsen wrote:
>> This may help us debug issues on Windows, as we now can build Git
>> natively on Windows with both MinGW and MSVC.
>>
>> Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
>> ---
>>  I'm just throwing this one out there. If people think manipulating
>>  the version here, to ease debugging, I don't mind if this patch is
>>  squashed into patch 12.
>>  If people don't like it, just skip this path.
>>
>>  Makefile |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index aa918eb..2c20922 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -878,6 +878,7 @@ ifneq (,$(findstring CYGWIN,$(uname_S)))
>>  	UNRELIABLE_FSTAT = UnfortunatelyYes
>>  endif
>>  ifdef MSVC
>> +	GIT_VERSION := $(GIT_VERSION).MSVC
>>  	pathsep = ;
>>  	NO_PREAD = YesPlease
>>  	NO_OPENSSL = YesPlease
> 
> I like it, but I would not squash it into patch 12.

Ok good, we'll just keep it as is then.
Thanks.

--
.marius
