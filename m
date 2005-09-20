From: Paul Mackerras <paulus@samba.org>
Subject: Re: [Valgrind-developers] Re: git-diff-tree rename detection bug
Date: Tue, 20 Sep 2005 20:50:41 +1000
Message-ID: <17199.59777.784039.885671@cargo.ozlabs.ibm.com>
References: <59a6e583050914094777c4fe96@mail.gmail.com>
	<Pine.LNX.4.58.0509142032300.26803@g5.osdl.org>
	<17192.65054.520959.454610@cargo.ozlabs.ibm.com>
	<200509151649.47159.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, valgrind-developers@lists.sourceforge.net
X-From: git-owner@vger.kernel.org Tue Sep 20 12:52:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHfi7-0001QC-SH
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 12:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbVITKul (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 06:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbVITKul
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 06:50:41 -0400
Received: from ozlabs.org ([203.10.76.45]:25057 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964968AbVITKul (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 06:50:41 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id D135568357; Tue, 20 Sep 2005 20:50:39 +1000 (EST)
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200509151649.47159.Josef.Weidendorfer@gmx.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8990>

Josef Weidendorfer writes:

> Just curious: Why is it using LD_PRELOAD and not the VGs symbol redirection 
> mechanism, which should catch strlen even if used inside of glibc?

Valgrind-2.4.1 does symbol redirects for stpcpy and strnlen in
libc.so.6, and stpcpy and strchr in ld-linux.so.2.  I could extend
that list on ppc to include strlen et al., but I don't know if that
would solve the problem for ld.so, since strlen doesn't appear in the
symbol table for ld.so.

Paul.
