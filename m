From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Unexpected difference between core.autocrlf=true and .gitattributes
 text=auto
Date: Wed, 19 Mar 2014 14:44:42 +0100
Message-ID: <53299F4A.6000600@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 14:53:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQGvy-0000NE-T7
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 14:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934154AbaCSNx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 09:53:26 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:39204 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933853AbaCSNxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 09:53:25 -0400
X-Greylist: delayed 520 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Mar 2014 09:53:25 EDT
Received: from [91.113.179.170] (helo=[127.0.0.1])
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <marc.strapetz@syntevo.com>)
	id 1WQGnT-0006UF-5F
	for git@vger.kernel.org; Wed, 19 Mar 2014 14:44:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
X-Enigmail-Version: 1.6
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244449>

I have a file.txt which is stored with CRLF in the repository (I'm on
Windows, but that should not matter). autocrlf has been set:

$ git config core.autocrlf
true

Git considers the working tree clean:

$ touch file.txt
$ git status
On branch master
nothing to commit, working directory clean

However, when adding .gitattributes with following content:

* text=auto

Git starts considering the file as modified:

$ touch file.txt
$ git status
On branch master
Changes not staged for commit:
...

        modified:   file.txt

I think it's correct to consider the file as modified, because when
committing it, it should be converted to CRLF.

But why doesn't it show up as modified in the first case?

-Marc
