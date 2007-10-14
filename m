From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] [BUG FIXED 2] git-add (-a|-u)  and -n support
Date: Sun, 14 Oct 2007 15:25:03 +0200
Message-ID: <vpq3awd25hs.fsf@bauges.imag.fr>
References: <E1DCA1D1-1ED3-498A-A919-9EBAF3BA0870@mit.edu>
	<0458D1DA-6261-4DA6-91B0-739F4D35AADF@mit.edu>
	<E857D120-787F-460B-A167-4B5F4BD2C3B5@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Oct 14 15:25:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih3TV-0001HC-E8
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 15:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbXJNNZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 09:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbXJNNZd
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 09:25:33 -0400
Received: from imag.imag.fr ([129.88.30.1]:38509 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129AbXJNNZc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 09:25:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l9EDP4Wq021393
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 14 Oct 2007 15:25:04 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Ih3Sq-0005PO-2W; Sun, 14 Oct 2007 15:25:04 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Ih3Sq-0001R8-05; Sun, 14 Oct 2007 15:25:04 +0200
In-Reply-To: <E857D120-787F-460B-A167-4B5F4BD2C3B5@mit.edu> (Michael Witten's message of "Sun\, 14 Oct 2007 08\:24\:05 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 14 Oct 2007 15:25:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60848>

Michael Witten <mfwitten@MIT.EDU> writes:

> Subject: [PATCH] git-add now understands two kinds of update:
>
>  	-u: update as before
>  	-a: update all as in a true 'git commit -a'

I don't find the option set very intuitive. I'd prefer

  - git add -u . => update the current directory as before
  - git add -u   => update all files from the root.

But your solution has the advantage of being backward compatible, so,
no strong opinion here.

(side note: also, while you're here, it would be nice to have a single
command to do "git add .; git add -u", i.e add all unknown files,
update all existing files, and actally remove all deleted files. In
one word, synchronize the index with the working tree completely.
Perhaps "-a" would be a good name for that, not sure)


>  builtin-add.c |   69 +++++++++++++++++++++++++++++++++++++
> +-------------------

Your patch is whitespace-damaged. I don't know how to fix that for
Apple Mail, but git-send-email can help.

>  static const char builtin_add_usage[] =
>  "git-add [-n] [-v] [-f] [--interactive | -i] [-u] [--refresh] [--]
> <filepattern>...";

You should document -a here, and in Documentation/git-add.txt if you
introduce it.

-- 
Matthieu
