From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH] .mailmap late summer cleaning
Date: Wed, 29 Aug 2012 10:16:35 -0700
Message-ID: <7vpq69wrd8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 19:16:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6lsk-0007Io-IW
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 19:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156Ab2H2RQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 13:16:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754126Ab2H2RQi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 13:16:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16BBC86AA;
	Wed, 29 Aug 2012 13:16:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=L
	eeyRB2xCaH6cvoKmyBGOU+tsq8=; b=tCyqoB1zyluF2cs0YQlFLExgcBP3QuBnP
	Z12MbSpVTkHiUkzpOaHU1gaAkmtamoDUM0IOFJGQUDXXkXSu7BB7z5ancAcGqafI
	bVB8oA2Tkui59bkq3ErxBFrGw6acEBCzbHupfQR478NLTHoZ8PRZFrKwezXLObLh
	BSXkoT3G/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=T4q
	PM1B8T2WPvSod4k5hjJkpMfb7VEZ6AGT/VDyYvtBoRfGvhHLbX1YA+Viu+/WIfDl
	GYKLFUuatHCt3FxY4Ktn8dr952TtM8zgyGSc0kLCpyfm6GqDPa2pD5DT0ZqUqH/r
	BU7BqNNmagHrtFzuvRse/Mgf2LPsep1d88lp/ubo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 050D486A9;
	Wed, 29 Aug 2012 13:16:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57E6286A8; Wed, 29 Aug 2012
 13:16:37 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A5123FA-F1FD-11E1-A044-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204486>

We have the "mailmap" mechanism to unify entries for a person with
multiple e-mail addresses into one "Name <address>", but it seems
that the .mailmap file hasn't been keeping up to the changes in the
real world.

Does any of you contributors who has commits in my tree want to
update how you appear in "shortlog -e -s -n" output?  It may show
your ancient e-mail address, for example.  If so, here is what I
want you to do.

First, run "git shortlog -e -s origin/pu" in a clone of git.git
source tree and find your name.  If you do not find your name listed
multiple times, or if you do not want them to be unified to your
latest address, stop here.  There is nothing you need to do.

Otherwise, please tell me which "Name <addr>" you do not want to
see.  For example, Martin vonZ recently changed his e-mail address,
and he appears twice in the "shortlog -e -s" output, like so:

  70  Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
   3  Martin von Zweigbergk <martinvonz@gmail.com>

Suppose that he wants to use the latter from now on (in other words,
he does not want to see the longer one).  I want to be told his wish
with the following (all on a single line, without leading indent):

    Martin von Zweigbergk <martinvonz@gmail.com> <martin.von.zweigbergk@gmail.com>

The format is "Name <preferred-address> <address-you-do-not-want-to-see>".

Even though he doesn't, if he also had appeared in "shortlog -e -s"
output like this:

   1  Martin von Zweigbergk <y@google.com>

that could also be mapped to his new address, with another line:

    Martin von Zweigbergk <martinvonz@gmail.com> <y@google.com>

I'll collect responses to this message, and update the file sometime
late next week.

Thanks.
