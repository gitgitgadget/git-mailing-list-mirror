From: Geert Bosch <bosch@adacore.com>
Subject: Re: [PATCH] Support 64-bit indexes for pack files.
Date: Tue, 27 Feb 2007 15:25:39 -0500
Message-ID: <F4EA27AD-EF1C-4BF2-8D52-945E0AE51006@adacore.com>
References: <200702261540.27080.ttelford.groups@gmail.com> <20070226235510.GF1639@spearce.org> <alpine.LRH.0.82.0702261916560.29426@xanadu.home> <20070227003118.GH1639@spearce.org> <alpine.LRH.0.82.0702262306100.29426@xanadu.home> <79B129C3-C1B5-43E3-97DA-1ADC70642B88@adacore.com> <alpine.LRH.0.82.0702270002100.29426@xanadu.home> <5FE0C988-0DA8-4BFB-8F0C-42F97808E6F8@adacore.com> <Pine.LNX.4.63.0702272102440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Troy Telford <ttelford.groups@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:26:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM8tw-0001SL-RQ
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:26:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbXB0UZr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbXB0UZq
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:25:46 -0500
Received: from nile.gnat.com ([205.232.38.5]:34615 "EHLO nile.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703AbXB0UZm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:25:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 673E248CCA8;
	Tue, 27 Feb 2007 15:25:41 -0500 (EST)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 05584-01-9; Tue, 27 Feb 2007 15:25:41 -0500 (EST)
Received: from [205.232.38.124] (potomac.gnat.com [205.232.38.124])
	by nile.gnat.com (Postfix) with ESMTP id 0E67B48CBD0;
	Tue, 27 Feb 2007 15:25:41 -0500 (EST)
In-Reply-To: <Pine.LNX.4.63.0702272102440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40786>


On Feb 27, 2007, at 15:05, Johannes Schindelin wrote:
> On Tue, 27 Feb 2007, Geert Bosch wrote:
>
>> The object-count at the beginning of the pack is a little strange for
>> local on-disk pack files, as it is data that can easily be derived.
>
> The SHA1 is also easily derived. So think of it as a doubly secure  
> way to
> ensure integrity.
>
> Remember, there were some people unable to accept that SHA1  
> collisions are
> _unlikely_...

Ah, you include the count because you don't trust the SHA1
and now you can count that you got the right number of objects ;-)

It's just that I don't see a use for the count in a local on-disk
pack. In these cases we'll always have an index. We can keep the
current protocol for sending/receiving packs, no need to ever upgrade
to v4 there.

   -Geert
