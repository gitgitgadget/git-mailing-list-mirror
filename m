From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v8 2/5] blame: introduce $ as "end of file" in -L syntax
Date: Wed, 13 Mar 2013 08:52:59 +0100
Message-ID: <87wqtbivms.fsf@pctrast.inf.ethz.ch>
References: <cover.1362069310.git.trast@student.ethz.ch>
	<7973d90cfcd86a3c15776b8718ad6bd84ee7b4ac.1362069310.git.trast@student.ethz.ch>
	<7vk3psicgf.fsf@alter.siamese.dyndns.org>
	<7va9q85jt9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Will Palmer <wmpalmer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 08:53:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFgVC-0003PJ-UE
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 08:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540Ab3CMHxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 03:53:07 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:54847 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932490Ab3CMHxG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 03:53:06 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 13 Mar
 2013 08:52:55 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 13 Mar 2013 08:53:00 +0100
In-Reply-To: <7va9q85jt9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 12 Mar 2013 15:34:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218037>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thomas Rast <trast@student.ethz.ch> writes:
>>
>>> To save the user a lookup of the last line number, introduce $ as a
>>> shorthand for the last line.  This is mostly useful to spell "until
>>> the end of the file" as '-L<begin>,$'.
>>
>> Doesn't "-L <begin>" or "-L <begin>," do that already?  If it were
>> to introduce "-L $-4," or "-L$-4,+2", I would understand why the
>> addition may be useful, but otherwise I do not think it adds much
>> value.
>
> It is a quiet-period so there is no need to rush, but did anything
> happened further on this series?

No, I've been busy :-(

The only open point is in the other email:

> >>  Documentation/blame-options.txt     |  19 +------
> >>  Documentation/line-range-format.txt |  18 +++++++
> >>  Makefile                            |   2 +
> >>  builtin/blame.c                     |  99 +++-------------------------------
> >>  line-log.c                          | 105 ++++++++++++++++++++++++++++++++++++
> >>  line-log.h                          |  23 ++++++++
> >
> > Was this churn necessary?  
> >
> > It is strange to move existing functions that will be tweaked to be
> > shared by two different codepaths (blame and line-log) to the new
> > user.
> [...]
> 
> Even though I am moving from builtin/blame.c to line-log.c?  I would
> otherwise have to call from a rather lib-ish file into a "front

You haven't sent any reply to this.  Does that mean you agree?  Would
you prefer the shared file to be named something like line-range.c?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
