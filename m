From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: strbuf API
Date: Mon, 03 Sep 2007 11:02:26 +0200
Message-ID: <vpq8x7om89p.fsf@bauges.imag.fr>
References: <20070902224213.GB431@artemis.corp>
	<vpqk5r8m9nz.fsf@bauges.imag.fr> <20070903084927.GB21759@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 03 11:03:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS7pc-0000v1-Bl
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 11:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbXICJCq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 05:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753645AbXICJCq
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 05:02:46 -0400
Received: from imag.imag.fr ([129.88.30.1]:52024 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753236AbXICJCp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 05:02:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l8392QZX003881
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 3 Sep 2007 11:02:26 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IS7pC-0002Jr-Ok; Mon, 03 Sep 2007 11:02:26 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IS7pC-0005zS-MQ; Mon, 03 Sep 2007 11:02:26 +0200
In-Reply-To: <20070903084927.GB21759@artemis.corp> (Pierre Habouzit's message of "Mon\, 03 Sep 2007 10\:49\:27 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 03 Sep 2007 11:02:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57456>

Pierre Habouzit <madcoder@debian.org> writes:

>   Indeed, OTHO doing that would be pretty silly, as embending NULs in a
> strbuf is wrong, it's a _str_buf, not a random-binary-buffer.

I see nothing in strbuf that prevents you from embedding '\0' in it.
And the git code calls read_line on stdin, which may well contain
'\0'. So, either I missed something, or strbuf can contain '\0', or
the git code is not robust to null-characters on stdin, and should be
fixed.

-- 
Matthieu
