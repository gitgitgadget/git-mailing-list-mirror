From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 12:07:08 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708221154150.16727@xanadu.home>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
 <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 18:07:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INsk3-0002qs-RF
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 18:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759859AbXHVQHL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 12:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759799AbXHVQHL
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 12:07:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64862 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759804AbXHVQHK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 12:07:10 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JN6009ASNFWWJP0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Aug 2007 12:07:08 -0400 (EDT)
In-reply-to: <864pirej6w.fsf@lola.quinscape.zz>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56394>

On Wed, 22 Aug 2007, David Kastrup wrote:

> The problem I see is that C sucks really really bad as a scripting
> language, and tying together plumbing functionality into porcelain is
> one of the most powerful, flexible and hack-friendly features of git.
> Deprecating scripts is making git more opaque.

I tend to agree with you.

> Personally, I would prefer an approach of using an embedded script
> interpreter: then language incompatibilities become a non-issue.
> git-busybox sounded like a great idea for portability.

Indeed.  And while the conversion of some script into C was the right 
thing to do performance wise, many other scripts are hardly performance 
critical.

There was a first attempt at a very specialized scripting language, even 
with a prototype a while ago from Linus: 

	http://marc.info/?l=git&m=114076345427378&w=2

but the idea never took off.

> I am just not sure that C is the ultimate solution since it makes
> things harder to hack on.
> 
> I'd prefer to see some scripting abilities retained: many of the
> recent advances in the porcelain (like rebase -i) would likely not
> have happened if one would had to write them in C in the first place.

The current scripting ability will never go away.  But it is less and 
less used meaning that scripting could never be a dependable ability on 
all platforms if the current trend continues.

> If the scripting engine of choice for cobbling together prototypes
> remains the Unix toolchain outside of git proper, then Windows users
> will _always_ remain second class citizens since they will get to work
> with and on new porcelain much later than the rest of the world:
> namely when somebody bothers porting his new favorite tool for them to
> C.

Right.


Nicolas
