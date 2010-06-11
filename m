From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] read_cache: cast types from stat to ce_cache
Date: Fri, 11 Jun 2010 15:32:04 +0200
Message-ID: <4C123AD4.6070606@drmicha.warpmail.net>
References: <a06cc84698f174d914350d6fd6e6b4739d22aa45.1276161176.git.git@drmicha.warpmail.net> <7vmxv2nar5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 15:32:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON4LX-0008Tb-3W
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 15:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760303Ab0FKNc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 09:32:27 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45260 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756353Ab0FKNcZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jun 2010 09:32:25 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CDD2BF8CC0;
	Fri, 11 Jun 2010 09:31:55 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 11 Jun 2010 09:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=txgzCfZRHil4/3BAilVkllgIb9o=; b=kGHVjf7G8/ok1VV/cHoDvALSQ6UXCreYdOsGa5tH2yc1pIgjD1BTfSItF6BtaL9rd1Ba0uhhWt73csi2t3Q0ekl3N98PqOVWIIzGA8A7uqrTreid3vDXmShUkc5vq4N5Q70ZZTwQLBE5vcxgPNvTcWfwL3TQe15pQ+QSyfmg2Jc=
X-Sasl-enc: PdBrdlnk1Yfpm4FkHQUC6tTZffONmNRznDX6HUFWV3Fi 1276263113
Received: from localhost.localdomain (p5485A0CC.dip0.t-ipconnect.de [84.133.160.204])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 91A054DCFD8;
	Fri, 11 Jun 2010 09:31:53 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100610 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <7vmxv2nar5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148946>

Junio C Hamano venit, vidit, dixit 10.06.2010 17:54:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> -	ce->ce_dev = st->st_dev;
>> -	ce->ce_ino = st->st_ino;
>> -	ce->ce_uid = st->st_uid;
>> -	ce->ce_gid = st->st_gid;
>> -	ce->ce_size = st->st_size;
>> +	ce->ce_dev = (unsigned int)st->st_dev;
>> +	ce->ce_ino = (unsigned int)st->st_ino;
>> +	ce->ce_uid = (unsigned int)st->st_uid;
>> +	ce->ce_gid = (unsigned int)st->st_gid;
>> +	ce->ce_size = (unsigned int)st->st_size;
> 
> I haven't had my morning coffee yet, but wouldn't the conversion be
> automatic by assignment anyway?

Well, we do cast from dev_t etc. to unsigned int in all other places in
read_cache.c.

In any case, enjoy your coffee :)

Michael
