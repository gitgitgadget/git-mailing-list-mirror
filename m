From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add feature release instructions to gitworkflows man
 page
Date: Wed, 01 Apr 2009 09:15:08 -0700
Message-ID: <7vtz581hbn.fsf@gitster.siamese.dyndns.org>
References: <1238391319-4953-1-git-send-email-rocketraman@fastmail.fm>
 <1238391319-4953-2-git-send-email-rocketraman@fastmail.fm>
 <7vk567ijlf.fsf@gitster.siamese.dyndns.org> <49D10875.2060008@fastmail.fm>
 <7vljqmdgj0.fsf@gitster.siamese.dyndns.org> <49D1120B.8060601@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Raman Gupta <rocketraman@fastmail.fm>
X-From: git-owner@vger.kernel.org Wed Apr 01 18:17:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp37V-0005EQ-13
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 18:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764424AbZDAQPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 12:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764741AbZDAQPT
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 12:15:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51660 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764907AbZDAQPR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 12:15:17 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5C20BA6241;
	Wed,  1 Apr 2009 12:15:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D7596A623E; Wed,
  1 Apr 2009 12:15:10 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 485CE670-1ED8-11DE-94A9-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115399>

Raman Gupta <rocketraman@fastmail.fm> writes:

> It might be useful to add some explanation of why one would want to
> rewind and rebuild vs simply continue as is.
>
> I guess the advantage is that the history for next starts out nice and
> clean for the next release, without any cruft from repeated merging of
> topic branches.

Repeated merges are usually not a major issue.  Summarization tools such
as log and shortlog can be told not to list merges.

What matters more is a revert of a topic, that looked promising when it
started, but later found undesirable or premature.  In such a case, the
topic is reverted out of 'next' and but the fact remains in the history
that it was once merged, and it was reverted.  We would want to get rid of
these records at some point to give a chance for another incarnation of
the topic done right a clean slate to retry, and a feature release is a
good point in history to do so.


> The disadvantage is that one must publish the operation and all forks
> must deal with the rebase.

Yes.
