From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Remove duplicate pathspecs from ls-files command line
Date: Wed, 29 Aug 2007 23:36:20 +0200
Message-ID: <85tzqic9bf.fsf@lola.goethe.zz>
References: <20070829081122.GA604@piper.oerlikon.madduck.net>
	<20070829194410.GA11824@steel.home>
	<7v4piioyu1.fsf@gitster.siamese.dyndns.org>
	<20070829211519.GE11824@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>,
	439992-quiet@bugs.debian.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 23:36:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQVDH-0008Up-RL
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 23:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741AbXH2Vgb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 17:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752345AbXH2Vgb
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 17:36:31 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:56639 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751681AbXH2Vga (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Aug 2007 17:36:30 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 9BFE14C625;
	Wed, 29 Aug 2007 23:36:29 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id 2528D2C6B7D;
	Wed, 29 Aug 2007 23:36:29 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-014-108.pools.arcor-ip.net [84.61.14.108])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id E0C9228ABA5;
	Wed, 29 Aug 2007 23:36:20 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 7C7171C3C7A6; Wed, 29 Aug 2007 23:36:20 +0200 (CEST)
In-Reply-To: <20070829211519.GE11824@steel.home> (Alex Riesen's message of "Wed\, 29 Aug 2007 23\:15\:19 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4107/Wed Aug 29 18:16:42 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56987>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Wed, Aug 29, 2007 22:44:22 +0200:
>> 
>> That loop is plain old O(n^2) that penalizes everybody.
>> 
>
> Maybe something in pathspec matching code could be reused to notice
> the duplications? It has to go through all of them anyway...

Does anything speak against sorting the pathspecs?  That is an O(n log
n) operation, and dup detection is trivial afterwards.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
