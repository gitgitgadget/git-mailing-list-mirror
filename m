From: Yves Goergen <nospam.list@unclassified.de>
Subject: Re: Bug? Git checkout fails with a wrong error message
Date: Fri, 13 Jan 2012 18:46:07 +0100
Message-ID: <4F106DDF.4040408@unclassified.de>
References: <loom.20120112T193624-86@post.gmane.org> <4F1028AD.9080701@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jan 13 19:09:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RllZO-0005DY-JU
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 19:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506Ab2AMSJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 13:09:38 -0500
Received: from dotforward.de ([178.63.102.138]:52875 "EHLO dotforward.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231Ab2AMSJh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 13:09:37 -0500
X-Greylist: delayed 1406 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Jan 2012 13:09:37 EST
Received: from dsl01.83.171.159.183.ip-pool.nefkom.net ([83.171.159.183] helo=[192.168.1.13])
	by dotforward.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <nospam.list@unclassified.de>)
	id 1RllCa-0000L3-G9; Fri, 13 Jan 2012 18:46:08 +0100
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <4F1028AD.9080701@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188523>

On 13.01.2012 13:50 CE(S)T, Holger Hellmuth wrote:
> Important information missing: What version of git are you using? Should 
> the version number begin with 1.6 or even lower you will get the advice 
> to update your version to something non-ancient. Lots of bug-fixes 
> happened in-between.

The first bug happened with msysGit 1.7.6 and 1.7.8, the second one
(reported now) with 1.7.8. That update didn't change a thing.

> I assume .cs is a C source file for visual studio, not a generated file, 
> right ?

.cs is C# code and .Designer.cs files are used internally by the Visual
Studio designer. They're not supposed to be edited by the programmer and
contain lots of stuff that changes all the time. So they are generated
and presented in a different way.

> git does not record renames like cvs/svn do. It operates on snapshots 
> and infers renames through comparisions. So if the next commit has a 
> file missing and the same or similar file contents under some different 
> path, it reports it as a rename. You can try -M with git log or git diff 
> so that git expends more effort to detect renames+edits. Or you could 
> avoid doing renames and edits of the same file in the same commit.

I renamed the file and created a new one with the same name. Is it so
simple to crash the Git repository?

>> -----
>> git.exe checkout    form-refactoring
>>
>> Aborting
>> error: The following untracked working tree files would be overwritten by
>> checkout:
>> Form1.Designer.cs
>> Please move or remove them before you can switch branches.
>> -----
> 
> You didn't mention that filename before (please assume people not 
> accustomed to the ways of Visual Studio 2010). Is that another file you 
> renamed and created new in the form-refactoring branch?

Form1.cs, Form1.Designer.cs and Form1.resx all belong together and are
renamed atomically. If I rename "Form1" in the project, actually these 3
files are renamed on disk.

> What does git diff -- Form1.Designer.cs' say?

Nothing.

> What does 'git diff form-refactoring -- Form1.Designer.cs' say?

All lines deleted.

Will this message also appear on the mailing list where I posted my
first message with Gmane? (That's the only thing I've found on the
official Git website.)

-- 
Yves Goergen "LonelyPixel" <nospam.list@unclassified.de>
Visit my web laboratory at http://beta.unclassified.de
