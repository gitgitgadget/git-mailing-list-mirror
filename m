From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] mergetool: run prompt only if guessed tool
Date: Thu, 24 Apr 2014 11:30:09 -0700
Message-ID: <xmqq1twmwpfy.fsf@gitster.dls.corp.google.com>
References: <1398039454-31193-1-git-send-email-felipe.contreras@gmail.com>
	<1398039454-31193-3-git-send-email-felipe.contreras@gmail.com>
	<20140422045951.GA60610@gmail.com>
	<20140422060120.GA10198@hashpling.org>
	<53560b09bbe96_2400128531085@nysa.notmuch>
	<20140422065549.GA11224@hashpling.org>
	<535611fac1b7b_268bd0b308f5@nysa.notmuch>
	<20140422073008.GA11584@hashpling.org>
	<535620a6e8274_3d2216372ec9d@nysa.notmuch>
	<20140423075601.GA18585@hashpling.org>
	<xmqqlhuw0ybb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu Apr 24 20:30:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdOPg-0005tA-8B
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 20:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758783AbaDXSaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 14:30:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51984 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758724AbaDXSaP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 14:30:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EFBF80300;
	Thu, 24 Apr 2014 14:30:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=++ye2Gt7NJHrLA7EIQgiAdGH3lk=; b=br/Shs
	Yd2xpE8W3lXxfnECMOFKwxG6W/tdoECedFEfDQwyv+jW2maUDdkL3AoMuhCkIc8e
	TDcfNajuoWR/d8CoU6HyABDMb0EZYIncKkRMWabmd/E4WGagy3go54R20UzqCCDQ
	wh2905qHMeUgtRQ2dbVHgFXHiTGdUbx/s3ip4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L1g9sFwRSyuqoqCl/j4RZZFltybUeb1j
	FfIZvTpe1T+vohzFzBJ62m7BC/cKkIHNbfBJrOjK+tc/6MNjVD5JLAgYF6Qyjd1F
	3Ozie6XQlmeisijB0XJtNX62Puu4HuEfxbY0HmG0GPVwO4X+f9sq/whHfggPPR4+
	4N+A2Ys5gqs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ACAB802FF;
	Thu, 24 Apr 2014 14:30:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75C83802F2;
	Thu, 24 Apr 2014 14:30:10 -0400 (EDT)
In-Reply-To: <xmqqlhuw0ybb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 23 Apr 2014 10:07:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 77DDEF80-CBDE-11E3-85A7-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246987>

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps like this?
>
> I take that your original motivation was to confirm to run a tool on
> this particular (as opposed to another) path, but the user can also
> take the prompt as to confirm to run this (as opposed to some other)
> tool.  The latter of which of course is irritating for those who
> told which exact tool to use.
>
> I think the large part of the reason why you and Felipe had to have
> a long back-and-forth was because it was unclear that the prompt
> served these two purposes from the documentation, so I attempted to
> clarify the first motivation by adding a brief half-sentence.

I'll queue the following as a separate documentation patch.  We may
want to polish the wording, so I'll keep it out of 'next' for now.

I think the main patch is good for 'next' with or without doc update
to be cooked during the remainder of this cycle, and I merged it
there already.

Thanks.

-- >8 --
Subject: [PATCH] mergetool: document the default for --[no-]prompt

The original motivation of using the prompt was to confirm to run a
tool on this particular (as opposed to another) path, but the user
can also take the prompt as to confirm to run this (as opposed to
some other) tool.  The latter of which of course is irritating for
those who told which exact tool to use, which is the reason why we
are flipping the default.

During the review discussion of the patch, many people (including
the maintainer) missed that a user can find the prompt useful way to
skip running the tool on particular paths.  Clarify it by adding a
brief half-sentence to the description.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-mergetool.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 07137f2..e846c2e 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -71,11 +71,13 @@ success of the resolution after the custom tool has exited.
 --no-prompt::
 	Don't prompt before each invocation of the merge resolution
 	program.
+	This is the default if the merge resolution program is
+	explicitly specified with the `--tool` option or with the
+	`merge.tool` configuration variable.
 
 --prompt::
-	Prompt before each invocation of the merge resolution program.
-	This is the default behaviour; the option is provided to
-	override any configuration settings.
+	Prompt before each invocation of the merge resolution program
+	to give the user a chance to skip the path.
 
 TEMPORARY FILES
 ---------------
-- 
2.0.0-rc0-224-g3c1c0b8
