From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3 v2] diff --stat: use the real terminal width
Date: Fri, 10 Feb 2012 10:24:36 -0800
Message-ID: <7vmx8qr1gb.fsf@alter.siamese.dyndns.org>
References: <CACsJy8AQdz=uwDm+FOgcUB5JOi5U7w-W4w7yUPL6wd2FO-bArg@mail.gmail.com>
 <1328831921-27272-1-git-send-email-zbyszek@in.waw.pl>
 <1328831921-27272-4-git-send-email-zbyszek@in.waw.pl>
 <CACsJy8APGeTNv_E3qD=xFCiLC25M_nm3aJbq6YU73J=X0Wxh2w@mail.gmail.com>
 <4F34FE9A.7020600@in.waw.pl>
 <1328891972-23695-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Fri Feb 10 19:24:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvv9J-0003Cw-8j
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 19:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759649Ab2BJSYk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 13:24:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40659 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754446Ab2BJSYj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 13:24:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD6566965;
	Fri, 10 Feb 2012 13:24:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pxJw1GJuF1Aa
	yljf53oCtu3juWg=; b=Hv32sI89DNVMGDSK77Qiht5wmc0EzceuUX0JxOqjKejN
	OqAeosjPjF/YH2APVJaPtX0yQGSXWmPUkEM/vvdQSYEKwyq2yjV4Gjj6X1Sp9oBl
	EeDtinCXuFlVDJmFqPm914tJLYy5CbsfpCCsm2bgankqhjyh2+NdZIQSukco8h4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BF2/14
	yyY0HeANzpYbFubriTnDUPMJMbP5uW/XIvsXW5fyIFVuWfNcTE2gtbIRsiVTljlB
	zEEMHAignudlXmGx62Wxaz0BWv7fqItt5ft0kbe8VANwpKsGGi9oUYFSfhPR0Ud8
	+WvKWoZ7oqo77Q9rGhWBUFGI748EK+R/2k1Dc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B55A76963;
	Fri, 10 Feb 2012 13:24:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 397846962; Fri, 10 Feb 2012
 13:24:38 -0500 (EST)
In-Reply-To: <1328891972-23695-1-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Fri, 10 Feb 2012
 17:39:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7DAE2608-5414-11E1-9E70-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190433>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> - style fixes

I think I still saw at least one malformatted multi-line comments in th=
is
round, though (I stopped looking after I saw one, so there may be other=
s).

> - some tests for git-format-patch added
> - patches 3 and 4 squashed together, since they touch the same lines
> - graph width is limited to 40 columns, even if there's more space

Hmm.

This is what we have in the documentation.

        --stat[=3D<width>[,<name-width>[,<count>]]]::
                Generate a diffstat.  You can override the default
                output width for 80-column terminal by `--stat=3D<width=
>`.
                The width of the filename part can be controlled by
                giving another width to it separated by a comma.

Na=C3=AFvely, one would expect that a "use the real terminal width" ser=
ies
would be only to learn the width of the terminal and tweak its hardcode=
d
default "80" to that width, and change nothing else, leaving the defaul=
t
for name-width to "50", which still can be overridable if needed.

But the reason somebody wants to have a wider width is more often not
because they want to see longer bars, but because they want to see long
names without truncation, so in retrospect, the order the "--stat=3D" o=
ption
takes its values is inconvenient.  Users would more often want to tinke=
r
with name-width than width because the latter can be auto-detected.

Which is a bit unfortunate.

In any case, the above needs to be updated to describe what the updated
logic does.  Do you have documentation updates in the series?

Judging from what you wrote in the above, the updated logic is, instead=
 of
the "na=C3=AFve" version:

 - auto-detect, if possible, to set the default "width" to COLUMNS inst=
ead
   of hardcoded 80; and

 - instead of using hardcoded 50, use width-40 as the default as the
   default "name-width".

But if that is what is going on, shouldn't your "40" be "30" to retain
backward compatibility for people who work on 80-column terminals?

Or is there something more complex going on that you are not describing
here?
