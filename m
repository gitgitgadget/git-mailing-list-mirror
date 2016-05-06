From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v16 0/7] config commit verbose
Date: Fri, 06 May 2016 08:33:15 -0700
Message-ID: <xmqqshxv5hhg.fsf@gitster.mtv.corp.google.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
	<xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
	<CAPig+cQO3W4WthHstrVFWziU2RAuNyEzeQwBEyDXG8dghRjECQ@mail.gmail.com>
	<20160506162058.Horde.toAFyoD2uVNcv2x2Ssx_9zt@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri May 06 17:33:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayhkx-000078-A0
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 17:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758274AbcEFPd0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2016 11:33:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64506 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757596AbcEFPdY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 11:33:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C6EB18194;
	Fri,  6 May 2016 11:33:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kg5LN+WzFeM8
	J92bbItsWoq1DGk=; b=tULZ9RWbafChyAYF/SXgKc/LVJDxZHUNo0aRjSvNAZwz
	oncIHP4yzxfhS43ZtmWq83fk8h62ySN0Wo2ZvZ9mI3T+jcmtOI1CcsW2fR6W5xBj
	K+c/bouLLHd70IUNANQzfveUpZArR235LpvWibjS6a9wLjP8EgZxpLzbK03Q55A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CwLx0I
	z6Si8z7DxOqrqTZ/0WMmi98XSlKkvedTAO3DprylT71Tx/Wtv+B+1ao7txJg3l7b
	azReKCYEDGXheK+872Sm/iCtYDrokDjfLDBu8vTLdMBu/2AnxtW0j6qsXUhOZZd0
	lz/xjiY8OP5ZpwFkhV+9qL9R0dlwKrSlA8S/I=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9459918193;
	Fri,  6 May 2016 11:33:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06A5E18192;
	Fri,  6 May 2016 11:33:16 -0400 (EDT)
In-Reply-To: <20160506162058.Horde.toAFyoD2uVNcv2x2Ssx_9zt@webmail.informatik.kit.edu>
	("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Fri, 06 May 2016 16:20:58
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DAA66ABA-139F-11E6-8CB3-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293790>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> A while ago in a related thread Peff remarked about 'git commit's
> '--quiet' and '--verbose' options:
>
>    I think that is a UX mistake, and we would not do
>    it that way if designing from scratch. But we're stuck with it for
>    historical reasons (I'd probably name "--verbose" as "--show-diff"=
 or
>    something if writing it today).
>
> http://thread.gmane.org/gmane.comp.version-control.git/289027/focus=3D=
289069
>
> Then I replied:
>
>    However, that doesn't mean that we have to spread this badly chose=
n
>    name from options to config variables, does it?  I think that if w=
e
>    are going to define a new config variable today, then it should be
>    named properly, and it's better not to call it 'commit.verbose', b=
ut
>    'commit.showDiff' or something.
>
> http://thread.gmane.org/gmane.comp.version-control.git/289027/focus=3D=
289303
>
> Any thoughts on this?  Before a poorly named config variable enters t=
o
> the codebase and we'll have to maintain it "forever"...

My thoughts are --show-diff would probably be a UI mistake of a
different sort, if you are anticipating that the different kinds of
information to be shown in verbose modes would proliferate and that
you would want to give the user flexibility to pick and choose to
use some while not using some other among them.  You would end up
having --show-xyzzy --show-frotz --show-nitfol ... options.

I am not convinced that we would want such a degree of flexibility
in the first place, but even if we did, we'd be better off giving
that as "--verbose=3Ddiff,xyzzy,frotz...", I would think.

And commit.verbose that begins its life as a simple boolean, which
can be extended to become bool-or-string if needed, is better than
having commit.showDiff, commit.showXyzzy, commit.showFrotz, etc.
