From: Junio C Hamano <gitster@pobox.com>
Subject: Summary of discussion on "git push" default change
Date: Wed, 21 Mar 2012 10:54:05 -0700
Message-ID: <7vr4wl262q.fsf@alter.siamese.dyndns.org>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
 <7vty1ndcoi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 18:54:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAPjk-0006xf-82
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 18:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863Ab2CURyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 13:54:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57167 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152Ab2CURyI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 13:54:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05331772D;
	Wed, 21 Mar 2012 13:54:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=DhcIxmKdMpe3k/Giso1PimK6n/E=; b=qQ7DMlrts/HYCOSsE2r8
	LP1zL51HQy+jR86UkFKmFEfyUxCyLa50xh81509Wt6ldz6JcN5Sh2fnTJDp++yeN
	XxOWDQtHTc+sNvf4SMIoc1N6bkuLpjvPLXCjxmfdUCXEDuJ6g0RESM82qygknB2r
	jc81PlVN5jf0d5nShoKqdOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=hy/Q0hs5ASTKto++DQ3GAhxfHzDt64WuOfs41c766lPBPqp20tokZIuO
	bpi9VDyfq8RPWVazsEPjPPIE6k74XaULzVk1H2L2N3cXCD5Uc+57B/4HBveM/+Je
	RQQv9uGv2vfRTzHk8m52cUQa2fSSk+rZsr0trbS60L4IRh4f7ds=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F196C772C;
	Wed, 21 Mar 2012 13:54:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 544B07728; Wed, 21 Mar 2012
 13:54:07 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DAE88E9C-737E-11E1-9D4D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193592>

By now it should be obvious that most people would prefer to see the
default behaviour for 'git push' to be something other than matching, even
if you did not read each and every "me too" message.

Actually, we've known it from the beginning. Otherwise, we wouldn't have
made noises about it in the first place ;-).  It was not the primary
objective of the discussion thread to decide if we are going to switch
away from 'matching' by voting (waking up those who are sleeping, so that
they do not have to be surprised with "I didn't know that was happening!"
was).

The new default we are switching to is not about how many people prefer it
for their own use. It is about what default is the least confusing to the
new users.  A default whose behaviour is easy to explain, easy to follow
and easy to understand is the goal. Once people understand what they want
and realize they fall into a minority, it is easy for them to configure
their push.default to something else, like 'matching'. And 'matching' was
a bad default for that purpose; it was the hardest to explain and
understand in the context of the workflows of many new people.

Many people said that they like 'upstream' solely based on their personal
preference, but a few people did justify their preference of 'upstream'
over 'current' based on their experience in teaching new people and
observing the sharp edges that hurt them. And they all sounded reasonable.

In order to show how the world after phase #2 of the transition [*1*]
would look like to developers, testers and early adopters, I am planning
merge Matthieu's patch mm/push-default-switch-warning topic [*2*] to
'next', together with Christopher's ct/advise-push-default topic [*3*];
hopefully these topics can be merged to 'master' soon after 1.7.10 final.

Thanks.

To people who helped spreading the initial RFD message: please do feel
free to distribute this message to the same channels, too.


[References]

*1* http://article.gmane.org/gmane.comp.version-control.git/193308

*2* https://github.com/gitster/git/commit/5293b54

*3* https://github.com/gitster/git/commit/f25950f
