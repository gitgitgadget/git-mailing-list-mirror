From: Jim Garrison <jim@garrison.cc>
Subject: git config --global not picking up includes
Date: Mon, 19 Jan 2015 11:37:10 -0800
Message-ID: <54BD5CE6.2060309@garrison.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 20:42:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDIDF-0008Bz-9S
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 20:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbbASTmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 14:42:08 -0500
Received: from smtp74.ord1c.emailsrvr.com ([108.166.43.74]:37270 "EHLO
	smtp74.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751618AbbASTmH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2015 14:42:07 -0500
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2015 14:42:07 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp2.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id BA40118035A
	for <git@vger.kernel.org>; Mon, 19 Jan 2015 14:36:13 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp2.relay.ord1c.emailsrvr.com (Authenticated sender: jim-AT-garrison.cc) with ESMTPSA id 69649180159
	for <git@vger.kernel.org>; Mon, 19 Jan 2015 14:36:13 -0500 (EST)
X-Sender-Id: jim@garrison.cc
Received: from [10.0.0.6] (ResNet-10-42.resnet.ucsb.edu [169.231.10.42])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.4.2);
	Mon, 19 Jan 2015 19:36:13 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262640>

I have found that `git config --global` does not pick up any include 
directives in the git config file.

For instance, my ~/.gitconfig contains the following:

     [include]
         path = /home/garrison/gitconfig-include

And ~/gitconfig-include in turn contains

     [user]
         name = Jim Garrison

However, when I pass the --global flag to git config, my name is not 
picked up:

     $ git config --global user.name
     $ git config user.name
     Jim Garrison

If I instead replace .gitconfig with the contents of gitconfig-include 
(and in turn remove the include step), everything works as expected.

     $ git config --global user.name
     Jim Garrison
     $ git config user.name
     Jim Garrison

I am using the latest git master, built on Debian jessie.
