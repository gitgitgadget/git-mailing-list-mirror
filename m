From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/10] Sequencer Foundations
Date: Thu, 26 May 2011 12:13:53 -0700
Message-ID: <7vpqn5w9zi.fsf@alter.siamese.dyndns.org>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 21:14:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPg0c-0004mZ-RB
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 21:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758315Ab1EZTOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 15:14:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225Ab1EZTOI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 15:14:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 511C94737;
	Thu, 26 May 2011 15:16:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=blvaX8250ewHpoHHCVaYML6jmXo=; b=W798yZ
	Kh8MqtCZFCsn8EKTOZ/xdAhp0Q1KDFGl/lxrVxIQH8jt+g8165WuqrBblsjZfvKo
	4wRyiQLV0r/mNOoMSLYlDh+/jZTIkjFvp8i1CjzwHz8jpCC6snXE+nxNWBC9qKUX
	IcW5PIg7rkJNaDOdC21jk9mVG8qPf9ae8eddE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PcTECShbYmosi2VMYzIRRLYIceZgedjw
	o24TdTorHaYLzQteAkpIRmds6gb0l5S4Q+1dfyaHhsPUTh0Tj0wFLi/MMe9vr3q4
	gTFylhfo4jl0MXvQqY/ZV7gFPL+W6Su4zmOwukqGsEaqt2Px1RNGLKBuxCe4+FoH
	a26gJ6U/kxk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ED56D4734;
	Thu, 26 May 2011 15:16:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 081394731; Thu, 26 May 2011
 15:16:01 -0400 (EDT)
In-Reply-To: <1306425233-504-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Thu, 26 May 2011 15:53:43 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C723D0A-87CC-11E0-9A15-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174560>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> This is a quick re-roll after Junio's review of the previous
> iteration; the previous iteration was posted less than 24 hours ago.
> I'm in a hurry,...

Open source is not just about pushing new code through other people's
throats, but also about the skill to make other people around you to work
with you. They may be busy spending time on helping other topics moving
forward. Or they may simply be bone-headed ;-).

If you are in a hurry, try to spend _more_ time making sure it is easier
to review for other people. What were updated, what were kept as they were
and for what reason? The purpose of adding the cover letter to the series
is to do just that.

Without spending that effort and saying "I am in a hurry" give a wrong
impression to others: "I cannot tell if this round is better cooked than
the previous round without spending nontrivial time reading on it, but
chances are it hasn't been much improved during the 24 hours.  It may be
better use of my time to skip it and work on other topics first.  After
finishing everything else I can come back---by that time Ram may have sent
out another round and reviewing this round right now may become wasted
time".

Also the series seems to be based on a rather old codebase where we didn't
allow reverting the root commit. I tried to apply a first few to
understand where these "positive" error status could be coming from, and
was stopped by patch conflicts. In [2/10] I think you are propagating
errors from run_command() coming back through try_merge_command(), and the
change is good for that particular codepath, but I haven't followed all
the other codepaths from do_cherry_pick() to convince myself that the exit
status from the merge strategy backend are _the only_ positive returns you
can possibly get. Have you?
