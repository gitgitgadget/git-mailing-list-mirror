From: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
Subject: Removing part of the history
Date: Fri, 28 Nov 2008 19:23:28 -0200
Organization: DATACOM
Message-ID: <49306150.6010701@datacom.ind.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 28 22:25:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6ApU-0003UM-7A
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 22:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbYK1VXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 16:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752704AbYK1VXb
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 16:23:31 -0500
Received: from mail.datacom-telematica.com.br ([200.213.13.18]:42619 "EHLO
	mail.datacom-telematica.com.br" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752636AbYK1VXb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Nov 2008 16:23:31 -0500
Received: by mail.datacom-telematica.com.br (Postfix, from userid 65)
	id 199E12ACCA; Fri, 28 Nov 2008 19:23:29 -0200 (BRST)
Received: from [10.1.3.11] (unknown [10.1.3.11])
	by mail.datacom-telematica.com.br (Postfix) with ESMTP id CEAD42ACC5
	for <git@vger.kernel.org>; Fri, 28 Nov 2008 19:23:28 -0200 (BRST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081125)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101885>

Hi All,

I have a repository with code imported from CVS.

I first imported from CVS using git 1.5.6 and we started to develop in git branches.
I run cvsimport periodically and merged the changes from CVS (legacy developers) to our git branches.
After some time, I realized that the import was broken, upgraded to git 1.6 and reimported the data.
Now the imported data seems to be correct and I finished with a history tree like this:

(our branch1)             X--Y--Z
merges>                  /    \
(our branch2)       J--K--L--M--N--O--P
merges>             /     /     /
(cvs old) ...A--B--C--D--E     /
merges>                       /
(cvs new) ...A'-B'-C'-D'-E'-F'


There is any way to get rid of the (broken) cvs-old tree?

I've tried to rebase, but the commits from A' and A are different, it tries to reapply all history in CVS.

I've tried to checkout a point before our changes start (B') and then, using a script, cherry-pick all commits up to HEAD that are not in cvs-old branch. This approach didn't handled well merges between our branches (K-L-M and X-Y).

The history from the beginning up to the point where our changes started (...A--B) is quite large, so it would be nice for us to get rid of it. 

Any suggestion on how to handle this?

Thank you,

 - Samuel
