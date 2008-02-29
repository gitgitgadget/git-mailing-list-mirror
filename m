From: "eric miao" <eric.y.miao@gmail.com>
Subject: Will git have a baseline feature or something alike?
Date: Fri, 29 Feb 2008 17:23:37 +0800
Message-ID: <f17812d70802290123raa099bag17a6f7b89de65dd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 29 10:24:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV1TW-0006OF-Un
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 10:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbYB2JXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 04:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbYB2JXk
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 04:23:40 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:64656 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbYB2JXi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 04:23:38 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4562638wah.23
        for <git@vger.kernel.org>; Fri, 29 Feb 2008 01:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=99v/Nn/C6Pdid9+w18DR0RQkHjSsiRI1YCaaMI1l3LY=;
        b=DAgQk5vxvCbVr2yXY6zxsBAnkv+mjlNGTKgYYUdlQFT3CHreqwea99s3EilLRxczS1JHvsfSOdGS075lKE0GDObCKqi89qBQrlFHCWHJNNW4J9tT0eV8OYsRm0JqAzCYdiGDiUy/w2VYHayprCvVvfq5uo4/xRC5ui+WyXIZlXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SrOd/GY4KJZ4JTbuuJRZn64asqkCTPV452w8TKSEgu/nli+QgbFvfeehdQUzN4EXcOjbiO4MWKmY/Xoqwhlrqhj7kEni7LEekM4nP1J5YMYAHqV+R+yHvqRxvbRi82xKUosWeQdzoTPj03srjtVDQ7QXIZ7FLPA7a9rpGr/2N+U=
Received: by 10.114.169.2 with SMTP id r2mr11023684wae.30.1204277017825;
        Fri, 29 Feb 2008 01:23:37 -0800 (PST)
Received: by 10.115.75.13 with HTTP; Fri, 29 Feb 2008 01:23:37 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75516>

All,

I kept a mirror of

http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

by a crontab task fetching the updated commits at midnight everyday.

Yet I found the repository now grows to be 1.2G without checking out
anything. The checked out working tree of this is about 1.5G.

I tried "git prune" and "git repack" but it still remains so large. The
trend of the kernel is still going to be enlarged. Thus I'm thinking
of the possibility of a baseline feature. One can totally forget about
the history before that baseline, and start the development there
after.

E.g.

1. user downloads a released tarball
2. and build a repository
3. and "git fetch" will find the current repository is identical to
a baseline in the remote, and fetches only commits after
that baseline
4. continue the development work

The above steps with current git will generate a totally different
hash value for the files in the downloaded tarball, thus making
it failed to fetch commits thereafter.

I know the history is usually mixed with multiple branches, which
makes this baseline feature a bit difficult to implement. It should
be a nice feature, though.

-- 
Cheers
- eric
