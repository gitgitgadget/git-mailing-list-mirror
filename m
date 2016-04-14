From: Ulrich Buchgraber <ulrich.b@gmx.at>
Subject: Data loss when using "git stash -u" and ignored content in directories
Date: Thu, 14 Apr 2016 11:16:57 +0200
Message-ID: <CAGxq=N-n5Vt-L4iaU2AyqYbH7oA-XcERx+oUWuSOj+rD2=MhLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 11:17:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqdOh-00017N-Aq
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 11:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbcDNJRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 05:17:05 -0400
Received: from mout.gmx.net ([212.227.17.22]:62180 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbcDNJRB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 05:17:01 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]) by mail.gmx.com
 (mrgmx101) with ESMTPSA (Nemesis) id 0M7CRe-1bkH3U1zWg-00x3Tw for
 <git@vger.kernel.org>; Thu, 14 Apr 2016 11:16:58 +0200
Received: by mail-yw0-f178.google.com with SMTP id t10so97657512ywa.0
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 02:16:58 -0700 (PDT)
X-Gm-Message-State: AOPr4FVXCDIA7AgkK9a7RfMtN8v0cR52XGubGViHin31MJvG1TKD8lLWAWRScfZ6pEBkwu7Oqp/JslLgVPhg0g==
X-Received: by 10.129.119.213 with SMTP id s204mr7823627ywc.95.1460625417335;
 Thu, 14 Apr 2016 02:16:57 -0700 (PDT)
Received: by 10.129.112.210 with HTTP; Thu, 14 Apr 2016 02:16:57 -0700 (PDT)
X-Gmail-Original-Message-ID: <CAGxq=N-n5Vt-L4iaU2AyqYbH7oA-XcERx+oUWuSOj+rD2=MhLA@mail.gmail.com>
X-Provags-ID: V03:K0:6lcFRKtiTVDeRyua+efFu08rY8CI7VHG5Ad89KfEmL2J3Nme1Vf
 Pfn5aBTZLoAOMstNNP6F7akE2TM0lmSPMobCX2sSjpBq/CCzXXetL3BsQkLtOn55H3WkwxV
 FLO60+0y3JYyImcwZTLMrT1g7ejp+J7Cj2ZNpmb/r7221QPr2W5vPi5DYlpKYMiq0AyPEw+
 d9jUESVLcii+veaw2aFvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:68vENgonZwQ=:Q6VUfcxWic/eX6NGpjFB/p
 izniw02q6ThQdUpQ20FU6nDRrKiK4djXI8aZxMhqvGqQfOfE8XiyaZ1zFndtgTWkpeF+yKFDr
 Xfpnua8eGnsll9wdQLAr93vIBR+hqh/1zGwkpbyypOx64WGC9FFRt+/uIHzCfRgJoiev/fByK
 P8xJd5IIEPgNQ9QuRbPtXYUYxkNdrp8jvwB/C9FL1t1hLkOtMwi4gYQ0ISoxJBwkO0RUcf6FM
 TyA+qujqoUIO8rTtw3ciP9zQP6oloC24WKr8t0/YhJoqAKSV1SbdOyUtFDSnMbzX3Pdk0dyNn
 L9jTUVPogCWsBTg0TMyxcSfVDOek7mZPJYpVtgCIsVcsDcXJmZX4fidfu4vStVbIlEtdX5qID
 w51GCyo/S1g5mVOK3Y4WXhAraunqjZdcRqtnDz1HKTdRcst/fTsXzmMpn4o6Er0d5OiDe2Wex
 r40ZZ7aICCXr0K3vKMe9g9EZ7JC7KJSdMHtk1Eu8wk9jmh5hDAUQB0FqrFMTg9HktPuV2LEo5
 nooknyoYWL320fdSFLF6r+6FI5cOgp1JQ/x6NxLTeuw1DSadvPr8a/Mm58RJDbhoHQ1cIqq0m
 2a5/yxzw1QV+5hugDsgWnLwytHNHutsuMr8z6giywzGGfs+BezqMyPnRDyeRqJto1GdCflDwC
 enXpXqIEoISXfynAa3X4uwOhbyVyfV6fjBUVV9ikO0Fs3AldrS2mKV3U5RwANkr+qWF8gNlZN
 Ou7LoZOl54rP7mrNJOK0x4u2kRP3vBN+7Dg28R4M6kKfSy4YonKDdW4saJyA+JwgQpKnmQlw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291517>

Hello,

A "git stash -u" cleans all untracked files (after storing them), and
normally does not clean ignored files.

But: It cleans ignored files _within_ a directory, when the directory
itself is not ignored, but its content (e.g. a "dir/*" ignore filter).

The bug seems to be that in the cleanup phase of "git stash -u" Git
immediately deletes untracked directories without checking if there
are ignored files in there.

See the following reproduction sample. The last "ls" command shows
that the file "ignored_dir_with_star/ignored.txt" is lost.

    git init

    mkdir ignored_dir && touch ignored_dir/ignored.txt
    mkdir ignored_dir_with_star && touch ignored_dir_with_star/ignored.txt

    echo "/ignored_dir" >> .gitignore
    echo "/ignored_dir_with_star/*" >> .gitignore
    git add .gitignore
    git commit -m "added ignores"

    touch untracked.txt

    ls -R
    # => Output:
    # .:
    # ignored_dir/  ignored_dir_with_star/  untracked.txt
    #
    # ./ignored_dir:
    # ignored.txt
    #
    # ./ignored_dir_with_star:
    # ignored.txt

    git stash -u
    git stash pop

    ls -R
    # => Output:
    # .:
    # ignored_dir/  untracked.txt
    #
    # ./ignored_dir:
    # ignored.txt

Note that there is no data loss when instead using "git stash" or "git
stash -a".

(Tested with Git 2.8.1 on Ubuntu and Git for Windows version 2.8.1.windows.1.)

Ulrich
