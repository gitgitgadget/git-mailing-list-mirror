From: Charles Bailey <charles@hashpling.org>
Subject: Re: What should mergetool do with --no-prompt?
Date: Tue, 14 Aug 2012 08:18:23 +0100
Message-ID: <20120814071823.GA21031@hashpling.org>
References: <CAJDDKr5TK910n603jcmoq6WoaLL9DX9hgwF3Y+MmjngMpAXPQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 09:24:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1BUW-0000rH-PI
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 09:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604Ab2HNHYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 03:24:33 -0400
Received: from avasout05.plus.net ([84.93.230.250]:60233 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab2HNHYc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 03:24:32 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Aug 2012 03:24:32 EDT
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id mXJP1j0082iA9hg01XJQDT; Tue, 14 Aug 2012 08:18:25 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.0 cv=FYC1NeC6 c=1 sm=1 a=wpJ/2au8Z6V/NgdivHIBow==:17
 a=-GleFfVwiy8A:10 a=wh2Od-te4LEA:10 a=mSBy96HJJ2wA:10 a=BHUvooL90DcA:10
 a=kj9zAlcOel0A:10 a=Ew9TdX-QAAAA:8 a=LRKIkcAg1ULjKnMj61IA:9 a=CjuIK1q_8ugA:10
 a=wpJ/2au8Z6V/NgdivHIBow==:117
Received: from charles by hashpling.plus.com with local (Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1T1BOR-0005dT-SA; Tue, 14 Aug 2012 08:18:23 +0100
Content-Disposition: inline
In-Reply-To: <CAJDDKr5TK910n603jcmoq6WoaLL9DX9hgwF3Y+MmjngMpAXPQw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203388>

On Tue, Aug 14, 2012 at 12:07:26AM -0700, David Aguilar wrote:
> Right now there are two code paths, resolving deletion conflicts
> and resolving symlink conflicts, in git-mergetool that do not
> honor --no-prompt.  They force user-interaction with the shell
> even though the caller (such as a program) said that they do
> not want to be prompted.
> 
> This was an oversight from when this option was first added.
> 
> I think a simple and sensible thing to do would be for mergetool
> to skip over these entries when --no-prompt is supplied.
> 
> Does this sound like a good idea?

--no-prompt is designed to remove the prompt before launching a
mergetool. This is because it is mostly pointless but does provide a
convenient point to interrupt (C-c) a large multifile conflict
resolution.

It was never supposed to be a batch mode switch. By it's very nature
mergetool is interactive so I don't see any advantage to pretending
otherwise.

If the documentation indicates otherwise then it's my opinion that
this is what needs to be fixed.

Charles.
