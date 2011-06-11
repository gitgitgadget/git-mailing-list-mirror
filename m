From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Best way to check for a "dirty" working tree?
Date: Sat, 11 Jun 2011 16:54:55 +0200
Message-ID: <4DF381BF.3050301@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 11 17:01:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVPgp-0001Js-DA
	for gcvg-git-2@lo.gmane.org; Sat, 11 Jun 2011 17:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758555Ab1FKPB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jun 2011 11:01:26 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.42]:47618 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758552Ab1FKPBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2011 11:01:25 -0400
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Jun 2011 11:01:25 EDT
Received: from [84.176.31.241] (helo=[192.168.2.100])
	by smtprelay04.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1QVPaR-0005Na-3o
	for git@vger.kernel.org; Sat, 11 Jun 2011 16:54:55 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175640>

Hi list,

I have a script which moves data from somewhere to my local repo and
then checks it in, like so:

-----------
mv /tmp/foo.bar .
git commit -am "Updated foo.bar at $timestamp"
-----------

However, before overwriting "foo.bar" in my working directory, I'd like
to check whether my working tree is dirty (at least "foo.bar").

I tried

A) if ! git diff-index --quiet HEAD -- foo.bar; then
       dirty=1
   fi

and

B) if ! git diff --quiet -- foo.bar; then
       dirty=1
   fi

Both A) and B) work. But which one is better/faster/more reliable? Or is
there a better solution? For my purpose, I cannot see a difference
between diff and diff-index, except the syntax.

Cheers,
    Dirk
