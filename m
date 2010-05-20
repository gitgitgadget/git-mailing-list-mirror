From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-status and git-diff now very slow in project with a submodule
Date: Thu, 20 May 2010 18:45:48 +0100
Message-ID: <ht3sda$cvo$1@dough.gmane.org>
References: <ht3194$1vc$1@dough.gmane.org> <4BF50A92.3060209@atlas-elektronik.com> <ht36u4$lo4$1@dough.gmane.org> <4BF55ACD.3060009@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 20 19:44:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF9nF-0006sC-GD
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 19:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266Ab0ETRoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 13:44:20 -0400
Received: from lo.gmane.org ([80.91.229.12]:46704 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479Ab0ETRoT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 13:44:19 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OF9n8-0006pz-JQ
	for git@vger.kernel.org; Thu, 20 May 2010 19:44:18 +0200
Received: from 91.84.15.31 ([91.84.15.31])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 May 2010 19:44:18 +0200
Received: from andyparkins by 91.84.15.31 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 May 2010 19:44:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 91.84.15.31
User-Agent: KNode/4.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147401>

Michael J Gruber wrote:

> You see: No submodule summary here!
> Try setting the variable to true and see the difference. False is the
> default.

Quite so; I hadn't understood submodulesummary -- I just tried it when it 
was suggested.

> Git needs to check the submodule in order to produce the "modified" line
> even when no summary is required. Stopping Git from looking at the

I realise that -- what I was after is a return to the old behaviour -- under 
the control of an option.

> submodule at all is impossible, I think. One could only hope that it
> stops scanning after the first modification.

"Impossible" is a strong word for a behaviour that existed pre-1.7.

It's not that I want git not to look at the submodule at all; in fact it 
certainly should for those cases when the submodule commit has changed, and 
I guess that a check for a dirty index is pretty quick too; but scanning the 
whole submodule tree (which it has to do to find if anything was modified, 
even when nothing was modified) is a lot of extra time when the submodule is 
large.  That extra time is inconvenient when you're working on a small 
project that makes use of a large project as a submodule.  (Most of my 
personal use of submodule is embedding large projects that I want to be able 
to guarantee are at a particular version, but I don't really change them)




Andy

-- 
Dr Andy Parkins
andyparkins@gmail.com
