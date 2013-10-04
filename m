From: Pascal MALAISE <malaise@magic.fr>
Subject: Bug? Unexpected outputs of git pull on stdout v.s. stderr
Date: Fri, 04 Oct 2013 19:18:49 +0200
Message-ID: <524EF879.1020607@magic.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 04 19:19:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VS924-0005Ry-3j
	for gcvg-git-2@plane.gmane.org; Fri, 04 Oct 2013 19:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150Ab3JDRS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Oct 2013 13:18:58 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:60297 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983Ab3JDRS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Oct 2013 13:18:58 -0400
Received: from telemaque (unknown [78.224.49.155])
	(Authenticated sender: pascal.malaise)
	by smtp1-g21.free.fr (Postfix) with ESMTPA id 3F9EC94020E
	for <git@vger.kernel.org>; Fri,  4 Oct 2013 19:18:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by telemaque (Postfix) with ESMTP id 9AEC584AD9
	for <git@vger.kernel.org>; Fri,  4 Oct 2013 19:18:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.0
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235716>

Hello,

git --version
-> git version 1.7.9.5
on linux

A 'git pull' operation exits with 1 (which is normal) but generates the
following output and error flows:

stdout:
Auto-merging c/makefile
CONFLICT (content): Merge conflict in c/makefile
Auto-merging c/x_color.c
Auto-merging c/x_export.c
CONFLICT (content): Merge conflict in c/x_export.c
...
CONFLICT (content): Merge conflict in c/x_line.h
Automatic merge failed; fix conflicts and then commit the result.

stderr:
From /home/malaise/ada
* branch            Xft        -> FETCH_HEAD

With option -q the Error flow is empty and the Output is as before.


I would expect that the text:
> From /home/malaise/ada
> * branch            Xft        -> FETCH_HEAD
is part of stdout and suppressed with option -q

And that the message:
> Automatic merge failed; fix conflicts and then commit the result.
is part of stderr (and kept with option -q).


Or did I miss something?
Thank you.

-- 
Couldn't eradicate windows from my PC but I caged it in a vmware.
Pascal MALAISE
