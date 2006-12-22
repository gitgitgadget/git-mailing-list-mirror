From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] Don't crash during repack of a reflog with pruned commits.
Date: Fri, 22 Dec 2006 02:18:33 +0100
Organization: At home
Message-ID: <emfbk4$f45$1@sea.gmane.org>
References: <be6b1443171482e1930bd7744a0218db0c03d611.1166748450.git.spearce@spearce.org> <20061222004906.GC14789@spearce.org> <7vmz5g92h7.fsf@assigned-by-dhcp.cox.net> <20061222010018.GB14773@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Dec 22 02:17:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxZ2h-0006Vv-8e
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 02:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945894AbWLVBRi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 20:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945899AbWLVBRi
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 20:17:38 -0500
Received: from main.gmane.org ([80.91.229.2]:34272 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945894AbWLVBRi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 20:17:38 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GxZ1o-00043p-DH
	for git@vger.kernel.org; Fri, 22 Dec 2006 02:16:55 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 02:16:52 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 02:16:52 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35111>

Shawn Pearce wrote:

> Junio C Hamano <junkio@cox.net> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> 
>>> If the user has been using reflog for a long time (e.g. since its
>>> introduction) then it is very likely that an existing branch's
>>> reflog may still mention commits which have long since been pruned
>>> out of the repository.
>> 
>> I've thought about this issue when I did the repack/prune; my
>> take on this was you should prune reflog first then repack.
> 
> OK, but we should suggest that to the user rather than just
> cryptically saying 'fatal: bad object refs/heads/build'.

I still think it is a good idea to allow user (experienced user)
to set to not consider reflog for saving. Especially that there
exist repositories which have reflogs with long pruned commits,
and it would be nice to preserve the reflog info, even if some of
information is not available.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
