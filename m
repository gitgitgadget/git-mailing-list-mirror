From: David Kastrup <dak@gnu.org>
Subject: Re: pack bitmap woes on Windows
Date: Wed, 12 Feb 2014 14:23:05 +0100
Message-ID: <87ioska2iu.fsf@fencepost.gnu.org>
References: <52FB2268.7080906@viscovery.net>
	<87mwhwa3s1.fsf@fencepost.gnu.org> <52FB7196.7060209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Vicent =?iso-8859-1?Q?Mart=ED?= <tanoku@gmail.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 12 14:23:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDZmx-00087b-Th
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 14:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbaBLNXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 08:23:39 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:49227 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbaBLNXi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 08:23:38 -0500
Received: from localhost ([127.0.0.1]:48268 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WDZmr-0002kc-B2; Wed, 12 Feb 2014 08:23:37 -0500
Received: by lola (Postfix, from userid 1000)
	id A53ACE047A; Wed, 12 Feb 2014 14:23:05 +0100 (CET)
In-Reply-To: <52FB7196.7060209@viscovery.net> (Johannes Sixt's message of
	"Wed, 12 Feb 2014 14:05:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241990>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 2/12/2014 13:55, schrieb David Kastrup:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>> 
>>> Running test suite of 'next' on Windows fails in t5310-pack-bitmaps with
>>> the following symptoms. I haven't followed the topic. Have there been
>>> patches floating that addressed the problem in one way or another?
>>>
>>> (gdb) run
>>> Starting program: D:\Src\mingw-git\t\trash
>>> directory.t5310-pack-bitmaps/..\..\git.exe rev-list --test-bitmap
>>> HEAD
>>> [New thread 3528.0x8d4]
>>> Bitmap v1 test (20 entries loaded)
>>> Found bitmap for 537ea4d3eb79c95f602873b1167c480006d2ac2d. 64 bits
>>> / 15873b36 checksum
>> 
>> Does reverting a201c20b41a2f0725977bcb89a2a66135d776ba2 help?
>
> YES! t5310 passes after reverting this commit.

Oh.  I just looked through the backtrace until finding a routine
reasonably related with the regtest and checked for the last commit
changing it, then posted my question.

Then I looked through the diff of the patch and considered it
unconspicuous.  So I commenced reading through earlier commits.

I actually don't have a good idea what might be wrong here.  The code is
somewhat distasteful as it basically uses eword_t and uint64_t
interchangeably, but then this does match its current definition.

-- 
David Kastrup
