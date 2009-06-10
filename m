From: Jon Nelson <jnelson@jamponi.net>
Subject: git-svn and *lots* of ssh connections
Date: Wed, 10 Jun 2009 09:09:39 -0500
Message-ID: <cccedfc60906100709r18364bc2h82d8e1a7ee0b8fd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 16:10:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEOVE-0002Ba-UW
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 16:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756238AbZFJOJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 10:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756146AbZFJOJ6
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 10:09:58 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:33893 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039AbZFJOJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 10:09:58 -0400
Received: by bwz9 with SMTP id 9so754374bwz.37
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 07:09:59 -0700 (PDT)
Received: by 10.216.50.144 with SMTP id z16mr498748web.65.1244642999159; Wed, 
	10 Jun 2009 07:09:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121278>

The company I work for (but do not speak for) uses svn (via ssh). I
tried to use it; I really did. But I missed git and found svn quite
honestly painful to use so I went to git-svn, and other than some
caveats I'm pretty happy.  However, one of the issues I've had with
git-svn is fairly troublesome.

Basically, during the fetch stage (or clone) git-svn uses a *ton* of
ssh connections. Many dozens and in even with smaller projects well
over a hundred. By "small" I mean a .git of less than 6MB and less
than 60 files in the checkout. I've got 4MBit bandwidth available but
frequently see only a single digit fraction of that going to the
fetch/clone process. Is there anything that can be done to reduce the
number of ssh connections involved? Why can't a single connection
simple be re-used? I can't use "ssh connection sharing" for a variety
of reasons that aren't relevant here.

I'm using 1.6.0.2.

-- 
Jon
