From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
Subject: Re: Reporting bugs and bisection
Date: Mon, 14 Apr 2008 22:30:55 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0804142221480.7090@wrl-59.cs.helsinki.fi>
References: <47FEADCB.7070104@rtr.ca> <20080413121831.d89dd424.akpm@linux-foundation.org>
 <20080413202118.GA29658@2ka.mipt.ru> <200804132233.50491.rjw@sisk.pl>
 <20080413205406.GA9190@2ka.mipt.ru> <48028830.6020703@earthlink.net>
 <alpine.DEB.1.10.0804131546370.9318@asgard> <20080414043939.GA6862@1wt.eu>
 <20080414053943.GU9785@ZenIV.linux.org.uk> <20080413232441.e216a02c.akpm@linux-foundation.org>
 <20080414072328.GW9785@ZenIV.linux.org.uk> <20080414010412.c42dc560.akpm@linux-foundation.org>
 <20080414074349.24fa90f8@laptopd505.fenrus.org> <20080414105152.9cc06fab.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Willy Tarreau <w@1wt.eu>,
	david@lang.hm, Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Tilman Schmidt <tilman@imap.cc>,
	Valdis.Kletnieks@vt.edu, Mark Lord <lkml@rtr.ca>,
	David Miller <davem@davemloft.net>, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, Jeff Garzik <jeff@garzik.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	Netdev <netdev@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Arjan van de Ven <arjan@infradead.org>
X-From: git-owner@vger.kernel.org Mon Apr 14 21:31:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlUP6-00076q-6L
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 21:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762443AbYDNTbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 15:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760971AbYDNTa6
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 15:30:58 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:40044 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbYDNTa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 15:30:57 -0400
Received: from wrl-59.cs.helsinki.fi (wrl-59.cs.helsinki.fi [128.214.166.179])
  (AUTH: PLAIN cs-relay, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by mail.cs.helsinki.fi with esmtp; Mon, 14 Apr 2008 22:30:55 +0300
  id 00067D99.4803B0EF.00000A86
Received: by wrl-59.cs.helsinki.fi (Postfix, from userid 50795)
	id B7FCC16B164; Mon, 14 Apr 2008 22:30:55 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
	by wrl-59.cs.helsinki.fi (Postfix) with ESMTP id B561C16B5B9;
	Mon, 14 Apr 2008 22:30:55 +0300 (EEST)
X-X-Sender: ijjarvin@wrl-59.cs.helsinki.fi
In-Reply-To: <20080414105152.9cc06fab.akpm@linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79527>

On Mon, 14 Apr 2008, Andrew Morton wrote:

> On Mon, 14 Apr 2008 07:43:49 -0700 Arjan van de Ven <arjan@infradead.org> wrote:
> 
> > I'll be writing a report with more details about this soon with more analysis and statistics
> > (I'll be looking at more detail around the top 25 issues, when they got introduced, when they got fixed etc)
> 
> Well OK.  But I don't think we can generalise from oops-causing bugs all
> the way to all bugs.  Very few bugs actually cause oopses, and oopses tend
> to be the thing which developers will zoom in on and pay attention to.
> 
> If we had metrics on "time goes backwards" or anything containing "ASUS",
> things might be different.

Even oopses have pitfalls, like in 25-rcs where those WARN_ON TCP 
backtraces were due to three different bugs (there might be fourth one 
still remaining). ...kerneloops.org didn't even make difference between 
different WARN_ONs in a function though that would have helped only little 
in the case of 25-rc TCP because of different bugs causing failures in the 
same invariant.

-- 
 i.
