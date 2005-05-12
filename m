From: Wink Saville <wink@saville.com>
Subject: How-to create a new repository using cogito
Date: Thu, 12 May 2005 08:37:11 -0700
Message-ID: <42837827.8020404@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu May 12 17:21:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWFUT-00064G-Tn
	for gcvg-git@gmane.org; Thu, 12 May 2005 17:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVELP2Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 11:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVELP2Y
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 11:28:24 -0400
Received: from adsl-66-218-52-146.dslextreme.com ([66.218.52.146]:33039 "EHLO
	saville.com") by vger.kernel.org with ESMTP id S262031AbVELP2Q
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 11:28:16 -0400
Received: from [192.168.0.18] (unknown [192.168.0.18])
	by saville.com (Postfix) with ESMTP id C4A2CF1B07
	for <git@vger.kernel.org>; Thu, 12 May 2005 08:22:48 -0400 (EDT)
Received: from 127.0.0.1 (AVG SMTP 7.0.308 [266.11.8]); Thu, 12 May 2005 08:37:11 -0700
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

I've successfully followed the instructions in the cogito README and 
gotten both cogito repositories and linux. I then tried to create a 
local repository for a directory of my own. But was unsuccessful.

<Attempted to do the following>

wink@tuxws git-linux $ mkdir test
wink@tuxws git-linux $ cd test
wink@tuxws test $ echo "some data" > src.c
wink@tuxws test $ cat src.c
some data
wink@tuxws test $ cg-clone -s .
defaulting to local storage area
`/home/wink/git-linux/test/./.git/refs/heads/master' -> 
`.git/refs/heads/origin'
cg-pull: objects pull failed
cg-init: pull failed

<forged ahead despite the error's>

wink@tuxws test $ cg-add src.c
Adding file src.c
wink@tuxws test $ cg-commit
usage: git-diff-cache [-p] [-r] [-z] [-m] [--cached] <tree sha1>
cg-commit: Nothing to commit

<using "cg-commit ." did prompt me for log info>

wink@tuxws test $ cg-commit .
Ignoring path .
usage: read-tree (<sha> | -m <sha1> [<sha2> <sha3>])
error: mmap failed
fatal: cache corrupted
cg-commit: update-cache failed
wink@tuxws test $ cg-log
cat: .git/refs/tags/: Is a directory
cat: .git/refs/heads/: Is a directory
Invalid id:

<contents of .git>

wink@tuxws test $ find .git -type f
.git/refs/heads/master
.git/refs/heads/origin
.git/index
.git/branches/origin
.git/objects/42/6863280eedd08aa600ac034e6a9933ba372944

So something happened but I'm obviously missing something. Also why does 
this fail?

wink@tuxws test $ cd .git/objects/42/
wink@tuxws test $ git-cat-file 6863280eedd08aa600ac034e6a9933ba372944
usage: git-cat-file [-t | tagname] <sha1>

Thanks,

Wink


-- 
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.308 / Virus Database: 266.11.8 - Release Date: 5/10/2005

