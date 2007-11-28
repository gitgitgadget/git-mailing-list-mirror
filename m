From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v2] Replace instances of export VAR=VAL with VAR=VAL; export VAR
Date: Wed, 28 Nov 2007 23:53:13 +0100
Message-ID: <85sl2q6kyu.fsf@lola.goethe.zz>
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
	<474D7D92.2000106@viscovery.net>
	<Pine.LNX.4.64.0711281552440.27959@racer.site>
	<85ve7m8iix.fsf@lola.goethe.zz>
	<7vzlwy2dkm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Wincent Colaiuta <win@wincent.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 23:53:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxVmS-0000F1-E8
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 23:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761606AbXK1Ww4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 17:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761569AbXK1Ww4
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 17:52:56 -0500
Received: from mail-in-17.arcor-online.net ([151.189.21.57]:44448 "EHLO
	mail-in-17.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761541AbXK1Wwz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 17:52:55 -0500
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mail-in-17.arcor-online.net (Postfix) with ESMTP id 9D7F72BB776;
	Wed, 28 Nov 2007 23:52:53 +0100 (CET)
Received: from mail-in-14.arcor-online.net (mail-in-14.arcor-online.net [151.189.21.54])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 85920100C5;
	Wed, 28 Nov 2007 23:52:53 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-037-196.pools.arcor-ip.net [84.61.37.196])
	by mail-in-14.arcor-online.net (Postfix) with ESMTP id 5735A187867;
	Wed, 28 Nov 2007 23:52:53 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id DDC6E1C4D3AA; Wed, 28 Nov 2007 23:53:13 +0100 (CET)
In-Reply-To: <7vzlwy2dkm.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 28 Nov 2007 14:46:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4948/Wed Nov 28 21:42:33 2007 on mail-in-14.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66452>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> It might be POSIX, but there are shells that do not like the
>>> expression 'export VAR=VAL'.
>>
>> As long as we have no positive report about any such shell that
>> _otherwise_ would be usable for git, why bother?
>
> I thought somebody already mention that ash mishandles "export VAR=VAL"
> but otherwise Ok.

dak@lola:~$ ash
$ export JUNK=woozle
$ sh -c 'echo $JUNK'
woozle
$ exit
dak@lola:~$ dash
$ export JUNK=woozle
$ sh -c 'echo $JUNK'
woozle
$ exit

What problem are we talking about exactly, and with what shell?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
