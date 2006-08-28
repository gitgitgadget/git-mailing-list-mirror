From: David Lang <david.lang@digitalinsight.com>
Subject: Re: Starting to think about sha-256?
Date: Mon, 28 Aug 2006 10:27:29 -0700
Message-ID: <656C30A1EFC89F6B2082D9B6@localhost>
References: <44F1DCB7.6020804@garzik.org>
 	<m31wr1exbf.fsf@defiant.localdomain>
 <Pine.LNX.4.64.0608271343120.27779@g5.o	sdl.org>
 <Pine.LNX.4.63.0608272341330.28360@wbgn013.biozentrum.uni-wuerzburg	.de>
 <Pine.LNX.4.64.0608271522390.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 28 19:33:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHkyn-0007rf-9b
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 19:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWH1Rcy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 13:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWH1Rcy
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 13:32:54 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:60835 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1750796AbWH1Rcx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 13:32:53 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Mon, 28 Aug 2006 10:32:53 -0700
Received: from [10.201.10.67] ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Mon, 28 Aug 2006 10:32:19 -0700
To: Linus Torvalds <torvalds@osdl.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.64.0608271522390.27779@g5.osdl.org>
X-Mailer: Mulberry/4.0.5 (Linux/x86)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26169>

--On Sunday, August 27, 2006 03:35:20 PM -0700 Linus Torvalds 
<torvalds@osdl.org> wrote:
>
> On Mon, 28 Aug 2006, Johannes Schindelin wrote:
>> Even if the breakthrough really comes to full SHA-1, you still have to
>> add  _at least_ 20 bytes of gibberish. Which would be harder to spot,
>> but it  would be spotted.
>
> Yeah, I don't think this is at all critical, especially since git really
> on a security level doesn't _depend_ on the hashes being
> cryptographically  secure. As I explained early on (ie over a year ago,
> back when the whole  design of git was being discussed), the _security_
> of git actually depends  on not cryptographic hashes, but simply on
> everybody being able to secure  their own _private_ repository.
>
> So the only thing git really _requires_ is a hash that is _unique_ for
> the  developer (and there we are talking not of an _attacker_, but a
> benign  participant).
>
> That said, the cryptographic security of SHA-1 is obviously a real bonus.
> So I'd be disappointed if SHA-1 can be broken more easily (and I
> obviously  already argued against using MD5, exactly because generating
> duplicates of  that is fairly easy). But it's not "fundamentally
> required" in git per se.


>> This made me think about the use of hashes in git. Why do we need a hash
>> here (in no particular order):
>>
>> 1) integrity checking,
>> 2) fast lookup,
>> 3) identifying objects (related to (2)),
>> 4) trust.
>>
>> Except for (4), I do not see why SHA-1 -- even if broken -- should not
>> be  adequate. It is not like somebody found out that all JPGs tend to
>> have  similar hashes so that collisions are more likely.
>
> Correct. I'm pretty sure we had exactly this discussion around May 2005,
> but I'm too lazy to search ;)

just to double check.

if you already have a file A in git with hash X is there any condition 
where a remote file with hash X (but different contents) would overwrite 
the local version?

what would happen if you ended up with two packs that both contained a file 
with hash X but with different contents and then did a repack on them? 
(either packs from different sources, or packs downloaded through some 
mechanism other then the git protocol are two ways this could happen that I 
can think of)

David Lang
