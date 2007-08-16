From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Fix warning when removing a branch (take 2)
Date: Thu, 16 Aug 2007 11:57:46 +1000
Message-ID: <18115.44826.758536.30810@cargo.ozlabs.ibm.com>
References: <11872265153600-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Thu Aug 16 03:57:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILUcW-0003GZ-Lp
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 03:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758831AbXHPB5w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 21:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758158AbXHPB5v
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 21:57:51 -0400
Received: from ozlabs.org ([203.10.76.45]:59788 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754197AbXHPB5v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 21:57:51 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 6192FDDE0D; Thu, 16 Aug 2007 11:57:50 +1000 (EST)
In-Reply-To: <11872265153600-git-send-email-mdl123@verizon.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55975>

Mark Levedahl writes:

> Paul - your commit b1054ac98 did not solve this for me. Playing around, I've
> several times received errors like this when trying to delete a branch:
> 
> can't read "idheads(f7b9ebd595c954cd0803e6b6f1f0f96a966e04c9 a890c4fca84a2a5c7835fe6432ede3e7c4e5426b)": no such element in array
> can't read "idheads(f7b9ebd595c954cd0803e6b6f1f0f96a966e04c9 a890c4fca84a2a5c7835fe6432ede3e7c4e5426b)": no such element in array

Yeah, I missed that case.  Sorry.

>     while executing
> "if {$idheads($dheads) eq $head} {

I think

	if {[llength $dheads] == 1 && $idheads($dheads) eq $head} {

should be what we want.  Could you try that?

Paul.
