From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Announcing 3 git docs: Best Practices, fixing mistakes,
 post-production editing
Date: Tue, 28 Feb 2012 17:00:53 -0800
Message-ID: <7v399uxxkq.fsf@alter.siamese.dyndns.org>
References: <201202281304.q1SD4U8W018223@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Wed Feb 29 02:01:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Xug-0003Tj-P2
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 02:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966190Ab2B2BA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 20:00:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49351 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169Ab2B2BA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 20:00:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEE206BCD;
	Tue, 28 Feb 2012 20:00:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wZ0DJUlSf39CcBDH7axOT0RzUow=; b=FCSjDV
	CWBadX9Glnv6NepP3P3zpUBXasdGHDVVgrpQTW/4cp4E4ArhwfEziDlxZykezWUl
	jrrUf+ALU3T0JTBQSvel2R+vK91tKJs+PiOiQSrVL5z0JYZDmO7CLHqt+Ihiw1Vj
	ej9lqoIbNRSF2DF1UZ/7f1by4sdA1uib5IwyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YyRM9X7QpZKkkZn6TyMBmi/wT/IljsBe
	1hebP2Hxw0OzEq3pQnMUWINaOEAp3WvzN/5ybzK/9drDjqOe2hjTPQwRZFV/oRdn
	ov4aMGFL5g2xiL4RIWpPCffkWr3WdGJObKIzu63Q10r6gC5+dIuNTNtHA2Sf+XSf
	x09QxeNW4dU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A372D6BC1;
	Tue, 28 Feb 2012 20:00:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEC2B6BC0; Tue, 28 Feb 2012
 20:00:54 -0500 (EST)
In-Reply-To: <201202281304.q1SD4U8W018223@no.baka.org> (Seth Robertson's
 message of "Tue, 28 Feb 2012 08:04:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D514877E-6270-11E1-BFFC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191798>

Just a few I noticed that are dubious to be in a document that is meant to
describe "best practices".

"Do commit early and often"
---------------------------

* "Personally ... history of this repository!".  That looks somewhat out
  of place when you are trying to document "best practices".


"Don't panic"
-------------

* As we never "auto-stash", anything that is on stash is by definition
  what the user deliberately placed, just like a commit on a branch that
  the user may have forgotten.  So it is strange to count it as one of the
  three places that "lost" commit may be hiding.  If you make it four and
  add "a branch you might have forgotten" to the mix, it would make a bit
  more sense, though.

* The example command line for gitk passes --all and also everything from
  "log -g" output, which should be OK for toy history, but wouldn't be
  such a good idea when you can expect tons of data from "log -g".

  Doesn't "gitk" itself accept -g these days?

* Lost and found

  Why "git ls-tree -r"?  Doesn't "git show" work eqully well?

  Also, the name of the hash we happen to use to produce the "object name"
  is "SHA-1", so either of these two are fine, but do not say "SHA"
  (throughout the document).


"On Sausage Making"
-------------------

* The desription of "downside" shows a bias against efforts to strive for
  useful history, and also shows ignorance of the true motivation behind
  such discipline. It is _not_ blame or ego. It is all about leaving a
  history others can later use to understand _why_ the code became the way
  it is now, to make it less likely for others to break it.

  If I were writing this, I would either remove that one paragraph
  altogether, or tone it down dramatically.  There is a short-term
  downside that you would be spending time on perfecting the history
  instead of advancing the tip of the branch, especially when you know the
  tree at the tip of the perfected history will be identical to the tip of
  the messy history you currently have.  If you plan to leave the project
  in a month or so and will never look back, that is totally wasted effort
  as maintaining the result will be other people's problem.  But if you
  are planning to be involved in the project for a longer haul, the time
  and effort is worth spending to make less-than-useful history into
  useful one.


"Do keep up to date"
--------------------

* You explained in "Do choose a workflow" section that different workflows
  suite different projects.  It would read better to rephrase this
  paragraph in which you are admitting that not everybody agrees with your
  "pull --rebase".  Instead of saying "but they should agree with me", it
  would be more useful to say in what workflow and the workflow elements
  such as "pull --rebase" you advocate in this section are suited (you do
  not have to say in what other workflow they are inappropriate).

I stopped reading at this point, but will look at the rest some other day.
Thanks for a fun reading.
