From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Replace instances of export VAR=VAL with VAR=VAL; export VAR
Date: Wed, 28 Nov 2007 15:41:07 +0100
Message-ID: <85aboya0vw.fsf@lola.goethe.zz>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
	<C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr>
	<D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com>
	<CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com>
	<474AC136.8060906@viscovery.net>
	<451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com>
	<Pine.LNX.4.64.0711261340470.27959@racer.site>
	<97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com>
	<7vir3m94ku.fsf@gitster.siamese.dyndns.org>
	<50645A3B-C5F0-4A99-A2B8-AD9251024244@wincent.com>
	<7v1waa7lcv.fsf@gitster.siamese.dyndns.org>
	<1570EAD5-9F47-4105-B3DA-49CA6FA57369@wincent.com>
	<Pine.LNX.4.64.0711281355460.27959@racer.site>
	<474D7956.8050401@viscovery.net>
	<Pine.LNX.4.64.0711281428180.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 15:41:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxO6b-0004UL-O9
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 15:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758816AbXK1OlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 09:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755798AbXK1OlJ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 09:41:09 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:49087 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755978AbXK1OlG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 09:41:06 -0500
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 7D17915B52C;
	Wed, 28 Nov 2007 15:41:05 +0100 (CET)
Received: from mail-in-16.arcor-online.net (mail-in-16.arcor-online.net [151.189.21.56])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 5A1DA345BF1;
	Wed, 28 Nov 2007 15:41:05 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-037-196.pools.arcor-ip.net [84.61.37.196])
	by mail-in-16.arcor-online.net (Postfix) with ESMTP id 1FD9E1A4350;
	Wed, 28 Nov 2007 15:40:51 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 90FAE1C4D3AA; Wed, 28 Nov 2007 15:41:07 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.0711281428180.27959@racer.site> (Johannes
	Schindelin's message of "Wed, 28 Nov 2007 14:29:11 +0000 (GMT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4936/Wed Nov 28 11:55:15 2007 on mail-in-16.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66348>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 28 Nov 2007, Johannes Sixt wrote:
>
>> Johannes Schindelin schrieb:
>> > -			s/.*/export GIT_'$uid'_NAME='\''&'\''/p
>> > +			s/.*/GIT_'$uid'_NAME='\''&'\''\nexport
>> > GIT_'$uid'_NAME/p
>> 
>> Recently there was a report that \n in the substitution side of s/// is not
>> supported by all seds :-(
>
> Okay, how about replacing the line with
>
> +			s/.*/GIT_'$uid'_NAME='\''&'\''\
> +export GIT_'$uid'_NAME/p
>
> Hmm?  (It works here.)

Do we really want to replace code which is not as far as I know known to
fail under any of the supported shells with something which quite
possibly relies on particular sed implementations (and we have fewer
portability guarantees or even experience about sed than about the
shell, right?)?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
