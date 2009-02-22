From: Brent Goodrick <bgoodr@gmail.com>
Subject: How do I undo a fast-forward merge safely?
Date: Sun, 22 Feb 2009 11:15:51 -0800
Message-ID: <e38bce640902221115o2dd1c63dv6f7acc374b48d418@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 22 20:17:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbJpI-0000QE-Vh
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 20:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbZBVTPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 14:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbZBVTPx
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 14:15:53 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:40870 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbZBVTPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 14:15:52 -0500
Received: by gxk22 with SMTP id 22so4406302gxk.13
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 11:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=aNg+LBbMMBA60FdD1i7M9pTb4LKZ0dTP2rH/WkGi3Eg=;
        b=jq1My+wBdCoK8jHnfhTF7H6HerdgrU1+QsB5J/iemayg7XnCx5JA/jISxW2vjtczNb
         Hx80UTExS9CrRoRjERnsdykyHUnGjV92IXITY042OxylhEXDBvZxQqlN8T13HkLNVXju
         vKpb3wnkS2nDEFI61zuBnvisjKFoCpmHdFSxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=QyC/kEzFaQgfI0Txt44Li8ZcG24lReiSWF8eOPvTSF+EmSN2q52H/u8AA3rzGzLXO3
         FGwkSbyYE859ZPg1VoLKaGnFLRe5VtlKhBVGCD8HIyfpw2Q48RFM0cPAirngVR9mYrmB
         b/2fAnQ23UzMhBUc7I8g3+pmPv0PBRZer0RQk=
Received: by 10.90.97.18 with SMTP id u18mr1011585agb.103.1235330151523; Sun, 
	22 Feb 2009 11:15:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111053>

I had done a git merge --no-commit <source_branch> operation, but that
bit me because I mistakingly concluded that --no-commit would prevent
any type of automatic operation, but apparently a fast-forward
occurred.  I should have used the --no-ff option? How do I get my
target branch back to where it was before the bad merge?

I did make a backup of the entire repo before I started, so I do have
the plan-B option of replay my changes onto a copy of the backup repo.
  But, maintaining backup copies just so as to avoid getting bit each
time I forget to use the --no-ff option will be a non-starter, so I
would hope there are some safe commands I can use to go back to the
original.

git log -1 does not show the commit, but gitk does show a vertical red
line that I can only presume indicates the fast-forward.  How does
gitk determine that red line, while git-log does not?  Note that I
have not pulled into any other repo's yet, and won't until I can
rectify this issue.

Here was my bad git merge command line:

$ git merge --no-commit source_branch
Updating 7eb9a02..0c66ca1
Fast forward
<eliding list of files I want mixed in with lots of files I don't want>

So, what operations, rebase, reset, etc, do I need to do to get this
repo back to where it was right before the fast-forward?

Thanks,
Brent
