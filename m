From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: Re: [PATCH 2/2] allow '%d' pretty format specifier to show
 decoration
Date: Wed, 20 Aug 2008 23:05:43 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0808202305230.4170@pollux>
References: <20080820175325.GD27773@sigill.intra.peff.net> <20080820180034.GB32005@sigill.intra.peff.net> <alpine.LNX.1.10.0808202138340.4070@pollux> <7vzln7phe1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 23:07:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVuti-00042J-AM
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 23:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbYHTVGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 17:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753064AbYHTVGO
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 17:06:14 -0400
Received: from mailout08.t-online.de ([194.25.134.20]:54894 "EHLO
	mailout08.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbYHTVGN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 17:06:13 -0400
Received: from fwd31.aul.t-online.de 
	by mailout08.sul.t-online.de with smtp 
	id 1KVusH-0004at-03; Wed, 20 Aug 2008 23:05:49 +0200
Received: from [192.168.2.100] (VOAOQBZZQhYAbOuKg+3dsfON7mo8-UVLNUs8DfsEcn6CMLlYItfpEuQssDqG4Nhwhz@[84.163.223.118]) by fwd31.t-online.de
	with esmtp id 1KVusE-1kFUgK0; Wed, 20 Aug 2008 23:05:46 +0200
X-X-Sender: michael@pollux
In-Reply-To: <7vzln7phe1.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
X-ID: VOAOQBZZQhYAbOuKg+3dsfON7mo8-UVLNUs8DfsEcn6CMLlYItfpEuQssDqG4Nhwhz
X-TOI-MSGID: dfd56af3-30be-4c47-9dfa-7eae2dfa3499
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93045>



On Wed, 20 Aug 2008, Junio C Hamano wrote:

> Michael Dressel <MichaelTiloDressel@t-online.de> writes:
>
>> I use it in a script to extract the log title of commits between certain
>> tags.
>
> "git shortlog"?
>

I use my script to see all the changes (by log titles) between
the commit (prev) I ran the script the last time and the current commit (curr). Now there may be uninteresting tags and some commits may have more
than one tag. Merges made before tag B may introduce commits (say c1) that are 
made before say tag A but with git log prev..curr I may get a list like this

curr (current commit)
.
.
B (latest tag)
A (previous tag)
c1 (commit merged some time between A and B. 
.
.
prev (commit when script was run the last time)


Actually I use "git rev-list prev..curr" to get a list  of commits between
the last time I ran the script and the current head of the branch. Then
I need the git log --decorate only to get _all_ the tags assigned to a 
given commit. Git describe     does not give all the tags, as discussed
earlier. The resulting list of tags assigned to a commit is later
searched for the tag names I'm interested in. And then I use git log
again (git log A..B ) to extract the log titles between every two successive
tags, at this point I may use git shortlog.



Cheers,
Michael
