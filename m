From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [bug] git-add won't add foo/.git/bar
Date: Tue, 25 Mar 2008 00:55:56 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0803250045120.30488@kaos.quantumfyre.co.uk>
References: <fs9f0o$jge$1@ger.gmane.org> <Pine.LNX.4.64.0803242359230.24262@kaos.quantumfyre.co.uk>
 <7v1w5zslv5.fsf@gitster.siamese.dyndns.org> <7vve3br6ct.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Michael Gebetsroither <gebi@sbox.tugraz.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 01:57:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdxTQ-0003xE-Bb
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 01:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbYCYA41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 20:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754586AbYCYA41
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 20:56:27 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:59047 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752799AbYCYA40 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 20:56:26 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 0D16175C8D
	for <git@vger.kernel.org>; Tue, 25 Mar 2008 00:56:24 +0000 (GMT)
Received: (qmail 12630 invoked by uid 103); 25 Mar 2008 00:55:56 +0000
Received: from 192.168.0.4 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.4):. 
 Processed in 0.029791 secs); 25 Mar 2008 00:55:56 -0000
Received: from elfhelm.quantumfyre.co.uk (HELO kaos.quantumfyre.co.uk) (192.168.0.4)
  by neutron.datavampyre.co.uk with SMTP; 25 Mar 2008 00:55:56 +0000
X-X-Sender: jp3@kaos.quantumfyre.co.uk
In-Reply-To: <7vve3br6ct.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78137>

On Mon, 24 Mar 2008, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> Well, git won't allow .git as a element anywhere in the path, when we
>>> should only care about the _first_ one - and also, if you use
>>> --git-dir=banana then we still check for '.git' ... oops.
>>
>> That's not how git-dir is supposed to used, so there is no oops.
>
> The only purpose of git-dir is to have $GIT_DIR elsewhere _outside_ the
> work tree.

That's fair enough.  It's not enforced, or discourgaed in the 
documentation though.  Would a patch to mention that using 
--git-dir/GIT_DIR to change the name _inside_ the work tree is not 
supported be accepted?

> A few weeks ago somebody wanted to rename .git and I thought I responded
> well enough.  You certainly did not ask CVS or SVN folks to rename the
> control directories they sprinkle in your work trees to .cvs or .svn, did
> you?

Well, no - but then I hold git to a higher standard. ;)

> Leave .git alone so that people don't get confused.

Agreed, it is a) a lot simpler to explain, b) less likely to break things. 
Sorry for wasting your time :$, an interesting poke around the code 
though. :)

Something I noticed that seemed a bit odd when playing with this, should I 
expect git to stop me from trying to add files inside subprojects to the 
main project?  It seems to just discard the submodule and turn it into a 
normal directory when I do.  Is that intended behaviour?

-- 
Julian

  ---
Excess on occasion is exhilarating.  It prevents moderation from
acquiring the deadening effect of a habit.
 		-- W. Somerset Maugham
