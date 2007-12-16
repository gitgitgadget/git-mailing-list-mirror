From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git merge --no-commit <branch>; does commit
Date: Sun, 16 Dec 2007 11:53:11 +0100
Message-ID: <20071216105311.GA2937@steel.home>
References: <alpine.LSU.0.99999.0712132151080.5326@castor.milkiway.cos> <81b0412b0712131319h63609810m593f0e552d02a83c@mail.gmail.com> <alpine.LSU.0.99999.0712132224280.5606@castor.milkiway.cos> <20071214074925.GA3525@steel.home> <alpine.LSU.0.99999.0712151905280.4341@castor.milkiway.cos> <20071215193741.GB3021@steel.home> <alpine.LSU.0.99999.0712152124220.5151@castor.milkiway.cos>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: B.Steinbrink@gmx.de, git@vger.kernel.org
To: Michael Dressel <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Sun Dec 16 11:53:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3r7v-0003xb-UB
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 11:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763080AbXLPKxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 05:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763129AbXLPKxP
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 05:53:15 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:19265 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763080AbXLPKxO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 05:53:14 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow2UcI=
Received: from tigra.home (Fc8e1.f.strato-dslnet.de [195.4.200.225])
	by post.webmailer.de (fruni mo32) (RZmta 14.6)
	with ESMTP id V03692jBGAgJzi ; Sun, 16 Dec 2007 11:53:12 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 4A3CB277AE;
	Sun, 16 Dec 2007 11:53:12 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 8DBDB56D22; Sun, 16 Dec 2007 11:53:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.0.99999.0712152124220.5151@castor.milkiway.cos>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68456>

Michael Dressel, Sat, Dec 15, 2007 21:33:20 +0100:
> On Sat, 15 Dec 2007, Alex Riesen wrote:
>> Michael Dressel, Sat, Dec 15, 2007 19:14:48 +0100:
>>>> Maybe. Or maybe you misunderstood the meaning of --squash, which also
>>>> is not a merge.
>>>
>>> Since "git merge --squash <branch>" does a merge of <branch> into the
>>> working tree why would you not call it a merge?
>>
>> Because merge, in Git language, means connection histories. That one
>> just mixes the text. That's different operation, kind of editing a
>> file.
>
> That's a nice clarification. In my case I wanted that "just mixes the text" 
> thing because I did aggressively do commits during development trying out 
> slightly different approaches and being able to go back to compare them. 
> These different games are not interesting to keep in the history once a 
> good solution has been found.

In this case --squash is almost right. "rebase -i" (interactive rebase)
still better: it'll allow you rebuild the development history in a
more fine-grained way. It can reorder commits, "mix" them together,
edit commit messages or just delete them altogether.
Try it, by the look of your situation you'll like it. Actually, it is
exactly why Johannes wrote it.
