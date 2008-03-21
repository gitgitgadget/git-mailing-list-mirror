From: "Jean-Baptiste Quenot" <jbq@caraldi.com>
Subject: Recording cherry-picked commits
Date: Fri, 21 Mar 2008 13:33:11 +0100
Message-ID: <ae63f8b50803210533n12645fb3w9a8be601c4cc394@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 13:34:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcgRX-0000xQ-PN
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 13:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600AbYCUMdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 08:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754414AbYCUMdO
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 08:33:14 -0400
Received: from gv-out-0910.google.com ([216.239.58.189]:46262 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423AbYCUMdN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 08:33:13 -0400
Received: by gv-out-0910.google.com with SMTP id s4so329780gve.37
        for <git@vger.kernel.org>; Fri, 21 Mar 2008 05:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=92zIuH/AiSA7hBNyYhOHvruHnBgEEwKk2oJjbJtPYl8=;
        b=Lm6lw23xIacfdh85+iD8q2fUZvHo/o6UTGk0nFGURX/G3gVUYLCYM6cA6E8TAKCwer5Uba3Ng/hcB+l5ByilGz+uucEKpoQ6R+jfNhF1DnePAwVNFPRwhIjuuCg8JflXWc5IvUdGpvtDBX9gzjAvWk7BJoyGEDfZyKPYsjWf6BA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=Sm6qOnoeZ2DPLGJA0yD6A1nlSdo+QUEsX4j23I9Hsmhmg+UYz1ibQlfOdIRWAepyNyittKcG5cSA67PrPB13WUdy4H4QuKnLWIG+rBQWas5L1WzP1XnEBC20MYUP7v2HQdzvLx2UAqiqNRAQntILaShLlhA5cZAme/UvVqunPaY=
Received: by 10.78.134.7 with SMTP id h7mr6669863hud.76.1206102791270;
        Fri, 21 Mar 2008 05:33:11 -0700 (PDT)
Received: by 10.78.130.20 with HTTP; Fri, 21 Mar 2008 05:33:11 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: ba39819f686cd32b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77734>

Hi there,

Cherry-picking is great with Git, both with git-cherry-pick and
git-cherry.   I use them to pick commits from my development branch to
my stable maintenance branch that goes to production.

But when a particular commit is slightly different between the two
branches (due to eg a conflict resolution in my stable branch), then
git-cherry still lists the commit as only present in the development
branch.  This is a feature, as documented in the man page, because
git-cherry compares the changeset rather than the commit id.

So I'm wondering if there's a way to record the commit ID as being
already picked from the development branch to the stable branch, so
that it's not listed again when I provide the same arguments to
cherry-pick.  I was used to this kind of feature with svnmerge, a
wrapper script around svn that records cherry-picked commits in a
Subversion property called svnmerge-integrated on the root directory.
But with Git, what is the best practice for knowing which commits you
already picked?

Ideally, the set of already-picked commits would be versioned in the
Git repo itself, so that other developers can watch what commits are
available to pick as well.

Thanks in advance,
-- 
Jean-Baptiste Quenot
http://caraldi.com/jbq/blog/
