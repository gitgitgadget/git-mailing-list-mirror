From: Dun Peal <dunpealer@gmail.com>
Subject: Git version of some common SVN hooks?
Date: Mon, 4 Oct 2010 14:43:45 -0500
Message-ID: <AANLkTimPGtH9xCh8rLSMAa2KDNOEDUt49qFK7p==aZho@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 04 21:43:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2qwy-0005Vt-15
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 21:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571Ab0JDTns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 15:43:48 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44619 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193Ab0JDTnr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 15:43:47 -0400
Received: by yxp4 with SMTP id 4so1761497yxp.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 12:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=H4Q76tDlvc3sdgRhKH4ioJ9LNYDxSWtbCkQuvadx1pw=;
        b=oMMmet26C8Ib6pw7F7ILHTNHsfO9o2hTcceZw+L4ObrVMxz5Cs4xhdFyJyU354DDbo
         seA2nCwgOvWYey3Mtn5aYtVIETwysvxxzU9c3Ta7bjhNTd2nkYVDjoKnGRAoeVcCTnQQ
         0lc7fQ6ytCVMn2Ahar9DeWdGxKw/tgPOBp+1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=DkDw+bi3TSclmwzSzTVHdtqlUKMZmuIEkD8l+YMKi0n4ksYyOt4cQ2dQKSAoHBev5v
         Rm7pOB2HAYoUJyDhpLTHcrp+hadEfYD1XVswbB4rYa2Y5BKYTKFSkG1b4X8j33ryc1R7
         ES9Mx6XdsEAGytJyltM0PzGcCeUwTzNoBwE7U=
Received: by 10.103.123.1 with SMTP id a1mr3587798mun.101.1286221426267; Mon,
 04 Oct 2010 12:43:46 -0700 (PDT)
Received: by 10.220.182.136 with HTTP; Mon, 4 Oct 2010 12:43:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158104>

Hi,

I'm porting a large and active repository from SVN to Git.

To provide the developers with the same features, I need the Git
version of the following common hooks:

1. svn2cl: the Subversion ChangeLog Generator. Basically a script that
sends a readable email listing a range of commits, showing just a
short summary for each commit: author name, timestamp, hash, paths
modified, commit message.
2. Hook to reject any commit containing a path with non-ASCII characters.
3. Hook to reject any commit causing the repository to contain two or
more paths that differ from each other only in letter case. For
instance, a commit adding foo/bar.py would be rejected if foo/Bar.py
was added as part of that same commit, or already existed in the repo.
4. Hook to trigger an action based on which path was committed to. For
example, if a developer commits into REPO_ROOT/foo, send an email to
address foo@somedomain, whereas a commit to REPO_ROOT/bar will send an
email to bar@somedomain.

I'm hoping there are Git versions of these hooks already written, but
if now any leads about implementing them would be appreciated.

Our full setup btw is a large repository hosted on a local instance of
Gitorious. All our users use Git >= 1.7, although they work on all 3
operating systems: Linux, OS X, Windows.

Thanks, D
