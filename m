From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Sun, 21 Apr 2013 01:33:23 -0700
Message-ID: <7vvc7guvu4.fsf@alter.siamese.dyndns.org>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
	<1366458313-7186-5-git-send-email-artagnon@gmail.com>
	<7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
	<CALkWK0nFAzPPb0_jTRev6nuicCV81sRQAbe=277nhyyY8TnQ7A@mail.gmail.com>
	<7v8v4cwd6g.fsf@alter.siamese.dyndns.org>
	<CALkWK0kiT7vggXgqGs2iiMooiw7TyJEgr2=Yy06S7H1NKiWJ3g@mail.gmail.com>
	<7vzjwsuxzp.fsf@alter.siamese.dyndns.org>
	<CALkWK0kEngwYQieR=Xmvzu+XqBe+ZFxiWj0C8M-euFavDDaD2Q@mail.gmail.com>
	<20130421080907.GF10429@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:33:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTpiQ-0006WI-R0
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543Ab3DUId2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:33:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40438 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524Ab3DUId0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:33:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F285313765;
	Sun, 21 Apr 2013 08:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vf1De0/1jtW7bpjFW+pG/p9rLlc=; b=tyChM3
	LiuaOGkVTQybhYXiLEFz5HRBq1UkE6yl2fWDbmkKg4NYj1p6o8BVjgde6JR/2B24
	WN0+bC8jAjgbHFTxT50FalZzBrmebvasVmKmJA9RdzCeCj03l7Wx6yuET0sxR8Kr
	1gJErBwvtsqagGNlpLqrocUzcc2cwSqALXV1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JdBpeLMgsh9xF3e5aF00D0KyFRgjGurP
	jlJzqOEJlRMGH8nL3qkB1rKQJta0zXBLPecsCCW9qgrt1CfjpIPUQG832Vjrz2Kb
	A4javy6hMo0FJhI33myrBisCvXulmRKOx3Gifx/G4Yl31H8vuzjlWX1Y0zr27QoS
	gFcgthJkNvM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E657013764;
	Sun, 21 Apr 2013 08:33:25 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D8B813763;
	Sun, 21 Apr 2013 08:33:25 +0000 (UTC)
In-Reply-To: <20130421080907.GF10429@elie.Belkin> (Jonathan Nieder's message
	of "Sun, 21 Apr 2013 01:09:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2246F082-AA5E-11E2-9954-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221922>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ramkumar Ramachandra wrote:
>
>>                       I would say the most technically accurate
>> description of what 'git log' takes is a "committish range" (basically
>> a "revision range" that resolves to commits).
>
> What is a revision range that doesn't resolve to commits?  Am I wrong
> in thinking revision is nothing more than a synonym for commit?
>
> When gitrevisions(7) says "A revision parameter <rev> typically, but
> not necessarily, names a commit object", I suspect it is residue from
> 3a45f625 trying to apologize for the extended SHA1 syntax parser being
> called "git rev-parse" instead of "git object-name-parse".

 - A revision range is a slice of history.  There is no need for
   "committish revision range" as there is no other kinds of ranges.

 - A revision should be a synonym to a committish, as glossary
   defines.  We historically used "revision" more or less
   interchangeably with "object name", especially "an extended SHA-1
   expression that is used as an object name", to mean whatever
   get_sha1() can grok down to a single object name.  This must be
   rectified to avoid causing confusion to new readers of our
   documentation.

 - Documentation/revisions.txt needs to be cleaned up.  It lists
   "specifying revisions" and "specifying ranges", which is a good
   start primarily because some notations used in ranges are not
   revisions (e.g. "^C"), but it should have three (not two) sections.

   They are: "specifying revisions", "specifying object names", and
   "specifying ranges".  Move non committish specification such as
   <revision>:<path> from the current "specifying revisions" section
   and make the new "object names" section.  The "ranges" section is
   already written in terms of revisions, and does not need any
   update, once we clarify the definition of a "revision" as
   "committish".
