From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Tue, 18 Dec 2012 15:31:03 +0100
Message-ID: <87txrjsa8o.fsf@pctrast.inf.ethz.ch>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
	<7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
	<20121212094432.6e1e48c8@chalon.bertin.fr>
	<7v38zb3ux0.fsf@alter.siamese.dyndns.org>
	<877goht6eu.fsf@pctrast.inf.ethz.ch>
	<20121217114058.449cbc3c@chalon.bertin.fr>
	<CAP8UFD2pkotNy=t5wTxDH-pMivQsTz-kw2y8Y7rWY42YKabp7g@mail.gmail.com>
	<m21ueo78f8.fsf@igel.home> <7vwqwgjs8f.fsf@alter.siamese.dyndns.org>
	<20121218120058.0c558ba5@chalon.bertin.fr>
	<50D05BAF.4000200@viscovery.net> <871uentthz.fsf@pctrast.inf.ethz.ch>
	<20121218144157.00ccd915@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Christian Couder <christian.couder@gmail.com>,
	git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Tue Dec 18 15:31:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkyCc-0002cB-SR
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 15:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120Ab2LRObI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 09:31:08 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:29940 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755101Ab2LRObH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 09:31:07 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Dec
 2012 15:31:01 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 18 Dec 2012 15:31:04 +0100
In-Reply-To: <20121218144157.00ccd915@chalon.bertin.fr> (Yann Dirson's message
	of "Tue, 18 Dec 2012 14:41:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211748>

Yann Dirson <dirson@bertin.fr> writes:

>> +EXAMPLE
>> +-------
>> +
>> +Replacements (and before them, grafts) are often used to replace the
>> +parent list of a commit.  Since commits are stored in a human-readable
>> +format, you can in fact change any property using the following
>> +recipe:
>> +
>> +------------------------------------------------
>> +$ git cat-file commit original_commit >tmp
>> +$ vi tmp
>> +------------------------------------------------
>> +In the editor, adjust the commit as needed.  For example, you can edit
>> +the parent lists by adding/removing lines starting with "parent".
>> +When done, replace the original commit with the edited one:
>> +------------------------------------------------
>> +$ git replace original_commit $(git hash-object -w tmp)
>
> You probably meant "-t commit" - a sign that it's not so trivial to forge ?

Mostly a sign that despite my testing efforts, I still fail at
cut&paste...

But yes, it absolutely needs -t commit.  Otherwise the commit would be
replaced by a blob, and confusion ensues.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
