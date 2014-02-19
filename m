From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Git release notes man page
Date: Wed, 19 Feb 2014 10:22:09 -0800
Message-ID: <xmqqha7v9d4e.fsf@gitster.dls.corp.google.com>
References: <1392460179-776-1-git-send-email-philipoakley@iee.org>
	<xmqqha7wcbkz.fsf@gitster.dls.corp.google.com>
	<1EC26D492ABB45FF8C399F84B1E30817@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "GitList" <git@vger.kernel.org>,
	"Stefan Nwe" <stefan.naewe@atlas-elektronik.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Feb 19 19:22:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGBmy-0005uT-Ov
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 19:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbaBSSWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Feb 2014 13:22:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38795 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754505AbaBSSWW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 13:22:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABA636BE51;
	Wed, 19 Feb 2014 13:22:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZWafjI9e5BjJ59U4gRMnEZOzzdU=; b=g4RTNb
	u26AqeImIk5PJbJjU0pkZ9cL45btTa9TJLkeHJYzR4HhSoRpC5eQLaQd8mfy83U5
	6B9NL4C3+Du05aM2/J8qjVyCvVIjw0G5AtYecqN0Mn/e3/LP3WtOdI3M1v7aO7tt
	O2QtSZhPWzjF3VBQkMrqCMzU+psVQs70q9AB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BG0hEAkXcEjFQD5JYEvDrIpIbXVjs9qS
	QuUKJOyXctkoOCiFjUwB8hzKDkx8xf5wke2bf3oJbz2EGKtTtyywfT1k72MrLNU3
	ZUip8ereyN5Xkj5iijV8WTbygMXzLbT6X4RCdWH6M9wcYazAGTGmF+wGhC/1w6HH
	WWEZFgot6Mk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4372E6BE4D;
	Wed, 19 Feb 2014 13:22:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6B0D6BE44;
	Wed, 19 Feb 2014 13:22:13 -0500 (EST)
In-Reply-To: <1EC26D492ABB45FF8C399F84B1E30817@PhilipOakley> (Philip Oakley's
	message of "Tue, 18 Feb 2014 22:54:15 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C13E2344-9992-11E3-9CFF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242395>

"Philip Oakley" <philipoakley@iee.org> writes:

>> RelNotes are incremental and only useful for those who know what the
>> immediately previous release contained, but for most people who get
>> their Git from distros, I have this impression that the versions of
>> Git they get skip versions, and seeing the notable changes since the
>> previous source release will not give them wrong information---they
>> may have this warm fuzzy feeling that they know what is going on,
>> but they are missing information on all the accumulated changes that
>> were added in earlier versions their distro skipped---these changes
>> are still in the version they are running.
>
> That's a reasonable argument.

I am not making an "argument" in order to reject the notion of
making release-notes available, though. I am only raising concerns,
pointing out why showing a single release notes as if that were the
only one that matter is misleading.

I am not opposed to the idea of making release notes available to
those who do not install from the source, by the way. Being able to
grep the release notes through may help people who are writing
scripts using Git to learn when a feature they want to use appeared
to make sure that they do not depend on something their users may
not have yet. But for that kind of users, it would be more helpful
to point them at the file location they can find the plain text
version of release notes, instead of giving them a bunch of web
links they need to read through page by page.

> I did look at trying to get the
> "stalenotes" to work as an alternative, that is extract the stalenotes
> section from the git.txt, and create a release notes man page from
> that.

I am not sure if stale-notes section meshes well with this; the
primary purpose of it was to point at the whole documentation set,
not just release-notes, for versions previously released, so those
who came to a website that hosts them can pick the version, possibly
a stale one, that they are using and read the manual pages for that
version, without seeing newer features that are not available to
them.  I do not think it is very useful in the context of your "You
received this single version of software, and you can access its
documentation off-line" feature---you cannot reasonably expect that
such a software release to contain all the past documentation sets,
but even if you could do so, that is not how normal people use the
installed documentation, i.e. to learn about older releases that
they no longer have.
