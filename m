From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: FFmpeg considering GIT
Date: Fri, 04 May 2007 19:23:54 +0200
Message-ID: <87vef8ijth.fsf@mid.deneb.enyo.de>
References: <loom.20070502T111026-882@post.gmane.org>
	<20070503200013.GG4489@pasky.or.cz>
	<loom.20070504T143538-533@post.gmane.org>
	<200705041653.49486.andyparkins@gmail.com>
	<463B5ABB.5D7A3EC4@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 19:24:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk1Vh-0001wA-TD
	for gcvg-git@gmane.org; Fri, 04 May 2007 19:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161159AbXEDRX6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 13:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161224AbXEDRX6
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 13:23:58 -0400
Received: from mail.enyo.de ([212.9.189.167]:1632 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161159AbXEDRX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 13:23:57 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1Hk1Vb-0002JT-ET
	for git@vger.kernel.org; Fri, 04 May 2007 19:23:55 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1Hk1Va-0005NI-9s
	for git@vger.kernel.org; Fri, 04 May 2007 19:23:54 +0200
In-Reply-To: <463B5ABB.5D7A3EC4@eudaptics.com> (Johannes Sixt's message of
	"Fri, 04 May 2007 18:09:31 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46194>

* Johannes Sixt:

> Andy Parkins wrote:
>> On Friday 2007 May 04, Michael Niedermayer wrote:
>> > for these we currently copy the last good version of the affected files
>> > over the current one with svn cp and then apply the changes in nicely
>> > split manner. (possibly without the reindention if its uneeded ...)
>> 
>> I might be misunderstanding, but doesn't that leave the "bad" commit in the
>> history?
>
> In the history? Yes.
> In the blame? No.
>
>> 
>>  * -- * -- G -- B -- !B -- 1 -- 2 -- 3
>> 
>> B is the bad commit; !B would be the result of the svn cp from the previous
>> known-good revision, "G"; then 1, 2, and 3 would be the correctly split
>> version of "B".
>
> With svn cp you actually create this "blame" history:
>
> * -- * -- G -- B
>            \
>              ----- G* -- 1 -- 2 -- 3
>
> where G* is a new revision, but since it is otherwise identical to G, it
> does not introduce new blame-able lines.


With GIT, you could create:


* -- * -- G --- B
           \     \
             ---- 1 -- 2 -- 3

Or perhaps :

* -- * -- G --- B
           \     \
             ---- G* -- 1 -- 2 -- 3

How do the history viewers handle this situation?
