From: Junio C Hamano <gitster@pobox.com>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 15:54:03 -0700
Message-ID: <7v8v35cnp0.fsf@alter.siamese.dyndns.org>
References: <20130522115042.GA20649@inner.h.apk.li>
	<7v4ndukhx0.fsf@alter.siamese.dyndns.org>
	<20130523090657.GB23933@inner.h.apk.li>
	<CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CAMP44s3-3gpAAyp-WfDjHxJiotO68GUbb5tHw9Qo35yCTGFNqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 00:54:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfeOj-0002o8-9C
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 00:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759891Ab3EWWyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 18:54:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38584 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759830Ab3EWWyH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 18:54:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5C3D22B32;
	Thu, 23 May 2013 22:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UoFkvBn+GEhairIsyTc7nZcRKUA=; b=XRihcd
	5EKfnvEvVwmC0chQnOAY0d0xif6cVJ8wNzRR1VDbfq1FePSebMUDbVNUWzWw+XAH
	7OVSLWtn5PzKe66+WGonzs1cqaV7C54Cv07srm0E+9cxSsA0mIo1v/W3diOzIjzn
	LnK67WZ6Kj0MQmcQsDZ63+4d4BKkooWo9u32Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JTaCsV9UV1a3Fi1zdarm8QgwcwuGj22z
	3PG+TnNR53nBcCkYLEZP0jRaoMcHJ+83bUC+LhKEojdgflEJH/J56udukLeJ09AS
	NrQce9KM17AsLMSXd6D11T9h7nYGnIfpLC0ov/t+nyv7eSGtGV6Ewx7fcEMcgUu/
	rYV8mYTTNjM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB36B22B31;
	Thu, 23 May 2013 22:54:05 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CF2322B30;
	Thu, 23 May 2013 22:54:05 +0000 (UTC)
In-Reply-To: <CAMP44s3-3gpAAyp-WfDjHxJiotO68GUbb5tHw9Qo35yCTGFNqA@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 23 May 2013 17:46:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB4C0B72-C3FB-11E2-87E7-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225313>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, May 23, 2013 at 5:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> John Keeping <john@keeping.me.uk> writes:
>>
>>> This isn't about "swap parents", it's about helping people realise that
>>> just "git pull" isn't necessarily the best thing for them to do, and
>>> that they may want --rebase.
>>>
>>> So I was asking if it would be sensible (possibly in Git 2.0) to make
>>> git-pull pass --ff-only to git-merge by default.
>>
>> Unless your primary user base is those who use Git as a deployment
>> tool to always follow along the tip of some external repository
>> without doing anything on your own on the branch you run your "git
>> pull" on, defaulting it to --ff-only does not make much sense to me.
>
> A lot of people do stuff, but the rebase it.

If I am parsing the above properly, I think that is only saying that
"pull --rebase" makes sense for people who do real work, which I am
not disagreeing.

>> If the proposal were to make pull.rebase the default at a major
>> version bump and force all integrators and other people who are
>> happy with how "pull = fetch + merge" (not "fetch + rebase") works
>> to say "pull.rebase = false" in their configuration, I think I can
>> see why some people may think it makes sense, though.
>
> That makes perfect sense, because the people that are not familiar
> with Git more often than not end up making merges by mistake, and the
> ones that are familiar with it can easily configure it to do what they
> want

Yes, in theory.  The transition needs a major version bump, but it
is doable (with unknown level of resistance).

>> But neither is an easy sell, I would imagine.  It is not about
>> passing me, but about not hurting users like kernel folks we
>> accumulated over 7-8 years.
>
> I've worked in the Linux kernel, and in my experience the vast vast
> majority of kernel developers don't do merges; they send patches. It's
> only the lieutenants that might do that, and although there are a lot,
> they don't surpass the 200, and they most definitely know how to
> configure Git to do what they need. And even then, most of them don't
> do merges, but create a linear history for Linus to merge.
>
> So the only one who does really rely on merges is Linus, I think he
> would have no problems configuring Git.

That is not something I can agree or disagree without looping
somebody whose judgement I can trust from the kernel circle ;-).
