From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: StGIT cannot import properly from stdin
Date: Thu, 22 Sep 2005 16:05:50 +0200
Message-ID: <4332BA3E.2080607@drzeus.cx>
References: <433107C7.60901@drzeus.cx>	<b0943d9e05092101033dd5d366@mail.gmail.com>	<433290A5.5070008@drzeus.cx> <tnxhdcd2tfn.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 16:09:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIRhx-0002fm-D1
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 16:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbVIVOFu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 10:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbVIVOFu
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 10:05:50 -0400
Received: from [85.8.12.41] ([85.8.12.41]:10627 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1030360AbVIVOFt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 10:05:49 -0400
Received: from [192.168.128.82] (alcatraz.cendio.se [::ffff:193.12.253.67])
  (AUTH: PLAIN drzeus, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by smtp.drzeus.cx with esmtp; Thu, 22 Sep 2005 16:05:48 +0200
  id 00062716.4332BA3C.00002883
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <tnxhdcd2tfn.fsf@arm.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9118>

Catalin Marinas wrote:

>
>Unfortunately, if the '---' line is missing, it consumes all the input
>lines. Is this the case with your patch?
>
>  
>

Nope. It consumes the correct ammount of lines. The problem is that I
have to give it a kick (^D) to start things twice. The first for
__parse_patch() and the second for _input(). I put some debug-prints in
there and the for-loops will not start executing on the first complete
line, only EOF.

>>If you would cache the input to a file (or memory) you would remove both
>>of these problems.
>>    
>>
>
>True, but it requires more work than simply writing the patch to a
>file and reading it twice.
>
>  
>

If it supports everything when given a filename then shouldn't adding a
preprocessing step to dump stdin to disk give the same code path?

Rgds
Pierre
