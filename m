From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: pretty format can't work on cron job
Date: Sun, 7 Nov 2010 20:18:31 +0100
Message-ID: <201011072018.31740.trast@student.ethz.ch>
References: <7B2091481B9ED640A92789B0CA07059587CCF7@CDCEXMAIL02.tw.trendnet.org> <20101105131444.GB11707@sigill.intra.peff.net> <01c101cb7d6c$fd053cf0$f70fb6d0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: 'Jeff King' <peff@peff.net>,
	"Chen Wang (QA-CN)" <chen_wang@trendmicro.com.cn>,
	<j.sixt@viscovery.net>, <git@vger.kernel.org>
To: Chen WANG <ellre923@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 07 20:18:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFAlG-0008HQ-Pz
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 20:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540Ab0KGTSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 14:18:37 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:59304 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824Ab0KGTSg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 14:18:36 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 7 Nov
 2010 20:18:33 +0100
Received: from pctrast.inf.ethz.ch (129.132.209.35) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 7 Nov
 2010 20:18:34 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.36-90-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <01c101cb7d6c$fd053cf0$f70fb6d0$@com>
X-Originating-IP: [129.132.209.35]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160898>

Chen WANG wrote:
> $ cat /home/wangchen/kps_update
> #!/bin/bash
> su wangchen -

What is this 'su' supposed to do?  AFAICS you would have to run
another script with 'su' if you really want to change user.

> git log 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2.. -M --date=short --pretty=format:"Author: %aN <%ae>; Date: %ad" --shortstat --dirstat --no-merges >/tmp/ChangeLog-all
[%aN does not expand to anything within the cron runs]

Also, what git version(s) do you have installed?  %aN appeared in
1.5.6.4 and 1.6.0, so it is entirely possible that the $PATH within
your cronjob runs an older version which fails to expand it to
anything.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
