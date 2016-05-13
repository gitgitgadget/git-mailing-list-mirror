From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: git svn clone cannot go beyond a specific rev on codeplex
Date: Fri, 13 May 2016 18:28:51 +0000 (UTC)
Message-ID: <320381260.3220496.1463164131860.JavaMail.yahoo@mail.yahoo.com>
References: <320381260.3220496.1463164131860.JavaMail.yahoo.ref@mail.yahoo.com>
Reply-To: Hin-Tak Leung <htl10@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Fri May 13 20:28:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1Hpa-0003XB-W7
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 20:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbcEMS2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 14:28:55 -0400
Received: from nm26-vm3.bullet.mail.ir2.yahoo.com ([212.82.97.45]:50999 "EHLO
	nm26-vm3.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753172AbcEMS2y (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2016 14:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1463164132; bh=owxGjwzl8HDucJOamA0Yh/iqNAT688NoFyqgkZciX4Y=; h=Date:From:Reply-To:To:Cc:Subject:References:From:Subject; b=GtFxlKbI1saN3/Cixk4oYbSaAqTBRXA1rRj+46jA6IX6T1P106OkCFPdERpHIvzvrgGi1ikTdCmlY8NfNIC2NBX5VpCPPJ1LC9EGnkbaxvq5ZcPUuXrAwh3XbT63QQ61ZqMdNrHeTv8x8xI6hTR+PSxcj7MsMYtXZxYpZ8qE9oXKxaXtWVOqbJq6LIpQb8rOrYLJmIK571rjMFX2ajsqozFNLOYQYmJjFXtEg40/SU5KhyObRG3wEHDYG80tXzR2FSv/Ze5zqzcVI72pB+2gZj8bwmB13UbmPC6XaV03hAQcJqRJVwq9rrFo8Gm4lW2iHnVDzkop2tvDxq7VMCzMIA==
Received: from [212.82.98.61] by nm26.bullet.mail.ir2.yahoo.com with NNFMP; 13 May 2016 18:28:52 -0000
Received: from [212.82.98.74] by tm14.bullet.mail.ir2.yahoo.com with NNFMP; 13 May 2016 18:28:52 -0000
Received: from [127.0.0.1] by omp1011.mail.ir2.yahoo.com with NNFMP; 13 May 2016 18:28:52 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 566076.84272.bm@omp1011.mail.ir2.yahoo.com
X-YMail-OSG: rViCYSwVM1la_uoJBGxRxFn_iH_IrT2AIon1_DGJUIKLeoAFqo2RAzKTndOuI5e
 0LfpbPE4IZVaI8vuSz7BQ37dhjudLoMO0CCw.yrKfgderYnFS9.0O7YOp7vRKXAgguhqj5XmCgR3
 UXLL6Z0T0tG6aOWfZrIqEZGOdX2nYED_WMAyQ6yOTDajw0HKINOVA0V0hlNt0A2dOBGTUaoQnjym
 kblD8MoypWGQWcKmFv9hPWqNNyZdSghxq45gGY7C4Cxk1neBbQYFFyUqCBhhqNKO7rZoMxEPp2Oc
 MDnNDn0ziUUEWGf3WnfonxF8t9PXIhhQaBOz.SC8btDG7H9yg8rhjrkwjxhnVItFf9bd7w2rUvdE
 05ApQQjaP0ONlLmeRcCcwQN1sn4nux6TD1lS405FWzIDEVrNWiMa3VQqcp7NFHsHynPbAkwL7rfO
 hEOvqboyKXwnfyu_ybXSh_nQN185cRtY62ZwU_d9x7NQf8g440ifqA2prParD94Taahi6sBk2cUM
 6fZKwDAmQvcuvk.4-
Received: from jws11158.mail.ir2.yahoo.com by sendmailws109.mail.ir2.yahoo.com; Fri, 13 May 2016 18:28:52 +0000; 1463164132.117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294557>

I tried your svn diff directly, and got the same error:

$ /usr/bin/time -v -o /tmp/svn-log svn diff -r7604:8870 https://ironpython.svn.codeplex.com/svn > /dev/null
svn: E000104: Error running context: Connection reset by peer

$ more /tmp/svn-log
Command exited with non-zero status 1
	Command being timed: "svn diff -r7604:8870 https://ironpython.svn.codeplex.com/svn"
	User time (seconds): 0.14
	System time (seconds): 0.03
	Percent of CPU this job got: 0%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 7:32.71
...

So the other end decided to drop it after 7 and half minutes. You said you were successful, so this seems connectivity/server-load related?

I suppose I could keep fetching to see if I can get past that rev one day :-(.
