From: Junio C Hamano <gitster@pobox.com>
Subject: Let's make our cycles shorter
Date: Thu, 31 Mar 2011 15:35:45 -0700
Message-ID: <7vvcyyhq9q.fsf@alter.siamese.dyndns.org>
References: <7v62qzhqp4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 00:35:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5QT7-00083U-Us
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 00:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954Ab1CaWfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 18:35:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab1CaWfv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 18:35:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3EAB8552D;
	Thu, 31 Mar 2011 18:37:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x9DIj9VjkhJ/uX7qwsp8OBGFqMY=; b=U2/cMB
	HeUMua6lNC2NYAxTyC76Ge+p9RtB757ohQrEDWxciHbkrCLnpJFdC+61c8j7/rwM
	dk+D953SOT1Ah3I5rLYA7edIybjGke9A7JWQxOelf/V6bIhkrPPpJ4P+ZKkbEPnK
	+SfmJHSvevFSZyoP217KUgmg5DhYcpuLrboKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eWMYzh2B+M4IgKAmUq5mbd+h+UQjjExs
	nWmvudIVAStm8slLpRJVo6VyMLW2/PPcgw+tlyAw0xkvx4Vc+xyqj1M2DNYYS6+2
	9FAKlR0VRhDiYnQZ9qA4K5/0LXg2IeoTWJ6auJgbr20/XjI5ft8g/W0n9EcWtcM3
	J+oQ6RYppI4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D597552B;
	Thu, 31 Mar 2011 18:37:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6720A552A; Thu, 31 Mar 2011
 18:37:36 -0400 (EDT)
In-Reply-To: <7v62qzhqp4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 31 Mar 2011 15:26:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B0B9DE8-5BE7-11E0-AD1C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170538>

I've been aiming for 6-8 week cycles but the 1.7.5 cycle ended up being
way longer than that.  I just tagged a -rc0 and it will be mirroring out,
and today's "What's cooking" has annotations on topics in flight that I
expect to be in the -rc1.

This message is primarily meant to be a reminder to myself and also to
clarify my intentions.  I'd like one cycle of ours to look roughly like
this:

 - 1.7.5 is released.

 - Week 1: post release clean-up.  People are strongly encouraged to give
   the highest priority to the regression fixes for the most recent
   release.

 - Week 2: new features, restructuring, non-regression bugfixes start to
   flow in and graduate in preparation for 1.7.6.  Some may graduate from
   'next' before 1.7.5 to master, some may be newly queued through 'pu' to
   'next'.

 - Week N: 1.7.6-rc0 is tagged.  Examine topics in 'next' that are still
   not in 'master' and decide which way they should go, either included in
   1.7.6-rc1 or wait until the next cycle.

 - Week N+1: 1.7.6-rc1 is tagged with (a subset of) candidate topics we
   decided previous week.

   At this point, people are again strongly encouraged to give the highest
   priority to the regression fixes for the upcoming release.

 - Week N+2: 1.7.6-rc2 is tagged.

 - Week X: 1.7.6 is released.

Historically we have done at least two rc releases, and often three, so I
would expect X is at least N+3 but possibly N+4.  Since I want to have at
most an 8-week cycle, it would mean N=4 or 5, so we have three to four
weeks to concentrate the real development for the next release.

We are at "Week N" for this cycle as of today.

This of course does not mean that people are forbidden from working on or
discussing anything but regression fixes during the rc and post-release
period.  It may take longer than a month to stabilize for a large-ish
topic to be properly reviewed, discussed and guinea-pigged in 'next'.  

So during Weeks N thru X, there may appear new topics in flight and I may
end up queueing them in 'pu' or even move some of them to 'next', with an
understanding that they will not be part of the current cycle, but are
queued merely to make it easier for people interested in the new topic to
try out and discuss ideas for the next cycle.  Also handling these new
topics during the rc period will receive much lower priority and time from
me.

I hope all the above sound sensible.  Thanks.
