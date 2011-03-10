From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/3] git-log.txt,rev-list-options.txt: put option blocks
 in proper order
Date: Thu, 10 Mar 2011 08:50:07 +0100
Message-ID: <4D7882AF.4010705@drmicha.warpmail.net>
References: <4D75E92C.1090506@drmicha.warpmail.net> <f34ebc6211ead3fa6698ff9b7a92903723715a28.1299572814.git.git@drmicha.warpmail.net> <7vbp1j985v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 08:53:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxags-0004RD-Lc
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 08:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054Ab1CJHxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 02:53:41 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:40295 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750754Ab1CJHxk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 02:53:40 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 33984208B4;
	Thu, 10 Mar 2011 02:53:40 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 10 Mar 2011 02:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=24K9uH7xrCwurvjOUUoZYfrvQOM=; b=geS5xBZ53pWAx9RAaIV7iA9N7ViFo/3quTq19n/+YaPUX5dwBiKPEwIjpxVMCvM4xAyEKJ3Tp06bLX+pSVZd0wLX9YeAFavN25lnem7slnU+Dq/L4O9H/yZuq7bzf5HzeHjbXHde/sjNsUP7OiyK5hIp1GCcEXj1punbQrkHAKQ=
X-Sasl-enc: R3fH5HUO0+nzYwlc3MPnjk0ln7gSdkC8/Ly+5XAEDE7x 1299743619
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 98D4B440682;
	Thu, 10 Mar 2011 02:53:39 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <7vbp1j985v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168794>

Junio C Hamano venit, vidit, dixit 10.03.2011 00:38:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
>> index 48c1715..6ae57dc 100644
>> --- a/Documentation/git-log.txt
>> +++ b/Documentation/git-log.txt
>> @@ -77,12 +77,12 @@ Common diff options
>>  ~~~~~~~~~~~~~~~~~~~
>>  
>>  :git-log: 1
>> -include::diff-options.txt[]
>> -
>>  include::rev-list-options.txt[]
>>  
>>  include::pretty-formats.txt[]
>>  
>> +include::diff-options.txt[]
>> +
>>  include::diff-generate-patch.txt[]
> 
> This is wrong.  The title "Common diff options", telling the AsciiDoc that
> we are formatting for git-log manual page with ":git-log: 1" and inclusion
> of diff-options.txt form a single group.  With your patch, the "Common
> diff options" section will become ampty and makes AsciiDoc barf.
> 
> You would need _at least_ something like the attached patch on top, which
> for now I'll squash in.

Didn't I say "squashable series"? ;)

Seriously, I'm sorry for this blunder. I usually build Doc before
submitting Doc patches (and here more careful reading should have sufficed).

>  Documentation/git-log.txt |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 6ae57dc..c43aa43 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -73,14 +73,14 @@ produced by --stat etc.
>  	to be prefixed with "\-- " to separate them from options or
>  	refnames.
>  
> -Common diff options
> -~~~~~~~~~~~~~~~~~~~
> -
> -:git-log: 1
>  include::rev-list-options.txt[]
>  
>  include::pretty-formats.txt[]
>  
> +Common diff options
> +-------------------
> +
> +:git-log: 1
>  include::diff-options.txt[]
>  
>  include::diff-generate-patch.txt[]

Thanks, that's what I meant, and I also meant to mark 3/3 as PATCH/RFC
because it's a larger change in the Doc for a main command.

Michael
