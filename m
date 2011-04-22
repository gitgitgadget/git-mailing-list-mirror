From: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH] contrib/completion: remove parentheses from prompt
Date: Fri, 22 Apr 2011 18:43:34 -0500
Organization: Freescale Semiconductor, Inc.
Message-ID: <20110422184334.98ce52a6.kim.phillips@freescale.com>
References: <20110422143248.1f4f84c0.kim.phillips@freescale.com>
	<7vk4elnchw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 23 01:44:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDQ16-0004B6-Q2
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 01:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756986Ab1DVXnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2011 19:43:43 -0400
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:17855
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755367Ab1DVXnm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2011 19:43:42 -0400
Received: from mail187-va3-R.bigfish.com (10.7.14.238) by
 VA3EHSOBE008.bigfish.com (10.7.40.28) with Microsoft SMTP Server id
 14.1.225.8; Fri, 22 Apr 2011 23:43:41 +0000
Received: from mail187-va3 (localhost.localdomain [127.0.0.1])	by
 mail187-va3-R.bigfish.com (Postfix) with ESMTP id CE2E34102BA;	Fri, 22 Apr
 2011 23:43:39 +0000 (UTC)
X-SpamScore: -18
X-BigFish: VS-18(zz1521M1432N98dK4015Lzz1202hzz8275bhz2dh2a8h668h839h61h)
X-Spam-TCS-SCL: 0:0
X-Forefront-Antispam-Report: KIP:(null);UIP:(null);IPVD:NLI;H:mail.freescale.net;RD:none;EFVD:NLI
Received: from mail187-va3 (localhost.localdomain [127.0.0.1]) by mail187-va3
 (MessageSwitch) id 1303515819704576_8233; Fri, 22 Apr 2011 23:43:39 +0000
 (UTC)
Received: from VA3EHSMHS019.bigfish.com (unknown [10.7.14.246])	by
 mail187-va3.bigfish.com (Postfix) with ESMTP id C19FB588053;	Fri, 22 Apr 2011
 23:43:37 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by VA3EHSMHS019.bigfish.com
 (10.7.99.29) with Microsoft SMTP Server (TLS) id 14.1.225.8; Fri, 22 Apr 2011
 23:43:37 +0000
Received: from az33smr01.freescale.net (10.64.34.199) by
 039-SN1MMR1-001.039d.mgd.msft.net (10.84.1.13) with Microsoft SMTP Server id
 14.1.270.2; Fri, 22 Apr 2011 18:43:36 -0500
Received: from widmer (widmer.am.freescale.net [10.82.123.5])	by
 az33smr01.freescale.net (8.13.1/8.13.0) with SMTP id p3MNhZ6Q023410;	Fri, 22
 Apr 2011 18:43:35 -0500 (CDT)
In-Reply-To: <7vk4elnchw.fsf@alter.siamese.dyndns.org>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
X-OriginatorOrg: freescale.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171946>

On Fri, 22 Apr 2011 15:32:27 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Kim Phillips <kim.phillips@freescale.com> writes:
> 
> > Save horizontal terminal line real estate by removing parentheses from
> > the prompt branch display.  The branch is already sufficiently visually
> > delimited by the preceding space character.
> 
> That changes behaviour and makes people who like the current output
> unhappy, no?  For example, I have
> 
> 	PS1=': \h \W$(__git_ps1 "/%s"); '
> 
> and from it I get these output:
> 
> 	: host git.git/master;
> 	: host git.git/(v1.7.5-rc3);
>         : host git.git/(63e4ee5...);
> 
> I do like the fact that the tagname v1.7.5-rc3 is parenthesized---it makes
> it very clear that I am not on any branch while being detached.
> 
> Of course that is _my_ personal taste, but I wonder if you can remove the
> parentheses by changing the way you use __git_ps1 in your PS1 definition.

Oh I see what happened.  A long time ago I had changed the recommended
PS1 from the top of git-completion.bash to a version without the
parentheses, but I must've started working in detached states more
recently until finally _my_ personal distaste for parens kicked in
again.

Fwiw, especially on properly managed projects, the content of the name
itself is enough to distinguish a branch name from a tag name (which
usually contains a version value), from a raw sha followed by three
dots.  But I'd understand if people want it to be more deterministic.

Thanks,

Kim
