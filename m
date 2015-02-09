From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Remove tcl-format flag from a message that shouldn't have it
Date: Mon, 09 Feb 2015 13:55:23 -0800
Message-ID: <xmqqlhk6agxg.fsf@gitster.dls.corp.google.com>
References: <1421914779-30865-1-git-send-email-alexhenrie24@gmail.com>
	<CAMMLpeTvtzPuiQJVxAx-Ja4JsoUxih5azMaN7_RcLvajny6A6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git mailing list <git@vger.kernel.org>,
	patthoyts@users.sourceforge.net,
	Alex Henrie <alexhenrie24@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Feb 09 22:55:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKwIp-0004OF-23
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 22:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760866AbbBIVzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 16:55:31 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755796AbbBIVza (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 16:55:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8933537422;
	Mon,  9 Feb 2015 16:55:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+9FDxC3H6gVsj3rkys+3Av3+z/0=; b=K+itp2
	0pNJVKONPdjdNmIjf/oJfxCADCNdOZx3ImKGjU8uJ9vHw0dPhyUTk1nX1o6Vy1U1
	GoBZE+goU7DliMlyWadZuJQ99HcaMY+wSgUT1m2vifRLDDz7VjYEovdcxpUc/POq
	/Wpo5+D5umeIWcBptRJrQsxoGCyt0Z1WA9WfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iBPP95XU6TchT2K++BNqvoiYA2Lcylox
	gvivQz3xhZk3QbDvKEdL0l3e832I/knSzXkSDE3dJLcBe9XE5l998OHCr7W6K17t
	qPOrMRYUPdYuqBjtuQj5/KtjJxRD2OamW2a20aerZKUzbOQaul2HsdFu+GVBCGMV
	lfU3o6RlwmA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8119337421;
	Mon,  9 Feb 2015 16:55:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 024143741D;
	Mon,  9 Feb 2015 16:55:24 -0500 (EST)
In-Reply-To: <CAMMLpeTvtzPuiQJVxAx-Ja4JsoUxih5azMaN7_RcLvajny6A6g@mail.gmail.com>
	(Alex Henrie's message of "Mon, 9 Feb 2015 14:36:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5A12F8A8-B0A6-11E4-A778-38A39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263610>

Alex Henrie <alexhenrie24@gmail.com> writes:

> This is just a friendly reminder that this patch has been sitting in
> the mailing list archives for a couple of weeks, and it has not yet
> been accepted or commented on.

I think that is because the message was not sent to the right
people, and also because the patch was made against a wrong project
;-).

I'll forward it to the gitk maintainer after digging it out of the
archive and tweaking it.  Thanks.

Paul, comments?

-- >8 --
From: Alex Henrie <alexhenrie24@gmail.com>
Date: Thu, 22 Jan 2015 01:19:39 -0700
Subject: gitk: Remove tcl-format flag from a message that shouldn't have it

xgettext sees "% o" and interprets it as a placeholder for an octal
number preceded by a space. However, in this case it's not actually a
placeholder, and most translations will replace the "% o" sequence with
something else. Removing the tcl-format flag from this string prevents
tools like Poedit from freaking out when "% o" doesn't appear in the
translated string.

The corrected flag will appear in each translation's po file the next time
the translation is updated with `make update-po`.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 gitk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gitk b/gitk
index 78358a7..dfd458d 100755
--- a/gitk
+++ b/gitk
@@ -11237,6 +11237,7 @@ proc prefspage_general {notebook} {
     ${NS}::label $page.maxwidthl -text [mc "Maximum graph width (lines)"]
     spinbox $page.maxwidth -from 0 -to 100 -width 4 -textvariable maxwidth
     grid $page.spacer $page.maxwidthl $page.maxwidth -sticky w
+                                         #xgettext:no-tcl-format
     ${NS}::label $page.maxpctl -text [mc "Maximum graph width (% of pane)"]
     spinbox $page.maxpct -from 1 -to 100 -width 4 -textvariable maxgraphpct
     grid x $page.maxpctl $page.maxpct -sticky w
-- 
2.2.2
