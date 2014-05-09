From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 19/25] contrib: remove 'diff-highlight'
Date: Fri, 09 May 2014 10:04:19 -0700
Message-ID: <xmqqa9aq28a4.fsf@gitster.dls.corp.google.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
	<1399597116-1851-20-git-send-email-felipe.contreras@gmail.com>
	<20140509015107.GA9787@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 09 19:04:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WioDq-0004j8-Ak
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 19:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757049AbaEIREa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 13:04:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60332 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755271AbaEIRE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 13:04:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B9A016F70;
	Fri,  9 May 2014 13:04:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rHBO0Rao1buORdKOD9hWfxtyAig=; b=yacR2D
	4Q0dcrl3L7c8q/ryGwlir1sXsvr4XXDkNG/cd25VXcdHOtBFUN/pqtqiEXjssbHY
	kyd0xhxf7kDvCDHhlakkh5C/bOpb4gZafad09gx08Y+cuvavJQ1CV0AFGcJPZ9Qk
	8a8c2tTTNjgSJVgR7eE57K3HPx0FWPsCNMSuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E6FqNt5mmdlvO/DiezbsFNaja6WJX9/A
	B9N+C8yqEVROK6yrSwWoAq/ErxfBiA2VOzZrQreHwOGrZVsIb9OvK7hK7SDFd5FY
	BpWOqqHY6bSkDkhOUdmRD/vb2IdRLgu0E+gReKfDUjVqnqyLtT75QLVmhDeGLAyP
	K9LVruNQRPU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9156216F6F;
	Fri,  9 May 2014 13:04:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1711316F6C;
	Fri,  9 May 2014 13:04:21 -0400 (EDT)
In-Reply-To: <20140509015107.GA9787@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 8 May 2014 21:51:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F6C1D62C-D79B-11E3-8025-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248587>

Jeff King <peff@peff.net> writes:

> On Thu, May 08, 2014 at 07:58:30PM -0500, Felipe Contreras wrote:
>
>> No activity since 2012, no tests, no chance of ever graduating.
>
> I don't think "no activity" is an interesting indicator. This tool _is_
> actively maintained, but it has not needed any fixes since 2012. I use
> it for every single "git log" and "git diff" invocation I do via the
> pager.* config.
>
> If we are getting rid of contrib/ I would be happy to continue
> maintaining it out-of-tree.

I do not know how much attention you have been paying, and I suspect
that you may be aware of all of the following, but I'll send this
out anyway, primarily so that others involved in other subthreads
can find out the story behind this.

There is no "prove yourself is worthy or get evicted" purge going on
in the contrib/ area.  I saw contrib/README referred to a few times
in the near-by threads, and I think these patches are done primarily
by deliberately misinterpreting one part of it in order to grab
attention by many people and also to sabotage the project.

The contrib/README file was written back when Git was still a small
and young project that was trying to build an ecosystem by having an
area to host stuff that are not core-material for some reason or
other (e.g.  only useful in some environments, only useful for some
workflows, the design or code not up to par to be in core) in my
tree to ease discovery and distribution.

There, I wrote:

    I expect that things that start their life in the contrib/ area
    to graduate out of contrib/ once they mature, either by becoming
    projects on their own, or moving to the toplevel directory.  On
    the other hand, I expect I'll be proposing removal of disused
    and inactive ones from time to time.

The purpose the last sentence in that paragraph is there was to
protect our codebase and our users from those who see an opportunity
to throw their ware in to our tree and go AWOL, by giving me, the
maintainer, a "stick" to prod them, saying "You as the primary
author are responsible for taking good care of the ware you created
by responding to issues (questions, suggestions, bugs, patches) in a
prompt manner, or your ware may even get evicted."

Among contrib/ materials we have today, I do not think there is
anything that requires me to exercise that "stick".  diff-highlight
certainly is not.  Perhaps subtree is the closest, as I see issues
raised from time to time but the original champion seems to be
inactive for some time, but even there, I recently saw somebody
hinting to volunteer to take it over after sending a patch or two to
it, and I do not intend to exercise the "stick" yet.

The sole mention of possible removal from contrib/ is this one:

    http://thread.gmane.org/gmane.comp.version-control.git/248063/focus=248457

in which Felipe said:

    I don't want to do anything for a "contrib" tool.

and I suggested that he has an option to make it a standalone
third-party project.  With the promotion to the core has already
been ruled out in the thread that begins at this one:

    http://thread.gmane.org/gmane.comp.version-control.git/247660/focus=248167

that is one of the only two alternatives I can offer, given that the
Git ecosystem has matured enough to let third-party tools flourish
on their own merit.  "We may want a better plug-in registry for Git"
I mentioned in

    http://thread.gmane.org/gmane.comp.version-control.git/248063/focus=248391

was to help us in that direction, but seeing that imerge mentioned
in many places I do not even regularly visit with the current
"discovery and distribution" infrastructure, perhaps yet another new
registry may not even be necessary.  I dunno.

In any case, that suggestion to remove not related to the "stick",
either, and certeinly not about "prove yourself" purge that does not
even exist.

So I think most of these removal patches can safely be ignored.

I agree with you and Jonathan that removal of contrib/vim may be a
good idea, but that is not due to "stick" nor "prove yourself",
either.  Jonathan's proposed alternative $gmane/248506 does a good
job of explaining and justifying the change.  It is a graduation "by
becoming projects on their own" that contrib/README mentions.
