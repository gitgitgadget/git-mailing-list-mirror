From: Luke Lu <git@vicaya.com>
Subject: Re: git packs
Date: Fri, 9 Nov 2007 22:36:03 -0800
Message-ID: <DF65F7E4-448A-4726-8B42-642776155A8F@vicaya.com>
References: <F6DD8DCD-416B-4DDF-B384-7213C9ED5565@mac.com> <alpine.LFD.0.9999.0711100011150.21255@xanadu.home> <FC175E4F-D9BE-42CC-B0BB-561B2EDCD941@mac.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: bob <kranki@mac.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 07:36:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqjxF-0001af-V4
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 07:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbXKJGgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 01:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbXKJGgN
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 01:36:13 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:3826 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbXKJGgM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 01:36:12 -0500
Received: by rv-out-0910.google.com with SMTP id k20so665438rvb
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 22:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        bh=A8mS4zmKjw/UOJEzyyJF1cauV51gbqAyojgOVaefKGI=;
        b=lAZ9RyBXT0kQQ/wyfVnpGumoDwAgUVxExm08EsU6jjPUHlP98R/uJpypNFUt18JpHVcJtTzljStVO4tbDNfDTwJ31Ut29zFe9zW+onEDx3kQomO0xoOgj/Z3gv6iK4e41gcJgNpyqe6HeLlSi0iw2eE6swoQwfdnuS+ExBXHQKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        b=O0gLezNtXto51G3Aon4CHZFqWyzipHJdXroKVR9pdA+aHr7zRO63eL9acy26WzfULcZ9lLOzZhRynORi8B4T9HmbJwsjBrmnQyP7Truth8YlIm5ih8L0Ct6bHBXxqg+ZyiRbZ/7fDkJR1y4o8Kl/FyLHtbQddXkvX/38zkwNTLA=
Received: by 10.141.97.5 with SMTP id z5mr1389742rvl.1194676572238;
        Fri, 09 Nov 2007 22:36:12 -0800 (PST)
Received: from ?192.168.15.20? ( [98.207.63.2])
        by mx.google.com with ESMTPS id f36sm5824324rvb.2007.11.09.22.36.06
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Nov 2007 22:36:08 -0800 (PST)
In-Reply-To: <FC175E4F-D9BE-42CC-B0BB-561B2EDCD941@mac.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64310>

On Nov 9, 2007, at 10:00 PM, bob wrote:
> When you say toolchain, are you referring to the compiler
> and associated libraries or are you referring to OS programs
> such as ls, md5, cat, etc or both?
>
> The reason that I ask is that I have been playing different
> scenarios using git 1.5.3.5 under MacOSX 10.4.10 mostly
> all day and every time that
>
> A) 	a file approaches or exceeds 2gig on an 'add', it
> 	results in:
> 	
> 	fatal: Out of memory? mmap failed: Cannot allocate memory
>
>
>
> B) 	the repository size less the .git subdirectory approaches
> 	4gig on a 'fetch' it results in:
>
> 	Resolving 3356 deltas...
> 	fatal: serious inflate inconsistency: -3 (unknown compression method)
> 	fatal: index-pack died with error code 128
> 	fatal: Fetch failure: ../rmwHtmlOld
>
> 	Under B, building the initial repository works fine.
>
> (I added a patch the Linus Torvalds gave out when a previous  
> inflate problem
> was being researched.)  Also, I have been looking in the source
> in particular in builtin-add.c builtin-pack-objects.c and  
> associated headers
> and see int and unsigned long being used a lot, but not any  
> unsigned long
> longs.  I have been testing on my laptop which has a 32-bit Intel  
> Core Duo.
> Also, I have run the same tests on a dual quad-core Intel processor
> which is 64 bit, (but not sure that Apple uses the 64 bits in  
> 10.4.10).  I
> get the same results as above.
>
> The zlib is at the latest revision of 1.2.3 and gcc is at 4.0.1
> which from what I can tell supports large files, because 'off_t' is  
> 8 bytes
> which is the size used for a 'stat' file size.

mmap(2), which git uses by default, is subject to vm limits  
(typically <2GB), regardless of large file support. file `which git`  
will probably tell you that it's a Mach-O executable i386 instead of  
x86_64. In order to get 64 bit binaries on Mactel boxes, you'll need  
the -m64 flag for gcc. I suspect that compiling with NO_MMAP option  
work as well.

__Luke
