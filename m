From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Is my repository broken?
Date: Wed, 9 Apr 2008 11:01:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0804091046170.14797@reaper.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0804082246160.8753@kaos.quantumfyre.co.uk>
 <20080408225522.GD10274@spearce.org> <Pine.LNX.4.64.0804090003480.10813@kaos.quantumfyre.co.uk>
 <7vbq4jcyj7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 12:03:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjX98-0000fX-VN
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 12:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbYDIKCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 06:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752432AbYDIKCb
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 06:02:31 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:48762 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752377AbYDIKCb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Apr 2008 06:02:31 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 6863D144BF6
	for <git@vger.kernel.org>; Wed,  9 Apr 2008 11:02:29 +0100 (BST)
Received: (qmail 5950 invoked by uid 103); 9 Apr 2008 11:02:42 +0100
Received: from 212.159.54.234 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.030382 secs); 09 Apr 2008 10:02:42 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.datavampyre.co.uk with SMTP; 9 Apr 2008 11:02:42 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <7vbq4jcyj7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79094>

On Tue, 8 Apr 2008, Junio C Hamano wrote:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>> On Tue, 8 Apr 2008, Shawn O. Pearce wrote:
>>
>>> The same holds true for the empty ident.
>>
>> Ok - but I can't even find a note in the manpage for this one ...
>
> That's not a fair complaint.

I didn't mean it as a complaint, but rather was hoping for a response of 
the form "no, it's not there" or "it's in the ... section" - sorry for not 
being clear.  It caught me out, if that was my own fault then fair enough 
- but if this was because the documentation doesn't make it clear then I 
can submit a documentation patch to try and help others avoid the same 
problem.

I think that the fast-import tool is extremely useful, and generally very 
well documented.  That doesn't mean that the documentation can't be 
improved though.

> It is often very hard to document that "we do not do X", because the line
> to stop at becomes fuzzier as you try to do more thorough job.  We do not
> warn on empty ident, we do not warn on typos in commit log messages, we do
> not warn on empty blob, we do not warn on ...  You get the idea.

Git doesn't die when trying to commit typos though ...  I think "creating 
a commit that you could not create using git-commit" is a pretty hard 
line.

I don't think that it is entirely unreasonable to expect that when an 
existing repository is run through a tool like filter-branch that all your 
existing commits are preserved - and that you don't lose large chunks 
because it turns out that they are actually invalid by the rules of 
git-commit.

I accept that you may want fast-import to create things that are 
technically illegal, but at the very least it ought to be possible to find 
out what restrictions are not being enforced.  Otherwise it might be that 
you manage to destroy a previously functioning repository by accident long 
after you thought you had successfully converted your respository.  After 
all, I would have thought that the majority of people using fast-import 
(either directly, or indirectly by using a fast-import based importer) 
would actually intend to use the repository created with the normal git 
tools from then on.

-- 
Julian

  ---
I have often regretted my speech, never my silence.
 		-- Publilius Syrus
