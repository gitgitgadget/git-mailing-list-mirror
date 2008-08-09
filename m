From: "Pierre-Julien Bringer" <pj.bringer@gmail.com>
Subject: keeping /etc under git with etckeeper
Date: Sat, 9 Aug 2008 20:48:39 +0200
Message-ID: <14b409fc0808091148k69f4019n6996261a710adfca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 09 20:49:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRtVa-0007Nc-O3
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 20:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbYHISsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 14:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbYHISsl
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 14:48:41 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:19954 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbYHISsk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 14:48:40 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1569301rvb.1
        for <git@vger.kernel.org>; Sat, 09 Aug 2008 11:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=zlMl87jIOfKYS/Wk3OiGMrRsEQEneELgV6pAXQNU9UM=;
        b=QUcd14Ioi4jWJXgw/LKpQMCRasKEZeXSsnRhewok4T607DQAW2qz/ihHL6pc+uRW0L
         NL8l+pVaWuxb0OmmeIh9uJo/LxEKhRu81xOWZDIfy75VW4D8yA2DJ5e1ghYLLI5CwTcR
         KeykSXQjbo33e/9wQbVhVwl2uzL0ZaqWhigu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Y3uoMLT+8KgZnJ4yhsxXNJkPejom5YejzQKGxa9+vEQY6IqR09tLryzR7AcPAn7IDQ
         crezL1d4K2v5bAnyLDIBvpMh+1YE7YkGDW0vWyMii3YQxNKDhU5ECuoLoLPXdHHKQckH
         7vpi7sYFHpl5RDLnsjRYDZdnFprGfC/RbfMN4=
Received: by 10.114.180.18 with SMTP id c18mr2627218waf.128.1218307719887;
        Sat, 09 Aug 2008 11:48:39 -0700 (PDT)
Received: by 10.114.210.9 with HTTP; Sat, 9 Aug 2008 11:48:39 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91772>

Do you think storing the etc directory in git with etckeeper is a good
thing? I've heard it was not recommended to do so for the home
directory, but also for /etc:
1 Git tries to find a link between the changes and there would
probably be none for $HOME, according to Randal Schwarz [1].
2 Git does not store permissions of files [2].
3 If Git has some sort of merge conflict on important config files
(passwd, etc...), it would be pretty bad [3].

When using etckeeper:
1 There would be a link between the changes if a commit occurs between tasks.
2 Permissions are stored thanks to Metastore.

I have only superficial experience in using git, and I don't really
know how likely it would be for things to go wrong. Merging seems to
be the dangerous operation, but using it to track linear history would
be okay. Gentoo users have been able to use RCS for a long time, but
that solution is considered to be deprecated, although it does the
job. Can experienced git users think of any reason not to use a small
subset of git for this task?


Pierre-Julien Bringer


[1] Randal Schwarz, "Git" at Google, October 12 2007, available at
http://www.youtube.com/watch?v=8dhZ9BXQgc4
[2] Git project's FAQ available at http://git.or.cz/gitwiki/GitFaq
[3] Joey Hess, November 26 2007 on vcs-home -- Discussion list for
storing ~ under VCS control, available at
http://lists.madduck.net/pipermail/vcs-home/2007-November/000102.html
