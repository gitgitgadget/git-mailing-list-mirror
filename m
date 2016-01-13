From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/4] Always release pack files before calling gc --auto
Date: Wed, 13 Jan 2016 18:20:02 +0100 (CET)
Message-ID: <cover.1452705584.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:20:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJP5n-0004iS-U1
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbcAMRUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:20:15 -0500
Received: from mout.gmx.net ([212.227.15.18]:52886 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932154AbcAMRUM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:20:12 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LomN9-1ZhcIp1hf9-00gmlj; Wed, 13 Jan 2016 18:20:04
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:DIVIjFAQfL/psIPjn55s0GKMeV91gMxeXtFOt1dmXfKalYC+p3O
 /yClTHcR4cJMuvBZ4OBUQLxfLb//TLeymBvQXczDO/AuniTGx92LyviJ3CmeaTJ1g0b9Xve
 tw1n7VPy21GyuFPpgBvv+SAi1+GYOt/UXITnZd4RGG2XuhvcjQPyQRGxCvNbLOSgYdNpaFb
 BEZbzYEtN5w9jotlimzCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dZv2EPmrtCo=:xEGMqg2CrWfoEB9ssUNqn9
 uW5619yfoY7cf0qJuMD+s6rNebpNu2bf3xMtfSCMkSeA5oQOXVPsizIsrXlwIOq7veDptOkB8
 MQ9ZKRcI2Y7sYv9grJ9kmC0bmo8Ibia3hhVYGThACfJySM+XKeN2Q1KbiXSGKOO7GXCCWE6sk
 SQ0H6QwoygvUnxqeTTJtuh3E7aqUf6vtSymSVL0k72A9wr8kJDpGkutdC9xeKBNkh+f4ZBefE
 NZxzymZubx6Y3s5QHlkbO50AyZ8+wTwY0M9s9IVWutmBSRiP9yRn8rSsOTK34UpfccqGIOaqT
 uXPDFwJOV4UHnpRcLjt/lvHHHFICVP3A5+eFhytNY+eBQpGEL7mc62E1DZWjE11P6Zv/XcEaZ
 Gdfj1bNzAzv+oWKAg7FmmJ+PiNAueKD55j8lB6nS0J+o7br2iU0ME1rFG+M1Yw4+eZuby6tIi
 pLyg1SxkVC8bpXypayR755yOf1be9iGTguyaPxp/l8YDnTHf5GKO+MmGdHQ+4cHnmEpJLt5kD
 Q8+iKhhGtSCM/nUC6M3gdfKeB8QYH3UpQ6Hr5bU8bC5sMQWDgqZP2YgTj84RPlNsjm5ZKHOuz
 GPHwJpKMkaub5PjOIGeTSsuBIAE+uyAwf0+8GB5yTU4wvvqQ3QWrz6e6A884WMayH9SLhSanp
 sjW+fFFrngMik2a5iDVNPmCn6oKIiswh7ysEhT/2s1GTCaI51GpwHPm6vHKuQ682wZgPX06GL
 cL4lLv1im0pImyZMQPB4MMROYstv9d7Zb6CGdzkugJvPR9m7FGXw3vWxkMolTQWlMrpATgfe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283947>

These patches are companions to 786b150 (clone --dissociate: avoid
locking pack files, 2015-10-06), triggered by a bug report to the Git
for Windows project.


Johannes Schindelin (4):
  fetch: release pack files before garbage-collecting
  am: release pack files before garbage-collecting
  merge: release pack files before garbage-collecting
  receive-pack: release pack files before garbage-collecting

 builtin/am.c           |  1 +
 builtin/fetch.c        |  2 ++
 builtin/merge.c        |  1 +
 builtin/receive-pack.c |  1 +
 t/t5510-fetch.sh       | 13 +++++++++++++
 5 files changed, 18 insertions(+)

-- 
2.6.3.windows.1.300.g1c25e49
