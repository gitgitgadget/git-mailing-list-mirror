From: "Aaron Gray" <angray@beeb.net>
Subject: Re: renaming question
Date: Mon, 20 Aug 2007 02:30:54 +0100
Message-ID: <045a01c7e2c9$c1ccd940$0600a8c0@ze4427wm>
References: <03a701c7e28a$87914fc0$0600a8c0@ze4427wm>	<87vebbo0f1.fsf@mid.deneb.enyo.de>	<03b401c7e28f$3c7304c0$0600a8c0@ze4427wm>	<85sl6fqr9n.fsf@lola.goethe.zz>	<03bd01c7e295$976a2970$0600a8c0@ze4427wm>	<85odh3qp8j.fsf@lola.goethe.zz> <87mywn8dm0.fsf@mid.deneb.enyo.de> <46C8E421.8000408@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Steven Grimm" <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 03:31:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMw6l-0006W5-7v
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 03:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbXHTBbB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 21:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbXHTBbB
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 21:31:01 -0400
Received: from lon1-mail-1.visp.demon.net ([193.195.70.4]:23416 "ehlo
	lon1-mail-1.visp.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751185AbXHTBbA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Aug 2007 21:31:00 -0400
Received: from mwgray.force9.co.uk (EHLO ze4427wm) ([212.159.110.144])
	by lon1-mail-1.visp.demon.net (MOS 3.7.5a-GA FastPath)
	with ESMTP id FKT79782 (AUTH angray);
	Mon, 20 Aug 2007 02:30:59 +0100 (BST)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.3138
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3138
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56163>

> Florian Weimer wrote:
>> Or, for more control about what gets put into patch, git-diff -M.
>> (As I wrote, most of the relevant commands accept an -M switch.)
>>
>
> The key point, and where the original writer is probably confused, is that 
> in git, renames are inferred from information in the repository.

Okay.

> You do not ever need to explicitly tell git about a rename. There is a 
> "git mv" command which is simply a convenience command; it is equivalent 
> to
>
> mv a b
> git add b
> git rm a

That makes things alot clearer, thanks.

> When you query history with the -M flag or do merges, git will notice that 
> the contents of the new file "b" are very similar to the old file "a" and 
> will treat it as a rename. (The contents don't have to match exactly; they 
> just have to be substantially similar.)
>
> This is not a perfect system -- there are known cases where it fails -- 
> but it has major advantages too. For example, you can unpack a third-party 
> tarfile into a git repository, commit it, then unpack the next version's 
> tarfile and commit that. Since you are using tar, nothing will have told 
> git about files that the upstream people renamed in between versions, but 
> git will detect them after the fact just as if you'd done "git mv".

Thats great, exactly what I want to do.

> Not only that, git can detect movement of content *within* files. Try 
> moving some code from one file to another and running "git blame -M -C -C" 
> on the target file; you will see git tell you that the content originally 
> came from the first file. Pretty sweet. (It's not the default since it 
> makes "git blame" slower.)

Okay. The documentation, or what I have read does not really explain this 
properly or concisely.

Thanks alot Steve.

Aaron
