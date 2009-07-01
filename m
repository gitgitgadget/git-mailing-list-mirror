From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/2] git-send-email.perl: Don't add header
 "In-Reply-To:" when --no-chain-reply-to set
Date: Tue, 30 Jun 2009 23:27:33 -0700
Message-ID: <1246429653.6259.111.camel@Joe-Laptop.home>
References: <cover.1246404999.git.joe@perches.com>
	 <a19204c574f407d98be74d54cfd899b43fdc7d26.1246404999.git.joe@perches.com>
	 <200907010818.57050.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Wed Jul 01 08:27:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLtIH-0008OB-AC
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 08:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbZGAG1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 02:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbZGAG1e
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 02:27:34 -0400
Received: from 136-022.dsl.LABridge.com ([206.117.136.22]:1341 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbZGAG1d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 02:27:33 -0400
Received: from [192.168.1.158] ([192.168.1.158])
	by mail.perches.com (8.9.3/8.9.3) with ESMTP id XAA26215;
	Tue, 30 Jun 2009 23:27:10 -0700
In-Reply-To: <200907010818.57050.markus.heidelberg@web.de>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122566>

On Wed, 2009-07-01 at 08:18 +0200, Markus Heidelberg wrote:
> Joe Perches, 01.07.2009:
> > using
> >   git format-patch --thread=shallow -o <foo>
> > and
> >   git send-email --no-thread --no-chain-reply-to <foo>
> 
> I guess you meant --thread here.

Actually, I did mean --no-thread.
If format-patch does the threading, send-email shouldn't.

> > duplicates the headers
> > 
> >   In-Reply-To:
> >   References:
> 
> You should run at least the test from the test suite for the particular
> command you change. Test 49 (threading but no chain-reply-to) from t9001
> now fails.
> 
> That means, this will fail now (covered by test 49):
> 
>   git format-patch -o <foo>
>   git send-email --thread --no-chain-reply-to <foo>
> 
> and also this (not covered by any test, maybe we should add one):
> 
>   git format-patch -o <foo>
>   git send-email --thread --chain-reply-to <foo>

I didn't know the tests existed, thanks.
I'll investigate a bit more.

cheers, Joe
