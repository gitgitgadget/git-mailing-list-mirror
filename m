From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Empty directories...
Date: Wed, 18 Jul 2007 18:39:21 +0200
Message-ID: <vpq4pk1vf7q.fsf@bauges.imag.fr>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<Pine.LNX.4.64.0707180135200.14781@racer.site>
	<858x9ez1li.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 18:40:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBCa7-0003MF-SV
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 18:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934763AbXGRQkv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 12:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934747AbXGRQku
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 12:40:50 -0400
Received: from imag.imag.fr ([129.88.30.1]:58635 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934649AbXGRQkt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 12:40:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l6IGdlcl014167
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2007 18:39:48 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IBCYb-0005Vg-4S; Wed, 18 Jul 2007 18:39:21 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IBCYb-0000BH-2B; Wed, 18 Jul 2007 18:39:21 +0200
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>, David Kastrup <dak@gnu.org>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
In-Reply-To: <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> (Linus Torvalds's message of "Wed\, 18 Jul 2007 09\:23\:46 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 18 Jul 2007 18:39:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52880>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>> b) The problem is not just that empty directories don't get added into
>> the repository.  They also don't get removed again when switching to a
>> different checkout.
>
> Bzzt. Wrong.
>
> We *do* remove directories when all files under them go away.
>
> HOWEVER (and this is where one of the reasons for not tracking them comes 
> in):
>
>    ** YOU CANNOT REMOVE A DIRECTORY IF IT HAS SOME UNTRACKED CONTENTS **

I believe David's point was different.

If you checkout a branch, create an empty directory in this branch
(probably a placeholder, either for future versionned files, or for
generated files), you cannot tell git "this empty directory is in this
branch, but not in other ones" without adding a file in it.

So, doing "git-checkout anotherbranch", this empty directory doesn't
go away. It's just unversionned in both branches, git won't touch it.

-- 
Matthieu
