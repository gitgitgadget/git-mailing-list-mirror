From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: Fix documentation of update subcommand
Date: Tue, 17 Feb 2015 14:45:31 -0800
Message-ID: <xmqqvbj0yx6c.fsf@gitster.dls.corp.google.com>
References: <1415009391-14979-1-git-send-email-sojkam1@fel.cvut.cz>
	<xmqqegtkrtt9.fsf@gitster.dls.corp.google.com>
	<xmqqsii0qa4l.fsf@gitster.dls.corp.google.com>
	<5457EC81.2060504@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michal Sojka <sojkam1@fel.cvut.cz>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 23:45:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNqtg-0004Ln-OA
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 23:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbbBQWpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 17:45:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51125 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751571AbbBQWpf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 17:45:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 504FD38F73;
	Tue, 17 Feb 2015 17:45:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=odLBbJWMrgR49X1Vxv1b/J+I/W8=; b=v28VIp
	TjwbpSeim6MQ4aholiQVadfXXGFr81nPmc5ATDx6GfInVxeX0KLcIWreFyrPlJPd
	7o52M/I/MnxyJFovpSKCsHRcLdGiPX8wl1XXBxU6OlpPv9sH0weRfkPqr9MDv5xH
	AGbW2wDgQKT+7sql8zsDZV+BmQuezSFEwjFws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rrRK3I/n9CSRz7RqTpGtSm0c7eriTIps
	npn+kjJBFdV0uQM7qEgaT8L7zIPWQuHhr0fa5jufm4hxyf5aMw5LYn5mb/CCYIaF
	4KI1FAewKPjPRuIEt4fASpd6u8WZ9PMyef6f6p4t/tlOirR/OSbJlxzXTI7q7Tnl
	Mjm0b2N+hD0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4786E38F72;
	Tue, 17 Feb 2015 17:45:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF49638F6F;
	Tue, 17 Feb 2015 17:45:32 -0500 (EST)
In-Reply-To: <5457EC81.2060504@web.de> (Jens Lehmann's message of "Mon, 03 Nov
	2014 21:58:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AE309606-B6F6-11E4-B30F-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263993>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Yup, but we should also mention '--merge' and '--rebase' here.

This has been sitting in the Stalled pile for quite a while and I am
getting tired of waiting.  How does this look?

-- >8 --
From: Michal Sojka <sojkam1@fel.cvut.cz>
Date: Mon, 3 Nov 2014 11:09:51 +0100
Subject: [PATCH] submodule: clarify documentation for update subcommand

e6a1c43a (document submdule.$name.update=none option for gitmodules,
2012-05-10) meant to say "Unlike the case where your .update
configuration is set to either 'rebase' or 'merge', when it is set
to 'none', the tip of the submodule would never move.  You can use
the --checkout option if you want the contents of the submodule to
be updated to some other commit."

But the resulting text made it sound as if using "--checkout" would
have no effect when .update configuration is set to 'rebase' or
'merge', which was misleading.  In fact, with the "--checkout"
option, the tip of the submodule moves to the exact commit that is
recorded in the superproject tree, regardless of .update
configuration.

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-submodule.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 8e6af65..9bfcdf5 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -158,7 +158,8 @@ update::
 	checkout the commit specified in the index of the containing repository.
 	This will make the submodules HEAD be detached unless `--rebase` or
 	`--merge` is specified or the key `submodule.$name.update` is set to
-	`rebase`, `merge` or `none`. `none` can be overridden by specifying
+	`rebase`, `merge` or `none`. The configuration can be overridden by
+	specifying `--rebase`, `--merge`, or
 	`--checkout`. Setting the key `submodule.$name.update` to `!command`
 	will cause `command` to be run. `command` can be any arbitrary shell
 	command that takes a single argument, namely the sha1 to update to.
-- 
2.3.0-301-g71e72fe
