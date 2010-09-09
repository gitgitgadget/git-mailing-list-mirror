From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Do not let lstree output recursively when a directory whose name is a prefix of the others is given in the path list.
Date: Thu, 09 Sep 2010 08:04:16 +0200
Message-ID: <vpqzkvr5u73.fsf@bauges.imag.fr>
References: <1284010826-81989-1-git-send-email-davi.reis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: davi.reis@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 09 08:07:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtaIY-0002k3-PF
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 08:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536Ab0IIGHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 02:07:42 -0400
Received: from imag.imag.fr ([129.88.30.1]:58568 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753464Ab0IIGHh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 02:07:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o8964Gh0015518
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 9 Sep 2010 08:04:16 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OtaF6-0008Sc-Ky; Thu, 09 Sep 2010 08:04:16 +0200
In-Reply-To: <1284010826-81989-1-git-send-email-davi.reis@gmail.com> (davi reis's message of "Wed\,  8 Sep 2010 22\:40\:25 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 09 Sep 2010 08:04:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155844>

davi.reis@gmail.com writes:

> Here is how to reproduce the bug:
>
> git init
> mkdir prefix && touch prefix/a && git add prefix/a
> mkdir prefixdir && touch prefixdir/b && git add prefixdir/b
> git commit -a -m "If -r is not given, ls-tree should not show files in subdirs."
> git ls-tree --name-only HEAD prefix  # works as expected
> git ls-tree --name-only HEAD prefixdir  # works as expected
> git ls-tree --name-only HEAD prefix prefixdir  # shows file, not dir

That's so close to a real test-case... You should incorporate this in
your patch (e.g. in t/t3101-ls-tree-dirname.sh), to make sure such bug
never happens again.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
