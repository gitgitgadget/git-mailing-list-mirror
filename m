From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I manage this setup with git-svn and/or git remotes?
Date: Fri, 17 Aug 2007 14:18:38 -0700
Message-ID: <7vvebdg8r5.fsf@gitster.siamese.dyndns.org>
References: <86y7gaxef5.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0708171042570.30176@woody.linux-foundation.org>
	<86d4xmxbjf.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0708171142510.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 23:18:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM9DV-000316-3d
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 23:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756317AbXHQVSp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 17:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbXHQVSp
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 17:18:45 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:52830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755321AbXHQVSo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 17:18:44 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D8D101233D7;
	Fri, 17 Aug 2007 17:19:02 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0708171142510.30176@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 17 Aug 2007 11:53:06 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56085>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 17 Aug 2007, David Kastrup wrote:
>> 
>> But it isn't an independent git project: the superproject has its
>> _own_ copy of dsp, with its _own_ specific commits and fixes that are
>> not supposed to ever end up in the dsp "mothership". 
>
> Sure. And that's different from any git "branch" exactly how?
>
> So you'd have different branches in the superproject - the way you always 
> have when you have two copies of a git project. And then you merge between 
> the two at will.

My reading of the project David is talking about is that its dsp
project which is a "subproject" part gets non generic commits
within the context of the superproject --- which means (1) you
would have branches in the subproject not superproject, and (2)
once you did that, the subproject is not really a subproject
anymore, as you cannot merge that back to the standalone dsp
project without dragging the non-generic bits along with it.

> There's a special "subtree" merge that does exactly that: it basically is 
> the normal recursive merge, except it merges into a subtree. I think 
> that's how Junio does the "git-gui" merges. Junio?

Yes.  It has exactly the same semantics and limitations with the
gitk merge, but just merges into a sub directory.  Shawn cannot
easily pull the changes done inside git.git repository back to
git-gui.git proper.
