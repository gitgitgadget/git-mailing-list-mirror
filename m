From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [RFC 0/9] bisect: allow git bisect to be used with repos
 containing damaged trees.
Date: Tue, 26 Jul 2011 09:38:12 +1000
Message-ID: <CAH3AnrrOdduUG_rS97fR_PRZAWb6y3uPa_oKDZenEX2gG-AvAQ@mail.gmail.com>
References: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
	<7v1uxfwmq3.fsf@alter.siamese.dyndns.org>
	<CAH3AnrrVwodvtwWfaJCJqjuHThtv75jaWeDjvwRgdFbgXA3ziA@mail.gmail.com>
	<4E2DBA84.3090405@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jul 26 01:38:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlUj4-0002qf-Ml
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 01:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635Ab1GYXiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 19:38:14 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:33959 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001Ab1GYXiN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 19:38:13 -0400
Received: by vxh35 with SMTP id 35so3249762vxh.19
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 16:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1IukxCnGXsXw8c81Y9JTTReFCNHrbu7h23ToY67J124=;
        b=mOmGZvNbC8+Jia67cN4o/bzR3EotfPgriz4WW+u8hMdFHDVrnXaomrQbcww8ttaFxh
         +5aX/2kXCd1Mbp3N8WQxMvZVGXJuaXX+ptvnz3XzEoiKSrybpg6j4WGLj7xKVgVyVo3z
         TWGEXqHXGOkTxXuO57tDCfVzX6vFRDDtv+zEQ=
Received: by 10.52.21.194 with SMTP id x2mr5019691vde.39.1311637092227; Mon,
 25 Jul 2011 16:38:12 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Mon, 25 Jul 2011 16:38:12 -0700 (PDT)
In-Reply-To: <4E2DBA84.3090405@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177834>

On Tue, Jul 26, 2011 at 4:48 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 25.07.2011 11:28, schrieb Jon Seymour:
>> On Mon, Jul 25, 2011 at 4:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Jon Seymour <jon.seymour@gmail.com> writes:
>
> The fundamental preconditions of bisection are: that there is a single
> event in the sequence, and that the effects of the event propagate to
> the end of the sequence.

More correctly: the fundamental pre-condition of a single round of
bisection finding an
event of interest is as you say.

There is nothing that prevents multiple rounds of bisection being
used, if required.

So, in my examples, may produce a limit commit such that the graph
between the limit and the tip
contains two regions of good commits and two regions of bad commits.
So, you keep applying rounds
of bisection until the bad regions identified have no good commits.

>
> Junio explainded, that the second precondition is violated. Therefore,
> you cannot apply git-bisect to find brokenness in a repository *in general*.
>

I never claimed that a single round of biseciton would be enough, in
general. Only that it would be useful to be able
to apply a bisection algorithm to broken repositories.

It seems clear to me that bisection is a very useful tool for probling
the extent of corruption in a broken repo.
It is certainly not the only tool, may not work in all cases (broken
commits) and may not be all you need.

Anyway, I agree that Junio's suggestion (e.g. --no-checkout) is a
better and more generally applicable than my original
(--ignore-checkout-failure) suggestion.

jon.
