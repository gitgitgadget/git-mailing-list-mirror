From: esr@thyrsus.com (Eric S. Raymond)
Subject: Change in cvsps maintainership, abd a --fast-export option
Date: Thu, 20 Dec 2012 16:56:38 -0500 (EST)
Message-ID: <20121220215638.E54BC44119@snark.thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 20 22:57:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlo7E-000163-2c
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 22:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851Ab2LTV47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 16:56:59 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:37677
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567Ab2LTV47 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 16:56:59 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id E54BC44119; Thu, 20 Dec 2012 16:56:38 -0500 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211933>

Earlier today David Mansfield handed off to me the cvsps project. This
is the code used as an engine for reading CVS repositories by
git-cvsimport.

His reason (aside from general overwork and no longer having a strong
interest on the code) is that I have added a --fast-export option to
cvsps-3.0 that emits a git fast-import stream representing the CVS
history.
 
I did this so that reposurgeon could use cvsps as a front end.  But I
expect it will be of some interest to whoever is maintaining
git-cvsimport. That code can now become much, *much* smaller and
simpler.

The new --fast-export mode solves at least one bug mentioned on the
git-cvsimport man page; multiple tags pointing at the same CVS changeset
will be passed through correctly.

Possibly it fixes some other problems described there as well.  
I don't understand all the bug warnings on that page and would like to
discuss them with the author, whoever that is.  Possibly cvsps can be
further enhanced to address these problems; I'm willing to work on that.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

To stay young requires the unceasing cultivation of the ability to
unlearn old falsehoods.
	-- Lazarus Long 
