From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [GIT PATCH] USB patches for 2.6.17
Date: Thu, 22 Jun 2006 14:07:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606221405080.6483@g5.osdl.org>
References: <20060621220656.GA10652@kroah.com>
	<Pine.LNX.4.64.0606211519550.5498@g5.osdl.org>
	<20060621225134.GA13618@kroah.com>
	<Pine.LNX.4.64.0606211814200.5498@g5.osdl.org>
	<20060622181826.GB22867@kroah.com> <20060622183021.GA5857@kroah.com>
	<Pine.LNX.4.64.0606221239100.5498@g5.osdl.org>
	<20060622200147.GA10712@mars.ravnborg.org>
	<Pine.LNX.4.64.0606221354070.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
X-From: linux-usb-devel-bounces@lists.sourceforge.net Thu Jun 22 23:07:20 2006
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
Envelope-to: linux-usb-devel-3@m.gmane.org
Received: from lists-outbound.sourceforge.net ([66.35.250.225])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtWOV-0002ds-Cd
	for linux-usb-devel-3@m.gmane.org; Thu, 22 Jun 2006 23:07:19 +0200
Received: from sc8-sf-list1-new.sourceforge.net (unknown [10.3.1.93])
	by sc8-sf-spam2.sourceforge.net (Postfix) with ESMTP
	id F16EA12A3B; Thu, 22 Jun 2006 14:07:17 -0700 (PDT)
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FtWOT-0000iq-03 for linux-usb-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 14:07:17 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1FtWOR-00086L-Jr
	for linux-usb-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 14:07:16 -0700
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5ML7EUT029782
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Jun 2006 14:07:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5ML7DhT016090;
	Thu, 22 Jun 2006 14:07:13 -0700
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <Pine.LNX.4.64.0606221354070.6483@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
X-Spam-Score: 1.0 (+)
X-Spam-Report: Spam Filtering performed by sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	Report problems to
	http://sf.net/tracker/?func=add&group_id=1&atid=200001
	1.0 FORGED_RCVD_HELO       Received: contains a forged HELO
X-BeenThere: linux-usb-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: <linux-usb-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>, 
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>, 
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22374>



On Thu, 22 Jun 2006, Linus Torvalds wrote:
> 
> After that, I'm not quite sure what you mean by "--dry-run". Do you mean 
> to know about file-level conflicts? You do need to do the merge in order 
> to know whether the conflicts can be resolved, but even without doing the 
> merge you can look for _file_level_ conflicts by other means.

Btw, what you can always do is just

	git pull <other-end>
	.. look at the result ..
	git reset --hard ORIG_HEAD

and you should be ok. It's obviously not a dry-run, it's more of a "do it 
and then undo it", but hey, it should _work_.

(Look out for dirty state, though. "git pull" will happily pull into a 
dirty tree if the changes don't actually affect any dirty files. The "git 
reset --hard" thing will undo all dirty state, though).

		Linus

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
