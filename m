From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Reporting bugs and bisection
Date: Mon, 14 Apr 2008 11:24:44 -0700
Organization: Intel
Message-ID: <20080414112444.2504b48d@laptopd505.fenrus.org>
References: <47FEADCB.7070104@rtr.ca>
	<20080413121831.d89dd424.akpm@linux-foundation.org>
	<20080413202118.GA29658@2ka.mipt.ru>
	<200804132233.50491.rjw@sisk.pl>
	<20080413205406.GA9190@2ka.mipt.ru>
	<48028830.6020703@earthlink.net>
	<alpine.DEB.1.10.0804131546370.9318@asgard>
	<20080414043939.GA6862@1wt.eu>
	<20080414053943.GU9785@ZenIV.linux.org.uk>
	<20080413232441.e216a02c.akpm@linux-foundation.org>
	<20080414072328.GW9785@ZenIV.linux.org.uk>
	<20080414010412.c42dc560.akpm@linux-foundation.org>
	<20080414074349.24fa90f8@laptopd505.fenrus.org>
	<20080414105152.9cc06fab.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Willy Tarreau <w@1wt.eu>,
	david@lang.hm, Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Tilman Schmidt <tilman@imap.cc>,
	Valdis.Kletnieks@vt.edu, Mark Lord <lkml@rtr.ca>,
	David Miller <davem@davemloft.net>, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	netdev@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: netdev-owner@vger.kernel.org Mon Apr 14 20:36:15 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlTTF-0005PQ-Oh
	for linux-netdev-2@gmane.org; Mon, 14 Apr 2008 20:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325AbYDNSbN (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Mon, 14 Apr 2008 14:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756310AbYDNSbN
	(ORCPT <rfc822;netdev-outgoing>); Mon, 14 Apr 2008 14:31:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50258 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005AbYDNSbL (ORCPT
	<rfc822;netdev@vger.kernel.org>); Mon, 14 Apr 2008 14:31:11 -0400
Received: from [192.102.209.1] (helo=laptopd505.fenrus.org)
	by pentafluge.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1JlTR0-0006Q2-5r; Mon, 14 Apr 2008 18:29:42 +0000
In-Reply-To: <20080414105152.9cc06fab.akpm@linux-foundation.org>
X-Mailer: Claws Mail 3.2.0 (GTK+ 2.12.5; i386-redhat-linux-gnu)
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79524>

On Mon, 14 Apr 2008 10:51:52 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:


> Well OK.  But I don't think we can generalise from oops-causing bugs

including all WARN_ON's and various other kernel backtrace-causing bugs.


> all the way to all bugs.  Very few bugs actually cause oopses, and
> oopses tend to be the thing which developers will zoom in on and pay
> attention to.

maybe.
> 
> If we had metrics on "time goes backwards" or anything containing
> "ASUS", things might be different.

Sounds really like we need to add more strategic WARN_ON's and other diagnostics in 
the kernel to track these issues down.


Because another thing that I found so far is that what hits LKML is by far not representative
on what happens for users. The most obvious example was the whole input layer refcounting disaster
in 2.6.25-rc; this was about 1/3rd of TOTAL reports for a few weeks in a row, but there
was hardly an LKML posting for it (in fact there was only 1 half one).
We need diagnostics and stuff the kernel spits out so that automated tools can detect these,
otherwise we'll very likely not get good information on what is actually wrong with the kernel.


In case you want to see the 2.6.25-rc data, the top 100 list is at
http://www.kerneloops.org/twentyfive.html

(I'm still working on annotating the individual items, but since there's 100
that does take time)

-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
