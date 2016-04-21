From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 14:10:57 +0200
Message-ID: <vpqmvonw4a6.fsf@anie.imag.fr>
References: <20160421113004.GA3140@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Thu Apr 21 14:11:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atDRu-0001vf-Bq
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 14:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbcDUMLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 08:11:05 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47077 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582AbcDUMLE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 08:11:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u3LCAtdl016524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 21 Apr 2016 14:10:55 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3LCAvr9008190;
	Thu, 21 Apr 2016 14:10:57 +0200
In-Reply-To: <20160421113004.GA3140@aepfle.de> (Olaf Hering's message of "Thu,
	21 Apr 2016 13:30:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Thu, 21 Apr 2016 14:10:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3LCAtdl016524
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1461845457.87513@xHrh1R891UteuUCYiMaNeg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292106>

Olaf Hering <olaf@aepfle.de> writes:

> To track the changes in hyperv related files I created some scripts
> years ago to automate the process of finding relevant commits in
> linux.git. Part of that process is to record the tag when a commit
> appeared in mainline. This worked fine, until very recently.
>
> Suddenly years-old commits are declared as having-just-arrived in
> linux.git. Look at this example:
>
>   $ git log --oneline -- drivers/input/serio/hyperv-keyboard.c
>   2048157 Drivers: hv: vmbus: fix the building warning with hyperv-keyboard
>   62238f3 Input: hyperv-keyboard - register as a wakeup source
>   c3c4d99 Input: hyperv-keyboard - pass through 0xE1 prefix
>   aed06b9 Input: add a driver to support Hyper-V synthetic keyboard
>   $ git describe --contains aed06b9
>   v4.6-rc1~9^2~792
>   $ git show aed06b9 | head
>   commit aed06b9cfcabf8644ac5f6f108c0b3d01522f88b
>   Author: K. Y. Srinivasan <kys@microsoft.com>
>   Date:   Wed Sep 18 12:50:42 2013 -0700
>
> Obviously that and other commits are in the tree since a very long time.

I cannot take that conclusion from the excerpts above. What I can
conclude is that the commit was made a long time ago (according to
https://github.com/torvalds/linux/commit/aed06b9cfcabf8644ac5f6f108c0b3d01522f88b
the commit was initially made on Sep 18 2013 by K. Y. Srinivasan, and
then applied by Dmitry Torokhov the day after to "some" tree.

My guess is that this commit has been sitting for a long time in a
repo outside Linus' linux.git, and got merged only recently.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
