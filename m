From: David Kastrup <dak@gnu.org>
Subject: Re: 'git fast-export' is crashing on the gcc repo
Date: Wed, 12 Dec 2007 09:46:42 +0100
Message-ID: <854peo8fm5.fsf@lola.goethe.zz>
References: <alpine.LFD.0.99999.0712111509270.555@xanadu.home>
	<alpine.LFD.0.99999.0712111703380.555@xanadu.home>
	<20071212013828.GC19857@steel.home>
	<alpine.LFD.0.99999.0712112045040.555@xanadu.home>
	<7v3au89utj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 09:47:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2NF6-0004zy-BG
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 09:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756381AbXLLIqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 03:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756314AbXLLIqh
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 03:46:37 -0500
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:36471 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756036AbXLLIqg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2007 03:46:36 -0500
Received: from mail-in-20-z2.arcor-online.net (mail-in-20-z2.arcor-online.net [151.189.8.85])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 576F1326920;
	Wed, 12 Dec 2007 09:46:35 +0100 (CET)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-20-z2.arcor-online.net (Postfix) with ESMTP id 43DEB10785F;
	Wed, 12 Dec 2007 09:46:35 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-048-119.pools.arcor-ip.net [84.61.48.119])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 2BCF419B323;
	Wed, 12 Dec 2007 09:46:11 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id C72391C4CE33; Wed, 12 Dec 2007 09:46:42 +0100 (CET)
In-Reply-To: <7v3au89utj.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 12 Dec 2007 00:32:56 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/5099/Wed Dec 12 08:17:10 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68014>

Junio C Hamano <gitster@pobox.com> writes:

> Nicolas Pitre <nico@cam.org> writes:
>
>> On Wed, 12 Dec 2007, Alex Riesen wrote:
>>
>>> Nicolas Pitre, Tue, Dec 11, 2007 23:06:42 +0100:
>>> > 
>>> > Well, ignore the above.  It seems that most of stdio doesn't set errno 
>>> > so the above is crap.
>>> > 
>>> 
>>> Well, it had no reason to in this case. It's not an error.
>>> It does not even have to do a syscall.
>>
>> Which is why I later agreed with your patch.
>
> Still, I like your swapping of size and nmemb parameters, regardless
> of the "don't bother calling fwrite(3) if size is zero" fix.

I don't.  Far too obscure, looks like an unintentional wart waiting to
be corrected.

I think that the explicit test is the way to go here.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
