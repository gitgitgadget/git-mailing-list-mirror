From: Garry Dolley <gdolley@arpnetworks.com>
Subject: git-shortlog hangs on bare repo without --bare option
Date: Wed, 27 Aug 2008 12:52:33 -0700
Message-ID: <20080827195233.GA2477@garry-thinkpad.arpnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 22:00:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYRBi-0006vj-Ph
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 22:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbYH0T7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 15:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbYH0T7O
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 15:59:14 -0400
Received: from mail.arpnetworks.com ([205.134.237.79]:42292 "HELO
	penguin.filetron.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1750811AbYH0T7N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 15:59:13 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Aug 2008 15:59:13 EDT
Received: (qmail 16003 invoked from network); 27 Aug 2008 19:50:48 -0000
Received: from unknown (HELO garry-thinkpad.arpnetworks.com) (gdolley@arpnetworks.com@205.134.237.48)
  by mail.arpnetworks.com with SMTP; 27 Aug 2008 19:50:48 -0000
Content-Disposition: inline
X-PGP-Key: http://scie.nti.st/pubkey.asc
X-PGP-Fingerprint: A4C2 A268 0A00 1C26 94BC  9690 4255 E69B F65A 9900
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93936>

I didn't see this happen with git 1.5.x, but if you do git-shortlog on a bare 
repo, without specifying --bare, the command will seemingly hang indefinitely.

Here's my output:

[garry@garry-thinkpad] ~/dev (master) $ cd ebay4r/                       <----- Repo with working tree (non-bare)
[garry@garry-thinkpad] ~/dev/ebay4r (master) $ git shortlog -e -s
   130  Garry Dolley <gdolley@arpnetworks.com>
[garry@garry-thinkpad] ~/dev/ebay4r (master) $ cd ..
[garry@garry-thinkpad] ~/dev (master) $ git clone --mirror ebay4r/ ebay4r-bare
Initialized empty Git repository in /home/garry/dev/ebay4r-bare/
[garry@garry-thinkpad] ~/dev (master) $ cd ebay4r-bare/
[garry@garry-thinkpad] ~/dev/ebay4r-bare (master) $ git shortlog -e -s
<hang>                                                                   <----- *** It hangs here ***

[garry@garry-thinkpad] ~/dev/ebay4r-bare (master) $ git --bare shortlog -e -s
   130  Garry Dolley <gdolley@arpnetworks.com>
[garry@garry-thinkpad] ~/dev/ebay4r-bare (master) $ 


If newlines break this output in your reader, you can also view it 
here: http://pastie.org/261134

I'm using git 1.6.0.1

Is this a bug?

-- 
Garry Dolley
ARP Networks, Inc.
818-206-0181
Los Angeles County REACT, Unit 336
WQGK336
