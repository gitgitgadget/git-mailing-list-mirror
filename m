From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: git push sends more objects than it needs to
Date: Mon, 31 Oct 2005 11:50:48 -0800
Message-ID: <20051031195048.GA9231@agluck-lia64.sc.intel.com>
References: <20051031182355.GA7368@agluck-lia64.sc.intel.com> <Pine.LNX.4.64.0510311035310.27915@g5.osdl.org> <Pine.LNX.4.64.0510311119170.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 20:53:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWfgY-00019B-1U
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 20:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVJaTu5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 14:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbVJaTu5
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 14:50:57 -0500
Received: from fmr21.intel.com ([143.183.121.13]:46546 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S964814AbVJaTu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 14:50:56 -0500
Received: from scsfmr101.sc.intel.com (scsfmr101.sc.intel.com [10.3.253.10])
	by scsfmr001.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j9VJonbj013261;
	Mon, 31 Oct 2005 19:50:49 GMT
Received: from intel.com (agluck-lia64.sc.intel.com [143.183.251.239])
	by scsfmr101.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j9VJn5w3023644;
	Mon, 31 Oct 2005 19:49:05 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [127.0.0.1])
	by intel.com (Postfix) with ESMTP id 1578419F00;
	Mon, 31 Oct 2005 11:50:49 -0800 (PST)
Received: (from aegl@localhost)
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1/Submit) id j9VJomn7009257;
	Mon, 31 Oct 2005 11:50:48 -0800
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510311119170.27915@g5.osdl.org>
User-Agent: Mutt/1.4.1i
X-Scanned-By: MIMEDefang 2.52 on 10.3.253.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10879>

On Mon, Oct 31, 2005 at 11:36:09AM -0800, Linus Torvalds wrote:
>  a) The "don't do that then" approach:
> 
>     Don't go behind git's back and add objects on your own, and expect git 
>     to realize what you did. ;^p

To be a responsible kernel.org git user I need to use packfiles.  The
cheapest and easiest way to do that is to steal them from you.

>  b) The "live with it" approach:
> 
>     You copied the pack by hand, and that will keep git-unpack-objects 
>     from duplicating the objects, but you'll still waste time and network 
>     when trying pushing the objects (just once, though).
> 
>     Ie this is what happened this time: nothing really lost, and the end 
>     result is fine. Now you know why it happened, and you're fine.

I like this one best.  There's a pretty fat pipe between here and
kernel.org ... more of the time wasted appeared to be on the
unpacking part than on the transfer.

>  d) Just let git do it for you.
> 
>     Copy the pack-files, or add my object directory as an "alternates" for 
>     your object directory, do the "git prune-objects", and then _locally_ 
>     on master.kernel.org just do something like

Longer term (when everyone is pulling using the "git" protocol)
adding your object directory to my info/alternates looks to be
the best thing.

-Tony
