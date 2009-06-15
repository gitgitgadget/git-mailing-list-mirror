From: Ingo Oeser <ioe-git@rameria.de>
Subject: Using git for code deployment on webservers?
Date: Tue, 16 Jun 2009 01:11:47 +0200
Message-ID: <200906160111.47325.ioe-git@rameria.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ingo Oeser <ioe-git@rameria.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 01:15:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGLOq-00036K-G4
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 01:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbZFOXP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 19:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbZFOXP0
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 19:15:26 -0400
Received: from smtprelay07.ispgateway.de ([80.67.31.41]:35061 "EHLO
	smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbZFOXPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 19:15:25 -0400
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jun 2009 19:15:25 EDT
Received: from [91.62.57.216] (helo=axel.localnet)
	by smtprelay07.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ioe-git@rameria.de>)
	id 1MGLIt-0004oH-0w; Tue, 16 Jun 2009 01:09:27 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; x86_64; ; )
Content-Disposition: inline
X-Df-Sender: 849595
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121638>

[please CC me, as I'm not subscribed]

Hi there,

I try to use git in a quite unusual way.

I have a bunch of servers (hundreds), which get regular pulls of web developer code.
The code consists of images, flash files, scripting language files, you name it.
An exported repo (just the files, no SCM metadata) contains up to 4GB of files.

No I want to distribute changes the developers made in a tree like structure:

main server --> slave_1 --> webserver_0815
            |-> slave_2 --> webserver_2342
                        |-> webserver_4711

But with the following contraints:
- Store as little as possible on the webservers.
  One selected revision/tag is enough.
- Transfer as little as possible data.
  Cancel out addition and deletion on the fly.
- Nearly atomic update of file tree (easy to implement outside git)

Nice to have:
- Instead of copying the files to their proper names, 
  hardlink them to their git objects.

At the moment I always get more data than I need and have to store
the repository AND the checked out data.

I couldn't find a way so far to get around this. Is this possible? 
Any ideas are welcome.

Many Thanks in Advance!

Best Regards

Ingo Oeser
