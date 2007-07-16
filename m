From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: Can someone explain this git-blame/git-rev behavior to me?
Date: Mon, 16 Jul 2007 15:24:53 +0200
Organization: eudaptics software gmbh
Message-ID: <469B71A5.D5299A80@eudaptics.com>
References: <86sl7oaasx.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 15:24:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAQYh-00077h-BQ
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 15:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758887AbXGPNYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 09:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757977AbXGPNYM
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 09:24:12 -0400
Received: from main.gmane.org ([80.91.229.2]:55273 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758726AbXGPNYK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 09:24:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IAQYQ-000140-Eq
	for git@vger.kernel.org; Mon, 16 Jul 2007 15:23:58 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 15:23:58 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 15:23:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52673>

David Kastrup wrote:
> git-name-rev b5dd9d20
> b5dd9d20 tags/v1.4.2-rc1~88
> 
> So what is it I am doing wrong here?  The problem I have is that in
> Emacs, one can go to the "next version" in an annotated file, and I
> get stuck in a loop here, since tags/v1.4.2-rc1~88 delivers
> 
> git-rev-list HEAD --not tags/v1.4.2-rc1~88 --parents contrib/emacs/vc-git.el|tail -1|git-name-rev --stdin
> 
> d87b90e47f7430455385edcf8506288b9a73d3b5 (tags/v1.4.2-rc1~87) b5dd9d2027c1bd5758033c7baf6d087752b0263d (tags/v1.4.2-rc1~88) 280242d1cc1fe2847f649d2f16b273e168fcbc48 (tags/v1.4.2-rc1~92)
> 
> So we have tags/v1.4.2-rc1~87 listed as successor again, so I get into
> a loop of blame.
> 
> Is there something I don't understand about merges?

rev-list --parents list both the commit and its parent(s). If you are
only interested in the parents, ignore the first SHA1 on the line.

-- Hannes
