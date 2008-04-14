From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Reporting bugs and bisection
Date: Sun, 13 Apr 2008 23:24:41 -0700
Message-ID: <20080413232441.e216a02c.akpm@linux-foundation.org>
References: <47FEADCB.7070104@rtr.ca>
	<20080413121831.d89dd424.akpm@linux-foundation.org>
	<20080413202118.GA29658@2ka.mipt.ru>
	<200804132233.50491.rjw@sisk.pl>
	<20080413205406.GA9190@2ka.mipt.ru>
	<48028830.6020703@earthlink.net>
	<alpine.DEB.1.10.0804131546370.9318@asgard>
	<20080414043939.GA6862@1wt.eu>
	<20080414053943.GU9785@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Willy Tarreau <w@1wt.eu>, david@lang.hm,
	Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Tilman Schmidt <tilman@imap.cc>,
	Valdis.Kletnieks@vt.edu, Mark Lord <lkml@rtr.ca>,
	David Miller <davem@davemloft.net>, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	netdev@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
X-From: netdev-owner@vger.kernel.org Mon Apr 14 08:26:24 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlI91-0007Y5-QK
	for linux-netdev-2@gmane.org; Mon, 14 Apr 2008 08:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315AbYDNGZk (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Mon, 14 Apr 2008 02:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754190AbYDNGZk
	(ORCPT <rfc822;netdev-outgoing>); Mon, 14 Apr 2008 02:25:40 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39643 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753083AbYDNGZj (ORCPT
	<rfc822;netdev@vger.kernel.org>); Mon, 14 Apr 2008 02:25:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3E6OhIC006707
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 13 Apr 2008 23:24:46 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m3E6Ofsx024916;
	Sun, 13 Apr 2008 23:24:41 -0700
In-Reply-To: <20080414053943.GU9785@ZenIV.linux.org.uk>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.753 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79462>

On Mon, 14 Apr 2008 06:39:43 +0100 Al Viro <viro@ZenIV.linux.org.uk> wrote:

> On Mon, Apr 14, 2008 at 06:39:39AM +0200, Willy Tarreau wrote:
> 
> [snip]
> 
> > I'm sure many people would find this useless (or in fact reject the
> > idea because it would show that most code will be rated 1 or 2),
> > but I really think it can help subsystem maintainers make the relation
> > between a reported bug and a possible submitter.
> 
> I have a related proposal: let us require all patches to be stamped
> with Discordian *and* Eternal September dates.  In triplicate.  While
> we are at it, why don't we introduce new mandatory headers like, say
> it,
> 
> X-checkpatch: {Yes,No}
> X-checkpatch-why-not: <string>
> X-pointless: <number from 1 to 69, going from "1: does something useful" all
> the way to "68: aligns right ends of lines in comments">
> X-arbitrary-rules-added-to-CodingStyle: <number> (should be present if
> and only if X-pointless: 69 is present).
> 
> Come to think of that, we clearly need a new file in Documentation/*,
> documenting such headers.  Why don't we organize a subcommittee^Wnew maillist
> devoted to that?  That would provide another entry route for contributors,
> lowering the overall entry barriers even further...
> 

None of the above was particularly useful.

> 
> Seriously, looks like Andi is right - we've got ourselves a developing
> beaurocracy.  As in "more and more ways of generating activity without
> doing anything even remotely useful".  Complete with tendency to operate in
> the ways that make sense only to beaurocracy in question and an ever-growing
> set of bylaws...

No.  The problem we're discussing here is the apparently-large number of
bugs which are in the kernel, the apparently-large number of new bugs which
we're adding to the kernel, and our apparent tardiness in addressing them.

Do you agree with these impressions, or not?

If you do agree, what would you propose we do about it?
