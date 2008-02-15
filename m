From: Jan Holesovsky <kendy@suse.cz>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 15 Feb 2008 10:34:45 +0100
Message-ID: <200802151034.46236.kendy@suse.cz>
References: <200802081828.43849.kendy@suse.cz> <alpine.LSU.1.00.0802122036150.3870@racer.site> <alpine.LSU.1.00.0802141917420.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 15 10:35:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPwyk-0002Id-EM
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 10:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbYBOJev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 04:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbYBOJev
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 04:34:51 -0500
Received: from styx.suse.cz ([82.119.242.94]:49326 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751475AbYBOJeu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 04:34:50 -0500
Received: from one.suse.cz (one.suse.cz [10.20.1.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.suse.cz (Postfix) with ESMTP id 2A80D628096;
	Fri, 15 Feb 2008 10:34:41 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <alpine.LSU.1.00.0802141917420.30505@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73946>

Hi Johannes,

On Thursday 14 of February 2008, Johannes Schindelin wrote:

> The result is:
>
> $ ls -la objects/pack/pack-e4dc6da0a10888ec4345490575efc587b7523b45.pack
> -rwxrwxrwx 1 root root 1638490531 2008-02-14 17:51
> objects/pack/pack-e4dc6da0a10888ec4345490575efc587b7523b45.pack
>
> 1.6G looks much better than 2.4G, wouldn't you say?  Jan, if you want it,
> please give me a place to upload it to.

Thank you!  In the meantime, I happened to produce something similar.  
Unfortunately even mine was too late for another round of tests to present it 
in our git vs. svn comparison (with todays deadline) - so we just mentioned 
in the report that the tested repository still had reserves [but the numbers 
were quite nice even with the 2.5G one ;-)].

> ll minimal3.git/objects/pack/
celkem 1636608
-r--r--r-- 1 kendy users   59264432 2008-02-10 15:22 
pack-909b501d3d673f10a66adfefdf8371933e7a6f3e.idx
-r--r--r-- 1 kendy users 1614968445 2008-02-10 15:22 
pack-909b501d3d673f10a66adfefdf8371933e7a6f3e.pack

> ll minimal4.git/objects/pack/
celkem 1644160
-r--r--r-- 1 kendy users   59264432 2008-02-11 16:09 
pack-909b501d3d673f10a66adfefdf8371933e7a6f3e.idx
-rw-r--r-- 1 kendy users          0 2008-02-11 16:29 
pack-909b501d3d673f10a66adfefdf8371933e7a6f3e.keep
-r--r--r-- 1 kendy users 1622697708 2008-02-11 16:09 
pack-909b501d3d673f10a66adfefdf8371933e7a6f3e.pack

The 'minimal3' case was with '--window=250 --depth=250', 'minimal4' was 
with '--window=250 --depth=50'

I tried the --depth=50 because I read 'making it too deep affects the 
performance on the unpacker side' in the man page.  How big the difference 
could be in practice, please?

Regards,
Jan
