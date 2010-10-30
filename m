From: Mathias Lafeldt <misfire@debugon.org>
Subject: Re: git merge-tree segfault
Date: Sat, 30 Oct 2010 19:26:26 +0200
Message-ID: <4CCC5542.8020105@debugon.org>
References: <AANLkTinJQCqwRZpbO66VHrgxezedS1Ay3nr9kayiODi9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Klas Lindberg <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 30 19:27:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCFCt-0003B6-SC
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 19:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755435Ab0J3R0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Oct 2010 13:26:30 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:60679 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144Ab0J3R03 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 13:26:29 -0400
Received: from [192.168.2.102] (dslb-088-071-184-013.pools.arcor-ip.net [88.71.184.13])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0McRym-1OuZmt2GbQ-00I2mu; Sat, 30 Oct 2010 19:26:27 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.15) Gecko/20101027 Thunderbird/3.0.10
In-Reply-To: <AANLkTinJQCqwRZpbO66VHrgxezedS1Ay3nr9kayiODi9@mail.gmail.com>
X-Provags-ID: V02:K0:DY+VypdGADnnTLvhwJnf2AVYyyywes0W/mocQNTlLfG
 OeU99G6SqbM5zDQ47V2p/yqwx9R8UcrFcAmZI94tY66WdhZyuY
 /0jvqoQoWmvGz1Zthl1L8rVGTD1GVJIYLp3g/4KZdvbQ0x5Tmh
 eWzqIwMgt3BowJfndGW2ydDZldVuN4ewrGuYPtf5u+BEmmpCaC
 lEORpfoBo35KRmj6Ct/sqvFx4Op37NjIfzZJM4A9ik=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160403>

On 10/28/2010 10:16 PM, Klas Lindberg wrote:
> I haven't tried this on newer versions of git, but the release notes
> for later releases don't mention merge-tree anywhere, so...
> 
> git version: 1.7.0
> uname -a: Linux tor 2.6.32-trunk-amd64 #1 SMP Sun Jan 10 22:40:40 UTC
> 2010 x86_64 GNU/Linux
> distro: Debian GNU/Linux squeeze/sid
> 
> Unpack the attached tree, cd into it and run:
> git merge-tree common master other
> 
> I get the following result:
> added in local
>   our    100644 d68dd4031d2ad5b7a3829ad7df6635e27a7daa22 t1.txt
> Segmentation fault
> 
> The exit code:
> 139
> 
> BR / Klas

Looks like this has been fixed by 21baa6e (merge-tree: fix where two
branches share no changes, 2010-07-14).

$ git merge-tree common master other
added in local
  our    100644 d68dd4031d2ad5b7a3829ad7df6635e27a7daa22 t1.txt

$ echo $?
0

$ git --version 
git version 1.7.3.2

-Mathias
