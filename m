From: Carlos Pereira <jose.carlos.pereira@ist.utl.pt>
Subject: howto to run git without a master branch
Date: Sat, 08 Mar 2014 21:37:21 +0000
Message-ID: <531B8D91.6020800@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 22:24:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMOjF-000308-OT
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 22:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbaCHVYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2014 16:24:17 -0500
Received: from smtp1.ist.utl.pt ([193.136.128.21]:56119 "EHLO smtp1.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052AbaCHVYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2014 16:24:16 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.ist.utl.pt (Postfix) with ESMTP id BD88F7000482
	for <git@vger.kernel.org>; Sat,  8 Mar 2014 21:24:14 +0000 (WET)
X-Virus-Scanned: by amavisd-new-2.6.4 (20090625) (Debian) at ist.utl.pt
Received: from smtp1.ist.utl.pt ([127.0.0.1])
	by localhost (smtp1.ist.utl.pt [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id jDizYWFJ9dse for <git@vger.kernel.org>;
	Sat,  8 Mar 2014 21:24:14 +0000 (WET)
Received: from mail2.ist.utl.pt (mail.ist.utl.pt [IPv6:2001:690:2100:1::8])
	by smtp1.ist.utl.pt (Postfix) with ESMTP id 7EF5B70003EB
	for <git@vger.kernel.org>; Sat,  8 Mar 2014 21:24:14 +0000 (WET)
Received: from [IPv6:2001:690:2100:1c0:7aac:c0ff:feff:eff7] (unknown [IPv6:2001:690:2100:1c0:7aac:c0ff:feff:eff7])
	(Authenticated sender: ist12604)
	by mail2.ist.utl.pt (Postfix) with ESMTPSA id 424C02007783
	for <git@vger.kernel.org>; Sat,  8 Mar 2014 21:24:14 +0000 (WET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20121215 Icedove/3.0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243683>

Hi,
git newbie here.

I would like to work with two main branches: master-g and master-x, 
instead of the usual master, and apparently git does not like this.

After creating a local repository with these two branches, and a server 
repository with git init --bare, and pushing the two branches:

git remote add origin foo@bar:~/path/test.git
git push origin master-g
git push origin master-x

everything seems fine, but cloning:
git clone foo@bar:~/path/test.git
terminates with a warning: remote HEAD refers to nonexistent ref, unable 
to checkout.

On the original local repository, I have:
 >cat HEAD
ref: refs/heads/master-x

But on the server repository or the clone repository, HEAD points to 
master branch, that does not exist:
 >cat HEAD
ref: refs/heads/master

Replacing in the HEAD file, master by master-g (on the server before 
cloning, or on the clone after cloning) seems to solve the problem.

Shall I worry about this? does my fix (editing directly HEAD on the 
server) fixes really the problem? what would be the correct procedure to 
avoid this?

Thank you!
Carlos Pereira,
