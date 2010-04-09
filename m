From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase command and docs questions
Date: Fri, 09 Apr 2010 14:11:37 -0700
Message-ID: <7vhbnk1gc6.fsf@alter.siamese.dyndns.org>
References: <h2j76c5b8581004091149y9f5f93a8o5f11b3ffc657623@mail.gmail.com>
 <r2mfabb9a1e1004091337w8ec2b721y3a5082d5e0f5925c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 23:11:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0LUX-0006X0-Un
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 23:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756535Ab0DIVLt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Apr 2010 17:11:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60724 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab0DIVLs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 17:11:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D3DE4A912B;
	Fri,  9 Apr 2010 17:11:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=N0RaJvrNb7ZR
	yTXzJrfQtyoIvCE=; b=n2XJCsKzqkQkvBO+LE/C1TXf5lPsPWMvkweinuDOmiGq
	meV2Nf9X6T/MSC8Uo5kF6wL3N3XKa+GA5bGCB+Krg8BbmlR/DGlaelCi1x2FOzfh
	WASm9YN2vlOqAUrEVaD9upPNkI8Xo2DXBMeS2cNvNFsnuv3CYg4nJTAiuaeBX+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wd9IjG
	WYbYrGNK/Gwi3QWgpLq7HVR3t8AZTqTuH+tOaWoHH3CCk5pIrTfRXhMXRaJEyY+r
	KPSRjwFMcYBlsLWZv9ZIgGnKNJT5EGQUWz+Q845PXSCfvGvSgbje4dmijtKscGF5
	cts7qEohWvUklxGrkWoM+nhNFYEKc/62k+ANo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CB74A912A;
	Fri,  9 Apr 2010 17:11:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5AEF9A9129; Fri,  9 Apr
 2010 17:11:39 -0400 (EDT)
In-Reply-To: <r2mfabb9a1e1004091337w8ec2b721y3a5082d5e0f5925c@mail.gmail.com>
 (Sverre Rabbelier's message of "Fri\, 9 Apr 2010 22\:37\:15 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7F8FE25E-441C-11DF-BAA5-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144472>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Fri, Apr 9, 2010 at 20:49, Eugene Sajine <euguess@gmail.com> wrote=
:
>> But, in =E2=80=9Cgit rebase =E2=80=93onto master next topic=E2=80=9D=
 the meaning of the =E2=80=9Cnext
>> topic=E2=80=9D parameters is different: as I understand, it actually=
 specifies
>> a range of commits from next to topic,  because =E2=80=93onto change=
s the way
>> the whole command is working, but it is not clarified in help. Is th=
at
>> correct understanding?
>
> I've never been able to remember how rebase --onto works, perhaps if
> we actually let users specify a range it would be more intuitive?
>
> $ git rebase next..topic master

Hmm, re*base* means "change the base to _this one_"; the above is more
like "replay these on master", which is often a useful operation but is
different.

Suppose other people have worked on the project and made their pushes
since you started working on your changes:

      o---o master
     /
 ---o---o---o---o origin

"git rebase origin" asks "I know my current work is based on a tad stal=
e
state, and I'd prefer a linear history, so change the base to origin".

If the thing of whose base you want to change is not your "current work=
",
then you name that explicitly, i.e. "git rebase origin master" (i.e. th=
e
second branch name defaults to HEAD as usual).

Onto is an optional feature that is primarily for correcting your earli=
er
mistakes.  Notice in the above picture, other people doing parallel wor=
k
and pushing their changes out is part of the normal life of distributed
development; there is no mistake on your part involved.

But suppose you started building bugfixes in a topic forked from origin=
,
but after that you realize they should be based on origin/maint:

                   X---Y fixes
                  /
         o---o---o---o---o origin
        /
    ---o---o---o origin/maint

You could have made fixes branch that houses X and Y on origin/maint (a=
nd
later merge that to master to be pushed to origin), but you did not hav=
e
perfect foresight.  You do not obviously want to change the base of who=
le
'fixes' branch to 'origin/maint', as that will pull in changes in origi=
n
that are not related to your fixes.

You would want to rebase 'fixes' branch (whose fork point can be specif=
ied
with 'origin') but not on top of 'origin', but on 'origin/maint'.  Henc=
e
instead of running "git rebase origin" to produce

                           X'--Y' fixes
                          /
         o---o---o---o---o origin
        /
    ---o---o---o origin/maint

You would say "git rebase --onto origin/maint origin" to transplant X' =
and
Y' as if you started working from 'origin/maint':


         o---o---o---o---o origin
        /
    ---o---o---o origin/maint
                \
                 X'--Y' fixes

If you _had_ your "replay" command, the workflow for this would be:

    $ git checkout -b maint-fixes origin/maint
    $ git replay origin..fixes


Before somebody else makes useless noises, "cherry-pick" could be a goo=
d
command in the existing UI set to do that kind of thing.
