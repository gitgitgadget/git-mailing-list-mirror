From: David Kastrup <dak@gnu.org>
Subject: Arbitrary long file lists?
Date: Mon, 30 Jul 2007 14:33:50 +0200
Message-ID: <866442t6j5.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 14:34:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFUSB-0005Os-G7
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 14:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbXG3MeY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 08:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752341AbXG3MeY
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 08:34:24 -0400
Received: from main.gmane.org ([80.91.229.2]:34957 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596AbXG3MeX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 08:34:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IFURp-0001a1-7P
	for git@vger.kernel.org; Mon, 30 Jul 2007 14:34:05 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 14:34:05 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 14:34:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:D8U04KwRp81zq14DPtV5gE9mQys=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54227>


Hi,

commands like git-archive take a file list on the command line.  If
the number of files does no longer fit the argv limitations, this
causes a problem.

So it might be nice to be able to treat some "filenames" in a file
list special:

-@=filename (read LF-lines with filenames from filename)
-@=- (read lines with filenames from stdin)
-@z=filename (read NUL-terminated list with filenames from filename)
-@z=- (same from stdin)

Of course, this particular syntax, very loosely inspired by infozip,
leaves a lot to be desired: prettier proposals welcome.

But the feature itself would not be unimportant.  I am also fuzzy on
what sort of quoting should be interpreted outside of the
NUL-terminated case.

-- 
David Kastrup
