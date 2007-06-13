From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Add a local implementation of hstrerror for the system which 
 do not have it
Date: Wed, 13 Jun 2007 09:05:03 +0200
Organization: eudaptics software gmbh
Message-ID: <466F971F.C74761E2@eudaptics.com>
References: <86ejkh40cr.fsf@blue.stonehenge.com> <20070612205210.GC2459@steel.home> <20070612213129.GD2459@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 09:04:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyMuE-0004zD-Jo
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 09:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499AbXFMHEh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 03:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755450AbXFMHEh
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 03:04:37 -0400
Received: from main.gmane.org ([80.91.229.2]:44757 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754852AbXFMHEg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 03:04:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HyMtm-0003Qa-H1
	for git@vger.kernel.org; Wed, 13 Jun 2007 09:04:10 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 09:04:10 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 09:04:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50023>

Alex Riesen wrote:
> +       static char buffer[32];
> ...
> +       sprintf(buffer, "Name resolution error %d", err);

I don't think it's a problem for any current implementation, but it
would be better to err on the conservative side: The buffer should be at
least 44 chars wide to account for 20 digit negative numbers (thats the
maximum if int is 64 bits wide).

-- Hannes
