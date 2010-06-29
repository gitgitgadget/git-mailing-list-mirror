From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [OT?] Executing Git from bash script invoked by cron
Date: Tue, 29 Jun 2010 08:24:46 +0200
Message-ID: <vpqhbkm9x01.fsf@bauges.imag.fr>
References: <4C290D88.80306@cedarsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schneider <mailings@cedarsoft.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 08:25:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTUFl-0004wx-6T
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 08:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481Ab0F2GY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 02:24:56 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47063 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752354Ab0F2GYy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 02:24:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5T6G4Re015471
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 29 Jun 2010 08:16:04 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OTUFS-0005wj-Ee; Tue, 29 Jun 2010 08:24:46 +0200
In-Reply-To: <4C290D88.80306@cedarsoft.com> (Johannes Schneider's message of "Mon\, 28 Jun 2010 23\:00\:56 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 29 Jun 2010 08:16:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5T6G4Re015471
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1278396967.73854@pT8qBBpSEc7pzzjHnyzvkg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149886>

Johannes Schneider <mailings@cedarsoft.com> writes:

> But the same script executed by cron, does not work. Git push does
> simply nothing. No output, no push, nothing.
> But git log and git --version works...

One common problem with cron jobs is that you don't have the same
$PATH in your shell and in cron. If you have no output at all, I'd say
you didn't reach the line where git is executed in your script.

Try to add a

  set -x

at the beginning of your script to see what it's doing.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
