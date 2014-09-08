From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Check out git-author
Date: Mon, 08 Sep 2014 09:16:20 +0200
Message-ID: <540D57C4.7000602@web.de>
References: <0a3b0f232ec56517d4db43c6bd6ebb63@cs.wisc.edu> <20140908051956.GA8987@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, xmeng <xmeng@cs.wisc.edu>
X-From: git-owner@vger.kernel.org Mon Sep 08 09:19:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQtEA-0000Oe-JH
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 09:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbaIHHTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 03:19:01 -0400
Received: from mout.web.de ([212.227.17.11]:64401 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752684AbaIHHTA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 03:19:00 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LwHkw-1YSDga1I34-0185Qk; Mon, 08 Sep 2014 09:18:50
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.6.0
In-Reply-To: <20140908051956.GA8987@peff.net>
X-Provags-ID: V03:K0:+gSuez1LM3KrAncga/DIXRsQCm4nHT1neYBeRXAXfhafb0UjaDP
 IDCC41gu+5MfXfVrqAyjjYobJBmj9Htdc3pOeeyDATk9IS4XerDdqNPtWpXzelAtNLW0Avz
 wqfzRDruig9obyZhSAYK3LzpvMEZCcbJlP/Qp0A6mponVZe3CfgTdV5OJgdv96eEB4Dy10m
 X4utDwOhu3gAPundpaIAg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256633>

On 09/08/2014 07:19 AM, Jeff King wrote:
> Have you tried "git log -L 2235,2235:fs/ext4/mballoc.c --
> fs/ext4/mballoc.c"? Can you compare your approach to that of "log -L"?
>
> -Peff
>
Nice, but it doesn't seem to work 100 % (?)



tb@linux:~/projects/git/git.pu/t$ git log t3910-mac-os-precompose.sh | 
grep "^commit"
commit 1265886303778b5a2631c41c6ee61094c5fda7b0
commit a4cf6b4b91835c1d8d13ebb5cf3ce9241e181f1b
commit 750b2e4785e5956122b3c565af65eb1929714fba
commit 92b0c8bed0d3f6ed5442e3ffa178413772faa31b
commit 308566eb8b35b9279082bd5398c4252169d52b22
commit 76759c7dff53e8c84e975b88cb8245587c14c7ba

I'm quite sure that line 15 looks like this in the original commit 76759c7d:

">junk/"$Adiarnfc" &&"

But it is not shown:
tb@linux:~/projects/git/git.pu/t$ git log -L 
15,15:t3910-mac-os-precompose.sh -- t3910-mac-os-precompose.sh
commit 308566eb8b35b9279082bd5398c4252169d52b22
Author: Michael J Gruber <git@drmicha.warpmail.net>
Date:   Mon Jul 30 11:57:18 2012 +0200

     t3910: use the UTF8_NFD_TO_NFC test prereq

     Besides reusing the new test prerequisite, this fixes also the issue
     that the current output is not TAP compliant and produces the 
output "no
     reason given" [for skipping].

     Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
     Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.sh
--- a/t/t3910-mac-os-precompose.sh
+++ b/t/t3910-mac-os-precompose.sh
@@ -10,0 +15,1 @@
+
============================
But line 20 seems to work better (I shortened the output by using grep):

tb@linux:~/projects/git/git.pu/t$ git log -L 
20,20:t3910-mac-os-precompose.sh -- t3910-mac-os-precompose.sh | grep 
"^commit"
commit a4cf6b4b91835c1d8d13ebb5cf3ce9241e181f1b
commit 308566eb8b35b9279082bd5398c4252169d52b22
commit 76759c7dff53e8c84e975b88cb8245587c14c7ba
