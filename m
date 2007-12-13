From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Something is broken in repack
Date: Thu, 13 Dec 2007 16:32:03 +0100
Message-ID: <fjrj9k$n6k$1@ger.gmane.org>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>	 <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>	 <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>	 <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>	 <alpine.LFD.0.99999.0712110832251.555@xanadu.home>	 <alpine.LFD.0.99999.0712110951070.555@xanadu.home>	 <alpine.LFD.0.99999.0712111117440.555@xanadu.home>	 <9e4733910712110821o7748802ag75d9df4be8b2c123@mail.gmail.com>	 <alpine.LFD.0.99999.0712112057390.555@xanadu.home>	 <alpine.LFD.0.99999.0712120743040.555@xanadu.home> <fcaeb9bf0712130532s79aa7afeve6f018f9430ab3b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gcc@gcc.gnu.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 16:34:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2q4S-0003la-1F
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 16:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525AbXLMPdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 10:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754961AbXLMPdd
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 10:33:33 -0500
Received: from main.gmane.org ([80.91.229.2]:49145 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753456AbXLMPdc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 10:33:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1J2q35-0000Oq-7f
	for git@vger.kernel.org; Thu, 13 Dec 2007 15:32:31 +0000
Received: from 195.176.178.209 ([195.176.178.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Dec 2007 15:32:31 +0000
Received: from bonzini by 195.176.178.209 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Dec 2007 15:32:31 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 195.176.178.209
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <fcaeb9bf0712130532s79aa7afeve6f018f9430ab3b3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 7.1 points;
 *  0.0 RCVD_BY_IP Received by mail server with no name
 *  0.1 FORGED_RCVD_HELO Received: contains a forged HELO
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  3.0 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in bl.spamcop.net
 *      [Blocked - see <http://www.spamcop.net/bl.shtml?195.176.178.209>]
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68162>

Nguyen Thai Ngoc Duy wrote:
> On Dec 12, 2007 10:48 PM, Nicolas Pitre <nico@cam.org> wrote:
>> In the mean time you might have to use only one thread and lots of
>> memory to repack the gcc repo, or find the perfect memory allocator to
>> be used with Git.  After all, packing the whole gcc history to around
>> 230MB is quite a stunt but it requires sufficient resources to
>> achieve it. Fortunately, like Linus said, such a wholesale repack is not
>> something that most users have to do anyway.
> 
> Is there an alternative to "git repack -a -d" that repacks everything
> but the first pack?

That would be a pretty good idea for big repositories.  If I were to 
implement it, I would actually add a .git/config option like 
pack.permanent so that more than one pack could be made permanent; then 
to repack really really everything you'd need "git repack -a -a -d".

Paolo
