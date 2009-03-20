From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: ref name troubles, was Re: [PATCH v2] Introduce %<branch> as
   shortcut to the tracked branch
Date: Fri, 20 Mar 2009 15:31:51 +0100
Message-ID: <49C3A8D7.1040509@drmicha.warpmail.net>
References: <7vr60ubgul.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de> <20090320004029.GX23521@spearce.org> <20090320060545.GB27008@coredump.intra.peff.net> <7vprgc4r6h.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903201029290.10279@pacific.mpi-cbg.de> <20090320111238.GZ8940@machine.or.cz> <alpine.DEB.1.00.0903201245140.6865@intel-tinevez-2-302> <20090320115043.GB8940@machine.or.cz> <alpine.DEB.1.00.0903201255230.6865@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 15:33:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkfnD-0007BY-2r
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 15:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248AbZCTOcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 10:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754225AbZCTOcJ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 10:32:09 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48330 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752603AbZCTOcI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 10:32:08 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 12DEE2F4770;
	Fri, 20 Mar 2009 10:32:06 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 20 Mar 2009 10:32:06 -0400
X-Sasl-enc: aMRJV1p5L3Gl1/f6CYcDGJOYr5UYyRUxA2EEm3XLIre4 1237559525
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CE3844D02D;
	Fri, 20 Mar 2009 10:32:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090320 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <alpine.DEB.1.00.0903201255230.6865@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113964>

Johannes Schindelin venit, vidit, dixit 20.03.2009 12:57:
> Hi,
> 
> On Fri, 20 Mar 2009, Petr Baudis wrote:
> 
>> On Fri, Mar 20, 2009 at 12:46:19PM +0100, Johannes Schindelin wrote:
>>
>>> On Fri, 20 Mar 2009, Petr Baudis wrote:
>>>
>>>> On Fri, Mar 20, 2009 at 10:30:29AM +0100, Johannes Schindelin wrote:
>>>>> On Thu, 19 Mar 2009, Junio C Hamano wrote:
>>>>>
>>>>>> I think you are right.  It is just "git branch" and perhaps "git
>>>>>> update-ref" are too loose in enforcing what can be created.
>>>>>
>>>>> "git branch" I agree with, but not "git update-ref".  As plumbing, the 
>>>>> latter should be much more allowing, feeding rope aplenty (but also 
>>>>> allowing cool tricks we do not think about yet).
>>>>
>>>> We shouldn't allow creating insane ref names even with update-ref. That
>>>> way porcelains cannot rely on update-ref to sanity check the user's
>>>> crap. At most, maybe you might want to bypass this check with some force
>>>> switch, though I really can't quite imagine why.
>>>
>>> You really cannot imagine?  You, the author of filter-branch?  People _do_ 
>>> have fscked-up repositories, but they get really angry when they cannot 
>>> use rebase or filter-branch on them.
>>
>> They can rename the ref as the first step of a cleanup, can't they?
> 
> Well, of course, we can make life hard on everybody.  That is quite 
> possible.
> 
> But then, we can be nice, and at the same time fix the problem _properly_.
> 
> IMHO a _warning_ should be the best thing.
> 
> But all this does not solve _my_ problem: I'd like something as easy to 
> write as %next, but as unlikely to be used in existing refs as @{..}.

Do we have ^ as a prefix yet?
Neither the suffix (commit^) nor the infix (commit^{type}) allow an
empty commit (for HEAD) - which might be nice, though. So, ^ as a prefix
is free, even without any specifier after.

Also, I don't think people would use @@ much in branch names.

Michael
