From: "Henning Moll" <newsScott@gmx.de>
Subject: squash commits deep down in history
Date: Thu, 23 Oct 2014 14:34:17 +0200
Message-ID: <trinity-6a57d894-cc4f-4213-9c51-5c73de2501d0-1414067657189@3capp-gmx-bs48>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 23 14:34:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhHb1-0002ix-4N
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 14:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567AbaJWMeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 08:34:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:54470 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755286AbaJWMeT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2014 08:34:19 -0400
Received: from [195.49.159.91] by 3capp-gmx-bs48.server.lan (via HTTP); Thu,
 23 Oct 2014 14:34:17 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K0:Dt3j/ZsHyifwhSdfpNqm7elxs055hUkIQp/F2RssigT
 +DXT1KbHBSeQm9Ig3OztYSZxJSGSI95l5inM/j2nb7cMjVXTo/
 dVeVezzQ7Wk5RZ1Bkjj6rGVRDVztx9ttibJv60r5bE4eijo7Gf
 EAZ/z3cfCf3u4vTjgFhue387lPr+nCQzESvzlZfIobBm+2NEhZ
 QNlo/tS5uSLsX8XunvanfVliLC3w8T2b64ludkWfRj4QD2SSNw
 ++v2GU0fczQElEN7dLFBE9EBjosq2b2LIuvDuBI8tFiBU1fM52 vbSOMU=
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

i need to squash several commits into a single one in a automated way. I know that there is interactive rebase, which can also be automated using GIT_SEQUENCE_EDITOR. Unfortunately my history is very large and i need to squash deep down in the history several times. So using interactive rebase seems not to be the right tool.

I wonder if i can solve this task using filter-branch? I have a file that list the SHA1s for each squash operation per line. All SHA1s of a line are in chronological order (youngest to oldest), or in other words: the first SHA1 is the child of the second, and so on.

| ab4423e 3432343 3234252
| 2324342 5232343
| ...

Lets say there are N lines in that file. Each line means: squash all SHA1s of this line into the first (or last) SHA1 of this line.
Performing this task with rebase would require N rewritings of the history. So e.g. HEAD (but many others too) would be rewritten N times even if it is not directly part of a line. My thinking is, that a filter-branch can do this in a single rewrite and therefore would be much more performant.

How can i solve this? Any ideas?

Best regards
Henning
