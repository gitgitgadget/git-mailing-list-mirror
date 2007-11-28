From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v2] Replace instances of export VAR=VAL with VAR=VAL; export VAR
Date: Thu, 29 Nov 2007 00:10:34 +0100
Message-ID: <85mysy6k5x.fsf@lola.goethe.zz>
References: <7v1waa7lcv.fsf@gitster.siamese.dyndns.org>
	<1570EAD5-9F47-4105-B3DA-49CA6FA57369@wincent.com>
	<Pine.LNX.4.64.0711281355460.27959@racer.site>
	<474D7956.8050401@viscovery.net>
	<Pine.LNX.4.64.0711281428180.27959@racer.site>
	<474D7D92.2000106@viscovery.net>
	<Pine.LNX.4.64.0711281552440.27959@racer.site>
	<85ve7m8iix.fsf@lola.goethe.zz>
	<7vzlwy2dkm.fsf@gitster.siamese.dyndns.org>
	<85sl2q6kyu.fsf@lola.goethe.zz>
	<20071128230203.GA13964@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Wincent Colaiuta <win@wincent.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 29 00:10:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxW3C-0006nk-6S
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 00:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823AbXK1XKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 18:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755690AbXK1XKT
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 18:10:19 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:41592 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755385AbXK1XKR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 18:10:17 -0500
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id E299815BA81;
	Thu, 29 Nov 2007 00:10:15 +0100 (CET)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id A8EF42BEB8F;
	Thu, 29 Nov 2007 00:10:15 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-037-196.pools.arcor-ip.net [84.61.37.196])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 7CF8835E6AA;
	Thu, 29 Nov 2007 00:10:15 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 2AFF41C4D3AA; Thu, 29 Nov 2007 00:10:33 +0100 (CET)
In-Reply-To: <20071128230203.GA13964@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 28 Nov 2007 18:02:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4948/Wed Nov 28 21:42:33 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66458>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 28, 2007 at 11:53:13PM +0100, David Kastrup wrote:
>
>> dak@lola:~$ ash
>> $ export JUNK=woozle
>> $ sh -c 'echo $JUNK'
>> woozle
>> $ exit
>> dak@lola:~$ dash
>> $ export JUNK=woozle
>> $ sh -c 'echo $JUNK'
>> woozle
>> $ exit
>> 
>> What problem are we talking about exactly, and with what shell?
>
> $ uname -sr
> FreeBSD 6.1-RELEASE-p17-jc1
> $ /bin/sh
> $ FOO='with spaces'
> $ echo $FOO
> with spaces
> $ OK=$FOO; export OK
> $ sh -c 'echo $OK'
> with spaces
> $ export BAD=$FOO
> $ sh -c 'echo $BAD'
> with
> $ echo $BAD
> with

I'd write
export BAD="$FOO"
anyhow.  And also OK="$FOO" by the way.  The alternatives scare me.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
