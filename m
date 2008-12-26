From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] ls-tree: add --full-tree option
Date: Fri, 26 Dec 2008 20:49:53 +0100
Message-ID: <49553561.4030902@kdbg.org>
References: <7v63l7rc1s.fsf@gitster.siamese.dyndns.org> <200812260916.45401.j6t@kdbg.org> <7vmyejpb6o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Deskin Miller <deskinm@umich.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 26 21:31:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGJKu-0005NX-V3
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 21:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbYLZU3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 15:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752647AbYLZU3r
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 15:29:47 -0500
Received: from mail.drei.at ([213.94.78.134]:14513 "EHLO mail.drei.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752536AbYLZU3r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 15:29:47 -0500
X-Greylist: delayed 2380 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Dec 2008 15:29:46 EST
Received: from atummr0mt01.um.internal ([172.23.102.132])
	by mail.drei.at  with ESMTP id mBQJniOK032334;
	Fri, 26 Dec 2008 20:49:44 +0100
Received: from [77.117.63.35] (atummr0vp02.um.internal [172.23.102.241])
	by atummr0mt01.um.internal (MOS 3.8.3-GA)
	with ESMTP id AJX97750;
	Fri, 26 Dec 2008 20:49:41 +0100 (CET)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <7vmyejpb6o.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103950>

Junio C Hamano schrieb:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> On Freitag, 26. Dezember 2008, Junio C Hamano wrote:
>>> This new option makes the command operate on the full tree object,
>>> regardless of where in the work tree it is run from.  It also implies the
>>> behaviour that is triggered by the existing --full-name option.
>> What's wrong with using 'git ls-tree ${rev}:'?
>>
>> Except that it does not work...
> 
> Hmph... you seem to be describing the exact issue they discussed on #git,
> which triggered the patch in the message you are responding to.  I am not
> sure what to say to your "What's wrong with...".

I'm saying that if a script has to be fixed to use --full-tree, then it 
can be fixed just as well by appending the colon to the ${rev}.

Not even porcelain 'git show ${rev}:' "is allowed" to insert the prefix. 
Dscho has argued the case passionately in the past:

http://thread.gmane.org/gmane.comp.version-control.git/68786/focus=68846

Therefore, plumbing 'ls-tree ${rev}:' shouldn't do that, either.

OTOH, you had yourself argued somewhat in favor of the current ls-tree 
behavior:

http://thread.gmane.org/gmane.comp.version-control.git/46232/focus=46400

I'm personally more in line with Dscho, and think that the current 
ls-tree behavior is a terrible bug.

-- Hannes
