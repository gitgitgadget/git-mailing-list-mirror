From: Gelonida N <gelonida@gmail.com>
Subject: clone over slow/ unreliable network  / partial clone with full history
Date: Sun, 21 Oct 2012 23:22:05 +0200
Message-ID: <k61p1s$3fp$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 21 23:22:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ2yj-0000Fk-N8
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 23:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641Ab2JUVWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 17:22:17 -0400
Received: from plane.gmane.org ([80.91.229.3]:60236 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754288Ab2JUVWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 17:22:16 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TQ2yT-00006v-Q7
	for git@vger.kernel.org; Sun, 21 Oct 2012 23:22:21 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 23:22:21 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 23:22:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208151>

Hi,


Sometimes I have to clone a repository over a slow / rather unreliable 
network and wonder whether there are any tools tricks to reduce the pain
for such cases.


I'm having two problems:

Problem 1: Resuming a clone:
-----------------------------

When the connection gets cut during the clone, then I don't know how to 
continue / resume the clone. This is very annoying. After 20 minutes of 
cloning my connection is los. I reclone after 15 minutes the connection 
is lost. I reclone and after 25 minutes I succeed.

The only wrokaround, that I know would require full ssh access to the 
server. In fact it would be using rsync, (which can be resumed)
clone from the rsynced copy and thenmanually change the url of origin.



Problem 2: Full history but only required data
-----------------------------------------------
Very often I would only need a few versions (some branch heads / last 
week's commits) However git clone --depth seems to have far too many 
restrictions. (e.g. can't push from it)
So I wondered whether it would be possible to clone the entire history
of a repositry, but fetch only the data of a few specific commits.

This would reduce the transfer time massively as the repository may 
contine some huge binary files, which may change every few versions.

What would be great would be.
- download only the history (of course with a resume option if the 
connection got interrupted)
- then fetch the 'contents' for the version's I want to checkout
   (ideally specify some commit ranges, but specifying some specific 
commit id's would be good enough for me)



Are there any helper tools/ plans which would allow such work flow?
