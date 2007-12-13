From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Something is broken in repack
Date: Thu, 13 Dec 2007 17:39:32 +0100
Message-ID: <47616044.7070504@viscovery.net>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>	 <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>	 <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>	 <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>	 <alpine.LFD.0.99999.0712110832251.555@xanadu.home>	 <alpine.LFD.0.99999.0712110951070.555@xanadu.home>	 <alpine.LFD.0.99999.0712111117440.555@xanadu.home>	 <9e4733910712110821o7748802ag75d9df4be8b2c123@mail.gmail.com>	 <alpine.LFD.0.99999.0712112057390.555@xanadu.home>	 <alpine.LFD.0.99999.0712120743040.555@xanadu.home> <fcaeb9bf0712130532s79aa7afeve6f018f9430ab3b3@mail.gmail.com> <fjrj9k$n6k$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gcc@gcc.gnu.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Dec 13 17:40:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2r6R-0008Rd-82
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 17:40:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbXLMQjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 11:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752671AbXLMQjh
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 11:39:37 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:47067 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbXLMQjg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 11:39:36 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J2r6G-0001I1-21; Thu, 13 Dec 2007 17:39:54 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 53A1069F; Thu, 13 Dec 2007 17:39:32 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <fjrj9k$n6k$1@ger.gmane.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68174>

Paolo Bonzini schrieb:
> Nguyen Thai Ngoc Duy wrote:
>> On Dec 12, 2007 10:48 PM, Nicolas Pitre <nico@cam.org> wrote:
>>> In the mean time you might have to use only one thread and lots of
>>> memory to repack the gcc repo, or find the perfect memory allocator to
>>> be used with Git.  After all, packing the whole gcc history to around
>>> 230MB is quite a stunt but it requires sufficient resources to
>>> achieve it. Fortunately, like Linus said, such a wholesale repack is not
>>> something that most users have to do anyway.
>>
>> Is there an alternative to "git repack -a -d" that repacks everything
>> but the first pack?
> 
> That would be a pretty good idea for big repositories.  If I were to
> implement it, I would actually add a .git/config option like
> pack.permanent so that more than one pack could be made permanent; then
> to repack really really everything you'd need "git repack -a -a -d".

It's already there: If you have a pack .git/objects/pack/pack-foo.pack, then
"touch .git/objects/pack/pack-foo.keep" marks the pack as precious.

-- Hannes
