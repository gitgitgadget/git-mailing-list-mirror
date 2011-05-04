From: richard parkins <p1rpp@yahoo.co.uk>
Subject: cannot pread pack
Date: Wed, 4 May 2011 10:31:25 +0100 (BST)
Message-ID: <60260.35977.qm@web27605.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 11:38:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHYXN-0002Wq-FN
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 11:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967Ab1EDJiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 05:38:24 -0400
Received: from nm7-vm0.bullet.mail.ukl.yahoo.com ([217.146.183.236]:34148 "HELO
	nm7-vm0.bullet.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751597Ab1EDJiX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 4 May 2011 05:38:23 -0400
X-Greylist: delayed 415 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 May 2011 05:38:22 EDT
Received: from [217.146.183.184] by nm7.bullet.mail.ukl.yahoo.com with NNFMP; 04 May 2011 09:31:26 -0000
Received: from [217.146.183.63] by tm15.bullet.mail.ukl.yahoo.com with NNFMP; 04 May 2011 09:31:26 -0000
Received: from [127.0.0.1] by omp1032.mail.ukl.yahoo.com with NNFMP; 04 May 2011 09:31:26 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 239753.30543.bm@omp1032.mail.ukl.yahoo.com
Received: (qmail 36255 invoked by uid 60001); 4 May 2011 09:31:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.co.uk; s=s1024; t=1304501486; bh=7HMvxoium/3NBoPvG8ju8fsDidxm2Grg+gFZrjDmN9g=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=qiZMdR0CJmnT4RQmLtnAKA0Jng37h29UfUFnIyXFI1gdrd78wXrj2GeKOveMUefi2if/iTsKQhF61yfdDYnGe34UuvTg4JqUInj6IOVkB4S2tVeIbD0zvc6MF3HEL477j/6MfX4xwHVZd/zFeIzbKVTfl9ic2nXxTz1QGVYRSfQ=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=23ODPH/aZ8RgjgqhBn9zaQdqOTT4Ji+tD8U95sTxsnQraOF/zyeluHekzfJd5tEA4dBPRqpOpwHdlmGWZfrihOQFIZ/uzbt+P+Z4dGCErePnjig6zo9ScS3byb8KE8smsda38VKTfn/rqoEFdFomnMp/vJ7EEbatc/P2DPGNFTE=;
X-YMail-OSG: sfNYpCgVM1mOTCSVirGlsKpeGIZDpaodBZGDKAw5SWIWn8M
 97jaWT5BxECqk7cYN7X3FGfKS3oIGoek7XsBXiAhyed5BJ0IdqwqR1vYz67z
 LD1WgwtPzJ1VwyaRoBzX7hx1oRkmTTfxGW_ebrvHplmnDBXVZrJD7CyX.bxQ
 jVnfxPQ9XWnXU87RGZgXJR_i7.agrmBHjhaW5KZlxb_VS4w67sk207J1Al.M
 huAedmg7ZKAes7pDGJJcgQHJPUyPqf9ybtkaXv3kTBPbzGR1pFZzqoLm700C
 Nec79Er.U8gkHah1xP9v2IUpvM.L4dRV9.m6FzN4InufayD9TgGEZWx6I_SW
 aPCgivvnnMsXIhDVwLBUOc2vB6ZtLig--
Received: from [87.194.171.89] by web27605.mail.ukl.yahoo.com via HTTP; Wed, 04 May 2011 10:31:25 BST
X-Mailer: YahooMailClassic/12.0.2 YahooMailWebService/0.8.110.299900
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172731>

I'm trying to do a git pull (with no arguments) from the remote repository from which my local repository was originally cloned. I get

remote: Counting objects: 1272, done.
remote: Compressing objects: 100% (897/897), done.
remote: Total 1127 (delta 588), reused 404 (delta 218)
Receiving objects: 100% (1127/1127), 1.18 MiB | 45 KiB/s, done.
fatal: cannot pread pack file: No such file or directory
fatal: index-pack failed

Does anyone know what causes this and how to recover from it if that is possible? Deleting my local repository and re-cloning makes the problem go away for a few months and several pulls and commits, but eventually it reappears and once reappeared is reproducible. Other users of the same remote repository don't see this problem.

I'm running under SUSE 11.1 Linux 2.6.27.39-0.2-default #1 SMP 2009-11-23 12:57:38 +0100 x86_64 x86_64 x86_64 GNU/Linux using git version 1.6.0.2, which is the latest built release for SUSE 11.1.

I have a copy of the local repository, but the remote repository  will probably have changed by the time anyone responds to this.

Richard Parkins
