From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation: summarize how format-patch output is
 consumed
Date: Thu, 14 Apr 2011 15:05:47 -0700
Message-ID: <7vlizcfpz8.fsf@alter.siamese.dyndns.org>
References: <87d3kq6tz7.fsf@rho.meyering.net>
 <1302719749.21047.6.camel@drew-northup.unet.maine.edu>
 <87mxjtn8x7.fsf@rho.meyering.net> <20110413221736.GA773@elie>
 <7vzkntkc9d.fsf@alter.siamese.dyndns.org> <20110414211125.GA15277@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jim Meyering <jim@meyering.net>,
	Drew Northup <drew.northup@maine.edu>,
	git list <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 00:06:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAUg4-0005LK-Ps
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 00:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906Ab1DNWGM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2011 18:06:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41444 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901Ab1DNWGI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 18:06:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0FDC959CC;
	Thu, 14 Apr 2011 18:08:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LHmd9EkV5Uz0
	BKcNJfJU9m33bHM=; b=Z0XlimT8eAjrnUehRqXP4jaEUpZUHVs8IbokObc0WKX9
	fsIa51x7ekoYVILbyzo2ejbBostUN4LZOcQItD0Ldkl/+ocvk8gCit2Pg2q8skv9
	xCg7C+BKd4OQ2bPnNgxqopsr9eD6wih1dojkkLaGnOEIv9uF98hzbC2JeQBo0/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qirJb1
	wVI4jBefTYFWRKHo9rsibDVqwSL5Ia2WcGeQKtwE6Hfw8CSmat65f4h3Bs3B63v+
	XPcv64/KKcX9ENdXTkx698ttbiIwOApwQY9qptBWRS3lu6nFSFjQfphw2RLpf3Ih
	mTn4UQK/bIcn7MqmuWPnzIftSHwnSHDuIcUzo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8F0C059CA;
	Thu, 14 Apr 2011 18:07:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DA6EB59C5; Thu, 14 Apr 2011
 18:07:47 -0400 (EDT)
In-Reply-To: <20110414211125.GA15277@elie> (Jonathan Nieder's message of
 "Thu, 14 Apr 2011 16:11:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7824DFC-66E3-11E0-AD39-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171564>

Jonathan Nieder <jrnieder@gmail.com> writes:

> It would be nice to clarify use of the "From:",
> "Date:", and "Subject:" fields after the scissors in general, but thi=
s
> patch avoids the topic in hope of leading the reader to look to
> git-am(1) for a detailed discussion.

That is going backwards.  The new discussion section is to help people =
who
send e-mails using the output of this command, and the information you =
are
leaving out is more useful to these people to decide what to cut and wh=
at
to keep.  The users of "am" do not have make the choice to begin with.

> I didn't find a way to sneak in a comment about "file" magic; that ca=
n
> come another day.

Heh, you could have done something like:

> +DISCUSSION
> +----------
> +The patch produced by 'git format-patch' is in UNIX mailbox format,
> +like so:

    -like so:
    +with a fixed "magic" datestamp to help people recognize that such =
a file
    +is an output from format-patch and not a real mailbox, like so:

if you really wanted to ;-).

> +Typically it will be placed in a MUA's drafts folder, edited to add
> +timely commentary that should not go in the changelog after the thre=
e
> +dashes, and then sent as a message whose body starts with "arch/arm
> +config files were".  On the receiving end, readers can save
> +interesting patches in a UNIX mailbox and apply them with
> +linkgit:git-am[1].

Good.  I would suggest rephrasing the next paragraph, though.

> +'git am --scissors' accepts an alternative format with the patch
> +inline in the message:

-'git am --scissors' accepts an alternative format with the patch
-inline in the message:
+When sending a patch as part of an ongoing discussion, the patch gener=
ated
+by 'git format-patch' can be to take advantage of `git am --scissors`
+feature.  After writing your response to the discussion, write a line =
that
+consists solely of "-- >8 --" (scissors), append the patch, and remove
+unnecessary header fields, like this:

> +------------
> +...
> +> So we should do such-and-such.
> +
> +Makes sense to me.  How about this patch?
> +
> +-- >8 --
> +Subject: [IA64] Put ia64 config files on the Uwe Kleine-K=C3=B6nig d=
iet
> +
> +arch/arm config files were slimmed down using a python script
> +...
> +------------

+Note that when used this way, most often you are sending your own patc=
h,
+so you should omit From: and Date: lines from the patch file, together
+with the "From $SHA-1 $magic_timestamp" marker.  Also your patch title
+is likely to be different from the subject of the discussion you are
+sending this response to, so it is likely that you would want to keep =
the
+Subject: line, like the example above.
+

> +See linkgit:git-am[1] for details.
> +

> -linkgit:git-am[1], linkgit:git-send-email[1]
> +linkgit:git-am[1], linkgit:git-send-email[1], linkgit:git-imap-send[=
1],
> +Documentation/SubmittingPatches

Hmm, I suspect this is (1) bad because the end users without the source
may not have access to it, and (2) bad because it may indicate that the=
re
are hints and tricks in SubmittingPatches file, which narrowly targets
developers of this project, but they would also be helpful to the gener=
al
audience.  Perhaps some text needs moving from there to here?
