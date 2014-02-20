From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: release-notes could be clearer on git-fetch changes
Date: Thu, 20 Feb 2014 18:54:34 +0100 (CET)
Message-ID: <alpine.LSU.2.11.1402201754370.11221@nerf08.vanv.qr>
References: <alpine.LSU.2.11.1402191952070.31131@nerf08.vanv.qr> <xmqqtxbu98ie.fsf@gitster.dls.corp.google.com> <alpine.LSU.2.11.1402192356480.1491@nerf08.vanv.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 20 18:54:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGXpZ-000494-RV
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 18:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337AbaBTRyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 12:54:36 -0500
Received: from ares08.inai.de ([46.4.84.70]:37479 "EHLO ares08.inai.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754253AbaBTRyg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 12:54:36 -0500
Received: by ares08.inai.de (Postfix, from userid 25121)
	id E67BD10677D33; Thu, 20 Feb 2014 18:54:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by ares08.inai.de (Postfix) with ESMTP id E223D189D469C;
	Thu, 20 Feb 2014 18:54:34 +0100 (CET)
In-Reply-To: <alpine.LSU.2.11.1402192356480.1491@nerf08.vanv.qr>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242437>


On Thu, 20 Feb 2014 12:06:17, Michael Haggerty wrote:
>On 02/19/2014 11:58 PM, Jan Engelhardt wrote:
>> 
>> Looking at it from one more angle, `git fetch r --tags` and
>> `git push r --tags` is now no longer symmetric :(
>
>I'm glad you brought this up, because I didn't really think about
>whether "git push" would need changes parallel to those in "git fetch".
>
>I use "git push" in very conservative ways, so I don't know its ins and
>outs.  What scenarios do you find asymmetric?  Were they more symmetric
>before?

`git push r --tags` pushes only tags, and `git fetch r --tags` only
fetched tags.

Starting from 1.9.0, `git fetch r --tags`, according to the release
summary, changed to "tags and other things".

That's the asymmetric change I find. It is, as you say,
undesirable to have `git push r --tags` push more than tags, which
is why I am objecting (acknowledging it's after-the-fact) that
the change to git-fetch was so-so.

A new option `git fetch r --only-tags` could remedy the
hard-to-remember syntax `git fetch r "refs/tags/*:refs/tags/*"`,
though it would not fix the asymmetry.
