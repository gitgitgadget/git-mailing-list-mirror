From: Bill Lear <rael@zopyra.com>
Subject: Re: git-push through git protocol
Date: Mon, 22 Jan 2007 08:41:11 -0600
Message-ID: <17844.52487.646049.902119@lisa.zopyra.com>
References: <17843.29798.866272.414435@lisa.zopyra.com>
	<ep00nl$mop$1@sea.gmane.org>
	<Pine.LNX.4.64.0701211034490.14248@woody.osdl.org>
	<17843.55730.456139.247155@lisa.zopyra.com>
	<Pine.LNX.4.64.0701211341300.14248@woody.osdl.org>
	<17844.5120.316805.794579@lisa.zopyra.com>
	<Pine.LNX.4.64.0701211749140.14248@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 22 15:41:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H90MS-0002BM-S3
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 15:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbXAVOlZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 09:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbXAVOlZ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 09:41:25 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61056 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbXAVOlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 09:41:25 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0MEfHR26939;
	Mon, 22 Jan 2007 08:41:17 -0600
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701211749140.14248@woody.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37411>

On Sunday, January 21, 2007 at 17:52:22 (-0800) Linus Torvalds writes:
>...
>iow, I think you simply need to make sure that git-daemon will have write 
>permission to the thing. Either by making the whole repository writable by 
>nobody, or by running git-daemon as the proper user.

This now works:

% perl -pi -e 's/nobody/blear/' /etc/xinetd.d/git-daemon
% /etc/init.d/xinetd restart
% cd test/foo
% cat .git/remotes/origin
URL: git://blake/foo
Pull: refs/heads/master:refs/heads/origin
% git push
updating 'refs/heads/master'
  from fee4efae4f3b98cce0fe85efc746291157fffbcd
  to   73167c1dbcd08ef290f9ead5eef1808236e728b3
Generating pack...
Done counting 5 objects.
Result has 3 objects.
Deltifying 3 objects.
 100% (3/3) done
Writing 3 objects.
 100% (3/3) done
Total 3 (delta 0), reused 0 (delta 0)

Thanks for the help.


Bill
