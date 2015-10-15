From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use the alternates of the source repository for dissociating
 clone
Date: Thu, 15 Oct 2015 16:11:27 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1510151609280.31610@s15462909.onlinehome-server.info>
References: <561F8DE9.4040703@cetitec.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Alexander Riesen <alexander.riesen@cetitec.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 16:11:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmjFr-0006d3-HC
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 16:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167AbbJOOLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 10:11:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:65134 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbbJOOLc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 10:11:32 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MSY2q-1aC3ds3ydQ-00Rbzi;
 Thu, 15 Oct 2015 16:11:29 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <561F8DE9.4040703@cetitec.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:ZW+gPCxndF3aNQSYmi+oKLoIt0lFD/1Fpwq2vH70lZhgDQiwVOl
 Kaw+D5OZOSEc461K7uJ+jife0ddrz0ZdrbVKeLKd0l5lEUCePd4J+8Zu5ge8U2BAC+A1HHt
 zQXSvOHFAp3I2zdA62rS4Hh/tg+2nzdP9mqIv37nEF1HXJyusx/XUfGGOV5s0ovslan+HRM
 aekZdLJn25tJnJh0dR6pQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ks4qTZPWCMU=:QGad9sYQhfRY0WJvarwbqz
 wUyB/iY0eLcGAK3Ke+Q3KOumudtla8pgGPwgKRYLmHTBij2hHyGr05jYbePaT02zU445c5SRf
 l0CzlKAwyEeae7bA7gtQl9S+2yhhV2rMZ7qWXkwQ94rclxws/XycbZb6sMtBikwuI+mo6r+AD
 JrUMesXNeE3uGpigI0Nr1GzkYBH3JlSt3TWCUhnSc2uDoywXWlHWCPWdKnk1K4R5CCSQpIuyu
 ELBUAt0ypa1OPf97BFuCpu89AxrgM3AnRTfU+Mi9d8On1TaIfuj+W80vNREbmx23ODWJe+kQZ
 YTXvQxzZ5oT5mD90IHm2JNV9sQo34wqB17Nv2XV8L4GcEF3fVq7LsWaANy+Narx5ZjfnsRBxu
 15QKvx01GOlPcbAJGdoDyteZpBsHY2Jhbg+nNG8pKvTg8JSs6wsBVx2eOvNLYEbvhFseoTWxH
 CMRWICbBSN0Q3Vc/9cS51PsLNNFvv2tOl0MZsECZ24igcG0So949RCMQZcLt2tAifPziArVbn
 WLIPQoYC+l9VRhidIFbTA0Cq720MZ5Oqv4a2/XUg55ychg77MEkw4GiUhIIClH8M1I+c55S2X
 mxPTjeGah/yab/p85djkyYMunPb8OcvZAj8X2SliH5XDig5eWLFKGV3Z9G3F1sIT2gh213e9C
 yVgC5OhiDdkSsrMwfrr2+7DGKIoworhr5cCPglwZBMuGvNFtvEJJBEXGafTuSKpvOX7liFbeC
 Gtl7gxJyxWV6HCcV+yNY7kOsAXUndcUr0txDoMKyUdr7BPZgICpK9uzlJVvknINwmmiLAL6a 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279667>

Hi Alex,

On Thu, 15 Oct 2015, Alexander Riesen wrote:

> The "--dissociate" option required reference repositories, which sometimes
> demanded a look into the objects/info/alternates by the user. As this
> is something which can be figured out automatically, do it in the
> clone unless there is no other reference repositories.

Would it not make sense to reuse the copy_alternates() function to simply
copy the alternates and let `--dissociate` run its course with the copied
.objects/info/alternate file? That would make for less new code...

Ciao,
Dscho
