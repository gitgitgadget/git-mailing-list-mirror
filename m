From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 1/2] send-email: refactor and ensure prompting doesn't loop forever
Date: Mon, 30 Mar 2009 13:29:34 +0200
Message-ID: <vpqd4bzjlk1.fsf@bauges.imag.fr>
References: <1238290751-57461-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 13:35:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoFlc-0007DI-H5
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 13:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596AbZC3Ldb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 07:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754638AbZC3Ld3
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 07:33:29 -0400
Received: from imag.imag.fr ([129.88.30.1]:64001 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753445AbZC3Ld3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 07:33:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n2UBTYtd003490
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 30 Mar 2009 13:29:34 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LoFgM-0008Pm-Mb; Mon, 30 Mar 2009 13:29:34 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LoFgM-0006V5-KT; Mon, 30 Mar 2009 13:29:34 +0200
In-Reply-To: <1238290751-57461-1-git-send-email-jaysoffian@gmail.com> (Jay Soffian's message of "Sat\, 28 Mar 2009 21\:39\:10 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 30 Mar 2009 13:29:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115137>

Jay Soffian <jaysoffian@gmail.com> writes:

> Several places in send-email prompt for input, and will do so forever
> when the input is EOF. This is poor behavior when send-email is run
> unattended (say from cron).

Thanks a lot for the patch, it does fix the problem I reported in
http://article.gmane.org/gmane.comp.version-control.git/114577 .

Minor problem: I still (harmless) get error messages in my log:

  print() on closed filehandle FOUT at /usr/share/perl/5.8/Term/ReadLine.pm line 193.
  readline() on closed filehandle FIN at /usr/share/perl/5.8/Term/ReadLine.pm line 395.
  print() on closed filehandle FOUT at /usr/share/perl/5.8/Term/ReadLine.pm line 203.
  
But I can very well live with them!

-- 
Matthieu
