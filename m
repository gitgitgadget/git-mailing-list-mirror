From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.6.5.4
Date: Thu, 03 Dec 2009 12:48:00 -0800
Message-ID: <7vfx7r4we7.fsf@alter.siamese.dyndns.org>
References: <7v638o76ra.fsf@alter.siamese.dyndns.org>
 <m2hbs85koj.fsf@igel.home> <4B17ABE3.6060003@drmicha.warpmail.net>
 <m2d42w5fqq.fsf@igel.home> <4B17D078.6080000@drmicha.warpmail.net>
 <20091203150323.GI23717@inocybe.localdomain>
 <7viqco54xh.fsf@alter.siamese.dyndns.org>
 <20091203202738.GP23717@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 21:48:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGIbL-00075R-Es
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 21:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565AbZLCUsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 15:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756559AbZLCUsL
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 15:48:11 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36942 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756545AbZLCUsI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 15:48:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B37085ABE;
	Thu,  3 Dec 2009 15:48:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9aXExHfmgr0x816/+YCTR1IgpGc=; b=BD0tnH
	K4fR1cdAKO+8oxAiAk8g38mpHYGG1svZE0rMalsIsJ3CVJL0XM6Gm2zvgEdBZ93S
	AdUFbtuJrP+XZ2bd17O3C1uXw5G8nvYQNnMJP9CsEMSrGKpjl04zSqDvu6fQuBxc
	wkLwz5/npX+rgGPaTB3ryFHNhf0WaO8XEnHyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bo09PD+LPW/njebeTmBTPyft57VqKcRT
	gokGWd4aG9HFwdCTCHtne37OqO6ST8GgjzaF38sD2zTn+iNmLIOL2PDPhCSRTNar
	JcBPJyZmL5fj5JVlLVgXVYXbgWC2aw/08vfWSLBjMv0qIC81IM3p+towUhZs29o3
	NSmHdwpPvhI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3283585ABA;
	Thu,  3 Dec 2009 15:48:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D333C85AB4; Thu,  3 Dec
 2009 15:48:01 -0500 (EST)
In-Reply-To: <20091203202738.GP23717@inocybe.localdomain> (Todd Zullinger's
 message of "Thu\, 3 Dec 2009 15\:27\:38 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2ABB17EA-E04D-11DE-8972-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134477>

Todd Zullinger <tmz@pobox.com> writes:

>> Either we require 0.0.20 or we revert the tip one on this topic.  I
>> think the latter is a safe thing to do.
>
> That sounds good to me.  I'd like to get the EPEL builds for
> RHEL/CentOS updated sometime soon, as they're currently still on
> 1.5.5.6 and that lacks too many of the great improvements in newer git
> releases.  Not having to patch for building the docs is one less thing
> to worry about.

This is what I plan to use.

-- >8 ---
From: Junio C Hamano <gitster@pobox.com>
Date: Thu, 3 Dec 2009 11:12:32 -0800
Subject: [PATCH] Documentation: xmlto 0.0.18 does not know --stringparam

Newer DocBook stylesheets want man.base.url.for.relative.links
parameter set when formatting manpages with external references
to turn them into full URLs, and leave a helpful "you should
set this parameter" message in the output.  Earlier we added
the MAN_BASE_URL make variable to specify the value for it.

When MAN_BASE_URL is not given, it ought to be safe to set the
parameter to empty; it would result in an empty leading path for
older stylesheets that ignore the parameter, and newer ones
would produce the same "relative URL" without the message.

Unfortunately, older xmlto (at least version 0.0.18 released in
early 2004 that comes with RHEL/CentOS 5) does not understand
the --stringparam command line option, so we cannot add the
parameter definition unconditionally to the command line.  Work
it around by passing the parameter only when set.

If you do not have a suitable URL prefix, you can pass a quoted empty
string to it, like so:

    $ make MAN_BASE_URL='""'

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/Makefile |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d4c05ca..1c9dfce 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -108,7 +108,14 @@ endif
 # use MAN_BASE_URL=http://www.kernel.org/pub/software/scm/git/docs/
 # but distros may want to set it to /usr/share/doc/git-core/docs/ or
 # something like that.
+#
+# As older stylesheets simply ignore this parameter, it ought to be
+# safe to set it to empty string when the base URL is not specified,
+# but unfortunately we cannot do so unconditionally because at least
+# xmlto 0.0.18 is reported to lack --stringparam option.
+ifdef MAN_BASE_URL
 XMLTO_EXTRA += --stringparam man.base.url.for.relative.links=$(MAN_BASE_URL)
+endif
 
 # If your target system uses GNU groff, it may try to render
 # apostrophes as a "pretty" apostrophe using unicode.  This breaks
-- 
1.6.6.rc1.5.ge21a85
