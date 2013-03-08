From: =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>
Subject: svn-fe + git-fast-import bails out on certain SVN commits
Date: Fri, 8 Mar 2013 11:21:45 +0100
Message-ID: <CAJ+HfNiLYYzpDN2NNzw99=z_PcbKtb_3fTneOkNOdJymSbB-zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 08 11:22:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDuRI-0007jl-T8
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 11:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab3CHKVr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Mar 2013 05:21:47 -0500
Received: from mail-ve0-f172.google.com ([209.85.128.172]:48643 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab3CHKVq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Mar 2013 05:21:46 -0500
Received: by mail-ve0-f172.google.com with SMTP id cz11so1151053veb.3
        for <git@vger.kernel.org>; Fri, 08 Mar 2013 02:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=Mx1ntWg97iHOl3cZ0WFHvyq5XQnm3+Y3eBGAnSO/4+g=;
        b=kOutpNrrUT+ohR81qNJ+2gXqfHOEddO4pgfJALSAwhX97g20Heh9/h9ABjyhHI3S+U
         ZpMw6R/nGal61f6KXloP/5Jx7Wbi7kyqQOmoAY6qij7gbC0iZwJ1WgkJJiYNGAV5JWSH
         ejMTSMqGauxquJVVXrYXp/Cg4XIFIsqEI5pG0RUfUySSIX4wDEBEbX2mHHuoJdSZ4K7O
         L7KT1zybCVSNBJfG9jLUpbUbxyWh6vp2ngzw9rQnkrq6oe9EGj2U/1e/HPtGpZMf/aO+
         8G7RJX6gyhVXzWIdecP+McYaRuurt6EDgHs6IorqZPk7DwXSaUrIZ/sYSZAgRyMpkdHe
         IY/Q==
X-Received: by 10.58.46.134 with SMTP id v6mr690739vem.45.1362738105480; Fri,
 08 Mar 2013 02:21:45 -0800 (PST)
Received: by 10.52.155.211 with HTTP; Fri, 8 Mar 2013 02:21:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217657>

I'm importing a huge repository using svn-fe and git-fast-import.

$ cat repo.svn_dump | svn-fe 'svn+ssh://bjornto@example.com/pub/repo/'
3<backchannel | git fast-import --cat-blob-fd=3D3 3>backchannel

git-fast-import crashes with:
  fatal: Empty path component found in input
  fast-import: dumping crash report to .git/fast_import_crash_10844

Crashing command:
  * ls :202791

Where the crashing SVN commit is "svn cp $SVN_ROOT $SVN_ROOT/subdirecto=
ry".

A Google search led me to:
http://git.661346.n2.nabble.com/BUG-fast-import-ls-command-on-commit-ro=
ot-returns-missing-was-Bug-in-svn-fe-copying-the-root-directo-td7353801=
=2Ehtml

As far as I understand, this issue is fixed in fast-import, or am I
missing something? Is there a way workaround this problem?



Bj=F6rn


$ git --verion
git version 1.8.2.rc3.dirty
$ uname -a # Ubuntu 12.04
Linux bjorntodesktop 3.2.0-38-generic #61-Ubuntu SMP Tue Feb 19
12:18:21 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
