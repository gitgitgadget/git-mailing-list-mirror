From: Nate Parsons <parsons.nate@gmail.com>
Subject: git .lock file error
Date: Mon, 13 Sep 2010 11:19:30 -0400
Message-ID: <AANLkTikjwW8jJ3qGCAM=8F_GBxsz9_KoSW0KDGPKhXGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Sep 13 17:20:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvApC-0006HO-VV
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 17:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006Ab0IMPT5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 11:19:57 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39973 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986Ab0IMPTz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 11:19:55 -0400
Received: by gxk23 with SMTP id 23so2062591gxk.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 08:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=OqlMRefNfgR4kgTlddxqLCsGfq5rNL0B/JVScjLPySU=;
        b=s4Gv9sF/TAJgNRzbvYkIZ1w2W4lUjE85itZtQq47XVjHe6IaDnPjdVfRfqxpLAl3vM
         x3r1lrPGNjfNI0dAoWMEFHmc/pq45P9b4Y4ti00uG4T0djKgnLDI3TMePAd7sS/2jAvL
         op868zdqxQQKBRPZ+3GQoDrGA3Vkz1AD/3HMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=ZIqRxApUO9Y61igFspbaCBDvkk6EHarSRqgD63/Yt3CAMGLnLqV5e7QGlFHPvBYRqd
         bpSdoCFTetN7OQsJIOijiImwn0M0OyogkGq92T6H8z/8MwUELSiC/PVaRdypKqgXUprT
         k846b3wa3gXlnka9RPbhUFckX0yh72bcMUgIs=
Received: by 10.100.215.10 with SMTP id n10mr4499187ang.125.1284391194878;
 Mon, 13 Sep 2010 08:19:54 -0700 (PDT)
Received: by 10.231.113.141 with HTTP; Mon, 13 Sep 2010 08:19:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156098>

Hi everyone,

I'm trying to switch to git, so I apologize in advance for my
ignorance. For this, I'm using cygwin git, version 1.7.1 to talk to a
svn server running 1.4.2.

When I 'git svn clone' or 'git svn clone; git svn fetch', I sometimes
run into the following error.
> Couldn't open .git/svn/refs/remotes/0.0.0/.rev_map.b8cad480-e46b-48b4=
-8317-a683ee46c2bd.lock: Device or resource busy
> =A0at /usr/lib/git-core/git-svn line 5210

And when I 'git svn rebase'
>=A0Couldn't open .git/svn/refs/remotes/git-svn/.rev_map.cc05479a-e8ea-=
436f-8d71-e07493b7796c.lock: Device or resource busy
> at /usr/lib/git-core/git-svn line 1528

Sometimes the line number is different (578, I think?), but when I
retry the fetch command, it rebuilds the file corresponding to the
lockfile, and then continues a little farther before dying again.

When I watch the directory in question, I see the lock file appear,
and then disappearing a short time after the script gives up.

I don't have a series of steps to reproduce the problem, sometimes it
goes for an hour, and sometimes for just a few minutes/seconds.

I do have TortoiseGit running my machine, but this issue happens even
when TGitCache.exe is not running. If some other instance of git is
accessing the repository, I don't know which or how.

Thanks,
-Nate
