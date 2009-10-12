From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git refuses to work with gvim
Date: Mon, 12 Oct 2009 14:43:50 +0200
Message-ID: <vpq8wfgg4u1.fsf@bauges.imag.fr>
References: <20091012134312.236d250e@gzip.coli.uni-saarland.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: sebastian@CoLi.Uni-SB.DE
X-From: git-owner@vger.kernel.org Mon Oct 12 14:49:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxKKc-0000Uz-Gq
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 14:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755497AbZJLMop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 08:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755394AbZJLMop
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 08:44:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39285 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754588AbZJLMoo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 08:44:44 -0400
Received: from archeboc.imag.fr (archeboc.imag.fr [129.88.43.1])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n9CChelB001715
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 12 Oct 2009 14:43:40 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by archeboc.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1MxKFi-0000Fo-S9; Mon, 12 Oct 2009 14:43:50 +0200
In-Reply-To: <20091012134312.236d250e@gzip.coli.uni-saarland.de> (sebastian@coli.uni-sb.de's message of "Mon\, 12 Oct 2009 13\:43\:12 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 12 Oct 2009 14:43:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n9CChelB001715
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1255956221.53763@FXzpohtdj4GsQsy+GVALUw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130009>

sebastian@CoLi.Uni-SB.DE writes:

> # git commit something
> fatal: no commit message?  aborting commit.
> #

The problem is that gvim returns immediately, and lets the window
opened (try it in a terminal, "gvim foo.txt" returns immediately). Git
expects the commit message to be written and saved when $EDITOR
returns.

A quick search for "wait" in the man pages tells me that

  GIT_EDITOR='gvim -f' git commit 

works.

(BTW, this is in no way specific to Git, 99% applications calling
$EDITOR will expect the same behavior)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
