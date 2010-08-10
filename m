From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git commit return code
Date: Tue, 10 Aug 2010 08:46:31 +0200
Message-ID: <vpqr5i7q81k.fsf@bauges.imag.fr>
References: <4C601F9B.6040102@puffy.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tomasz Pajor <nikon@puffy.pl>
X-From: git-owner@vger.kernel.org Tue Aug 10 08:49:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oiiea-0002eK-KU
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 08:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab0HJGtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 02:49:36 -0400
Received: from imag.imag.fr ([129.88.30.1]:54272 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752702Ab0HJGtf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 02:49:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o7A6kWe8026520
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 10 Aug 2010 08:46:32 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OiibX-000614-S4; Tue, 10 Aug 2010 08:46:31 +0200
In-Reply-To: <4C601F9B.6040102@puffy.pl> (Tomasz Pajor's message of "Mon\, 09 Aug 2010 17\:32\:43 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 10 Aug 2010 08:46:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153079>

Tomasz Pajor <nikon@puffy.pl> writes:

> Hello,
>
> Is this proper behaviour:
>
> root# su <username> -c "git commit --quiet -a -m \"templates generation\";"
> # On branch master
> nothing to commit (working directory clean)
> root# echo $?
> 1

The exit status doesn't seem documented in the manpage, but it's
expected behavior that "git commit" refuses to create an empty commit,
and it seems sensible to "exit(1)" in this case.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
