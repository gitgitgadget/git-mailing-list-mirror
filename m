From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: possible 'git cp'/how does git detect copies
Date: Fri, 27 Jun 2008 15:05:18 +0200
Message-ID: <4864E58E.4090000@viscovery.net>
References: <4864DFB6.3050204@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mircea Bardac <dev@mircea.bardac.net>
X-From: git-owner@vger.kernel.org Fri Jun 27 15:06:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCDeo-0006JB-1l
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 15:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799AbYF0NFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 09:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755828AbYF0NFX
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 09:05:23 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:10974 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755681AbYF0NFW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 09:05:22 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KCDde-00047F-J5; Fri, 27 Jun 2008 15:05:19 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 532DF54D; Fri, 27 Jun 2008 15:05:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <4864DFB6.3050204@mircea.bardac.net>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86556>

Mircea Bardac schrieb:
> I was looking today at duplicating a file but, I soon realized that
> there is no 'git cp' command (this was the "deductive approach to git
> commands", starting from git mv/rm/...). How does "git diff -C" detect
> copies (-C is used for this, according to the documentation)?
> 
> On a very simple test, I couldn't see this working. I just copied one
> file, added it, committed the change, ran "git diff -C HEAD^!". There is
> no place saying that it's contents is copied from some other file (both
> files are in the repository now).
> 
> "git blame -C new_copied_file" also doesn't show the commits for the
> original file.
> 
> This is all with 1.5.6.1.
> 
> I am probably missing something here... but I can't produce an example
> of copied contents that actually works. Any hint would be appreciated.

If you modify the original file in the same commit, then you should see
the copy. Otherwise, you can try git diff -C -C aka --find-copies-harder.

-- Hannes
