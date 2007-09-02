From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and make stat use that implementation too.
Date: Sun, 02 Sep 2007 19:58:54 +0200
Organization: Organization?!?
Message-ID: <85sl5xoso1.fsf@lola.goethe.zz>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <3f4fd2640709020832x656fa78djf29117690318ea48@mail.gmail.com> <46DAE025.900@trolltech.com> <3f4fd2640709020933sa2bdec0g532500ea49c179b5@mail.gmail.com> <F0525923-6D9B-46AA-9678-8B1263C45FF7@silverinsanity.com> <3f4fd2640709020953k2f5367a0o64870da9d8e04f68@mail.gmail.com> <46DAED4F.2080407@trolltech.com> <Pine.LNX.4.64.0709021843270.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 19:59:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRtjA-0005JA-Rf
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 19:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967AbXIBR7J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 13:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752293AbXIBR7J
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 13:59:09 -0400
Received: from main.gmane.org ([80.91.229.2]:49898 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752562AbXIBR7I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 13:59:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IRtix-0007D9-TR
	for git@vger.kernel.org; Sun, 02 Sep 2007 19:59:03 +0200
Received: from dslb-084-061-038-061.pools.arcor-ip.net ([84.61.38.61])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Sep 2007 19:59:03 +0200
Received: from dak by dslb-084-061-038-061.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Sep 2007 19:59:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-038-061.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:rtU5vJ32MbezBSbqzc8ZYYo82as=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57373>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sun, 2 Sep 2007, Marius Storm-Olsen wrote:
>
>> The conversion of the FileTime to unix time_t is far more heavy.
>
> Really?  If so, we might consider storing FILETIME->dwHightDateTime and 
> ->dwLowDateTime in the index.
>
> But I doubt it.  AFAICT _getting_ at the stat data is the expensive thing 
> in Windows, not a 64-bit addition, subtraction and division.

64-bit division conceivably could be somewhat expensive, but it sounds
like it should not be much compared to the cost of a system call.
What is the code doing that division?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
