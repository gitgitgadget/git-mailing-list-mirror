From: "Michael Johnson" <redbeard@mdjohnson.us>
Subject: Re: Segfault on merge with 1.6.2.1
Date: Sun, 29 Mar 2009 21:39:49 -0500
Message-ID: <op.urk20nanso3nzr@sulidor.mdjohnson.us>
References: <op.urifmtkkso3nzr@sulidor.mdjohnson.us>
 <20090329121700.GN22446@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Mar 30 04:41:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo7RK-0005ae-JO
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 04:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756522AbZC3Cj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 22:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbZC3Cj4
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 22:39:56 -0400
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:36264 "EHLO
	looneymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756245AbZC3Cjz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Mar 2009 22:39:55 -0400
Received: from sulidor.mdjohnson.us (216.49.248-IP-55.ckt.net [216.49.248.55])
	by looneymail-a5.g.dreamhost.com (Postfix) with ESMTP id ECA80122082;
	Sun, 29 Mar 2009 19:39:52 -0700 (PDT)
In-Reply-To: <20090329121700.GN22446@genesis.frugalware.org>
User-Agent: Opera Mail/9.64 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115053>

On Sun, 29 Mar 2009 07:17:00 -0500, Miklos Vajna <vmiklos@frugalware.org>  
wrote:

> On Sat, Mar 28, 2009 at 11:19:31AM -0500, Michael Johnson  
> <redbeard@mdjohnson.us> wrote:
>> The 1.6.2.1 version just segfaults, but 1.5.6.5 says:
>>
>> /usr/bin/git-merge: line 438: 32335 Segmentation fault
>> git-merge-$strategy $common -- "$head_arg" "$@"
>> Merge with strategy recursive failed.
>>
>> In all cases, .git/index.lock is left behind.
>
> That's because 1.6.2.1 has git-merge in C and it calls merge-recursive
> directly without a fork. Could you try it in gdb and provide a
> backtrace, please?

Well, I've got a backtrace, but I don't have debugging symbols,  
apparently. There is not a Debian package I can find that has them. I  
checked debug.debian.net, as well as the standard sid repository. So I  
will have to rebuild the package with debugging turned on. I will not be  
able to do that tonight, unfortunately. I will probably have a chance  
tomorrow evening.

Just in case it might be useful, though, here's the backtrace, without  
symbols.

Starting program: /usr/bin/git merge origin/dojo-1.3
(no debugging symbols found)
... repeated multiple times ...
[Thread debugging using libthread_db enabled]
(no debugging symbols found)
... repeated multiple times
[New Thread 0xb7a73b30 (LWP 21505)]

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0xb7a73b30 (LWP 21505)]
0x080e5a6f in ?? ()
(gdb) backtrace
#0  0x080e5a6f in ?? ()
#1  0x0893e000 in ?? ()
#2  0x000f0000 in ?? ()
#3  0xbf949098 in ?? ()
#4  0x080e63ad in ?? ()
#5  0x08977fcf in ?? ()
#6  0x000f0000 in ?? ()
#7  0xfff0ffff in ?? ()
#8  0x08945dd8 in ?? ()
#9  0x00000000 in ?? ()

Thanks for the continuing help.

Michael

-- 
Michael D Johnson   <redbeard@mdjohnson.us>    
redbeardcreator.deviantart.com

"Marketing research...[has] shown that energy weapons that make sounds sell
  better..." - Kevin Siembieda (Rifts Game Master Guide, pg 111)
