From: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Subject: Get all tips quickly
Date: Sun, 13 Apr 2014 18:19:47 +0400
Message-ID: <4A7A3A96-DC10-4748-BBCC-F52F48977022@jetbrains.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stanislav.Erokhin@jetbrains.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 16:26:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZLMp-0001Ef-Lk
	for gcvg-git-2@plane.gmane.org; Sun, 13 Apr 2014 16:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbaDMO0d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2014 10:26:33 -0400
Received: from mail1.intellij.net ([46.137.178.215]:39337 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbaDMO0c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Apr 2014 10:26:32 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Apr 2014 10:26:31 EDT
Received: (qmail 28110 invoked by uid 89); 13 Apr 2014 14:19:49 -0000
Received: from unknown (HELO loki.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@81.3.129.2)
  by ip-10-62-119-91.eu-west-1.compute.internal with ESMTPA; 13 Apr 2014 14:19:49 -0000
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246208>

Hi,=20

What is fastest possible way to get all =93tips=94 (leafs of the Git lo=
g graph) in a Git repository with hashes of commits they point to?

We at JetBrains are tuning performance of Git log integration in our In=
telliJ IDEA and want to get all tips as fast as possible.=20
Currently we use 'git log =97branches --tags --remotes --no-walk=92, bu=
t the problem is that it is slow if there are a lot of references. In o=
ur repository we have about 35K tags, and therefore the tags is the mai=
n slowdown. On the other hand, we have just a couple of dozens of tips =
as well as branch references, and `git log --branches --remotes` is ver=
y fast.

So we are searching a way to get tags pointing to the graph leafs faste=
r.=20

We also tried to read tags by manually parsing .git files (it is faster=
 than invoking git log), but unfortunately annotated tags in .git/refs/=
tags/ are written without the hashes they point to (unlike .git/packed-=
refs).

And that=92s a pity that `git tag` doesn=92t show the hashes.

Thanks a lot for any help!

-----
Kirill Likhodedov
JetBrains
http://www.jetbrains.com
"Develop with pleasure!"
