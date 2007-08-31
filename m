From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Change handling of RelNotes
Date: Fri, 31 Aug 2007 13:25:46 -0700
Message-ID: <7vhcmfzc1h.fsf@gitster.siamese.dyndns.org>
References: <316a20a40708301835hc4236d4tdb289b6f705ab86@mail.gmail.com>
	<200708310645.l7V6jKJk009287@mi0.bluebottle.com>
	<7vveaw2na9.fsf@gitster.siamese.dyndns.org>
	<316a20a40708310539w1d20c391w8566a042c7a8679a@mail.gmail.com>
	<316a20a40708310552r3d445d03h2ab44508a0608f0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen Cuppett" <cuppett@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 22:26:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRD44-0004Nb-6a
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 22:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938AbXHaUZy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 16:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753710AbXHaUZy
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 16:25:54 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:42821 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbXHaUZx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 16:25:53 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A1097129D3F;
	Fri, 31 Aug 2007 16:26:09 -0400 (EDT)
In-Reply-To: <316a20a40708310552r3d445d03h2ab44508a0608f0c@mail.gmail.com>
	(Stephen Cuppett's message of "Fri, 31 Aug 2007 08:52:38 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57202>

"Stephen Cuppett" <cuppett@gmail.com> writes:

> Sorry, I didn't mean to imply a demand on anybody, or mandate anybody
> change their workflow...

I have to admit that your "I propose" phrase did raise my
eyebrow, but it's not a big deal.  I've grown thicker skins ;-)

As a general principle, I agree it is a good idea to keep
git.git easily accessible by people on different platforms and
environments.  After all, you would need to get git.git in order
to obtain newer repository features, so there is a chicken and
egg problem involved that is more severe than other projects.

That is exactly the reason why I do not use subprojects to bind
gitk and git-gui into git.git.  It needs to wait until everybody
has 1.5.2 or newer --- otherwise peole cannot clone or fetch
from git.git to get the feature that allows such a fetch to
begin with.

It would have been a different issue if the build procedure
depended on having a tracked symlink foo.h pointing at cache.h
and some source file included foo.h.  You cannot build such a
thing on a filesystem without symbolic links.  But the RelNotes
symlink is there for people to easily find the notes for the
latest to be released, and that symlink appears as a text file
that records the name of the Documentation file in a checkout
with "core.symlinks = false"; I do not think it is such a big
show stopper, even for people on a filesystem without symbolic
links.
