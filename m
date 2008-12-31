From: Junio C Hamano <gitster@pobox.com>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and
 other non-sophisticated new Git users :-) [Scanned]
Date: Tue, 30 Dec 2008 20:48:20 -0800
Message-ID: <7v7i5hymp7.fsf@gitster.siamese.dyndns.org>
References: <BB5F02FD3789B54E8964D38D6775E718242D36@ALTMORE-SVR.altmore.local>
 <200812302141.02248.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Conor Rafferty" <conor.rafferty@altmore.co.uk>,
	"Jeff Whiteside" <jeff.m.whiteside@gmail.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Wed Dec 31 05:50:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHt1s-0005fZ-1H
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 05:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbYLaEsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 23:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbYLaEsg
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 23:48:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44173 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbYLaEsf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 23:48:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 90CF81B6D8;
	Tue, 30 Dec 2008 23:48:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5EC5F1B6D6; Tue,
 30 Dec 2008 23:48:27 -0500 (EST)
In-Reply-To: <200812302141.02248.bss@iguanasuicide.net> (Boyd Stephen Smith,
 Jr.'s message of "Tue, 30 Dec 2008 21:40:58 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 47CB9F14-D6F6-11DD-8A24-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104249>

"Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:

> On Tuesday 2008 December 30 20:30:46 Conor Rafferty wrote:
>> MERCURIAL:
>>
>> Update
>> hg update [-C] [-d DATE] [[-r] REV]
>
> Which is the role of "git checkout <branch>"
>
> "git checkout <branch> <paths>" is similar to "hg revert -r <branch> <paths>", 

No it is not.

The form of the command is makes this request:

    Please look into that named <tree-ish>, and check out the named
    <paths> out of it to my work tree.  Because the reason I want them in
    my work tree is so that I can include them as part of the next commit
    I am preparing to create in the index, please update these paths in my
    index while at it.

After working for some time on top of the current HEAD to make changes to
existing files in "lib/" directory, if you notice that none of your
changes in the directory does not make any sense, you may rather want to
start over from the version that you began with.  In such a case, you
would make the above request with <tree-ish> equal to HEAD and <paths>
equal to "lib", i.e.

    git checkout HEAD lib

and as the end result you may be able to achieve "reverting my crappy
changes to all of the files in lib/".

HOWEVER.

Read what the above request says carefully again, and think about what
would happen to a path that exists in the work tree but not in the named
<tree-ish>.

In other words, what would happen to a new file you added since you
started working on top of HEAD?

See?

A new file that you added in lib/ directory since you started working will
not be molested in any way, because they do not even exist in the
<tree-ish>.

If you think "git checkout <tree-ish> <paths>" has anything to do with
reverting, you will keep confusing yourself.  The command is "checking out
the named paths out of the named tree", and absense of a file is not
something that is checked out by this operation.
