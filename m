From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: git-daemon on NSLU2
Date: Fri, 24 Aug 2007 16:27:34 -0400
Message-ID: <9e4733910708241327l664d5077k175c13a2c386dbaa@mail.gmail.com>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com>
	 <20070824062106.GV27913@spearce.org>
	 <9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 24 22:28:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOfle-0002Tv-Hq
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 22:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760356AbXHXU1g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 16:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757259AbXHXU1g
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 16:27:36 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:62670 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760421AbXHXU1f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 16:27:35 -0400
Received: by rv-out-0910.google.com with SMTP id k20so731505rvb
        for <git@vger.kernel.org>; Fri, 24 Aug 2007 13:27:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F0iiUEq3OV5alwEjvAcstaeamsY0hqU82CQUEie5Kuj02JCmxWJlYZTeSCN0c2QMK+g2f1+w3iIJkyz//kEiTz2gqnFtmts4jEV5/96fbEwWihmagvwhBycIeb7Ot4paat4pNNvlMKHA9UCgmflHs4CDhkZInocURFe6gr9Rahs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kiQsudjAQujvXXIf77UWvOWDXCr2+RoDVLu/mYLSe2MpSuNXz2dYcnX6lKrwr/sz5/DbrR2n8eKq3L7pnEgjvOb6Aj+dPUk9nXwRYnHl3fusQGmBxRsG1nkSP2EYsxdfOj6r8+dOl4WY1ZIX5QgcvXzA4x5zDgR67rY0xLQEiAw=
Received: by 10.114.197.1 with SMTP id u1mr1809926waf.1187987254399;
        Fri, 24 Aug 2007 13:27:34 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Fri, 24 Aug 2007 13:27:34 -0700 (PDT)
In-Reply-To: <9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56599>

Not sure what I did but I have git-daemon working on the NSLU2 now.

It is unusable with 32MB physical memory.  I am 2hrs into the clone of
the kernel repository and it has only counted 9,500 objects and used
100min CPU time. There are 540,000 objects in the repository.

Disk is chattering insanely, I'm way IO bound.

procs -----------memory---------- ---swap-- -----io---- -system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
 6  2  37960    972    168  11952  160   64  1748    64 2224 2233  5 28  0 67
 4  2  37960   1012    176  11756  168    0  2424     0 2517 2780 10 29  0 61
 2  2  37960    944    200  11792  152    0  1456    88 2102 2067  6 21  0 73
 2  2  37960   1120    180  11620  120    0  1180     0 2106 2122  4 21  0 75
 2  2  37960   1044    180  11788   76   28  1800    28 2255 2275  7 27  0 66
 4  3  37960   1144    176  11436   68    0  1896    12 2384 2553  7 23  0 70
 4  1  37972    992    188  11932   44  188  1148   188 1910 1731  3 18  0 79
 3  2  37976    804    196  12008  336   16  2104   112 2353 2490 13 22  0 65
 2  2  37976   1068    164  11720   96    8  2008     8 2502 2731  5 36  0 59
 2  2  37976   1280    184  11528  140    8  1332    36 2054 1956  7 26  0 67
 4  2  37976   1028    200  11552  264   16   956    16 1855 1710  4 20  0 76
 2  2  37976    844    192  11680  144    8  1576     8 2206 2307  5 31  0 64
 3  1  37984   1304    172  11264   92   28  1444    52 1998 1887  5 23  0 72
 2  2  38000   1012    168  11680  124   84  1896   192 2385 2486  3 30  0 67
 5  2  38008    928    164  11916  136   20  1776    20 2256 2308 11 22  0 67
 2  3  38008   1168    184  11704  144   20  1820    32 2163 2186  5 24  0 71
 4  4  38016    816    156  11784  248   32  1828    44 2328 2422  2 24  0 74
 4  1  38020   1476    160  11448  152  104  2080   116 1925 1728  3 24  0 73
 2  5  38028    828    192  12140  240  140  1768   232 2319 2226  4 29  0 68
 2  2  38020   1136    172  11880  156   16  1764    72 2081 2020  3 20  0 77
 2  3  38060   1040    172  12016  188  140  2056   140 2180 2182  6 26  0 68

root     11241  0.3  0.0    104    24 ?        Ss   06:54   0:07 runsv
git-daemon
gitlog   11242  0.0  0.1    124    40 ?        S    06:54   0:01
svlogd -tt /var/log/git-daemon
root     11335  0.0  0.4   1620   140 pts/0    S+   06:56   0:00
strace git-daemon --verbose --export-all /home/git
root     11336  0.0  0.4   1808   144 pts/0    S+   06:56   0:00
git-daemon --verbose --export-all /home/git
root     11344  0.1  1.0  60240   328 pts/0    S+   06:56   0:02
/usr/local/bin/git-upload-pack --strict --timeout=0 .
root     11349  6.5 50.8 171868 15240 pts/0    D+   06:56   2:09
/usr/local/bin/git-upload-pack --strict --timeout=0 .
root     11350  0.6 14.6  16392  4380 pts/0    S+   06:56   0:12
/usr/local/bin git-pack-objects --stdout --progress
--delta-base-offset


-- 
Jon Smirl
jonsmirl@gmail.com
