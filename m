From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Fri, 07 Jun 2013 12:46:25 -0700
Message-ID: <7vwqq5snzi.fsf@alter.siamese.dyndns.org>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org>
	<20130607000006.GA25731@goldbirke>
	<CALkWK0=D7sHLgptWkFHma1FoS-zdifHqXnuuBKhkyuszgEJ0Xw@mail.gmail.com>
	<7v8v2lu5ks.fsf@alter.siamese.dyndns.org>
	<20130607191643.GA31625@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jun 07 21:46:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul2cM-0005ty-BV
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 21:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549Ab3FGTqa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 15:46:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56764 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754902Ab3FGTq3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 15:46:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFD7A26F78;
	Fri,  7 Jun 2013 19:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tK9FYcRM2bfC
	a3mHH12uHXxbTK0=; b=N70/yIQm5ocDnArSVGD92qmpy/C3hRFglsz/6Gy9ITqE
	0iCPd0H9dWGnHblTv5yiaDxQNB2f/54GGPLtlG5a8NZuoc0FY3ihmez22dqpQU5I
	95rqFn6NsEhEIUDJMq8Wa9We4ngESrAj31geJ017j8Tn8/CNyWo0JqQb1TOd0zE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=myCE5m
	IndiKVGZ/b6GvGkGOQ2OR1pLOI6uKOpcZYwz3i2oMI3lLmk6pKN7sJ0VpBmDi7yP
	FZuhF96JJk2EXka+QhX0x00+RfIEtRTm8zsqkh/tHfJYDLVMMcS7BxbYZoVZEOVl
	Ka6EqdiNBsNAb/nwX7yd7lKrYvsUyAJghN8vY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D325426F77;
	Fri,  7 Jun 2013 19:46:28 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 508F126F71;
	Fri,  7 Jun 2013 19:46:28 +0000 (UTC)
In-Reply-To: <20130607191643.GA31625@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
	"Fri, 7 Jun 2013 21:16:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1D7C6DE-CFAA-11E2-8127-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226689>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

>> Now I do not recall suggesting it, and you (and I today after 2
>> years) may disagree with the rationale, but at least we can read
>> what was the "intended" meaning, I think.
>
> See
>
>   http://thread.gmane.org/gmane.comp.version-control.git/167728/focus=
=3D168838
>
> I still agree with the rationale,...

Thanks for a pointer.  I think what I was suggesting was slightly
different in that I was hoping to see a single helper that knows to
complete to object names (possibly including trees/blobs with the
treeish:path notation), ranges, and pathnames (not treeish:path
notation) until it sees a "--" and then complete only to pathnames.

It can be improved by teaching the unified one that some command
like "log" can never take treeish:path but only committishes, some
command take individual object names but never ranges, and/or
details like that.  But I still agree that "git log HEAD:dir<TAB>"
that completes to a blob or a tree object name is not an issue
(because what was before <TAB> cannot possibly name anything "git
log" would appreciate), even though it might not be ideal.
