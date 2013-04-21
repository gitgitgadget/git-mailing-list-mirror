From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Sun, 21 Apr 2013 00:39:40 -0700
Message-ID: <7v4nf0wcw3.fsf@alter.siamese.dyndns.org>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
	<1366458313-7186-5-git-send-email-artagnon@gmail.com>
	<7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
	<CALkWK0nFAzPPb0_jTRev6nuicCV81sRQAbe=277nhyyY8TnQ7A@mail.gmail.com>
	<7v8v4cwd6g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 09:39:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTosF-0002lm-CN
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 09:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304Ab3DUHjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 03:39:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37553 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285Ab3DUHjn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 03:39:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95C0F14523;
	Sun, 21 Apr 2013 07:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V2Uk3Jbsg7q0AK3pQP1uaxe4qWA=; b=HVw8n+
	3Nrv6SlRZgUe7io0bEltb98+yqzuS0zQjGy/dpX1iY1n89B235CYmOVWD6AAzU1h
	0mVSbaGZBP1Qp1/oA6fi+Vq8NbaLAgvE4FW+91M4DQJREyTBd2ZWg9xoeFqcQagz
	6uXPRSOWBcZ6nMe5/jo7t35rimMq0JbxLy6I8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q7x5AmmKOLhtW4h1GKEKp8DVxI7G6+jB
	Xj2vfYAJ0HhbsaCEb2avK/zLZdi78PnA3jXwQuphVkcvy13rqa7ZMIMpqjkqoXBB
	f2sfHbmjLxguMeXU1xpWB6OxROWjH2TNr8GUoKRnGrJrMVDqdaXtMfcw65Ftd4jj
	oeLawu5j0G0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A2D114522;
	Sun, 21 Apr 2013 07:39:42 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CA9714521;
	Sun, 21 Apr 2013 07:39:41 +0000 (UTC)
In-Reply-To: <7v8v4cwd6g.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 21 Apr 2013 00:33:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A10FB546-AA56-11E2-9A9B-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221909>

Junio C Hamano <gitster@pobox.com> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>> I think "branch names" was an attempt to make it more newbie
>>> friendly by sacrificing technical accuracy.  With the suggested
>>> update (see the review for the previous one), it would be easier to
>>> read if this part said "options or the revision range".
>>
>> Why does it have to be a range? It might well be a list of revisions,
>
> Study "Specifying Ranges" section of gitrevisions and come back,
> perhaps?

A bit more specifically, there is a reason why we list "Specifying
Revisions" and "Specifying Ranges" separately in that manual page.

I think you are trying explain "git log --short A B ^C" as if it
takes "--short" (which is an option), "A", "B", and "^C" (all of
which are revisions).  And I am saying that is wrong.

It is "--short" (which is an option) and "A B ^C" (which is a
revision range).

"git log --short A" is taking "--short" (an option) and "A".  This
"A" is still a revision range and not a single revision.  It is a
single commit that is used to name a revision range which is the
entire history behind the commit "A".
