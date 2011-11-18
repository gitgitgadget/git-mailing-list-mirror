From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH] honour GIT_ASKPASS for querying username in git-svn
Date: Fri, 18 Nov 2011 14:30:12 +0100
Message-ID: <4EC65DE4.90005@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 18 14:30:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RROWH-0002i5-Mz
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 14:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757471Ab1KRNaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 08:30:11 -0500
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:24172 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757031Ab1KRNaK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 08:30:10 -0500
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 67A36422073;
	Fri, 18 Nov 2011 14:30:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=Tfu82NB+2RyAe6UBVrVH29EFNLY=; b=rzQnsIHgLRTNaNvzioPYLPs+xO7u
	lNltmVHWTsugeg/lORC0bIN0Z3j9b8Y7LcFJykfVd1HT2GBwaIllaAp8ws5csHR9
	CqoH9cSL3cPumeIu7J+AvRao4EFbwJfvIyT7KuVTVkVReGCNBy7jLjHuIs4z/Iy4
	dN/+4vICnZERxGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=LKabGDde7pF1l3JM6daC/CVyoqlZ91G5fYWRiyyP8fBTTyBYpIaIDWq
	K3c9rccthJ2V4BcHTZeS/nS3QWlDYsJ8ihy/WYhpIA4kIAkgcqIDe2HG3n2c6JNT
	qe6NrHpVMOULJ/CeKCbn+JpUh61XGqiCW67GYQHqu00opXn03tWc=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 0E354422065;
	Fri, 18 Nov 2011 14:30:08 +0100 (CET)
Received: from [139.174.242.80] (account sstri@tu-clausthal.de [139.174.242.80] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.2)
  with ESMTPSA id 23547065; Fri, 18 Nov 2011 14:30:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
X-Enigmail-Version: 1.3.3
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185658>

Am 18.11.2011 12:36 schrieb Erik Faye-Lund:
> On Thu, Nov 17, 2011 at 4:15 PM, Sven Strickroth
> <sven.strickroth@tu-clausthal.de> wrote:
>> From 8e576705ca949c32ff22d3216006073ee70652eb Mon Sep 17 00:00:00 2001
>> From: Sven Strickroth <email@cs-ware.de>
>> Date: Thu, 17 Nov 2011 15:43:25 +0100
>> Subject: [PATCH 1/2] honour GIT_ASKPASS for querying username
>>
>> git-svn reads usernames from an interactive terminal.
>> This behavior cause GUIs to hang waiting for git-svn to
>> complete (http://code.google.com/p/tortoisegit/issues/detail?id=967).
>>
>> Also see commit 56a853b62c0ae7ebaad0a7a0a704f5ef561eb795.
>>
>> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> 
> IIUC, GIT_ASKPASS is intended for passwords and not usernames. Won't
> this cause console-users to not see their username prompted anymore?

git also asks for username using the GIT_ASKPASS tool (if GIT_ASKPASS is
set).

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
