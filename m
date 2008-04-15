From: Junio C Hamano <gitster@pobox.com>
Subject: Re: branch description
Date: Tue, 15 Apr 2008 12:12:16 -0700
Message-ID: <7vej97x78v.fsf@gitster.siamese.dyndns.org>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com>
 <f9d2a5e10804151031o1d09c1f9od0ad78dcf9b746c5@mail.gmail.com>
 <C55CA6EB-D427-4CF5-923E-DE0071D2F870@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russ Dill <russ.dill@gmail.com>,
	"Stephen Sinclair" <radarsat1@gmail.com>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 21:15:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlqb7-0007uH-Vq
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 21:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760177AbYDOTM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 15:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760750AbYDOTM2
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 15:12:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754417AbYDOTM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 15:12:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 31B56332E;
	Tue, 15 Apr 2008 15:12:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 686463329; Tue, 15 Apr 2008 15:12:20 -0400 (EDT)
In-Reply-To: <C55CA6EB-D427-4CF5-923E-DE0071D2F870@silverinsanity.com> (Brian
 Gernhardt's message of "Tue, 15 Apr 2008 14:01:41 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79621>

Brian Gernhardt <benji@silverinsanity.com> writes:

> On Apr 15, 2008, at 1:31 PM, Russ Dill wrote:
>
>> The problem is that a branch is just a floating name for a line of
>> development. Its not really a "thing" in the repository like a tag or
>> a commit. You'd need to make some sort of special tag that describes
>> the branch or somesuch.
>
> No special tags needed.  A simple file that I'll call .git/info/
> ref_names could be a set of lines that have "<ref>\t<description>",
> like the following:
>
> refs/heads/master	Collection point for all my work
> refs/heads/ref_names	Add descriptions for branches
> refs/heads/segfault	Trying to fix bug #12345
>
> Simple, no tags, new object types or anything.  All you have to do is
> add the bits to git-branch to add, edit, and remove the description
> alongside the branch itself.
>
> Now if you want to propagate these descriptions when you push and
> pull, things get a lot more complicated.

Not complicated at all.  Put that description in-tree in a known location
(say, "help-branch") in-tree and your propagation problem is solved.

And have a scriptlet in $HOME/bin/git-help-branch to grep from that file.
