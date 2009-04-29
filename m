From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Workaround for ai_canonname sometimes coming back as null
Date: Thu, 30 Apr 2009 00:04:14 +0200
Message-ID: <81b0412b0904291504k3261df5fl692d09c6c761887e@mail.gmail.com>
References: <9C355DCC-0240-4B9E-83CA-083B51C2E34C@gmail.com>
	 <81b0412b0904291455n47f83e9ftcbdec0ff1c0ea03@mail.gmail.com>
	 <6B7EA51D-8412-4E6A-BA7B-156FD5B755E8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Augie Fackler <durin42@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 00:05:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzHta-0000jo-7x
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 00:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbZD2WER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 18:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754234AbZD2WER
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 18:04:17 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:36699 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152AbZD2WEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 18:04:16 -0400
Received: by fxm2 with SMTP id 2so1470303fxm.37
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 15:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DVu4ChwJMvECBPbOR3Hbj0PLwpoc/iQ7EFQ7KFZwwfA=;
        b=kFlUsaxMXKrkqlX6Gs2Gf+rxVGPbGmzu/899iX+dtHBBt4MKjPkveEacxcrZCARUBr
         aAIquKmeaIDK6PWD8aNv52PVoDJIrDuFEQIzfnjxjw8ME+MxG/rVij1ueIerB89WCWK4
         3oIhvly0rnRguuNfKdXEFOxQ1LQ4FPVqSU1x0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J26AEeBYEiar+tOm0iinvTgrSApBs3+mdECqi9DAcea+e83CgSeklM1MSPKthKM1vp
         LC22ZO+a/Yv81bNGD2HlbUMsIzP40TXtZvtO8cru+pe/SFStF9DqDgbQ9xAVm3qwzBEL
         KFfMu18en47bn48Y+lV2mkZcbofFgxnjmPkRg=
Received: by 10.204.62.135 with SMTP id x7mr763053bkh.95.1241042654579; Wed, 
	29 Apr 2009 15:04:14 -0700 (PDT)
In-Reply-To: <6B7EA51D-8412-4E6A-BA7B-156FD5B755E8@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117963>

2009/4/29 Augie Fackler <durin42@gmail.com>:
>>
>> This last line will crash some lines down, when canon_hostname is free'd:
>>
>
> Odd, because I'm running with that exact code and not seeing the problem.

Pure luck (see the message regarding "the line above". The first was bogus,
of course. It is in the other leg of #ifndef NO_IPV6). The "line above" will
crash should you have more than one element in gai list.
