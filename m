From: Sergei Organov <osv@javad.com>
Subject: Re: Rollback of git commands
Date: Wed, 28 Nov 2007 21:39:56 +0300
Message-ID: <87lk8imcxv.fsf@osv.gnss.ru>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com>
	<7vmyszb39s.fsf@gitster.siamese.dyndns.org>
	<9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>
	<9e4733910711271749q1b96bfe9i60e43619c89234b9@mail.gmail.com>
	<ee77f5c20711271757h724d5fcep38f3c2354c54f20b@mail.gmail.com>
	<20071128165033.GA31218@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Symonds <dsymonds@gmail.com>, Jon Smirl <jonsmirl@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Nov 28 19:41:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxRqY-0006PO-GD
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 19:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbXK1Sk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 13:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbXK1Sk7
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 13:40:59 -0500
Received: from javad.com ([216.122.176.236]:2026 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842AbXK1Sk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 13:40:58 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lASIe2H44299;
	Wed, 28 Nov 2007 18:40:02 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1IxRpE-0007RL-NX; Wed, 28 Nov 2007 21:39:56 +0300
In-Reply-To: <20071128165033.GA31218@elte.hu> (Ingo Molnar's message of "Wed\, 28 Nov 2007 17\:50\:33 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66400>

Ingo Molnar <mingo@elte.hu> writes:

> * David Symonds <dsymonds@gmail.com> wrote:
>
>> On Nov 28, 2007 12:49 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>> > Rollback is too strong of name for this. Checkpoints would be better.
>> > The idea is to record the total system state at convenient moments and
>> > then allow moving back to the checkpointed state. The object store
>> > supports this, but the rest of the state in .git/* isn't being
>> > recorded.
>> 
>> rsync -a .git /somewhere/safe
>> 
>> I fear that what you ask becomes a chicken-and-egg scenario: where/how 
>> is this checkpointing information going to be stored? If it's tightly 
>> integrated with Git, what happens when you want to roll-back a 
>> checkpoint-restore?
>
> well, it would/could be the normal undo/redo semantics of editors: you 
> can undo-redo in a linear history fashion, in an unlimited way, but the 
> moment you modify any past point of history then the redo future is 
> overriden. (but the 'past' up to that point is still recorded and 
> available)

Or it could be Emacs-like: 'undo' is just another operation that is a
subject for further undo's ;) Then there is no need for 'redo', and no
need to override either the future or the past. Besides this obvious
technical superiority will help to maintain git's reputation of being
hard to grok ;)

-- 
Sergei.
