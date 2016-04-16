From: Ulrich Buchgraber <ulrich.b@gmx.at>
Subject: [Bug] "git stash -u": Data loss of ignored content in directories
Date: Sat, 16 Apr 2016 15:14:17 +0200
Message-ID: <CAGxq=N8FsLapC2S_oDyD5ZcjWv6OLCPW2DXA219weLA6HthjUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 15:14:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arQ3R-00019y-Nn
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 15:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbcDPNOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 09:14:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:59845 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272AbcDPNOX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 09:14:23 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]) by mail.gmx.com
 (mrgmx001) with ESMTPSA (Nemesis) id 0MhhwJ-1b4OV61lyN-00MtN2 for
 <git@vger.kernel.org>; Sat, 16 Apr 2016 15:14:19 +0200
Received: by mail-yw0-f173.google.com with SMTP id i84so162112363ywc.2
        for <git@vger.kernel.org>; Sat, 16 Apr 2016 06:14:18 -0700 (PDT)
X-Gm-Message-State: AOPr4FXegrqAmSObDTObgTemumPWLL5e79ORx31uTEg9ArHAWTkMB4CGkCPdLw0MiBMzJIQ/BWZrkaKSKMPKug==
X-Received: by 10.13.251.135 with SMTP id l129mr14795184ywf.283.1460812457992;
 Sat, 16 Apr 2016 06:14:17 -0700 (PDT)
Received: by 10.13.209.65 with HTTP; Sat, 16 Apr 2016 06:14:17 -0700 (PDT)
X-Gmail-Original-Message-ID: <CAGxq=N8FsLapC2S_oDyD5ZcjWv6OLCPW2DXA219weLA6HthjUA@mail.gmail.com>
X-Provags-ID: V03:K0:rLeHGBcmcv6C/l6AAqrL1UbCz3Oo06iAI2gxTQCS0mhS+wYQGfF
 2Mqb3Gr98PgnH6Jn3ktxA5DQbZxwEtdpUSdW5AubR7fX9c2LUoev+c3Ny/3MoKSgNfBLFdt
 o3W4YlO/WcPYhvORZOObzCwGElfabZVKex8/Wcltcwb2fchbY5C7ZcZzBnPo4nV9AnAzlCt
 pdV0jeRIJakWsJ1jELcew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PqzWNqlrne0=:t+K8XPF/uuO/I7Pf4Axyqp
 +Ikmi02KOhmElDbxQQKXwa2h3dnfHiTocgZp212qlwGWs705ye5ptXY4zRxjf8eGkxI+Ab+pG
 hr4mQxUjWAb7NB2RVlOIYPHA4gc0aL3jw596/m0I8HzBvGugkwBpRU2SDJhpvP++zgmVxX1YA
 cC7UerD/Wgj9ko4ze06WYUGi7IO95dhoEMSHBsgTsYcbmh4agGKNXWuFrIXkSHj54YgDZCo5E
 TKFXlLTE76h3mPd6sZV1lIYHRo6xIJ4A3csjE0N1Pbo1x5ytBXweFr62lW/oYjlpTOCvRJLyl
 9YUIbGeQEmMavRnGR7/LJQcoangtgjr8OekU+pZ6ZueOsLuYvgHi8e7QYJfu5QsppTnoCUShx
 Qumdcl/K30fKSot/670i6mKjv7d+KRn2BoTlQeosPdQqmcpk9YiH0Y1oFddBXoSdMUPDeKXGR
 aeCDr76JjI5DxiQLsoDXT6UM7vR2Nf8JYY1urEB1AG9PFHIHjxo002uex0X1QWr/GCSnW5Baw
 LCUKEnL889pdh9rfCUynxnkNGNxqPwuQYE36N/XHQXiXuzLrh5KXqohV2gpnZ0ujO0TD0jAHn
 tPIBEhj1+i/X2Noa7D5gQ8Aomv7SIqWCpbw//d+beP3/nnIWbSn0hptibbV/yb0PGNtrWvyaQ
 Hsbv9vYzG8KVHmeiXs0qHaujvk9/JePpTaaTgzNmfRaz+TvxioSr1r8dRlcJc0YM/ZbRAFXv6
 l2wnU2Bbg33psT3p8Vyu9TUhjTtILKGdn1FRmhDr1C9UWux89/TBQNXlQ05K9U/ykySACYTU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291721>

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
