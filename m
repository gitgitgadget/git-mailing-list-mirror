From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: specific push default
Date: Sun, 27 Jan 2008 17:58:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0801271751490.3323@pollux.milkiway.cos>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1038705986-1201452721=:3323"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 18:59:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJBnO-0000YW-8F
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 18:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbYA0R7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 12:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752467AbYA0R7T
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 12:59:19 -0500
Received: from mailout03.sul.t-online.de ([194.25.134.81]:39233 "EHLO
	mailout03.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752272AbYA0R7S (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jan 2008 12:59:18 -0500
Received: from fwd33.aul.t-online.de 
	by mailout03.sul.t-online.com with smtp 
	id 1JJBmm-0003Hb-00; Sun, 27 Jan 2008 18:59:16 +0100
Received: from pollux.local (bKhKwyZAYhuOWyG+kupOx-sMqnXAKJ75a6tFjNWgCvTcnNqPOd6DTGtCZIEbnjcgBK@[84.163.209.54]) by fwd33.t-online.de
	with esmtp id 1JJBmU-1napYe0; Sun, 27 Jan 2008 18:58:58 +0100
X-X-Sender: michael@pollux.milkiway.cos
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Content-ID: <alpine.DEB.1.00.0801271752430.3323@pollux.milkiway.cos>
X-ID: bKhKwyZAYhuOWyG+kupOx-sMqnXAKJ75a6tFjNWgCvTcnNqPOd6DTGtCZIEbnjcgBK
X-TOI-MSGID: fe3ea902-f230-4852-a7b9-b41f78fc47a2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71824>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1038705986-1201452721=:3323
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; format=flowed
Content-ID: <alpine.DEB.1.00.0801271752431.3323@pollux.milkiway.cos>

Hi,

the model I  use git with has a central repository that is cloned by
developers and fetched and pushed into from developers. So the model is a
bit CVS like.

In order to have git fetch, when used without arguments (default behavior),
to fetch from all the branches in origin but to have git push, when used
without arguments (default behavior), to push only the current branch I
use a specific configuration.
For illustration I have created simple stupid example repositories attached
as zipped tar file to this e-mail. The example provides two sub directories.
The sub directory "cr" holds a bare git repository used to resemble a central
repository. The sub directory "dr" contains a git repository and a work tree
resembling a developers repository.

There are two branches: master and green. When git push (no arguments) is
invoked from one of the branches only the current branch gets pushed into
the central repository (cr). On the other hand if there where updates in the
central repository git fetch (no arguments) would fetch all branches.
Of course merging would only be done in the current branch.

This is probably a very specific way of using git. It took me a while to set
it up like that. Maybe that's just me. But maybe there is somebody else for
whom this e-mail could be of help.

Here is the .git/config of the "dr" directory:
[core]
         repositoryformatversion = 0
         filemode = true
         bare = false
         logallrefupdates = true
[remote "rmt_master"]
         url = ../cr
         fetch = +refs/heads/*:refs/remotes/origin/*
         push = master
[remote "rmt_green"]
         url = ../cr
         fetch = +refs/heads/*:refs/remotes/origin/*
         push = green
[branch "master"]
         remote = rmt_master
         merge = refs/heads/master
[branch "green"]
         remote = rmt_green
         merge = refs/heads/green

Hint:
when e.g. "git remote add rmt_green ../cr" is used the remotes don't get
setup like that.A
"git config remote.rmt_green.fetch '+refs/heads/*:refs/remotes/origin/*'"
would be required in advance.


Cheers,
Michael


--8323329-1038705986-1201452721=:3323
Content-Type: APPLICATION/X-GTAR; NAME=pushex.tgz
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.1.00.0801271752010.3323@pollux.milkiway.cos>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=pushex.tgz

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
+CcOnH3r7zYMPnPd1ovevfXOF3Z/ZsPBLa8cHr7ztR9f2n390zf/e+Qvn71d
/kL8vmcGr9b6nrn81buHLzp828s/Gfr6bT3dD/2+0v30skPHHr7mnPg//u2D
S1/3XBc7o0Vaun/t1x9c9Yc7ptYpIztX/OD90eQt9//83w7dQd+a+dUX3469
9NgTm4buv+Wh139z4XffPHLvBT/0W4f/Y+3Sz+9+d+8/3PvkUPrtDRt+crpn
avMfLTaaPrKlDv/LyuLI/6jiyP/m+V9DSv31TyYjupxEgRyn8SjVNVDNUz2J
br0nSbswUqMnHpO75zPG3Pp/xfqj+t+8/6chRej/39RB/XcU/+ChM6TFhqtZ
GlPq8H9CXmT9P6405X8jSv3174p19aiqpnd3g94f17rjcioGv/RIj5xKxvUu
LZFKxGPzGWNO+R9XKvV/JdqU/w0p00s6A+s3bo/EU5EYZuL5NNsEqP/At157
/eqh04+1b37kvffvODb9tbvuuvr3Wsgnzjuy2BA3y0KWOvyvdS+y/z/W1P8b
Uuqvfzyq9qS643pUjcmqGk2qiVg00R1P9MhROZqKUZpQosnofMY4IfnP/f9y
M/6vMaWO/J829n1w0/cS//zjm79wwTOfbL3rs+/89ezys1uWnna+stgQN8tC
ljr8j7czLsr7n+L9366m/G9MqSf/k4sc/y83z38aUuqv//ziQuczxpznP12R
qv0/0dz/G1Kml9x7y0bvkcj5a3a9deHLZ1/23D0HLlw98uj/nn+bnrzxt3dv
/LRlvdj66K9fky792Y3HIvnhiyfPo+odL/Z9bdneO/c/uOxzKyeWHH56zfV/
nj7w4soW+dgR7cv7C3te/FE8cNdZf3DP/rMuPv3a9YGDX9p+zjmTgzuN+4Zf
fexfLvjlzx9757H/3nvxZ19TNs8+efiBv3n7U6/c9ur2Qy89/KM1xuTjW3dc
evuO9c9Y5utPDr/xxJOXfOfMlw5vOrzYePqolnr+n9hi+/+a+39DSv317+lW
I1RWdbD2ItEuGqMxRU1qqaRMlW4aUVLxVLwrEZ/PGHOf/1Sd/yvx5vsfDSll
8V/+548G120vxn89e+bBxQavWU5xqcP/C3oZ/MnYf83zn8aUevp/12LFf8QT
3P8ba65/I0r99VdpknZ3x+NUUXpkLdnTlYrHovFUN2zS3VqXovdo8WRiQeL/
InG5fP0Vfv93c/8/9aWO//f8f/1+50//86t3vv/e7ueev+Hgb077XHRrW4vn
wLkPLDbAzbKgpQ7/RxOLK/8j8eb9/w0p9dd/fvcCzWeMOf1/slIl/7ua/r+G
lOkl9948eO4Rcn5L///ccPhgbP/+mPzs9Vd+asnb8VfOSu5f89vDzw48dazN
/qunbo1OvfBD89rLTnvkOt/Mz/7Y6O+46e6vHHr5289tmFx+9ewlL36n/4vf
/MW3tz0a+cF1Fxzq/Pv33lz6jTd+4Q9I31hqP/Zu9PEzgz89a/0G+siVO57a
0RE444P3vvLBuZ4n7Le+tFu64Tzvn61+YbEx8fEsFfzvpN1d0BeAT9z+iyXi
zfd/G1Iq1t8wdTq90GMwFf+48r94/4OMuSDhoRJt+v8aUlav2zIEf06DnyVr
D2ks+cvaQ39a4E9PP7PltF/+uqXlunvg8e/gCx1+zvuv6PP/1PbeZdq3juy+
aMlVb76z/uB3P9NyxoQFKGKttm0ZHoY/n2yRScR7VLv/V5newQf67huaHv+y
vGLTW60PH10+8vzYzPabjj30+P0Hbn7q9vxX3/AvxuSbpZL/eabIBR7jJOR/
tHn/d2NKzfXP5uhC5gCfQ/5HlVhl/pc4W/+m/D/1ZX75vy2yh+aM1AyZEpnA
1aRVYN8nqcj8jYl6oYchniI8OUN4FlqWFJwlhjStUubeECHbJpwxJjDpI8vx
WKpqStfSnIV5JfMFW2QTNmy7gEkiVZOo2WzOyuYMNU9Jhtq2Ok6JgXkisQcV
UwPnsbGVZfklORQnmZJcpDfGDMdpY3wCM1dmLN1IGTBLTI0JONNzdIpstHJ5
y2y3yRU0l8I0l1eoeW0iVMyTidkpDTOfs/SCRsWkYaJ5MqHugcFzqpFmGTAn
jDy1s6qGKdTJYNq2COjj2qSTIBgVNBOwgnczsdSbmC156xWwDlAB82ZuG1wF
UBsphv8c3SNl1ZxNiSSJFcQMb0QZCOt0T9gspNNewJDp9WBtmFVKYhogkbJE
2giNNBVG13kjSfJSdt9TK9k0PLx665Wbt2zoJVPFyWTF3FSCHfGVBIhpJpuf
gQlSWG+aY80BOmjm5OrULbZKNuYYYkAaGp+fk3baMI28oaaJkckCkkNeT683
ZZB93izNpYlESbuXQMnMkLaUVTD1saSq471VfaWvYVUxhVHpG7zuKgckO+Y8
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

--8323329-1038705986-1201452721=:3323--
