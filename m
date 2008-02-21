From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [Bug] Segfault in git status
Date: Thu, 21 Feb 2008 18:17:45 +0100
Message-ID: <9E63BCA0-A99A-468D-8DC9-47860D60BB5B@ai.rug.nl>
References: <F8D3F7F0-3A98-4576-BD89-6E5C682B351C@fastmail.fm> <D3C27E63-329D-4509-830A-099A7BCB72B7@ai.rug.nl> <76718490802210853t23b0498fkfb9a14bcd50ca458@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Dane Jensen" <careo@fastmail.fm>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 18:18:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSF47-0000nS-HW
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 18:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763590AbYBURR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 12:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763473AbYBURR5
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 12:17:57 -0500
Received: from smtp-2.orange.nl ([193.252.22.242]:37654 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762415AbYBURRz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 12:17:55 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6109.orange.nl (SMTP Server) with ESMTP id 4767F7000090
	for <git@vger.kernel.org>; Thu, 21 Feb 2008 18:17:54 +0100 (CET)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6109.orange.nl (SMTP Server) with ESMTP id DE2957000087;
	Thu, 21 Feb 2008 18:17:45 +0100 (CET)
X-ME-UUID: 20080221171751910.DE2957000087@mwinf6109.orange.nl
In-Reply-To: <76718490802210853t23b0498fkfb9a14bcd50ca458@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74637>


On Feb 21, 2008, at 5:53 PM, Jay Soffian wrote:
>>
> Do that again, but type "bt" at the gdb prompt after the crash  
> please. :-)
>
> j.

Program received signal EXC_BAD_ACCESS, Could not access memory.
Reason: KERN_INVALID_ADDRESS at address: 0x004a2010
index_name_exists (istate=0xeba80, name=0xbfffdc27 "Data/Cache/ 
Template/Peter_II_of_Yugoslavia.html", namelen=47) at read-cache.c:101
101			if (!(ce->ce_flags & CE_UNHASHED)) {
(gdb) backtrace
#0  index_name_exists (istate=0xeba80, name=0xbfffdc27 "Data/Cache/ 
Template/Peter_II_of_Yugoslavia.html", namelen=47) at read-cache.c:101
#1  0x0006fc04 in dir_add_name (dir=0xbfffef68, pathname=0xbfffdc27  
"Data/Cache/Template/Peter_II_of_Yugoslavia.html", len=47) at dir.c:374
#2  0x00070d11 in read_directory_recursive (dir=0xbfffef68,  
path=<value temporarily unavailable, due to optimizations>,  
base=<value temporarily unavailable, due to optimizations>,  
baselen=20, check_only=0, simplify=0x8072cc) at dir.c:642
#3  0x00070baf in read_directory_recursive (dir=0xbfffef68,  
path=<value temporarily unavailable, due to optimizations>,  
base=<value temporarily unavailable, due to optimizations>,  
baselen=11, check_only=0, simplify=<value temporarily unavailable, due  
to optimizations>) at dir.c:627
#4  0x00070baf in read_directory_recursive (dir=0xbfffef68,  
path=<value temporarily unavailable, due to optimizations>,  
base=<value temporarily unavailable, due to optimizations>, baselen=5,  
check_only=0, simplify=<value temporarily unavailable, due to  
optimizations>) at dir.c:627
#5  0x00070baf in read_directory_recursive (dir=0xbfffef68,  
path=<value temporarily unavailable, due to optimizations>,  
base=<value temporarily unavailable, due to optimizations>, baselen=0,  
check_only=0, simplify=<value temporarily unavailable, due to  
optimizations>) at dir.c:627
#6  0x00070ed3 in read_directory (dir=0xbfffef68, path=0xc446c ".",  
base=0xbb080 "", baselen=4857836, pathspec=0x0) at dir.c:715
#7  0x0009d4d6 in wt_status_print (s=0xbffff5ac) at wt-status.c:282
#8  0x000167c3 in run_status (fp=0xa015f5f8, index_file=0x500300 "/ 
Users/pieter/Documents/Studie/2007-2008/AWT/Project/.git/index",  
prefix=0x0, nowarn=4857836) at builtin-commit.c:347
#9  0x000171af in cmd_status (argc=1, argv=0x0, prefix=0x500300 "/ 
Users/pieter/Documents/Studie/2007-2008/AWT/Project/.git/index") at  
builtin-commit.c:783
#10 0x00002260 in handle_internal_command (argc=1, argv=0xbffff7b8) at  
git.c:259
#11 0x0000246f in main (argc=1, argv=0xbffff7b8) at git.c:451


There ya go

- Pieter
