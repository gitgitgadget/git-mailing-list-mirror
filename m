From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: git-svn and local only topic branch
Date: Tue, 1 May 2007 18:40:05 +0200
Message-ID: <8b65902a0705010940pb3bfb16u624d470068351624@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 18:40:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HivOi-0005nw-58
	for gcvg-git@gmane.org; Tue, 01 May 2007 18:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731AbXEAQkJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 12:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754760AbXEAQkJ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 12:40:09 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:10631 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731AbXEAQkH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 12:40:07 -0400
Received: by an-out-0708.google.com with SMTP id b33so1652349ana
        for <git@vger.kernel.org>; Tue, 01 May 2007 09:40:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=o7sNmHYElJsOqwlPQ87vGVWcJDSVRoHc/WYeWq8fmX42ZoMPBrEl+tsqA82z2j5OSCxgHAWALUojF60Y5KagSMhwLzh/AW049Uo7I9Uy8tMilkyIJoD5bvQDFfXdmcnJTl8lVU+ujWzY5GSqKwzz2Z6Z00vLYSa45OYl7JRuWFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WEApF1AYPNa0jWpGhbJbint8+iqNpPZdNPaKIWiTSZjRzZO556a9fAr7L8A7i2kJzzhGKvtEBZ4q8khR7lflfmwpNJj4zaOO+nVePtHOG5YaRt0jQLFnsF7SGllkU0ZiippN67nEXajkVvUUdbFi2AWev51dzlnq2HseUIz+K5w=
Received: by 10.100.108.11 with SMTP id g11mr1251275anc.1178037606068;
        Tue, 01 May 2007 09:40:06 -0700 (PDT)
Received: by 10.100.46.11 with HTTP; Tue, 1 May 2007 09:40:05 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45957>

Hi,

I'm using Git as a SVN frontend (via git-svn). Recently, I made a
topic branch, I did some job on it and wish to "upload" my work (on
the SVN). But, I do not want "pushing" all commits, I only want to
create a single commit on the SVN, while keeping full commits on my
Git repo. But I did not find how to do this.

Here my story.
Let's call "upstream" the local branch connected to the SVN, the raw
SVN mirror branch is remotes/upstream. Now, I create a branch "topic"
from "upstream" and I do job:

o--o--o (upstream, remotes/upstream)
         \
          o--o--o--o (topic)

I want the following result:

o--o--o-------------- o (upstream, remotes/upstream)
         \             /
          o--o--o--o (topic)

So I did "git-merge "Merge" upstream topic". But, the merge action
decided to do a fast-forward. It's not correct because I really don't
want to "pollute" the SVN with all my commits.

So I rewinded and I did "git-merge --squash "Merge" upstream topic".
This time, it seems to work as I obtained a single commit on upstream
branch. But this commit does not have ancestry link with the topic
branch. Here is it:

o--o--o--o (upstream, remotes/upstream)
         \
          o--o--o--o (topic)

Is there a way to do what I want?

-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
