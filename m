From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Wed, 14 Feb 2007 17:16:03 +0100
Organization: eudaptics software gmbh
Message-ID: <45D335C3.E28D28E0@eudaptics.com>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com>
	 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org>
	 <7v7iumx7hu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 17:14:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHMmD-0005OC-NC
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 17:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbXBNQOa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 11:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbXBNQOa
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 11:14:30 -0500
Received: from main.gmane.org ([80.91.229.2]:54286 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932354AbXBNQO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 11:14:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HHMlw-0006pJ-PO
	for git@vger.kernel.org; Wed, 14 Feb 2007 17:14:20 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Feb 2007 17:14:20 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Feb 2007 17:14:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39664>

Linus Torvalds wrote:
> 
> On Tue, 13 Feb 2007, Junio C Hamano wrote:
> >
> > Thanks, applied.  I think git-apply has separate codepaths for
> > both reading and writing; I won't look into them before 1.5.0
> > but people are welcome to help advancing the cause before I get
> > to it ;-).
> 
> Actually, I did it myself.
> 
> This is a "lazy man's auto-CRLF", and it really is pretty simple.

Thanks a lot, busy beaver! I gave this a quick spin with a few
interesting operations: merges and rebase. Merges leave the merge
results with only LFs behind. Rebasing seems to work as expected
(working files have CRLFs), except when merges are needed.

Doesn't git-unpack-file also need to call into the converter?

-- Hannes
