From: Thomas Jampen <jampen@kinet.ch>
Subject: Out of memory error during git push
Date: Fri, 20 Aug 2010 11:11:00 +0200
Organization: Gymnasium Kirchenfeld - Informatikdienste
Message-ID: <4C6E46A4.8050502@kinet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 11:18:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmNkV-0003me-EZ
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 11:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014Ab0HTJSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 05:18:45 -0400
Received: from hermes.gymkirchenfeld.ch ([86.118.137.202]:44814 "EHLO
	hermes.gymkirchenfeld.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab0HTJSo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 05:18:44 -0400
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Aug 2010 05:18:44 EDT
Received: from localhost (localhost [127.0.0.1])
	by hermes.gymkirchenfeld.ch (Postfix) with ESMTP id 2A72F8C432D
	for <git@vger.kernel.org>; Fri, 20 Aug 2010 11:11:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at hermes.gymkirchenfeld.ch
Received: from hermes.gymkirchenfeld.ch ([127.0.0.1])
	by localhost (hermes.gymkirchenfeld.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YBOaLVbzoP6w for <git@vger.kernel.org>;
	Fri, 20 Aug 2010 11:11:01 +0200 (CEST)
Received: from [192.168.9.54] (proxy.gymkirchenfeld.ch [86.118.137.200])
	by hermes.gymkirchenfeld.ch (Postfix) with ESMTPSA id 51A368C432A
	for <git@vger.kernel.org>; Fri, 20 Aug 2010 11:11:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2 ThunderBrowse/3.3.2
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153988>

Hi all

I'm experiencing the following error while pushing a git repo (home
directory) to my QNAP TS-210:

user@mypc:~$ git push origin master
Counting objects: 12532, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (8974/8974), done.
fatal: Out of memory, malloc failed, 986.06 MiB | 1.65 MiB/s
error: pack-objects died of signal 13
error: pack-objects died with strange error
error: failed to push some refs to
'ssh://nas//share/MD0_DATA/user/repositories/backup.mypc'

I've searched the internet and found suggestions to try to repack with
lower values for 'depth', 'window' and 'windowMemory'. I used 3, 3, 50
respectively, but a push after the repack command resulted in the same
error.

I tried git fsck which reported a few dangling blobs only and I got the
same error again during the next push.

I watched /proc/meminfo and /proc/swaps on the NAS while pushing and saw
that there are always 20-50MB of free RAM and that from 512MB swap space
only about 180MB are used.

What else can I try to successfully push my repo to my NAS?

Thanks for your help,
Tom
