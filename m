From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git-users] Highlevel (but simple to implement) commands provided by default for git
Date: Sun, 02 Jun 2013 12:20:05 -0700
Message-ID: <7vobbonwuy.fsf@alter.siamese.dyndns.org>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
	<CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
	<CALkWK0k8GkFYNkoGH4YCgmWtSR5rgFSG0dU9Aw2CO_arvuzKxQ@mail.gmail.com>
	<CAMP44s1VFxarV4Gp5KsxhFKJbmd033-DW8koe9P4XUZQcX4mrA@mail.gmail.com>
	<7v38t5sg7k.fsf@alter.siamese.dyndns.org>
	<CALkWK0=kA8mPt-8h8dYS9HrOcF1tx=0Pj-=jFHfa_UxdC=ehPQ@mail.gmail.com>
	<7vtxllqyhz.fsf@alter.siamese.dyndns.org>
	<CALkWK0mZqaUHObNqXKeY7=BCOq-0iHtMvtc_eNANHN8Hw8G-fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	=?utf-8?Q?Br=C3=A1ulio?= Bhavamitra <brauliobo@gmail.com>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 02 21:20:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjDp7-0008Iq-9z
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 21:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755764Ab3FBTUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 15:20:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49172 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755721Ab3FBTUH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 15:20:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49F1C24FF7;
	Sun,  2 Jun 2013 19:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x0qvGS0jdIMzlS3ozOsdwmv6Byw=; b=oV/fjg
	ln8aOvFsH7WjQPm2wMP5ajz49EXcb1mJCPvkuFfc4qLFuUJlyNSVuW5PqmxzIKcd
	036AmWa6y5wQfITKhKIoMFOVCNSDq0e/ETArXOxOpysyfutS2WdEAd6Kv0ZQwDSG
	Morj/hP+0B8KJjx4WQZVamopl7UKAEvOuuTm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sarAeM/wOscpHld4MzM64+IX6y0fXuHJ
	FldyFO7MFI2jka8fxcuKErXYp6KwTjaQJ9U0F/2FP0WknOJNu8fMSWx2DzE0a9+P
	HRsWXIUdHmRiSj+LOHxtZ22TH+5/Kuz5A+VtUcEHrpbXEn0+XBmoLSIVDym0/iNV
	gBlGpTe04IA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DEDB24FF4;
	Sun,  2 Jun 2013 19:20:07 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B774424FF0;
	Sun,  2 Jun 2013 19:20:06 +0000 (UTC)
In-Reply-To: <CALkWK0mZqaUHObNqXKeY7=BCOq-0iHtMvtc_eNANHN8Hw8G-fQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 30 May 2013 02:56:20 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F15A152-CBB9-11E2-A184-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226174>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> So the problem is that I can't do:
>
>   git blame -- :/Makefile
>
> So blame has to be converted to use pathspec semantics, and should
> error out when the pathspec doesn't match the concrete path of a file.

Correct, that is what I wrote in two messages ago in the footnote
you were responding to.
