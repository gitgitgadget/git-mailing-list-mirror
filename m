From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sun, 22 Jul 2007 00:00:30 -0400
Message-ID: <1DB4C18A-A21B-4176-85AD-A86C92178F54@silverinsanity.com>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site> <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> <vpq4pk1vf7q.fsf@bauges.imag.fr>   =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.0707181004330.=04?=
	=?ISO-8859-1?Q?=0427353@woody.lin?= =?ISO-8859-1?Q?ux-foundation.or?=
	=?ISO-8859-1?Q?g>?= <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <851wf2bcqy.fsf@lola.goethe.zz>   =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.07072=0402135450.?=
	=?ISO-8859-1?Q?27249@woody.linu?= =?ISO-8859-1?Q?x-foundation.org?=
	=?ISO-8859-1?Q?>?= <alpine.LFD.0.999.0707202154220.27249@woody.linux-foundation.org> <85odi69vgt.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707210832180.27249@woody.linux-foundation.org> <85tzrxslms.fsf@lola.goethe.zz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 06:00:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICScZ-0006QU-Vd
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 06:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbXGVEAc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 00:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbXGVEAc
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 00:00:32 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:33204 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbXGVEAb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 00:00:31 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 3DEE91FFC01F;
	Sun, 22 Jul 2007 04:00:31 +0000 (UTC)
In-Reply-To: <85tzrxslms.fsf@lola.goethe.zz>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53216>


On Jul 21, 2007, at 1:38 PM, David Kastrup wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> So git filenames are very much a "stream of bytes", not anything
>> else. And they need to sort 100% reliably, always the same way, and
>> never with any localized meaning.
>
> There is some utf-8/Unicode trouble to be expected in connection with
> that eventually: some, but not all operating and/or file systems
> canonicalize file names, replacing accented letters by a combining
> accent and the letter.  But that's beside the point.

This issue exists today.  OS X does a number of things to filenames,  
one of which is normalizing all UTF.  The resulting error is wholly  
non-intuitive, but easy to solve.  Git thinks both that the file  
exists under the name it expects and that the file is being ignored  
as the name OS X uses.  The solution is to put the OS X normalized  
form into .git/info/exclude.  Any other solution involves platform- 
dependent hackery and inclusion of Unicode libraries.  I perused this  
for a short while some months ago, but was convinced to leave it be.

~~ Brian
