From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] How to review patches: Documentation/ReviewingPatches?
Date: Fri, 13 Feb 2009 00:44:48 -0800
Message-ID: <7vocx6bu9r.fsf@gitster.siamese.dyndns.org>
References: <200902130045.59395.jnareb@gmail.com>
 <alpine.DEB.1.00.0902130055370.26370@racer> <49952728.2080404@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 09:46:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXtgt-0000lI-IT
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 09:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193AbZBMIpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 03:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbZBMIpA
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 03:45:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47857 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbZBMIo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 03:44:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EF0E82B079;
	Fri, 13 Feb 2009 03:44:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9C6ED1CD52; Fri,
 13 Feb 2009 03:44:50 -0500 (EST)
In-Reply-To: <49952728.2080404@trolltech.com> (Marius Storm-Olsen's message
 of "Fri, 13 Feb 2009 08:54:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 96BBD64E-F9AA-11DD-8C92-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109726>

Marius Storm-Olsen <marius@trolltech.com> writes:

> One thing I've wondered about though when sending patches, is how to
> send the fixups. Lets say I have a patch serie with 8 patches, do I
> send the whole serie each time, or do I just send an update to each
> individual patch? Do I attach it to the previous thread, or start a
> new one?
>
> I couldn't really draw any conclusion by watching the list, since all
> methods are used. However, I'd like to do what's easiest for the
> reviewers and maintainers. Probably a new series each time is easiest
> for Junio to parse and apply, without single updates deep in a
> thread. However, that might also be considered a tad 'spamming' of the
> list?

People work at different paces, especially because we are mostly
volunteers and hobbists who work on git not on full-time basis [*1*].

Although I obviously appreciate if people make it easy for _me_ to process
patches, and it may become necessary to optimize the rules to remove the
maintainer bottleneck if/when the amount of useful patches in the overall
list traffic starts to exceed my bandwidth [*2*], I do not think it is a
healthy thing to implement rules to make contributors' life more difficult
to make _my_ life easier.

So please do not take this message as me setting a rule.  Take it just as
a datapoint from me.  Other reviewers may have different preference, and I
am interested in hearing from them, too, especially their preference is
different from mine.

 * Marking the second and the third iterations as [PATCH v2], [PATCH v3]
   really helps, especially if you are a busy contributor whose throughput
   exceeds reviewers' throughput.

 * Resending the whole series would help, especially if their earlier
   round did not hit 'pu'.  If an earlier round did not land on 'pu', it
   is a sign that I either did not read them carefully to judge if they
   are 'pu' worthy, I did not even look at it beyond their commit log
   messages, I thought they were outright wrong, or I saw objections from
   others that were reasonable.

 * Once you have an earlier round in 'pu', it is Ok to resend only the
   updated ones, with a cover letter that says "the second and the third
   ones are the same as the previous round, so I am sending the updates
   for the first one and the fourth one, and this round additionally has
   the fifth one."

   But I suspect resending the whole series may help reviewers who missed
   the previous round in this case, too.

 * If you are resending the same patch as the previous round, I'd really
   appreciate a single line comment "This is unchanged from the last
   round" after the three-dash marker.  I often end up saving two messages
   to temporary files and run diff on them to see if they are the same
   without such indication.

 * If you are sending an updated patch, unless the whole series has been
   re-split and there is no one-to-one correspondence with the previous
   round, it is appreciated if you list the changes from the previous
   round below the three-dash marker.  Many people already do this, and it
   helps when reading the interdiff with the previous version.

[Footnotes]

*1* I am allowed to work on git for 20% of my day-job time budget by my
employer and NEC, so I am not a 100% full-time hobbist.

*2* At some point, I suspect we would have a problem similar to the one
pre-BK Linux kernel project had, the "maintainer does not scale" problem.

Subsytem maintainers like Paulus for gitk, Shawn for git-gui and bash
completion, Eric for git-svn, and Alexandre for emacs really have helped,
as I can choose to either ignore or simply kibitz on patches in these
areas, without having to worry about dropping patches in these areas.
