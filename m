From: John Tapsell <johnflux@gmail.com>
Subject: Confusing git pull error message
Date: Sat, 12 Sep 2009 23:01:45 +0300
Message-ID: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 12 22:01:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmYnA-0004XW-8r
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 22:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775AbZILUBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 16:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753713AbZILUBn
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 16:01:43 -0400
Received: from mail-yx0-f176.google.com ([209.85.210.176]:35827 "EHLO
	mail-yx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634AbZILUBm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 16:01:42 -0400
Received: by yxe6 with SMTP id 6so2849628yxe.22
        for <git@vger.kernel.org>; Sat, 12 Sep 2009 13:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=L4mNyMt9QDLHmMgt625d5ElC7YrMxOLLB8STqzQsOYc=;
        b=hLSZT4GA6RW/Qvgo6UdTDXtXRZYGy5Dv8wtbfVFAOyKP8bzAvGM9VxXcCMwTcy937S
         cXw/bAjHEkoS2/+t9oWFLxT6Gi8DkMcRoVBMOiDNdm+F7nnz7DTUPFeNwJ1ctObUNFlG
         ZhbktQJSOL1uP5Fdi7RVpyKvLPnatDR5vCenI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=bq9sLqirNkyEPMxBda5dhO38NwPs/nROdiCcZj4k2fy/W/a4iT+UQGVTlSjMOC2p+m
         wJJhRTGjT3F/3jl9Nm+QGzx6Fu1GX7QZLCO+1bHxkyM2Vx2TlNngvS/ePBAMPJhgkF1U
         w0VJcM37S79/KpK1WjC1ULEsW2neoi1r6skxQ=
Received: by 10.150.65.19 with SMTP id n19mr7208072yba.119.1252785705894; Sat, 
	12 Sep 2009 13:01:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128292>

Hi,

  Because of another bug in git https, sometimes "git ls-remote
origin" only sees a small subset of the actually available branches.
This lasts until someone using git:// makes a commit.

  So anyway, I tried to do a "git pull" and it gives me the misleading error:

You asked me to pull without telling me which branch you
want to merge with, and 'branch.master.merge' in
your configuration file does not tell me either.  Please
name which branch you want to merge on the command line and
try again (e.g. 'git pull <repository> <refspec>').
See git-pull(1) for details on the refspec.

If you often merge with the same branch, you may want to
configure the following variables in your configuration
file:

    branch.master.remote = <nickname>
    branch.master.merge = <remote-ref>
    remote.<nickname>.url = <url>
    remote.<nickname>.fetch = <refspec>

See git-config(1) for details.



But the actual problem is that "master" doesn't exist on origin.  So
basically I _have_ told it what branch.master.remote and
branch.master.merge etc is, it's just that they don't appear to exist.

Thanks,

John
